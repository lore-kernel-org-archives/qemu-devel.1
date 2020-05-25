Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB80AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 05:09:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9205B2075F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 05:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GHo67Yhn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9205B2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd5Mm-0004yY-RO
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 01:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jd5LJ-00031y-W2; Mon, 25 May 2020 01:08:06 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33271 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jd5LI-00047g-31; Mon, 25 May 2020 01:08:05 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49VlTl07SXz9sSx; Mon, 25 May 2020 15:07:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1590383275;
 bh=/bQ/EMPthSOxtGzy68UC0DYKSqD6F2AiBpfo9nE5SZQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GHo67Yhnv5MIZzNb9fuL76uq7F4xN3bG+2/dJYw6ut4czG6baAxY6C/wD6WRrgqrN
 JfCWBJnso2zO0FjaAp9h3RF29WwIQZNaffgHjutLLUSImpED2r7sP2DZ4CKAAeJoSo
 90S+aUinqFMcX9kNpNg+CCFOG7rkVBJvs/if51UQ=
Date: Mon, 25 May 2020 15:07:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH] hw/nvram/mac_nvram: Convert debug printf()s to trace
 events
Message-ID: <20200525050747.GD23110@umbus.fritz.box>
References: <20200524165126.13920-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hxkXGo8AKqTJ+9QI"
Content-Disposition: inline
In-Reply-To: <20200524165126.13920-1-f4bug@amsat.org>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 01:07:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--hxkXGo8AKqTJ+9QI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2020 at 06:51:26PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Convert NVR_DPRINTF() to trace events and remove ifdef'ry.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Applied to ppc-for-5.1, thanks.

> ---
>  hw/nvram/mac_nvram.c  | 17 +++--------------
>  hw/nvram/trace-events |  4 ++++
>  2 files changed, 7 insertions(+), 14 deletions(-)
>=20
> diff --git a/hw/nvram/mac_nvram.c b/hw/nvram/mac_nvram.c
> index ff5db03e6b..beec1c4e4d 100644
> --- a/hw/nvram/mac_nvram.c
> +++ b/hw/nvram/mac_nvram.c
> @@ -30,18 +30,9 @@
>  #include "migration/vmstate.h"
>  #include "qemu/cutils.h"
>  #include "qemu/module.h"
> +#include "trace.h"
>  #include <zlib.h>
> =20
> -/* debug NVR */
> -//#define DEBUG_NVR
> -
> -#ifdef DEBUG_NVR
> -#define NVR_DPRINTF(fmt, ...)                                   \
> -    do { printf("NVR: " fmt , ## __VA_ARGS__); } while (0)
> -#else
> -#define NVR_DPRINTF(fmt, ...)
> -#endif
> -
>  #define DEF_SYSTEM_SIZE 0xc10
> =20
>  /* macio style NVRAM device */
> @@ -51,9 +42,8 @@ static void macio_nvram_writeb(void *opaque, hwaddr add=
r,
>      MacIONVRAMState *s =3D opaque;
> =20
>      addr =3D (addr >> s->it_shift) & (s->size - 1);
> +    trace_macio_nvram_write(addr, value);
>      s->data[addr] =3D value;
> -    NVR_DPRINTF("writeb addr %04" HWADDR_PRIx " val %" PRIx64 "\n",
> -                addr, value);
>  }
> =20
>  static uint64_t macio_nvram_readb(void *opaque, hwaddr addr,
> @@ -64,8 +54,7 @@ static uint64_t macio_nvram_readb(void *opaque, hwaddr =
addr,
> =20
>      addr =3D (addr >> s->it_shift) & (s->size - 1);
>      value =3D s->data[addr];
> -    NVR_DPRINTF("readb addr %04" HWADDR_PRIx " val %" PRIx32 "\n",
> -                addr, value);
> +    trace_macio_nvram_read(addr, value);
> =20
>      return value;
>  }
> diff --git a/hw/nvram/trace-events b/hw/nvram/trace-events
> index 0dea9260ce..e023193295 100644
> --- a/hw/nvram/trace-events
> +++ b/hw/nvram/trace-events
> @@ -13,3 +13,7 @@ fw_cfg_add_string(uint16_t key_value, const char *key_n=
ame, const char *value) "
>  fw_cfg_add_i16(uint16_t key_value, const char *key_name, uint16_t value)=
 "key 0x%04" PRIx16 " '%s', value 0x%" PRIx16
>  fw_cfg_add_i32(uint16_t key_value, const char *key_name, uint32_t value)=
 "key 0x%04" PRIx16 " '%s', value 0x%" PRIx32
>  fw_cfg_add_i64(uint16_t key_value, const char *key_name, uint64_t value)=
 "key 0x%04" PRIx16 " '%s', value 0x%" PRIx64
> +
> +# mac_nvram.c
> +macio_nvram_read(uint32_t addr, uint8_t val) "read addr=3D0x%04"PRIx32" =
val=3D0x%02x"
> +macio_nvram_write(uint32_t addr, uint8_t val) "write addr=3D0x%04"PRIx32=
" val=3D0x%02x"

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hxkXGo8AKqTJ+9QI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7LUqMACgkQbDjKyiDZ
s5ILbBAArevA+vueEYNUYrjH3U5CYBs/frum5fEekewYFQggMlh/Mbu2VkwHq5Af
8AEa8oO7xe1ckKeKheTi9pphheRpZjm5ajybjcduBvewAmqkszh4gAZ2qxiU7EKM
kL8Ad16DdrQ5Jlgv5w25mvSkooFf6BRBpaBfpCp0yXg8X/l+h7jiWnbD2MnraY+f
oC9w8ylY2suKiIWt5icWL6atdptZE7mYTLG594q69E3xaKoy33MR+4i9b/cOld/J
JcQw1s7fllpSlfkZpZ2cDmgiSkC3pNus/NW55KbwcXAMqscMDSJid08U9JGNM3kY
vtr9GNVelTkILi/yOlVAlwa3j/Vt5We70gcVyIzWM8CJoA8TsxVCzG1VTuwcKt6z
X0ujUOa9zqmiX2Qakh60b52HbNlYh0CUiWXaSITk9+Vm4qNVdjERX/Bzqzns/yFu
kVQlNvgerkqkhr0IH7Ao/hs9WtGXsog3xrcq8mPNB9eObQCRaeRm9e5p25RS8yfv
hrXaH1WPX5l5HKmXENF3O/O1xmbGf2hRIZTZBDITyH+SKq9p9/uidNYL/u03Zdws
DZIEZzsYqQ/DBEPYnnFvy3yZBp2ArlV4YgaRLhyp81Hb8SoXVGYWnu3F8OipEaM8
wMcruQvmXAKLnU9+Ja1pPOEePgk1xPQEyLNBkTWeVXeLvKMXBnM=
=C4uW
-----END PGP SIGNATURE-----

--hxkXGo8AKqTJ+9QI--

