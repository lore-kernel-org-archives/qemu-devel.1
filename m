Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F12C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:10:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46EAF2077C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rtfk+5PX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46EAF2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugvw-0004Ve-4p
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 13:10:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56713)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iuew1-0000F0-UI
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:02:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iuew0-0004IV-D3
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:02:21 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34026
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iuew0-0004I2-9P
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:02:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579795339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Og0ui2Hp6TvCDFLGi8YO2Ic3NyIuzFMzSg/nbUR+QyI=;
 b=Rtfk+5PXfUbwAuOBfJgW3bdJea2WBTXQXzyDQ5vKRQkvrHz+y6qDAluVqQa1T8Px+GVIGY
 O9t+Xq0j7DQgCFvxkIWjsZHAkTNigeUiaLL/nE4deQsFv6xJXYZKMP8+RXl+AqMmtv6HPP
 z1lGf/5L3H/yimEVdQos4ZQs69sjiNY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-F0GOoBZ2MiuvmUsCEXDlEA-1; Thu, 23 Jan 2020 11:02:10 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A6358010D6;
 Thu, 23 Jan 2020 16:02:09 +0000 (UTC)
Received: from work-vm (ovpn-116-110.ams2.redhat.com [10.36.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 38C1A80896;
 Thu, 23 Jan 2020 16:02:05 +0000 (UTC)
Date: Thu, 23 Jan 2020 16:02:02 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 000/111] virtiofs queue
Message-ID: <20200123160202.GB2732@work-vm>
References: <20200123115841.138849-1-dgilbert@redhat.com>
 <CAFEAcA_7T2Yu8fXv7XycSSN=8xoi8aciR5NMh76o8LQxNU6rDw@mail.gmail.com>
 <20200123153052.GA2732@work-vm>
 <CAFEAcA8ufZTy=T_iixbHMN6a7GZxxRkod6y_1Vu_vbsoioDV=g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8ufZTy=T_iixbHMN6a7GZxxRkod6y_1Vu_vbsoioDV=g@mail.gmail.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: F0GOoBZ2MiuvmUsCEXDlEA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On Thu, 23 Jan 2020 at 15:31, Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> >
> > * Peter Maydell (peter.maydell@linaro.org) wrote:
> > > On Thu, 23 Jan 2020 at 12:54, Dr. David Alan Gilbert (git)
> > > <dgilbert@redhat.com> wrote:
> > > >  docs/tools/conf.py                        |   16 +
> > > >  docs/tools/index.rst                      |   14 +
> > > >  docs/tools/virtiofsd-security.rst         |  118 ++
> > >
> > > Do we really want a new top-level manual? This isn't
> > > in the plan: https://wiki.qemu.org/Features/Documentation
> > >
> > > What defines what goes in docs/tools rather than
> > > docs/interop (like qemu-nbd and qemu-img do) ?
> >
> > In my v1 patchset this lived in tools/virtiofsd and I hadn't
> > wired up the top level index, however discussion with Daniel
> > we came up with docs/tools/virtiofsd. See:
> >
> > https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg00793.html
> >
> > My suggestion is that more should move into tools and docs/tools
> > since they're not really 'interop' - but I don't have a strong feeling
> > as long as we can quickly come to an agreement.
>=20
> I guess that's probably not unreasonable. It's going to clash
> with the various docs patchsets already on list, though.

Which ones exactly?
Do you want me to rebuild this set on top of those, or drop the docs for
now until after they're in (I'm happy for you to drop the docs patches
and merge the rest of this series, which would seem the quickest way).

> And it's a bit odd that the only doc file in docs/tools
> doesn't seem to be documenting a tool (it's a more general
> 'security guide';

I think it is actually specific to this virtiofsd implementation.

> I think the case would be better if the
> doc you were adding was the virtiofsd manpage, which doesn't
> seem to exist yet).

Yes it does, see 'virtiofsd: add man page' (patch 0094),
tools/virtiofsd/virtiofsd.texi

> Our other "stuff between guest and host"
> docs (including other vhost-user topics and the qemu-ga guest
> agent docs) are all in interop/.

Note that doc I've added here doesn't define protocol or anything like
that between qemu and the guest; it's purely a doc talking about what
someone using that daemon sees.

> PS: you forgot to add the new docs/tools entry to
> docs/index.html.in.

Ah, happy to fix that.

Dave

> thanks
> -- PMM
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


