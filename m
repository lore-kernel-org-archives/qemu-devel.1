Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A54FC04AAE
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 06:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BCD32082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 06:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="epwM1B3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BCD32082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51424 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNXTQ-0006oy-E0
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 02:51:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNXRf-0005Ob-Qx
	for qemu-devel@nongnu.org; Mon, 06 May 2019 02:49:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNXRe-00067F-Hg
	for qemu-devel@nongnu.org; Mon, 06 May 2019 02:49:51 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:59161)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hNXRd-00064j-I1; Mon, 06 May 2019 02:49:50 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44yCyv2HCBz9s9T; Mon,  6 May 2019 16:49:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557125383;
	bh=kpiTxPXaiSCDCONvxPyf2zbcoL5tDoylf5HLdKbFgNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=epwM1B3fufz33hL7Jgpk0rdAT7a7dRJh7HDKaDhxBuupMrWCbrjI0CjXzGJJPgvRY
	qZTFHYDwPhWt4gt5agpe229zYCf1fczrROKvIl01xwgKDLkiycS/vD2zeGMgAlMP0x
	uB7RpMK9Y2S7QrcW18OlK6oMTBLq6dQXy4xU6LXo=
Date: Mon, 6 May 2019 16:17:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <20190506061732.GJ6790@umbus.fritz.box>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
	<20190503055316.6441-5-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zYo4Elh1vtcYNvbq"
Content-Disposition: inline
In-Reply-To: <20190503055316.6441-5-sjitindarsingh@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH 04/13] target/ppc: Add SPR TBU40
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--zYo4Elh1vtcYNvbq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2019 at 03:53:07PM +1000, Suraj Jitindar Singh wrote:
> The spr TBU40 is used to set the upper 40 bits of the timebase
> register, present on POWER5+ and later processors.
>=20
> This register can only be written by the hypervisor, and cannot be read.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/ppc.c                    | 13 +++++++++++++
>  target/ppc/cpu.h                |  1 +
>  target/ppc/helper.h             |  1 +
>  target/ppc/timebase_helper.c    |  5 +++++
>  target/ppc/translate_init.inc.c | 19 +++++++++++++++++++
>  5 files changed, 39 insertions(+)
>=20
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index b567156f97..b618c6f615 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -710,6 +710,19 @@ void cpu_ppc_store_vtb(CPUPPCState *env, uint64_t va=
lue)
>                       &tb_env->vtb_offset, value);
>  }
> =20
> +void cpu_ppc_store_tbu40(CPUPPCState *env, uint64_t value)
> +{
> +    ppc_tb_t *tb_env =3D env->tb_env;
> +    uint64_t tb;
> +
> +    tb =3D cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> +                        tb_env->tb_offset);
> +    tb &=3D 0xFFFFFFUL;
> +    tb |=3D (value & ~0xFFFFFFUL);
> +    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> +                     &tb_env->tb_offset, tb);
> +}
> +
>  static void cpu_ppc_tb_stop (CPUPPCState *env)
>  {
>      ppc_tb_t *tb_env =3D env->tb_env;
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 8d66265e5a..e324064111 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1334,6 +1334,7 @@ target_ulong cpu_ppc_load_decr (CPUPPCState *env);
>  void cpu_ppc_store_decr (CPUPPCState *env, target_ulong value);
>  target_ulong cpu_ppc_load_hdecr (CPUPPCState *env);
>  void cpu_ppc_store_hdecr (CPUPPCState *env, target_ulong value);
> +void cpu_ppc_store_tbu40(CPUPPCState *env, uint64_t value);
>  uint64_t cpu_ppc_load_purr (CPUPPCState *env);
>  void cpu_ppc_store_purr(CPUPPCState *env, uint64_t value);
>  uint32_t cpu_ppc601_load_rtcl (CPUPPCState *env);
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 336e7802fb..6aee195528 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -703,6 +703,7 @@ DEF_HELPER_FLAGS_2(store_decr, TCG_CALL_NO_RWG, void,=
 env, tl)
>  DEF_HELPER_FLAGS_1(load_hdecr, TCG_CALL_NO_RWG, tl, env)
>  DEF_HELPER_FLAGS_2(store_hdecr, TCG_CALL_NO_RWG, void, env, tl)
>  DEF_HELPER_FLAGS_2(store_vtb, TCG_CALL_NO_RWG, void, env, tl)
> +DEF_HELPER_FLAGS_2(store_tbu40, TCG_CALL_NO_RWG, void, env, tl)
>  DEF_HELPER_2(store_hid0_601, void, env, tl)
>  DEF_HELPER_3(store_403_pbr, void, env, i32, tl)
>  DEF_HELPER_FLAGS_1(load_40x_pit, TCG_CALL_NO_RWG, tl, env)
> diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
> index 2395295b77..703bd9ed18 100644
> --- a/target/ppc/timebase_helper.c
> +++ b/target/ppc/timebase_helper.c
> @@ -128,6 +128,11 @@ void helper_store_vtb(CPUPPCState *env, target_ulong=
 val)
>      cpu_ppc_store_vtb(env, val);
>  }
> =20
> +void helper_store_tbu40(CPUPPCState *env, target_ulong val)
> +{
> +    cpu_ppc_store_tbu40(env, val);
> +}
> +
>  target_ulong helper_load_40x_pit(CPUPPCState *env)
>  {
>      return load_40x_pit(env);
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index a0cae58e19..8e287066e5 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -325,6 +325,11 @@ static void spr_write_vtb(DisasContext *ctx, int spr=
n, int gprn)
>      gen_helper_store_vtb(cpu_env, cpu_gpr[gprn]);
>  }
> =20
> +static void spr_write_tbu40(DisasContext *ctx, int sprn, int gprn)
> +{
> +    gen_helper_store_tbu40(cpu_env, cpu_gpr[gprn]);
> +}
> +
>  #endif
>  #endif
> =20
> @@ -7812,6 +7817,16 @@ static void gen_spr_power5p_ear(CPUPPCState *env)
>                   0x00000000);
>  }
> =20
> +static void gen_spr_power5p_tb(CPUPPCState *env)
> +{
> +    /* TBU40 (High 40 bits of the Timebase register */
> +    spr_register_hv(env, SPR_TBU40, "TBU40",
> +                    SPR_NOACCESS, SPR_NOACCESS,
> +                    SPR_NOACCESS, SPR_NOACCESS,
> +                    SPR_NOACCESS, &spr_write_tbu40,
> +                    0x00000000);
> +}
> +
>  #if !defined(CONFIG_USER_ONLY)
>  static void spr_write_hmer(DisasContext *ctx, int sprn, int gprn)
>  {
> @@ -8352,6 +8367,7 @@ static void init_proc_power5plus(CPUPPCState *env)
>      gen_spr_power5p_common(env);
>      gen_spr_power5p_lpar(env);
>      gen_spr_power5p_ear(env);
> +    gen_spr_power5p_tb(env);
> =20
>      /* env variables */
>      env->dcache_line_size =3D 128;
> @@ -8464,6 +8480,7 @@ static void init_proc_POWER7(CPUPPCState *env)
>      gen_spr_power5p_common(env);
>      gen_spr_power5p_lpar(env);
>      gen_spr_power5p_ear(env);
> +    gen_spr_power5p_tb(env);
>      gen_spr_power6_common(env);
>      gen_spr_power6_dbg(env);
>      gen_spr_power7_book4(env);
> @@ -8605,6 +8622,7 @@ static void init_proc_POWER8(CPUPPCState *env)
>      gen_spr_power5p_common(env);
>      gen_spr_power5p_lpar(env);
>      gen_spr_power5p_ear(env);
> +    gen_spr_power5p_tb(env);
>      gen_spr_power6_common(env);
>      gen_spr_power6_dbg(env);
>      gen_spr_power8_tce_address_control(env);
> @@ -8793,6 +8811,7 @@ static void init_proc_POWER9(CPUPPCState *env)
>      gen_spr_power5p_common(env);
>      gen_spr_power5p_lpar(env);
>      gen_spr_power5p_ear(env);
> +    gen_spr_power5p_tb(env);
>      gen_spr_power6_common(env);
>      gen_spr_power6_dbg(env);
>      gen_spr_power8_tce_address_control(env);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zYo4Elh1vtcYNvbq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzP0XwACgkQbDjKyiDZ
s5L7Nw//Q9PasQhBFROgBSrfy7BWhMlbjB/WoG/p/fqB/MVVZKvgIfDUorXNZeuE
tjGdEpEL4EVqrWesUEZ4jl42zzjWFd3YJgOmw/+GyL4odF2vQFZfp/DEubeqF0Yw
Qb1AH1O2I05+eaRgqhCqsHdEg9JZCu8tPXAs71ja1cxKGQLIxOb8Zjp/tn4mRZiR
VHreufkqGYVJ5mJ2lEp7q1BUrb3A4ohyG7UX6lwKXc7rU2Wqh1wspMb5QnO+gfxn
x0JD+diMmrQwqs4M1bmMO7R6/HGtjUAy2pcFx8gD+tsFJVGpNRZXbMy8nNePKGdr
+IS6DW7KRsfLekV/BMR6PnRcK7Yzx1bpslJT7CgKYzsTb2cmKW08tahkc2fKxsA6
BHXxZRt1UK+Ztiy8ilmqk968KoScp3Ci/ZuyCYFhn6AYxljYsfecl2w7xCr5BnFy
SV50eah0h2mNG0P/UQs5ef8GV7bxpQqdOLx5MBB/riev3YwIxaS+w2Ut0SdrL7sw
NLSBmJksTO5+9lpUNw9mJMAmZHFWRfBoICw6VJ5TMKJBRDdpyAVVA+d0cSMGrk/U
o1c0HjCEhSQftKn/EFnNvKaBoi13J9H8Mql93sxLGhL0BXVIlM/tXh2hSiALEZnP
rlwwZFfKce6YOiL+tirLEERrJs+81uxOd/6fFGRL98XLxqmpb8k=
=Bu2L
-----END PGP SIGNATURE-----

--zYo4Elh1vtcYNvbq--

