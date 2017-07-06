Received: from eggs.gnu.org ([2001:4830:134:3::10]:56257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dT1dg-0000pZ-8W
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dT1dd-0002qZ-72
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:55:52 -0400
Received: from 19.mo4.mail-out.ovh.net ([87.98.179.66]:33480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dT1dd-0002n9-0i
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:55:49 -0400
Received: from player159.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 46753835DE
	for <qemu-devel@nongnu.org>; Thu,  6 Jul 2017 09:55:45 +0200 (CEST)
Date: Thu, 6 Jul 2017 09:55:38 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170706095538.65c26004@bahia.lan>
In-Reply-To: <20170706073233.GP2180@umbus.fritz.box>
References: <149924459296.25523.6693809356627708668.stgit@bahia.lan>
	<20170706073233.GP2180@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/=rdKY.KxF66G2S0v0+fKeM8";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] ppc/kvm: have the "family" CPU alias to
 point to TYPE_HOST_POWERPC_CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org

--Sig_/=rdKY.KxF66G2S0v0+fKeM8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Jul 2017 17:32:33 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Jul 05, 2017 at 10:49:52AM +0200, Greg Kurz wrote:
> > When running KVM on POWER, we allow the user to pass "-cpu POWERx" inst=
ead
> > of "-cpu host". This is achieved by patching the ppc_cpu_aliases[] array
> > so that "POWERx" points to the CPU class with the same PVR as the host =
CPU.
> > This causes CPUs to be instantiated from this CPU class instead of the
> > TYPE_HOST_POWERPC_CPU class which is used with "-cpu host". These CPUs =
thus
> > miss all the KVM specific tuning from kvmppc_host_cpu_class_init().
> >=20
> > This currently causes QEMU with "-cpu POWER9" to fail when running KVM =
on a
> > POWER9 DD1 host:
> >=20
> > qemu-system-ppc64: Register sync failed... If you're using kvm-hv.ko, o=
nly
> >  "-cpu host" is possible
> > kvm_init_vcpu failed: Invalid argument
> >=20
> > Let's have the "POWERx" alias to point to TYPE_HOST_POWERPC_CPU directl=
y,
> > so that "-cpu POWERx" instantiates CPUs from the same class as "-cpu ho=
st".
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
> Nice.  I had mistakenly thought it already did that.
>=20
> I've applied this to ppc-for-2.10.
>=20
> Just to make sure I've understood, this obsoletes Laurent's earlier
> patches moving DD1 workarounds about, yes?
>=20

Yes it does.

Cheers,

--
Greg

--Sig_/=rdKY.KxF66G2S0v0+fKeM8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlld7PoACgkQAvw66wEB28I5sQCeJUX9/AYMtkcMmVYsI+BNueoK
mhEAn1ZTsaXJwYl7pgOUL9e4xwo5kj4P
=Sim6
-----END PGP SIGNATURE-----

--Sig_/=rdKY.KxF66G2S0v0+fKeM8--
