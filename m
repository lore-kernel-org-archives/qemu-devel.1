Received: from eggs.gnu.org ([2001:4830:134:3::10]:56303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYPTq-0000mx-Ge
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 22:51:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYPTp-0001Wt-F1
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 22:51:42 -0500
Date: Tue, 31 Jan 2017 13:46:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170131024645.GG14879@umbus.fritz.box>
References: <1485255307-11799-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yZnyZsPjQYjG7xG7"
Content-Disposition: inline
In-Reply-To: <1485255307-11799-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Remove unused
 POWERPC_FAMILY(POWER)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org


--yZnyZsPjQYjG7xG7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2017 at 11:55:07AM +0100, Thomas Huth wrote:
> We do not support POWER1 CPUs in QEMU, so it does not make sense
> to keep this stub around.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Merged to ppc-for-2.9, thanks.

> ---
>  target/ppc/translate_init.c | 22 ----------------------
>  1 file changed, 22 deletions(-)
>=20
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 19ef250..70333c5 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -5217,28 +5217,6 @@ POWERPC_FAMILY(e5500)(ObjectClass *oc, void *data)
> =20
>  /* Non-embedded PowerPC                                                 =
     */
> =20
> -/* POWER : same as 601, without mfmsr, mfsr                             =
     */
> -POWERPC_FAMILY(POWER)(ObjectClass *oc, void *data)
> -{
> -    DeviceClass *dc =3D DEVICE_CLASS(oc);
> -    PowerPCCPUClass *pcc =3D POWERPC_CPU_CLASS(oc);
> -
> -    dc->desc =3D "POWER";
> -    /* pcc->insns_flags =3D XXX_TODO; */
> -    /* POWER RSC (from RAD6000) */
> -    pcc->msr_mask =3D (1ull << MSR_EE) |
> -                    (1ull << MSR_PR) |
> -                    (1ull << MSR_FP) |
> -                    (1ull << MSR_ME) |
> -                    (1ull << MSR_FE0) |
> -                    (1ull << MSR_SE) |
> -                    (1ull << MSR_DE) |
> -                    (1ull << MSR_AL) |
> -                    (1ull << MSR_EP) |
> -                    (1ull << MSR_IR) |
> -                    (1ull << MSR_DR);
> -}
> -
>  #define POWERPC_MSRR_601     (0x0000000000001040ULL)
> =20
>  static void init_proc_601 (CPUPPCState *env)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yZnyZsPjQYjG7xG7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYj/qSAAoJEGw4ysog2bOSR9oQAMUTqZ6fC/MgSg40JvyVH1Wm
npeDkK+buin/RLmFwoU2QHymihC89x+cv2NM5bL4G6goWkVKdj7gnYaLtI0iyF8q
N/4G8P5PV2VPB02yP3S1+n+Jq+jbBW84EA1iQwDQQTcCqiEfIa+btgIwKYQ7lpIu
LA1ZERhEczGvxP4WObKl6df0sbOAKSGTfnhUVGpUXqAoC6QfrBMCs61G3f0DLtIr
92A2x2zLLaZdskaW+6Mjw8kGgv53f6auS667htH0DgaMZntYFhQR0M+ymVntM5Ge
pHYkYCxPdbOkeu4BJmsB1VASvibvmqZBiALmyKEeQ4yDetad0ovFxiKchaxwNl0J
ZVkL+Aj35ycyFa89S6nK1o6HLQtGwP4i+z1lc8Ntuuln02gm4LcehJGWflFszVov
rSMlDIZsjxEoF/GzzUzcgqHw8MuuhzBnPhnLxx4TzEoFM0QdAolsc4VWpAHqH9Zo
LmpK1504M1ilMdAP4RnQGtyzcdhOKTZujC67ywAiIpR4jaIDp1MXUetuZk92Qk+v
cP/B8+OVwdQcoiGvFsdZzJbWwZ/w8/ELU1yG+iIYXSyMXdMfLongbnQvuJDXRJQ2
L2MRvowHyTEfW0rYHVT/llByfK9BDP7FviwYt43u8Q6KFNE9IABYUyNwLfAs5LBE
xwJX3vnKhNee5ovvgpcX
=MPgY
-----END PGP SIGNATURE-----

--yZnyZsPjQYjG7xG7--
