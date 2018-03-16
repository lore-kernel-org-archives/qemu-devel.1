Received: from eggs.gnu.org ([2001:4830:134:3::10]:33130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ewfIS-0007Ub-Rs
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 22:40:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ewfIP-000446-Oh
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 22:40:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51698 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ewfIP-00043d-Ja
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 22:40:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8231BEBFEF
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 02:40:29 +0000 (UTC)
Date: Fri, 16 Mar 2018 10:40:23 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180316024023.GC13063@lemon.usersys.redhat.com>
References: <1520942752-19449-1-git-send-email-pbonzini@redhat.com>
	<20180315144719.GT3146@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180315144719.GT3146@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docker: fedora: test more components
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Thu, 03/15 14:47, Daniel P. Berrang=E9 wrote:
> On Tue, Mar 13, 2018 at 01:05:52PM +0100, Paolo Bonzini wrote:
> > Install optional dependencies of QEMU to get better coverage.
> >=20
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  tests/docker/dockerfiles/fedora.docker | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/do=
ckerfiles/fedora.docker
> > index 994a35a..0d9da45 100644
> > --- a/tests/docker/dockerfiles/fedora.docker
> > +++ b/tests/docker/dockerfiles/fedora.docker
> > @@ -1,9 +1,16 @@
> >  FROM fedora:27
> >  ENV PACKAGES \
> >      ccache gettext git tar PyYAML sparse flex bison python3 bzip2 ho=
stname \
> > -    glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
> > -    gcc gcc-c++ clang make perl which bc findutils libaio-devel \
> > -    nettle-devel libasan libubsan \
> > +    gcc gcc-c++ clang make perl which bc findutils glib2-devel \
> > +    libaio-devel pixman-devel zlib-devel libfdt-devel libasan libubs=
an \
> > +    bluez-libs-devel brlapi-devel bzip2-devel \
> > +    device-mapper-multipath-devel glusterfs-api-devel gnutls-devel \
> > +    gtk3-devel libattr-devel libcap-devel libcap-ng-devel libcurl-de=
vel \
> > +    libjpeg-devel libpng-devel librbd-devel libssh2-devel libusbx-de=
vel \
> > +    libxml2-devel lzo-devel ncurses-devel nettle-devel nss-devel \
> > +    numactl-devel SDL2-devel snappy-devel spice-server-devel \
> > +    systemtap-sdt-devel usbredir-devel virglrenderer-devel vte3-deve=
l \
> > +    xen-devel \
>=20
> This still has some notable differences from the build deps we use in
> formal Fedora QEMU RPMs. I think we have missing:
>=20
>    alsa-lib-devel
>    capstone-devel
>    cyrus-sasl-devel
>    glusterfs-devel
>    libcacard-devel
>    libepoxy-devel
>    libiscsi-devel
>    libnfs-devel
>    librdmacm-devel
>    libseccomp-devel
>    libtasn1-devel
>    libuuid-devel
>    mesa-libgbm-devel
>    perl-podlators
>    pulseaudio-libs-devel
>    systemd-devel
>    texinfo
>    vte291-devel

I wonder if we should simply do "dnf build-dep qemu" and only list additi=
onal
(mingw, for example) packages explicitly, like the debian dockerfiles.

Fam

>=20
>=20
> Some extra bits that are not needed:
>=20
>   glib2-devel is not required as gtk3-devel pulls it in
>   nettle-devel is not required as gnutls-devel puls it in
>  =20
>   nss-devel shouldn't be used by anything in QEMU - we use gnutls
>  =20
>   vte3-devel is obsoleted by vte291-devel
>=20
> >      mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL mingw32-pkg=
-config \
> >      mingw32-gtk2 mingw32-gtk3 mingw32-gnutls mingw32-nettle mingw32-=
libtasn1 \
> >      mingw32-libjpeg-turbo mingw32-libpng mingw32-curl mingw32-libssh=
2 \
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
