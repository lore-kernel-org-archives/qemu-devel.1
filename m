Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEDBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 04:03:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50E6B20715
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 04:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="IFD3YCB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E6B20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6QwE-0004iW-Hu
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 00:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6Qtj-0002IV-2t; Fri, 14 Aug 2020 00:00:55 -0400
Received: from ozlabs.org ([203.11.71.1]:35065)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6Qte-0001Q4-FU; Fri, 14 Aug 2020 00:00:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BSV8l69kSz9sTK; Fri, 14 Aug 2020 14:00:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597377639;
 bh=NptKj65iWj0wRwvDcWYwM5fh9/BRyf40l8+1PXl3oTE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IFD3YCB+Gsd5BTyxDP37eYSrv3CbsMRuKvE19Idwtw3n6NWK9+nYFE6ggjj6d++QH
 R5HxwiSPq5/76DhKyKY9723TRLUlIYazZEkkiLjm+woi3M6CS1IuBet+hpRsfaIrRH
 4M2XKFVrutdj5q2A97g2qWlBStSBCZbzicJwHx+k=
Date: Fri, 14 Aug 2020 13:34:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2] nvram: Exit QEMU if NVRAM cannot contain all
 -prom-env data
Message-ID: <20200814033447.GC12805@yekko.fritz.box>
References: <159736033937.350502.12402444542194031035.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sHrvAb52M6C8blB9"
Content-Disposition: inline
In-Reply-To: <159736033937.350502.12402444542194031035.stgit@bahia.lan>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 00:00:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--sHrvAb52M6C8blB9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2020 at 01:12:19AM +0200, Greg Kurz wrote:
> Since commit 61f20b9dc5b7 ("spapr_nvram: Pre-initialize the NVRAM to
> support the -prom-env parameter"), pseries machines can pre-initialize
> the "system" partition in the NVRAM with the data passed to all -prom-env
> parameters on the QEMU command line.
>=20
> In this case it is assumed that all the data fits in 64 KiB, but the user
> can easily pass more and crash QEMU:
>=20
> $ qemu-system-ppc64 -M pseries $(for ((x=3D0;x<128;x++)); do \
>   echo -n " -prom-env " ; printf "%0.sx" {1..1024}; \
>   done) # this requires ~128 Kib
> malloc(): corrupted top size
> Aborted (core dumped)
>=20
> This happens because we don't check if all the prom-env data fits in
> the NVRAM and chrp_nvram_set_var() happily memcpy() it passed the
> buffer.
>=20
> This crash affects basically all ppc/ppc64 machine types that use -prom-e=
nv:
> - pseries (all versions)
> - g3beige
> - mac99
>=20
> and also sparc/sparc64 machine types:
> - LX
> - SPARCClassic
> - SPARCbook
> - SS-10
> - SS-20
> - SS-4
> - SS-5
> - SS-600MP
> - Voyager
> - sun4u
> - sun4v
>=20
> Add a max_len argument to chrp_nvram_create_system_partition() so that
> it can check the available size before writing to memory.
>=20
> Since NVRAM is populated at machine init, it seems reasonable to consider
> this error as fatal. So, instead of reporting an error when we detect that
> the NVRAM is too small and adapt all machine types to handle it, we simply
> exit QEMU in all cases. This is still better than crashing. If someone
> wants another behavior, I guess this can be reworked later.
>=20
> Tested with:
>=20
> $ yes q | \
>   (for arch in ppc ppc64 sparc sparc64; do \
>        echo =3D=3D $arch =3D=3D; \
>        qemu=3D${arch}-softmmu/qemu-system-$arch; \
>        for mach in $($qemu -M help | awk '! /^Supported/ { print $1 }'); =
do \
>            echo $mach; \
>            $qemu -M $mach -monitor stdio -nodefaults -nographic \
>            $(for ((x=3D0;x<128;x++)); do \
>                  echo -n " -prom-env " ; printf "%0.sx" {1..1024}; \
>              done) >/dev/null; \
>         done; echo; \
>    done)
>=20
> Without the patch, affected machine types cause QEMU to report some
> memory corruption and crash:
>=20
> malloc(): corrupted top size
>=20
> free(): invalid size
>=20
> *** stack smashing detected ***: terminated
>=20
> With the patch, QEMU prints the following message and exits:
>=20
> NVRAM is too small. Try to pass less data to -prom-env
>=20
> It seems that the conditions for the crash have always existed, but it
> affects pseries, the machine type I care for, since commit 61f20b9dc5b7
> only.
>=20
> Fixes: 61f20b9dc5b7 ("spapr_nvram: Pre-initialize the NVRAM to support th=
e -prom-env parameter")
> RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=3D1867739
> Reported-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-5.2, thanks.

> ---
> v2: - fixed system partition size for sparc/sparc64 (Laurent)
> ---
>  hw/nvram/chrp_nvram.c         |   24 +++++++++++++++++++++---
>  hw/nvram/mac_nvram.c          |    2 +-
>  hw/nvram/spapr_nvram.c        |    3 ++-
>  hw/sparc/sun4m.c              |    2 +-
>  hw/sparc64/sun4u.c            |    2 +-
>  include/hw/nvram/chrp_nvram.h |    3 ++-
>  6 files changed, 28 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/nvram/chrp_nvram.c b/hw/nvram/chrp_nvram.c
> index d969f267048e..d4d10a7c03c7 100644
> --- a/hw/nvram/chrp_nvram.c
> +++ b/hw/nvram/chrp_nvram.c
> @@ -21,14 +21,21 @@
> =20
>  #include "qemu/osdep.h"
>  #include "qemu/cutils.h"
> +#include "qemu/error-report.h"
>  #include "hw/nvram/chrp_nvram.h"
>  #include "sysemu/sysemu.h"
> =20
> -static int chrp_nvram_set_var(uint8_t *nvram, int addr, const char *str)
> +static int chrp_nvram_set_var(uint8_t *nvram, int addr, const char *str,
> +                              int max_len)
>  {
>      int len;
> =20
>      len =3D strlen(str) + 1;
> +
> +    if (max_len < len) {
> +        return -1;
> +    }
> +
>      memcpy(&nvram[addr], str, len);
> =20
>      return addr + len;
> @@ -38,19 +45,26 @@ static int chrp_nvram_set_var(uint8_t *nvram, int add=
r, const char *str)
>   * Create a "system partition", used for the Open Firmware
>   * environment variables.
>   */
> -int chrp_nvram_create_system_partition(uint8_t *data, int min_len)
> +int chrp_nvram_create_system_partition(uint8_t *data, int min_len, int m=
ax_len)
>  {
>      ChrpNvramPartHdr *part_header;
>      unsigned int i;
>      int end;
> =20
> +    if (max_len < sizeof(*part_header)) {
> +        goto fail;
> +    }
> +
>      part_header =3D (ChrpNvramPartHdr *)data;
>      part_header->signature =3D CHRP_NVPART_SYSTEM;
>      pstrcpy(part_header->name, sizeof(part_header->name), "system");
> =20
>      end =3D sizeof(ChrpNvramPartHdr);
>      for (i =3D 0; i < nb_prom_envs; i++) {
> -        end =3D chrp_nvram_set_var(data, end, prom_envs[i]);
> +        end =3D chrp_nvram_set_var(data, end, prom_envs[i], max_len - en=
d);
> +        if (end =3D=3D -1) {
> +            goto fail;
> +        }
>      }
> =20
>      /* End marker */
> @@ -65,6 +79,10 @@ int chrp_nvram_create_system_partition(uint8_t *data, =
int min_len)
>      chrp_nvram_finish_partition(part_header, end);
> =20
>      return end;
> +
> +fail:
> +    error_report("NVRAM is too small. Try to pass less data to -prom-env=
");
> +    exit(EXIT_FAILURE);
>  }
> =20
>  /**
> diff --git a/hw/nvram/mac_nvram.c b/hw/nvram/mac_nvram.c
> index beec1c4e4d11..11f2d31cdb20 100644
> --- a/hw/nvram/mac_nvram.c
> +++ b/hw/nvram/mac_nvram.c
> @@ -141,7 +141,7 @@ static void pmac_format_nvram_partition_of(MacIONVRAM=
State *nvr, int off,
> =20
>      /* OpenBIOS nvram variables partition */
>      sysp_end =3D chrp_nvram_create_system_partition(&nvr->data[off],
> -                                                  DEF_SYSTEM_SIZE) + off;
> +                                                  DEF_SYSTEM_SIZE, len) =
+ off;
> =20
>      /* Free space partition */
>      chrp_nvram_create_free_partition(&nvr->data[sysp_end], len - sysp_en=
d);
> diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
> index 15d08281d411..386513499f59 100644
> --- a/hw/nvram/spapr_nvram.c
> +++ b/hw/nvram/spapr_nvram.c
> @@ -188,7 +188,8 @@ static void spapr_nvram_realize(SpaprVioDevice *dev, =
Error **errp)
>          }
>      } else if (nb_prom_envs > 0) {
>          /* Create a system partition to pass the -prom-env variables */
> -        chrp_nvram_create_system_partition(nvram->buf, MIN_NVRAM_SIZE / =
4);
> +        chrp_nvram_create_system_partition(nvram->buf, MIN_NVRAM_SIZE / =
4,
> +                                           nvram->size);
>          chrp_nvram_create_free_partition(&nvram->buf[MIN_NVRAM_SIZE / 4],
>                                           nvram->size - MIN_NVRAM_SIZE / =
4);
>      }
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 9be930415f8e..cf7dfa4af5de 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -143,7 +143,7 @@ static void nvram_init(Nvram *nvram, uint8_t *macaddr,
>      memset(image, '\0', sizeof(image));
> =20
>      /* OpenBIOS nvram variables partition */
> -    sysp_end =3D chrp_nvram_create_system_partition(image, 0);
> +    sysp_end =3D chrp_nvram_create_system_partition(image, 0, 0x1fd0);
> =20
>      /* Free space partition */
>      chrp_nvram_create_free_partition(&image[sysp_end], 0x1fd0 - sysp_end=
);
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 9e30203dcc44..37310b73e6c2 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -136,7 +136,7 @@ static int sun4u_NVRAM_set_params(Nvram *nvram, uint1=
6_t NVRAM_size,
>      memset(image, '\0', sizeof(image));
> =20
>      /* OpenBIOS nvram variables partition */
> -    sysp_end =3D chrp_nvram_create_system_partition(image, 0);
> +    sysp_end =3D chrp_nvram_create_system_partition(image, 0, 0x1fd0);
> =20
>      /* Free space partition */
>      chrp_nvram_create_free_partition(&image[sysp_end], 0x1fd0 - sysp_end=
);
> diff --git a/include/hw/nvram/chrp_nvram.h b/include/hw/nvram/chrp_nvram.h
> index 09941a9be454..4a0f5c21b884 100644
> --- a/include/hw/nvram/chrp_nvram.h
> +++ b/include/hw/nvram/chrp_nvram.h
> @@ -50,7 +50,8 @@ chrp_nvram_finish_partition(ChrpNvramPartHdr *header, u=
int32_t size)
>      header->checksum =3D sum & 0xff;
>  }
> =20
> -int chrp_nvram_create_system_partition(uint8_t *data, int min_len);
> +/* chrp_nvram_create_system_partition() failure is fatal */
> +int chrp_nvram_create_system_partition(uint8_t *data, int min_len, int m=
ax_len);
>  int chrp_nvram_create_free_partition(uint8_t *data, int len);
> =20
>  #endif
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sHrvAb52M6C8blB9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl82BlcACgkQbDjKyiDZ
s5I5MQ//bb0F9ohImui3DXXW5EDtcexvkdLkEKf2ALHr+DJsmqI79TZbyyyiXuNp
5uln17OhBVwJq9dDzbfwt+2G8TfKPWkKuOIvV0s7pS6M/zpO1MI+eZE0UQykvhKJ
ZboHdWp9tp1ntRU67EHH3Bvv62j/cWFHtWmRo2HPkMDfEQpK+OdGpDkLoENSYzJi
geKzgkweTZAJCLA6eZ61fOAusK0sa/dGxShl1ZXmfOgzs1NaTbIhwkoGnM0M7OfR
RSm01cBvnSMO20Aw36ryC9ea4yFiVm/cNySR4HHGRaVP6zzUYHm/gORB3tl0uqNo
f6M8TZ2vPYX8+z70alWsNMA1IUCjIUwEsZrsYooNntHAh7ZjobZnPWJbE/2xz6ms
bNRk9JXJ68vsc/Cm8weNOqhaTi8t/T1GDiEcIiFJZ+VsL/HkqLqUqSDf6cx3Gu9D
4whF8Vrd/u/YyzeVfVnFq/0pGwloStKf9svXLVGwCgjKn3BHpBXbG/KR3ZG/tqUR
scRYI9sUyWdzT58SgAk8lO2DZpDvo+AQbMbfiKSOJcIlP1EcbAIkto/4XKElgBKP
U7Zru0hNVWuYtWdDOKju1rBAibavJnQh+dut0lcykmPh+yYiuqkjNHJ5iI0wNlaR
LAE/hcFA5drnh+XSIT8lABVrP/dgwbSZL2fMrBbLN0Yyl29ROIw=
=LU5C
-----END PGP SIGNATURE-----

--sHrvAb52M6C8blB9--

