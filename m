Received: from eggs.gnu.org ([2001:4830:134:3::10]:33612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKLEm-00018G-E6
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 05:02:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKLEj-00020h-6A
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 05:02:16 -0400
Date: Mon, 12 Jun 2017 16:45:00 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170612084500.GD18542@umbus>
References: <1497245555-32472-1-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GyRA7555PLgSTuth"
Content-Disposition: inline
In-Reply-To: <1497245555-32472-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v6 0/2] ppc/spapr: Fix migration of radix
 guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com, sjitindarsingh@gmail.com


--GyRA7555PLgSTuth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 12, 2017 at 11:02:33AM +0530, Bharata B Rao wrote:
> This patchset fixes the migration of sPAPR radix guests.
>=20
> Migration of hash and radix guests individually has been tested on
> TCG and KVM (P8 and P9 hosts). Changeover from HPT to RPT and vice versa
> via reboot during migration isn't tested yet since it is possible
> to test that currently only with TCG and TCG reboot is being fixed.
>=20
> Changes in v6:
> --------------
> - Ensure any allocated HPT is free by the target when the source
>   doesn't send HPT.

I've applied these to ppc-for-2.10, because I'm pretty sure they make
things better than they were.  There are some things I'd really like
to see addressed in followup patches, however.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GyRA7555PLgSTuth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZPlSLAAoJEGw4ysog2bOS44cQANFuCEONTAza0KAVlCrYyXlA
mRx4j4iiw6oCUP57QmrU2s1aWL74kJvF+8lBAhhYmLe2CpemjnCGbK+O99YrMeHg
+AnqXG0KzcTUdjRpzWSmbxkM5J/4r9bHLhsNJ0hdoX5kD7adr5WO81TPTnK8Cw+k
bkrEFbCH2SVRoT7sU9JAtfYjLtEzwbtx2vTZ4Y09N9MGC7yqE7fpNfaGPnMXxCX6
kHm9zwE6uiNcz8I1gg2Bjc/AmtzR7z/tIx4pECluX2LP9MANWkXPunR1KFjQ161A
CEHa3TJNMg3ms612Z03pdaI7MMYBzR2/ad1F/KGwczMDzh81lVuCvfe2uiQ+YjMg
81I1qm2vSBuT9FOJCw/1L+xh654vkqA/wK1a5gCHaqK06O1ZyflzUCikqE3s++8l
s5xdSDcAAwNBd8A/Qvl/EMr5G6mBv3VGZDo1BM5fsLice5Aqnt64Rvq9sRGJTrD2
CvhMbuacSKG3x1p3RnK3QJdWgClXzXRcmzaKYJijqaQb9TBn/GIRUO0IfjZvCzNQ
yaFCwGL95CijUZedujNeuvUDmQTwvwpPEMJ5cT7asGjjOB0MfsJkSkKIISU/qLWE
Bf1bBlyr++cMjwEhpejoKM2r2pQANx6N9UACHuP3gGb1WOS6Y+t5Nzs1wP8zAPqL
tGyoWLX8oi8Zd1GAQnld
=GWHn
-----END PGP SIGNATURE-----

--GyRA7555PLgSTuth--
