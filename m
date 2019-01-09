Received: from eggs.gnu.org ([209.51.188.92]:36119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghEi9-0001cI-OL
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:20:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghEi8-0004LU-SZ
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:20:01 -0500
Date: Wed, 9 Jan 2019 14:19:52 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190109141952.GQ3998@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190109132302.22634-1-rjones@redhat.com>
	<20190109134448.GO3998@redhat.com>
	<20190109141446.GY27120@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190109141446.GY27120@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] qemu-io: Add generic function for
 reinitializing optind.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: eblake@redhat.com, kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

On Wed, Jan 09, 2019 at 02:14:46PM +0000, Richard W.M. Jones wrote:
> On Wed, Jan 09, 2019 at 01:44:48PM +0000, Daniel P. Berrang=C3=A9 wrote=
:
> > On Wed, Jan 09, 2019 at 01:23:01PM +0000, Richard W.M. Jones wrote:
> > > How about this one?  Add a generic osdep function for reinitializin=
g
> > > optind, which does optreset on FreeBSD (but is identical on all oth=
er
> > > OSes).  Use it from qemu-io and qemu-img.
> > >=20
> > > I have tested this on Linux, FreeBSD and OpenBSD.
> > >=20
> > > checkpatch complains:
> > >=20
> > > WARNING: Block comments use a leading /* on a separate line
> > > #69: FILE: include/qemu/osdep.h:591:
> > > +/**
> >=20
> > I think it just doesn't like your '/**' and wants '/*' instead.
>=20
> The existing comments in the same file are a mix of three styles.
> I chose the style used closest to the new comment I was adding :-)

Yeah, pre-existing code is a mess often not passing current style
rules. I wish we'd clean up existing code, but failing that, it can
be valid to ignore style warnings to be more consistent with existing
code.

>=20
> > > WARNING: architecture specific defines should be avoided
> > > #78: FILE: include/qemu/osdep.h:600:
> > > +#ifdef __FreeBSD__
> >=20
> > Normally we'd suggest doing a configure test to for the platform
> > feature and then using a feature based ifdef test. In this case
> > though that would be difficult and/or overly complex.
> >=20
> > This does make me wonder about the other *BSDs, OS-X and Mingw
>=20
> OpenBSD is known fine with optind =3D 0.  I can't test OS-X.  I can tes=
t
> mingw (on Linux) later.
>=20
>=20
> > though ?  Should they all be using the #else codepath, or should
> > the other BSDs / OS-X use the __FreeBSD__ codepath.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
