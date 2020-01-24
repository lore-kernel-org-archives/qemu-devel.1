Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1185C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 17:24:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F2F2071A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 17:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F2F2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv2gn-0004Ls-II
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 12:24:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53903)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.rikalo@rt-rk.com>) id 1iv2fn-0003Nw-WD
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:23:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.rikalo@rt-rk.com>) id 1iv2fm-0003wA-0w
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:23:11 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:47491 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.rikalo@rt-rk.com>)
 id 1iv2fl-0003Nh-LE
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:23:09 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 3BE211A2040;
 Fri, 24 Jan 2020 18:22:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from [10.10.14.141] (rtrkw304-lin.domain.local [10.10.14.141])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 22D501A1E2C;
 Fri, 24 Jan 2020 18:22:04 +0100 (CET)
Subject: Re: [PATCH v4 3/7] target/mips: Amend CP0 WatchHi register
 implementation
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1579883929-1517-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1579883929-1517-4-git-send-email-aleksandar.markovic@rt-rk.com>
From: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Message-ID: <d2d3e6ca-969f-f5e6-32cb-9854ca18e1e9@rt-rk.com>
Date: Fri, 24 Jan 2020 18:22:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1579883929-1517-4-git-send-email-aleksandar.markovic@rt-rk.com>
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
Cc: Yongbok Kim <yongbok.kim@mips.com>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


 > From: Yongbok Kim <yongbok.kim@mips.com>
 >
 > WatchHi is extended by the field MemoryMapID with the GINVT instructio=
n.
 > The field is accessible by MTHC0/MFHC0 in 32-bit architectures and DMT=
C0/
 > DMFC0 in 64-bit architectures.
 >
 > Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
 > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
 > ---
 >=C2=A0 target/mips/cpu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 =
+-
 >=C2=A0 target/mips/helper.h=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +++
 >=C2=A0 target/mips/machine.c=C2=A0=C2=A0 |=C2=A0 6 +++---
 >=C2=A0 target/mips/op_helper.c | 23 +++++++++++++++++++++--
 >=C2=A0 target/mips/translate.c | 42 +++++++++++++++++++++++++++++++++++=
++++++-
 >=C2=A0 5 files changed, 69 insertions(+), 7 deletions(-)
 >
 > diff --git a/target/mips/cpu.h b/target/mips/cpu.h
 > index ca00f41..a7e9857 100644
 > --- a/target/mips/cpu.h
 > +++ b/target/mips/cpu.h
 > @@ -961,7 +961,7 @@ struct CPUMIPSState {
 >=C2=A0 /*
 >=C2=A0=C2=A0 * CP0 Register 19
 >=C2=A0=C2=A0 */
 > -=C2=A0=C2=A0=C2=A0 int32_t CP0_WatchHi[8];
 > +=C2=A0=C2=A0=C2=A0 uint64_t CP0_WatchHi[8];
 >=C2=A0 #define CP0WH_ASID 16
 >=C2=A0 /*
 >=C2=A0=C2=A0 * CP0 Register 20
 > diff --git a/target/mips/helper.h b/target/mips/helper.h
 > index 2095330..032ea8a 100644
 > --- a/target/mips/helper.h
 > +++ b/target/mips/helper.h
 > @@ -80,6 +80,7 @@ DEF_HELPER_1(mfc0_maar, tl, env)
 >=C2=A0 DEF_HELPER_1(mfhc0_maar, tl, env)
 >=C2=A0 DEF_HELPER_2(mfc0_watchlo, tl, env, i32)
 >=C2=A0 DEF_HELPER_2(mfc0_watchhi, tl, env, i32)
 > +DEF_HELPER_2(mfhc0_watchhi, tl, env, i32)
 >=C2=A0 DEF_HELPER_1(mfc0_debug, tl, env)
 >=C2=A0 DEF_HELPER_1(mftc0_debug, tl, env)
 >=C2=A0 #ifdef TARGET_MIPS64
 > @@ -91,6 +92,7 @@ DEF_HELPER_1(dmfc0_tcschefback, tl, env)
 >=C2=A0 DEF_HELPER_1(dmfc0_lladdr, tl, env)
 >=C2=A0 DEF_HELPER_1(dmfc0_maar, tl, env)
 >=C2=A0 DEF_HELPER_2(dmfc0_watchlo, tl, env, i32)
 > +DEF_HELPER_2(dmfc0_watchhi, tl, env, i32)
 >=C2=A0 DEF_HELPER_1(dmfc0_saar, tl, env)
 >=C2=A0 #endif /* TARGET_MIPS64 */
 >
 > @@ -161,6 +163,7 @@ DEF_HELPER_2(mthc0_maar, void, env, tl)
 >=C2=A0 DEF_HELPER_2(mtc0_maari, void, env, tl)
 >=C2=A0 DEF_HELPER_3(mtc0_watchlo, void, env, tl, i32)
 >=C2=A0 DEF_HELPER_3(mtc0_watchhi, void, env, tl, i32)
 > +DEF_HELPER_3(mthc0_watchhi, void, env, tl, i32)
 >=C2=A0 DEF_HELPER_2(mtc0_xcontext, void, env, tl)
 >=C2=A0 DEF_HELPER_2(mtc0_framemask, void, env, tl)
 >=C2=A0 DEF_HELPER_2(mtc0_debug, void, env, tl)
 > diff --git a/target/mips/machine.c b/target/mips/machine.c
 > index c139239..8d5b18b 100644
 > --- a/target/mips/machine.c
 > +++ b/target/mips/machine.c
 > @@ -212,8 +212,8 @@ const VMStateDescription vmstate_tlb =3D {
 >
 >=C2=A0 const VMStateDescription vmstate_mips_cpu =3D {
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "cpu",
 > -=C2=A0=C2=A0=C2=A0 .version_id =3D 18,
 > -=C2=A0=C2=A0=C2=A0 .minimum_version_id =3D 18,
 > +=C2=A0=C2=A0=C2=A0 .version_id =3D 19,
 > +=C2=A0=C2=A0=C2=A0 .minimum_version_id =3D 19,
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .post_load =3D cpu_post_load,
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .fields =3D (VMStateField[]) {
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Active TC */
 > @@ -296,7 +296,7 @@ const VMStateDescription vmstate_mips_cpu =3D {
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_INT32(en=
v.CP0_MAARI, MIPSCPU),
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINTTL(e=
nv.lladdr, MIPSCPU),
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINTTL_A=
RRAY(env.CP0_WatchLo, MIPSCPU, 8),
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_INT32_ARRAY(env.CP=
0_WatchHi, MIPSCPU, 8),
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT64_ARRAY(env.C=
P0_WatchHi, MIPSCPU, 8),
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINTTL(e=
nv.CP0_XContext, MIPSCPU),
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_INT32(en=
v.CP0_Framemask, MIPSCPU),
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_INT32(en=
v.CP0_Debug, MIPSCPU),
 > diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
 > index 5cd396d..bcff2f9 100644
 > --- a/target/mips/op_helper.c
 > +++ b/target/mips/op_helper.c
 > @@ -1026,7 +1026,12 @@ target_ulong helper_mfc0_watchlo(CPUMIPSState=20
*env, uint32_t sel)
 >
 >=C2=A0 target_ulong helper_mfc0_watchhi(CPUMIPSState *env, uint32_t sel=
)
 >=C2=A0 {
 > -=C2=A0=C2=A0=C2=A0 return env->CP0_WatchHi[sel];
 > +=C2=A0=C2=A0=C2=A0 return (int32_t) env->CP0_WatchHi[sel];
 > +}
 > +
 > +target_ulong helper_mfhc0_watchhi(CPUMIPSState *env, uint32_t sel)
 > +{
 > +=C2=A0=C2=A0=C2=A0 return env->CP0_WatchHi[sel] >> 32;
 >=C2=A0 }
 >
 >=C2=A0 target_ulong helper_mfc0_debug(CPUMIPSState *env)
 > @@ -1104,6 +1109,11 @@ target_ulong helper_dmfc0_saar(CPUMIPSState *en=
v)
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
 >=C2=A0 }
 > +
 > +target_ulong helper_dmfc0_watchhi(CPUMIPSState *env, uint32_t sel)
 > +{
 > +=C2=A0=C2=A0=C2=A0 return env->CP0_WatchHi[sel];
 > +}
 >=C2=A0 #endif /* TARGET_MIPS64 */
 >
 >=C2=A0 void helper_mtc0_index(CPUMIPSState *env, target_ulong arg1)
 > @@ -1950,11 +1960,20 @@ void helper_mtc0_watchlo(CPUMIPSState *env,=20
target_ulong arg1, uint32_t sel)
 >
 >=C2=A0 void helper_mtc0_watchhi(CPUMIPSState *env, target_ulong arg1,=20
uint32_t sel)
 >=C2=A0 {
 > -=C2=A0=C2=A0=C2=A0 int mask =3D 0x40000FF8 | (env->CP0_EntryHi_ASID_m=
ask << CP0WH_ASID);
 > +=C2=A0=C2=A0=C2=A0 uint64_t mask =3D 0x40000FF8 | (env->CP0_EntryHi_A=
SID_mask <<=20
CP0WH_ASID);
 > +=C2=A0=C2=A0=C2=A0 if ((env->CP0_Config5 >> CP0C5_MI) & 1) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D 0xFFFFFFFF000000=
00ULL; /* MMID */
 > +=C2=A0=C2=A0=C2=A0 }
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_WatchHi[sel] =3D arg1 & mask;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_WatchHi[sel] &=3D ~(env->CP0_Wa=
tchHi[sel] & arg1 & 0x7);
 >=C2=A0 }
 >
 > +void helper_mthc0_watchhi(CPUMIPSState *env, target_ulong arg1,=20
uint32_t sel)
 > +{
 > +=C2=A0=C2=A0=C2=A0 env->CP0_WatchHi[sel] =3D ((uint64_t) (arg1) << 32=
) |
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (env->CP0_WatchHi[sel] &=20
0x00000000ffffffffULL);
 > +}
 > +
 >=C2=A0 void helper_mtc0_xcontext(CPUMIPSState *env, target_ulong arg1)
 >=C2=A0 {
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_ulong mask =3D (1ULL << (env->SEG=
BITS - 7)) - 1;
 > diff --git a/target/mips/translate.c b/target/mips/translate.c
 > index 1b38356..7cda5c7 100644
 > --- a/target/mips/translate.c
 > +++ b/target/mips/translate.c
 > @@ -2549,6 +2549,7 @@ typedef struct DisasContext {
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool abs2008;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool saar;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool crcp;
 > +=C2=A0=C2=A0=C2=A0 bool mi;
 >=C2=A0 } DisasContext;
 >
 >=C2=A0 #define DISAS_STOP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DISAS_TAR=
GET_0
 > @@ -6785,6 +6786,25 @@ static void gen_mfhc0(DisasContext *ctx, TCGv=20
arg, int reg, int sel)
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto cp0_unimplemented;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case CP0_REGISTER_19:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (sel) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 0:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 1:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 2:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 3:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 4:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 5:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 6:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 7:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 upper 32 bits are only available when Config5MI !=3D 0 */
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CP=
0_CHECK(ctx->mi);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ge=
n_mfhc0_load64(arg, offsetof(CPUMIPSState,=20
CP0_WatchHi[sel]), 0);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
gister_name =3D "WatchHi";
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to cp0_unimplemented;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case CP0_REGISTER_28:
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (sel) {
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 0:
 > @@ -6871,6 +6891,25 @@ static void gen_mthc0(DisasContext *ctx, TCGv=20
arg, int reg, int sel)
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto cp0_unimplemented;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case CP0_REGISTER_19:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (sel) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 0:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 1:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 2:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 3:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 4:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 5:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 6:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 7:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 upper 32 bits are only available when Config5MI !=3D 0 */
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CP=
0_CHECK(ctx->mi);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ge=
n_helper_0e1i(mthc0_watchhi, arg, sel);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
gister_name =3D "WatchHi";
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to cp0_unimplemented;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case CP0_REGISTER_28:
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (sel) {
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 0:
 > @@ -8924,7 +8963,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv=20
arg, int reg, int sel)
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case CP0_REG19__=
WATCHHI6:
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case CP0_REG19__=
WATCHHI7:
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 CP0_CHECK(ctx->CP0_Config1 & (1 << CP0C1_WR));
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ge=
n_helper_1e0i(mfc0_watchhi, arg, sel);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ge=
n_helper_1e0i(dmfc0_watchhi, arg, sel);
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 register_name =3D "WatchHi";
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 break;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
 > @@ -30854,6 +30893,7 @@ static void=20
mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctx->nan2008 =3D (env->active_fpu.fcr31 =
>> FCR31_NAN2008) & 1;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctx->abs2008 =3D (env->active_fpu.fcr31 =
>> FCR31_ABS2008) & 1;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctx->crcp =3D (env->CP0_Config5 >> CP0C5=
_CRCP) & 1;
 > +=C2=A0=C2=A0=C2=A0 ctx->mi =3D (env->CP0_Config5 >> CP0C5_MI) & 1;
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 restore_cpu_state(env, ctx);
 >=C2=A0 #ifdef CONFIG_USER_ONLY
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctx->mem_idx =3D=
 MIPS_HFLAG_UM;

Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>


