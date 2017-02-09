Received: from eggs.gnu.org ([2001:4830:134:3::10]:46922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbzF6-0002Jh-TP
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 19:39:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbzF6-00064w-4Y
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 19:39:16 -0500
Date: Fri, 10 Feb 2017 10:58:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170209235833.GI27610@umbus.fritz.box>
References: <1486618411-7018-1-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="svExV93C05KqedWb"
Content-Disposition: inline
In-Reply-To: <1486618411-7018-1-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 0/2] POWER9 TCG enablements - part14
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, rth@twiddle.net, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com


--svExV93C05KqedWb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09, 2017 at 11:03:29AM +0530, Nikunj A Dadhania wrote:
> This series contains 4 new instructions for POWER9 ISA3.0
>     Load/Store Atomic instructions
>=20
> Changelog:
> v0:
>    Raise invalid execption for function codes that are not implemented,=
=20
>    and data storage execption for invalid function codes.
>=20
> Balamuruhan S (2):
>   target-ppc: implement load atomic instruction
>   target-ppc: implement store atomic instruction
>=20
>  target/ppc/internal.h  |   2 +
>  target/ppc/translate.c | 111 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 113 insertions(+)

Applied to ppc-for-2.9.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--svExV93C05KqedWb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYnQIpAAoJEGw4ysog2bOST4kQAIRfFyfppktSGet0rtJKl5tY
7FiJLeppByDUohZQqy2yIuEF3oy6UNuDdjAdM0OBRpxcUYkk6eLn4+PzRfW+5HRE
gSYqr76/3AUUD5s1OW/5RoPVm8cBNhkjO5h/QMIOye4736yImgzOJ7y4zhRuNxfC
YjA6VPbxiVfL0TLmk3Z3YFAhgm2x1m7RpxK+PwQrsDJq8quIRtXjTyTNmsrBS093
TWrX9dCVgACBfa68Pg7d076kYkv5YBu3hlBJzUXAxupJZI+GSg5eLliAIFh5heK1
1de9MDiaLMi3uLKPVfhtb0bkSKdep0V9keT/68TckCnHjIBkXAdBe3hctt0ljxNI
7zq6Sc3/bTnQ/yBBTijHDTS3eraAg33ZeDBKwg/JYDEZlJmKwAqDUO9FdTVCO7nI
yp09puqRWVAIRzBNBliggYz1uMqN4Ue75Tpk7dN7rhKfxWIt5MuLliHf9hlDx5VV
KVA+JmxWTMVGe2VRP0U2gl5uTG2Vtr8WBoD/sUDfHm3R1OQX+IEWm2fH7HhWGuUj
pT3scK0cGWJbx36AtsGPVQBSLK8D0Td9Wh8r/E5gNmfI6BN+7282UYFqbE7WmxE2
3mFhPMaUr/FL/WrBWUjk/NynhyyF3kVKuN4TPLbsO5ITFWDxzdHknkWL3+EhqgS+
CxXW+wYjC2SXakbz5AFp
=LaMG
-----END PGP SIGNATURE-----

--svExV93C05KqedWb--
