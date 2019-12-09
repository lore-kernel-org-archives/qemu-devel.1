Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0091CC3F68F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 01:05:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC1422070A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 01:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="OtgD0o/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1422070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ie7UM-0000pj-Ku
	for qemu-devel@archiver.kernel.org; Sun, 08 Dec 2019 20:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ie7QV-0007n7-BN
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 20:01:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ie7QT-0007P3-9I
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 20:01:27 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:55685 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1ie7QS-0007Io-2t
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 20:01:25 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47WPyg3JMLz9sPK; Mon,  9 Dec 2019 12:01:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1575853275;
 bh=3JOmfTneeQAuPZzC01REtE0YWyxM/qdYZUDCTq5d804=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OtgD0o/wSefa4mtZH9xe+7wHVEWql2bElzNz0CV5dIm3RC0PFYWKhZLLQqWHgLrSU
 LXF0dPGbhcsKbl7ghIi1rTqeZbvAayZtQZcytSDcZj17uRVEZbLFEpy8c2OuVCVCs+
 PX7fbnvvUZdjYgjTR7QuMVpYvBqwtkh9nKPnt9S8=
Date: Mon, 9 Dec 2019 11:51:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [for-5.0 PATCH 3/3] cpu: Use cpu_class_set_parent_reset()
Message-ID: <20191209005157.GD2482@umbus.fritz.box>
References: <157565782864.3897844.627720481210693346.stgit@bahia.lan>
 <157565784603.3897844.16391025294328116481.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PHCdUe6m4AxPMzOu"
Content-Disposition: inline
In-Reply-To: <157565784603.3897844.16391025294328116481.stgit@bahia.lan>
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


--PHCdUe6m4AxPMzOu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2019 at 07:44:06PM +0100, Greg Kurz wrote:
> Convert all targets to use cpu_class_set_parent_reset() with the following
> coccinelle script:
>=20
> @@
> type CPUParentClass;
> CPUParentClass *pcc;
> CPUClass *cc;
> identifier parent_fn;
> identifier child_fn;
> @@
> +cpu_class_set_parent_reset(cc, child_fn, &pcc->parent_fn);
> -pcc->parent_fn =3D cc->reset;
> ...
> -cc->reset =3D child_fn;
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

ppc parts
Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/arm/cpu.c                |    3 +--
>  target/cris/cpu.c               |    3 +--
>  target/i386/cpu.c               |    3 +--
>  target/lm32/cpu.c               |    3 +--
>  target/m68k/cpu.c               |    3 +--
>  target/microblaze/cpu.c         |    3 +--
>  target/mips/cpu.c               |    3 +--
>  target/moxie/cpu.c              |    3 +--
>  target/nios2/cpu.c              |    3 +--
>  target/openrisc/cpu.c           |    3 +--
>  target/ppc/translate_init.inc.c |    3 +--
>  target/riscv/cpu.c              |    3 +--
>  target/s390x/cpu.c              |    3 +--
>  target/sh4/cpu.c                |    3 +--
>  target/sparc/cpu.c              |    3 +--
>  target/tilegx/cpu.c             |    3 +--
>  target/tricore/cpu.c            |    3 +--
>  target/xtensa/cpu.c             |    3 +--
>  18 files changed, 18 insertions(+), 36 deletions(-)
>=20
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 7a4ac9339bf9..712a9425fdf5 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2625,8 +2625,7 @@ static void arm_cpu_class_init(ObjectClass *oc, voi=
d *data)
>                                      &acc->parent_realize);
>      dc->props =3D arm_cpu_properties;
> =20
> -    acc->parent_reset =3D cc->reset;
> -    cc->reset =3D arm_cpu_reset;
> +    cpu_class_set_parent_reset(cc, arm_cpu_reset, &acc->parent_reset);
> =20
>      cc->class_by_name =3D arm_cpu_class_by_name;
>      cc->has_work =3D arm_cpu_has_work;
> diff --git a/target/cris/cpu.c b/target/cris/cpu.c
> index 7adfd6caf4ed..486675e3822f 100644
> --- a/target/cris/cpu.c
> +++ b/target/cris/cpu.c
> @@ -256,8 +256,7 @@ static void cris_cpu_class_init(ObjectClass *oc, void=
 *data)
>      device_class_set_parent_realize(dc, cris_cpu_realizefn,
>                                      &ccc->parent_realize);
> =20
> -    ccc->parent_reset =3D cc->reset;
> -    cc->reset =3D cris_cpu_reset;
> +    cpu_class_set_parent_reset(cc, cris_cpu_reset, &ccc->parent_reset);
> =20
>      cc->class_by_name =3D cris_cpu_class_by_name;
>      cc->has_work =3D cris_cpu_has_work;
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 69f518a21a9b..57d36931725d 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7049,8 +7049,7 @@ static void x86_cpu_common_class_init(ObjectClass *=
oc, void *data)
>                                        &xcc->parent_unrealize);
>      dc->props =3D x86_cpu_properties;
> =20
> -    xcc->parent_reset =3D cc->reset;
> -    cc->reset =3D x86_cpu_reset;
> +    cpu_class_set_parent_reset(cc, x86_cpu_reset, &xcc->parent_reset);
>      cc->reset_dump_flags =3D CPU_DUMP_FPU | CPU_DUMP_CCOP;
> =20
>      cc->class_by_name =3D x86_cpu_class_by_name;
> diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
> index b35537de6285..687bf35e6588 100644
> --- a/target/lm32/cpu.c
> +++ b/target/lm32/cpu.c
> @@ -218,8 +218,7 @@ static void lm32_cpu_class_init(ObjectClass *oc, void=
 *data)
> =20
>      device_class_set_parent_realize(dc, lm32_cpu_realizefn,
>                                      &lcc->parent_realize);
> -    lcc->parent_reset =3D cc->reset;
> -    cc->reset =3D lm32_cpu_reset;
> +    cpu_class_set_parent_reset(cc, lm32_cpu_reset, &lcc->parent_reset);
> =20
>      cc->class_by_name =3D lm32_cpu_class_by_name;
>      cc->has_work =3D lm32_cpu_has_work;
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index e6596de29c2c..176d95e6fcfb 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -257,8 +257,7 @@ static void m68k_cpu_class_init(ObjectClass *c, void =
*data)
> =20
>      device_class_set_parent_realize(dc, m68k_cpu_realizefn,
>                                      &mcc->parent_realize);
> -    mcc->parent_reset =3D cc->reset;
> -    cc->reset =3D m68k_cpu_reset;
> +    cpu_class_set_parent_reset(cc, m68k_cpu_reset, &mcc->parent_reset);
> =20
>      cc->class_by_name =3D m68k_cpu_class_by_name;
>      cc->has_work =3D m68k_cpu_has_work;
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 9cfd7445e7da..71d88f603b2e 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -292,8 +292,7 @@ static void mb_cpu_class_init(ObjectClass *oc, void *=
data)
> =20
>      device_class_set_parent_realize(dc, mb_cpu_realizefn,
>                                      &mcc->parent_realize);
> -    mcc->parent_reset =3D cc->reset;
> -    cc->reset =3D mb_cpu_reset;
> +    cpu_class_set_parent_reset(cc, mb_cpu_reset, &mcc->parent_reset);
> =20
>      cc->class_by_name =3D mb_cpu_class_by_name;
>      cc->has_work =3D mb_cpu_has_work;
> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index bbcf7ca4635c..6cd6b9650baa 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -189,8 +189,7 @@ static void mips_cpu_class_init(ObjectClass *c, void =
*data)
> =20
>      device_class_set_parent_realize(dc, mips_cpu_realizefn,
>                                      &mcc->parent_realize);
> -    mcc->parent_reset =3D cc->reset;
> -    cc->reset =3D mips_cpu_reset;
> +    cpu_class_set_parent_reset(cc, mips_cpu_reset, &mcc->parent_reset);
> =20
>      cc->class_by_name =3D mips_cpu_class_by_name;
>      cc->has_work =3D mips_cpu_has_work;
> diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
> index 48996d0554f2..cf47bc709b54 100644
> --- a/target/moxie/cpu.c
> +++ b/target/moxie/cpu.c
> @@ -101,8 +101,7 @@ static void moxie_cpu_class_init(ObjectClass *oc, voi=
d *data)
> =20
>      device_class_set_parent_realize(dc, moxie_cpu_realizefn,
>                                      &mcc->parent_realize);
> -    mcc->parent_reset =3D cc->reset;
> -    cc->reset =3D moxie_cpu_reset;
> +    cpu_class_set_parent_reset(cc, moxie_cpu_reset, &mcc->parent_reset);
> =20
>      cc->class_by_name =3D moxie_cpu_class_by_name;
> =20
> diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
> index ca9c7a6df5d1..bbdbc0c6fbf0 100644
> --- a/target/nios2/cpu.c
> +++ b/target/nios2/cpu.c
> @@ -188,8 +188,7 @@ static void nios2_cpu_class_init(ObjectClass *oc, voi=
d *data)
>      device_class_set_parent_realize(dc, nios2_cpu_realizefn,
>                                      &ncc->parent_realize);
>      dc->props =3D nios2_properties;
> -    ncc->parent_reset =3D cc->reset;
> -    cc->reset =3D nios2_cpu_reset;
> +    cpu_class_set_parent_reset(cc, nios2_cpu_reset, &ncc->parent_reset);
> =20
>      cc->class_by_name =3D nios2_cpu_class_by_name;
>      cc->has_work =3D nios2_cpu_has_work;
> diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
> index 506aec6bfba5..5cd04dafab69 100644
> --- a/target/openrisc/cpu.c
> +++ b/target/openrisc/cpu.c
> @@ -150,8 +150,7 @@ static void openrisc_cpu_class_init(ObjectClass *oc, =
void *data)
> =20
>      device_class_set_parent_realize(dc, openrisc_cpu_realizefn,
>                                      &occ->parent_realize);
> -    occ->parent_reset =3D cc->reset;
> -    cc->reset =3D openrisc_cpu_reset;
> +    cpu_class_set_parent_reset(cc, openrisc_cpu_reset, &occ->parent_rese=
t);
> =20
>      cc->class_by_name =3D openrisc_cpu_class_by_name;
>      cc->has_work =3D openrisc_cpu_has_work;
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index ba726dec4d00..e5773a99fffd 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -10614,8 +10614,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, v=
oid *data)
>      pcc->interrupts_big_endian =3D ppc_cpu_interrupts_big_endian_always;
>      dc->props =3D ppc_cpu_properties;
> =20
> -    pcc->parent_reset =3D cc->reset;
> -    cc->reset =3D ppc_cpu_reset;
> +    cpu_class_set_parent_reset(cc, ppc_cpu_reset, &pcc->parent_reset);
> =20
>      cc->class_by_name =3D ppc_cpu_class_by_name;
>      pcc->parent_parse_features =3D cc->parse_features;
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d37861a4305b..d6f187272859 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -462,8 +462,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void=
 *data)
>      device_class_set_parent_realize(dc, riscv_cpu_realize,
>                                      &mcc->parent_realize);
> =20
> -    mcc->parent_reset =3D cc->reset;
> -    cc->reset =3D riscv_cpu_reset;
> +    cpu_class_set_parent_reset(cc, riscv_cpu_reset, &mcc->parent_reset);
> =20
>      cc->class_by_name =3D riscv_cpu_class_by_name;
>      cc->has_work =3D riscv_cpu_has_work;
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 3abe7e80fd0a..cf7cf5655fbc 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -469,13 +469,12 @@ static void s390_cpu_class_init(ObjectClass *oc, vo=
id *data)
>      dc->props =3D s390x_cpu_properties;
>      dc->user_creatable =3D true;
> =20
> -    scc->parent_reset =3D cc->reset;
> +    cpu_class_set_parent_reset(cc, s390_cpu_full_reset, &scc->parent_res=
et);
>  #if !defined(CONFIG_USER_ONLY)
>      scc->load_normal =3D s390_cpu_load_normal;
>  #endif
>      scc->cpu_reset =3D s390_cpu_reset;
>      scc->initial_cpu_reset =3D s390_cpu_initial_reset;
> -    cc->reset =3D s390_cpu_full_reset;
>      cc->class_by_name =3D s390_cpu_class_by_name,
>      cc->has_work =3D s390_cpu_has_work;
>  #ifdef CONFIG_TCG
> diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
> index d0a7707991fe..70c8d8170ff3 100644
> --- a/target/sh4/cpu.c
> +++ b/target/sh4/cpu.c
> @@ -214,8 +214,7 @@ static void superh_cpu_class_init(ObjectClass *oc, vo=
id *data)
>      device_class_set_parent_realize(dc, superh_cpu_realizefn,
>                                      &scc->parent_realize);
> =20
> -    scc->parent_reset =3D cc->reset;
> -    cc->reset =3D superh_cpu_reset;
> +    cpu_class_set_parent_reset(cc, superh_cpu_reset, &scc->parent_reset);
> =20
>      cc->class_by_name =3D superh_cpu_class_by_name;
>      cc->has_work =3D superh_cpu_has_work;
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index bc659295520f..9c306e52717e 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -859,8 +859,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, voi=
d *data)
>                                      &scc->parent_realize);
>      dc->props =3D sparc_cpu_properties;
> =20
> -    scc->parent_reset =3D cc->reset;
> -    cc->reset =3D sparc_cpu_reset;
> +    cpu_class_set_parent_reset(cc, sparc_cpu_reset, &scc->parent_reset);
> =20
>      cc->class_by_name =3D sparc_cpu_class_by_name;
>      cc->parse_features =3D sparc_cpu_parse_features;
> diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
> index 2b2a7ccc313f..cd422a0467a0 100644
> --- a/target/tilegx/cpu.c
> +++ b/target/tilegx/cpu.c
> @@ -142,8 +142,7 @@ static void tilegx_cpu_class_init(ObjectClass *oc, vo=
id *data)
>      device_class_set_parent_realize(dc, tilegx_cpu_realizefn,
>                                      &tcc->parent_realize);
> =20
> -    tcc->parent_reset =3D cc->reset;
> -    cc->reset =3D tilegx_cpu_reset;
> +    cpu_class_set_parent_reset(cc, tilegx_cpu_reset, &tcc->parent_reset);
> =20
>      cc->class_by_name =3D tilegx_cpu_class_by_name;
>      cc->has_work =3D tilegx_cpu_has_work;
> diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
> index df807c1d7437..85bc9f03a1ee 100644
> --- a/target/tricore/cpu.c
> +++ b/target/tricore/cpu.c
> @@ -153,8 +153,7 @@ static void tricore_cpu_class_init(ObjectClass *c, vo=
id *data)
>      device_class_set_parent_realize(dc, tricore_cpu_realizefn,
>                                      &mcc->parent_realize);
> =20
> -    mcc->parent_reset =3D cc->reset;
> -    cc->reset =3D tricore_cpu_reset;
> +    cpu_class_set_parent_reset(cc, tricore_cpu_reset, &mcc->parent_reset=
);
>      cc->class_by_name =3D tricore_cpu_class_by_name;
>      cc->has_work =3D tricore_cpu_has_work;
> =20
> diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
> index c65dcf9dd782..4856aee8eca6 100644
> --- a/target/xtensa/cpu.c
> +++ b/target/xtensa/cpu.c
> @@ -184,8 +184,7 @@ static void xtensa_cpu_class_init(ObjectClass *oc, vo=
id *data)
>      device_class_set_parent_realize(dc, xtensa_cpu_realizefn,
>                                      &xcc->parent_realize);
> =20
> -    xcc->parent_reset =3D cc->reset;
> -    cc->reset =3D xtensa_cpu_reset;
> +    cpu_class_set_parent_reset(cc, xtensa_cpu_reset, &xcc->parent_reset);
> =20
>      cc->class_by_name =3D xtensa_cpu_class_by_name;
>      cc->has_work =3D xtensa_cpu_has_work;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PHCdUe6m4AxPMzOu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3tmqwACgkQbDjKyiDZ
s5Loxw//Txge5Adv9f7o3qF7CLd4HusfHlCfga6+Z26HZYqGJkurcq3I4EPMzKWg
mFXhLPMNKKe9IusYcaKXZRcujljG+XZA4KLPXaj7j1l/vIVlH0WGUcKR+v1Bv67h
6MnOn1Mxi6+WGj8dkRwfH0GFP8XYWaCJkqTnDufeKpP1msCUlMsZ5pC75dk1AFNj
0DpP8oQ4lDX74mEwkiR0AdSzePwcgYD5K4uMNf97VcOUflKb9yT3DtPo9eqcABys
gI7bEJAFUIpE6We7ppSuUckgUBBT0g3igSCKUxXjcxn3d63qILNp4z3YwuZdrU61
80ubIh0OK1/gZp6DFV3QP9vCllVwxlD70YX7z+EE3X7mfVKymhuSPnU9SG1T66VU
5+BU8KBOENS7jd1ubiSuZxHGAsRZSWME4F64VqOpnlw55vtBhwwrqIgbRednGi/b
EG36jTQat10iDj3A0CPI1OksfTfjTmNpnA1jhkE8iDqmikuPVIbbXtYsAAApXBMv
Asj8Tg5iT4/5xqvI6wWiVrJUuxx4T2oy0jy6pNZOzl6onFngOGuCnCN/Mudq2c3J
373VqbocRwocs6JLnkxvj0LjRXEMJYwcSfF1eBGNQnzChgFcNlDuTVd649Q2FHDu
qa6AZRUFrEEi6BBm5y1vhI4FSGhQvkS8iA/eFtL30DyPL7aP8ag=
=XtPV
-----END PGP SIGNATURE-----

--PHCdUe6m4AxPMzOu--

