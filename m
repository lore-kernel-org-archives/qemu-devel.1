Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B81C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 08:41:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C21F206C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 08:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkCoHn43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C21F206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc3Fb-0005De-8t
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 04:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jc3Eq-0004mm-RT
 for qemu-devel@nongnu.org; Fri, 22 May 2020 04:41:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28481
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jc3Ep-0004Z4-Ca
 for qemu-devel@nongnu.org; Fri, 22 May 2020 04:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590136864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0rRGMXuDPQm7VHVHqFU7LRW3XMGF1X3bOLnPHMsHcGY=;
 b=IkCoHn43GNyedQRxlmwrn+iqXFhMUUVsf/sdCGbMpY+daeaCbFElqJsEgGaBGMLlMYCuiZ
 TVZgjIOwhINiaXm+eOZwQJi1CRsId/Ae9SFC6KhcpkHPTVdKGPqWUN/vaNQKnTmCA/+fyX
 LBZM9+cS44eJD9Rc3JjAVCsQhxjLjFU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-6TB0t8DXNj6EXczmOF1NaA-1; Fri, 22 May 2020 04:41:01 -0400
X-MC-Unique: 6TB0t8DXNj6EXczmOF1NaA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56FB8835B45;
 Fri, 22 May 2020 08:40:59 +0000 (UTC)
Received: from nas.mammed.net (unknown [10.40.193.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9675B5D9CC;
 Fri, 22 May 2020 08:40:56 +0000 (UTC)
Date: Fri, 22 May 2020 10:40:53 +0200
From: Igor Mammedow <imammedo@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 5/6] i386: Hyper-V VMBus ACPI DSDT entry
Message-ID: <20200522104053.4e7834a8@nas.mammed.net>
In-Reply-To: <fb1661c0-7282-58b4-03b4-a77793cc8e97@redhat.com>
References: <20200424123444.3481728-1-arilou@gmail.com>
 <20200424123444.3481728-6-arilou@gmail.com>
 <20200505150637.7131e79b@redhat.com>
 <20200511182121.GA1307176@rvkaganb.lan>
 <20200513173414.62e3cb4e@redhat.com>
 <fb1661c0-7282-58b4-03b4-a77793cc8e97@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 04:25:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: mail@maciej.szmigiero.name, eyakovlev@virtuozzo.com,
 Jon Doron <arilou@gmail.com>, qemu-devel@nongnu.org,
 Roman Kagan <rvkagan@yandex-team.ru>, liran.alon@oracle.com,
 Roman Kagan <rkagan@virtuozzo.com>, vkuznets@redhat.com,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 21 May 2020 18:02:07 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 13/05/20 17:34, Igor Mammedov wrote:
> > I'd rather avoid using random IRQ numbers (considering we are
> > dealing with black-box here). So if it's really necessary to have
> > IRQ described here, I'd suggest to implement them in device model
> > so they would be reserved and QEMU would error out in a sane way if
> > IRQ conflict is detected.  
> 
> We don't generally detect ISA IRQ conflicts though, do we?

that I don't know that's why I'm not suggesting how to do it.
The point is hard-coding in AML random IRQs is not right thing to do,
(especially with the lack of 'any' spec), as minimum AML should pull
it from device model and that probably should be configurable and set
by board.

Other thing is:
I haven't looked at VMBus device model in detail, but DSDT part aren't
matching device though (device model is not ISA device hence AML part
shouldn't be on in ISA scope), where to put it is open question.
There were other issues with AML code, I've commented on, so I was
waiting on respin with comments addressed.
I don't think that this patch is good enough for merging.

 
> 
> Paolo
> 


