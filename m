Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D490DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 17:24:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AFBC2071A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 17:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AFBC2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv2hP-0005Yr-T5
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 12:24:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.rikalo@rt-rk.com>) id 1iv2gd-0004N5-On
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:24:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.rikalo@rt-rk.com>) id 1iv2ga-00052v-Tx
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:24:03 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:53005 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.rikalo@rt-rk.com>)
 id 1iv2ga-0004zJ-EJ
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:24:00 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 3EE1E1A2040;
 Fri, 24 Jan 2020 18:23:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from [10.10.14.141] (rtrkw304-lin.domain.local [10.10.14.141])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 1A2001A1E2C;
 Fri, 24 Jan 2020 18:23:58 +0100 (CET)
Subject: Re: [PATCH v4 4/7] target/mips: Add implementation of GINVT
 instruction
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1579883929-1517-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1579883929-1517-5-git-send-email-aleksandar.markovic@rt-rk.com>
From: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Message-ID: <9aff44ea-d646-3617-98b3-bb523542b2d8@rt-rk.com>
Date: Fri, 24 Jan 2020 18:23:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1579883929-1517-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
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
Cc: Yongbok Kim <yongbok.kim@mips.com>, aurelien@aurel32.net,
 amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 > From: Yongbok Kim <yongbok.kim@mips.com>
 >
 > Implement emulation of GINVT instruction. As QEMU doesn't support
 > caches and virtualization, this implementation covers only GINVT
 > (Global Invalidate TLB) instruction among TLB-related instructions.
 >
 > Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
 > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
 > ---
 >=C2=A0 disas/mips.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
 >=C2=A0 target/mips/cpu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 2 +-
 >=C2=A0 target/mips/helper.c=C2=A0=C2=A0=C2=A0 |=C2=A0 20 ++++++--
 >=C2=A0 target/mips/helper.h=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
 >=C2=A0 target/mips/internal.h=C2=A0 |=C2=A0=C2=A0 1 +
 >=C2=A0 target/mips/op_helper.c | 129=20
+++++++++++++++++++++++++++++++++++++++++-------
 >=C2=A0 target/mips/translate.c |=C2=A0 46 ++++++++++++++++-
 >=C2=A0 7 files changed, 176 insertions(+), 26 deletions(-)
 >
 > diff --git a/disas/mips.c b/disas/mips.c
 > index 75c48b3..cedfbf8 100644
 > --- a/disas/mips.c
 > +++ b/disas/mips.c
 > @@ -1417,6 +1417,8 @@ const struct mips_opcode mips_builtin_opcodes[] =
=3D
 >=C2=A0 {"crc32ch",=C2=A0=C2=A0=C2=A0 "t,v,t", 0x7c00014f, 0xfc00ff3f, W=
R_d | RD_s |=20
RD_t,=C2=A0=C2=A0 0, I32R6},
 >=C2=A0 {"crc32cw",=C2=A0=C2=A0=C2=A0 "t,v,t", 0x7c00018f, 0xfc00ff3f, W=
R_d | RD_s |=20
RD_t,=C2=A0=C2=A0 0, I32R6},
 >=C2=A0 {"crc32cd",=C2=A0=C2=A0=C2=A0 "t,v,t", 0x7c0001cf, 0xfc00ff3f, W=
R_d | RD_s |=20
RD_t,=C2=A0=C2=A0 0, I64R6},
 > +{"ginvi",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "v",=C2=A0=C2=A0=C2=A0=C2=A0 =
0x7c00003d, 0xfc1ffcff, TRAP |=20
INSN_TLB,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, I32R6},
 > +{"ginvt",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "v",=C2=A0=C2=A0=C2=A0=C2=A0 =
0x7c0000bd, 0xfc1ffcff, TRAP |=20
INSN_TLB,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, I32R6},
 >
 >=C2=A0 /* MSA */
 >=C2=A0 {"sll.b",=C2=A0=C2=A0 "+d,+e,+f", 0x7800000d, 0xffe0003f, WR_VD|=
RD_VS|RD_VT,=C2=A0=20
0, MSA},
 > diff --git a/target/mips/cpu.h b/target/mips/cpu.h
 > index a7e9857..fdab989 100644
 > --- a/target/mips/cpu.h
 > +++ b/target/mips/cpu.h
 > @@ -309,7 +309,7 @@ typedef struct mips_def_t mips_def_t;
 >=C2=A0 #define CP0_REG04__USERLOCAL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 2
 >=C2=A0 #define CP0_REG04__XCONTEXTCONFIG=C2=A0 3
 >=C2=A0 #define CP0_REG04__DBGCONTEXTID=C2=A0=C2=A0=C2=A0 4
 > -#define CP0_REG00__MMID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 5
 > +#define CP0_REG04__MMID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 5
 >=C2=A0 /* CP0 Register 05 */
 >=C2=A0 #define CP0_REG05__PAGEMASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0
 >=C2=A0 #define CP0_REG05__PAGEGRAIN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 1
 > diff --git a/target/mips/helper.c b/target/mips/helper.c
 > index 781930a..afd78b1 100644
 > --- a/target/mips/helper.c
 > +++ b/target/mips/helper.c
 > @@ -72,8 +72,13 @@ int r4k_map_address(CPUMIPSState *env, hwaddr=20
*physical, int *prot,
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_ulong addre=
ss, int rw, int access_type)
 >=C2=A0 {
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t ASID =3D env->CP0_EntryHi & env=
->CP0_EntryHi_ASID_mask;
 > +=C2=A0=C2=A0=C2=A0 uint32_t MMID =3D env->CP0_MemoryMapID;
 > +=C2=A0=C2=A0=C2=A0 bool mi =3D !!((env->CP0_Config5 >> CP0C5_MI) & 1)=
;
 > +=C2=A0=C2=A0=C2=A0 uint32_t tlb_mmid;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
 >
 > +=C2=A0=C2=A0=C2=A0 MMID =3D mi ? MMID : (uint32_t) ASID;
 > +
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < env->tlb->tlb_in_use; =
i++) {
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r4k_tlb_t *tlb =3D=
 &env->tlb->mmu.r4k.tlb[i];
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 1k pages are =
not supported. */
 > @@ -84,8 +89,9 @@ int r4k_map_address(CPUMIPSState *env, hwaddr=20
*physical, int *prot,
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tag &=3D env->SE=
GMask;
 >=C2=A0 #endif
 >
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Check ASID, virtual pag=
e number & size */
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((tlb->G =3D=3D 1 || tl=
b->ASID =3D=3D ASID) && VPN =3D=3D tag &&=20
!tlb->EHINV) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Check ASID/MMID, virtua=
l page number & size */
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tlb_mmid =3D mi ? tlb->MMI=
D : (uint32_t) tlb->ASID;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((tlb->G =3D=3D 1 || tl=
b_mmid =3D=3D MMID) && VPN =3D=3D tag &&=20
!tlb->EHINV) {
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* TLB match */
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 int n =3D !!(address & mask & ~(mask >> 1));
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* Check access rights */
 > @@ -1418,14 +1424,20 @@ void r4k_invalidate_tlb(CPUMIPSState *env,=20
int idx, int use_extra)
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_ulong addr;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_ulong end;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t ASID =3D env->CP0_EntryHi & env=
->CP0_EntryHi_ASID_mask;
 > +=C2=A0=C2=A0=C2=A0 uint32_t MMID =3D env->CP0_MemoryMapID;
 > +=C2=A0=C2=A0=C2=A0 bool mi =3D !!((env->CP0_Config5 >> CP0C5_MI) & 1)=
;
 > +=C2=A0=C2=A0=C2=A0 uint32_t tlb_mmid;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_ulong mask;
 >
 > +=C2=A0=C2=A0=C2=A0 MMID =3D mi ? MMID : (uint32_t) ASID;
 > +
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tlb =3D &env->tlb->mmu.r4k.tlb[idx];
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
 > -=C2=A0=C2=A0=C2=A0=C2=A0 * The qemu TLB is flushed when the ASID chan=
ges, so no need to
 > +=C2=A0=C2=A0=C2=A0=C2=A0 * The qemu TLB is flushed when the ASID/MMID=
 changes, so no need to
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * flush these entries again.
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
 > -=C2=A0=C2=A0=C2=A0 if (tlb->G =3D=3D 0 && tlb->ASID !=3D ASID) {
 > +=C2=A0=C2=A0=C2=A0 tlb_mmid =3D mi ? tlb->MMID : (uint32_t) tlb->ASID=
;
 > +=C2=A0=C2=A0=C2=A0 if (tlb->G =3D=3D 0 && tlb_mmid !=3D MMID) {
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 >
 > diff --git a/target/mips/helper.h b/target/mips/helper.h
 > index 032ea8a..acf7b82 100644
 > --- a/target/mips/helper.h
 > +++ b/target/mips/helper.h
 > @@ -122,6 +122,7 @@ DEF_HELPER_2(mtc0_tcschefback, void, env, tl)
 >=C2=A0 DEF_HELPER_2(mttc0_tcschefback, void, env, tl)
 >=C2=A0 DEF_HELPER_2(mtc0_entrylo1, void, env, tl)
 >=C2=A0 DEF_HELPER_2(mtc0_context, void, env, tl)
 > +DEF_HELPER_2(mtc0_memorymapid, void, env, tl)
 >=C2=A0 DEF_HELPER_2(mtc0_pagemask, void, env, tl)
 >=C2=A0 DEF_HELPER_2(mtc0_pagegrain, void, env, tl)
 >=C2=A0 DEF_HELPER_2(mtc0_segctl0, void, env, tl)
 > @@ -378,6 +379,7 @@ DEF_HELPER_1(ei, tl, env)
 >=C2=A0 DEF_HELPER_1(eret, void, env)
 >=C2=A0 DEF_HELPER_1(eretnc, void, env)
 >=C2=A0 DEF_HELPER_1(deret, void, env)
 > +DEF_HELPER_3(ginvt, void, env, tl, i32)
 >=C2=A0 #endif /* !CONFIG_USER_ONLY */
 >=C2=A0 DEF_HELPER_1(rdhwr_cpunum, tl, env)
 >=C2=A0 DEF_HELPER_1(rdhwr_synci_step, tl, env)
 > diff --git a/target/mips/internal.h b/target/mips/internal.h
 > index 3f435b5..df55f84 100644
 > --- a/target/mips/internal.h
 > +++ b/target/mips/internal.h
 > @@ -95,6 +95,7 @@ struct r4k_tlb_t {
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_ulong VPN;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t PageMask;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t ASID;
 > +=C2=A0=C2=A0=C2=A0 uint32_t MMID;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int G:1;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int C0:3;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int C1:3;
 > diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
 > index bcff2f9..a331d9d 100644
 > --- a/target/mips/op_helper.c
 > +++ b/target/mips/op_helper.c
 > @@ -1470,6 +1470,17 @@ void helper_mtc0_context(CPUMIPSState *env,=20
target_ulong arg1)
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_Context =3D (env->CP0_Context &=
 0x007FFFFF) | (arg1 &=20
~0x007FFFFF);
 >=C2=A0 }
 >
 > +void helper_mtc0_memorymapid(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int32_t old;
 > +=C2=A0=C2=A0=C2=A0 old =3D env->CP0_MemoryMapID;
 > +=C2=A0=C2=A0=C2=A0 env->CP0_MemoryMapID =3D (int32_t) arg1;
 > +=C2=A0=C2=A0=C2=A0 /* If the MemoryMapID changes, flush qemu's TLB.=C2=
=A0 */
 > +=C2=A0=C2=A0=C2=A0 if (old !=3D env->CP0_MemoryMapID) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_mips_tlb_flush(env);
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 >=C2=A0 void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32=
_t=20
*pagemask)
 >=C2=A0 {
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t mask =3D arg1 >> (TARGET_PAGE_B=
ITS + 1);
 > @@ -1906,6 +1917,8 @@ void helper_mtc0_config5(CPUMIPSState *env,=20
target_ulong arg1)
 >=C2=A0 {
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_Config5 =3D (env->CP0_Config5 &=
=20
(~env->CP0_Config5_rw_bitmask)) |
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
(arg1 & env->CP0_Config5_rw_bitmask);
 > +=C2=A0=C2=A0=C2=A0 env->CP0_EntryHi_ASID_mask =3D (env->CP0_Config5 &=
 (1 << CP0C5_MI)) ?
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x=
0 : (env->CP0_Config4 & (1 << CP0C4_AE)) ? 0x3ff : 0xff;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compute_hflags(env);
 >=C2=A0 }
 >
 > @@ -2349,6 +2362,7 @@ static void r4k_fill_tlb(CPUMIPSState *env, int=20
idx)
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tlb->VPN &=3D env->SEGMask;
 >=C2=A0 #endif
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tlb->ASID =3D env->CP0_EntryHi & env->CP=
0_EntryHi_ASID_mask;
 > +=C2=A0=C2=A0=C2=A0 tlb->MMID =3D env->CP0_MemoryMapID;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tlb->PageMask =3D env->CP0_PageMask;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tlb->G =3D env->CP0_EntryLo0 & env->CP0_=
EntryLo1 & 1;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tlb->V0 =3D (env->CP0_EntryLo0 & 2) !=3D=
 0;
 > @@ -2367,13 +2381,18 @@ static void r4k_fill_tlb(CPUMIPSState *env,=20
int idx)
 >
 >=C2=A0 void r4k_helper_tlbinv(CPUMIPSState *env)
 >=C2=A0 {
 > -=C2=A0=C2=A0=C2=A0 int idx;
 > -=C2=A0=C2=A0=C2=A0 r4k_tlb_t *tlb;
 > +=C2=A0=C2=A0=C2=A0 bool mi =3D !!((env->CP0_Config5 >> CP0C5_MI) & 1)=
;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t ASID =3D env->CP0_EntryHi & env=
->CP0_EntryHi_ASID_mask;
 > +=C2=A0=C2=A0=C2=A0 uint32_t MMID =3D env->CP0_MemoryMapID;
 > +=C2=A0=C2=A0=C2=A0 uint32_t tlb_mmid;
 > +=C2=A0=C2=A0=C2=A0 r4k_tlb_t *tlb;
 > +=C2=A0=C2=A0=C2=A0 int idx;
 >
 > +=C2=A0=C2=A0=C2=A0 MMID =3D mi ? MMID : (uint32_t) ASID;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (idx =3D 0; idx < env->tlb->nb_tlb; =
idx++) {
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tlb =3D &env->tl=
b->mmu.r4k.tlb[idx];
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!tlb->G && tlb->ASID =3D=
=3D ASID) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tlb_mmid =3D mi ? tlb->MMI=
D : (uint32_t) tlb->ASID;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!tlb->G && tlb_mmid =3D=
=3D MMID) {
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 tlb->EHINV =3D 1;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > @@ -2392,11 +2411,16 @@ void r4k_helper_tlbinvf(CPUMIPSState *env)
 >
 >=C2=A0 void r4k_helper_tlbwi(CPUMIPSState *env)
 >=C2=A0 {
 > -=C2=A0=C2=A0=C2=A0 r4k_tlb_t *tlb;
 > -=C2=A0=C2=A0=C2=A0 int idx;
 > +=C2=A0=C2=A0=C2=A0 bool mi =3D !!((env->CP0_Config5 >> CP0C5_MI) & 1)=
;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_ulong VPN;
 > -=C2=A0=C2=A0=C2=A0 uint16_t ASID;
 > +=C2=A0=C2=A0=C2=A0 uint16_t ASID =3D env->CP0_EntryHi & env->CP0_Entr=
yHi_ASID_mask;
 > +=C2=A0=C2=A0=C2=A0 uint32_t MMID =3D env->CP0_MemoryMapID;
 > +=C2=A0=C2=A0=C2=A0 uint32_t tlb_mmid;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool EHINV, G, V0, D0, V1, D1, XI0, XI1,=
 RI0, RI1;
 > +=C2=A0=C2=A0=C2=A0 r4k_tlb_t *tlb;
 > +=C2=A0=C2=A0=C2=A0 int idx;
 > +
 > +=C2=A0=C2=A0=C2=A0 MMID =3D mi ? MMID : (uint32_t) ASID;
 >
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 idx =3D (env->CP0_Index & ~0x80000000) %=
 env->tlb->nb_tlb;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tlb =3D &env->tlb->mmu.r4k.tlb[idx];
 > @@ -2404,7 +2428,6 @@ void r4k_helper_tlbwi(CPUMIPSState *env)
 >=C2=A0 #if defined(TARGET_MIPS64)
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VPN &=3D env->SEGMask;
 >=C2=A0 #endif
 > -=C2=A0=C2=A0=C2=A0 ASID =3D env->CP0_EntryHi & env->CP0_EntryHi_ASID_=
mask;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EHINV =3D (env->CP0_EntryHi & (1 << CP0E=
nHi_EHINV)) !=3D 0;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 G =3D env->CP0_EntryLo0 & env->CP0_Entry=
Lo1 & 1;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 V0 =3D (env->CP0_EntryLo0 & 2) !=3D 0;
 > @@ -2416,11 +2439,12 @@ void r4k_helper_tlbwi(CPUMIPSState *env)
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 XI1 =3D (env->CP0_EntryLo1 >> CP0EnLo_XI=
) &1;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RI1 =3D (env->CP0_EntryLo1 >> CP0EnLo_RI=
) &1;
 >
 > +=C2=A0=C2=A0=C2=A0 tlb_mmid =3D mi ? tlb->MMID : (uint32_t) tlb->ASID=
;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Discard cached TLB entries, unle=
ss tlbwi is just upgrading access
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * permissions on the current entry=
.
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
 > -=C2=A0=C2=A0=C2=A0 if (tlb->VPN !=3D VPN || tlb->ASID !=3D ASID || tl=
b->G !=3D G ||
 > +=C2=A0=C2=A0=C2=A0 if (tlb->VPN !=3D VPN || tlb_mmid !=3D MMID || tlb=
->G !=3D G ||
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (!tlb->EHINV && =
EHINV) ||
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (tlb->V0 && !V0)=
 || (tlb->D0 && !D0) ||
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (!tlb->XI0 && XI=
0) || (!tlb->RI0 && RI0) ||
 > @@ -2443,14 +2467,17 @@ void r4k_helper_tlbwr(CPUMIPSState *env)
 >
 >=C2=A0 void r4k_helper_tlbp(CPUMIPSState *env)
 >=C2=A0 {
 > +=C2=A0=C2=A0=C2=A0 bool mi =3D !!((env->CP0_Config5 >> CP0C5_MI) & 1)=
;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r4k_tlb_t *tlb;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_ulong mask;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_ulong tag;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_ulong VPN;
 > -=C2=A0=C2=A0=C2=A0 uint16_t ASID;
 > +=C2=A0=C2=A0=C2=A0 uint16_t ASID =3D env->CP0_EntryHi & env->CP0_Entr=
yHi_ASID_mask;
 > +=C2=A0=C2=A0=C2=A0 uint32_t MMID =3D env->CP0_MemoryMapID;
 > +=C2=A0=C2=A0=C2=A0 uint32_t tlb_mmid;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
 >
 > -=C2=A0=C2=A0=C2=A0 ASID =3D env->CP0_EntryHi & env->CP0_EntryHi_ASID_=
mask;
 > +=C2=A0=C2=A0=C2=A0 MMID =3D mi ? MMID : (uint32_t) ASID;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < env->tlb->nb_tlb; i++)=
 {
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tlb =3D &env->tl=
b->mmu.r4k.tlb[i];
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 1k pages are =
not supported. */
 > @@ -2460,8 +2487,9 @@ void r4k_helper_tlbp(CPUMIPSState *env)
 >=C2=A0 #if defined(TARGET_MIPS64)
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tag &=3D env->SE=
GMask;
 >=C2=A0 #endif
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Check ASID, virtual pag=
e number & size */
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((tlb->G =3D=3D 1 || tl=
b->ASID =3D=3D ASID) && VPN =3D=3D tag &&=20
!tlb->EHINV) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tlb_mmid =3D mi ? tlb->MMI=
D : (uint32_t) tlb->ASID;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Check ASID/MMID, virtua=
l page number & size */
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((tlb->G =3D=3D 1 || tl=
b_mmid =3D=3D MMID) && VPN =3D=3D tag &&=20
!tlb->EHINV) {
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* TLB match */
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 env->CP0_Index =3D i;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 break;
 > @@ -2478,8 +2506,9 @@ void r4k_helper_tlbp(CPUMIPSState *env)
 >=C2=A0 #if defined(TARGET_MIPS64)
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 tag &=3D env->SEGMask;
 >=C2=A0 #endif
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 Check ASID, virtual page number & size */
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 ((tlb->G =3D=3D 1 || tlb->ASID =3D=3D ASID) && VPN =3D=3D tag) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tl=
b_mmid =3D mi ? tlb->MMID : (uint32_t) tlb->ASID;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 Check ASID/MMID, virtual page number & size */
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 ((tlb->G =3D=3D 1 || tlb_mmid =3D=3D MMID) && VPN =3D=3D tag) {
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r4k_mips_tlb_flush_extra(env, i);
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
 > @@ -2501,16 +2530,20 @@ static inline uint64_t=20
get_entrylo_pfn_from_tlb(uint64_t tlb_pfn)
 >
 >=C2=A0 void r4k_helper_tlbr(CPUMIPSState *env)
 >=C2=A0 {
 > +=C2=A0=C2=A0=C2=A0 bool mi =3D !!((env->CP0_Config5 >> CP0C5_MI) & 1)=
;
 > +=C2=A0=C2=A0=C2=A0 uint16_t ASID =3D env->CP0_EntryHi & env->CP0_Entr=
yHi_ASID_mask;
 > +=C2=A0=C2=A0=C2=A0 uint32_t MMID =3D env->CP0_MemoryMapID;
 > +=C2=A0=C2=A0=C2=A0 uint32_t tlb_mmid;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r4k_tlb_t *tlb;
 > -=C2=A0=C2=A0=C2=A0 uint16_t ASID;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int idx;
 >
 > -=C2=A0=C2=A0=C2=A0 ASID =3D env->CP0_EntryHi & env->CP0_EntryHi_ASID_=
mask;
 > +=C2=A0=C2=A0=C2=A0 MMID =3D mi ? MMID : (uint32_t) ASID;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 idx =3D (env->CP0_Index & ~0x80000000) %=
 env->tlb->nb_tlb;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tlb =3D &env->tlb->mmu.r4k.tlb[idx];
 >
 > -=C2=A0=C2=A0=C2=A0 /* If this will change the current ASID, flush qem=
u's TLB.=C2=A0 */
 > -=C2=A0=C2=A0=C2=A0 if (ASID !=3D tlb->ASID) {
 > +=C2=A0=C2=A0=C2=A0 tlb_mmid =3D mi ? tlb->MMID : (uint32_t) tlb->ASID=
;
 > +=C2=A0=C2=A0=C2=A0 /* If this will change the current ASID/MMID, flus=
h qemu's TLB.=C2=A0 */
 > +=C2=A0=C2=A0=C2=A0 if (MMID !=3D tlb_mmid) {
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_mips_tlb_flu=
sh(env);
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 >
 > @@ -2522,7 +2555,8 @@ void r4k_helper_tlbr(CPUMIPSState *env)
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_EntryLo=
0 =3D 0;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_EntryLo=
1 =3D 0;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_EntryHi =3D tlb->=
VPN | tlb->ASID;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_EntryHi =3D mi ? =
tlb->VPN : tlb->VPN | tlb->ASID;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_MemoryMapID =3D t=
lb->MMID;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_PageMas=
k =3D tlb->PageMask;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_EntryLo=
0 =3D tlb->G | (tlb->V0 << 1) | (tlb->D0 << 2) |
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ((uint64_t)tlb->RI0 << CP0EnLo_RI) |
 > @@ -2565,6 +2599,63 @@ void helper_tlbinvf(CPUMIPSState *env)
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->tlb->helper_tlbinvf(env);
 >=C2=A0 }
 >
 > +static void global_invalidate_tlb(CPUMIPSState *env,
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 uint32_t invMsgVPN2,
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 uint8_t invMsgR,
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 uint32_t invMsgMMid,
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 bool invAll,
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 bool invVAMMid,
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 bool invMMid,
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 bool invVA)
 > +{
 > +
 > +=C2=A0=C2=A0=C2=A0 int idx;
 > +=C2=A0=C2=A0=C2=A0 r4k_tlb_t *tlb;
 > +=C2=A0=C2=A0=C2=A0 bool VAMatch;
 > +=C2=A0=C2=A0=C2=A0 bool MMidMatch;
 > +
 > +=C2=A0=C2=A0=C2=A0 for (idx =3D 0; idx < env->tlb->nb_tlb; idx++) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tlb =3D &env->tlb->mmu.r4k=
.tlb[idx];
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VAMatch =3D
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((=
(tlb->VPN & ~tlb->PageMask) =3D=3D (invMsgVPN2 &=20
~tlb->PageMask))
 > +#ifdef TARGET_MIPS64
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &&
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (e=
xtract64(env->CP0_EntryHi, 62, 2) =3D=3D invMsgR)
 > +#endif
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 );
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MMidMatch =3D tlb->MMID =3D=
=3D invMsgMMid;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((invAll && (idx > env-=
>CP0_Wired)) ||
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (V=
AMatch && invVAMMid && (tlb->G || MMidMatch)) ||
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (V=
AMatch && invVA) ||
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (M=
MidMatch && !(tlb->G) && invMMid)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tl=
b->EHINV =3D 1;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 cpu_mips_tlb_flush(env);
 > +}
 > +
 > +void helper_ginvt(CPUMIPSState *env, target_ulong arg, uint32_t type)
 > +{
 > +=C2=A0=C2=A0=C2=A0 bool invAll =3D type =3D=3D 0;
 > +=C2=A0=C2=A0=C2=A0 bool invVA =3D type =3D=3D 1;
 > +=C2=A0=C2=A0=C2=A0 bool invMMid =3D type =3D=3D 2;
 > +=C2=A0=C2=A0=C2=A0 bool invVAMMid =3D type =3D=3D 3;
 > +=C2=A0=C2=A0=C2=A0 uint32_t invMsgVPN2 =3D arg & (TARGET_PAGE_MASK <<=
 1);
 > +=C2=A0=C2=A0=C2=A0 uint8_t invMsgR =3D 0;
 > +=C2=A0=C2=A0=C2=A0 uint32_t invMsgMMid =3D env->CP0_MemoryMapID;
 > +=C2=A0=C2=A0=C2=A0 CPUState *other_cs =3D first_cpu;
 > +
 > +#ifdef TARGET_MIPS64
 > +=C2=A0=C2=A0=C2=A0 invMsgR =3D extract64(arg, 62, 2);
 > +#endif
 > +
 > +=C2=A0=C2=A0=C2=A0 CPU_FOREACH(other_cs) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MIPSCPU *other_cpu =3D MIP=
S_CPU(other_cs);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 global_invalidate_tlb(&oth=
er_cpu->env, invMsgVPN2, invMsgR,=20
invMsgMMid,
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 invAll, invVAMMid, invMMid, invVA);
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 >=C2=A0 /* Specials */
 >=C2=A0 target_ulong helper_di(CPUMIPSState *env)
 >=C2=A0 {
 > diff --git a/target/mips/translate.c b/target/mips/translate.c
 > index 7cda5c7..b3c177f 100644
 > --- a/target/mips/translate.c
 > +++ b/target/mips/translate.c
 > @@ -388,6 +388,7 @@ enum {
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OPC_BSHFL=C2=A0=C2=A0=C2=A0 =3D 0x20 | O=
PC_SPECIAL3,
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OPC_DBSHFL=C2=A0=C2=A0 =3D 0x24 | OPC_SP=
ECIAL3,
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OPC_RDHWR=C2=A0=C2=A0=C2=A0 =3D 0x3B | O=
PC_SPECIAL3,
 > +=C2=A0=C2=A0=C2=A0 OPC_GINV=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x3D | OPC_SP=
ECIAL3,
 >
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Loongson 2E */
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OPC_MULT_G_2E=C2=A0=C2=A0 =3D 0x18 | OPC=
_SPECIAL3,
 > @@ -2550,6 +2551,7 @@ typedef struct DisasContext {
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool saar;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool crcp;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool mi;
 > +=C2=A0=C2=A0=C2=A0 int gi;
 >=C2=A0 } DisasContext;
 >
 >=C2=A0 #define DISAS_STOP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DISAS_TAR=
GET_0
 > @@ -7133,6 +7135,11 @@ static void gen_mfc0(DisasContext *ctx, TCGv=20
arg, int reg, int sel)
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 tcg_gen_ext32s_tl(arg, arg);
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 register_name =3D "UserLocal";
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case CP0_REG04__MMID:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CP=
0_CHECK(ctx->mi);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ge=
n_helper_mtc0_memorymapid(cpu_env, arg);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
gister_name =3D "MMID";
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto cp0_unimplemented;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > @@ -7873,6 +7880,11 @@ static void gen_mtc0(DisasContext *ctx, TCGv=20
arg, int reg, int sel)
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 offsetof(CPUMIPSState,=20
active_tc.CP0_UserLocal));
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 register_name =3D "UserLocal";
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case CP0_REG04__MMID:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CP=
0_CHECK(ctx->mi);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ge=
n_mfc0_load32(arg, offsetof(CPUMIPSState,=20
CP0_MemoryMapID));
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
gister_name =3D "MMID";
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto cp0_unimplemented;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > @@ -8631,6 +8643,11 @@ static void gen_dmfc0(DisasContext *ctx, TCGv=20
arg, int reg, int sel)
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 offsetof(CPUMIPSState,=20
active_tc.CP0_UserLocal));
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 register_name =3D "UserLocal";
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case CP0_REG04__MMID:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CP=
0_CHECK(ctx->mi);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ge=
n_helper_mtc0_memorymapid(cpu_env, arg);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
gister_name =3D "MMID";
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto cp0_unimplemented;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > @@ -9353,6 +9370,11 @@ static void gen_dmtc0(DisasContext *ctx, TCGv=20
arg, int reg, int sel)
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 offsetof(CPUMIPSState,=20
active_tc.CP0_UserLocal));
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 register_name =3D "UserLocal";
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case CP0_REG04__MMID:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CP=
0_CHECK(ctx->mi);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ge=
n_mfc0_load32(arg, offsetof(CPUMIPSState,=20
CP0_MemoryMapID));
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
gister_name =3D "MMID";
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto cp0_unimplemented;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > @@ -27335,6 +27357,25 @@ static void=20
decode_opc_special3_r6(CPUMIPSState *env, DisasContext *ctx)
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +#ifndef CONFIG_USER_ONLY
 > +=C2=A0=C2=A0=C2=A0 case OPC_GINV:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(ctx->gi <=3D =
1)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ge=
nerate_exception_end(ctx, EXCP_RI);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 check_cp0_enabled(ctx);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch ((ctx->opcode >> 6)=
 & 3) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 0:=C2=A0=C2=A0=C2=A0 =
/* GINVI */
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 Treat as NOP. */
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 2:=C2=A0=C2=A0=C2=A0 =
/* GINVT */
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ge=
n_helper_0e1i(ginvt, cpu_gpr[rs],=20
extract32(ctx->opcode, 8, 2));
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ge=
nerate_exception_end(ctx, EXCP_RI);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +#endif
 >=C2=A0 #if defined(TARGET_MIPS64)
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case R6_OPC_SCD:
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_st_cond(ctx,=
 rt, rs, imm, MO_TEQ, false);
 > @@ -30894,6 +30935,7 @@ static void=20
mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctx->abs2008 =3D (env->active_fpu.fcr31 =
>> FCR31_ABS2008) & 1;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctx->crcp =3D (env->CP0_Config5 >> CP0C5=
_CRCP) & 1;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctx->mi =3D (env->CP0_Config5 >> CP0C5_M=
I) & 1;
 > +=C2=A0=C2=A0=C2=A0 ctx->gi =3D (env->CP0_Config5 >> CP0C5_GI) & 3;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 restore_cpu_state(env, ctx);
 >=C2=A0 #ifdef CONFIG_USER_ONLY
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctx->mem_idx =3D=
 MIPS_HFLAG_UM;
 > @@ -31354,8 +31396,8 @@ void cpu_state_reset(CPUMIPSState *env)
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (env->CP0_Config3 & (1 << CP0C3_CMGCR=
)) {
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_CMGCRBa=
se =3D 0x1fbf8000 >> 4;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 env->CP0_EntryHi_ASID_mask =3D (env->CP0_Config4 &=
 (1 << CP0C4_AE)) ?
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x3ff : 0xff;
 > +=C2=A0=C2=A0=C2=A0 env->CP0_EntryHi_ASID_mask =3D (env->CP0_Config5 &=
 (1 << CP0C5_MI)) ?
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x=
0 : (env->CP0_Config4 & (1 << CP0C4_AE)) ? 0x3ff : 0xff;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_Status =3D (1 << CP0St_BEV) | (=
1 << CP0St_ERL);
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Vectored interrupts not implemen=
ted, timer on int 7,

Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>


