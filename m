Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,T_HK_NAME_DR,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B30C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 09:01:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD37420883
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 09:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD37420883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37803 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDmcr-0001zY-Qu
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 05:01:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hDmbD-0000qr-7N
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:59:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hDmbC-0006PM-5P
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:59:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>)
	id 1hDmbB-0006NW-Ta; Tue, 09 Apr 2019 04:59:22 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CFA403168907;
	Tue,  9 Apr 2019 08:59:19 +0000 (UTC)
Received: from work-vm (ovpn-117-233.ams2.redhat.com [10.36.117.233])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C22C360BF1;
	Tue,  9 Apr 2019 08:59:17 +0000 (UTC)
Date: Tue, 9 Apr 2019 09:59:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Ilya Maximets <i.maximets@samsung.com>
Message-ID: <20190409085913.GB2964@work-vm>
References: <CGME20190408123341eucas1p2add7886160b2b66912413defd4544d1f@eucas1p2.samsung.com>
	<c138abfe-61fd-6e04-8900-2ba2a24073de@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <c138abfe-61fd-6e04-8900-2ba2a24073de@samsung.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Tue, 09 Apr 2019 08:59:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 00/97] Patch Round-up for stable 3.0.1,
 freeze on 2019-04-08
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-stable@nongnu.org, mdroth@linux.vnet.ibm.com,
	qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409085914.DXb9dmh9cLtBoidlgBMzFgq_tXHTCpoTGsZ21Xozcpw@z>

* Ilya Maximets (i.maximets@samsung.com) wrote:
> > Hi everyone,                                                                    
> >                           
> > 
> > The following new patches are queued for QEMU stable v3.0.1:
> > 
> >   https://github.com/mdroth/qemu/commits/stable-3.0-staging
> > 
> > The release is planned for 2019-04-11:
> > 
> >   https://wiki.qemu.org/Planning/3.0
> > 
> > Please respond here or CC address@hidden on any patches you
> > think should be included in the release.
> > 
> > Note that this update falls outside the normal stable release support
> > window (~1 development cycle), but is being release now since it was
> > delayed from its intended release date.
> > 
> > Thanks!
> > 
> 
> [...]
> 
> > 
> > Ilya Maximets (1):
> >       migration: Stop postcopy fault thread before notifying
> 
> Hi.
> 
> Sorry for late response, but what about following two patches:
> 
>   c4f753859ae6 ("vhost-user: Fix userfaultfd leak")
>   5ce43896e167 ("vhost-user: Don't ask for reply on postcopy mem table set")
> 
> ?

OK with me.

Dave

> Best regards, Ilya Maximets.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

