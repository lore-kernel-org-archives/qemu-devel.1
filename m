Received: from eggs.gnu.org ([2001:4830:134:3::10]:44126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3Ae-0005M5-EC
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 22:21:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3Ad-0005ml-8G
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 22:21:44 -0500
Date: Tue, 6 Mar 2018 13:10:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180306021013.GT2650@umbus.fritz.box>
References: <1520247228-15496-1-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SSJ6yXlPvEk0CmSI"
Content-Disposition: inline
In-Reply-To: <1520247228-15496-1-git-send-email-wei.guo.simon@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2] PowerPC: Add TS bits into msr_mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wei.guo.simon@gmail.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>


--SSJ6yXlPvEk0CmSI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 05, 2018 at 06:53:48PM +0800, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
>=20
> During migration, after MSR bits is synced, cpu_post_load() will use
> msr_mask to determine which PPC MSR bits will be applied into the target
> side. Hardware Transaction Memory(HTM) has been supported since Power8,
> but TS0/TS1 bit was not in msr_mask yet. That will prevent target KVM
> from loading TM checkpointed values.
>=20
> This patch adds TS bits into msr_mask for Power8, so that transactional
> application can be migrated across qemu.
>=20
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>

Much better, applied, thanks.

> ---
>  target/ppc/translate_init.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 55c99c9..ca06028 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8689,6 +8689,8 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
>                      (1ull << MSR_DR) |
>                      (1ull << MSR_PMM) |
>                      (1ull << MSR_RI) |
> +                    (1ull << MSR_TS0) |
> +                    (1ull << MSR_TS1) |
>                      (1ull << MSR_LE);
>      pcc->mmu_model =3D POWERPC_MMU_2_07;
>  #if defined(CONFIG_SOFTMMU)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SSJ6yXlPvEk0CmSI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqd+IUACgkQbDjKyiDZ
s5LffQ/9F7SU6QKezKFeA/g5SKpU0pat9CiTNT3+FUJix2iUYAKehl/nfzDqOmV2
OXDFDphebuFXuvdQub5p7f2JMeoDrd8Xnvgs8I65LNqIhNleXDY+aCJSP0QlbKb8
BMmzXzrQDyO8izYE5B24tDQEE+C6H/BCY3KMi7V9+FVupnIDuTLU8pFpYdC/qK88
e8Cbq+W+Vk0CSakObOpPqaxyWY+N1KOetsl7cWjavZxDNydDLfOICkY02qYtsfKE
CH4vJR/0o4H3jmHgeVZ4s65Vmx+8vLUIvFBiV7k9fY+/Hl3757+DrNxgNJDuCVf0
wdjy7GFXmhzUvTaM75gfo9mMgJVI+rx0hI+hPqv1+rIqFmEiVBjm+AbBseAFFI0e
vGw+p0zjK7LsOXcNBnOQjDNM79zPC6sjWFM8lEGqrys2NljvN9eA3PH77k+6IMUI
auZEbdTVb005Y2lumDESiyvJFNvJErvWlWgZJuRByvXYpKj5JgWsiatxauxRZ1xQ
aUsC6k3F1zDbbKN8VDqVu29dl8mV7D9Y8M2FbuiWA7AskUqyszVGAniaHKmD0c+G
hVwmFl98iIwOwPqwpZetf7BDde3PAPN6gRFo4YVGbLQxFCFgtYFNtLnbyO3E3XtA
EqJHhE2+MlMeZ3LinGrBo0SVDw0txY6w0QgMmxb5X8CKOluEWqo=
=4ruP
-----END PGP SIGNATURE-----

--SSJ6yXlPvEk0CmSI--
