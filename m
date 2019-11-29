Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD67BC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 02:09:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 976092176D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 02:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PjU3Jq8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 976092176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaVir-0007Br-Qh
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 21:09:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iaVZ3-0003v1-Fh
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 20:59:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iaVYw-0005qQ-KX
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 20:59:19 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:39997)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iaVYw-0005SU-7e; Thu, 28 Nov 2019 20:59:14 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47PHk41796z9sPZ; Fri, 29 Nov 2019 12:59:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574992748;
 bh=LbsoeaBZSWh/QEl0lHKfl9vGiMcy5DkWcMs0SGAjLbA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PjU3Jq8+nuhKG96olTsiLFmmvgtcch3rQ+1RMIzIEI2Tep81z6U1n8eS/HkTwpLWy
 j4uJyflgqHlBZIFCMwZsNekyQRJl449WqUhsVZMfcZQRKyWqdOjUHNbAVor93m8DeA
 eYBTN1W4s8lz4J0VoHj5VtJvIADR/cUc37cq0jww=
Date: Fri, 29 Nov 2019 12:53:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 2/7] target/ppc: Work [S]PURR implementation and add HV
 support
Message-ID: <20191129015358.GG4765@umbus.fritz.box>
References: <20191128134700.16091-1-clg@kaod.org>
 <20191128134700.16091-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8bBEDOJVaa9YlTAt"
Content-Disposition: inline
In-Reply-To: <20191128134700.16091-3-clg@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--8bBEDOJVaa9YlTAt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2019 at 02:46:55PM +0100, C=E9dric Le Goater wrote:
> From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>=20
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
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> [ clg: rebased on current ppc tree ]
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>=20
>  David,
>=20
>  In the initial discussion, PURR and VTB still needed to be added to
>  the migration stream. The patch is changing the representation indeed
>  but that seems OK. AFAICT, all the SPRs are migrated. I didn't quite
>  understand that part. See http://patchwork.ozlabs.org/patch/1094662
>  for more info.

Ah, right, forgot that discussion in my comment on 1/1.

So, "all SPRs are migrated" is kind of conditional.  All SPRs stored
statically in env->sprs[] are migrated.  But here we have what's
essentially a virtual register whose value is calculated at read time.
We don't actually update sprs[SPR_TB] and similar registers at 500MHz,
that would be impossibly expensive.  So instead we need to migrate the
offset data - in some encoding or other - so that the apparent
register value on reads after the migrate will make sense.

I think we can do this without actually adding extra data to the
stream, by using the sprs[SPR_VTB,SPR_PURR] fields.  But to do so will
need a little extra logic.

I think what Suraj was suggesting in that patchwork link was to read
the PURR value (via the helpers here) at pre_save() and write it to
sprs[SPR_PURR], then at post_load() take the value in sprs[SPR_PURR]
and write it back to the virtual PURR via the helpers here.  That will
effectively freeze the PURR during the migration downtime, but
otherwise preserve it, and for PURR and SPURR I think that makes
sense.

VTB is a little different.  Like the TB itself, it's essentially
tracking wall clock time, and so it should continue to count
(conceptually speaking) during the migration downtime.

I think the key here is that we want to maintain the offset between TB
and VTB across migration.  It will require different logic, but
there's a good chance we can still save the data we need in
sprs[SPR_VTB] rather than having to add extra things to the stream.

That said, the writable versions of PURR, SPURR and VTB are only
relevant for pnv, and I don't think we currently support migration of
pnv machines anyway.  So we could punt on this until later.  But if we
do that, I would like to see some TODO comments in strategic places.

>=20
>  Nevertheless, you added your Reviewed-by.
>=20
>  include/hw/ppc/ppc.h            |  3 +--
>  target/ppc/cpu.h                |  1 +
>  target/ppc/helper.h             |  1 +
>  hw/ppc/ppc.c                    | 17 +++++++----------
>  target/ppc/timebase_helper.c    |  5 +++++
>  target/ppc/translate_init.inc.c | 23 +++++++++++++++--------
>  6 files changed, 30 insertions(+), 20 deletions(-)
>=20
> diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
> index 02481cd27c36..27bef85ca869 100644
> --- a/include/hw/ppc/ppc.h
> +++ b/include/hw/ppc/ppc.h
> @@ -33,8 +33,7 @@ struct ppc_tb_t {
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
> index 19d6e724bb5a..9128dbefbdb0 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1313,6 +1313,7 @@ void cpu_ppc_store_decr(CPUPPCState *env, target_ul=
ong value);
>  target_ulong cpu_ppc_load_hdecr(CPUPPCState *env);
>  void cpu_ppc_store_hdecr(CPUPPCState *env, target_ulong value);
>  uint64_t cpu_ppc_load_purr(CPUPPCState *env);
> +void cpu_ppc_store_purr(CPUPPCState *env, uint64_t value);
>  uint32_t cpu_ppc601_load_rtcl(CPUPPCState *env);
>  uint32_t cpu_ppc601_load_rtcu(CPUPPCState *env);
>  #if !defined(CONFIG_USER_ONLY)
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index a5f53bb421a7..356a14d8a639 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -655,6 +655,7 @@ DEF_HELPER_FLAGS_1(load_601_rtcu, TCG_CALL_NO_RWG, tl=
, env)
>  #if !defined(CONFIG_USER_ONLY)
>  #if defined(TARGET_PPC64)
>  DEF_HELPER_FLAGS_1(load_purr, TCG_CALL_NO_RWG, tl, env)
> +DEF_HELPER_FLAGS_2(store_purr, TCG_CALL_NO_RWG, void, env, tl)
>  DEF_HELPER_2(store_ptcr, void, env, tl)
>  #endif
>  DEF_HELPER_2(store_sdr1, void, env, tl)
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index 263922052536..353f11b91d40 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -821,12 +821,9 @@ target_ulong cpu_ppc_load_hdecr(CPUPPCState *env)
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
> @@ -985,12 +982,12 @@ static void cpu_ppc_hdecr_cb(void *opaque)
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
> @@ -1007,7 +1004,7 @@ static void cpu_ppc_set_tb_clk (void *opaque, uint3=
2_t freq)
>       */
>      _cpu_ppc_store_decr(cpu, 0xFFFFFFFF, 0xFFFFFFFF, 32);
>      _cpu_ppc_store_hdecr(cpu, 0xFFFFFFFF, 0xFFFFFFFF, 32);
> -    cpu_ppc_store_purr(cpu, 0x0000000000000000ULL);
> +    cpu_ppc_store_purr(env, 0x0000000000000000ULL);
>  }
> =20
>  static void timebase_save(PPCTimebase *tb)
> diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
> index 8c3c2fe67c2c..2395295b778c 100644
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
> index 5a560164d4a4..6105e74e9dc6 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -287,6 +287,11 @@ static void spr_read_purr(DisasContext *ctx, int gpr=
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
> @@ -8008,14 +8013,16 @@ static void gen_spr_book3s_purr(CPUPPCState *env)
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

--8bBEDOJVaa9YlTAt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3gejMACgkQbDjKyiDZ
s5K2jBAAypduz14UZMxuNtxhtDd8Rvco7OkkNQnHRRFEhxZnDUSwfuIfT1y+Q0a4
r5GgZb6GkNodxFinvqnTo5HRjS9ufjbTY9K+EOAmqHkWPWd8dIfaozP+4PqMl9M7
/7a4oMdpNK9HQ80KhMHvzQl+Oc6pts72GsgvxsvAuZNnXPP+Bcnf43PVEoe0VeA3
ySdjMjoQQF+ON6YgheSox27lGZ9vIsvi9G5XXspZozP4AOuZLYnRbqAmG8Al2ojq
cjQJvfTpWvhG9tVChvf8vipBLp78fyrRmzcP8RVOCDa+VABNCg29x81XYk0aEvYN
TG/n5QDryYSI27pGmneKKWSZSxqFK32BbUE6gs0y6xW+LLSw8/N02CqCXUXsAIah
edygieHSxorwQ05e3G5QiRn5sfkpfv9scJt+0yddFrweyg/zl3Py39PRPIxEWplB
l5ykjEdJYKHm5eSIjW2zpqfnJB/EvVY7SQJR7SrHS7vE0SWhp7ppRndqubmfuW7X
6Atbe70HGlp66DHdOEblqAE2wBsfpHZr7FHCNgbOmvKqel55HCWkUpIY7Oy1DHYZ
1og9r4SqTQLrb3YdCgKaByZw8zdnSKVpJ6HlI/MxK+ErKs2O3HcBxZA7aOsNHn+k
yXoIyTR6JqGysXrCV6ozmJ0BJa8BFDgJqxa3v523Cf65xp3SSN0=
=VNoB
-----END PGP SIGNATURE-----

--8bBEDOJVaa9YlTAt--

