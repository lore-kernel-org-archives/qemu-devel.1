Received: from eggs.gnu.org ([2001:4830:134:3::10]:54940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1gSJfm-0004u6-BU
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:35:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1gSJfj-0004UX-65
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:35:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fziglio@redhat.com>) id 1gSJfi-0004ON-TT
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:35:51 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1E768C052504
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 10:35:50 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DF625C21E
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 10:35:50 +0000 (UTC)
Date: Thu, 29 Nov 2018 05:35:49 -0500 (EST)
From: Frediano Ziglio <fziglio@redhat.com>
Message-ID: <905475153.46444981.1543487749747.JavaMail.zimbra@redhat.com>
In-Reply-To: <20181129090701.lbyqnyw4u3s2bxxw@sirius.home.kraxel.org>
References: <20181128155932.16171-1-marcandre.lureau@redhat.com>
	<20181129080926.qyji6olhjqzkkcuz@sirius.home.kraxel.org>
	<CAMxuvaywjHiBPLuaqhV1H_0XnariFHm=JLeo3fptSKLaZbFo9g@mail.gmail.com>
	<2135052047.46423828.1543480348695.JavaMail.zimbra@redhat.com>
	<20181129090701.lbyqnyw4u3s2bxxw@sirius.home.kraxel.org>
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

>=20
> On Thu, Nov 29, 2018 at 03:32:28AM -0500, Frediano Ziglio wrote:
> > > On Thu, Nov 29, 2018 at 12:09 PM Gerd Hoffmann <kraxel@redhat.com> wr=
ote:
> > > >
> > > > On Wed, Nov 28, 2018 at 07:59:32PM +0400, Marc-Andr=C3=A9 Lureau wr=
ote:
> > > > > Looking at chardev/spice.c code, I realize compilation was broken=
 for
> > > > > a while with spice-server < 0.12.3. Let's bump required version
> > > > > to 0.12.5, released May 19 2014, instead of adding more #ifdef.
> > > >
> > > > Oh, you did the 0.12.5 patch already.  Scratch my other reply then.
> > > >
> > > > > -  if $pkg_config --atleast-version=3D0.12.0 spice-server && \
> > > > > +  if $pkg_config --atleast-version=3D0.12.5 spice-server && \
> > > > >       $pkg_config --atleast-version=3D0.12.3 spice-protocol && \
> > > >
> > > > I think we should adjust spice-protocol too to whatever 0.12.5 requ=
ires
> > > > to build.
> > > >
> > >=20
> > > Why not leave that responsibility to pkg-config, and only require in
> > > qemu what is required there?
> > >=20
> > >=20
> >=20
> > That is remove explicit requirement in configure script?
> > I can see that spice-core.h (spice-server, one of the mail include) is
> > including spice-protocol headers.
> > Looking at configure both are required so would make sense to check
> > only spice-server, unless packaging has some bugs if you have spice-ser=
ver
> > (devel) installed you also have spice-protocol.
>=20
> seems the spice-protocol dep is there due to qemu itself needing it:
>=20
> commit 358689fe299c306f1d81bea57a5067d0abb56699
> Author: Michal Privoznik <mprivozn@redhat.com>
> Date:   Fri Mar 1 08:43:18 2013 +0100
>=20
>     configure: Require at least spice-protocol-0.12.3
>    =20
>     As of 5a49d3e9 we assume SPICE_PORT_EVENT_BREAK to be defined.
>     However, it is defined not in 0.12.2 what we require now, but in
>     0.12.3.  Therefore in order to prevent build failure we must
>     adjust our minimal requirements.
>    =20
>     Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> That makes sense.  So, when spice-server 0.12.5 requires spice-protocol
> 0.12.8+ anyway I think we can savely drop the spice-protocol check.
>=20
> cheers,
>   Gerd
>=20

My idea was more to revert (kind of) 7e3efdac75caca0b283f8e76ad24c924b4718e=
7b:


commit 7e3efdac75caca0b283f8e76ad24c924b4718e7b
Author: Alon Levy <alevy@redhat.com>
Date:   Wed Mar 7 16:19:03 2012 +0200

    spice: require spice-protocol >=3D 0.8.1
   =20
    Requiring spice-server >=3D 0.8.2 is not enough since spice-server.pc
    doesn't require spice-protocol (any version). Until that is fixed
    upstream an explicit requirement in qemu fixes compilation broken since
   =20
    commit 2e1a98c9c1b90ca093278c6b43244dc46604d7b7
    Author: Alon Levy <alevy@redhat.com>
    Date:   Fri Feb 24 23:19:30 2012 +0200
   =20
        qxl: introduce QXLCookie
   =20
    Reported-by: Peter Maydell <peter.maydell@linaro.org>
   =20
    Signed-off-by: Alon Levy <alevy@redhat.com>
    Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

diff --git a/configure b/configure
index 0111774cb0..62aa7609e1 100755
--- a/configure
+++ b/configure
@@ -2592,6 +2592,7 @@ EOF
   spice_cflags=3D$($pkg_config --cflags spice-protocol spice-server 2>/dev=
/null)
   spice_libs=3D$($pkg_config --libs spice-protocol spice-server 2>/dev/nul=
l)
   if $pkg_config --atleast-version=3D0.8.2 spice-server >/dev/null 2>&1 &&=
 \
+     $pkg_config --atleast-version=3D0.8.1 spice-protocol > /dev/null 2>&1=
 && \
      compile_prog "$spice_cflags" "$spice_libs" ; then
     spice=3D"yes"
     libs_softmmu=3D"$libs_softmmu $spice_libs"


The rationale does not apply any more, spice-server depends on spice-protoc=
ol.

Frediano
