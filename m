Received: from eggs.gnu.org ([2001:4830:134:3::10]:35917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxss2-0003Lw-2Q
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:17:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxss0-0006mM-OM
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:17:58 -0400
Date: Tue, 11 Apr 2017 16:53:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170411065300.GC12900@umbus.fritz.box>
References: <20170410081217.2897-1-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Content-Disposition: inline
In-Reply-To: <20170410081217.2897-1-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for 2.10] tcg: enable MTTCG by default for
 PPC64 on x86
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, rth@twiddle.net, qemu-devel@nongnu.org, alex.bennee@linaro.org, intermediadc@hotmail.com, programmingkidx@gmail.com, clg@kaod.org


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 10, 2017 at 01:42:17PM +0530, Nikunj A Dadhania wrote:
> This enables the multi-threaded system emulation by default for PPC64
> guests using the x86_64 TCG back-end.
>=20
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>=20
> Depends on following patch which fixes the define name:
>=20
> https://patchwork.ozlabs.org/patch/748840/

Applied to ppc-for-2.10.

>=20
> ---
>  configure        | 2 ++
>  target/ppc/cpu.h | 2 ++
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/configure b/configure
> index 4b3b5cd..2a87495 100755
> --- a/configure
> +++ b/configure
> @@ -6008,12 +6008,14 @@ case "$target_name" in
>    ppc64)
>      TARGET_BASE_ARCH=3Dppc
>      TARGET_ABI_DIR=3Dppc
> +    mttcg=3Dyes
>      gdb_xml_files=3D"power64-core.xml power-fpu.xml power-altivec.xml po=
wer-spe.xml power-vsx.xml"
>    ;;
>    ppc64le)
>      TARGET_ARCH=3Dppc64
>      TARGET_BASE_ARCH=3Dppc
>      TARGET_ABI_DIR=3Dppc
> +    mttcg=3Dyes
>      gdb_xml_files=3D"power64-core.xml power-fpu.xml power-altivec.xml po=
wer-spe.xml power-vsx.xml"
>    ;;
>    ppc64abi32)
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index e0ff041..ece535d 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -30,6 +30,8 @@
>  #define TARGET_LONG_BITS 64
>  #define TARGET_PAGE_BITS 12
> =20
> +#define TCG_GUEST_DEFAULT_MO 0
> +
>  /* Note that the official physical address space bits is 62-M where M
>     is implementation dependent.  I've not looked up M for the set of
>     cpus we emulate at the system level.  */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY7H1KAAoJEGw4ysog2bOSKBEP/0fRZOb8Ki8tpMt41pzcEZVM
1efAgeoy1VK2VScYjaIWz8G6CKA8QUSnfPSWiVaxFtMVMyQQQvPtet+SY1s90ajh
rwbZsSn2Bo8IxM2u/gvxFurVx/U+bETb7GZlTgOiEt0Ex8jXprPwZIaLR0pCivMV
qV1QQfD3NLKMLXIlJW9A2GCQ45/XXDMlAn2sHT7WDV0b5Bud6Ujg3rSepXOoddQN
pRK6do9jlOmi9iOkDv3I59y5RTp++WEbVhtaOoDLvcJSZqgN14jA+VrhgtjKafO4
L9ZEIYWSNZb54lKFxVoelCq9V6grkV7g1xKdggszTdOAbQX3aPmu7nUKWxgbPhzS
MJqCrBFKHrtM5C2NsG1Tl17bnKiPTDkc53Iphf+7DE26IEVPmpgesMJSJEUjN62r
w+JYupRFGt/vOHEAEk9UB380dkrvYwCu8/aN34idK2M0K5oHykX7cL/CL2vyhcZc
HCvAtsHrAy1eWyVQPyHtcMWWgn2UVCYS1kq5yKpzJ7o2V/15sestNWM7EVo3Z4Fd
pCpQLAp0XZ8oq+jro5mq/LFsjq+RNzMPv+x0yFGPp7JOGV49BoRMXmqaOretWGHI
l6KxgPKfB4k0fbYPoDwJH56r6g5ckHfVB+tCDNBc/Fu7ev/glAeBK0gMl1DSud98
7YD8mxyWQoZcYoJfch7T
=jLeY
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--
