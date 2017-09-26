Received: from eggs.gnu.org ([2001:4830:134:3::10]:47801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwpyg-0003V7-3Z
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:32:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwpyZ-0004mM-GS
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:32:46 -0400
References: <cover.1506384414.git.alistair.francis@xilinx.com>
	<e9eb34b7a508fbe3b89bb8b8aa8141f018871081.1506384414.git.alistair.francis@xilinx.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1788278d-9437-34a0-4a17-d7914d459f77@redhat.com>
Date: Tue, 26 Sep 2017 08:32:09 -0500
MIME-Version: 1.0
In-Reply-To: <e9eb34b7a508fbe3b89bb8b8aa8141f018871081.1506384414.git.alistair.francis@xilinx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jvVlmhcp7cUHL8p1XvQEu8e63pbwj1G79"
Subject: Re: [Qemu-devel] [PATCH v1 1/8] Replace all occurances of
 __FUNCTION__ with __func__
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, John Snow <jsnow@redhat.com>, Juan Quintela <quintela@redhat.com>, armbru@redhat.com, Yongbok Kim <yongbok.kim@imgtec.com>, qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>, alistair23@gmail.com, Aurelien Jarno <aurelien@aurel32.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jvVlmhcp7cUHL8p1XvQEu8e63pbwj1G79
From: Eric Blake <eblake@redhat.com>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Fam Zheng <famz@redhat.com>,
 qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 John Snow <jsnow@redhat.com>, Juan Quintela <quintela@redhat.com>,
 armbru@redhat.com, Yongbok Kim <yongbok.kim@imgtec.com>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>, alistair23@gmail.com,
 Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <1788278d-9437-34a0-4a17-d7914d459f77@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 1/8] Replace all occurances of
 __FUNCTION__ with __func__
References: <cover.1506384414.git.alistair.francis@xilinx.com>
 <e9eb34b7a508fbe3b89bb8b8aa8141f018871081.1506384414.git.alistair.francis@xilinx.com>
In-Reply-To: <e9eb34b7a508fbe3b89bb8b8aa8141f018871081.1506384414.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/25/2017 07:08 PM, Alistair Francis wrote:
> Replace all occurs of __FUNCTION__ except for the check in checkpatch
> with the non GCC specific __func__.
>=20
> One line in hcd-musb.c was manually tweaked to pass checkpatch.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Andrzej Zaborowski <balrogg@gmail.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: John Snow <jsnow@redhat.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Yongbok Kim <yongbok.kim@imgtec.com>
> Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com> (supporter:Block
> Cc: Fam Zheng <famz@redhat.com> (supporter:Block

That looks funny, with no closing ).  Something's breaking down between
get_maintainers.pl and your eventual email, although it's not fatal.

> Cc: Juan Quintela <quintela@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: qemu-arm@nongnu.org
> Cc: qemu-block@nongnu.org
> Cc: xen-devel@lists.xenproject.org
> ---
>=20

>  65 files changed, 273 insertions(+), 273 deletions(-)

Big but mechanical, so I'm okay without splitting it further.

>=20
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index 5bcb1c60e1..543b1bd8d5 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -253,7 +253,7 @@ static inline int audio_ring_dist (int dst, int src=
, int len)
>  #define AUDIO_STRINGIFY(n) AUDIO_STRINGIFY_(n)
> =20
>  #if defined _MSC_VER || defined __GNUC__
> -#define AUDIO_FUNC __FUNCTION__
> +#define AUDIO_FUNC __func__
>  #else
>  #define AUDIO_FUNC __FILE__ ":" AUDIO_STRINGIFY (__LINE__)
>  #endif

This can be further simplified.  We really aren't using _MSC_VER as our
compiler (can anyone prove me wrong?), and we DO require a C99 compiler
(per C99 6.4.2.2, __func__ support is mandatory), so we don't really
need the #else branch (or, for that matter, we probably don't even need
AUDIO_FUNC).  But to keep this patch mechanical, that can be a separate
followup.

> diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
> index 58005b6619..32687afced 100644
> --- a/hw/arm/nseries.c
> +++ b/hw/arm/nseries.c
> @@ -463,7 +463,7 @@ static uint32_t mipid_txrx(void *opaque, uint32_t c=
md, int len)
>      uint8_t ret;
> =20
>      if (len > 9) {
> -        hw_error("%s: FIXME: bad SPI word width %i\n", __FUNCTION__, l=
en);
> +        hw_error("%s: FIXME: bad SPI word width %i\n", __func__, len);=


Not this patch's problem, but it would probably be simpler if hw_error()
were a macro that automatically prefixed __func__, rather than making
every caller have to supply it themselves.

> +++ b/hw/arm/omap1.c

> @@ -1716,7 +1716,7 @@ static void omap_clkm_write(void *opaque, hwaddr =
addr,
>      case 0x18:	/* ARM_SYSST */
>          if ((s->clkm.clocking_scheme ^ (value >> 11)) & 7) {
>              s->clkm.clocking_scheme =3D (value >> 11) & 7;
> -            printf("%s: clocking scheme set to %s\n", __FUNCTION__,
> +            printf("%s: clocking scheme set to %s\n", __func__,
>                              clkschemename[s->clkm.clocking_scheme]);

Worth fixing the indentation while you are here?

> @@ -2473,7 +2473,7 @@ static void omap_pwt_write(void *opaque, hwaddr a=
ddr,
>      case 0x04:	/* VRC */
>          if ((value ^ s->vrc) & 1) {
>              if (value & 1)
> -                printf("%s: %iHz buzz on\n", __FUNCTION__, (int)
> +                printf("%s: %iHz buzz on\n", __func__, (int)
>                                  /* 1.5 MHz from a 12-MHz or 13-MHz PWT=
_CLK */
>                                  ((omap_clk_getrate(s->clk) >> 3) /
>                                   /* Pre-multiplexer divider */

Likewise?

> @@ -3330,13 +3330,13 @@ static void omap_mcbsp_writeh(void *opaque, hwa=
ddr addr,
>          s->mcr[1] =3D value & 0x03e3;
>          if (value & 3)					/* XMCM */
>              printf("%s: Tx channel selection mode enable attempt\n",
> -                            __FUNCTION__);
> +                            __func__);
>          return;
>      case 0x1a:	/* MCR1 */
>          s->mcr[0] =3D value & 0x03e1;
>          if (value & 1)					/* RMCM */
>              printf("%s: Rx channel selection mode enable attempt\n",
> -                            __FUNCTION__);
> +                            __func__);

and again


> +++ b/hw/arm/omap2.c
> @@ -1312,7 +1312,7 @@ static void omap_prcm_apll_update(struct omap_prc=
m_s *s)
> =20
>      if (mode[0] =3D=3D 1 || mode[0] =3D=3D 2 || mode[1] =3D=3D 1 || mo=
de[1] =3D=3D 2)
>          fprintf(stderr, "%s: bad EN_54M_PLL or bad EN_96M_PLL\n",
> -                        __FUNCTION__);
> +                        __func__);

More of the same. I'll quit pointing it out.


> +++ b/hw/block/onenand.c
> @@ -661,12 +661,12 @@ static uint64_t onenand_read(void *opaque, hwaddr=
 addr,
>      case 0xff02:	/* ECC Result of spare area data */
>      case 0xff03:	/* ECC Result of main area data */
>      case 0xff04:	/* ECC Result of spare area data */
> -        hw_error("%s: imeplement ECC\n", __FUNCTION__);
> +        hw_error("%s: imeplement ECC\n", __func__);

Should we fix the typo while here? s/imeplement/implement/

> +++ b/hw/isa/vt82c686.c
> @@ -30,7 +30,7 @@
>  //#define DEBUG_VT82C686B
> =20
>  #ifdef DEBUG_VT82C686B
> -#define DPRINTF(fmt, ...) fprintf(stderr, "%s: " fmt, __FUNCTION__, ##=
__VA_ARGS__)
> +#define DPRINTF(fmt, ...) fprintf(stderr, "%s: " fmt, __func__, ##__VA=
_ARGS__)
>  #else
>  #define DPRINTF(fmt, ...)
>  #endif

Not this patch's problem, but I hate bit-rottable statements.  This
should be fixed separately into a form that always evaluates under
-Wformat (guarded by an if(0) in normal builds).

> diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
> index e8b2eef688..41a7690560 100644
> --- a/hw/mips/gt64xxx_pci.c
> +++ b/hw/mips/gt64xxx_pci.c
> @@ -33,7 +33,7 @@
>  //#define DEBUG
> =20
>  #ifdef DEBUG
> -#define DPRINTF(fmt, ...) fprintf(stderr, "%s: " fmt, __FUNCTION__, ##=
__VA_ARGS__)
> +#define DPRINTF(fmt, ...) fprintf(stderr, "%s: " fmt, __func__, ##__VA=
_ARGS__)
>  #else
>  #define DPRINTF(fmt, ...)
>  #endif

Ditto.


> +++ b/hw/usb/hcd-musb.c
> @@ -253,8 +253,8 @@
>  /* #define MUSB_DEBUG */
> =20
>  #ifdef MUSB_DEBUG
> -#define TRACE(fmt,...) fprintf(stderr, "%s@%d: " fmt "\n", __FUNCTION_=
_, \
> -                               __LINE__, ##__VA_ARGS__)
> +#define TRACE(fmt, ...) fprintf(stderr, "%s@%d: " fmt "\n", __func__, =
\
> +                                __LINE__, ##__VA_ARGS__)
>  #else
>  #define TRACE(...)
>  #endif

and again

My comments were either about things for separate patches, or things
that are trivial if you choose to touch them up, so:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--jvVlmhcp7cUHL8p1XvQEu8e63pbwj1G79
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnKVtkACgkQp6FrSiUn
Q2qeOQf8C9QDtC9z27RGtuiDAeN4pBKh+nmPCRAt+sIW1JGMiGUkfdgoLC3vStmV
MfEda0cGe+QEMTSwtDQNuIppN8RdmrYG8L+KM86RWmLH0fVlsdHbawPBhujJaeIi
0xxL5NQ3E/QALMY0AnOIFb5dFz9MDebrzZVr1wkqlv2PKbaycPiMtpi73sxfRIAm
vUhHLYhx9xdId+j40lrGzKtVW78HYFa6rjtdDE2eP+HCflyD00C7ztFF/v4EG6PZ
ANEcXqqP1k9YYaqEDHleBNg/6ls+t4qFemVO9mhF5NjTNvxLCRYdldK2H+MNxdua
aD4O5f1HCCqVEtGxDaejNTLgbE2vJA==
=dRLs
-----END PGP SIGNATURE-----

--jvVlmhcp7cUHL8p1XvQEu8e63pbwj1G79--
