Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FF4C76195
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:02:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40BF2217F9
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="G/IUvUBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40BF2217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnZGt-00030H-QM
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 22:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44983)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hnZG9-00011O-9H
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hnZG6-0008Ca-Sp
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:01:33 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:51403 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hnZG6-000871-4o; Tue, 16 Jul 2019 22:01:30 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45pL8z5lYJz9s7T; Wed, 17 Jul 2019 12:01:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563328883;
 bh=eHBAcs8SfUa2hPOJI9LCNnmeLhLbLanVmYWPVfoHkhg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=G/IUvUBNmh4rKCDNbxCcppdrPm37UcvpW7X4iE6/yczZyJYPhjQK+Aj0rZiv4POsM
 ITTfttjF7z0Xx6LGb2T+fu3242qnd7O/C8F+jDcJyIu9qyTLuSmpeba7Ra4ZDqYATa
 +dgUP/Zw39qYutFQT13fVweM3BfZFlIW8y/FjD9U=
Date: Wed, 17 Jul 2019 11:33:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Message-ID: <20190717013346.GB2217@umbus.fritz.box>
References: <20190716121352.302-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <20190716121352.302-1-alex.bennee@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [RFC PATCH for 4.1?] target/ppc: move opcode
 decode tables to PowerPCCPU
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
Cc: "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 1836558@bugs.launchpad.net, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2019 at 01:13:52PM +0100, Alex Benn=E9e wrote:
> The opcode decode tables aren't really part of the CPUPPCState but an
> internal implementation detail for the translator. This can cause
> problems with memcpy in cpu_copy as any table created during
> ppc_cpu_realize get written over causing a memory leak. To avoid this
> move the tables into PowerPCCPU which is better suited to hold
> internal implementation details.
>=20
> Attempts to fix: https://bugs.launchpad.net/qemu/+bug/1836558
> Cc: 1836558@bugs.launchpad.net
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>

I've applied this now to ppc-for-4.2.  If there's an argument for
including it in 4.1 during hard freeze, you'll need to spell it out
for me.

> ---
>  target/ppc/cpu.h                |  8 ++++----
>  target/ppc/translate.c          |  3 ++-
>  target/ppc/translate_init.inc.c | 16 +++++++---------
>  3 files changed, 13 insertions(+), 14 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index c9beba2a5c0..10e34b69b75 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1104,10 +1104,6 @@ struct CPUPPCState {
>      bool resume_as_sreset;
>  #endif
> =20
> -    /* Those resources are used only during code translation */
> -    /* opcode handlers */
> -    opc_handler_t *opcodes[PPC_CPU_OPCODES_LEN];
> -
>      /* Those resources are used only in QEMU core */
>      target_ulong hflags;      /* hflags is a MSR & HFLAGS_MASK         */
>      target_ulong hflags_nmsr; /* specific hflags, not coming from MSR */
> @@ -1191,6 +1187,10 @@ struct PowerPCCPU {
>      int32_t node_id; /* NUMA node this CPU belongs to */
>      PPCHash64Options *hash64_opts;
> =20
> +    /* Those resources are used only during code translation */
> +    /* opcode handlers */
> +    opc_handler_t *opcodes[PPC_CPU_OPCODES_LEN];
> +
>      /* Fields related to migration compatibility hacks */
>      bool pre_2_8_migration;
>      target_ulong mig_msr_mask;
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 4a5de280365..c0faab8a824 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -7857,6 +7857,7 @@ static bool ppc_tr_breakpoint_check(DisasContextBas=
e *dcbase, CPUState *cs,
>  static void ppc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
>  {
>      DisasContext *ctx =3D container_of(dcbase, DisasContext, base);
> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      CPUPPCState *env =3D cs->env_ptr;
>      opc_handler_t **table, *handler;
> =20
> @@ -7874,7 +7875,7 @@ static void ppc_tr_translate_insn(DisasContextBase =
*dcbase, CPUState *cs)
>                opc3(ctx->opcode), opc4(ctx->opcode),
>                ctx->le_mode ? "little" : "big");
>      ctx->base.pc_next +=3D 4;
> -    table =3D env->opcodes;
> +    table =3D cpu->opcodes;
>      handler =3D table[opc1(ctx->opcode)];
>      if (is_indirect_opcode(handler)) {
>          table =3D ind_table(handler);
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 86fc8f2e316..9cd2033bb92 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -9440,14 +9440,13 @@ static void fix_opcode_tables(opc_handler_t **ppc=
_opcodes)
>  static void create_ppc_opcodes(PowerPCCPU *cpu, Error **errp)
>  {
>      PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> -    CPUPPCState *env =3D &cpu->env;
>      opcode_t *opc;
> =20
> -    fill_new_table(env->opcodes, PPC_CPU_OPCODES_LEN);
> +    fill_new_table(cpu->opcodes, PPC_CPU_OPCODES_LEN);
>      for (opc =3D opcodes; opc < &opcodes[ARRAY_SIZE(opcodes)]; opc++) {
>          if (((opc->handler.type & pcc->insns_flags) !=3D 0) ||
>              ((opc->handler.type2 & pcc->insns_flags2) !=3D 0)) {
> -            if (register_insn(env->opcodes, opc) < 0) {
> +            if (register_insn(cpu->opcodes, opc) < 0) {
>                  error_setg(errp, "ERROR initializing PowerPC instruction=
 "
>                             "0x%02x 0x%02x 0x%02x", opc->opc1, opc->opc2,
>                             opc->opc3);
> @@ -9455,7 +9454,7 @@ static void create_ppc_opcodes(PowerPCCPU *cpu, Err=
or **errp)
>              }
>          }
>      }
> -    fix_opcode_tables(env->opcodes);
> +    fix_opcode_tables(cpu->opcodes);
>      fflush(stdout);
>      fflush(stderr);
>  }
> @@ -10023,7 +10022,6 @@ static void ppc_cpu_unrealize(DeviceState *dev, E=
rror **errp)
>  {
>      PowerPCCPU *cpu =3D POWERPC_CPU(dev);
>      PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> -    CPUPPCState *env =3D &cpu->env;
>      Error *local_err =3D NULL;
>      opc_handler_t **table, **table_2;
>      int i, j, k;
> @@ -10035,11 +10033,11 @@ static void ppc_cpu_unrealize(DeviceState *dev,=
 Error **errp)
>      }
> =20
>      for (i =3D 0; i < PPC_CPU_OPCODES_LEN; i++) {
> -        if (env->opcodes[i] =3D=3D &invalid_handler) {
> +        if (cpu->opcodes[i] =3D=3D &invalid_handler) {
>              continue;
>          }
> -        if (is_indirect_opcode(env->opcodes[i])) {
> -            table =3D ind_table(env->opcodes[i]);
> +        if (is_indirect_opcode(cpu->opcodes[i])) {
> +            table =3D ind_table(cpu->opcodes[i]);
>              for (j =3D 0; j < PPC_CPU_INDIRECT_OPCODES_LEN; j++) {
>                  if (table[j] =3D=3D &invalid_handler) {
>                      continue;
> @@ -10057,7 +10055,7 @@ static void ppc_cpu_unrealize(DeviceState *dev, E=
rror **errp)
>                                               ~PPC_INDIRECT));
>                  }
>              }
> -            g_free((opc_handler_t *)((uintptr_t)env->opcodes[i] &
> +            g_free((opc_handler_t *)((uintptr_t)cpu->opcodes[i] &
>                  ~PPC_INDIRECT));
>          }
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0uevkACgkQbDjKyiDZ
s5KplhAApH47ERLfDN20o/oildYB7LIQdFUJ3OAFScMrkY2v5CTG08ST5k6f+ils
zCEH2Nr//LBIOqhVe88fdddOnX1pOVC2ueGBHRV8XNSCz1AKzyJTDOKjWQ6osDCj
/wz27upT+H49JoeNijCYz4QcXZ1HRzr2Hn0ztxut0iWT/upRoxfwT8Wu7RyNF5Rx
cQf0NF8AxkpfBE1st6QXCUH51LJSWcuX5AEbw8kdNBhtL1Aul0mgmaJJ3xDqdO49
Th9btMulNEw1Xr+WAxF2PW/n6Fquv6UZDxFGPoyBoxJofc8FYLsiEsRZwAEwBPFL
6TRL/XWtWINlw2pjk1PpL+r2S6lplfFm2tO/PRh20YR7iNyAimM5xutsoBIsNWKN
1T4FoUMlbLngYxhnNL6UG6XhnGgffhQE9ro7RBigVlLCIz+YqAte1AT7Kx5cjOku
7d4JIRLw3gDIyoLr3r8GYdJGvR76BXktEK2kD1Tmkk61/3Lko1Qhv077DXp3Uttd
ONKAAu8BOgnIpUnmh9TiGKhEJbf/XD8UiF0BurFHLAZPmXTrSXJm9WKHsH5kBhqz
HEd7ryZdS72D9yH7oqkBOxfDm143aAZj8RVQtHMQJfUhx1zMoFFff/TBdL2yyoMu
fzRzWot4uaXceYbgMQWCiJ4R8/ne5hG/gUBWMQE2z1wlBwJY3rY=
=N5YD
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--

