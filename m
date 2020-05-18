Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76713C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 06:29:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D67E2070A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 06:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dahX/a61"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D67E2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaZHJ-0001Al-GU
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 02:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jaZGd-0000SG-8g
 for qemu-devel@nongnu.org; Mon, 18 May 2020 02:28:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37640
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jaZGc-0007An-JH
 for qemu-devel@nongnu.org; Mon, 18 May 2020 02:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589783329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dpQ447hZ/yyq5m4WZtHf6MWW4Jbv9ayz/Hgwn4K25rs=;
 b=dahX/a61pcBdOp3nS0YVnwtiuaJowWxbSfpMZo7j7wwUOfnR9YWTm0AhB7FjnsoO3tOP6+
 xeq4QqrAID5abyiEBiVBFCYax+2KvEW6ho/jylfD09mIe8AC+ItLSYZyE+ogpjAwO15ZYl
 7obImnRXjo+vpu5pbVsoUovfrDMNylM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-7tHNxdOBMbGi9njM26p50A-1; Mon, 18 May 2020 02:28:48 -0400
X-MC-Unique: 7tHNxdOBMbGi9njM26p50A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3099B107ACCA;
 Mon, 18 May 2020 06:28:47 +0000 (UTC)
Received: from gondolin (ovpn-113-28.ams2.redhat.com [10.36.113.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F6EE385;
 Mon, 18 May 2020 06:28:46 +0000 (UTC)
Date: Mon, 18 May 2020 08:28:43 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 1/3] docs/s390x: document the virtual css
Message-ID: <20200518082843.4f5deaf4.cohuck@redhat.com>
In-Reply-To: <df4ae06b-5401-c0f3-415e-89dc9cdefc67@redhat.com>
References: <20200515151518.83950-1-cohuck@redhat.com>
 <20200515151518.83950-2-cohuck@redhat.com>
 <df4ae06b-5401-c0f3-415e-89dc9cdefc67@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:51:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On Sun, 17 May 2020 19:39:24 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 15/05/2020 17.15, Cornelia Huck wrote:
> > Add some hints about "devno" rules.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  docs/system/s390x/css.rst    | 86 ++++++++++++++++++++++++++++++++++++
> >  docs/system/target-s390x.rst |  1 +
> >  2 files changed, 87 insertions(+)
> >  create mode 100644 docs/system/s390x/css.rst  
> [...]
> > +if the guest OS does not enable MCSS-E (which is true of all  
> supported guest
> 
> Maybe s/true of/true for/ ? Not sure, your English is normally better
> than mine ;-)

"for" is better :)

> 
> Anyway,
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks!


