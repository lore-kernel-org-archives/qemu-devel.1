Received: from eggs.gnu.org ([2001:4830:134:3::10]:35787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1gSHkW-0002xA-CL
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 03:32:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1gSHkR-0004kX-FX
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 03:32:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fziglio@redhat.com>) id 1gSHkQ-0004f0-RG
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 03:32:35 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2E7CFD6F15
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 08:32:29 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2110D5D777
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 08:32:29 +0000 (UTC)
Date: Thu, 29 Nov 2018 03:32:28 -0500 (EST)
From: Frediano Ziglio <fziglio@redhat.com>
Message-ID: <2135052047.46423828.1543480348695.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAMxuvaywjHiBPLuaqhV1H_0XnariFHm=JLeo3fptSKLaZbFo9g@mail.gmail.com>
References: <20181128155932.16171-1-marcandre.lureau@redhat.com>
	<20181129080926.qyji6olhjqzkkcuz@sirius.home.kraxel.org>
	<CAMxuvaywjHiBPLuaqhV1H_0XnariFHm=JLeo3fptSKLaZbFo9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v3] configure: bump spice-server
 required version to 0.12.5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

> On Thu, Nov 29, 2018 at 12:09 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > On Wed, Nov 28, 2018 at 07:59:32PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > > Looking at chardev/spice.c code, I realize compilation was broken for
> > > a while with spice-server < 0.12.3. Let's bump required version
> > > to 0.12.5, released May 19 2014, instead of adding more #ifdef.
> >
> > Oh, you did the 0.12.5 patch already.  Scratch my other reply then.
> >
> > > -  if $pkg_config --atleast-version=3D0.12.0 spice-server && \
> > > +  if $pkg_config --atleast-version=3D0.12.5 spice-server && \
> > >       $pkg_config --atleast-version=3D0.12.3 spice-protocol && \
> >
> > I think we should adjust spice-protocol too to whatever 0.12.5 requires
> > to build.
> >
>=20
> Why not leave that responsibility to pkg-config, and only require in
> qemu what is required there?
>=20
>=20

That is remove explicit requirement in configure script?
I can see that spice-core.h (spice-server, one of the mail include) is
including spice-protocol headers.
Looking at configure both are required so would make sense to check
only spice-server, unless packaging has some bugs if you have spice-server
(devel) installed you also have spice-protocol.

Frediano
