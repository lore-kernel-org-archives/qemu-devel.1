Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9B1C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:34:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB9F12084F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DzLvnQu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9F12084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icTrm-0005Tm-2k
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 07:34:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48711)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1icTOo-000162-Lp
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 07:04:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1icTOe-00030T-Qr
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 07:04:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42429
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1icTOe-0002OU-5b
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 07:04:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575461075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Carz3m175ZOdBHmKj5YBxD780t/+PeS3b4VZXwUpT3E=;
 b=DzLvnQu8Easv/QhNuXBaTZOPQd9IHArtPXwieNEp4FLclN8YTYu9QVAM+Fr8nAhro0DSKv
 P9G5teSuWAgFb6n+t6xhAa224JhU56dkXwO2YPlRWTbIYYEE9zksORCuino3Nwsgm6+j+7
 YFDGw77NsrX86fLq8PdHPEvG3K6mdWU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-HStP-gXDPH2oLCwRqb17dQ-1; Wed, 04 Dec 2019 07:04:32 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 468D41005509;
 Wed,  4 Dec 2019 12:04:31 +0000 (UTC)
Received: from work-vm (ovpn-117-217.ams2.redhat.com [10.36.117.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA2B060850;
 Wed,  4 Dec 2019 12:04:20 +0000 (UTC)
Date: Wed, 4 Dec 2019 12:04:18 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: virtiofsd: Where should it live?
Message-ID: <20191204120418.GH3325@work-vm>
References: <20191125185021.GB3767@work-vm>
 <20191126102600.GG556568@redhat.com>
 <20191126121416.GE2928@work-vm>
 <CAFEAcA9Ln2uwg4f4s8oS6VeQk83W3BErmH9cHeyDJy7v-4gNxw@mail.gmail.com>
 <87k17ekhs9.fsf@dusky.pond.sub.org>
 <fef0eaaf-149a-f8a8-02c5-821d2d42becd@redhat.com>
 <20191203105341.GB3078@work-vm>
 <CAFEAcA8bjGAs7JSTNYYYwCH1yF06i0v0r9wjKXqZGZg_Sqy0VA@mail.gmail.com>
 <20191203111949.GB267814@redhat.com>
 <87o8wofsda.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87o8wofsda.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: HStP-gXDPH2oLCwRqb17dQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, mszeredi@redhat.com, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Markus Armbruster (armbru@redhat.com) wrote:
> Daniel P. Berrang=E9 <berrange@redhat.com> writes:
>=20
> > On Tue, Dec 03, 2019 at 11:06:44AM +0000, Peter Maydell wrote:
> >> On Tue, 3 Dec 2019 at 10:53, Dr. David Alan Gilbert <dgilbert@redhat.c=
om> wrote:
> >> >
> >> > We seem to be coming to the conclusion something that:
> >> >
> >> >   a) It should live in the qemu tree
> >> >   b) It shouldn't live under contrib
> >> >   c) We'll create a new top level, i.e. 'daemons'
> >> >   d) virtiofsd will be daemons/virtiofsd
> >> >
> >> > Now, somethings I'm less clear on:
> >> >   e) What else would move into daemons?  It was suggested
> >> >     that if we've got virtiofsd in there, then we should move
> >> >     libvhost-user - which I understand, but then it's not a
> >> >     'daemons'.
> >> >     Are there any otehr daemons that should move?
> >>=20
> >> I like the idea of a new top level directory, but I think
> >> 'daemons' is a bit too specific -- for instance it seems to
> >> me that qemu-img would be sensible to move out of the root,
> >> and that's not a daemon.
> >
> > Do we really need an extra directory level ?
>=20
> +1
>=20
> > IIUC, the main point against having $GIT_ROOT/virtiofsd is that
> > the root of our repo is quite cluttered already.
> >
> > Rather than trying to create a multi-level hierarchy which adds
> > a debate around naming, why not address the clutter by moving
> > *ALL* the .c/.h files out of the root so that we have a flatter
> > tree:
> >
> >   $GITROOT
> >     +- qemu-system
> >     |   +- vl.c
> >     |   +- ...most other files...
>=20
> Sounds good to me.
>=20
> >     +- qemu-img
> >     |   +- qemu-img.c
>=20
> Perhaps this one can all go into existing block/, similar to how
> pr-manager-helper.c is in scsi/, and virtfs-proxy-helper.c is in fsdev/.
> Up to the block maintainers, of course.
>=20
> >     +- qemu-nbd
> >     |   +- qemu-nbd.c
>=20
> block/ or nbd/?
>=20
> >     +- qemu-io
> >     |   +- qemu-io.c
> >     |   +- qemu-io-cmds.c
>=20
> block/?
>=20
> >     +- qemu-bridge-helper
>=20
> net/?
>=20
> >     |   ...
> >     +- qemu-edid
>=20
> Has its own MAINTAINERS section, together with hw/display/edit* and
> include/hw/display/edid.h.  I'm not sure moving it hw/display/ is a good
> idea.  Gerd?
>=20
> >     +- qemu-keymap
>=20
> Not covered by MAINTAINERS.  scripts/get_maintainer.pl --git-blame
> points to Gerd.
>=20
> >     +- qga  (already exists)
>=20
> Yes.
>=20
> > Then we can add virtiofsd and other programs at the root with no big
> > issue.
>=20
> We don't *have* to put each program into its own directory.  Simple ones
> could also share one.  We just need a directory name.

So what do you think of Paolo's suggestion of putting virtiofsd in=20
fsdev (mkdir fsdev/9p && mv fsdev/* fsdev/9p && mkdir fsdev/virtiofsd )

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


