Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4489C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:41:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C551206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULeDc2i3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C551206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZWpw-0005v1-Kj
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 05:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jZWpM-0005M0-H3
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:40:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36987
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jZWpL-0002nY-6R
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589535621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Flm1Z5RsTh6ql1i8cJJj6I9tbFoxve2ly7hP7fuj9p8=;
 b=ULeDc2i3r1GoPhtWQ3r2NEzqgfG74KjWwKr5HVf+QqMAkc6V2Xjkhuee82X6om+nLXMeDi
 sWMhn3CpjGRgjE7tbTactPSWr9DKP4Bf5q8dCshk8RAdw5yTUeZeh1d8+xOtFHq4SinwrG
 qCTWTrq8g2m9DH+/gOFiQWAOZ8xzRdI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-zuv1wyIvN9imy1FxqduCpw-1; Fri, 15 May 2020 05:40:20 -0400
X-MC-Unique: zuv1wyIvN9imy1FxqduCpw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AE748015D1;
 Fri, 15 May 2020 09:40:19 +0000 (UTC)
Received: from gondolin (ovpn-112-229.ams2.redhat.com [10.36.112.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05DCA60CD3;
 Fri, 15 May 2020 09:40:17 +0000 (UTC)
Date: Fri, 15 May 2020 11:40:15 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 1/3] docs/s390x: document the virtual css
Message-ID: <20200515114015.6190668b.cohuck@redhat.com>
In-Reply-To: <8c2abd64-39e8-8150-c4ee-546ee55ddb42@redhat.com>
References: <20200505135025.14614-1-cohuck@redhat.com>
 <20200505135025.14614-2-cohuck@redhat.com>
 <7876d0f3-7bb9-38b9-6675-94ba6bd47a1a@redhat.com>
 <20200515105133.12ffb2be.cohuck@redhat.com>
 <8c2abd64-39e8-8150-c4ee-546ee55ddb42@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:39:12
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
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 May 2020 10:57:26 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 15/05/2020 10.51, Cornelia Huck wrote:
> > On Fri, 15 May 2020 09:04:13 +0200
> > Thomas Huth <thuth@redhat.com> wrote:
> >   
> >> On 05/05/2020 15.50, Cornelia Huck wrote:  
> [...]
> >>> +
> >>> +  This would not show up in a standard Linux guest.    
> >>
> >> Ok ... and what happens if you use devno=0.0.1234 ? Will that then show
> >> up under fe.0.1234 in the guest??  
> > 
> > That won't show up in the guest, either -- do you think I should add an
> > example for that as well?  
> 
> It could help to clarify the question that came to my mind here. And
> what would happen if the guest supported MCSS-E ? Would it then show up
> as fe.0.1234 indeed?

No, it would show up as 0.0.1234, and the devices in the default css
(0xfe) would show up as fe.x.yyyy.

But I have not seen a Linux kernel with support for MCSS-E in the wild
:) (nor any other OS, for that matter)


