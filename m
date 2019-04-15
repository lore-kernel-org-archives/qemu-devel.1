Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_HK_NAME_DR,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D9DC10F12
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 12:04:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3821C206BA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 12:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3821C206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49285 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG0LJ-0004oX-Eg
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 08:04:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hG0Jv-0004AJ-5b
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:02:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hG0Jt-0003JX-79
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:02:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hG0Js-0003J4-Uj
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:02:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B4683024552;
	Mon, 15 Apr 2019 12:02:40 +0000 (UTC)
Received: from work-vm (ovpn-117-222.ams2.redhat.com [10.36.117.222])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6233260F9B;
	Mon, 15 Apr 2019 12:02:39 +0000 (UTC)
Date: Mon, 15 Apr 2019 13:02:36 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190415120236.GJ2852@work-vm>
References: <20190405184648.17029-1-dgilbert@redhat.com>
	<20190405212501.cdg4u3m7ihldcop4@function>
	<20190408084653.GB2687@work-vm>
	<20190411184502.xvesnriqcocyvuan@function>
	<20190412154942.GF2906@work-vm>
	<20190412211633.6pyn6cfm5dnwjzji@function>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190412211633.6pyn6cfm5dnwjzji@function>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Mon, 15 Apr 2019 12:02:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] slirp: Gcc 9 -O3 fix
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
Cc: jan.kiszka@siemens.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415120236.DbmK6xtV9FKYzGpsQ95lIjPOcYw6ZFFDwNlkdsaNgow@z>

* Samuel Thibault (samuel.thibault@gnu.org) wrote:
> Dr. David Alan Gilbert, le ven. 12 avril 2019 16:49:42 +0100, a ecrit:
> > * Samuel Thibault (samuel.thibault@gnu.org) wrote:
> > > Hello,
> > > 
> > > Dr. David Alan Gilbert, le lun. 08 avril 2019 09:46:53 +0100, a ecrit:
> > > > 'soread' has the comment:
> > > > 
> > > >         /*
> > > >          * No need to check if there's enough room to read.
> > > >          * soread wouldn't have been called if there weren't
> > > >          */
> > > >         sopreprbuf(so, iov, &n);
> > > > 
> > > > the compiler doesn't realise that, and is moaning about the case
> > > > where the if (len <=0) return happens and the following 
> > > > code tries to use iov.
> > > 
> > > I see. Perhaps we should make this an assert then? In case this isn't
> > > true, i.e. soread() is called even if no room is available, returning 0
> > > would probably just let the caller just try again, and we should rather
> > > just plainly crash than hang?
> > 
> > Adding the assert in soread sorts that case out:
> >   assert(sopreprbuf(so, iov, &n) != 0);
> > 
> > however, I also need to fix soreadbuf;  is it legal to call that with
> > a 0 size?
> 
> It does not really make sense to, so an assert >0 should be fine.

OK, replacement patch with just a couple of asserts sent.

Dave

> Samuel
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

