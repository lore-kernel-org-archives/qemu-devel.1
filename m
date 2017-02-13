Received: from eggs.gnu.org ([2001:4830:134:3::10]:33180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cd6Jr-0004QL-2H
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 21:24:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cd6Jp-0007v8-Pc
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 21:24:47 -0500
Date: Mon, 13 Feb 2017 12:59:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170213015953.GO25381@umbus>
References: <1486704360-27361-1-git-send-email-sjitindarsingh@gmail.com>
	<1486704360-27361-3-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iEWWOZ/QYGWEaBRW"
Content-Disposition: inline
In-Reply-To: <1486704360-27361-3-git-send-email-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V2 02/10] target/ppc: Fix LPCR
 DPFD mask define
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org, sam.bobroff@au1.ibm.com


--iEWWOZ/QYGWEaBRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2017 at 04:25:52PM +1100, Suraj Jitindar Singh wrote:
> The DPFD field in the LPCR is 3 bits wide. This has always been defined
> as 0x3 << shift which indicates a 2 bit field, which is incorrect.
> Correct this.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Since this is a correct fix all on its own, I've applied it to
ppc-for-2.9.

> ---
>  target/ppc/cpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index bc2a2ce..bb96dd5 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -381,7 +381,7 @@ struct ppc_slb_t {
>  #define LPCR_ISL          (1ull << (63 - 2))
>  #define LPCR_KBV          (1ull << (63 - 3))
>  #define LPCR_DPFD_SHIFT   (63 - 11)
> -#define LPCR_DPFD         (0x3ull << LPCR_DPFD_SHIFT)
> +#define LPCR_DPFD         (0x7ull << LPCR_DPFD_SHIFT)
>  #define LPCR_VRMASD_SHIFT (63 - 16)
>  #define LPCR_VRMASD       (0x1full << LPCR_VRMASD_SHIFT)
>  #define LPCR_RMLS_SHIFT   (63 - 37)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--iEWWOZ/QYGWEaBRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYoRMZAAoJEGw4ysog2bOS+0IP/1hcpsvAo5AFe9Lstv267Z0K
WBLzaLBnEbylmkfsXkRtOSIaccKWkW8/c3JQEMMTvcc5uKAm8uapbXuCqoc28BkV
qcXzxoLcEylSSmmL0EyrOiz7HObGlCFg3d5DMLojHRH2DSeVmIHE2G2nyvz8bsg7
s1Pjn8oWC3t5kIX9TI90HIj3qDS1wdGYy4r1CwmmeoV5nghL6Go1w1yF7DDRZjRL
l510gwlxT4JXQaMUjh9canEUa6crFVqUbAgQOXgdIT5vVzFlBY0r7Lm3MiTrg0zI
2uucdj8m3gVxrpgarS5+RXcvNkK3mFpdJeK2JcLXEdVG+nmK5J+XS7h4x5c6XLFE
XcPGcyTCvvz7MKd3+Gcfwn/hp9l07fQcwFUdhKidwbPfVQ0RakcVkoPJ7kTQiFE7
2hxIAV6zUepCh4S2Fj50fvNtQfJC/tOzLp6khAQ3KWOggsDPtYVLDVeHLijS0clg
U68+sSesWneUjKGDMtkXy+wyQsrJgqHfQEhdJOp5oOgUtggYCLcvrSIgVYuxeGUB
I2HeJPUk3VQd04sMnIafKDXDf3MDkClD+pnUwR1tcUEMYl23h6Y8+ecE4+Iq81P0
axK3cQSXQzITjZgamM7ddppzhp7BqpEotd3YuanSHT0dlCN8prZvUYQrWo8Qmz0n
aZRceEaMhXLgpAVy6z0f
=HC3J
-----END PGP SIGNATURE-----

--iEWWOZ/QYGWEaBRW--
