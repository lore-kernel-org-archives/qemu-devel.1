Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E26CC04AAD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 06:55:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A1C6206A3
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 06:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Hs/zeIPG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1C6206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51457 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNXWq-0001sr-Ka
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 02:55:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNXRh-0005Ow-F4
	for qemu-devel@nongnu.org; Mon, 06 May 2019 02:49:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNXRf-00068P-Mw
	for qemu-devel@nongnu.org; Mon, 06 May 2019 02:49:53 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:34705)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hNXRf-00064t-0f; Mon, 06 May 2019 02:49:51 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44yCyv1RCxz9s7T; Mon,  6 May 2019 16:49:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557125383;
	bh=i0qezLyMT98G2NutTWA5Qk+kDW8sz0sjdgMTP4Ehny8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hs/zeIPGvv56or8mYLahYeuWuWdhIlnU4lN4tkfaUa3sx4twPMbg2BSZ3nMF03mhj
	dDAaw4SghlASnobPmB5YTJKYgsEp6Zh0toX01Q9DViglT3fszllcZ26aYLL8eJjFQL
	Sk/6G8JXohydRLLnkOIfJTTXFtq0hrJtWYtbif2Y=
Date: Mon, 6 May 2019 16:15:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <20190506061534.GH6790@umbus.fritz.box>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
	<20190503055316.6441-3-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uJrvpPjGB3z5kYrA"
Content-Disposition: inline
In-Reply-To: <20190503055316.6441-3-sjitindarsingh@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH 02/13] target/ppc: Work [S]PURR
 implementation and add HV support
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


--uJrvpPjGB3z5kYrA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2019 at 03:53:05PM +1000, Suraj Jitindar Singh wrote:
> The Processor Utilisation of Resources Register (PURR) and Scaled
> Processor Utilisation of Resources Register (SPURR) provide an estimate
> of the resources used by the thread, present on POWER7 and later
> processors.
>=20
> Currently the [S]PURR registers simply count at the rate of the
> timebase.
>=20
> Preserve this behaviour but rework the implementation to store an offset
> like the timebase rather than doing the calculation manually. Also allow
> hypervisor write access to the register along with the currently
> available read access.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Hm.  How will this affect migration of the PURR and SPURR?

> ---
>  hw/ppc/ppc.c                    | 17 +++++++----------
>  include/hw/ppc/ppc.h            |  3 +--
>  target/ppc/cpu.h                |  1 +
>  target/ppc/helper.h             |  1 +
>  target/ppc/timebase_helper.c    |  5 +++++
>  target/ppc/translate_init.inc.c | 23 +++++++++++++++--------
>  6 files changed, 30 insertions(+), 20 deletions(-)
>=20
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index a57ca64626..b567156f97 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -819,12 +819,9 @@ target_ulong cpu_ppc_load_hdecr (CPUPPCState *env)
>  uint64_t cpu_ppc_load_purr (CPUPPCState *env)
>  {
>      ppc_tb_t *tb_env =3D env->tb_env;
> -    uint64_t diff;
> =20
> -    diff =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - tb_env->purr_start;
> -
> -    return tb_env->purr_load +
> -        muldiv64(diff, tb_env->tb_freq, NANOSECONDS_PER_SECOND);
> +    return cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> +                          tb_env->purr_offset);
>  }
> =20
>  /* When decrementer expires,
> @@ -980,12 +977,12 @@ static void cpu_ppc_hdecr_cb(void *opaque)
>      cpu_ppc_hdecr_excp(cpu);
>  }
> =20
> -static void cpu_ppc_store_purr(PowerPCCPU *cpu, uint64_t value)
> +void cpu_ppc_store_purr(CPUPPCState *env, uint64_t value)
>  {
> -    ppc_tb_t *tb_env =3D cpu->env.tb_env;
> +    ppc_tb_t *tb_env =3D env->tb_env;
> =20
> -    tb_env->purr_load =3D value;
> -    tb_env->purr_start =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> +                     &tb_env->purr_offset, value);
>  }
> =20
>  static void cpu_ppc_set_tb_clk (void *opaque, uint32_t freq)
> @@ -1002,7 +999,7 @@ static void cpu_ppc_set_tb_clk (void *opaque, uint32=
_t freq)
>       */
>      _cpu_ppc_store_decr(cpu, 0xFFFFFFFF, 0xFFFFFFFF, 32);
>      _cpu_ppc_store_hdecr(cpu, 0xFFFFFFFF, 0xFFFFFFFF, 32);
> -    cpu_ppc_store_purr(cpu, 0x0000000000000000ULL);
> +    cpu_ppc_store_purr(env, 0x0000000000000000ULL);
>  }
> =20
>  static void timebase_save(PPCTimebase *tb)
> diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
> index 205150e6b4..b09ffbf300 100644
> --- a/include/hw/ppc/ppc.h
> +++ b/include/hw/ppc/ppc.h
> @@ -32,8 +32,7 @@ struct ppc_tb_t {
>      /* Hypervisor decrementer management */
>      uint64_t hdecr_next;    /* Tick for next hdecr interrupt  */
>      QEMUTimer *hdecr_timer;
> -    uint64_t purr_load;
> -    uint64_t purr_start;
> +    int64_t purr_offset;
>      void *opaque;
>      uint32_t flags;
>  };
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 70167bae22..19b3e1de0e 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1335,6 +1335,7 @@ void cpu_ppc_store_decr (CPUPPCState *env, target_u=
long value);
>  target_ulong cpu_ppc_load_hdecr (CPUPPCState *env);
>  void cpu_ppc_store_hdecr (CPUPPCState *env, target_ulong value);
>  uint64_t cpu_ppc_load_purr (CPUPPCState *env);
> +void cpu_ppc_store_purr(CPUPPCState *env, uint64_t value);
>  uint32_t cpu_ppc601_load_rtcl (CPUPPCState *env);
>  uint32_t cpu_ppc601_load_rtcu (CPUPPCState *env);
>  #if !defined(CONFIG_USER_ONLY)
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 3701bcbf1b..336e7802fb 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -686,6 +686,7 @@ DEF_HELPER_FLAGS_1(load_601_rtcu, TCG_CALL_NO_RWG, tl=
, env)
>  #if !defined(CONFIG_USER_ONLY)
>  #if defined(TARGET_PPC64)
>  DEF_HELPER_FLAGS_1(load_purr, TCG_CALL_NO_RWG, tl, env)
> +DEF_HELPER_FLAGS_2(store_purr, TCG_CALL_NO_RWG, void, env, tl)
>  DEF_HELPER_2(store_ptcr, void, env, tl)
>  #endif
>  DEF_HELPER_2(store_sdr1, void, env, tl)
> diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
> index 8c3c2fe67c..2395295b77 100644
> --- a/target/ppc/timebase_helper.c
> +++ b/target/ppc/timebase_helper.c
> @@ -55,6 +55,11 @@ target_ulong helper_load_purr(CPUPPCState *env)
>  {
>      return (target_ulong)cpu_ppc_load_purr(env);
>  }
> +
> +void helper_store_purr(CPUPPCState *env, target_ulong val)
> +{
> +    cpu_ppc_store_purr(env, val);
> +}
>  #endif
> =20
>  target_ulong helper_load_601_rtcl(CPUPPCState *env)
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index e3f941800b..9cd33e79ef 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -285,6 +285,11 @@ static void spr_read_purr(DisasContext *ctx, int gpr=
n, int sprn)
>      gen_helper_load_purr(cpu_gpr[gprn], cpu_env);
>  }
> =20
> +static void spr_write_purr(DisasContext *ctx, int sprn, int gprn)
> +{
> +    gen_helper_store_purr(cpu_env, cpu_gpr[gprn]);
> +}
> +
>  /* HDECR */
>  static void spr_read_hdecr(DisasContext *ctx, int gprn, int sprn)
>  {
> @@ -7972,14 +7977,16 @@ static void gen_spr_book3s_purr(CPUPPCState *env)
>  {
>  #if !defined(CONFIG_USER_ONLY)
>      /* PURR & SPURR: Hack - treat these as aliases for the TB for now */
> -    spr_register_kvm(env, SPR_PURR,   "PURR",
> -                     &spr_read_purr, SPR_NOACCESS,
> -                     &spr_read_purr, SPR_NOACCESS,
> -                     KVM_REG_PPC_PURR, 0x00000000);
> -    spr_register_kvm(env, SPR_SPURR,   "SPURR",
> -                     &spr_read_purr, SPR_NOACCESS,
> -                     &spr_read_purr, SPR_NOACCESS,
> -                     KVM_REG_PPC_SPURR, 0x00000000);
> +    spr_register_kvm_hv(env, SPR_PURR,   "PURR",
> +                        &spr_read_purr, SPR_NOACCESS,
> +                        &spr_read_purr, SPR_NOACCESS,
> +                        &spr_read_purr, &spr_write_purr,
> +                        KVM_REG_PPC_PURR, 0x00000000);
> +    spr_register_kvm_hv(env, SPR_SPURR,   "SPURR",
> +                        &spr_read_purr, SPR_NOACCESS,
> +                        &spr_read_purr, SPR_NOACCESS,
> +                        &spr_read_purr, &spr_write_purr,
> +                        KVM_REG_PPC_SPURR, 0x00000000);
>  #endif
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uJrvpPjGB3z5kYrA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzP0QQACgkQbDjKyiDZ
s5I6pRAAntQUi907fZR30nazYKaKtzZ5lZCLEjoHqqq2k7TuOeTP8QP5etqdkBfH
ab7lpFZOGTRfwKmnCzL6s1C6aqpv1cAkRn0lIffYNT6bn6JHInofRLZtcD3uppxc
llmV29815e00Yzbqr5UffmKzTUODt5QdOTbIJHfPDnleo5zesw0bX7sIwvWZhAix
U7+xu2I5sKwSuOwGPb3Sl9BwxCmb5LRlxijRw5nzqENmfL5+718pyVlAx8/0PLys
bHbAun2W3HNiI+bnSB5o0erQVGoQ089GpDbskcly/WVM1m5f3QY78Eg/YGdbiCC+
3SMoRip+T9eEDG6QdydUdXvXCJJVwhXS8/hUMvNgnjsLHwUv/1I4NrMwVFaqYgkG
qhF2HBFee487vr6Iik0SmJK/CXuWXEyV3wOvvlx55KmSCgbTNoKtk69ooCCH1aoc
KPfzvhkwjthhPwJNSOQ+lqg9bFCF0C1ffrowEyHz8w6jXxJ/PKsyAnTUiRWerkmx
NwzqgojcIZjusVyL7bdJoNzvJZThvaROVdWp4hfDgEhCvKyQ6W6TWQH0WOKFO5Rs
c34P4xSh2pna+Ho6wEnnd5c/vAuDfj+Tf3v0ab/WulUH/MNMRjyh92CBnlWJIgdr
q0e1ortj70r8vYiWLbIb6dFEKmxbKgu6EraM51Z+fVZAWon4a2M=
=H83q
-----END PGP SIGNATURE-----

--uJrvpPjGB3z5kYrA--

