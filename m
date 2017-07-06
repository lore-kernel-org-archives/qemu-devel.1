Received: from eggs.gnu.org ([2001:4830:134:3::10]:52728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dT1HO-0002Ka-A0
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:32:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dT1HK-0001EN-A9
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:32:50 -0400
Date: Thu, 6 Jul 2017 17:32:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170706073233.GP2180@umbus.fritz.box>
References: <149924459296.25523.6693809356627708668.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4SRTEifjNkXp0Rce"
Content-Disposition: inline
In-Reply-To: <149924459296.25523.6693809356627708668.stgit@bahia.lan>
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
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org


--4SRTEifjNkXp0Rce
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2017 at 10:49:52AM +0200, Greg Kurz wrote:
> When running KVM on POWER, we allow the user to pass "-cpu POWERx" instead
> of "-cpu host". This is achieved by patching the ppc_cpu_aliases[] array
> so that "POWERx" points to the CPU class with the same PVR as the host CP=
U.
> This causes CPUs to be instantiated from this CPU class instead of the
> TYPE_HOST_POWERPC_CPU class which is used with "-cpu host". These CPUs th=
us
> miss all the KVM specific tuning from kvmppc_host_cpu_class_init().
>=20
> This currently causes QEMU with "-cpu POWER9" to fail when running KVM on=
 a
> POWER9 DD1 host:
>=20
> qemu-system-ppc64: Register sync failed... If you're using kvm-hv.ko, only
>  "-cpu host" is possible
> kvm_init_vcpu failed: Invalid argument
>=20
> Let's have the "POWERx" alias to point to TYPE_HOST_POWERPC_CPU directly,
> so that "-cpu POWERx" instantiates CPUs from the same class as "-cpu host=
".
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Nice.  I had mistakenly thought it already did that.

I've applied this to ppc-for-2.10.

Just to make sure I've understood, this obsoletes Laurent's earlier
patches moving DD1 workarounds about, yes?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4SRTEifjNkXp0Rce
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZXeeOAAoJEGw4ysog2bOSmCoP/3b9+XvrdIZha5Wh8wvcA0y4
63YO19Ezak/VMMvpmTnXYJzNMhgeMUwzYClaoAHLP2r0KTwldntUWF9sgca7QZoB
8Q4+wEG+fbhFWGh7og+9fFpxQ3blTs7DDOAUwb8d+7Y2WG7nyoxJtxg9InWcnzTq
KPjA1/AroejyVtXFJZCBWmgTslQiU2eKm7fCq2wVXZuOtfYmQ48HCv2tY2Ly3XDA
8gOSL+eK910TkBTTuNH/b6Mzg+8cCU768L29+pGaQee/j6ETwHsaaDgCltHsVF0q
pSj+A1COqrQof64S67hpY7t+GNWNOZckk0qKrjaQvtaQbfsnVPx0LiRD4Q+dJbdy
JXHuCf6tr4DOP9GLI5UKzSMMf9zbvBPrrajSxzrxRuWBy4zKpfTvyztLKYbDfpf9
wWd8BHNu7Fd9rvKKM0Y/1lZcmMYwS33ysJ1DC0UV582WPnxTX3U8iCxdmruduxbM
sLzE7AZqgj4rsfqblfhgcYorpkuz38TlCKt8xRBLe/cXdb0NbwlIWb9aMdw0EPAN
n6u0Vmh9znGIimfDeqMzEK1HSH85neWAemQDytOWxKOKne5CEc9uM/F5jbn9guui
nPkGrXBq1rXZJZMrhr5xtRxmOI3Q/RaHjaS9ooMw85YZuA9Ph5Kon1MySSQO+38P
m4k8aCIrbjJYsaCiSOeR
=fpXx
-----END PGP SIGNATURE-----

--4SRTEifjNkXp0Rce--
