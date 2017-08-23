Received: from eggs.gnu.org ([2001:4830:134:3::10]:56062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkJp6-0002xd-2S
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 20:48:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkJoE-0005hN-Ce
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 20:47:08 -0400
Date: Wed, 23 Aug 2017 10:45:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170823004546.GH5379@umbus.fritz.box>
References: <20170822122327.9567-1-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r5lq+205vWdkqwtk"
Content-Disposition: inline
In-Reply-To: <20170822122327.9567-1-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] target/ppc: 'PVR != host PVR' in
 KVM_SET_SREGS workaround
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, lvivier@redhat.com


--r5lq+205vWdkqwtk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 22, 2017 at 09:23:26AM -0300, Daniel Henrique Barboza wrote:
> v2:
> - added Laurent's fix in 'kvmppc_pvr_workaround_required' to avoid
> returning true when running with TCG.

Thanks, but I already altered this inline.  I made a slight change, so
that we check for kvm enabled before looking at the relevant KVM cap -
it shouldn't matter if there is no KVM anyway.

>=20
>=20
> Daniel Henrique Barboza (1):
>   target/ppc: 'PVR !=3D host PVR' in KVM_SET_SREGS workaround
>=20
>  target/ppc/kvm.c     | 34 ++++++++++++++++++++++++++++++++++
>  target/ppc/kvm_ppc.h |  1 +
>  target/ppc/machine.c | 22 ++++++++++++++++++++++
>  3 files changed, 57 insertions(+)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--r5lq+205vWdkqwtk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmc0DoACgkQbDjKyiDZ
s5LAFA/7BXgzN8zC1nO2FRSytKZCnNEl2AqBI3a/BGhN1+00bayaxqQeL4BDITqr
K9HuVF8w0CPBwOleQKcE/R4TFWmNXopKU2v+c+cKwAXcLq9KsmDPvVyDHquOshj+
pCheYXRJxnIow8CVLnfYMYw9IiBDA9JrkUvERAPH4jY8PUhKpDciguwqzC+17H/k
rcItGyy7m1gYzf5HVeoYOGfeewXKWnvN+Y1zk855VPP5fuYJ+xJJNJHwy7drIEki
3DFPxcVldWxeLAxyLRUvkXcH6VHyoYN6VxBORVQCHDcFCzkStGWSQd5xWo7UXTv8
2gJE9vKiB96XUQ6+jq11bqeaDfe2Q8sg14puKPG+NJWgOtq6RiFTfU5hwaXny8QM
OHD+MtoggVjIMdvUMywJtxHf8qUObHkG6WaHJKwNG/7alzdDXVKZrfsxwYbH9DLK
Tp3JB45wY6ZP4OEMSY3iMmMRFlPA9tm6YoT+/gG1yIEUfNPBFir3HXwiAFsrOnKV
5X6io19F90mkB7SWR2PDv0ExzVvt9AtnO96t4tWL1JrggULDRJh59UgkMGhvYlm6
P5LiN0aw+BqdQdtiJ87QrB/DrBWC925BVsXiryRYttnM/kyBf5cmtaDex3MiylhJ
VaaNFESkSH5nEemiTo7naQqNwD0c71TfqF3qOEmh46e+qWGfKjM=
=YDtF
-----END PGP SIGNATURE-----

--r5lq+205vWdkqwtk--
