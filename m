Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25C2C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 01:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DAEE20709
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 01:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="CSuu+45t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DAEE20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ie7UM-0000nW-H2
	for qemu-devel@archiver.kernel.org; Sun, 08 Dec 2019 20:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ie7QV-0007n6-5A
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 20:01:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ie7QT-0007Oh-5y
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 20:01:27 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:35441 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1ie7QS-0007Ip-2w
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 20:01:25 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47WPyg2SkLz9sR0; Mon,  9 Dec 2019 12:01:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1575853275;
 bh=nHawHCZzDLBjHH6Ss6qkky8r9eIdQL9+flLYWh+9GZU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CSuu+45tnaMOsKyw1MO9VU4zdsP8WtZKlB7IY+JuqrpNotm8pYF/BveA9cwNOqm6d
 ljhLFZ0vVssQYgbYNeDqzZaOK40MnM7YBoBGeHllMEuP/cLnn1+i5dfeMMMCms4a40
 zZzL0XEnWSJBKDVmL0RcH71UFQY8Q0VYDDcRXGz8=
Date: Mon, 9 Dec 2019 11:51:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [for-5.0 PATCH 1/3] cpu: Introduce CPUReset callback typedef
Message-ID: <20191209005109.GB2482@umbus.fritz.box>
References: <157565782864.3897844.627720481210693346.stgit@bahia.lan>
 <157565783446.3897844.13799667957070272380.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
In-Reply-To: <157565783446.3897844.13799667957070272380.stgit@bahia.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2019 at 07:43:54PM +0100, Greg Kurz wrote:
> Use it in include/hw/core/cpu.h and convert all targets to use it as
> well with:
>=20
> perl -pi \
>  -e 's/void\s+\(\*(parent_reset)\)\(CPUState\s+\*\w+\)/CPUReset \1/;' \
>  $(git ls-files 'target/*.h')
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

ppc parts
Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/core/cpu.h       |    4 +++-
>  target/alpha/cpu-qom.h      |    2 +-
>  target/arm/cpu-qom.h        |    2 +-
>  target/cris/cpu-qom.h       |    2 +-
>  target/hppa/cpu-qom.h       |    2 +-
>  target/i386/cpu-qom.h       |    2 +-
>  target/lm32/cpu-qom.h       |    2 +-
>  target/m68k/cpu-qom.h       |    2 +-
>  target/microblaze/cpu-qom.h |    2 +-
>  target/mips/cpu-qom.h       |    2 +-
>  target/moxie/cpu.h          |    2 +-
>  target/nios2/cpu.h          |    2 +-
>  target/openrisc/cpu.h       |    2 +-
>  target/ppc/cpu-qom.h        |    2 +-
>  target/riscv/cpu.h          |    2 +-
>  target/s390x/cpu-qom.h      |    2 +-
>  target/sh4/cpu-qom.h        |    2 +-
>  target/sparc/cpu-qom.h      |    2 +-
>  target/tilegx/cpu.h         |    2 +-
>  target/tricore/cpu-qom.h    |    2 +-
>  target/xtensa/cpu-qom.h     |    2 +-
>  21 files changed, 23 insertions(+), 21 deletions(-)
>=20
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 77c6f0529903..047e3972ecaf 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -74,6 +74,8 @@ typedef struct CPUWatchpoint CPUWatchpoint;
> =20
>  struct TranslationBlock;
> =20
> +typedef void (*CPUReset)(CPUState *cpu);
> +
>  /**
>   * CPUClass:
>   * @class_by_name: Callback to map -cpu command line model name to an
> @@ -165,7 +167,7 @@ typedef struct CPUClass {
>      ObjectClass *(*class_by_name)(const char *cpu_model);
>      void (*parse_features)(const char *typename, char *str, Error **errp=
);
> =20
> -    void (*reset)(CPUState *cpu);
> +    CPUReset reset;
>      int reset_dump_flags;
>      bool (*has_work)(CPUState *cpu);
>      void (*do_interrupt)(CPUState *cpu);
> diff --git a/target/alpha/cpu-qom.h b/target/alpha/cpu-qom.h
> index 6f0a0adb9efa..0c974805481b 100644
> --- a/target/alpha/cpu-qom.h
> +++ b/target/alpha/cpu-qom.h
> @@ -44,7 +44,7 @@ typedef struct AlphaCPUClass {
>      /*< public >*/
> =20
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>  } AlphaCPUClass;
> =20
>  typedef struct AlphaCPU AlphaCPU;
> diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
> index 7f5b244bde35..aeaa84afcc9a 100644
> --- a/target/arm/cpu-qom.h
> +++ b/target/arm/cpu-qom.h
> @@ -51,7 +51,7 @@ typedef struct ARMCPUClass {
> =20
>      const ARMCPUInfo *info;
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>  } ARMCPUClass;
> =20
>  typedef struct ARMCPU ARMCPU;
> diff --git a/target/cris/cpu-qom.h b/target/cris/cpu-qom.h
> index 308c1f95bdf6..079ffe6bda0a 100644
> --- a/target/cris/cpu-qom.h
> +++ b/target/cris/cpu-qom.h
> @@ -45,7 +45,7 @@ typedef struct CRISCPUClass {
>      /*< public >*/
> =20
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
> =20
>      uint32_t vr;
>  } CRISCPUClass;
> diff --git a/target/hppa/cpu-qom.h b/target/hppa/cpu-qom.h
> index 6367dc479391..5c129de148a8 100644
> --- a/target/hppa/cpu-qom.h
> +++ b/target/hppa/cpu-qom.h
> @@ -44,7 +44,7 @@ typedef struct HPPACPUClass {
>      /*< public >*/
> =20
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>  } HPPACPUClass;
> =20
>  typedef struct HPPACPU HPPACPU;
> diff --git a/target/i386/cpu-qom.h b/target/i386/cpu-qom.h
> index 0efab2fc670f..1e962518e68e 100644
> --- a/target/i386/cpu-qom.h
> +++ b/target/i386/cpu-qom.h
> @@ -71,7 +71,7 @@ typedef struct X86CPUClass {
> =20
>      DeviceRealize parent_realize;
>      DeviceUnrealize parent_unrealize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>  } X86CPUClass;
> =20
>  typedef struct X86CPU X86CPU;
> diff --git a/target/lm32/cpu-qom.h b/target/lm32/cpu-qom.h
> index dc9ac9ac9f7b..e105a315aa3e 100644
> --- a/target/lm32/cpu-qom.h
> +++ b/target/lm32/cpu-qom.h
> @@ -44,7 +44,7 @@ typedef struct LM32CPUClass {
>      /*< public >*/
> =20
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>  } LM32CPUClass;
> =20
>  typedef struct LM32CPU LM32CPU;
> diff --git a/target/m68k/cpu-qom.h b/target/m68k/cpu-qom.h
> index b56da8a21374..0a196775e5d1 100644
> --- a/target/m68k/cpu-qom.h
> +++ b/target/m68k/cpu-qom.h
> @@ -44,7 +44,7 @@ typedef struct M68kCPUClass {
>      /*< public >*/
> =20
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>  } M68kCPUClass;
> =20
>  typedef struct M68kCPU M68kCPU;
> diff --git a/target/microblaze/cpu-qom.h b/target/microblaze/cpu-qom.h
> index 49b07cc697b9..7a4ff4a11e33 100644
> --- a/target/microblaze/cpu-qom.h
> +++ b/target/microblaze/cpu-qom.h
> @@ -44,7 +44,7 @@ typedef struct MicroBlazeCPUClass {
>      /*< public >*/
> =20
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>  } MicroBlazeCPUClass;
> =20
>  typedef struct MicroBlazeCPU MicroBlazeCPU;
> diff --git a/target/mips/cpu-qom.h b/target/mips/cpu-qom.h
> index a430c0fe4bbf..818401a501cb 100644
> --- a/target/mips/cpu-qom.h
> +++ b/target/mips/cpu-qom.h
> @@ -48,7 +48,7 @@ typedef struct MIPSCPUClass {
>      /*< public >*/
> =20
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>      const struct mips_def_t *cpu_def;
>  } MIPSCPUClass;
> =20
> diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
> index 01dca548e5d5..20dafc80f6ac 100644
> --- a/target/moxie/cpu.h
> +++ b/target/moxie/cpu.h
> @@ -69,7 +69,7 @@ typedef struct MoxieCPUClass {
>      /*< public >*/
> =20
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>  } MoxieCPUClass;
> =20
>  /**
> diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
> index 361b06ffeb61..59a07a5d0ee0 100644
> --- a/target/nios2/cpu.h
> +++ b/target/nios2/cpu.h
> @@ -50,7 +50,7 @@ typedef struct Nios2CPUClass {
>      /*< public >*/
> =20
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>  } Nios2CPUClass;
> =20
>  #define TARGET_HAS_ICE 1
> diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
> index 0ad02eab7946..d77976ccce7f 100644
> --- a/target/openrisc/cpu.h
> +++ b/target/openrisc/cpu.h
> @@ -48,7 +48,7 @@ typedef struct OpenRISCCPUClass {
>      /*< public >*/
> =20
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>  } OpenRISCCPUClass;
> =20
>  #define TARGET_INSN_START_EXTRA_WORDS 1
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index e499575dc873..9a20e5a1bfea 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -166,7 +166,7 @@ typedef struct PowerPCCPUClass {
> =20
>      DeviceRealize parent_realize;
>      DeviceUnrealize parent_unrealize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>      void (*parent_parse_features)(const char *type, char *str, Error **e=
rrp);
> =20
>      uint32_t pvr;
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index e59343e13c02..2246f95b3f33 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -185,7 +185,7 @@ typedef struct RISCVCPUClass {
>      CPUClass parent_class;
>      /*< public >*/
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>  } RISCVCPUClass;
> =20
>  /**
> diff --git a/target/s390x/cpu-qom.h b/target/s390x/cpu-qom.h
> index b809ec8418e0..cc23edc92198 100644
> --- a/target/s390x/cpu-qom.h
> +++ b/target/s390x/cpu-qom.h
> @@ -55,7 +55,7 @@ typedef struct S390CPUClass {
>      const char *desc;
> =20
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>      void (*load_normal)(CPUState *cpu);
>      void (*cpu_reset)(CPUState *cpu);
>      void (*initial_cpu_reset)(CPUState *cpu);
> diff --git a/target/sh4/cpu-qom.h b/target/sh4/cpu-qom.h
> index 0c56d055bada..35732a367427 100644
> --- a/target/sh4/cpu-qom.h
> +++ b/target/sh4/cpu-qom.h
> @@ -51,7 +51,7 @@ typedef struct SuperHCPUClass {
>      /*< public >*/
> =20
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
> =20
>      uint32_t pvr;
>      uint32_t prr;
> diff --git a/target/sparc/cpu-qom.h b/target/sparc/cpu-qom.h
> index 7442e2768e88..93165bd24f1c 100644
> --- a/target/sparc/cpu-qom.h
> +++ b/target/sparc/cpu-qom.h
> @@ -49,7 +49,7 @@ typedef struct SPARCCPUClass {
>      /*< public >*/
> =20
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>      sparc_def_t *cpu_def;
>  } SPARCCPUClass;
> =20
> diff --git a/target/tilegx/cpu.h b/target/tilegx/cpu.h
> index 9cbec247d238..68bd509898d4 100644
> --- a/target/tilegx/cpu.h
> +++ b/target/tilegx/cpu.h
> @@ -118,7 +118,7 @@ typedef struct TileGXCPUClass {
>      /*< public >*/
> =20
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>  } TileGXCPUClass;
> =20
>  /**
> diff --git a/target/tricore/cpu-qom.h b/target/tricore/cpu-qom.h
> index 7c1e130b4ede..f613452b00e0 100644
> --- a/target/tricore/cpu-qom.h
> +++ b/target/tricore/cpu-qom.h
> @@ -36,7 +36,7 @@ typedef struct TriCoreCPUClass {
>      /*< public >*/
> =20
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
>  } TriCoreCPUClass;
> =20
>  typedef struct TriCoreCPU TriCoreCPU;
> diff --git a/target/xtensa/cpu-qom.h b/target/xtensa/cpu-qom.h
> index 9ac54241bd69..685d7b8d823a 100644
> --- a/target/xtensa/cpu-qom.h
> +++ b/target/xtensa/cpu-qom.h
> @@ -56,7 +56,7 @@ typedef struct XtensaCPUClass {
>      /*< public >*/
> =20
>      DeviceRealize parent_realize;
> -    void (*parent_reset)(CPUState *cpu);
> +    CPUReset parent_reset;
> =20
>      const XtensaConfig *config;
>  } XtensaCPUClass;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3tmnsACgkQbDjKyiDZ
s5IEjRAAouRuJLkw+MUx7rrWOvkMEZQaqibWyGtZP4D0Ayg8UjPqsNxyS8xkk2f5
0XRESOM70KSpaFmLic0KpOpeY4gzcDgcaC6LANebIXsZ2sQp0y7U38I406cb5jRn
nzBympjbscHVs2pfgbjLtA57J3ICMjyNmKw9Gfub2jsTGk59KU6qD94jvbEMyuUf
A2Hfr0JfFxUxnzuLFQrVDf7l3lSgetPthHcWNjbmZya2QHy9ZbfaliJOvAl0OVBE
qPhVeF1EB2M1XoFDnw+epxtiaxPq2W8JFtlXqkbQPrHYqawyG7z4IQa2F2Jxmipq
Oc0SPECJj5jTwtj/bye1kPmaqNr+FSv6j+M8dtRiHU0c+/TRkNS/C8W8xP2LxpeB
LpAxIFL4sABpUq/2I/+irHGDOrYSXcaG1TWIfIHLM7DPgBVEfs0h2kNtLjovmoKG
yVO3RlqfFOBMj+9/TPR8HmD5pAmgr6FFDkFtRcu2ho6oqE5ba3C5wROD/fyO0gjr
XR5SsWJIcWPBc5F81TTPUrFDF+hGgFeylUoFCQeHAJN9+K2dGsbpAYU+4ffKn4i4
eXk85zibZDF3WJNMxWEqCLJLKrSLM7beczil+mFoJBWzWA50yyDmrUrkntiWz0q7
6uP+eKvDxD1/TyQG521fFMERIQ1h0AwlkegQp6rzvYL8aGuPeLE=
=AdV4
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--

