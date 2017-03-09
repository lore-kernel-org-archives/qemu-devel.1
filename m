Received: from eggs.gnu.org ([2001:4830:134:3::10]:48098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cloJ8-0001v8-Mo
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 22:00:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cloJ4-0003yP-JW
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 22:00:02 -0500
Date: Thu, 9 Mar 2017 12:34:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170309013414.GL19967@umbus.fritz.box>
References: <1489003123-3641-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="37cJpJlYZwAfNbm5"
Content-Disposition: inline
In-Reply-To: <1489003123-3641-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Fix wrong number of UAMR
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>


--37cJpJlYZwAfNbm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 08, 2017 at 08:58:43PM +0100, Thomas Huth wrote:
> The SPR UAMR has the number 13, and not 12. (Fortunately it seems like
> Linux is not using this register yet - only the privileged version with
> number 29 ... that's why nobody noticed this problem yet)
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/ppc/cpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to ppc-for-2.9, thanks.

>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 7c4a1f5..5ee33b3 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1408,7 +1408,7 @@ int ppc_compat_max_threads(PowerPCCPU *cpu);
>  #define SPR_601_UDECR         (0x006)
>  #define SPR_LR                (0x008)
>  #define SPR_CTR               (0x009)
> -#define SPR_UAMR              (0x00C)
> +#define SPR_UAMR              (0x00D)
>  #define SPR_DSCR              (0x011)
>  #define SPR_DSISR             (0x012)
>  #define SPR_DAR               (0x013) /* DAE for PowerPC 601 */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--37cJpJlYZwAfNbm5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYwLEWAAoJEGw4ysog2bOSon0QAIknoQ58Xsq5RVBNJ9VNUKNA
RJNGyUZPzJKDsqvEUDdPtmk0piW5IjHdWmPuoDBnt7ogh6UVRlb+KMq+0tRK+CPd
y4LZQKHX7tOw70Vhxpuvao0q9Xn+fXCwXtygQLiipn42q3B6RbYU2xgogPmktiCU
kTAK/V4RkKkTxibUVBIzP4H6Zqo3i/WCIDa2/3w2edfzca8mkk7nwDFnbj5615o1
TGcSf+6LPXVCs2NLtDAB2FmJN9MyLThUI2X5RELvLKlwg1az1km/a438pHfZ6EHY
5Y9iC6gQGBFxxWlIH3hXkPEkAZ685uc833DQNf3SD8E3RSggM6VOQ11nTXfHvJnq
N5xhnNBG1fXJSCrdmFuHqYaDoVnAnOvmuu6XsysB8wLz94JjLzQzuv97oGn8gzf+
3nTjZsrA/eb3pMFL7c7+Cc17biP+1APkwHHQlGxXRpw3TutNdMhmb/bBmdTFHv2m
6BRMkLvQLSONpR/zhHqf7PtEKv7tgdR4koyjPUbQxwxT9tRHmsrhcmzeUCI/NdB3
cEimKFsehNopN/JBDqEB0aoxMcjKeIxYSwkyX8sYUo3yeZOXjYlSrYfYD6YAav9S
4Ix07XTzIOq6xUGuD6jK6lmRYF15WNhXWJCJlQE9fW42Na0PuEMzjgbcvE0UMl6K
lQO8u/OBNdlP21eFUIKl
=sK5b
-----END PGP SIGNATURE-----

--37cJpJlYZwAfNbm5--
