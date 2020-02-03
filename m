Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A83C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:31:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F684218AC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F684218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyedK-0002gc-HO
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 11:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.rikalo@rt-rk.com>) id 1iyeak-00081F-PR
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:29:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.rikalo@rt-rk.com>) id 1iyeaa-0007Rw-KM
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:28:54 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:37713 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.rikalo@rt-rk.com>)
 id 1iyeaZ-0004wR-Ae
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:28:44 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id D82691A1FE7;
 Mon,  3 Feb 2020 17:27:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from [10.10.14.141] (rtrkw304-lin.domain.local [10.10.14.141])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 98FD31A1E6F;
 Mon,  3 Feb 2020 17:27:39 +0100 (CET)
Subject: Re: [PATCH 2/2] target mips: Separate FPU-related helpers into their
 own file
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1580745443-24650-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580745443-24650-3-git-send-email-aleksandar.markovic@rt-rk.com>
From: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Message-ID: <ad79a7b7-a97a-1e18-c164-1eac4a1dd228@rt-rk.com>
Date: Mon, 3 Feb 2020 17:27:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1580745443-24650-3-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
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
Cc: amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 > From: Aleksandar Markovic <amarkovic@wavecomp.com>
 >
 > For clarity and easier maintenence, create target/mips/fpu_helper.c, a=
nd
 > move all fpu-related content form target/mips/op_helper.c to that file=
.
 >
 > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
 > ---
 >=C2=A0 target/mips/Makefile.objs |=C2=A0=C2=A0=C2=A0 2 +-
 >=C2=A0 target/mips/fpu_helper.c=C2=A0 | 1911=20
+++++++++++++++++++++++++++++++++++++++++++++
 >=C2=A0 target/mips/op_helper.c=C2=A0=C2=A0 | 1877=20
--------------------------------------------
 >=C2=A0 3 files changed, 1912 insertions(+), 1878 deletions(-)
 >=C2=A0 create mode 100644 target/mips/fpu_helper.c
 >
 > diff --git a/target/mips/Makefile.objs b/target/mips/Makefile.objs
 > index 3ca2bde..91eb691 100644
 > --- a/target/mips/Makefile.objs
 > +++ b/target/mips/Makefile.objs
 > @@ -1,5 +1,5 @@
 >=C2=A0 obj-y +=3D translate.o cpu.o gdbstub.o helper.o
 > -obj-y +=3D op_helper.o cp0_helper.o
 > +obj-y +=3D op_helper.o cp0_helper.o fpu_helper.o
 >=C2=A0 obj-y +=3D dsp_helper.o lmi_helper.o msa_helper.o
 >=C2=A0 obj-$(CONFIG_SOFTMMU) +=3D mips-semi.o
 >=C2=A0 obj-$(CONFIG_SOFTMMU) +=3D machine.o cp0_timer.o
 > diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
 > new file mode 100644
 > index 0000000..0d5769e
 > --- /dev/null
 > +++ b/target/mips/fpu_helper.c
 > @@ -0,0 +1,1911 @@
 > +/*
 > + *=C2=A0 Helpers for emulation of CP0-related MIPS instructions.
 > + *
 > + *=C2=A0 Copyright (C) 2004-2005=C2=A0 Jocelyn Mayer
 > + *=C2=A0 Copyright (C) 2020=C2=A0 Wave Computing, Inc.
 > + *=C2=A0 Copyright (C) 2020=C2=A0 Aleksandar Markovic <amarkovic@wave=
comp.com>
 > + *
 > + * This library is free software; you can redistribute it and/or
 > + * modify it under the terms of the GNU Lesser General Public
 > + * License as published by the Free Software Foundation; either
 > + * version 2 of the License, or (at your option) any later version.
 > + *
 > + * This library is distributed in the hope that it will be useful,
 > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
 > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
 GNU
 > + * Lesser General Public License for more details.
 > + *
 > + * You should have received a copy of the GNU Lesser General Public
 > + * License along with this library; if not, see=20
<http://www.gnu.org/licenses/>.
 > + *
 > + */
 > +
 > +#include "qemu/osdep.h"
 > +#include "qemu/main-loop.h"
 > +#include "cpu.h"
 > +#include "internal.h"
 > +#include "qemu/host-utils.h"
 > +#include "exec/helper-proto.h"
 > +#include "exec/exec-all.h"
 > +#include "exec/cpu_ldst.h"
 > +#include "exec/memop.h"
 > +#include "sysemu/kvm.h"
 > +#include "fpu/softfloat.h"
 > +
 > +
 > +/* Complex FPU operations which may need stack space. */
 > +
 > +#define FLOAT_TWO32 make_float32(1 << 30)
 > +#define FLOAT_TWO64 make_float64(1ULL << 62)
 > +
 > +#define FP_TO_INT32_OVERFLOW 0x7fffffff
 > +#define FP_TO_INT64_OVERFLOW 0x7fffffffffffffffULL
 > +
 > +/* convert MIPS rounding mode in FCR31 to IEEE library */
 > +unsigned int ieee_rm[] =3D {
 > +=C2=A0=C2=A0=C2=A0 float_round_nearest_even,
 > +=C2=A0=C2=A0=C2=A0 float_round_to_zero,
 > +=C2=A0=C2=A0=C2=A0 float_round_up,
 > +=C2=A0=C2=A0=C2=A0 float_round_down
 > +};
 > +
 > +target_ulong helper_cfc1(CPUMIPSState *env, uint32_t reg)
 > +{
 > +=C2=A0=C2=A0=C2=A0 target_ulong arg1 =3D 0;
 > +
 > +=C2=A0=C2=A0=C2=A0 switch (reg) {
 > +=C2=A0=C2=A0=C2=A0 case 0:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arg1 =3D (int32_t)env->act=
ive_fpu.fcr0;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case 1:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* UFR Support - Read Stat=
us FR */
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (env->active_fpu.fcr0 &=
 (1 << FCR0_UFRP)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (env->CP0_Config5 & (1 << CP0C5_UFR)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 arg1 =3D (int32_t)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((env->CP=
0_Status & (1=C2=A0 << CP0St_FR)) >>=20
CP0St_FR);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } =
else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 do_raise_exception(env, EXCP_RI, GETPC());
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case 5:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* FRE Support - read Conf=
ig5.FRE bit */
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (env->active_fpu.fcr0 &=
 (1 << FCR0_FREP)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (env->CP0_Config5 & (1 << CP0C5_UFE)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 arg1 =3D (env->CP0_Config5 >> CP0C5_FRE) & 1;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } =
else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 helper_raise_exception(env, EXCP_RI);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case 25:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arg1 =3D ((env->active_fpu=
.fcr31 >> 24) & 0xfe) |
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ((env->active_fpu.fcr31 >> 23) & 0x1);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case 26:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arg1 =3D env->active_fpu.f=
cr31 & 0x0003f07c;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case 28:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arg1 =3D (env->active_fpu.=
fcr31 & 0x00000f83) |
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ((env->active_fpu.fcr31 >> 22) & 0x4);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 default:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arg1 =3D (int32_t)env->act=
ive_fpu.fcr31;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 }
 > +
 > +=C2=A0=C2=A0=C2=A0 return arg1;
 > +}
 > +
 > +void helper_ctc1(CPUMIPSState *env, target_ulong arg1, uint32_t fs,=20
uint32_t rt)
 > +{
 > +=C2=A0=C2=A0=C2=A0 switch (fs) {
 > +=C2=A0=C2=A0=C2=A0 case 1:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* UFR Alias - Reset Statu=
s FR */
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!((env->active_fpu.fcr=
0 & (1 << FCR0_UFRP)) && (rt =3D=3D 0))) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (env->CP0_Config5 & (1 =
<< CP0C5_UFR)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 en=
v->CP0_Status &=3D ~(1 << CP0St_FR);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
mpute_hflags(env);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do=
_raise_exception(env, EXCP_RI, GETPC());
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case 4:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* UNFR Alias - Set Status=
 FR */
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!((env->active_fpu.fcr=
0 & (1 << FCR0_UFRP)) && (rt =3D=3D 0))) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (env->CP0_Config5 & (1 =
<< CP0C5_UFR)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 en=
v->CP0_Status |=3D (1 << CP0St_FR);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
mpute_hflags(env);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do=
_raise_exception(env, EXCP_RI, GETPC());
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case 5:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* FRE Support - clear Con=
fig5.FRE bit */
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!((env->active_fpu.fcr=
0 & (1 << FCR0_FREP)) && (rt =3D=3D 0))) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (env->CP0_Config5 & (1 =
<< CP0C5_UFE)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 en=
v->CP0_Config5 &=3D ~(1 << CP0C5_FRE);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
mpute_hflags(env);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 he=
lper_raise_exception(env, EXCP_RI);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case 6:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* FRE Support - set Confi=
g5.FRE bit */
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!((env->active_fpu.fcr=
0 & (1 << FCR0_FREP)) && (rt =3D=3D 0))) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (env->CP0_Config5 & (1 =
<< CP0C5_UFE)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 en=
v->CP0_Config5 |=3D (1 << CP0C5_FRE);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
mpute_hflags(env);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 he=
lper_raise_exception(env, EXCP_RI);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case 25:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((env->insn_flags & ISA=
_MIPS32R6) || (arg1 & 0xffffff00)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->active_fpu.fcr31 =3D =
(env->active_fpu.fcr31 & 0x017fffff) |
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((arg1 & 0xfe) << 24) |
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((arg1 & 0x1) << 23);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case 26:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (arg1 & 0x007c0000) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->active_fpu.fcr31 =3D =
(env->active_fpu.fcr31 & 0xfffc0f83) |
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (arg1 & 0x0003f07c);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case 28:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (arg1 & 0x007c0000) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->active_fpu.fcr31 =3D =
(env->active_fpu.fcr31 & 0xfefff07c) |
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (arg1 & 0x00000f83) |
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((arg1 & 0x4) << 22);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 case 31:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->active_fpu.fcr31 =3D =
(arg1 &=20
env->active_fpu.fcr31_rw_bitmask) |
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 (env->active_fpu.fcr31 &=20
~(env->active_fpu.fcr31_rw_bitmask));
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 default:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (env->insn_flags & ISA_=
MIPS32R6) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do=
_raise_exception(env, EXCP_RI, GETPC());
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 restore_fp_status(env);
 > +=C2=A0=C2=A0=C2=A0 set_float_exception_flags(0, &env->active_fpu.fp_s=
tatus);
 > +=C2=A0=C2=A0=C2=A0 if ((GET_FP_ENABLE(env->active_fpu.fcr31) | 0x20) =
&
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GET_FP_CAUSE(env->active_f=
pu.fcr31)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do_raise_exception(env, EX=
CP_FPE, GETPC());
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +int ieee_ex_to_mips(int xcpt)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int ret =3D 0;
 > +=C2=A0=C2=A0=C2=A0 if (xcpt) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (xcpt & float_flag_inva=
lid) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t |=3D FP_INVALID;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (xcpt & float_flag_over=
flow) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t |=3D FP_OVERFLOW;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (xcpt & float_flag_unde=
rflow) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t |=3D FP_UNDERFLOW;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (xcpt & float_flag_divb=
yzero) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t |=3D FP_DIV0;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (xcpt & float_flag_inex=
act) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t |=3D FP_INEXACT;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 return ret;
 > +}
 > +
 > +static inline void update_fcr31(CPUMIPSState *env, uintptr_t pc)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int tmp =3D ieee_ex_to_mips(get_float_exception_fl=
ags(
 > + &env->active_fpu.fp_status));
 > +
 > +=C2=A0=C2=A0=C2=A0 SET_FP_CAUSE(env->active_fpu.fcr31, tmp);
 > +
 > +=C2=A0=C2=A0=C2=A0 if (tmp) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_float_exception_flags(=
0, &env->active_fpu.fp_status);
 > +
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (GET_FP_ENABLE(env->act=
ive_fpu.fcr31) & tmp) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do=
_raise_exception(env, EXCP_FPE, pc);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 UP=
DATE_FP_FLAGS(env->active_fpu.fcr31, tmp);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +/*
 > + * Float support.
 > + * Single precition routines have a "s" suffix, double precision a
 > + * "d" suffix, 32bit integer "w", 64bit integer "l", paired single "p=
s",
 > + * paired single lower "pl", paired single upper "pu".
 > + */
 > +
 > +/* unary operations, modifying fp status=C2=A0 */
 > +uint64_t helper_float_sqrt_d(CPUMIPSState *env, uint64_t fdt0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 fdt0 =3D float64_sqrt(fdt0, &env->active_fpu.fp_st=
atus);
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return fdt0;
 > +}
 > +
 > +uint32_t helper_float_sqrt_s(CPUMIPSState *env, uint32_t fst0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 fst0 =3D float32_sqrt(fst0, &env->active_fpu.fp_st=
atus);
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return fst0;
 > +}
 > +
 > +uint64_t helper_float_cvtd_s(CPUMIPSState *env, uint32_t fst0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint64_t fdt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 fdt2 =3D float32_to_float64(fst0, &env->active_fpu=
.fp_status);
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return fdt2;
 > +}
 > +
 > +uint64_t helper_float_cvtd_w(CPUMIPSState *env, uint32_t wt0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint64_t fdt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 fdt2 =3D int32_to_float64(wt0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return fdt2;
 > +}
 > +
 > +uint64_t helper_float_cvtd_l(CPUMIPSState *env, uint64_t dt0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint64_t fdt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 fdt2 =3D int64_to_float64(dt0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return fdt2;
 > +}
 > +
 > +uint64_t helper_float_cvt_l_d(CPUMIPSState *env, uint64_t fdt0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 dt2 =3D float64_to_int64(fdt0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt2 =3D FP_TO_INT64_OVERFL=
OW;
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return dt2;
 > +}
 > +
 > +uint64_t helper_float_cvt_l_s(CPUMIPSState *env, uint32_t fst0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 dt2 =3D float32_to_int64(fst0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt2 =3D FP_TO_INT64_OVERFL=
OW;
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return dt2;
 > +}
 > +
 > +uint64_t helper_float_cvtps_pw(CPUMIPSState *env, uint64_t dt0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t fst2;
 > +=C2=A0=C2=A0=C2=A0 uint32_t fsth2;
 > +
 > +=C2=A0=C2=A0=C2=A0 fst2 =3D int32_to_float32(dt0 & 0XFFFFFFFF,=20
&env->active_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 fsth2 =3D int32_to_float32(dt0 >> 32, &env->active=
_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return ((uint64_t)fsth2 << 32) | fst2;
 > +}
 > +
 > +uint64_t helper_float_cvtpw_ps(CPUMIPSState *env, uint64_t fdt0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > +=C2=A0=C2=A0=C2=A0 uint32_t wth2;
 > +=C2=A0=C2=A0=C2=A0 int excp, excph;
 > +
 > +=C2=A0=C2=A0=C2=A0 wt2 =3D float32_to_int32(fdt0 & 0XFFFFFFFF,=20
&env->active_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 excp =3D get_float_exception_flags(&env->active_fp=
u.fp_status);
 > +=C2=A0=C2=A0=C2=A0 if (excp & (float_flag_overflow | float_flag_inval=
id)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt2 =3D FP_TO_INT32_OVERFL=
OW;
 > +=C2=A0=C2=A0=C2=A0 }
 > +
 > +=C2=A0=C2=A0=C2=A0 set_float_exception_flags(0, &env->active_fpu.fp_s=
tatus);
 > +=C2=A0=C2=A0=C2=A0 wth2 =3D float32_to_int32(fdt0 >> 32, &env->active=
_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 excph =3D get_float_exception_flags(&env->active_f=
pu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 if (excph & (float_flag_overflow | float_flag_inva=
lid)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wth2 =3D FP_TO_INT32_OVERF=
LOW;
 > +=C2=A0=C2=A0=C2=A0 }
 > +
 > +=C2=A0=C2=A0=C2=A0 set_float_exception_flags(excp | excph, &env->acti=
ve_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +
 > +=C2=A0=C2=A0=C2=A0 return ((uint64_t)wth2 << 32) | wt2;
 > +}
 > +
 > +uint32_t helper_float_cvts_d(CPUMIPSState *env, uint64_t fdt0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t fst2;
 > +
 > +=C2=A0=C2=A0=C2=A0 fst2 =3D float64_to_float32(fdt0, &env->active_fpu=
.fp_status);
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return fst2;
 > +}
 > +
 > +uint32_t helper_float_cvts_w(CPUMIPSState *env, uint32_t wt0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t fst2;
 > +
 > +=C2=A0=C2=A0=C2=A0 fst2 =3D int32_to_float32(wt0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return fst2;
 > +}
 > +
 > +uint32_t helper_float_cvts_l(CPUMIPSState *env, uint64_t dt0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t fst2;
 > +
 > +=C2=A0=C2=A0=C2=A0 fst2 =3D int64_to_float32(dt0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return fst2;
 > +}
 > +
 > +uint32_t helper_float_cvts_pl(CPUMIPSState *env, uint32_t wt0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 wt2 =3D wt0;
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return wt2;
 > +}
 > +
 > +uint32_t helper_float_cvts_pu(CPUMIPSState *env, uint32_t wth0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 wt2 =3D wth0;
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return wt2;
 > +}
 > +
 > +uint32_t helper_float_cvt_w_s(CPUMIPSState *env, uint32_t fst0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 wt2 =3D float32_to_int32(fst0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt2 =3D FP_TO_INT32_OVERFL=
OW;
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return wt2;
 > +}
 > +
 > +uint32_t helper_float_cvt_w_d(CPUMIPSState *env, uint64_t fdt0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 wt2 =3D float64_to_int32(fdt0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt2 =3D FP_TO_INT32_OVERFL=
OW;
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return wt2;
 > +}
 > +
 > +uint64_t helper_float_round_l_d(CPUMIPSState *env, uint64_t fdt0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_nearest_even,
 > + &env->active_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 dt2 =3D float64_to_int64(fdt0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt2 =3D FP_TO_INT64_OVERFL=
OW;
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return dt2;
 > +}
 > +
 > +uint64_t helper_float_round_l_s(CPUMIPSState *env, uint32_t fst0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_nearest_even,
 > + &env->active_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 dt2 =3D float32_to_int64(fst0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt2 =3D FP_TO_INT64_OVERFL=
OW;
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return dt2;
 > +}
 > +
 > +uint32_t helper_float_round_w_d(CPUMIPSState *env, uint64_t fdt0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_nearest_even,
 > + &env->active_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 wt2 =3D float64_to_int32(fdt0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt2 =3D FP_TO_INT32_OVERFL=
OW;
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return wt2;
 > +}
 > +
 > +uint32_t helper_float_round_w_s(CPUMIPSState *env, uint32_t fst0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_nearest_even,
 > + &env->active_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 wt2 =3D float32_to_int32(fst0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt2 =3D FP_TO_INT32_OVERFL=
OW;
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return wt2;
 > +}
 > +
 > +uint64_t helper_float_trunc_l_d(CPUMIPSState *env, uint64_t fdt0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 dt2 =3D float64_to_int64_round_to_zero(fdt0,
 > + &env->active_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt2 =3D FP_TO_INT64_OVERFL=
OW;
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return dt2;
 > +}
 > +
 > +uint64_t helper_float_trunc_l_s(CPUMIPSState *env, uint32_t fst0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 dt2 =3D float32_to_int64_round_to_zero(fst0,=20
&env->active_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt2 =3D FP_TO_INT64_OVERFL=
OW;
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return dt2;
 > +}
 > +
 > +uint32_t helper_float_trunc_w_d(CPUMIPSState *env, uint64_t fdt0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 wt2 =3D float64_to_int32_round_to_zero(fdt0,=20
&env->active_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt2 =3D FP_TO_INT32_OVERFL=
OW;
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return wt2;
 > +}
 > +
 > +uint32_t helper_float_trunc_w_s(CPUMIPSState *env, uint32_t fst0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 wt2 =3D float32_to_int32_round_to_zero(fst0,=20
&env->active_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt2 =3D FP_TO_INT32_OVERFL=
OW;
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return wt2;
 > +}
 > +
 > +uint64_t helper_float_ceil_l_d(CPUMIPSState *env, uint64_t fdt0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_up, &env->acti=
ve_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 dt2 =3D float64_to_int64(fdt0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt2 =3D FP_TO_INT64_OVERFL=
OW;
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return dt2;
 > +}
 > +
 > +uint64_t helper_float_ceil_l_s(CPUMIPSState *env, uint32_t fst0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_up, &env->acti=
ve_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 dt2 =3D float32_to_int64(fst0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt2 =3D FP_TO_INT64_OVERFL=
OW;
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return dt2;
 > +}
 > +
 > +uint32_t helper_float_ceil_w_d(CPUMIPSState *env, uint64_t fdt0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_up, &env->acti=
ve_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 wt2 =3D float64_to_int32(fdt0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt2 =3D FP_TO_INT32_OVERFL=
OW;
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return wt2;
 > +}
 > +
 > +uint32_t helper_float_ceil_w_s(CPUMIPSState *env, uint32_t fst0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_up, &env->acti=
ve_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 wt2 =3D float32_to_int32(fst0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt2 =3D FP_TO_INT32_OVERFL=
OW;
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return wt2;
 > +}
 > +
 > +uint64_t helper_float_floor_l_d(CPUMIPSState *env, uint64_t fdt0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_down,=20
&env->active_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 dt2 =3D float64_to_int64(fdt0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt2 =3D FP_TO_INT64_OVERFL=
OW;
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return dt2;
 > +}
 > +
 > +uint64_t helper_float_floor_l_s(CPUMIPSState *env, uint32_t fst0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_down,=20
&env->active_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 dt2 =3D float32_to_int64(fst0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt2 =3D FP_TO_INT64_OVERFL=
OW;
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return dt2;
 > +}
 > +
 > +uint32_t helper_float_floor_w_d(CPUMIPSState *env, uint64_t fdt0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_down,=20
&env->active_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 wt2 =3D float64_to_int32(fdt0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt2 =3D FP_TO_INT32_OVERFL=
OW;
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return wt2;
 > +}
 > +
 > +uint32_t helper_float_floor_w_s(CPUMIPSState *env, uint32_t fst0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_down,=20
&env->active_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 wt2 =3D float32_to_int32(fst0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt2 =3D FP_TO_INT32_OVERFL=
OW;
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return wt2;
 > +}
 > +
 > +uint64_t helper_float_cvt_2008_l_d(CPUMIPSState *env, uint64_t fdt0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 dt2 =3D float64_to_int64(fdt0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float64_is_any_nan(fdt=
0)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt=
2 =3D 0;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return dt2;
 > +}
 > +
 > +uint64_t helper_float_cvt_2008_l_s(CPUMIPSState *env, uint32_t fst0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 dt2 =3D float32_to_int64(fst0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float32_is_any_nan(fst=
0)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt=
2 =3D 0;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return dt2;
 > +}
 > +
 > +uint32_t helper_float_cvt_2008_w_d(CPUMIPSState *env, uint64_t fdt0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 wt2 =3D float64_to_int32(fdt0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float64_is_any_nan(fdt=
0)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt=
2 =3D 0;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return wt2;
 > +}
 > +
 > +uint32_t helper_float_cvt_2008_w_s(CPUMIPSState *env, uint32_t fst0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 wt2 =3D float32_to_int32(fst0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float32_is_any_nan(fst=
0)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt=
2 =3D 0;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return wt2;
 > +}
 > +
 > +uint64_t helper_float_round_2008_l_d(CPUMIPSState *env, uint64_t fdt0=
)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_nearest_even,
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &e=
nv->active_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 dt2 =3D float64_to_int64(fdt0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float64_is_any_nan(fdt=
0)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt=
2 =3D 0;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return dt2;
 > +}
 > +
 > +uint64_t helper_float_round_2008_l_s(CPUMIPSState *env, uint32_t fst0=
)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_nearest_even,
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &e=
nv->active_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 dt2 =3D float32_to_int64(fst0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float32_is_any_nan(fst=
0)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt=
2 =3D 0;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return dt2;
 > +}
 > +
 > +uint32_t helper_float_round_2008_w_d(CPUMIPSState *env, uint64_t fdt0=
)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_nearest_even,
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &e=
nv->active_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 wt2 =3D float64_to_int32(fdt0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float64_is_any_nan(fdt=
0)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt=
2 =3D 0;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return wt2;
 > +}
 > +
 > +uint32_t helper_float_round_2008_w_s(CPUMIPSState *env, uint32_t fst0=
)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_nearest_even,
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &e=
nv->active_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 wt2 =3D float32_to_int32(fst0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float32_is_any_nan(fst=
0)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt=
2 =3D 0;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return wt2;
 > +}
 > +
 > +uint64_t helper_float_trunc_2008_l_d(CPUMIPSState *env, uint64_t fdt0=
)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 dt2 =3D float64_to_int64_round_to_zero(fdt0,=20
&env->active_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float64_is_any_nan(fdt=
0)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt=
2 =3D 0;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return dt2;
 > +}
 > +
 > +uint64_t helper_float_trunc_2008_l_s(CPUMIPSState *env, uint32_t fst0=
)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 dt2 =3D float32_to_int64_round_to_zero(fst0,=20
&env->active_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float32_is_any_nan(fst=
0)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt=
2 =3D 0;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return dt2;
 > +}
 > +
 > +uint32_t helper_float_trunc_2008_w_d(CPUMIPSState *env, uint64_t fdt0=
)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 wt2 =3D float64_to_int32_round_to_zero(fdt0,=20
&env->active_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float64_is_any_nan(fdt=
0)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt=
2 =3D 0;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return wt2;
 > +}
 > +
 > +uint32_t helper_float_trunc_2008_w_s(CPUMIPSState *env, uint32_t fst0=
)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 wt2 =3D float32_to_int32_round_to_zero(fst0,=20
&env->active_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float32_is_any_nan(fst=
0)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt=
2 =3D 0;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return wt2;
 > +}
 > +
 > +uint64_t helper_float_ceil_2008_l_d(CPUMIPSState *env, uint64_t fdt0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_up, &env->acti=
ve_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 dt2 =3D float64_to_int64(fdt0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float64_is_any_nan(fdt=
0)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt=
2 =3D 0;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return dt2;
 > +}
 > +
 > +uint64_t helper_float_ceil_2008_l_s(CPUMIPSState *env, uint32_t fst0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_up, &env->acti=
ve_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 dt2 =3D float32_to_int64(fst0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float32_is_any_nan(fst=
0)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt=
2 =3D 0;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return dt2;
 > +}
 > +
 > +uint32_t helper_float_ceil_2008_w_d(CPUMIPSState *env, uint64_t fdt0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_up, &env->acti=
ve_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 wt2 =3D float64_to_int32(fdt0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float64_is_any_nan(fdt=
0)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt=
2 =3D 0;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return wt2;
 > +}
 > +
 > +uint32_t helper_float_ceil_2008_w_s(CPUMIPSState *env, uint32_t fst0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_up, &env->acti=
ve_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 wt2 =3D float32_to_int32(fst0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float32_is_any_nan(fst=
0)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt=
2 =3D 0;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return wt2;
 > +}
 > +
 > +uint64_t helper_float_floor_2008_l_d(CPUMIPSState *env, uint64_t fdt0=
)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_down,=20
&env->active_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 dt2 =3D float64_to_int64(fdt0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float64_is_any_nan(fdt=
0)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt=
2 =3D 0;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return dt2;
 > +}
 > +
 > +uint64_t helper_float_floor_2008_l_s(CPUMIPSState *env, uint32_t fst0=
)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_down,=20
&env->active_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 dt2 =3D float32_to_int64(fst0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float32_is_any_nan(fst=
0)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt=
2 =3D 0;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return dt2;
 > +}
 > +
 > +uint32_t helper_float_floor_2008_w_d(CPUMIPSState *env, uint64_t fdt0=
)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_down,=20
&env->active_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 wt2 =3D float64_to_int32(fdt0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float64_is_any_nan(fdt=
0)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt=
2 =3D 0;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return wt2;
 > +}
 > +
 > +uint32_t helper_float_floor_2008_w_s(CPUMIPSState *env, uint32_t fst0=
)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_down,=20
&env->active_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 wt2 =3D float32_to_int32(fst0, &env->active_fpu.fp=
_status);
 > +=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > +=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float32_is_any_nan(fst=
0)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt=
2 =3D 0;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return wt2;
 > +}
 > +
 > +/* unary operations, not modifying fp status=C2=A0 */
 > +#define FLOAT_UNOP(name) \
 > +uint64_t helper_float_ ## name ## _d(uint64_t fdt0)=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
\
 > +{ \
 > +=C2=A0=C2=A0=C2=A0 return float64_ ## name(fdt0); \
 > +} \
 > +uint32_t helper_float_ ## name ## _s(uint32_t fst0)=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
\
 > +{ \
 > +=C2=A0=C2=A0=C2=A0 return float32_ ## name(fst0); \
 > +} \
 > +uint64_t helper_float_ ## name ## _ps(uint64_t fdt0)=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +{ \
 > +=C2=A0=C2=A0=C2=A0 uint32_t wt0; \
 > +=C2=A0=C2=A0=C2=A0 uint32_t wth0; \
 > + \
 > +=C2=A0=C2=A0=C2=A0 wt0 =3D float32_ ## name(fdt0 & 0XFFFFFFFF);=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 wth0 =3D float32_ ## name(fdt0 >> 32);=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 return ((uint64_t)wth0 << 32) | wt0;=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +}
 > +FLOAT_UNOP(abs)
 > +FLOAT_UNOP(chs)
 > +#undef FLOAT_UNOP
 > +
 > +/* MIPS specific unary operations */
 > +uint64_t helper_float_recip_d(CPUMIPSState *env, uint64_t fdt0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint64_t fdt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 fdt2 =3D float64_div(float64_one, fdt0, &env->acti=
ve_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return fdt2;
 > +}
 > +
 > +uint32_t helper_float_recip_s(CPUMIPSState *env, uint32_t fst0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t fst2;
 > +
 > +=C2=A0=C2=A0=C2=A0 fst2 =3D float32_div(float32_one, fst0, &env->acti=
ve_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return fst2;
 > +}
 > +
 > +uint64_t helper_float_rsqrt_d(CPUMIPSState *env, uint64_t fdt0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint64_t fdt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 fdt2 =3D float64_sqrt(fdt0, &env->active_fpu.fp_st=
atus);
 > +=C2=A0=C2=A0=C2=A0 fdt2 =3D float64_div(float64_one, fdt2, &env->acti=
ve_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return fdt2;
 > +}
 > +
 > +uint32_t helper_float_rsqrt_s(CPUMIPSState *env, uint32_t fst0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t fst2;
 > +
 > +=C2=A0=C2=A0=C2=A0 fst2 =3D float32_sqrt(fst0, &env->active_fpu.fp_st=
atus);
 > +=C2=A0=C2=A0=C2=A0 fst2 =3D float32_div(float32_one, fst2, &env->acti=
ve_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return fst2;
 > +}
 > +
 > +uint64_t helper_float_recip1_d(CPUMIPSState *env, uint64_t fdt0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint64_t fdt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 fdt2 =3D float64_div(float64_one, fdt0, &env->acti=
ve_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return fdt2;
 > +}
 > +
 > +uint32_t helper_float_recip1_s(CPUMIPSState *env, uint32_t fst0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t fst2;
 > +
 > +=C2=A0=C2=A0=C2=A0 fst2 =3D float32_div(float32_one, fst0, &env->acti=
ve_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return fst2;
 > +}
 > +
 > +uint64_t helper_float_recip1_ps(CPUMIPSState *env, uint64_t fdt0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t fst2;
 > +=C2=A0=C2=A0=C2=A0 uint32_t fsth2;
 > +
 > +=C2=A0=C2=A0=C2=A0 fst2 =3D float32_div(float32_one, fdt0 & 0XFFFFFFF=
F,
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &env->act=
ive_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 fsth2 =3D float32_div(float32_one, fdt0 >> 32,=20
&env->active_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return ((uint64_t)fsth2 << 32) | fst2;
 > +}
 > +
 > +uint64_t helper_float_rsqrt1_d(CPUMIPSState *env, uint64_t fdt0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint64_t fdt2;
 > +
 > +=C2=A0=C2=A0=C2=A0 fdt2 =3D float64_sqrt(fdt0, &env->active_fpu.fp_st=
atus);
 > +=C2=A0=C2=A0=C2=A0 fdt2 =3D float64_div(float64_one, fdt2, &env->acti=
ve_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return fdt2;
 > +}
 > +
 > +uint32_t helper_float_rsqrt1_s(CPUMIPSState *env, uint32_t fst0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t fst2;
 > +
 > +=C2=A0=C2=A0=C2=A0 fst2 =3D float32_sqrt(fst0, &env->active_fpu.fp_st=
atus);
 > +=C2=A0=C2=A0=C2=A0 fst2 =3D float32_div(float32_one, fst2, &env->acti=
ve_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return fst2;
 > +}
 > +
 > +uint64_t helper_float_rsqrt1_ps(CPUMIPSState *env, uint64_t fdt0)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t fst2;
 > +=C2=A0=C2=A0=C2=A0 uint32_t fsth2;
 > +
 > +=C2=A0=C2=A0=C2=A0 fst2 =3D float32_sqrt(fdt0 & 0XFFFFFFFF, &env->act=
ive_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 fsth2 =3D float32_sqrt(fdt0 >> 32, &env->active_fp=
u.fp_status);
 > +=C2=A0=C2=A0=C2=A0 fst2 =3D float32_div(float32_one, fst2, &env->acti=
ve_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 fsth2 =3D float32_div(float32_one, fsth2, &env->ac=
tive_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return ((uint64_t)fsth2 << 32) | fst2;
 > +}
 > +
 > +#define FLOAT_RINT(name,=20
bits)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +uint ## bits ## _t helper_float_ ## name(CPUMIPSState=20
*env,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 uint ## bits ## _t=20
fs)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 \
 > +{ \
 > +=C2=A0=C2=A0=C2=A0 uint ## bits ## _t=20
fdret;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > + \
 > +=C2=A0=C2=A0=C2=A0 fdret =3D float ## bits ## _round_to_int(fs,=20
&env->active_fpu.fp_status); \
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env,=20
GETPC());=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 return=20
fdret;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +}
 > +
 > +FLOAT_RINT(rint_s, 32)
 > +FLOAT_RINT(rint_d, 64)
 > +#undef FLOAT_RINT
 > +
 > +#define FLOAT_CLASS_SIGNALING_NAN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x001
 > +#define FLOAT_CLASS_QUIET_NAN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x002
 > +#define FLOAT_CLASS_NEGATIVE_INFINITY=C2=A0 0x004
 > +#define FLOAT_CLASS_NEGATIVE_NORMAL=C2=A0=C2=A0=C2=A0 0x008
 > +#define FLOAT_CLASS_NEGATIVE_SUBNORMAL 0x010
 > +#define FLOAT_CLASS_NEGATIVE_ZERO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x020
 > +#define FLOAT_CLASS_POSITIVE_INFINITY=C2=A0 0x040
 > +#define FLOAT_CLASS_POSITIVE_NORMAL=C2=A0=C2=A0=C2=A0 0x080
 > +#define FLOAT_CLASS_POSITIVE_SUBNORMAL 0x100
 > +#define FLOAT_CLASS_POSITIVE_ZERO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x200
 > +
 > +#define FLOAT_CLASS(name, bits)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +uint ## bits ## _t float_ ## name(uint ## bits ## _t arg,=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float_status *stat=
us)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 \
 > +{ \
 > +=C2=A0=C2=A0=C2=A0 if (float ## bits ## _is_signaling_nan(arg, status=
)) {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return FLOAT_CLASS_SIGNALI=
NG_NAN;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 } else if (float ## bits ## _is_quiet_nan(arg, sta=
tus)) {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return FLOAT_CLASS_QUIET_N=
AN;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 } else if (float ## bits ## _is_neg(arg)) {=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float ## bits ## _is_i=
nfinity(arg)) {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn FLOAT_CLASS_NEGATIVE_INFINITY;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (float ## bits #=
# _is_zero(arg)) {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn FLOAT_CLASS_NEGATIVE_ZERO;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (float ## bits #=
# _is_zero_or_denormal(arg)) {=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn FLOAT_CLASS_NEGATIVE_SUBNORMAL;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn FLOAT_CLASS_NEGATIVE_NORMAL;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 \
 > + }=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 } else {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float ## bits ## _is_i=
nfinity(arg)) {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn FLOAT_CLASS_POSITIVE_INFINITY;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (float ## bits #=
# _is_zero(arg)) {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn FLOAT_CLASS_POSITIVE_ZERO;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (float ## bits #=
# _is_zero_or_denormal(arg)) {=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn FLOAT_CLASS_POSITIVE_SUBNORMAL;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn FLOAT_CLASS_POSITIVE_NORMAL;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 \
 > + }=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > + }=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 \
 > +} \
 > + \
 > +uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 uint ## bits ## _t arg)=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +{ \
 > +=C2=A0=C2=A0=C2=A0 return float_ ## name(arg, &env->active_fpu.fp_sta=
tus);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +}
 > +
 > +FLOAT_CLASS(class_s, 32)
 > +FLOAT_CLASS(class_d, 64)
 > +#undef FLOAT_CLASS
 > +
 > +/* binary operations */
 > +#define FLOAT_BINOP(name)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +uint64_t helper_float_ ## name ## _d(CPUMIPSState *env,=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
uint64_t fdt0, uint64_t fdt1) \
 > +{ \
 > +=C2=A0=C2=A0=C2=A0 uint64_t dt2;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > + \
 > +=C2=A0=C2=A0=C2=A0 dt2 =3D float64_ ## name(fdt0, fdt1, &env->active_=
fpu.fp_status);\
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 return dt2;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +} \
 > + \
 > +uint32_t helper_float_ ## name ## _s(CPUMIPSState *env,=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
uint32_t fst0, uint32_t fst1) \
 > +{ \
 > +=C2=A0=C2=A0=C2=A0 uint32_t wt2;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > + \
 > +=C2=A0=C2=A0=C2=A0 wt2 =3D float32_ ## name(fst0, fst1, &env->active_=
fpu.fp_status);\
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 return wt2;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +} \
 > + \
 > +uint64_t helper_float_ ## name ## _ps(CPUMIPSState *env,=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 uint64_t fdt0,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 uint64_t fdt1)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +{ \
 > +=C2=A0=C2=A0=C2=A0 uint32_t fst0 =3D fdt0 & 0XFFFFFFFF;=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
 > +=C2=A0=C2=A0=C2=A0 uint32_t fsth0 =3D fdt0 >> 32;=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 uint32_t fst1 =3D fdt1 & 0XFFFFFFFF;=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
 > +=C2=A0=C2=A0=C2=A0 uint32_t fsth1 =3D fdt1 >> 32;=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 uint32_t wt2;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 uint32_t wth2;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > + \
 > +=C2=A0=C2=A0=C2=A0 wt2 =3D float32_ ## name(fst0, fst1,=20
&env->active_fpu.fp_status);=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 wth2 =3D float32_ ## name(fsth0, fsth1,=20
&env->active_fpu.fp_status);=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 return ((uint64_t)wth2 << 32) | wt2;=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +}
 > +
 > +FLOAT_BINOP(add)
 > +FLOAT_BINOP(sub)
 > +FLOAT_BINOP(mul)
 > +FLOAT_BINOP(div)
 > +#undef FLOAT_BINOP
 > +
 > +/* MIPS specific binary operations */
 > +uint64_t helper_float_recip2_d(CPUMIPSState *env, uint64_t fdt0,=20
uint64_t fdt2)
 > +{
 > +=C2=A0=C2=A0=C2=A0 fdt2 =3D float64_mul(fdt0, fdt2, &env->active_fpu.=
fp_status);
 > +=C2=A0=C2=A0=C2=A0 fdt2 =3D float64_chs(float64_sub(fdt2, float64_one=
,
 > + &env->active_fpu.fp_status));
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return fdt2;
 > +}
 > +
 > +uint32_t helper_float_recip2_s(CPUMIPSState *env, uint32_t fst0,=20
uint32_t fst2)
 > +{
 > +=C2=A0=C2=A0=C2=A0 fst2 =3D float32_mul(fst0, fst2, &env->active_fpu.=
fp_status);
 > +=C2=A0=C2=A0=C2=A0 fst2 =3D float32_chs(float32_sub(fst2, float32_one=
,
 > + &env->active_fpu.fp_status));
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return fst2;
 > +}
 > +
 > +uint64_t helper_float_recip2_ps(CPUMIPSState *env, uint64_t fdt0,=20
uint64_t fdt2)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t fst0 =3D fdt0 & 0XFFFFFFFF;
 > +=C2=A0=C2=A0=C2=A0 uint32_t fsth0 =3D fdt0 >> 32;
 > +=C2=A0=C2=A0=C2=A0 uint32_t fst2 =3D fdt2 & 0XFFFFFFFF;
 > +=C2=A0=C2=A0=C2=A0 uint32_t fsth2 =3D fdt2 >> 32;
 > +
 > +=C2=A0=C2=A0=C2=A0 fst2 =3D float32_mul(fst0, fst2, &env->active_fpu.=
fp_status);
 > +=C2=A0=C2=A0=C2=A0 fsth2 =3D float32_mul(fsth0, fsth2, &env->active_f=
pu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 fst2 =3D float32_chs(float32_sub(fst2, float32_one=
,
 > + &env->active_fpu.fp_status));
 > +=C2=A0=C2=A0=C2=A0 fsth2 =3D float32_chs(float32_sub(fsth2, float32_o=
ne,
 > + &env->active_fpu.fp_status));
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return ((uint64_t)fsth2 << 32) | fst2;
 > +}
 > +
 > +uint64_t helper_float_rsqrt2_d(CPUMIPSState *env, uint64_t fdt0,=20
uint64_t fdt2)
 > +{
 > +=C2=A0=C2=A0=C2=A0 fdt2 =3D float64_mul(fdt0, fdt2, &env->active_fpu.=
fp_status);
 > +=C2=A0=C2=A0=C2=A0 fdt2 =3D float64_sub(fdt2, float64_one, &env->acti=
ve_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 fdt2 =3D float64_chs(float64_div(fdt2, FLOAT_TWO64=
,
 > + &env->active_fpu.fp_status));
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return fdt2;
 > +}
 > +
 > +uint32_t helper_float_rsqrt2_s(CPUMIPSState *env, uint32_t fst0,=20
uint32_t fst2)
 > +{
 > +=C2=A0=C2=A0=C2=A0 fst2 =3D float32_mul(fst0, fst2, &env->active_fpu.=
fp_status);
 > +=C2=A0=C2=A0=C2=A0 fst2 =3D float32_sub(fst2, float32_one, &env->acti=
ve_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 fst2 =3D float32_chs(float32_div(fst2, FLOAT_TWO32=
,
 > + &env->active_fpu.fp_status));
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return fst2;
 > +}
 > +
 > +uint64_t helper_float_rsqrt2_ps(CPUMIPSState *env, uint64_t fdt0,=20
uint64_t fdt2)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t fst0 =3D fdt0 & 0XFFFFFFFF;
 > +=C2=A0=C2=A0=C2=A0 uint32_t fsth0 =3D fdt0 >> 32;
 > +=C2=A0=C2=A0=C2=A0 uint32_t fst2 =3D fdt2 & 0XFFFFFFFF;
 > +=C2=A0=C2=A0=C2=A0 uint32_t fsth2 =3D fdt2 >> 32;
 > +
 > +=C2=A0=C2=A0=C2=A0 fst2 =3D float32_mul(fst0, fst2, &env->active_fpu.=
fp_status);
 > +=C2=A0=C2=A0=C2=A0 fsth2 =3D float32_mul(fsth0, fsth2, &env->active_f=
pu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 fst2 =3D float32_sub(fst2, float32_one, &env->acti=
ve_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 fsth2 =3D float32_sub(fsth2, float32_one, &env->ac=
tive_fpu.fp_status);
 > +=C2=A0=C2=A0=C2=A0 fst2 =3D float32_chs(float32_div(fst2, FLOAT_TWO32=
,
 > + &env->active_fpu.fp_status));
 > +=C2=A0=C2=A0=C2=A0 fsth2 =3D float32_chs(float32_div(fsth2, FLOAT_TWO=
32,
 > + &env->active_fpu.fp_status));
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return ((uint64_t)fsth2 << 32) | fst2;
 > +}
 > +
 > +uint64_t helper_float_addr_ps(CPUMIPSState *env, uint64_t fdt0,=20
uint64_t fdt1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t fst0 =3D fdt0 & 0XFFFFFFFF;
 > +=C2=A0=C2=A0=C2=A0 uint32_t fsth0 =3D fdt0 >> 32;
 > +=C2=A0=C2=A0=C2=A0 uint32_t fst1 =3D fdt1 & 0XFFFFFFFF;
 > +=C2=A0=C2=A0=C2=A0 uint32_t fsth1 =3D fdt1 >> 32;
 > +=C2=A0=C2=A0=C2=A0 uint32_t fst2;
 > +=C2=A0=C2=A0=C2=A0 uint32_t fsth2;
 > +
 > +=C2=A0=C2=A0=C2=A0 fst2 =3D float32_add(fst0, fsth0, &env->active_fpu=
.fp_status);
 > +=C2=A0=C2=A0=C2=A0 fsth2 =3D float32_add(fst1, fsth1, &env->active_fp=
u.fp_status);
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return ((uint64_t)fsth2 << 32) | fst2;
 > +}
 > +
 > +uint64_t helper_float_mulr_ps(CPUMIPSState *env, uint64_t fdt0,=20
uint64_t fdt1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t fst0 =3D fdt0 & 0XFFFFFFFF;
 > +=C2=A0=C2=A0=C2=A0 uint32_t fsth0 =3D fdt0 >> 32;
 > +=C2=A0=C2=A0=C2=A0 uint32_t fst1 =3D fdt1 & 0XFFFFFFFF;
 > +=C2=A0=C2=A0=C2=A0 uint32_t fsth1 =3D fdt1 >> 32;
 > +=C2=A0=C2=A0=C2=A0 uint32_t fst2;
 > +=C2=A0=C2=A0=C2=A0 uint32_t fsth2;
 > +
 > +=C2=A0=C2=A0=C2=A0 fst2 =3D float32_mul(fst0, fsth0, &env->active_fpu=
.fp_status);
 > +=C2=A0=C2=A0=C2=A0 fsth2 =3D float32_mul(fst1, fsth1, &env->active_fp=
u.fp_status);
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > +=C2=A0=C2=A0=C2=A0 return ((uint64_t)fsth2 << 32) | fst2;
 > +}
 > +
 > +#define FLOAT_MINMAX(name, bits,=20
minmaxfunc)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +uint ## bits ## _t helper_float_ ## name(CPUMIPSState=20
*env,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 uint ## bits ## _t=20
fs,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 uint ## bits ## _t=20
ft)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +{ \
 > +=C2=A0=C2=A0=C2=A0 uint ## bits ## _t=20
fdret;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > + \
 > +=C2=A0=C2=A0=C2=A0 fdret =3D float ## bits ## _ ## minmaxfunc(fs,=20
ft,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > + &env->active_fpu.fp_status); \
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env,=20
GETPC());=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 return=20
fdret;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +}
 > +
 > +FLOAT_MINMAX(max_s, 32, maxnum)
 > +FLOAT_MINMAX(max_d, 64, maxnum)
 > +FLOAT_MINMAX(maxa_s, 32, maxnummag)
 > +FLOAT_MINMAX(maxa_d, 64, maxnummag)
 > +
 > +FLOAT_MINMAX(min_s, 32, minnum)
 > +FLOAT_MINMAX(min_d, 64, minnum)
 > +FLOAT_MINMAX(mina_s, 32, minnummag)
 > +FLOAT_MINMAX(mina_d, 64, minnummag)
 > +#undef FLOAT_MINMAX
 > +
 > +/* ternary operations */
 > +#define UNFUSED_FMA(prefix, a, b, c, flags)=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +{ \
 > +=C2=A0=C2=A0=C2=A0 a =3D prefix##_mul(a, b, &env->active_fpu.fp_statu=
s);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 if ((flags) & float_muladd_negate_c) {=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a =3D prefix##_sub(a, c, &=
env->active_fpu.fp_status);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 } else {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a =3D prefix##_add(a, c, &=
env->active_fpu.fp_status);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 \
 > + }=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 if ((flags) & float_muladd_negate_result) {=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a =3D prefix##_chs(a);=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 \
 > + }=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 \
 > +}
 > +
 > +/* FMA based operations */
 > +#define FLOAT_FMA(name, type)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +uint64_t helper_float_ ## name ## _d(CPUMIPSState *env,=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
uint64_t fdt0, uint64_t fdt1,=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
uint64_t fdt2)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +{ \
 > +=C2=A0=C2=A0=C2=A0 UNFUSED_FMA(float64, fdt0, fdt1, fdt2, type);=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 return fdt0;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +} \
 > + \
 > +uint32_t helper_float_ ## name ## _s(CPUMIPSState *env,=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
uint32_t fst0, uint32_t fst1,=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
uint32_t fst2)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +{ \
 > +=C2=A0=C2=A0=C2=A0 UNFUSED_FMA(float32, fst0, fst1, fst2, type);=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 return fst0;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +} \
 > + \
 > +uint64_t helper_float_ ## name ## _ps(CPUMIPSState *env,=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 uint64_t fdt0, uint64_t fdt1,=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 uint64_t fdt2)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +{ \
 > +=C2=A0=C2=A0=C2=A0 uint32_t fst0 =3D fdt0 & 0XFFFFFFFF;=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 uint32_t fsth0 =3D fdt0 >> 32;=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 uint32_t fst1 =3D fdt1 & 0XFFFFFFFF;=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 uint32_t fsth1 =3D fdt1 >> 32;=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 uint32_t fst2 =3D fdt2 & 0XFFFFFFFF;=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 uint32_t fsth2 =3D fdt2 >> 32;=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > + \
 > +=C2=A0=C2=A0=C2=A0 UNFUSED_FMA(float32, fst0, fst1, fst2, type);=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 UNFUSED_FMA(float32, fsth0, fsth1, fsth2, type);=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 return ((uint64_t)fsth0 << 32) | fst0;=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +}
 > +FLOAT_FMA(madd, 0)
 > +FLOAT_FMA(msub, float_muladd_negate_c)
 > +FLOAT_FMA(nmadd, float_muladd_negate_result)
 > +FLOAT_FMA(nmsub, float_muladd_negate_result | float_muladd_negate_c)
 > +#undef FLOAT_FMA
 > +
 > +#define FLOAT_FMADDSUB(name, bits,=20
muladd_arg)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 \
 > +uint ## bits ## _t helper_float_ ## name(CPUMIPSState=20
*env,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 uint ## bits ## _t=20
fs,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 uint ## bits ## _t=20
ft,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 uint ## bits ## _t=20
fd)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +{ \
 > +=C2=A0=C2=A0=C2=A0 uint ## bits ## _t=20
fdret;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > + \
 > +=C2=A0=C2=A0=C2=A0 fdret =3D float ## bits ## _muladd(fs, ft, fd,=20
muladd_arg,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
 > + &env->active_fpu.fp_status);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env,=20
GETPC());=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 return=20
fdret;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +}
 > +
 > +FLOAT_FMADDSUB(maddf_s, 32, 0)
 > +FLOAT_FMADDSUB(maddf_d, 64, 0)
 > +FLOAT_FMADDSUB(msubf_s, 32, float_muladd_negate_product)
 > +FLOAT_FMADDSUB(msubf_d, 64, float_muladd_negate_product)
 > +#undef FLOAT_FMADDSUB
 > +
 > +/* compare operations */
 > +#define FOP_COND_D(op, cond) \
 > +void helper_cmp_d_ ## op(CPUMIPSState *env, uint64_t fdt0, \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 uint64_t fdt1, int cc) \
 > +{ \
 > +=C2=A0=C2=A0=C2=A0 int c; \
 > +=C2=A0=C2=A0=C2=A0 c =3D cond; \
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC()); \
 > +=C2=A0=C2=A0=C2=A0 if (c) \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SET_FP_COND(cc, env->activ=
e_fpu);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 else \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CLEAR_FP_COND(cc, env->act=
ive_fpu);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +} \
 > +void helper_cmpabs_d_ ## op(CPUMIPSState *env, uint64_t fdt0, \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 uint64_t fdt1, int cc) \
 > +{ \
 > +=C2=A0=C2=A0=C2=A0 int c; \
 > +=C2=A0=C2=A0=C2=A0 fdt0 =3D float64_abs(fdt0); \
 > +=C2=A0=C2=A0=C2=A0 fdt1 =3D float64_abs(fdt1); \
 > +=C2=A0=C2=A0=C2=A0 c =3D cond; \
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC()); \
 > +=C2=A0=C2=A0=C2=A0 if (c) \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SET_FP_COND(cc, env->activ=
e_fpu);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 else \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CLEAR_FP_COND(cc, env->act=
ive_fpu);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +}
 > +
 > +/*
 > + * NOTE: the comma operator will make "cond" to eval to false,
 > + * but float64_unordered_quiet() is still called.
 > + */
 > +FOP_COND_D(f,=C2=A0=C2=A0=C2=A0 (float64_unordered_quiet(fdt1, fdt0,
 > + &env->active_fpu.fp_status), 0))
 > +FOP_COND_D(un,=C2=A0=C2=A0 float64_unordered_quiet(fdt1, fdt0,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_D(eq,=C2=A0=C2=A0 float64_eq_quiet(fdt0, fdt1,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_D(ueq,=C2=A0 float64_unordered_quiet(fdt1, fdt0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_eq_quiet(fdt0, fdt1,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_D(olt,=C2=A0 float64_lt_quiet(fdt0, fdt1,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_D(ult,=C2=A0 float64_unordered_quiet(fdt1, fdt0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_lt_quiet(fdt0, fdt1,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_D(ole,=C2=A0 float64_le_quiet(fdt0, fdt1,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_D(ule,=C2=A0 float64_unordered_quiet(fdt1, fdt0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_le_quiet(fdt0, fdt1,
 > + &env->active_fpu.fp_status))
 > +/*
 > + * NOTE: the comma operator will make "cond" to eval to false,
 > + * but float64_unordered() is still called.
 > + */
 > +FOP_COND_D(sf,=C2=A0=C2=A0 (float64_unordered(fdt1, fdt0,
 > + &env->active_fpu.fp_status), 0))
 > +FOP_COND_D(ngle, float64_unordered(fdt1, fdt0,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_D(seq,=C2=A0 float64_eq(fdt0, fdt1,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_D(ngl,=C2=A0 float64_unordered(fdt1, fdt0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_eq(fdt0, fdt1,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_D(lt,=C2=A0=C2=A0 float64_lt(fdt0, fdt1,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_D(nge,=C2=A0 float64_unordered(fdt1, fdt0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_lt(fdt0, fdt1,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_D(le,=C2=A0=C2=A0 float64_le(fdt0, fdt1,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_D(ngt,=C2=A0 float64_unordered(fdt1, fdt0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_le(fdt0, fdt1,
 > + &env->active_fpu.fp_status))
 > +
 > +#define FOP_COND_S(op, cond) \
 > +void helper_cmp_s_ ## op(CPUMIPSState *env, uint32_t fst0, \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 uint32_t fst1, int cc) \
 > +{ \
 > +=C2=A0=C2=A0=C2=A0 int c; \
 > +=C2=A0=C2=A0=C2=A0 c =3D cond; \
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC()); \
 > +=C2=A0=C2=A0=C2=A0 if (c) \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SET_FP_COND(cc, env->activ=
e_fpu);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 else \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CLEAR_FP_COND(cc, env->act=
ive_fpu);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +} \
 > +void helper_cmpabs_s_ ## op(CPUMIPSState *env, uint32_t fst0, \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 uint32_t fst1, int cc) \
 > +{ \
 > +=C2=A0=C2=A0=C2=A0 int c; \
 > +=C2=A0=C2=A0=C2=A0 fst0 =3D float32_abs(fst0); \
 > +=C2=A0=C2=A0=C2=A0 fst1 =3D float32_abs(fst1); \
 > +=C2=A0=C2=A0=C2=A0 c =3D cond; \
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC()); \
 > +=C2=A0=C2=A0=C2=A0 if (c) \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SET_FP_COND(cc, env->activ=
e_fpu);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 else \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CLEAR_FP_COND(cc, env->act=
ive_fpu);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +}
 > +
 > +/*
 > + * NOTE: the comma operator will make "cond" to eval to false,
 > + * but float32_unordered_quiet() is still called.
 > + */
 > +FOP_COND_S(f,=C2=A0=C2=A0=C2=A0 (float32_unordered_quiet(fst1, fst0,
 > + &env->active_fpu.fp_status), 0))
 > +FOP_COND_S(un,=C2=A0=C2=A0 float32_unordered_quiet(fst1, fst0,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_S(eq,=C2=A0=C2=A0 float32_eq_quiet(fst0, fst1,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_S(ueq,=C2=A0 float32_unordered_quiet(fst1, fst0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_eq_quiet(fst0, fst1,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_S(olt,=C2=A0 float32_lt_quiet(fst0, fst1,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_S(ult,=C2=A0 float32_unordered_quiet(fst1, fst0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_lt_quiet(fst0, fst1,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_S(ole,=C2=A0 float32_le_quiet(fst0, fst1,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_S(ule,=C2=A0 float32_unordered_quiet(fst1, fst0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_le_quiet(fst0, fst1,
 > + &env->active_fpu.fp_status))
 > +/*
 > + * NOTE: the comma operator will make "cond" to eval to false,
 > + * but float32_unordered() is still called.
 > + */
 > +FOP_COND_S(sf,=C2=A0=C2=A0 (float32_unordered(fst1, fst0,
 > + &env->active_fpu.fp_status), 0))
 > +FOP_COND_S(ngle, float32_unordered(fst1, fst0,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_S(seq,=C2=A0 float32_eq(fst0, fst1,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_S(ngl,=C2=A0 float32_unordered(fst1, fst0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_eq(fst0, fst1,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_S(lt,=C2=A0=C2=A0 float32_lt(fst0, fst1,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_S(nge,=C2=A0 float32_unordered(fst1, fst0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_lt(fst0, fst1,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_S(le,=C2=A0=C2=A0 float32_le(fst0, fst1,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_S(ngt,=C2=A0 float32_unordered(fst1, fst0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_le(fst0, fst1,
 > + &env->active_fpu.fp_status))
 > +
 > +#define FOP_COND_PS(op, condl, condh)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +void helper_cmp_ps_ ## op(CPUMIPSState *env, uint64_t fdt0,=C2=A0=C2=A0=
=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 uint64_t fdt1, int cc)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +{=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
 > +=C2=A0=C2=A0=C2=A0 uint32_t fst0, fsth0, fst1, fsth1;=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 int ch, cl;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 fst0 =3D fdt0 & 0XFFFFFFFF;=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 fsth0 =3D fdt0 >> 32;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 fst1 =3D fdt1 & 0XFFFFFFFF;=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 fsth1 =3D fdt1 >> 32;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 cl =3D condl;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 ch =3D condh;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 if (cl)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SET_FP_COND(cc, env->activ=
e_fpu);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > + else=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CLEAR_FP_COND(cc, env->act=
ive_fpu);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 if (ch)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SET_FP_COND(cc + 1, env->a=
ctive_fpu);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > + else=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CLEAR_FP_COND(cc + 1, env-=
>active_fpu);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +}=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
 > +void helper_cmpabs_ps_ ## op(CPUMIPSState *env, uint64_t fdt0,=C2=A0 =
\
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t fdt1, int cc)=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +{=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
 > +=C2=A0=C2=A0=C2=A0 uint32_t fst0, fsth0, fst1, fsth1;=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 int ch, cl;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 fst0 =3D float32_abs(fdt0 & 0XFFFFFFFF);=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 fsth0 =3D float32_abs(fdt0 >> 32);=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 fst1 =3D float32_abs(fdt1 & 0XFFFFFFFF);=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 fsth1 =3D float32_abs(fdt1 >> 32);=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 cl =3D condl;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 ch =3D condh;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 if (cl)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SET_FP_COND(cc, env->activ=
e_fpu);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > + else=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CLEAR_FP_COND(cc, env->act=
ive_fpu);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 if (ch)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SET_FP_COND(cc + 1, env->a=
ctive_fpu);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > + else=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CLEAR_FP_COND(cc + 1, env-=
>active_fpu);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +}
 > +
 > +/*
 > + * NOTE: the comma operator will make "cond" to eval to false,
 > + * but float32_unordered_quiet() is still called.
 > + */
 > +FOP_COND_PS(f,=C2=A0=C2=A0=C2=A0 (float32_unordered_quiet(fst1, fst0,
 > + &env->active_fpu.fp_status), 0),
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (float32_unordered_quiet(fsth1, fsth0,
 > + &env->active_fpu.fp_status), 0))
 > +FOP_COND_PS(un,=C2=A0=C2=A0 float32_unordered_quiet(fst1, fst0,
 > + &env->active_fpu.fp_status),
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float32_unordered_quiet(fsth1, fsth0,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_PS(eq,=C2=A0=C2=A0 float32_eq_quiet(fst0, fst1,
 > + &env->active_fpu.fp_status),
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float32_eq_quiet(fsth0, fsth1,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_PS(ueq,=C2=A0 float32_unordered_quiet(fst1, fst0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_eq_quiet(fst0, fst1,
 > + &env->active_fpu.fp_status),
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float32_unordered_quiet(fsth1, fsth0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_eq_quiet(fsth0, fsth1,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_PS(olt,=C2=A0 float32_lt_quiet(fst0, fst1,
 > + &env->active_fpu.fp_status),
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float32_lt_quiet(fsth0, fsth1,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_PS(ult,=C2=A0 float32_unordered_quiet(fst1, fst0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_lt_quiet(fst0, fst1,
 > + &env->active_fpu.fp_status),
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float32_unordered_quiet(fsth1, fsth0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_lt_quiet(fsth0, fsth1,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_PS(ole,=C2=A0 float32_le_quiet(fst0, fst1,
 > + &env->active_fpu.fp_status),
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float32_le_quiet(fsth0, fsth1,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_PS(ule,=C2=A0 float32_unordered_quiet(fst1, fst0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_le_quiet(fst0, fst1,
 > + &env->active_fpu.fp_status),
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float32_unordered_quiet(fsth1, fsth0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_le_quiet(fsth0, fsth1,
 > + &env->active_fpu.fp_status))
 > +/*
 > + * NOTE: the comma operator will make "cond" to eval to false,
 > + * but float32_unordered() is still called.
 > + */
 > +FOP_COND_PS(sf,=C2=A0=C2=A0 (float32_unordered(fst1, fst0,
 > + &env->active_fpu.fp_status), 0),
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (float32_unordered(fsth1, fsth0,
 > + &env->active_fpu.fp_status), 0))
 > +FOP_COND_PS(ngle, float32_unordered(fst1, fst0,
 > + &env->active_fpu.fp_status),
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float32_unordered(fsth1, fsth0,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_PS(seq,=C2=A0 float32_eq(fst0, fst1,
 > + &env->active_fpu.fp_status),
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float32_eq(fsth0, fsth1,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_PS(ngl,=C2=A0 float32_unordered(fst1, fst0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_eq(fst0, fst1,
 > + &env->active_fpu.fp_status),
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float32_unordered(fsth1, fsth0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_eq(fsth0, fsth1,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_PS(lt,=C2=A0=C2=A0 float32_lt(fst0, fst1,
 > + &env->active_fpu.fp_status),
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float32_lt(fsth0, fsth1,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_PS(nge,=C2=A0 float32_unordered(fst1, fst0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_lt(fst0, fst1,
 > + &env->active_fpu.fp_status),
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float32_unordered(fsth1, fsth0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_lt(fsth0, fsth1,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_PS(le,=C2=A0=C2=A0 float32_le(fst0, fst1,
 > + &env->active_fpu.fp_status),
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float32_le(fsth0, fsth1,
 > + &env->active_fpu.fp_status))
 > +FOP_COND_PS(ngt,=C2=A0 float32_unordered(fst1, fst0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_le(fst0, fst1,
 > + &env->active_fpu.fp_status),
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float32_unordered(fsth1, fsth0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_le(fsth0, fsth1,
 > + &env->active_fpu.fp_status))
 > +
 > +/* R6 compare operations */
 > +#define FOP_CONDN_D(op, cond)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +uint64_t helper_r6_cmp_d_ ## op(CPUMIPSState *env, uint64_t fdt0,=C2=A0=
=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t fdt1)=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +{ \
 > +=C2=A0=C2=A0=C2=A0 uint64_t c;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 c =3D cond;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 if (c) {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 } else {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > + }=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
 > +}
 > +
 > +/*
 > + * NOTE: the comma operator will make "cond" to eval to false,
 > + * but float64_unordered_quiet() is still called.
 > + */
 > +FOP_CONDN_D(af,=C2=A0 (float64_unordered_quiet(fdt1, fdt0,
 > + &env->active_fpu.fp_status), 0))
 > +FOP_CONDN_D(un,=C2=A0 (float64_unordered_quiet(fdt1, fdt0,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_D(eq,=C2=A0 (float64_eq_quiet(fdt0, fdt1,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_D(ueq, (float64_unordered_quiet(fdt1, fdt0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_eq_quiet(fdt0, fdt1,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_D(lt,=C2=A0 (float64_lt_quiet(fdt0, fdt1,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_D(ult, (float64_unordered_quiet(fdt1, fdt0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_lt_quiet(fdt0, fdt1,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_D(le,=C2=A0 (float64_le_quiet(fdt0, fdt1,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_D(ule, (float64_unordered_quiet(fdt1, fdt0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_le_quiet(fdt0, fdt1,
 > + &env->active_fpu.fp_status)))
 > +/*
 > + * NOTE: the comma operator will make "cond" to eval to false,
 > + * but float64_unordered() is still called.\
 > + */
 > +FOP_CONDN_D(saf,=C2=A0 (float64_unordered(fdt1, fdt0,
 > + &env->active_fpu.fp_status), 0))
 > +FOP_CONDN_D(sun,=C2=A0 (float64_unordered(fdt1, fdt0,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_D(seq,=C2=A0 (float64_eq(fdt0, fdt1,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_D(sueq, (float64_unordered(fdt1, fdt0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_eq(fdt0, fdt1,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_D(slt,=C2=A0 (float64_lt(fdt0, fdt1,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_D(sult, (float64_unordered(fdt1, fdt0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_lt(fdt0, fdt1,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_D(sle,=C2=A0 (float64_le(fdt0, fdt1,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_D(sule, (float64_unordered(fdt1, fdt0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_le(fdt0, fdt1,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_D(or,=C2=A0=C2=A0 (float64_le_quiet(fdt1, fdt0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_le_quiet(fdt0, fdt1,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_D(une,=C2=A0 (float64_unordered_quiet(fdt1, fdt0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_lt_quiet(fdt1, fdt0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_lt_quiet(fdt0, fdt1,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_D(ne,=C2=A0=C2=A0 (float64_lt_quiet(fdt1, fdt0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_lt_quiet(fdt0, fdt1,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_D(sor,=C2=A0 (float64_le(fdt1, fdt0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_le(fdt0, fdt1,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_D(sune, (float64_unordered(fdt1, fdt0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_lt(fdt1, fdt0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_lt(fdt0, fdt1,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_D(sne,=C2=A0 (float64_lt(fdt1, fdt0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_lt(fdt0, fdt1,
 > + &env->active_fpu.fp_status)))
 > +
 > +#define FOP_CONDN_S(op, cond)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +uint32_t helper_r6_cmp_s_ ## op(CPUMIPSState *env, uint32_t fst0,=C2=A0=
=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t fst1)=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +{ \
 > +=C2=A0=C2=A0=C2=A0 uint64_t c;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 c =3D cond;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 if (c) {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0 } else {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > + }=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
 > +}
 > +
 > +/*
 > + * NOTE: the comma operator will make "cond" to eval to false,
 > + * but float32_unordered_quiet() is still called.
 > + */
 > +FOP_CONDN_S(af,=C2=A0=C2=A0 (float32_unordered_quiet(fst1, fst0,
 > + &env->active_fpu.fp_status), 0))
 > +FOP_CONDN_S(un,=C2=A0=C2=A0 (float32_unordered_quiet(fst1, fst0,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_S(eq,=C2=A0=C2=A0 (float32_eq_quiet(fst0, fst1,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_S(ueq,=C2=A0 (float32_unordered_quiet(fst1, fst0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_eq_quiet(fst0, fst1,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_S(lt,=C2=A0=C2=A0 (float32_lt_quiet(fst0, fst1,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_S(ult,=C2=A0 (float32_unordered_quiet(fst1, fst0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_lt_quiet(fst0, fst1,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_S(le,=C2=A0=C2=A0 (float32_le_quiet(fst0, fst1,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_S(ule,=C2=A0 (float32_unordered_quiet(fst1, fst0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_le_quiet(fst0, fst1,
 > + &env->active_fpu.fp_status)))
 > +/*
 > + * NOTE: the comma operator will make "cond" to eval to false,
 > + * but float32_unordered() is still called.
 > + */
 > +FOP_CONDN_S(saf,=C2=A0 (float32_unordered(fst1, fst0,
 > + &env->active_fpu.fp_status), 0))
 > +FOP_CONDN_S(sun,=C2=A0 (float32_unordered(fst1, fst0,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_S(seq,=C2=A0 (float32_eq(fst0, fst1,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_S(sueq, (float32_unordered(fst1, fst0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_eq(fst0, fst1,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_S(slt,=C2=A0 (float32_lt(fst0, fst1,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_S(sult, (float32_unordered(fst1, fst0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_lt(fst0, fst1,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_S(sle,=C2=A0 (float32_le(fst0, fst1,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_S(sule, (float32_unordered(fst1, fst0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_le(fst0, fst1,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_S(or,=C2=A0=C2=A0 (float32_le_quiet(fst1, fst0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_le_quiet(fst0, fst1,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_S(une,=C2=A0 (float32_unordered_quiet(fst1, fst0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_lt_quiet(fst1, fst0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_lt_quiet(fst0, fst1,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_S(ne,=C2=A0=C2=A0 (float32_lt_quiet(fst1, fst0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_lt_quiet(fst0, fst1,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_S(sor,=C2=A0 (float32_le(fst1, fst0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_le(fst0, fst1,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_S(sune, (float32_unordered(fst1, fst0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_lt(fst1, fst0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_lt(fst0, fst1,
 > + &env->active_fpu.fp_status)))
 > +FOP_CONDN_S(sne,=C2=A0 (float32_lt(fst1, fst0,
 > + &env->active_fpu.fp_status)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_lt(fst0, fst1,
 > + &env->active_fpu.fp_status)))
 > diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
 > index eeb6fa1..f0b5ab1 100644
 > --- a/target/mips/op_helper.c
 > +++ b/target/mips/op_helper.c
 > @@ -28,7 +28,6 @@
 >=C2=A0 #include "exec/cpu_ldst.h"
 >=C2=A0 #include "exec/memop.h"
 >=C2=A0 #include "sysemu/kvm.h"
 > -#include "fpu/softfloat.h"
 >
 >
 >=20
/************************************************************************=
*****/
 > @@ -1178,1882 +1177,6 @@ void mips_cpu_do_transaction_failed(CPUState=20
*cs, hwaddr physaddr,
 >=C2=A0 }
 >=C2=A0 #endif /* !CONFIG_USER_ONLY */
 >
 > -/* Complex FPU operations which may need stack space. */
 > -
 > -#define FLOAT_TWO32 make_float32(1 << 30)
 > -#define FLOAT_TWO64 make_float64(1ULL << 62)
 > -
 > -#define FP_TO_INT32_OVERFLOW 0x7fffffff
 > -#define FP_TO_INT64_OVERFLOW 0x7fffffffffffffffULL
 > -
 > -/* convert MIPS rounding mode in FCR31 to IEEE library */
 > -unsigned int ieee_rm[] =3D {
 > -=C2=A0=C2=A0=C2=A0 float_round_nearest_even,
 > -=C2=A0=C2=A0=C2=A0 float_round_to_zero,
 > -=C2=A0=C2=A0=C2=A0 float_round_up,
 > -=C2=A0=C2=A0=C2=A0 float_round_down
 > -};
 > -
 > -target_ulong helper_cfc1(CPUMIPSState *env, uint32_t reg)
 > -{
 > -=C2=A0=C2=A0=C2=A0 target_ulong arg1 =3D 0;
 > -
 > -=C2=A0=C2=A0=C2=A0 switch (reg) {
 > -=C2=A0=C2=A0=C2=A0 case 0:
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arg1 =3D (int32_t)env->act=
ive_fpu.fcr0;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > -=C2=A0=C2=A0=C2=A0 case 1:
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* UFR Support - Read Stat=
us FR */
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (env->active_fpu.fcr0 &=
 (1 << FCR0_UFRP)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (env->CP0_Config5 & (1 << CP0C5_UFR)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 arg1 =3D (int32_t)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((env->CP=
0_Status & (1=C2=A0 << CP0St_FR)) >>=20
CP0St_FR);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } =
else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 do_raise_exception(env, EXCP_RI, GETPC());
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > -=C2=A0=C2=A0=C2=A0 case 5:
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* FRE Support - read Conf=
ig5.FRE bit */
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (env->active_fpu.fcr0 &=
 (1 << FCR0_FREP)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (env->CP0_Config5 & (1 << CP0C5_UFE)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 arg1 =3D (env->CP0_Config5 >> CP0C5_FRE) & 1;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } =
else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 helper_raise_exception(env, EXCP_RI);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > -=C2=A0=C2=A0=C2=A0 case 25:
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arg1 =3D ((env->active_fpu=
.fcr31 >> 24) & 0xfe) |
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ((env->active_fpu.fcr31 >> 23) & 0x1);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > -=C2=A0=C2=A0=C2=A0 case 26:
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arg1 =3D env->active_fpu.f=
cr31 & 0x0003f07c;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > -=C2=A0=C2=A0=C2=A0 case 28:
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arg1 =3D (env->active_fpu.=
fcr31 & 0x00000f83) |
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ((env->active_fpu.fcr31 >> 22) & 0x4);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > -=C2=A0=C2=A0=C2=A0 default:
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arg1 =3D (int32_t)env->act=
ive_fpu.fcr31;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > -=C2=A0=C2=A0=C2=A0 }
 > -
 > -=C2=A0=C2=A0=C2=A0 return arg1;
 > -}
 > -
 > -void helper_ctc1(CPUMIPSState *env, target_ulong arg1, uint32_t fs,=20
uint32_t rt)
 > -{
 > -=C2=A0=C2=A0=C2=A0 switch (fs) {
 > -=C2=A0=C2=A0=C2=A0 case 1:
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* UFR Alias - Reset Statu=
s FR */
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!((env->active_fpu.fcr=
0 & (1 << FCR0_UFRP)) && (rt =3D=3D 0))) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (env->CP0_Config5 & (1 =
<< CP0C5_UFR)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 en=
v->CP0_Status &=3D ~(1 << CP0St_FR);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
mpute_hflags(env);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do=
_raise_exception(env, EXCP_RI, GETPC());
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > -=C2=A0=C2=A0=C2=A0 case 4:
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* UNFR Alias - Set Status=
 FR */
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!((env->active_fpu.fcr=
0 & (1 << FCR0_UFRP)) && (rt =3D=3D 0))) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (env->CP0_Config5 & (1 =
<< CP0C5_UFR)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 en=
v->CP0_Status |=3D (1 << CP0St_FR);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
mpute_hflags(env);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do=
_raise_exception(env, EXCP_RI, GETPC());
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > -=C2=A0=C2=A0=C2=A0 case 5:
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* FRE Support - clear Con=
fig5.FRE bit */
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!((env->active_fpu.fcr=
0 & (1 << FCR0_FREP)) && (rt =3D=3D 0))) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (env->CP0_Config5 & (1 =
<< CP0C5_UFE)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 en=
v->CP0_Config5 &=3D ~(1 << CP0C5_FRE);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
mpute_hflags(env);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 he=
lper_raise_exception(env, EXCP_RI);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > -=C2=A0=C2=A0=C2=A0 case 6:
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* FRE Support - set Confi=
g5.FRE bit */
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!((env->active_fpu.fcr=
0 & (1 << FCR0_FREP)) && (rt =3D=3D 0))) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (env->CP0_Config5 & (1 =
<< CP0C5_UFE)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 en=
v->CP0_Config5 |=3D (1 << CP0C5_FRE);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
mpute_hflags(env);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 he=
lper_raise_exception(env, EXCP_RI);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > -=C2=A0=C2=A0=C2=A0 case 25:
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((env->insn_flags & ISA=
_MIPS32R6) || (arg1 & 0xffffff00)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->active_fpu.fcr31 =3D =
(env->active_fpu.fcr31 & 0x017fffff) |
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((arg1 & 0xfe) << 24) |
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((arg1 & 0x1) << 23);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > -=C2=A0=C2=A0=C2=A0 case 26:
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (arg1 & 0x007c0000) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->active_fpu.fcr31 =3D =
(env->active_fpu.fcr31 & 0xfffc0f83) |
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (arg1 & 0x0003f07c);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > -=C2=A0=C2=A0=C2=A0 case 28:
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (arg1 & 0x007c0000) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->active_fpu.fcr31 =3D =
(env->active_fpu.fcr31 & 0xfefff07c) |
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (arg1 & 0x00000f83) |
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((arg1 & 0x4) << 22);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > -=C2=A0=C2=A0=C2=A0 case 31:
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->active_fpu.fcr31 =3D =
(arg1 &=20
env->active_fpu.fcr31_rw_bitmask) |
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 (env->active_fpu.fcr31 &=20
~(env->active_fpu.fcr31_rw_bitmask));
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > -=C2=A0=C2=A0=C2=A0 default:
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (env->insn_flags & ISA_=
MIPS32R6) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do=
_raise_exception(env, EXCP_RI, GETPC());
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 restore_fp_status(env);
 > -=C2=A0=C2=A0=C2=A0 set_float_exception_flags(0, &env->active_fpu.fp_s=
tatus);
 > -=C2=A0=C2=A0=C2=A0 if ((GET_FP_ENABLE(env->active_fpu.fcr31) | 0x20) =
&
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GET_FP_CAUSE(env->active_f=
pu.fcr31)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do_raise_exception(env, EX=
CP_FPE, GETPC());
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -int ieee_ex_to_mips(int xcpt)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int ret =3D 0;
 > -=C2=A0=C2=A0=C2=A0 if (xcpt) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (xcpt & float_flag_inva=
lid) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t |=3D FP_INVALID;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (xcpt & float_flag_over=
flow) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t |=3D FP_OVERFLOW;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (xcpt & float_flag_unde=
rflow) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t |=3D FP_UNDERFLOW;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (xcpt & float_flag_divb=
yzero) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t |=3D FP_DIV0;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (xcpt & float_flag_inex=
act) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t |=3D FP_INEXACT;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 return ret;
 > -}
 > -
 > -static inline void update_fcr31(CPUMIPSState *env, uintptr_t pc)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int tmp =3D ieee_ex_to_mips(get_float_exception_fl=
ags(
 > - &env->active_fpu.fp_status));
 > -
 > -=C2=A0=C2=A0=C2=A0 SET_FP_CAUSE(env->active_fpu.fcr31, tmp);
 > -
 > -=C2=A0=C2=A0=C2=A0 if (tmp) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_float_exception_flags(=
0, &env->active_fpu.fp_status);
 > -
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (GET_FP_ENABLE(env->act=
ive_fpu.fcr31) & tmp) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do=
_raise_exception(env, EXCP_FPE, pc);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 UP=
DATE_FP_FLAGS(env->active_fpu.fcr31, tmp);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -/*
 > - * Float support.
 > - * Single precition routines have a "s" suffix, double precision a
 > - * "d" suffix, 32bit integer "w", 64bit integer "l", paired single "p=
s",
 > - * paired single lower "pl", paired single upper "pu".
 > - */
 > -
 > -/* unary operations, modifying fp status=C2=A0 */
 > -uint64_t helper_float_sqrt_d(CPUMIPSState *env, uint64_t fdt0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 fdt0 =3D float64_sqrt(fdt0, &env->active_fpu.fp_st=
atus);
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return fdt0;
 > -}
 > -
 > -uint32_t helper_float_sqrt_s(CPUMIPSState *env, uint32_t fst0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 fst0 =3D float32_sqrt(fst0, &env->active_fpu.fp_st=
atus);
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return fst0;
 > -}
 > -
 > -uint64_t helper_float_cvtd_s(CPUMIPSState *env, uint32_t fst0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint64_t fdt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 fdt2 =3D float32_to_float64(fst0, &env->active_fpu=
.fp_status);
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return fdt2;
 > -}
 > -
 > -uint64_t helper_float_cvtd_w(CPUMIPSState *env, uint32_t wt0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint64_t fdt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 fdt2 =3D int32_to_float64(wt0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return fdt2;
 > -}
 > -
 > -uint64_t helper_float_cvtd_l(CPUMIPSState *env, uint64_t dt0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint64_t fdt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 fdt2 =3D int64_to_float64(dt0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return fdt2;
 > -}
 > -
 > -uint64_t helper_float_cvt_l_d(CPUMIPSState *env, uint64_t fdt0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 dt2 =3D float64_to_int64(fdt0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt2 =3D FP_TO_INT64_OVERFL=
OW;
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return dt2;
 > -}
 > -
 > -uint64_t helper_float_cvt_l_s(CPUMIPSState *env, uint32_t fst0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 dt2 =3D float32_to_int64(fst0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt2 =3D FP_TO_INT64_OVERFL=
OW;
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return dt2;
 > -}
 > -
 > -uint64_t helper_float_cvtps_pw(CPUMIPSState *env, uint64_t dt0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t fst2;
 > -=C2=A0=C2=A0=C2=A0 uint32_t fsth2;
 > -
 > -=C2=A0=C2=A0=C2=A0 fst2 =3D int32_to_float32(dt0 & 0XFFFFFFFF,=20
&env->active_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 fsth2 =3D int32_to_float32(dt0 >> 32, &env->active=
_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return ((uint64_t)fsth2 << 32) | fst2;
 > -}
 > -
 > -uint64_t helper_float_cvtpw_ps(CPUMIPSState *env, uint64_t fdt0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > -=C2=A0=C2=A0=C2=A0 uint32_t wth2;
 > -=C2=A0=C2=A0=C2=A0 int excp, excph;
 > -
 > -=C2=A0=C2=A0=C2=A0 wt2 =3D float32_to_int32(fdt0 & 0XFFFFFFFF,=20
&env->active_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 excp =3D get_float_exception_flags(&env->active_fp=
u.fp_status);
 > -=C2=A0=C2=A0=C2=A0 if (excp & (float_flag_overflow | float_flag_inval=
id)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt2 =3D FP_TO_INT32_OVERFL=
OW;
 > -=C2=A0=C2=A0=C2=A0 }
 > -
 > -=C2=A0=C2=A0=C2=A0 set_float_exception_flags(0, &env->active_fpu.fp_s=
tatus);
 > -=C2=A0=C2=A0=C2=A0 wth2 =3D float32_to_int32(fdt0 >> 32, &env->active=
_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 excph =3D get_float_exception_flags(&env->active_f=
pu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 if (excph & (float_flag_overflow | float_flag_inva=
lid)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wth2 =3D FP_TO_INT32_OVERF=
LOW;
 > -=C2=A0=C2=A0=C2=A0 }
 > -
 > -=C2=A0=C2=A0=C2=A0 set_float_exception_flags(excp | excph, &env->acti=
ve_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -
 > -=C2=A0=C2=A0=C2=A0 return ((uint64_t)wth2 << 32) | wt2;
 > -}
 > -
 > -uint32_t helper_float_cvts_d(CPUMIPSState *env, uint64_t fdt0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t fst2;
 > -
 > -=C2=A0=C2=A0=C2=A0 fst2 =3D float64_to_float32(fdt0, &env->active_fpu=
.fp_status);
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return fst2;
 > -}
 > -
 > -uint32_t helper_float_cvts_w(CPUMIPSState *env, uint32_t wt0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t fst2;
 > -
 > -=C2=A0=C2=A0=C2=A0 fst2 =3D int32_to_float32(wt0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return fst2;
 > -}
 > -
 > -uint32_t helper_float_cvts_l(CPUMIPSState *env, uint64_t dt0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t fst2;
 > -
 > -=C2=A0=C2=A0=C2=A0 fst2 =3D int64_to_float32(dt0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return fst2;
 > -}
 > -
 > -uint32_t helper_float_cvts_pl(CPUMIPSState *env, uint32_t wt0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 wt2 =3D wt0;
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return wt2;
 > -}
 > -
 > -uint32_t helper_float_cvts_pu(CPUMIPSState *env, uint32_t wth0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 wt2 =3D wth0;
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return wt2;
 > -}
 > -
 > -uint32_t helper_float_cvt_w_s(CPUMIPSState *env, uint32_t fst0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 wt2 =3D float32_to_int32(fst0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt2 =3D FP_TO_INT32_OVERFL=
OW;
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return wt2;
 > -}
 > -
 > -uint32_t helper_float_cvt_w_d(CPUMIPSState *env, uint64_t fdt0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 wt2 =3D float64_to_int32(fdt0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt2 =3D FP_TO_INT32_OVERFL=
OW;
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return wt2;
 > -}
 > -
 > -uint64_t helper_float_round_l_d(CPUMIPSState *env, uint64_t fdt0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_nearest_even,
 > - &env->active_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 dt2 =3D float64_to_int64(fdt0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt2 =3D FP_TO_INT64_OVERFL=
OW;
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return dt2;
 > -}
 > -
 > -uint64_t helper_float_round_l_s(CPUMIPSState *env, uint32_t fst0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_nearest_even,
 > - &env->active_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 dt2 =3D float32_to_int64(fst0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt2 =3D FP_TO_INT64_OVERFL=
OW;
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return dt2;
 > -}
 > -
 > -uint32_t helper_float_round_w_d(CPUMIPSState *env, uint64_t fdt0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_nearest_even,
 > - &env->active_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 wt2 =3D float64_to_int32(fdt0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt2 =3D FP_TO_INT32_OVERFL=
OW;
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return wt2;
 > -}
 > -
 > -uint32_t helper_float_round_w_s(CPUMIPSState *env, uint32_t fst0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_nearest_even,
 > - &env->active_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 wt2 =3D float32_to_int32(fst0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt2 =3D FP_TO_INT32_OVERFL=
OW;
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return wt2;
 > -}
 > -
 > -uint64_t helper_float_trunc_l_d(CPUMIPSState *env, uint64_t fdt0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 dt2 =3D float64_to_int64_round_to_zero(fdt0,
 > - &env->active_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt2 =3D FP_TO_INT64_OVERFL=
OW;
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return dt2;
 > -}
 > -
 > -uint64_t helper_float_trunc_l_s(CPUMIPSState *env, uint32_t fst0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 dt2 =3D float32_to_int64_round_to_zero(fst0,=20
&env->active_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt2 =3D FP_TO_INT64_OVERFL=
OW;
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return dt2;
 > -}
 > -
 > -uint32_t helper_float_trunc_w_d(CPUMIPSState *env, uint64_t fdt0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 wt2 =3D float64_to_int32_round_to_zero(fdt0,=20
&env->active_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt2 =3D FP_TO_INT32_OVERFL=
OW;
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return wt2;
 > -}
 > -
 > -uint32_t helper_float_trunc_w_s(CPUMIPSState *env, uint32_t fst0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 wt2 =3D float32_to_int32_round_to_zero(fst0,=20
&env->active_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt2 =3D FP_TO_INT32_OVERFL=
OW;
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return wt2;
 > -}
 > -
 > -uint64_t helper_float_ceil_l_d(CPUMIPSState *env, uint64_t fdt0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_up, &env->acti=
ve_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 dt2 =3D float64_to_int64(fdt0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt2 =3D FP_TO_INT64_OVERFL=
OW;
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return dt2;
 > -}
 > -
 > -uint64_t helper_float_ceil_l_s(CPUMIPSState *env, uint32_t fst0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_up, &env->acti=
ve_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 dt2 =3D float32_to_int64(fst0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt2 =3D FP_TO_INT64_OVERFL=
OW;
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return dt2;
 > -}
 > -
 > -uint32_t helper_float_ceil_w_d(CPUMIPSState *env, uint64_t fdt0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_up, &env->acti=
ve_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 wt2 =3D float64_to_int32(fdt0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt2 =3D FP_TO_INT32_OVERFL=
OW;
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return wt2;
 > -}
 > -
 > -uint32_t helper_float_ceil_w_s(CPUMIPSState *env, uint32_t fst0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_up, &env->acti=
ve_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 wt2 =3D float32_to_int32(fst0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt2 =3D FP_TO_INT32_OVERFL=
OW;
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return wt2;
 > -}
 > -
 > -uint64_t helper_float_floor_l_d(CPUMIPSState *env, uint64_t fdt0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_down,=20
&env->active_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 dt2 =3D float64_to_int64(fdt0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt2 =3D FP_TO_INT64_OVERFL=
OW;
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return dt2;
 > -}
 > -
 > -uint64_t helper_float_floor_l_s(CPUMIPSState *env, uint32_t fst0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_down,=20
&env->active_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 dt2 =3D float32_to_int64(fst0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt2 =3D FP_TO_INT64_OVERFL=
OW;
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return dt2;
 > -}
 > -
 > -uint32_t helper_float_floor_w_d(CPUMIPSState *env, uint64_t fdt0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_down,=20
&env->active_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 wt2 =3D float64_to_int32(fdt0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt2 =3D FP_TO_INT32_OVERFL=
OW;
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return wt2;
 > -}
 > -
 > -uint32_t helper_float_floor_w_s(CPUMIPSState *env, uint32_t fst0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_down,=20
&env->active_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 wt2 =3D float32_to_int32(fst0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & (float_flag_invalid | fl=
oat_flag_overflow)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt2 =3D FP_TO_INT32_OVERFL=
OW;
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return wt2;
 > -}
 > -
 > -uint64_t helper_float_cvt_2008_l_d(CPUMIPSState *env, uint64_t fdt0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 dt2 =3D float64_to_int64(fdt0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float64_is_any_nan(fdt=
0)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt=
2 =3D 0;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return dt2;
 > -}
 > -
 > -uint64_t helper_float_cvt_2008_l_s(CPUMIPSState *env, uint32_t fst0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 dt2 =3D float32_to_int64(fst0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float32_is_any_nan(fst=
0)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt=
2 =3D 0;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return dt2;
 > -}
 > -
 > -uint32_t helper_float_cvt_2008_w_d(CPUMIPSState *env, uint64_t fdt0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 wt2 =3D float64_to_int32(fdt0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float64_is_any_nan(fdt=
0)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt=
2 =3D 0;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return wt2;
 > -}
 > -
 > -uint32_t helper_float_cvt_2008_w_s(CPUMIPSState *env, uint32_t fst0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 wt2 =3D float32_to_int32(fst0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float32_is_any_nan(fst=
0)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt=
2 =3D 0;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return wt2;
 > -}
 > -
 > -uint64_t helper_float_round_2008_l_d(CPUMIPSState *env, uint64_t fdt0=
)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_nearest_even,
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &e=
nv->active_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 dt2 =3D float64_to_int64(fdt0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float64_is_any_nan(fdt=
0)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt=
2 =3D 0;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return dt2;
 > -}
 > -
 > -uint64_t helper_float_round_2008_l_s(CPUMIPSState *env, uint32_t fst0=
)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_nearest_even,
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &e=
nv->active_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 dt2 =3D float32_to_int64(fst0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float32_is_any_nan(fst=
0)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt=
2 =3D 0;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return dt2;
 > -}
 > -
 > -uint32_t helper_float_round_2008_w_d(CPUMIPSState *env, uint64_t fdt0=
)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_nearest_even,
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &e=
nv->active_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 wt2 =3D float64_to_int32(fdt0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float64_is_any_nan(fdt=
0)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt=
2 =3D 0;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return wt2;
 > -}
 > -
 > -uint32_t helper_float_round_2008_w_s(CPUMIPSState *env, uint32_t fst0=
)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_nearest_even,
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &e=
nv->active_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 wt2 =3D float32_to_int32(fst0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float32_is_any_nan(fst=
0)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt=
2 =3D 0;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return wt2;
 > -}
 > -
 > -uint64_t helper_float_trunc_2008_l_d(CPUMIPSState *env, uint64_t fdt0=
)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 dt2 =3D float64_to_int64_round_to_zero(fdt0,=20
&env->active_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float64_is_any_nan(fdt=
0)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt=
2 =3D 0;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return dt2;
 > -}
 > -
 > -uint64_t helper_float_trunc_2008_l_s(CPUMIPSState *env, uint32_t fst0=
)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 dt2 =3D float32_to_int64_round_to_zero(fst0,=20
&env->active_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float32_is_any_nan(fst=
0)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt=
2 =3D 0;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return dt2;
 > -}
 > -
 > -uint32_t helper_float_trunc_2008_w_d(CPUMIPSState *env, uint64_t fdt0=
)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 wt2 =3D float64_to_int32_round_to_zero(fdt0,=20
&env->active_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float64_is_any_nan(fdt=
0)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt=
2 =3D 0;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return wt2;
 > -}
 > -
 > -uint32_t helper_float_trunc_2008_w_s(CPUMIPSState *env, uint32_t fst0=
)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 wt2 =3D float32_to_int32_round_to_zero(fst0,=20
&env->active_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float32_is_any_nan(fst=
0)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt=
2 =3D 0;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return wt2;
 > -}
 > -
 > -uint64_t helper_float_ceil_2008_l_d(CPUMIPSState *env, uint64_t fdt0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_up, &env->acti=
ve_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 dt2 =3D float64_to_int64(fdt0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float64_is_any_nan(fdt=
0)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt=
2 =3D 0;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return dt2;
 > -}
 > -
 > -uint64_t helper_float_ceil_2008_l_s(CPUMIPSState *env, uint32_t fst0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_up, &env->acti=
ve_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 dt2 =3D float32_to_int64(fst0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float32_is_any_nan(fst=
0)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt=
2 =3D 0;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return dt2;
 > -}
 > -
 > -uint32_t helper_float_ceil_2008_w_d(CPUMIPSState *env, uint64_t fdt0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_up, &env->acti=
ve_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 wt2 =3D float64_to_int32(fdt0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float64_is_any_nan(fdt=
0)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt=
2 =3D 0;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return wt2;
 > -}
 > -
 > -uint32_t helper_float_ceil_2008_w_s(CPUMIPSState *env, uint32_t fst0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_up, &env->acti=
ve_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 wt2 =3D float32_to_int32(fst0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float32_is_any_nan(fst=
0)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt=
2 =3D 0;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return wt2;
 > -}
 > -
 > -uint64_t helper_float_floor_2008_l_d(CPUMIPSState *env, uint64_t fdt0=
)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_down,=20
&env->active_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 dt2 =3D float64_to_int64(fdt0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float64_is_any_nan(fdt=
0)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt=
2 =3D 0;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return dt2;
 > -}
 > -
 > -uint64_t helper_float_floor_2008_l_s(CPUMIPSState *env, uint32_t fst0=
)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint64_t dt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_down,=20
&env->active_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 dt2 =3D float32_to_int64(fst0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float32_is_any_nan(fst=
0)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt=
2 =3D 0;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return dt2;
 > -}
 > -
 > -uint32_t helper_float_floor_2008_w_d(CPUMIPSState *env, uint64_t fdt0=
)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_down,=20
&env->active_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 wt2 =3D float64_to_int32(fdt0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float64_is_any_nan(fdt=
0)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt=
2 =3D 0;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return wt2;
 > -}
 > -
 > -uint32_t helper_float_floor_2008_w_s(CPUMIPSState *env, uint32_t fst0=
)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t wt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 set_float_rounding_mode(float_round_down,=20
&env->active_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 wt2 =3D float32_to_int32(fst0, &env->active_fpu.fp=
_status);
 > -=C2=A0=C2=A0=C2=A0 restore_rounding_mode(env);
 > -=C2=A0=C2=A0=C2=A0 if (get_float_exception_flags(&env->active_fpu.fp_=
status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 & =
float_flag_invalid) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float32_is_any_nan(fst=
0)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wt=
2 =3D 0;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return wt2;
 > -}
 > -
 > -/* unary operations, not modifying fp status=C2=A0 */
 > -#define FLOAT_UNOP(name) \
 > -uint64_t helper_float_ ## name ## _d(uint64_t fdt0)=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
\
 > -{ \
 > -=C2=A0=C2=A0=C2=A0 return float64_ ## name(fdt0); \
 > -} \
 > -uint32_t helper_float_ ## name ## _s(uint32_t fst0)=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
\
 > -{ \
 > -=C2=A0=C2=A0=C2=A0 return float32_ ## name(fst0); \
 > -} \
 > -uint64_t helper_float_ ## name ## _ps(uint64_t fdt0)=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -{ \
 > -=C2=A0=C2=A0=C2=A0 uint32_t wt0; \
 > -=C2=A0=C2=A0=C2=A0 uint32_t wth0; \
 > - \
 > -=C2=A0=C2=A0=C2=A0 wt0 =3D float32_ ## name(fdt0 & 0XFFFFFFFF);=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 wth0 =3D float32_ ## name(fdt0 >> 32);=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 return ((uint64_t)wth0 << 32) | wt0;=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -}
 > -FLOAT_UNOP(abs)
 > -FLOAT_UNOP(chs)
 > -#undef FLOAT_UNOP
 > -
 > -/* MIPS specific unary operations */
 > -uint64_t helper_float_recip_d(CPUMIPSState *env, uint64_t fdt0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint64_t fdt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 fdt2 =3D float64_div(float64_one, fdt0, &env->acti=
ve_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return fdt2;
 > -}
 > -
 > -uint32_t helper_float_recip_s(CPUMIPSState *env, uint32_t fst0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t fst2;
 > -
 > -=C2=A0=C2=A0=C2=A0 fst2 =3D float32_div(float32_one, fst0, &env->acti=
ve_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return fst2;
 > -}
 > -
 > -uint64_t helper_float_rsqrt_d(CPUMIPSState *env, uint64_t fdt0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint64_t fdt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 fdt2 =3D float64_sqrt(fdt0, &env->active_fpu.fp_st=
atus);
 > -=C2=A0=C2=A0=C2=A0 fdt2 =3D float64_div(float64_one, fdt2, &env->acti=
ve_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return fdt2;
 > -}
 > -
 > -uint32_t helper_float_rsqrt_s(CPUMIPSState *env, uint32_t fst0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t fst2;
 > -
 > -=C2=A0=C2=A0=C2=A0 fst2 =3D float32_sqrt(fst0, &env->active_fpu.fp_st=
atus);
 > -=C2=A0=C2=A0=C2=A0 fst2 =3D float32_div(float32_one, fst2, &env->acti=
ve_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return fst2;
 > -}
 > -
 > -uint64_t helper_float_recip1_d(CPUMIPSState *env, uint64_t fdt0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint64_t fdt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 fdt2 =3D float64_div(float64_one, fdt0, &env->acti=
ve_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return fdt2;
 > -}
 > -
 > -uint32_t helper_float_recip1_s(CPUMIPSState *env, uint32_t fst0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t fst2;
 > -
 > -=C2=A0=C2=A0=C2=A0 fst2 =3D float32_div(float32_one, fst0, &env->acti=
ve_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return fst2;
 > -}
 > -
 > -uint64_t helper_float_recip1_ps(CPUMIPSState *env, uint64_t fdt0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t fst2;
 > -=C2=A0=C2=A0=C2=A0 uint32_t fsth2;
 > -
 > -=C2=A0=C2=A0=C2=A0 fst2 =3D float32_div(float32_one, fdt0 & 0XFFFFFFF=
F,
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &env->act=
ive_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 fsth2 =3D float32_div(float32_one, fdt0 >> 32,=20
&env->active_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return ((uint64_t)fsth2 << 32) | fst2;
 > -}
 > -
 > -uint64_t helper_float_rsqrt1_d(CPUMIPSState *env, uint64_t fdt0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint64_t fdt2;
 > -
 > -=C2=A0=C2=A0=C2=A0 fdt2 =3D float64_sqrt(fdt0, &env->active_fpu.fp_st=
atus);
 > -=C2=A0=C2=A0=C2=A0 fdt2 =3D float64_div(float64_one, fdt2, &env->acti=
ve_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return fdt2;
 > -}
 > -
 > -uint32_t helper_float_rsqrt1_s(CPUMIPSState *env, uint32_t fst0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t fst2;
 > -
 > -=C2=A0=C2=A0=C2=A0 fst2 =3D float32_sqrt(fst0, &env->active_fpu.fp_st=
atus);
 > -=C2=A0=C2=A0=C2=A0 fst2 =3D float32_div(float32_one, fst2, &env->acti=
ve_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return fst2;
 > -}
 > -
 > -uint64_t helper_float_rsqrt1_ps(CPUMIPSState *env, uint64_t fdt0)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t fst2;
 > -=C2=A0=C2=A0=C2=A0 uint32_t fsth2;
 > -
 > -=C2=A0=C2=A0=C2=A0 fst2 =3D float32_sqrt(fdt0 & 0XFFFFFFFF, &env->act=
ive_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 fsth2 =3D float32_sqrt(fdt0 >> 32, &env->active_fp=
u.fp_status);
 > -=C2=A0=C2=A0=C2=A0 fst2 =3D float32_div(float32_one, fst2, &env->acti=
ve_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 fsth2 =3D float32_div(float32_one, fsth2, &env->ac=
tive_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return ((uint64_t)fsth2 << 32) | fst2;
 > -}
 > -
 > -#define FLOAT_RINT(name,=20
bits)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -uint ## bits ## _t helper_float_ ## name(CPUMIPSState=20
*env,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 uint ## bits ## _t=20
fs)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 \
 > -{ \
 > -=C2=A0=C2=A0=C2=A0 uint ## bits ## _t=20
fdret;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > - \
 > -=C2=A0=C2=A0=C2=A0 fdret =3D float ## bits ## _round_to_int(fs,=20
&env->active_fpu.fp_status); \
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env,=20
GETPC());=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 return=20
fdret;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -}
 > -
 > -FLOAT_RINT(rint_s, 32)
 > -FLOAT_RINT(rint_d, 64)
 > -#undef FLOAT_RINT
 > -
 > -#define FLOAT_CLASS_SIGNALING_NAN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x001
 > -#define FLOAT_CLASS_QUIET_NAN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x002
 > -#define FLOAT_CLASS_NEGATIVE_INFINITY=C2=A0 0x004
 > -#define FLOAT_CLASS_NEGATIVE_NORMAL=C2=A0=C2=A0=C2=A0 0x008
 > -#define FLOAT_CLASS_NEGATIVE_SUBNORMAL 0x010
 > -#define FLOAT_CLASS_NEGATIVE_ZERO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x020
 > -#define FLOAT_CLASS_POSITIVE_INFINITY=C2=A0 0x040
 > -#define FLOAT_CLASS_POSITIVE_NORMAL=C2=A0=C2=A0=C2=A0 0x080
 > -#define FLOAT_CLASS_POSITIVE_SUBNORMAL 0x100
 > -#define FLOAT_CLASS_POSITIVE_ZERO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x200
 > -
 > -#define FLOAT_CLASS(name, bits)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -uint ## bits ## _t float_ ## name(uint ## bits ## _t arg,=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float_status *stat=
us)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 \
 > -{ \
 > -=C2=A0=C2=A0=C2=A0 if (float ## bits ## _is_signaling_nan(arg, status=
)) {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return FLOAT_CLASS_SIGNALI=
NG_NAN;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 } else if (float ## bits ## _is_quiet_nan(arg, sta=
tus)) {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return FLOAT_CLASS_QUIET_N=
AN;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 } else if (float ## bits ## _is_neg(arg)) {=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float ## bits ## _is_i=
nfinity(arg)) {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn FLOAT_CLASS_NEGATIVE_INFINITY;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (float ## bits #=
# _is_zero(arg)) {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn FLOAT_CLASS_NEGATIVE_ZERO;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (float ## bits #=
# _is_zero_or_denormal(arg)) {=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn FLOAT_CLASS_NEGATIVE_SUBNORMAL;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn FLOAT_CLASS_NEGATIVE_NORMAL;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 \
 > - }=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 } else {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (float ## bits ## _is_i=
nfinity(arg)) {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn FLOAT_CLASS_POSITIVE_INFINITY;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (float ## bits #=
# _is_zero(arg)) {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn FLOAT_CLASS_POSITIVE_ZERO;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (float ## bits #=
# _is_zero_or_denormal(arg)) {=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn FLOAT_CLASS_POSITIVE_SUBNORMAL;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn FLOAT_CLASS_POSITIVE_NORMAL;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 \
 > - }=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > - }=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 \
 > -} \
 > - \
 > -uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 uint ## bits ## _t arg)=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -{ \
 > -=C2=A0=C2=A0=C2=A0 return float_ ## name(arg, &env->active_fpu.fp_sta=
tus);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -}
 > -
 > -FLOAT_CLASS(class_s, 32)
 > -FLOAT_CLASS(class_d, 64)
 > -#undef FLOAT_CLASS
 > -
 > -/* binary operations */
 > -#define FLOAT_BINOP(name)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -uint64_t helper_float_ ## name ## _d(CPUMIPSState *env,=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
uint64_t fdt0, uint64_t fdt1) \
 > -{ \
 > -=C2=A0=C2=A0=C2=A0 uint64_t dt2;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > - \
 > -=C2=A0=C2=A0=C2=A0 dt2 =3D float64_ ## name(fdt0, fdt1, &env->active_=
fpu.fp_status);\
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 return dt2;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -} \
 > - \
 > -uint32_t helper_float_ ## name ## _s(CPUMIPSState *env,=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
uint32_t fst0, uint32_t fst1) \
 > -{ \
 > -=C2=A0=C2=A0=C2=A0 uint32_t wt2;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > - \
 > -=C2=A0=C2=A0=C2=A0 wt2 =3D float32_ ## name(fst0, fst1, &env->active_=
fpu.fp_status);\
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 return wt2;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -} \
 > - \
 > -uint64_t helper_float_ ## name ## _ps(CPUMIPSState *env,=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 uint64_t fdt0,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 uint64_t fdt1)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -{ \
 > -=C2=A0=C2=A0=C2=A0 uint32_t fst0 =3D fdt0 & 0XFFFFFFFF;=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
 > -=C2=A0=C2=A0=C2=A0 uint32_t fsth0 =3D fdt0 >> 32;=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 uint32_t fst1 =3D fdt1 & 0XFFFFFFFF;=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
 > -=C2=A0=C2=A0=C2=A0 uint32_t fsth1 =3D fdt1 >> 32;=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 uint32_t wt2;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 uint32_t wth2;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > - \
 > -=C2=A0=C2=A0=C2=A0 wt2 =3D float32_ ## name(fst0, fst1,=20
&env->active_fpu.fp_status);=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 wth2 =3D float32_ ## name(fsth0, fsth1,=20
&env->active_fpu.fp_status);=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 return ((uint64_t)wth2 << 32) | wt2;=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -}
 > -
 > -FLOAT_BINOP(add)
 > -FLOAT_BINOP(sub)
 > -FLOAT_BINOP(mul)
 > -FLOAT_BINOP(div)
 > -#undef FLOAT_BINOP
 > -
 > -/* MIPS specific binary operations */
 > -uint64_t helper_float_recip2_d(CPUMIPSState *env, uint64_t fdt0,=20
uint64_t fdt2)
 > -{
 > -=C2=A0=C2=A0=C2=A0 fdt2 =3D float64_mul(fdt0, fdt2, &env->active_fpu.=
fp_status);
 > -=C2=A0=C2=A0=C2=A0 fdt2 =3D float64_chs(float64_sub(fdt2, float64_one=
,
 > - &env->active_fpu.fp_status));
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return fdt2;
 > -}
 > -
 > -uint32_t helper_float_recip2_s(CPUMIPSState *env, uint32_t fst0,=20
uint32_t fst2)
 > -{
 > -=C2=A0=C2=A0=C2=A0 fst2 =3D float32_mul(fst0, fst2, &env->active_fpu.=
fp_status);
 > -=C2=A0=C2=A0=C2=A0 fst2 =3D float32_chs(float32_sub(fst2, float32_one=
,
 > - &env->active_fpu.fp_status));
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return fst2;
 > -}
 > -
 > -uint64_t helper_float_recip2_ps(CPUMIPSState *env, uint64_t fdt0,=20
uint64_t fdt2)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t fst0 =3D fdt0 & 0XFFFFFFFF;
 > -=C2=A0=C2=A0=C2=A0 uint32_t fsth0 =3D fdt0 >> 32;
 > -=C2=A0=C2=A0=C2=A0 uint32_t fst2 =3D fdt2 & 0XFFFFFFFF;
 > -=C2=A0=C2=A0=C2=A0 uint32_t fsth2 =3D fdt2 >> 32;
 > -
 > -=C2=A0=C2=A0=C2=A0 fst2 =3D float32_mul(fst0, fst2, &env->active_fpu.=
fp_status);
 > -=C2=A0=C2=A0=C2=A0 fsth2 =3D float32_mul(fsth0, fsth2, &env->active_f=
pu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 fst2 =3D float32_chs(float32_sub(fst2, float32_one=
,
 > - &env->active_fpu.fp_status));
 > -=C2=A0=C2=A0=C2=A0 fsth2 =3D float32_chs(float32_sub(fsth2, float32_o=
ne,
 > - &env->active_fpu.fp_status));
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return ((uint64_t)fsth2 << 32) | fst2;
 > -}
 > -
 > -uint64_t helper_float_rsqrt2_d(CPUMIPSState *env, uint64_t fdt0,=20
uint64_t fdt2)
 > -{
 > -=C2=A0=C2=A0=C2=A0 fdt2 =3D float64_mul(fdt0, fdt2, &env->active_fpu.=
fp_status);
 > -=C2=A0=C2=A0=C2=A0 fdt2 =3D float64_sub(fdt2, float64_one, &env->acti=
ve_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 fdt2 =3D float64_chs(float64_div(fdt2, FLOAT_TWO64=
,
 > - &env->active_fpu.fp_status));
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return fdt2;
 > -}
 > -
 > -uint32_t helper_float_rsqrt2_s(CPUMIPSState *env, uint32_t fst0,=20
uint32_t fst2)
 > -{
 > -=C2=A0=C2=A0=C2=A0 fst2 =3D float32_mul(fst0, fst2, &env->active_fpu.=
fp_status);
 > -=C2=A0=C2=A0=C2=A0 fst2 =3D float32_sub(fst2, float32_one, &env->acti=
ve_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 fst2 =3D float32_chs(float32_div(fst2, FLOAT_TWO32=
,
 > - &env->active_fpu.fp_status));
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return fst2;
 > -}
 > -
 > -uint64_t helper_float_rsqrt2_ps(CPUMIPSState *env, uint64_t fdt0,=20
uint64_t fdt2)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t fst0 =3D fdt0 & 0XFFFFFFFF;
 > -=C2=A0=C2=A0=C2=A0 uint32_t fsth0 =3D fdt0 >> 32;
 > -=C2=A0=C2=A0=C2=A0 uint32_t fst2 =3D fdt2 & 0XFFFFFFFF;
 > -=C2=A0=C2=A0=C2=A0 uint32_t fsth2 =3D fdt2 >> 32;
 > -
 > -=C2=A0=C2=A0=C2=A0 fst2 =3D float32_mul(fst0, fst2, &env->active_fpu.=
fp_status);
 > -=C2=A0=C2=A0=C2=A0 fsth2 =3D float32_mul(fsth0, fsth2, &env->active_f=
pu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 fst2 =3D float32_sub(fst2, float32_one, &env->acti=
ve_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 fsth2 =3D float32_sub(fsth2, float32_one, &env->ac=
tive_fpu.fp_status);
 > -=C2=A0=C2=A0=C2=A0 fst2 =3D float32_chs(float32_div(fst2, FLOAT_TWO32=
,
 > - &env->active_fpu.fp_status));
 > -=C2=A0=C2=A0=C2=A0 fsth2 =3D float32_chs(float32_div(fsth2, FLOAT_TWO=
32,
 > - &env->active_fpu.fp_status));
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return ((uint64_t)fsth2 << 32) | fst2;
 > -}
 > -
 > -uint64_t helper_float_addr_ps(CPUMIPSState *env, uint64_t fdt0,=20
uint64_t fdt1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t fst0 =3D fdt0 & 0XFFFFFFFF;
 > -=C2=A0=C2=A0=C2=A0 uint32_t fsth0 =3D fdt0 >> 32;
 > -=C2=A0=C2=A0=C2=A0 uint32_t fst1 =3D fdt1 & 0XFFFFFFFF;
 > -=C2=A0=C2=A0=C2=A0 uint32_t fsth1 =3D fdt1 >> 32;
 > -=C2=A0=C2=A0=C2=A0 uint32_t fst2;
 > -=C2=A0=C2=A0=C2=A0 uint32_t fsth2;
 > -
 > -=C2=A0=C2=A0=C2=A0 fst2 =3D float32_add(fst0, fsth0, &env->active_fpu=
.fp_status);
 > -=C2=A0=C2=A0=C2=A0 fsth2 =3D float32_add(fst1, fsth1, &env->active_fp=
u.fp_status);
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return ((uint64_t)fsth2 << 32) | fst2;
 > -}
 > -
 > -uint64_t helper_float_mulr_ps(CPUMIPSState *env, uint64_t fdt0,=20
uint64_t fdt1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t fst0 =3D fdt0 & 0XFFFFFFFF;
 > -=C2=A0=C2=A0=C2=A0 uint32_t fsth0 =3D fdt0 >> 32;
 > -=C2=A0=C2=A0=C2=A0 uint32_t fst1 =3D fdt1 & 0XFFFFFFFF;
 > -=C2=A0=C2=A0=C2=A0 uint32_t fsth1 =3D fdt1 >> 32;
 > -=C2=A0=C2=A0=C2=A0 uint32_t fst2;
 > -=C2=A0=C2=A0=C2=A0 uint32_t fsth2;
 > -
 > -=C2=A0=C2=A0=C2=A0 fst2 =3D float32_mul(fst0, fsth0, &env->active_fpu=
.fp_status);
 > -=C2=A0=C2=A0=C2=A0 fsth2 =3D float32_mul(fst1, fsth1, &env->active_fp=
u.fp_status);
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());
 > -=C2=A0=C2=A0=C2=A0 return ((uint64_t)fsth2 << 32) | fst2;
 > -}
 > -
 > -#define FLOAT_MINMAX(name, bits,=20
minmaxfunc)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -uint ## bits ## _t helper_float_ ## name(CPUMIPSState=20
*env,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 uint ## bits ## _t=20
fs,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 uint ## bits ## _t=20
ft)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -{ \
 > -=C2=A0=C2=A0=C2=A0 uint ## bits ## _t=20
fdret;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > - \
 > -=C2=A0=C2=A0=C2=A0 fdret =3D float ## bits ## _ ## minmaxfunc(fs,=20
ft,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > - &env->active_fpu.fp_status); \
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env,=20
GETPC());=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 return=20
fdret;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -}
 > -
 > -FLOAT_MINMAX(max_s, 32, maxnum)
 > -FLOAT_MINMAX(max_d, 64, maxnum)
 > -FLOAT_MINMAX(maxa_s, 32, maxnummag)
 > -FLOAT_MINMAX(maxa_d, 64, maxnummag)
 > -
 > -FLOAT_MINMAX(min_s, 32, minnum)
 > -FLOAT_MINMAX(min_d, 64, minnum)
 > -FLOAT_MINMAX(mina_s, 32, minnummag)
 > -FLOAT_MINMAX(mina_d, 64, minnummag)
 > -#undef FLOAT_MINMAX
 > -
 > -/* ternary operations */
 > -#define UNFUSED_FMA(prefix, a, b, c, flags)=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -{ \
 > -=C2=A0=C2=A0=C2=A0 a =3D prefix##_mul(a, b, &env->active_fpu.fp_statu=
s);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 if ((flags) & float_muladd_negate_c) {=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a =3D prefix##_sub(a, c, &=
env->active_fpu.fp_status);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 } else {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a =3D prefix##_add(a, c, &=
env->active_fpu.fp_status);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 \
 > - }=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 if ((flags) & float_muladd_negate_result) {=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a =3D prefix##_chs(a);=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 \
 > - }=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 \
 > -}
 > -
 > -/* FMA based operations */
 > -#define FLOAT_FMA(name, type)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -uint64_t helper_float_ ## name ## _d(CPUMIPSState *env,=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
uint64_t fdt0, uint64_t fdt1,=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
uint64_t fdt2)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -{ \
 > -=C2=A0=C2=A0=C2=A0 UNFUSED_FMA(float64, fdt0, fdt1, fdt2, type);=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 return fdt0;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -} \
 > - \
 > -uint32_t helper_float_ ## name ## _s(CPUMIPSState *env,=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
uint32_t fst0, uint32_t fst1,=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
uint32_t fst2)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -{ \
 > -=C2=A0=C2=A0=C2=A0 UNFUSED_FMA(float32, fst0, fst1, fst2, type);=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 return fst0;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -} \
 > - \
 > -uint64_t helper_float_ ## name ## _ps(CPUMIPSState *env,=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 uint64_t fdt0, uint64_t fdt1,=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 uint64_t fdt2)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -{ \
 > -=C2=A0=C2=A0=C2=A0 uint32_t fst0 =3D fdt0 & 0XFFFFFFFF;=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 uint32_t fsth0 =3D fdt0 >> 32;=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 uint32_t fst1 =3D fdt1 & 0XFFFFFFFF;=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 uint32_t fsth1 =3D fdt1 >> 32;=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 uint32_t fst2 =3D fdt2 & 0XFFFFFFFF;=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 uint32_t fsth2 =3D fdt2 >> 32;=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > - \
 > -=C2=A0=C2=A0=C2=A0 UNFUSED_FMA(float32, fst0, fst1, fst2, type);=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 UNFUSED_FMA(float32, fsth0, fsth1, fsth2, type);=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 return ((uint64_t)fsth0 << 32) | fst0;=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -}
 > -FLOAT_FMA(madd, 0)
 > -FLOAT_FMA(msub, float_muladd_negate_c)
 > -FLOAT_FMA(nmadd, float_muladd_negate_result)
 > -FLOAT_FMA(nmsub, float_muladd_negate_result | float_muladd_negate_c)
 > -#undef FLOAT_FMA
 > -
 > -#define FLOAT_FMADDSUB(name, bits,=20
muladd_arg)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 \
 > -uint ## bits ## _t helper_float_ ## name(CPUMIPSState=20
*env,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 uint ## bits ## _t=20
fs,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 uint ## bits ## _t=20
ft,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 uint ## bits ## _t=20
fd)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -{ \
 > -=C2=A0=C2=A0=C2=A0 uint ## bits ## _t=20
fdret;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > - \
 > -=C2=A0=C2=A0=C2=A0 fdret =3D float ## bits ## _muladd(fs, ft, fd,=20
muladd_arg,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
 > - &env->active_fpu.fp_status);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env,=20
GETPC());=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 return=20
fdret;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -}
 > -
 > -FLOAT_FMADDSUB(maddf_s, 32, 0)
 > -FLOAT_FMADDSUB(maddf_d, 64, 0)
 > -FLOAT_FMADDSUB(msubf_s, 32, float_muladd_negate_product)
 > -FLOAT_FMADDSUB(msubf_d, 64, float_muladd_negate_product)
 > -#undef FLOAT_FMADDSUB
 > -
 > -/* compare operations */
 > -#define FOP_COND_D(op, cond) \
 > -void helper_cmp_d_ ## op(CPUMIPSState *env, uint64_t fdt0, \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 uint64_t fdt1, int cc) \
 > -{ \
 > -=C2=A0=C2=A0=C2=A0 int c; \
 > -=C2=A0=C2=A0=C2=A0 c =3D cond; \
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC()); \
 > -=C2=A0=C2=A0=C2=A0 if (c) \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SET_FP_COND(cc, env->activ=
e_fpu);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 else \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CLEAR_FP_COND(cc, env->act=
ive_fpu);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -} \
 > -void helper_cmpabs_d_ ## op(CPUMIPSState *env, uint64_t fdt0, \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 uint64_t fdt1, int cc) \
 > -{ \
 > -=C2=A0=C2=A0=C2=A0 int c; \
 > -=C2=A0=C2=A0=C2=A0 fdt0 =3D float64_abs(fdt0); \
 > -=C2=A0=C2=A0=C2=A0 fdt1 =3D float64_abs(fdt1); \
 > -=C2=A0=C2=A0=C2=A0 c =3D cond; \
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC()); \
 > -=C2=A0=C2=A0=C2=A0 if (c) \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SET_FP_COND(cc, env->activ=
e_fpu);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 else \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CLEAR_FP_COND(cc, env->act=
ive_fpu);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -}
 > -
 > -/*
 > - * NOTE: the comma operator will make "cond" to eval to false,
 > - * but float64_unordered_quiet() is still called.
 > - */
 > -FOP_COND_D(f,=C2=A0=C2=A0=C2=A0 (float64_unordered_quiet(fdt1, fdt0,
 > - &env->active_fpu.fp_status), 0))
 > -FOP_COND_D(un,=C2=A0=C2=A0 float64_unordered_quiet(fdt1, fdt0,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_D(eq,=C2=A0=C2=A0 float64_eq_quiet(fdt0, fdt1,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_D(ueq,=C2=A0 float64_unordered_quiet(fdt1, fdt0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_eq_quiet(fdt0, fdt1,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_D(olt,=C2=A0 float64_lt_quiet(fdt0, fdt1,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_D(ult,=C2=A0 float64_unordered_quiet(fdt1, fdt0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_lt_quiet(fdt0, fdt1,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_D(ole,=C2=A0 float64_le_quiet(fdt0, fdt1,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_D(ule,=C2=A0 float64_unordered_quiet(fdt1, fdt0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_le_quiet(fdt0, fdt1,
 > - &env->active_fpu.fp_status))
 > -/*
 > - * NOTE: the comma operator will make "cond" to eval to false,
 > - * but float64_unordered() is still called.
 > - */
 > -FOP_COND_D(sf,=C2=A0=C2=A0 (float64_unordered(fdt1, fdt0,
 > - &env->active_fpu.fp_status), 0))
 > -FOP_COND_D(ngle, float64_unordered(fdt1, fdt0,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_D(seq,=C2=A0 float64_eq(fdt0, fdt1,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_D(ngl,=C2=A0 float64_unordered(fdt1, fdt0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_eq(fdt0, fdt1,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_D(lt,=C2=A0=C2=A0 float64_lt(fdt0, fdt1,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_D(nge,=C2=A0 float64_unordered(fdt1, fdt0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_lt(fdt0, fdt1,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_D(le,=C2=A0=C2=A0 float64_le(fdt0, fdt1,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_D(ngt,=C2=A0 float64_unordered(fdt1, fdt0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_le(fdt0, fdt1,
 > - &env->active_fpu.fp_status))
 > -
 > -#define FOP_COND_S(op, cond) \
 > -void helper_cmp_s_ ## op(CPUMIPSState *env, uint32_t fst0, \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 uint32_t fst1, int cc) \
 > -{ \
 > -=C2=A0=C2=A0=C2=A0 int c; \
 > -=C2=A0=C2=A0=C2=A0 c =3D cond; \
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC()); \
 > -=C2=A0=C2=A0=C2=A0 if (c) \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SET_FP_COND(cc, env->activ=
e_fpu);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 else \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CLEAR_FP_COND(cc, env->act=
ive_fpu);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -} \
 > -void helper_cmpabs_s_ ## op(CPUMIPSState *env, uint32_t fst0, \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 uint32_t fst1, int cc) \
 > -{ \
 > -=C2=A0=C2=A0=C2=A0 int c; \
 > -=C2=A0=C2=A0=C2=A0 fst0 =3D float32_abs(fst0); \
 > -=C2=A0=C2=A0=C2=A0 fst1 =3D float32_abs(fst1); \
 > -=C2=A0=C2=A0=C2=A0 c =3D cond; \
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC()); \
 > -=C2=A0=C2=A0=C2=A0 if (c) \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SET_FP_COND(cc, env->activ=
e_fpu);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 else \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CLEAR_FP_COND(cc, env->act=
ive_fpu);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -}
 > -
 > -/*
 > - * NOTE: the comma operator will make "cond" to eval to false,
 > - * but float32_unordered_quiet() is still called.
 > - */
 > -FOP_COND_S(f,=C2=A0=C2=A0=C2=A0 (float32_unordered_quiet(fst1, fst0,
 > - &env->active_fpu.fp_status), 0))
 > -FOP_COND_S(un,=C2=A0=C2=A0 float32_unordered_quiet(fst1, fst0,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_S(eq,=C2=A0=C2=A0 float32_eq_quiet(fst0, fst1,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_S(ueq,=C2=A0 float32_unordered_quiet(fst1, fst0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_eq_quiet(fst0, fst1,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_S(olt,=C2=A0 float32_lt_quiet(fst0, fst1,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_S(ult,=C2=A0 float32_unordered_quiet(fst1, fst0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_lt_quiet(fst0, fst1,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_S(ole,=C2=A0 float32_le_quiet(fst0, fst1,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_S(ule,=C2=A0 float32_unordered_quiet(fst1, fst0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_le_quiet(fst0, fst1,
 > - &env->active_fpu.fp_status))
 > -/*
 > - * NOTE: the comma operator will make "cond" to eval to false,
 > - * but float32_unordered() is still called.
 > - */
 > -FOP_COND_S(sf,=C2=A0=C2=A0 (float32_unordered(fst1, fst0,
 > - &env->active_fpu.fp_status), 0))
 > -FOP_COND_S(ngle, float32_unordered(fst1, fst0,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_S(seq,=C2=A0 float32_eq(fst0, fst1,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_S(ngl,=C2=A0 float32_unordered(fst1, fst0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_eq(fst0, fst1,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_S(lt,=C2=A0=C2=A0 float32_lt(fst0, fst1,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_S(nge,=C2=A0 float32_unordered(fst1, fst0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_lt(fst0, fst1,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_S(le,=C2=A0=C2=A0 float32_le(fst0, fst1,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_S(ngt,=C2=A0 float32_unordered(fst1, fst0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_le(fst0, fst1,
 > - &env->active_fpu.fp_status))
 > -
 > -#define FOP_COND_PS(op, condl, condh)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -void helper_cmp_ps_ ## op(CPUMIPSState *env, uint64_t fdt0,=C2=A0=C2=A0=
=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 uint64_t fdt1, int cc)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -{=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
 > -=C2=A0=C2=A0=C2=A0 uint32_t fst0, fsth0, fst1, fsth1;=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 int ch, cl;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 fst0 =3D fdt0 & 0XFFFFFFFF;=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 fsth0 =3D fdt0 >> 32;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 fst1 =3D fdt1 & 0XFFFFFFFF;=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 fsth1 =3D fdt1 >> 32;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 cl =3D condl;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 ch =3D condh;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 if (cl)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SET_FP_COND(cc, env->activ=
e_fpu);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > - else=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CLEAR_FP_COND(cc, env->act=
ive_fpu);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 if (ch)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SET_FP_COND(cc + 1, env->a=
ctive_fpu);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > - else=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CLEAR_FP_COND(cc + 1, env-=
>active_fpu);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -}=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
 > -void helper_cmpabs_ps_ ## op(CPUMIPSState *env, uint64_t fdt0,=C2=A0 =
\
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t fdt1, int cc)=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -{=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
 > -=C2=A0=C2=A0=C2=A0 uint32_t fst0, fsth0, fst1, fsth1;=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 int ch, cl;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 fst0 =3D float32_abs(fdt0 & 0XFFFFFFFF);=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 fsth0 =3D float32_abs(fdt0 >> 32);=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 fst1 =3D float32_abs(fdt1 & 0XFFFFFFFF);=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 fsth1 =3D float32_abs(fdt1 >> 32);=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 cl =3D condl;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 ch =3D condh;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 if (cl)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SET_FP_COND(cc, env->activ=
e_fpu);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > - else=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CLEAR_FP_COND(cc, env->act=
ive_fpu);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 if (ch)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SET_FP_COND(cc + 1, env->a=
ctive_fpu);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > - else=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CLEAR_FP_COND(cc + 1, env-=
>active_fpu);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -}
 > -
 > -/*
 > - * NOTE: the comma operator will make "cond" to eval to false,
 > - * but float32_unordered_quiet() is still called.
 > - */
 > -FOP_COND_PS(f,=C2=A0=C2=A0=C2=A0 (float32_unordered_quiet(fst1, fst0,
 > - &env->active_fpu.fp_status), 0),
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (float32_unordered_quiet(fsth1, fsth0,
 > - &env->active_fpu.fp_status), 0))
 > -FOP_COND_PS(un,=C2=A0=C2=A0 float32_unordered_quiet(fst1, fst0,
 > - &env->active_fpu.fp_status),
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float32_unordered_quiet(fsth1, fsth0,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_PS(eq,=C2=A0=C2=A0 float32_eq_quiet(fst0, fst1,
 > - &env->active_fpu.fp_status),
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float32_eq_quiet(fsth0, fsth1,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_PS(ueq,=C2=A0 float32_unordered_quiet(fst1, fst0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_eq_quiet(fst0, fst1,
 > - &env->active_fpu.fp_status),
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float32_unordered_quiet(fsth1, fsth0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_eq_quiet(fsth0, fsth1,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_PS(olt,=C2=A0 float32_lt_quiet(fst0, fst1,
 > - &env->active_fpu.fp_status),
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float32_lt_quiet(fsth0, fsth1,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_PS(ult,=C2=A0 float32_unordered_quiet(fst1, fst0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_lt_quiet(fst0, fst1,
 > - &env->active_fpu.fp_status),
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float32_unordered_quiet(fsth1, fsth0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_lt_quiet(fsth0, fsth1,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_PS(ole,=C2=A0 float32_le_quiet(fst0, fst1,
 > - &env->active_fpu.fp_status),
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float32_le_quiet(fsth0, fsth1,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_PS(ule,=C2=A0 float32_unordered_quiet(fst1, fst0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_le_quiet(fst0, fst1,
 > - &env->active_fpu.fp_status),
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float32_unordered_quiet(fsth1, fsth0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_le_quiet(fsth0, fsth1,
 > - &env->active_fpu.fp_status))
 > -/*
 > - * NOTE: the comma operator will make "cond" to eval to false,
 > - * but float32_unordered() is still called.
 > - */
 > -FOP_COND_PS(sf,=C2=A0=C2=A0 (float32_unordered(fst1, fst0,
 > - &env->active_fpu.fp_status), 0),
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (float32_unordered(fsth1, fsth0,
 > - &env->active_fpu.fp_status), 0))
 > -FOP_COND_PS(ngle, float32_unordered(fst1, fst0,
 > - &env->active_fpu.fp_status),
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float32_unordered(fsth1, fsth0,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_PS(seq,=C2=A0 float32_eq(fst0, fst1,
 > - &env->active_fpu.fp_status),
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float32_eq(fsth0, fsth1,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_PS(ngl,=C2=A0 float32_unordered(fst1, fst0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_eq(fst0, fst1,
 > - &env->active_fpu.fp_status),
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float32_unordered(fsth1, fsth0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_eq(fsth0, fsth1,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_PS(lt,=C2=A0=C2=A0 float32_lt(fst0, fst1,
 > - &env->active_fpu.fp_status),
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float32_lt(fsth0, fsth1,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_PS(nge,=C2=A0 float32_unordered(fst1, fst0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_lt(fst0, fst1,
 > - &env->active_fpu.fp_status),
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float32_unordered(fsth1, fsth0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_lt(fsth0, fsth1,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_PS(le,=C2=A0=C2=A0 float32_le(fst0, fst1,
 > - &env->active_fpu.fp_status),
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float32_le(fsth0, fsth1,
 > - &env->active_fpu.fp_status))
 > -FOP_COND_PS(ngt,=C2=A0 float32_unordered(fst1, fst0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_le(fst0, fst1,
 > - &env->active_fpu.fp_status),
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 float32_unordered(fsth1, fsth0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_le(fsth0, fsth1,
 > - &env->active_fpu.fp_status))
 > -
 > -/* R6 compare operations */
 > -#define FOP_CONDN_D(op, cond)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -uint64_t helper_r6_cmp_d_ ## op(CPUMIPSState *env, uint64_t fdt0,=C2=A0=
=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t fdt1)=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -{ \
 > -=C2=A0=C2=A0=C2=A0 uint64_t c;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 c =3D cond;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 if (c) {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 } else {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > - }=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
 > -}
 > -
 > -/*
 > - * NOTE: the comma operator will make "cond" to eval to false,
 > - * but float64_unordered_quiet() is still called.
 > - */
 > -FOP_CONDN_D(af,=C2=A0 (float64_unordered_quiet(fdt1, fdt0,
 > - &env->active_fpu.fp_status), 0))
 > -FOP_CONDN_D(un,=C2=A0 (float64_unordered_quiet(fdt1, fdt0,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_D(eq,=C2=A0 (float64_eq_quiet(fdt0, fdt1,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_D(ueq, (float64_unordered_quiet(fdt1, fdt0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_eq_quiet(fdt0, fdt1,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_D(lt,=C2=A0 (float64_lt_quiet(fdt0, fdt1,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_D(ult, (float64_unordered_quiet(fdt1, fdt0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_lt_quiet(fdt0, fdt1,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_D(le,=C2=A0 (float64_le_quiet(fdt0, fdt1,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_D(ule, (float64_unordered_quiet(fdt1, fdt0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_le_quiet(fdt0, fdt1,
 > - &env->active_fpu.fp_status)))
 > -/*
 > - * NOTE: the comma operator will make "cond" to eval to false,
 > - * but float64_unordered() is still called.\
 > - */
 > -FOP_CONDN_D(saf,=C2=A0 (float64_unordered(fdt1, fdt0,
 > - &env->active_fpu.fp_status), 0))
 > -FOP_CONDN_D(sun,=C2=A0 (float64_unordered(fdt1, fdt0,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_D(seq,=C2=A0 (float64_eq(fdt0, fdt1,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_D(sueq, (float64_unordered(fdt1, fdt0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_eq(fdt0, fdt1,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_D(slt,=C2=A0 (float64_lt(fdt0, fdt1,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_D(sult, (float64_unordered(fdt1, fdt0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_lt(fdt0, fdt1,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_D(sle,=C2=A0 (float64_le(fdt0, fdt1,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_D(sule, (float64_unordered(fdt1, fdt0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_le(fdt0, fdt1,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_D(or,=C2=A0=C2=A0 (float64_le_quiet(fdt1, fdt0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_le_quiet(fdt0, fdt1,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_D(une,=C2=A0 (float64_unordered_quiet(fdt1, fdt0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_lt_quiet(fdt1, fdt0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_lt_quiet(fdt0, fdt1,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_D(ne,=C2=A0=C2=A0 (float64_lt_quiet(fdt1, fdt0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_lt_quiet(fdt0, fdt1,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_D(sor,=C2=A0 (float64_le(fdt1, fdt0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_le(fdt0, fdt1,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_D(sune, (float64_unordered(fdt1, fdt0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_lt(fdt1, fdt0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_lt(fdt0, fdt1,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_D(sne,=C2=A0 (float64_lt(fdt1, fdt0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float64_lt(fdt0, fdt1,
 > - &env->active_fpu.fp_status)))
 > -
 > -#define FOP_CONDN_S(op, cond)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -uint32_t helper_r6_cmp_s_ ## op(CPUMIPSState *env, uint32_t fst0,=C2=A0=
=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t fst1)=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -{ \
 > -=C2=A0=C2=A0=C2=A0 uint64_t c;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 c =3D cond;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 update_fcr31(env, GETPC());=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 if (c) {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0 } else {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
 > - }=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
 > -}
 > -
 > -/*
 > - * NOTE: the comma operator will make "cond" to eval to false,
 > - * but float32_unordered_quiet() is still called.
 > - */
 > -FOP_CONDN_S(af,=C2=A0=C2=A0 (float32_unordered_quiet(fst1, fst0,
 > - &env->active_fpu.fp_status), 0))
 > -FOP_CONDN_S(un,=C2=A0=C2=A0 (float32_unordered_quiet(fst1, fst0,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_S(eq,=C2=A0=C2=A0 (float32_eq_quiet(fst0, fst1,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_S(ueq,=C2=A0 (float32_unordered_quiet(fst1, fst0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_eq_quiet(fst0, fst1,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_S(lt,=C2=A0=C2=A0 (float32_lt_quiet(fst0, fst1,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_S(ult,=C2=A0 (float32_unordered_quiet(fst1, fst0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_lt_quiet(fst0, fst1,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_S(le,=C2=A0=C2=A0 (float32_le_quiet(fst0, fst1,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_S(ule,=C2=A0 (float32_unordered_quiet(fst1, fst0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_le_quiet(fst0, fst1,
 > - &env->active_fpu.fp_status)))
 > -/*
 > - * NOTE: the comma operator will make "cond" to eval to false,
 > - * but float32_unordered() is still called.
 > - */
 > -FOP_CONDN_S(saf,=C2=A0 (float32_unordered(fst1, fst0,
 > - &env->active_fpu.fp_status), 0))
 > -FOP_CONDN_S(sun,=C2=A0 (float32_unordered(fst1, fst0,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_S(seq,=C2=A0 (float32_eq(fst0, fst1,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_S(sueq, (float32_unordered(fst1, fst0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_eq(fst0, fst1,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_S(slt,=C2=A0 (float32_lt(fst0, fst1,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_S(sult, (float32_unordered(fst1, fst0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_lt(fst0, fst1,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_S(sle,=C2=A0 (float32_le(fst0, fst1,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_S(sule, (float32_unordered(fst1, fst0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_le(fst0, fst1,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_S(or,=C2=A0=C2=A0 (float32_le_quiet(fst1, fst0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_le_quiet(fst0, fst1,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_S(une,=C2=A0 (float32_unordered_quiet(fst1, fst0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_lt_quiet(fst1, fst0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_lt_quiet(fst0, fst1,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_S(ne,=C2=A0=C2=A0 (float32_lt_quiet(fst1, fst0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_lt_quiet(fst0, fst1,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_S(sor,=C2=A0 (float32_le(fst1, fst0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_le(fst0, fst1,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_S(sune, (float32_unordered(fst1, fst0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_lt(fst1, fst0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_lt(fst0, fst1,
 > - &env->active_fpu.fp_status)))
 > -FOP_CONDN_S(sne,=C2=A0 (float32_lt(fst1, fst0,
 > - &env->active_fpu.fp_status)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || float32_lt(fst0, fst1,
 > - &env->active_fpu.fp_status)))
 >
 >=C2=A0 /* MSA */
 >=C2=A0 /* Data format min and max values */

Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>


