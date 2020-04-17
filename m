Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC95C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 01:02:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12C9E20776
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 01:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="K+nttMMp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C9E20776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPFOL-00011e-87
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 21:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jPFNH-0000M0-EZ
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 21:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jPFNF-0002C4-9m
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 21:00:54 -0400
Received: from ozlabs.org ([203.11.71.1]:45071)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jPFNE-00023q-5d; Thu, 16 Apr 2020 21:00:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 493Hp21kWhz9sSG; Fri, 17 Apr 2020 11:00:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1587085242;
 bh=yoah8bflFH5+cIjZW68ZwOiWwUY28dTHfS4xBrV55Lg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=K+nttMMp/QFurxERBnQtMKnndcRtzCwL2DLHLx1Hn3NSPTBUUag1ymTvHTKORXgt6
 9kX/XlyDnwx0RIjZfU8cN4t4jP3ceEBt7giarpHxcE10EsoOBekvi9awjOZhageKdt
 t4aMiN4AL4r/Gpqk4rSJK0jBdFTZiER6BKaDOzeo=
Date: Fri, 17 Apr 2020 10:40:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] target/ppc: Fix mtmsr(d) L=1 variant that loses interrupts
Message-ID: <20200417004012.GA2102@umbus.fritz.box>
References: <20200414111131.465560-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <20200414111131.465560-1-npiggin@gmail.com>
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
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>, qemu-ppc@nongnu.org,
 Nathan Chancellor <natechancellor@gmail.com>,
 Anton Blanchard <anton@ozlabs.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2020 at 09:11:31PM +1000, Nicholas Piggin wrote:
65;5803;1c> If mtmsr L=3D1 sets MSR[EE] while there is a maskable exception=
 pending,
> it does not cause an interrupt. This causes the test case to hang:
>=20
> https://lists.gnu.org/archive/html/qemu-ppc/2019-10/msg00826.html
>=20
> More recently, Linux reduced the occurance of operations (e.g., rfi)
> which stop translation and allow pending interrupts to be processed.
> This started causing hangs in Linux boot in long-running kernel tests,
> running with '-d int' shows the decrementer stops firing despite DEC
> wrapping and MSR[EE]=3D1.
>=20
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2020-April/208301.html
>=20
> The cause is the broken mtmsr L=3D1 behaviour, which is contrary to the
> architecture. From Power ISA v3.0B, p.977, Move To Machine State Register,
> Programming Note states:
>=20
>     If MSR[EE]=3D0 and an External, Decrementer, or Performance Monitor
>     exception is pending, executing an mtmsrd instruction that sets
>     MSR[EE] to 1 will cause the interrupt to occur before the next
>     instruction is executed, if no higher priority exception exists
>=20
> Fix this by handling L=3D1 exactly the same way as L=3D0, modulo the MSR
> bits altered.
>=20
> The confusion arises from L=3D0 being "context synchronizing" whereas L=
=3D1
> is "execution synchronizing", which is a weaker semantic. However this
> is not a relaxation of the requirement that these exceptions cause
> interrupts when MSR[EE]=3D1 (e.g., when mtmsr executes to completion as
> TCG is doing here), rather it specifies how a pipelined processor can
> have multiple instructions in flight where one may influence how another
> behaves.
>=20
> Cc: qemu-stable@nongnu.org
> Reported-by: Anton Blanchard <anton@ozlabs.org>
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> Thanks very much to Nathan for reporting and testing it, I added his
> Tested-by tag despite a more polished patch, as the the basics are=20
> still the same (and still fixes his test case here).
>=20
> This bug possibly goes back to early v2.04 / mtmsrd L=3D1 support around
> 2007, and the code has been changed several times since then so may
> require some backporting.
>=20
> 32-bit / mtmsr untested at the moment, I don't have an environment
> handy.
>=20
>  target/ppc/translate.c | 46 +++++++++++++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 19 deletions(-)

Applied to ppc-for-5.0.

>=20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index b207fb5386..9959259dba 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4361,30 +4361,34 @@ static void gen_mtmsrd(DisasContext *ctx)
>      CHK_SV;
> =20
>  #if !defined(CONFIG_USER_ONLY)
> +    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
> +        gen_io_start();
> +    }
>      if (ctx->opcode & 0x00010000) {
> -        /* Special form that does not need any synchronisation */
> +        /* L=3D1 form only updates EE and RI */
>          TCGv t0 =3D tcg_temp_new();
> +        TCGv t1 =3D tcg_temp_new();
>          tcg_gen_andi_tl(t0, cpu_gpr[rS(ctx->opcode)],
>                          (1 << MSR_RI) | (1 << MSR_EE));
> -        tcg_gen_andi_tl(cpu_msr, cpu_msr,
> +        tcg_gen_andi_tl(t1, cpu_msr,
>                          ~(target_ulong)((1 << MSR_RI) | (1 << MSR_EE)));
> -        tcg_gen_or_tl(cpu_msr, cpu_msr, t0);
> +        tcg_gen_or_tl(t1, t1, t0);
> +
> +        gen_helper_store_msr(cpu_env, t1);
>          tcg_temp_free(t0);
> +        tcg_temp_free(t1);
> +
>      } else {
>          /*
>           * XXX: we need to update nip before the store if we enter
>           *      power saving mode, we will exit the loop directly from
>           *      ppc_store_msr
>           */
> -        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
> -            gen_io_start();
> -        }
>          gen_update_nip(ctx, ctx->base.pc_next);
>          gen_helper_store_msr(cpu_env, cpu_gpr[rS(ctx->opcode)]);
> -        /* Must stop the translation as machine state (may have) changed=
 */
> -        /* Note that mtmsr is not always defined as context-synchronizin=
g */
> -        gen_stop_exception(ctx);
>      }
> +    /* Must stop the translation as machine state (may have) changed */
> +    gen_stop_exception(ctx);
>  #endif /* !defined(CONFIG_USER_ONLY) */
>  }
>  #endif /* defined(TARGET_PPC64) */
> @@ -4394,15 +4398,23 @@ static void gen_mtmsr(DisasContext *ctx)
>      CHK_SV;
> =20
>  #if !defined(CONFIG_USER_ONLY)
> -   if (ctx->opcode & 0x00010000) {
> -        /* Special form that does not need any synchronisation */
> +    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
> +        gen_io_start();
> +    }
> +    if (ctx->opcode & 0x00010000) {
> +        /* L=3D1 form only updates EE and RI */
>          TCGv t0 =3D tcg_temp_new();
> +        TCGv t1 =3D tcg_temp_new();
>          tcg_gen_andi_tl(t0, cpu_gpr[rS(ctx->opcode)],
>                          (1 << MSR_RI) | (1 << MSR_EE));
> -        tcg_gen_andi_tl(cpu_msr, cpu_msr,
> +        tcg_gen_andi_tl(t1, cpu_msr,
>                          ~(target_ulong)((1 << MSR_RI) | (1 << MSR_EE)));
> -        tcg_gen_or_tl(cpu_msr, cpu_msr, t0);
> +        tcg_gen_or_tl(t1, t1, t0);
> +
> +        gen_helper_store_msr(cpu_env, t1);
>          tcg_temp_free(t0);
> +        tcg_temp_free(t1);
> +
>      } else {
>          TCGv msr =3D tcg_temp_new();
> =20
> @@ -4411,9 +4423,6 @@ static void gen_mtmsr(DisasContext *ctx)
>           *      power saving mode, we will exit the loop directly from
>           *      ppc_store_msr
>           */
> -        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
> -            gen_io_start();
> -        }
>          gen_update_nip(ctx, ctx->base.pc_next);
>  #if defined(TARGET_PPC64)
>          tcg_gen_deposit_tl(msr, cpu_msr, cpu_gpr[rS(ctx->opcode)], 0, 32=
);
> @@ -4422,10 +4431,9 @@ static void gen_mtmsr(DisasContext *ctx)
>  #endif
>          gen_helper_store_msr(cpu_env, msr);
>          tcg_temp_free(msr);
> -        /* Must stop the translation as machine state (may have) changed=
 */
> -        /* Note that mtmsr is not always defined as context-synchronizin=
g */
> -        gen_stop_exception(ctx);
>      }
> +    /* Must stop the translation as machine state (may have) changed */
> +    gen_stop_exception(ctx);
>  #endif
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6Y+uoACgkQbDjKyiDZ
s5IfvQ/7B95w2bN1JzPlxMZJbbl/6U1RSYX643qSwxmHp3qmmWV4okUgaNzsVscC
mBl17DQbHuvl8YJduL5G6qNwfnkcEq+OIfX3k60QyQ+bf7ETK5UlmUq3c4Ao/E7e
H9O44iv5RSBZ41TQoYUVC+1IU11Mx0GXMsKiGkHOCCB3aK9no22rY4Um9LoEhHLB
Kue9WvNLlOcUm78BJ/00K70UffTgnbyR6q/CzUY81Lq1vuohZ1SdJWb6z8DeJLLe
XQ9Thne+6Z48MN/tPc0gLg6MF/NSaXzC4jeuI6Ht6WHe2P1USIgB+CrRpUmU/eK2
cpeHUZjg1oZgvno8v9uoKyQloTdaNczVJ4HmdMjt0+FmEhUFyZqx6o5aW4V93BV7
tPUc0TxNORcc31ol2gjBVWzQRTHbF5dq3rCBJzVellzUg6hA+H/AXudVRR1Z/Szk
CzbvVhLCpbJXmx5e/g0MZJnvejOjOTM1WLi0VwibH/ZIGVBbFP0wwG5GfAkP7D9+
/8YX1vb+5E8a10ThMP01hyQFJjjFbhkLilT6IMwJAzf5rv3josFj+QI5wKmt9b6n
zI2f0xkb15zX4aMAwTj05ReDQ7qA3ICwcu4As2N32PqO9j+jJ08sAzpkH6e2zXDE
Jb0Ew1oM/n0XkPQHIRIE4pjGhpgafPyOaK5PLokVaSpm1D/2hfU=
=Qw8M
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--

