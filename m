Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10906C04AAA
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 06:51:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0F422082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 06:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="geS/VqfM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0F422082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51426 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNXTV-0006xk-QG
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 02:51:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNXRh-0005Oj-6S
	for qemu-devel@nongnu.org; Mon, 06 May 2019 02:49:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNXRf-00068B-HK
	for qemu-devel@nongnu.org; Mon, 06 May 2019 02:49:53 -0400
Received: from ozlabs.org ([203.11.71.1]:43511)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hNXRd-00064I-LW; Mon, 06 May 2019 02:49:51 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44yCyv0cLwz9s9N; Mon,  6 May 2019 16:49:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557125383;
	bh=Z0eSrySStS0U0qnSjNb8zpISnT2RTIxs35FQDAzStRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=geS/VqfM47eJJ8VNgUX7iMQGsOPiaTQ/DAWF3b2JpKCrINsEfmpSVOgFAaUgqXfBv
	cY626qzthGgqLe5VeY49uHX73uug3ICB1t7Ri9gRDiqkwtXFvhCxx8Yh6iQzwLi/KM
	QKjRFz/mr5KTIbJcz2dJLkHxCHaFGYjph9xx0oo0=
Date: Mon, 6 May 2019 16:02:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <20190506060214.GG6790@umbus.fritz.box>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
	<20190503055316.6441-2-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MrRUTeZlqqNo1jQ9"
Content-Disposition: inline
In-Reply-To: <20190503055316.6441-2-sjitindarsingh@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH 01/13] target/ppc: Implement the
 VTB for HV access
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


--MrRUTeZlqqNo1jQ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2019 at 03:53:04PM +1000, Suraj Jitindar Singh wrote:
> The virtual timebase register (VTB) is a 64-bit register which
> increments at the same rate as the timebase register, present on POWER8
> and later processors.
>=20
> The register is able to be read/written by the hypervisor and read by
> the supervisor. All other accesses are illegal.
>=20
> Currently the VTB is just an alias for the timebase (TB) register.
>=20
> Implement the VTB so that is can be read/written independent of the TB.
> Make use of the existing method for accessing timebase facilities where
> by the compensation is stored and used to compute the value on reads/is
> updated on writes.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

LGTM, but now conflicts with the ppc-for-4.1 tree.

> ---
>  hw/ppc/ppc.c                    | 16 ++++++++++++++++
>  include/hw/ppc/ppc.h            |  1 +
>  linux-user/ppc/cpu_loop.c       |  5 +++++
>  target/ppc/cpu.h                |  2 ++
>  target/ppc/helper.h             |  2 ++
>  target/ppc/timebase_helper.c    | 10 ++++++++++
>  target/ppc/translate_init.inc.c | 19 +++++++++++++++----
>  7 files changed, 51 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index b2ff99ec66..a57ca64626 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -694,6 +694,22 @@ void cpu_ppc_store_atbu (CPUPPCState *env, uint32_t =
value)
>                       &tb_env->atb_offset, ((uint64_t)value << 32) | tb);
>  }
> =20
> +uint64_t cpu_ppc_load_vtb(CPUPPCState *env)
> +{
> +    ppc_tb_t *tb_env =3D env->tb_env;
> +
> +    return cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> +                          tb_env->vtb_offset);
> +}
> +
> +void cpu_ppc_store_vtb(CPUPPCState *env, uint64_t value)
> +{
> +    ppc_tb_t *tb_env =3D env->tb_env;
> +
> +    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> +                     &tb_env->vtb_offset, value);
> +}
> +
>  static void cpu_ppc_tb_stop (CPUPPCState *env)
>  {
>      ppc_tb_t *tb_env =3D env->tb_env;
> diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
> index 4bdcb8bacd..205150e6b4 100644
> --- a/include/hw/ppc/ppc.h
> +++ b/include/hw/ppc/ppc.h
> @@ -23,6 +23,7 @@ struct ppc_tb_t {
>      /* Time base management */
>      int64_t  tb_offset;    /* Compensation                    */
>      int64_t  atb_offset;   /* Compensation                    */
> +    int64_t  vtb_offset;
>      uint32_t tb_freq;      /* TB frequency                    */
>      /* Decrementer management */
>      uint64_t decr_next;    /* Tick for next decr interrupt    */
> diff --git a/linux-user/ppc/cpu_loop.c b/linux-user/ppc/cpu_loop.c
> index 801f5ace29..c715861804 100644
> --- a/linux-user/ppc/cpu_loop.c
> +++ b/linux-user/ppc/cpu_loop.c
> @@ -46,6 +46,11 @@ uint32_t cpu_ppc_load_atbu(CPUPPCState *env)
>      return cpu_ppc_get_tb(env) >> 32;
>  }
> =20
> +uint64_t cpu_ppc_load_vtb(CPUPPCState *env)
> +{
> +    return cpu_ppc_get_tb(env);
> +}
> +
>  uint32_t cpu_ppc601_load_rtcu(CPUPPCState *env)
>  __attribute__ (( alias ("cpu_ppc_load_tbu") ));
> =20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index fe93cf0555..70167bae22 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1327,6 +1327,8 @@ uint64_t cpu_ppc_load_atbl (CPUPPCState *env);
>  uint32_t cpu_ppc_load_atbu (CPUPPCState *env);
>  void cpu_ppc_store_atbl (CPUPPCState *env, uint32_t value);
>  void cpu_ppc_store_atbu (CPUPPCState *env, uint32_t value);
> +uint64_t cpu_ppc_load_vtb(CPUPPCState *env);
> +void cpu_ppc_store_vtb(CPUPPCState *env, uint64_t value);
>  bool ppc_decr_clear_on_delivery(CPUPPCState *env);
>  target_ulong cpu_ppc_load_decr (CPUPPCState *env);
>  void cpu_ppc_store_decr (CPUPPCState *env, target_ulong value);
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 69cbf7922f..3701bcbf1b 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -680,6 +680,7 @@ DEF_HELPER_FLAGS_1(load_tbl, TCG_CALL_NO_RWG, tl, env)
>  DEF_HELPER_FLAGS_1(load_tbu, TCG_CALL_NO_RWG, tl, env)
>  DEF_HELPER_FLAGS_1(load_atbl, TCG_CALL_NO_RWG, tl, env)
>  DEF_HELPER_FLAGS_1(load_atbu, TCG_CALL_NO_RWG, tl, env)
> +DEF_HELPER_FLAGS_1(load_vtb, TCG_CALL_NO_RWG, tl, env)
>  DEF_HELPER_FLAGS_1(load_601_rtcl, TCG_CALL_NO_RWG, tl, env)
>  DEF_HELPER_FLAGS_1(load_601_rtcu, TCG_CALL_NO_RWG, tl, env)
>  #if !defined(CONFIG_USER_ONLY)
> @@ -700,6 +701,7 @@ DEF_HELPER_FLAGS_1(load_decr, TCG_CALL_NO_RWG, tl, en=
v)
>  DEF_HELPER_FLAGS_2(store_decr, TCG_CALL_NO_RWG, void, env, tl)
>  DEF_HELPER_FLAGS_1(load_hdecr, TCG_CALL_NO_RWG, tl, env)
>  DEF_HELPER_FLAGS_2(store_hdecr, TCG_CALL_NO_RWG, void, env, tl)
> +DEF_HELPER_FLAGS_2(store_vtb, TCG_CALL_NO_RWG, void, env, tl)
>  DEF_HELPER_2(store_hid0_601, void, env, tl)
>  DEF_HELPER_3(store_403_pbr, void, env, i32, tl)
>  DEF_HELPER_FLAGS_1(load_40x_pit, TCG_CALL_NO_RWG, tl, env)
> diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
> index 73363e08ae..8c3c2fe67c 100644
> --- a/target/ppc/timebase_helper.c
> +++ b/target/ppc/timebase_helper.c
> @@ -45,6 +45,11 @@ target_ulong helper_load_atbu(CPUPPCState *env)
>      return cpu_ppc_load_atbu(env);
>  }
> =20
> +target_ulong helper_load_vtb(CPUPPCState *env)
> +{
> +    return cpu_ppc_load_vtb(env);
> +}
> +
>  #if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
>  target_ulong helper_load_purr(CPUPPCState *env)
>  {
> @@ -113,6 +118,11 @@ void helper_store_hdecr(CPUPPCState *env, target_ulo=
ng val)
>      cpu_ppc_store_hdecr(env, val);
>  }
> =20
> +void helper_store_vtb(CPUPPCState *env, target_ulong val)
> +{
> +    cpu_ppc_store_vtb(env, val);
> +}
> +
>  target_ulong helper_load_40x_pit(CPUPPCState *env)
>  {
>      return load_40x_pit(env);
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 0bd555eb19..e3f941800b 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -310,6 +310,16 @@ static void spr_write_hdecr(DisasContext *ctx, int s=
prn, int gprn)
>      }
>  }
> =20
> +static void spr_read_vtb(DisasContext *ctx, int gprn, int sprn)
> +{
> +    gen_helper_load_vtb(cpu_gpr[gprn], cpu_env);
> +}
> +
> +static void spr_write_vtb(DisasContext *ctx, int sprn, int gprn)
> +{
> +    gen_helper_store_vtb(cpu_env, cpu_gpr[gprn]);
> +}
> +
>  #endif
>  #endif
> =20
> @@ -8133,10 +8143,11 @@ static void gen_spr_power8_ebb(CPUPPCState *env)
>  /* Virtual Time Base */
>  static void gen_spr_vtb(CPUPPCState *env)
>  {
> -    spr_register_kvm(env, SPR_VTB, "VTB",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_tbl, SPR_NOACCESS,
> -                 KVM_REG_PPC_VTB, 0x00000000);
> +    spr_register_kvm_hv(env, SPR_VTB, "VTB",
> +                        SPR_NOACCESS, SPR_NOACCESS,
> +                        &spr_read_vtb, SPR_NOACCESS,
> +                        &spr_read_vtb, &spr_write_vtb,
> +                        KVM_REG_PPC_VTB, 0x00000000);
>  }
> =20
>  static void gen_spr_power8_fscr(CPUPPCState *env)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MrRUTeZlqqNo1jQ9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzPzeYACgkQbDjKyiDZ
s5KssxAAs8bwovLVEG1gCrvniOKbt9JSbj+iwnykTLRr87LC1QsHKwoUqo58DPhu
54k1msBgjCqIJdTPEUOXA5Ic7M6aRCt75DPVwdYk8pBA0Ef8VVB2IeyShgcVp8ZD
QfWEKfwos6pu/DuzUQqUFjISMl3TX3XSf32FqOepnv/ges2d8unlRdiEdSlVARnF
FyCIQDmiUq8mpTTwetdLlV47AIAU8tEshEo++MiI84QmyPAN5ThVvD6P+1ioocTA
2vtnuWYxDldqR5X6U6LrdHZ8dUSfz6+CfGop+bppDGh2QxCL5B0DGF2I30OgDkiK
edAzDI6drSwDhwm+ZRqMzT+Kz6BPrnHZaUFRoRdjGJ4nh859NMup8hOucrgrfBRO
kJFu/TqF0L449yCs136fATE7CD4L9FtG/fOOL4HCb5jTeiyLLaGGsn5R7Nsv0oCS
5lVtIaM0aOcToL4IF5PZZPfyFIVOpRIGFs6iD8rrRyAs7CfDgItVLy0osG+wA1oo
EjQyJ12bSVML9D5CoGCsPGEdeVbq+NC52C6NEL7Cg/Nbzcs/OWoByQMKGXGVI+30
unADaoAD6fcuvKV44mOZ2NuL+eSkqRPKVKrFFCwcikB3kHi9rJNfKqJwonFBKWu+
vAb8MNPqG3mYEl4bowoZoJ0CH5JcBhxJmD5lqgDgnImuGxAbx2g=
=f4Y6
-----END PGP SIGNATURE-----

--MrRUTeZlqqNo1jQ9--

