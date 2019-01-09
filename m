Received: from eggs.gnu.org ([209.51.188.92]:35189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1ghEdD-0008Jl-6J
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:14:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1ghEdC-00020Z-8j
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:14:55 -0500
Date: Wed, 9 Jan 2019 14:14:46 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20190109141446.GY27120@redhat.com>
References: <20190109132302.22634-1-rjones@redhat.com>
	<20190109134448.GO3998@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190109134448.GO3998@redhat.com>
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: eblake@redhat.com, kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

On Wed, Jan 09, 2019 at 01:44:48PM +0000, Daniel P. Berrang=E9 wrote:
> On Wed, Jan 09, 2019 at 01:23:01PM +0000, Richard W.M. Jones wrote:
> > How about this one?  Add a generic osdep function for reinitializing
> > optind, which does optreset on FreeBSD (but is identical on all other
> > OSes).  Use it from qemu-io and qemu-img.
> >=20
> > I have tested this on Linux, FreeBSD and OpenBSD.
> >=20
> > checkpatch complains:
> >=20
> > WARNING: Block comments use a leading /* on a separate line
> > #69: FILE: include/qemu/osdep.h:591:
> > +/**
>=20
> I think it just doesn't like your '/**' and wants '/*' instead.

The existing comments in the same file are a mix of three styles.
I chose the style used closest to the new comment I was adding :-)

> > WARNING: architecture specific defines should be avoided
> > #78: FILE: include/qemu/osdep.h:600:
> > +#ifdef __FreeBSD__
>=20
> Normally we'd suggest doing a configure test to for the platform
> feature and then using a feature based ifdef test. In this case
> though that would be difficult and/or overly complex.
>=20
> This does make me wonder about the other *BSDs, OS-X and Mingw

OpenBSD is known fine with optind =3D 0.  I can't test OS-X.  I can test
mingw (on Linux) later.

Rich.

> though ?  Should they all be using the #else codepath, or should
> the other BSDs / OS-X use the __FreeBSD__ codepath.
>=20
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

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v
