Received: from eggs.gnu.org ([2001:4830:134:3::10]:37849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dsmAG-0006Pe-EW
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:39:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dsmAF-0001vc-9l
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:39:56 -0400
Date: Fri, 15 Sep 2017 18:39:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170915083932.GM5250@umbus.fritz.box>
References: <150541711102.1616.2690784964841960181.stgit@bahia.lan>
	<150541714343.1616.11893912014879112098.stgit@bahia.lan>
	<19f09a67-5b16-6bdf-5c72-c2df84537ea7@redhat.com>
	<20170915063540.GF5250@umbus.fritz.box>
	<fff9daba-393f-a226-4b9d-467e7a6f47a0@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Aaj1jBvBEV7KRjLi"
Content-Disposition: inline
In-Reply-To: <fff9daba-393f-a226-4b9d-467e7a6f47a0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] ppc/kvm: check some capabilities with
 kvm_vm_check_extension()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Sam Bobroff <sam.bobroff@au1.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>


--Aaj1jBvBEV7KRjLi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2017 at 10:18:49AM +0200, Thomas Huth wrote:
> On 15.09.2017 08:35, David Gibson wrote:
> > On Fri, Sep 15, 2017 at 07:15:41AM +0200, Thomas Huth wrote:
> >> On 14.09.2017 21:25, Greg Kurz wrote:
> >>> The following capabilities are VM specific:
> >>> - KVM_CAP_PPC_SMT_POSSIBLE
> >>> - KVM_CAP_PPC_HTAB_FD
> >>
> >> BTW, looks like kvmppc_has_cap_htab_fd() is dead code ... should we
> >> either remove it or check it somewhere?
> >=20
> > It's checked in kvmppc_get_htab_fd().
>=20
> That function checks the "cap_htab_fd" variable, but is not using the
> kvmppc_has_cap_htab_fd() function which I was referring to.

Oh, sorry, good point.

We should remove it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Aaj1jBvBEV7KRjLi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm7kcQACgkQbDjKyiDZ
s5JIHBAAhtZ9Pp3a3uBUOw4TawF5gVxvtE/LyVKP8gixaIrI8yJUelpdQIDkIsUs
uiNS+M3EgQJeHlWi3kwTxx/NwWXAQJJOlg769nDUqxpS1oWVdMHh6K0gBIUJIo4L
0o7sHxdWksfFaFnGdzqp2wQnukup2Gm6S1jEmEGr294zUQ0/4UsvfH8WHEn/ICRM
sXjhFH8CNCoqDT84E2/d4wu5KsJwbA2+FxcnTqFqJ7z4FwkaCoUlf9wL8Bnyb7oR
ErNAg6RVou3es0eDzPDjafbTyjB6RTf1bw5w+0xXg232yRdngUJKLiXtyhjQDfVV
l0yZ7FUONEaAM/tOj4TrTf1r9GciD/UjLk9t3Kef2kbUaU1Amf7tAAYVLXDUsada
QyNogScK3gs4fLUrL3G3TbcKRgiYhlOSue9LAEXueQYbJuhOWmyML2X5XJb9P1ZN
tsbtaAG2W4wSCJbMQnOklfrgwX8Csc7r8Spnl/D2oI76sHnVQoD9HST1UL28nlpv
BkQFFcdqDVgYNDcGwMjsMd4oU/KgGe07yUBjCdv/BpD+tM5O8cg+f7HGFNGWTMO4
CAkfO3/zHXpvzfimXAsY7t20sJT9bmZ1CKR3FqIoHx4uhI/QdwxQIvW3LGJD/n4h
DCKD72yBUvfVvoUO3KEqFcKw5YO4uofbaoPswJN4xWe53BlOVkA=
=0vHc
-----END PGP SIGNATURE-----

--Aaj1jBvBEV7KRjLi--
