Received: from eggs.gnu.org ([2001:4830:134:3::10]:35324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ewlu4-000449-UI
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 05:44:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ewlu2-0007R4-7t
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 05:44:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48944 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ewlu2-0007Qf-1b
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 05:43:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8644A40704AD
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 09:43:57 +0000 (UTC)
Date: Fri, 16 Mar 2018 09:43:51 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180316094351.GD3066@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1520942752-19449-1-git-send-email-pbonzini@redhat.com>
	<20180315144719.GT3146@redhat.com>
	<20180316024023.GC13063@lemon.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180316024023.GC13063@lemon.usersys.redhat.com>
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
To: Fam Zheng <famz@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Fri, Mar 16, 2018 at 10:40:23AM +0800, Fam Zheng wrote:
> On Thu, 03/15 14:47, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, Mar 13, 2018 at 01:05:52PM +0100, Paolo Bonzini wrote:
> > > Install optional dependencies of QEMU to get better coverage.
> > >=20
> > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > > ---
> > >  tests/docker/dockerfiles/fedora.docker | 13 ++++++++++---
> > >  1 file changed, 10 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/=
dockerfiles/fedora.docker
> > > index 994a35a..0d9da45 100644
> > > --- a/tests/docker/dockerfiles/fedora.docker
> > > +++ b/tests/docker/dockerfiles/fedora.docker
> > > @@ -1,9 +1,16 @@
> > >  FROM fedora:27
> > >  ENV PACKAGES \
> > >      ccache gettext git tar PyYAML sparse flex bison python3 bzip2 =
hostname \
> > > -    glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
> > > -    gcc gcc-c++ clang make perl which bc findutils libaio-devel \
> > > -    nettle-devel libasan libubsan \
> > > +    gcc gcc-c++ clang make perl which bc findutils glib2-devel \
> > > +    libaio-devel pixman-devel zlib-devel libfdt-devel libasan libu=
bsan \
> > > +    bluez-libs-devel brlapi-devel bzip2-devel \
> > > +    device-mapper-multipath-devel glusterfs-api-devel gnutls-devel=
 \
> > > +    gtk3-devel libattr-devel libcap-devel libcap-ng-devel libcurl-=
devel \
> > > +    libjpeg-devel libpng-devel librbd-devel libssh2-devel libusbx-=
devel \
> > > +    libxml2-devel lzo-devel ncurses-devel nettle-devel nss-devel \
> > > +    numactl-devel SDL2-devel snappy-devel spice-server-devel \
> > > +    systemtap-sdt-devel usbredir-devel virglrenderer-devel vte3-de=
vel \
> > > +    xen-devel \
> >=20
> > This still has some notable differences from the build deps we use in
> > formal Fedora QEMU RPMs. I think we have missing:
> >=20
> >    alsa-lib-devel
> >    capstone-devel
> >    cyrus-sasl-devel
> >    glusterfs-devel
> >    libcacard-devel
> >    libepoxy-devel
> >    libiscsi-devel
> >    libnfs-devel
> >    librdmacm-devel
> >    libseccomp-devel
> >    libtasn1-devel
> >    libuuid-devel
> >    mesa-libgbm-devel
> >    perl-podlators
> >    pulseaudio-libs-devel
> >    systemd-devel
> >    texinfo
> >    vte291-devel
>=20
> I wonder if we should simply do "dnf build-dep qemu" and only list addi=
tional
> (mingw, for example) packages explicitly, like the debian dockerfiles.

>From an upstream POV it feels wrong to have our builds depend on the stat=
e
of stuff listed in the Fedora RPM spec file, as we don't want changes in
Fedora to randomly break QEMU upstream CI.=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
