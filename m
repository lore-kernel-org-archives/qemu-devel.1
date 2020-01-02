Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB39C2D0DE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 02:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCCCF24653
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 02:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="mxgDvtPQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCCCF24653
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imppO-00047y-Un
	for qemu-devel@archiver.kernel.org; Wed, 01 Jan 2020 21:03:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1impoX-0003I0-G6
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 21:02:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1impoV-0001QW-PB
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 21:02:17 -0500
Received: from ozlabs.org ([203.11.71.1]:49775)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1impoQ-0000Zb-Nc; Wed, 01 Jan 2020 21:02:11 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47pB9h5TDtz9sPW; Thu,  2 Jan 2020 13:02:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1577930520;
 bh=HPM5Vh+tpYJbZd9Q2oxyabGJjmW597vE4NhBqlukHnU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mxgDvtPQMS/c+WOwEGgIXGIP2ffLGXnwSAK2YS9hdWApVVmXjz4DgbjG+GDMDBOZM
 H1jMWiCw9jN0w+Y1rnnXNn4DxrS/UYjYKi+D8dNxZeWuzteF/vIrPnc7UR5YGo6G2C
 wtJYi9HDZa0dkdWpC1+ZbdGvEDytRsJuyZ44Pn90=
Date: Thu, 2 Jan 2020 12:44:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 2/4] tcg: Search includes in the parent source directory
Message-ID: <20200102014419.GB2098@umbus>
References: <20200101112303.20724-1-philmd@redhat.com>
 <20200101112303.20724-3-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline
In-Reply-To: <20200101112303.20724-3-philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>, Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Stafford Horne <shorne@gmail.com>,
 Richard Henderson <rth@twiddle.net>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>,
 Claudio Fontana <claudio.fontana@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 01, 2020 at 12:23:01PM +0100, Philippe Mathieu-Daud=E9 wrote:
> All the *.inc.c files included by tcg/$TARGET/tcg-target.inc.c
> are in tcg/, their parent directory. To simplify the preprocessor
> search path, include the relative parent path: '..'.
>=20
> Patch created mechanically by running:
>=20
>   $ for x in tcg-pool.inc.c tcg-ldst.inc.c; do \
>     sed -i "s,#include \"$x\",#include \"../$x\"," \
>       $(git grep -l "#include \"$x\""); \
>     done
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

ppc parts
Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  tcg/aarch64/tcg-target.inc.c | 4 ++--
>  tcg/arm/tcg-target.inc.c     | 4 ++--
>  tcg/i386/tcg-target.inc.c    | 4 ++--
>  tcg/mips/tcg-target.inc.c    | 2 +-
>  tcg/ppc/tcg-target.inc.c     | 4 ++--
>  tcg/riscv/tcg-target.inc.c   | 4 ++--
>  tcg/s390/tcg-target.inc.c    | 4 ++--
>  tcg/sparc/tcg-target.inc.c   | 2 +-
>  8 files changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
> index 3f921015d3..843fd0ca69 100644
> --- a/tcg/aarch64/tcg-target.inc.c
> +++ b/tcg/aarch64/tcg-target.inc.c
> @@ -10,7 +10,7 @@
>   * See the COPYING file in the top-level directory for details.
>   */
> =20
> -#include "tcg-pool.inc.c"
> +#include "../tcg-pool.inc.c"
>  #include "qemu/bitops.h"
> =20
>  /* We're going to re-use TCGType in setting of the SF bit, which controls
> @@ -1541,7 +1541,7 @@ static void tcg_out_cltz(TCGContext *s, TCGType ext=
, TCGReg d,
>  }
> =20
>  #ifdef CONFIG_SOFTMMU
> -#include "tcg-ldst.inc.c"
> +#include "../tcg-ldst.inc.c"
> =20
>  /* helper signature: helper_ret_ld_mmu(CPUState *env, target_ulong addr,
>   *                                     TCGMemOpIdx oi, uintptr_t ra)
> diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
> index 94d80d79d1..fffb6611e2 100644
> --- a/tcg/arm/tcg-target.inc.c
> +++ b/tcg/arm/tcg-target.inc.c
> @@ -23,7 +23,7 @@
>   */
> =20
>  #include "elf.h"
> -#include "tcg-pool.inc.c"
> +#include "../tcg-pool.inc.c"
> =20
>  int arm_arch =3D __ARM_ARCH;
> =20
> @@ -1131,7 +1131,7 @@ static TCGCond tcg_out_cmp2(TCGContext *s, const TC=
GArg *args,
>  }
> =20
>  #ifdef CONFIG_SOFTMMU
> -#include "tcg-ldst.inc.c"
> +#include "../tcg-ldst.inc.c"
> =20
>  /* helper signature: helper_ret_ld_mmu(CPUState *env, target_ulong addr,
>   *                                     int mmu_idx, uintptr_t ra)
> diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
> index 9d8ed974e0..cdedcb2b25 100644
> --- a/tcg/i386/tcg-target.inc.c
> +++ b/tcg/i386/tcg-target.inc.c
> @@ -22,7 +22,7 @@
>   * THE SOFTWARE.
>   */
> =20
> -#include "tcg-pool.inc.c"
> +#include "../tcg-pool.inc.c"
> =20
>  #ifdef CONFIG_DEBUG_TCG
>  static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] =3D {
> @@ -1647,7 +1647,7 @@ static void tcg_out_nopn(TCGContext *s, int n)
>  }
> =20
>  #if defined(CONFIG_SOFTMMU)
> -#include "tcg-ldst.inc.c"
> +#include "../tcg-ldst.inc.c"
> =20
>  /* helper signature: helper_ret_ld_mmu(CPUState *env, target_ulong addr,
>   *                                     int mmu_idx, uintptr_t ra)
> diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
> index 5442167045..1da663ce84 100644
> --- a/tcg/mips/tcg-target.inc.c
> +++ b/tcg/mips/tcg-target.inc.c
> @@ -1107,7 +1107,7 @@ static void tcg_out_call(TCGContext *s, tcg_insn_un=
it *arg)
>  }
> =20
>  #if defined(CONFIG_SOFTMMU)
> -#include "tcg-ldst.inc.c"
> +#include "../tcg-ldst.inc.c"
> =20
>  static void * const qemu_ld_helpers[16] =3D {
>      [MO_UB]   =3D helper_ret_ldub_mmu,
> diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
> index d308d69aba..ee1f9227c1 100644
> --- a/tcg/ppc/tcg-target.inc.c
> +++ b/tcg/ppc/tcg-target.inc.c
> @@ -23,7 +23,7 @@
>   */
> =20
>  #include "elf.h"
> -#include "tcg-pool.inc.c"
> +#include "../tcg-pool.inc.c"
> =20
>  #if defined _CALL_DARWIN || defined __APPLE__
>  #define TCG_TARGET_CALL_DARWIN
> @@ -1845,7 +1845,7 @@ static const uint32_t qemu_exts_opc[4] =3D {
>  };
> =20
>  #if defined (CONFIG_SOFTMMU)
> -#include "tcg-ldst.inc.c"
> +#include "../tcg-ldst.inc.c"
> =20
>  /* helper signature: helper_ld_mmu(CPUState *env, target_ulong addr,
>   *                                 int mmu_idx, uintptr_t ra)
> diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
> index 7018509693..2bc0ba71f2 100644
> --- a/tcg/riscv/tcg-target.inc.c
> +++ b/tcg/riscv/tcg-target.inc.c
> @@ -27,7 +27,7 @@
>   * THE SOFTWARE.
>   */
> =20
> -#include "tcg-pool.inc.c"
> +#include "../tcg-pool.inc.c"
> =20
>  #ifdef CONFIG_DEBUG_TCG
>  static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] =3D {
> @@ -921,7 +921,7 @@ static void tcg_out_mb(TCGContext *s, TCGArg a0)
>   */
> =20
>  #if defined(CONFIG_SOFTMMU)
> -#include "tcg-ldst.inc.c"
> +#include "../tcg-ldst.inc.c"
> =20
>  /* helper signature: helper_ret_ld_mmu(CPUState *env, target_ulong addr,
>   *                                     TCGMemOpIdx oi, uintptr_t ra)
> diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
> index 8aaa4cebe8..b07e9ff7d6 100644
> --- a/tcg/s390/tcg-target.inc.c
> +++ b/tcg/s390/tcg-target.inc.c
> @@ -29,7 +29,7 @@
>  #error "unsupported code generation mode"
>  #endif
> =20
> -#include "tcg-pool.inc.c"
> +#include "../tcg-pool.inc.c"
>  #include "elf.h"
> =20
>  /* ??? The translation blocks produced by TCG are generally small enough=
 to
> @@ -1536,7 +1536,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, M=
emOp opc, TCGReg data,
>  }
> =20
>  #if defined(CONFIG_SOFTMMU)
> -#include "tcg-ldst.inc.c"
> +#include "../tcg-ldst.inc.c"
> =20
>  /* We're expecting to use a 20-bit negative offset on the tlb memory ops=
=2E  */
>  QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) > 0);
> diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
> index d7986cda5c..65fddb310d 100644
> --- a/tcg/sparc/tcg-target.inc.c
> +++ b/tcg/sparc/tcg-target.inc.c
> @@ -22,7 +22,7 @@
>   * THE SOFTWARE.
>   */
> =20
> -#include "tcg-pool.inc.c"
> +#include "../tcg-pool.inc.c"
> =20
>  #ifdef CONFIG_DEBUG_TCG
>  static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] =3D {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4NSvIACgkQbDjKyiDZ
s5KATA/5AcabIswOejZ2JbqWvu28jlG9o1t0ZX4usP0ZOABITylyMVWjjxdg+Old
SAiQMQL7qgBsIWiyWZZDJnuScJ6W/JcUAnDSH/dTiJ7yRp3V6w79MYeoedH+wzLg
j68PYRpcYdFj4egqlfWtqe4EPWdf+7KHalSy+ZYqj32hb9Cbgb4T2mqfEpCPJ3B/
heNBamLflMq7xQ2buewVZoYCcT/nyAHqQgm7Z9AbJG/62I9DFdqI95b2/n1zsvWw
GoyLwthpi4LZsuWQfKvD5ldkR+68blV/DkrvLexTo25vPHxdSXOJ4ABsYpbS7g2Y
hjvh+v8N2F4ABnfRV6uxZq26Peqrrm+Nbt8wBsz6HgW8nEXy6dp2sWFXj6xr2iXF
hadNNhOFM91027bIwidRpHQAMyxFrQcftHh2XNwbYIXRYGaoEWcChn+2UGl1xFCf
YYHJ2yCNKVNVodnzF1shndjpOmYPCfqotqhkegnDIM9cJWRddWuA/pqAX4wo2qVH
cAzJyAPplQpMIIWD2wANxmLzOSdJjO0jejnim8LcjbMgHbPJu+ckFTeaRyXeAo06
wVWBnn8UDbuo2YsK2IaHCRAUy7fx1GNeLyrpb8X8dYnnrQliw7u6Ls+YWQc+5++u
xZhFLg6hNxPe6KRwZcxq34tXx/IKb+HA+DsEzhe9fPYEYwqOqyY=
=XK1l
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--

