Received: from eggs.gnu.org ([2001:4830:134:3::10]:37076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEClN-0002j7-UX
	for qemu-devel@nongnu.org; Thu, 03 May 2018 07:51:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEClJ-0004D0-Ph
	for qemu-devel@nongnu.org; Thu, 03 May 2018 07:51:06 -0400
Date: Thu, 3 May 2018 17:35:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180503073541.GZ13229@umbus.fritz.box>
References: <20180503071037.31834-1-david@gibson.dropbear.id.au>
	<2bd5d47b-5561-fa4a-4277-6ef026ff8749@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xd76R9tHJzDpbIo0"
Content-Disposition: inline
In-Reply-To: <2bd5d47b-5561-fa4a-4277-6ef026ff8749@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] spapr: Remove support for explicitly
 allocated RMAs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: groug@kaod.org, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--xd76R9tHJzDpbIo0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 09:19:34AM +0200, Thomas Huth wrote:
> On 03.05.2018 09:10, David Gibson wrote:
> > Current POWER cpus allow for a VRMA, a special mapping which describes a
> > guest's view of memory when in real mode (MMU off, from the guest's poi=
nt
> > of view).  Older cpus didn't have that which meant that to support a gu=
est
> > a special host-contiguous region of memory was needed to give the guest=
 its
> > Real Mode Area (RMA).
> >=20
> > KVM used to provide special calls to allocate a contiguous RMA for those
> > cases.  This was useful in the early days of KVM on Power to allow it t=
o be
> > tested on PowerPC 970 chips as used in Macintosh G5 machines.  Now, tho=
se
> > machines are so old as to be almost irrelevant.
>=20
> I still got my YDL PowerStation somewhere in a corner ... but well,
> true, I haven't turned on its power since a year or two... or three...
>=20
> > The normal qemu deprecation process would require this to be marked
> > deprecated then removed in 2 releases.  However, this can only be used
> > with corresponding support in the host kernel - which was dropped
> > years ago (in c17b98cf "KVM: PPC: Book3S HV: Remove code for PPC970
> > processors" of 2014-12-03 to be precise).  Therefore it should be ok
> > to drop this immediately.
>=20
> OK, fair.
>=20
> > Just to be clear this only affects *KVM* guests with PowerPC 970, and t=
hose
> > already require an ancient host kernel.  TCG guests with PowerPC 970 sh=
ould
> > still work.
>=20
> Just to be sure: kvm-pr will continue to work on a 970 host, right? In
> that case:

Yes, KVM PR should be fine.  Not that I've tested, but I see no reason
it would break.  I'll clarify that in the message.

> Acked-by: Thomas Huth <thuth@redhat.com>
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xd76R9tHJzDpbIo0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrqu8oACgkQbDjKyiDZ
s5L+rRAAvLSCxFZz7Lo+2COkiPXZMaZ5Xkg7tSrJqu//2ZSFQCty4SfM7WNvF+iD
s6d8yMAcig+xez+g5sJ2sSo9EO0cTLV7WUj29oRv9G0FVgo8rlRk3cgSYk/f4um9
J84p6KKDKX3m8n7N7BDN0czPBuWp1IJswbZ/l4q8EC81OywhsHNMRvozj4yVk8dc
1+Hv/+1jwqsNoTeEuhqyNfYpNRaLGM1uMObwLlnBB4h+crDuJFvFgjKGhQVcs0/k
CoImrJJOFyOlMAJ0mSYdnbQlH6VLnD9s9d7aWnLXvz6nIi72NioeRAtQnipr3rwH
hG100LvF/7phzN0kFLC7eX6HFVmpEKfROI80vTIWijg01yDBOTr0vyv0ODw2hMv2
i7DQfVMmR4cSAoecw52MbpbG723Ba5ovu9osdHTxlIk024154mhDspa00i+seHzn
HampLSkHB9wz7/pZfsSHWVcz4t9nO3DekqyiNFMjRwsV74MfDga6K7PstHGz1vZR
lqilK1PD/RVqu+ng0EEPNqzQxyNMvhKlXgLUEbvMFqv8zROLSSke+eeyIq1DcLU2
4q5bCHqxuzQVS4Yq3um9VbDPVaJ96/LLxwz77/NFjqzgnoiXgeqjbq0dXO6PMqYr
nWiIoeqki2iAbGoxkQEth/Q98UfbNvpjoVJuRyHmLgVb5OprVWQ=
=DLm4
-----END PGP SIGNATURE-----

--xd76R9tHJzDpbIo0--
