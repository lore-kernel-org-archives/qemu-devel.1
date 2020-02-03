Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD28C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:30:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA1AE2080C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1AE2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyebw-0000z8-RP
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 11:30:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47798)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.rikalo@rt-rk.com>) id 1iyeaD-0007Jt-2V
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:28:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.rikalo@rt-rk.com>) id 1iyea1-0006J0-DP
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:28:20 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:36351 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.rikalo@rt-rk.com>)
 id 1iyea0-0002cv-CN
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:28:09 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 69A401A20F3;
 Mon,  3 Feb 2020 17:27:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from [10.10.14.141] (rtrkw304-lin.domain.local [10.10.14.141])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 314801A20CC;
 Mon,  3 Feb 2020 17:27:03 +0100 (CET)
Subject: Re: [PATCH 1/2] target mips: Separate CP0-related helpers into their
 own file
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1580745443-24650-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580745443-24650-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Message-ID: <8fe9da0b-e03a-c548-626f-b3b94cc97157@rt-rk.com>
Date: Mon, 3 Feb 2020 17:27:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1580745443-24650-2-git-send-email-aleksandar.markovic@rt-rk.com>
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
 > For clarity and easier maintenence, create target/mips/cp0_helper.c, a=
nd
 > move all cp0-related content form target/mips/op_helper.c to that file=
.
 >
 > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
 > ---
 >=C2=A0 target/mips/Makefile.objs |=C2=A0=C2=A0=C2=A0 5 +-
 >=C2=A0 target/mips/cp0_helper.c=C2=A0 | 1678=20
++++++++++++++++++++++++++++++++++++++++++++
 >=C2=A0 target/mips/op_helper.c=C2=A0=C2=A0 | 1705=20
+--------------------------------------------
 >=C2=A0 3 files changed, 1713 insertions(+), 1675 deletions(-)
 >=C2=A0 create mode 100644 target/mips/cp0_helper.c
 >
 > diff --git a/target/mips/Makefile.objs b/target/mips/Makefile.objs
 > index 3448ad5..3ca2bde 100644
 > --- a/target/mips/Makefile.objs
 > +++ b/target/mips/Makefile.objs
 > @@ -1,5 +1,6 @@
 > -obj-y +=3D translate.o dsp_helper.o op_helper.o lmi_helper.o helper.o=
=20
cpu.o
 > -obj-y +=3D gdbstub.o msa_helper.o
 > +obj-y +=3D translate.o cpu.o gdbstub.o helper.o
 > +obj-y +=3D op_helper.o cp0_helper.o
 > +obj-y +=3D dsp_helper.o lmi_helper.o msa_helper.o
 >=C2=A0 obj-$(CONFIG_SOFTMMU) +=3D mips-semi.o
 >=C2=A0 obj-$(CONFIG_SOFTMMU) +=3D machine.o cp0_timer.o
 >=C2=A0 obj-$(CONFIG_KVM) +=3D kvm.o
 > diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c
 > new file mode 100644
 > index 0000000..bbf12e4
 > --- /dev/null
 > +++ b/target/mips/cp0_helper.c
 > @@ -0,0 +1,1678 @@
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
 > +
 > +
 > +#ifndef CONFIG_USER_ONLY
 > +/* SMP helpers.=C2=A0 */
 > +static bool mips_vpe_is_wfi(MIPSCPU *c)
 > +{
 > +=C2=A0=C2=A0=C2=A0 CPUState *cpu =3D CPU(c);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *env =3D &c->env;
 > +
 > +=C2=A0=C2=A0=C2=A0 /*
 > +=C2=A0=C2=A0=C2=A0=C2=A0 * If the VPE is halted but otherwise active,=
 it means it's=20
waiting for
 > +=C2=A0=C2=A0=C2=A0=C2=A0 * an interrupt.\
 > +=C2=A0=C2=A0=C2=A0=C2=A0 */
 > +=C2=A0=C2=A0=C2=A0 return cpu->halted && mips_vpe_active(env);
 > +}
 > +
 > +static bool mips_vp_is_wfi(MIPSCPU *c)
 > +{
 > +=C2=A0=C2=A0=C2=A0 CPUState *cpu =3D CPU(c);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *env =3D &c->env;
 > +
 > +=C2=A0=C2=A0=C2=A0 return cpu->halted && mips_vp_active(env);
 > +}
 > +
 > +static inline void mips_vpe_wake(MIPSCPU *c)
 > +{
 > +=C2=A0=C2=A0=C2=A0 /*
 > +=C2=A0=C2=A0=C2=A0=C2=A0 * Don't set ->halted =3D 0 directly, let it =
be done via cpu_has_work
 > +=C2=A0=C2=A0=C2=A0=C2=A0 * because there might be other conditions th=
at state that c should
 > +=C2=A0=C2=A0=C2=A0=C2=A0 * be sleeping.
 > +=C2=A0=C2=A0=C2=A0=C2=A0 */
 > +=C2=A0=C2=A0=C2=A0 qemu_mutex_lock_iothread();
 > +=C2=A0=C2=A0=C2=A0 cpu_interrupt(CPU(c), CPU_INTERRUPT_WAKE);
 > +=C2=A0=C2=A0=C2=A0 qemu_mutex_unlock_iothread();
 > +}
 > +
 > +static inline void mips_vpe_sleep(MIPSCPU *cpu)
 > +{
 > +=C2=A0=C2=A0=C2=A0 CPUState *cs =3D CPU(cpu);
 > +
 > +=C2=A0=C2=A0=C2=A0 /*
 > +=C2=A0=C2=A0=C2=A0=C2=A0 * The VPE was shut off, really go to bed.
 > +=C2=A0=C2=A0=C2=A0=C2=A0 * Reset any old _WAKE requests.
 > +=C2=A0=C2=A0=C2=A0=C2=A0 */
 > +=C2=A0=C2=A0=C2=A0 cs->halted =3D 1;
 > +=C2=A0=C2=A0=C2=A0 cpu_reset_interrupt(cs, CPU_INTERRUPT_WAKE);
 > +}
 > +
 > +static inline void mips_tc_wake(MIPSCPU *cpu, int tc)
 > +{
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *c =3D &cpu->env;
 > +
 > +=C2=A0=C2=A0=C2=A0 /* FIXME: TC reschedule.=C2=A0 */
 > +=C2=A0=C2=A0=C2=A0 if (mips_vpe_active(c) && !mips_vpe_is_wfi(cpu)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mips_vpe_wake(cpu);
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +static inline void mips_tc_sleep(MIPSCPU *cpu, int tc)
 > +{
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *c =3D &cpu->env;
 > +
 > +=C2=A0=C2=A0=C2=A0 /* FIXME: TC reschedule.=C2=A0 */
 > +=C2=A0=C2=A0=C2=A0 if (!mips_vpe_active(c)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mips_vpe_sleep(cpu);
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +/**
 > + * mips_cpu_map_tc:
 > + * @env: CPU from which mapping is performed.
 > + * @tc: Should point to an int with the value of the global TC index.
 > + *
 > + * This function will transform @tc into a local index within the
 > + * returned #CPUMIPSState.
 > + */
 > +
 > +/*
 > + * FIXME: This code assumes that all VPEs have the same number of TCs=
,
 > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 which depends on runtime=
 setup. Can probably be fixed by
 > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 walking the list of CPUM=
IPSStates.
 > + */
 > +static CPUMIPSState *mips_cpu_map_tc(CPUMIPSState *env, int *tc)
 > +{
 > +=C2=A0=C2=A0=C2=A0 MIPSCPU *cpu;
 > +=C2=A0=C2=A0=C2=A0 CPUState *cs;
 > +=C2=A0=C2=A0=C2=A0 CPUState *other_cs;
 > +=C2=A0=C2=A0=C2=A0 int vpe_idx;
 > +=C2=A0=C2=A0=C2=A0 int tc_idx =3D *tc;
 > +
 > +=C2=A0=C2=A0=C2=A0 if (!(env->CP0_VPEConf0 & (1 << CP0VPEC0_MVP))) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Not allowed to address =
other CPUs.=C2=A0 */
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *tc =3D env->current_tc;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return env;
 > +=C2=A0=C2=A0=C2=A0 }
 > +
 > +=C2=A0=C2=A0=C2=A0 cs =3D env_cpu(env);
 > +=C2=A0=C2=A0=C2=A0 vpe_idx =3D tc_idx / cs->nr_threads;
 > +=C2=A0=C2=A0=C2=A0 *tc =3D tc_idx % cs->nr_threads;
 > +=C2=A0=C2=A0=C2=A0 other_cs =3D qemu_get_cpu(vpe_idx);
 > +=C2=A0=C2=A0=C2=A0 if (other_cs =3D=3D NULL) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return env;
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 cpu =3D MIPS_CPU(other_cs);
 > +=C2=A0=C2=A0=C2=A0 return &cpu->env;
 > +}
 > +
 > +/*
 > + * The per VPE CP0_Status register shares some fields with the per TC
 > + * CP0_TCStatus registers. These fields are wired to the same registe=
rs,
 > + * so changes to either of them should be reflected on both registers=
.
 > + *
 > + * Also, EntryHi shares the bottom 8 bit ASID with TCStauts.
 > + *
 > + * These helper call synchronizes the regs for a given cpu.
 > + */
 > +
 > +/*
 > + * Called for updates to CP0_Status.=C2=A0 Defined in "cpu.h" for gdb=
stub.c.
 > + * static inline void sync_c0_status(CPUMIPSState *env, CPUMIPSState=20
*cpu,
 > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int tc);
 > + */
 > +
 > +/* Called for updates to CP0_TCStatus.=C2=A0 */
 > +static void sync_c0_tcstatus(CPUMIPSState *cpu, int tc,
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 target_ulong v)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t status;
 > +=C2=A0=C2=A0=C2=A0 uint32_t tcu, tmx, tasid, tksu;
 > +=C2=A0=C2=A0=C2=A0 uint32_t mask =3D ((1U << CP0St_CU3)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | (1 << C=
P0St_CU2)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | (1 << C=
P0St_CU1)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | (1 << C=
P0St_CU0)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | (1 << C=
P0St_MX)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | (3 << C=
P0St_KSU));
 > +
 > +=C2=A0=C2=A0=C2=A0 tcu =3D (v >> CP0TCSt_TCU0) & 0xf;
 > +=C2=A0=C2=A0=C2=A0 tmx =3D (v >> CP0TCSt_TMX) & 0x1;
 > +=C2=A0=C2=A0=C2=A0 tasid =3D v & cpu->CP0_EntryHi_ASID_mask;
 > +=C2=A0=C2=A0=C2=A0 tksu =3D (v >> CP0TCSt_TKSU) & 0x3;
 > +
 > +=C2=A0=C2=A0=C2=A0 status =3D tcu << CP0St_CU0;
 > +=C2=A0=C2=A0=C2=A0 status |=3D tmx << CP0St_MX;
 > +=C2=A0=C2=A0=C2=A0 status |=3D tksu << CP0St_KSU;
 > +
 > +=C2=A0=C2=A0=C2=A0 cpu->CP0_Status &=3D ~mask;
 > +=C2=A0=C2=A0=C2=A0 cpu->CP0_Status |=3D status;
 > +
 > +=C2=A0=C2=A0=C2=A0 /* Sync the TASID with EntryHi.=C2=A0 */
 > +=C2=A0=C2=A0=C2=A0 cpu->CP0_EntryHi &=3D ~cpu->CP0_EntryHi_ASID_mask;
 > +=C2=A0=C2=A0=C2=A0 cpu->CP0_EntryHi |=3D tasid;
 > +
 > +=C2=A0=C2=A0=C2=A0 compute_hflags(cpu);
 > +}
 > +
 > +/* Called for updates to CP0_EntryHi.=C2=A0 */
 > +static void sync_c0_entryhi(CPUMIPSState *cpu, int tc)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int32_t *tcst;
 > +=C2=A0=C2=A0=C2=A0 uint32_t asid, v =3D cpu->CP0_EntryHi;
 > +
 > +=C2=A0=C2=A0=C2=A0 asid =3D v & cpu->CP0_EntryHi_ASID_mask;
 > +
 > +=C2=A0=C2=A0=C2=A0 if (tc =3D=3D cpu->current_tc) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcst =3D &cpu->active_tc.C=
P0_TCStatus;
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcst =3D &cpu->tcs[tc].CP0=
_TCStatus;
 > +=C2=A0=C2=A0=C2=A0 }
 > +
 > +=C2=A0=C2=A0=C2=A0 *tcst &=3D ~cpu->CP0_EntryHi_ASID_mask;
 > +=C2=A0=C2=A0=C2=A0 *tcst |=3D asid;
 > +}
 > +
 > +/* CP0 helpers */
 > +target_ulong helper_mfc0_mvpcontrol(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 return env->mvp->CP0_MVPControl;
 > +}
 > +
 > +target_ulong helper_mfc0_mvpconf0(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 return env->mvp->CP0_MVPConf0;
 > +}
 > +
 > +target_ulong helper_mfc0_mvpconf1(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 return env->mvp->CP0_MVPConf1;
 > +}
 > +
 > +target_ulong helper_mfc0_random(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 return (int32_t)cpu_mips_get_random(env);
 > +}
 > +
 > +target_ulong helper_mfc0_tcstatus(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 return env->active_tc.CP0_TCStatus;
 > +}
 > +
 > +target_ulong helper_mftc0_tcstatus(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->active_tc.CP=
0_TCStatus;
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->tcs[other_tc=
].CP0_TCStatus;
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +target_ulong helper_mfc0_tcbind(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 return env->active_tc.CP0_TCBind;
 > +}
 > +
 > +target_ulong helper_mftc0_tcbind(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->active_tc.CP=
0_TCBind;
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->tcs[other_tc=
].CP0_TCBind;
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +target_ulong helper_mfc0_tcrestart(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 return env->active_tc.PC;
 > +}
 > +
 > +target_ulong helper_mftc0_tcrestart(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->active_tc.PC=
;
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->tcs[other_tc=
].PC;
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +target_ulong helper_mfc0_tchalt(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 return env->active_tc.CP0_TCHalt;
 > +}
 > +
 > +target_ulong helper_mftc0_tchalt(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->active_tc.CP=
0_TCHalt;
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->tcs[other_tc=
].CP0_TCHalt;
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +target_ulong helper_mfc0_tccontext(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 return env->active_tc.CP0_TCContext;
 > +}
 > +
 > +target_ulong helper_mftc0_tccontext(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->active_tc.CP=
0_TCContext;
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->tcs[other_tc=
].CP0_TCContext;
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +target_ulong helper_mfc0_tcschedule(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 return env->active_tc.CP0_TCSchedule;
 > +}
 > +
 > +target_ulong helper_mftc0_tcschedule(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->active_tc.CP=
0_TCSchedule;
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->tcs[other_tc=
].CP0_TCSchedule;
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +target_ulong helper_mfc0_tcschefback(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 return env->active_tc.CP0_TCScheFBack;
 > +}
 > +
 > +target_ulong helper_mftc0_tcschefback(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->active_tc.CP=
0_TCScheFBack;
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->tcs[other_tc=
].CP0_TCScheFBack;
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +target_ulong helper_mfc0_count(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 return (int32_t)cpu_mips_get_count(env);
 > +}
 > +
 > +target_ulong helper_mfc0_saar(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 if ((env->CP0_SAARI & 0x3f) < 2) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (int32_t) env->CP0_=
SAAR[env->CP0_SAARI & 0x3f];
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 return 0;
 > +}
 > +
 > +target_ulong helper_mfhc0_saar(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 if ((env->CP0_SAARI & 0x3f) < 2) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return env->CP0_SAAR[env->=
CP0_SAARI & 0x3f] >> 32;
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 return 0;
 > +}
 > +
 > +target_ulong helper_mftc0_entryhi(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 return other->CP0_EntryHi;
 > +}
 > +
 > +target_ulong helper_mftc0_cause(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 int32_t tccause;
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tccause =3D other->CP0_Cau=
se;
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tccause =3D other->CP0_Cau=
se;
 > +=C2=A0=C2=A0=C2=A0 }
 > +
 > +=C2=A0=C2=A0=C2=A0 return tccause;
 > +}
 > +
 > +target_ulong helper_mftc0_status(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 return other->CP0_Status;
 > +}
 > +
 > +target_ulong helper_mfc0_lladdr(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 return (int32_t)(env->CP0_LLAddr >> env->CP0_LLAdd=
r_shift);
 > +}
 > +
 > +target_ulong helper_mfc0_maar(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 return (int32_t) env->CP0_MAAR[env->CP0_MAARI];
 > +}
 > +
 > +target_ulong helper_mfhc0_maar(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 return env->CP0_MAAR[env->CP0_MAARI] >> 32;
 > +}
 > +
 > +target_ulong helper_mfc0_watchlo(CPUMIPSState *env, uint32_t sel)
 > +{
 > +=C2=A0=C2=A0=C2=A0 return (int32_t)env->CP0_WatchLo[sel];
 > +}
 > +
 > +target_ulong helper_mfc0_watchhi(CPUMIPSState *env, uint32_t sel)
 > +{
 > +=C2=A0=C2=A0=C2=A0 return (int32_t) env->CP0_WatchHi[sel];
 > +}
 > +
 > +target_ulong helper_mfhc0_watchhi(CPUMIPSState *env, uint32_t sel)
 > +{
 > +=C2=A0=C2=A0=C2=A0 return env->CP0_WatchHi[sel] >> 32;
 > +}
 > +
 > +target_ulong helper_mfc0_debug(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 target_ulong t0 =3D env->CP0_Debug;
 > +=C2=A0=C2=A0=C2=A0 if (env->hflags & MIPS_HFLAG_DM) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t0 |=3D 1 << CP0DB_DM;
 > +=C2=A0=C2=A0=C2=A0 }
 > +
 > +=C2=A0=C2=A0=C2=A0 return t0;
 > +}
 > +
 > +target_ulong helper_mftc0_debug(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 int32_t tcstatus;
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcstatus =3D other->active=
_tc.CP0_Debug_tcstatus;
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcstatus =3D other->tcs[ot=
her_tc].CP0_Debug_tcstatus;
 > +=C2=A0=C2=A0=C2=A0 }
 > +
 > +=C2=A0=C2=A0=C2=A0 /* XXX: Might be wrong, check with EJTAG spec. */
 > +=C2=A0=C2=A0=C2=A0 return (other->CP0_Debug & ~((1 << CP0DB_SSt) | (1=
 <<=20
CP0DB_Halt))) |
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (t=
cstatus & ((1 << CP0DB_SSt) | (1 << CP0DB_Halt)));
 > +}
 > +
 > +#if defined(TARGET_MIPS64)
 > +target_ulong helper_dmfc0_tcrestart(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 return env->active_tc.PC;
 > +}
 > +
 > +target_ulong helper_dmfc0_tchalt(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 return env->active_tc.CP0_TCHalt;
 > +}
 > +
 > +target_ulong helper_dmfc0_tccontext(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 return env->active_tc.CP0_TCContext;
 > +}
 > +
 > +target_ulong helper_dmfc0_tcschedule(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 return env->active_tc.CP0_TCSchedule;
 > +}
 > +
 > +target_ulong helper_dmfc0_tcschefback(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 return env->active_tc.CP0_TCScheFBack;
 > +}
 > +
 > +target_ulong helper_dmfc0_lladdr(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 return env->CP0_LLAddr >> env->CP0_LLAddr_shift;
 > +}
 > +
 > +target_ulong helper_dmfc0_maar(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 return env->CP0_MAAR[env->CP0_MAARI];
 > +}
 > +
 > +target_ulong helper_dmfc0_watchlo(CPUMIPSState *env, uint32_t sel)
 > +{
 > +=C2=A0=C2=A0=C2=A0 return env->CP0_WatchLo[sel];
 > +}
 > +
 > +target_ulong helper_dmfc0_watchhi(CPUMIPSState *env, uint32_t sel)
 > +{
 > +=C2=A0=C2=A0=C2=A0 return env->CP0_WatchHi[sel];
 > +}
 > +
 > +target_ulong helper_dmfc0_saar(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 if ((env->CP0_SAARI & 0x3f) < 2) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return env->CP0_SAAR[env->=
CP0_SAARI & 0x3f];
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 return 0;
 > +}
 > +#endif /* TARGET_MIPS64 */
 > +
 > +void helper_mtc0_index(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t index_p =3D env->CP0_Index & 0x80000000;
 > +=C2=A0=C2=A0=C2=A0 uint32_t tlb_index =3D arg1 & 0x7fffffff;
 > +=C2=A0=C2=A0=C2=A0 if (tlb_index < env->tlb->nb_tlb) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (env->insn_flags & ISA_=
MIPS32R6) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in=
dex_p |=3D arg1 & 0x80000000;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_Index =3D index_p=
 | tlb_index;
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +void helper_mtc0_mvpcontrol(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t mask =3D 0;
 > +=C2=A0=C2=A0=C2=A0 uint32_t newval;
 > +
 > +=C2=A0=C2=A0=C2=A0 if (env->CP0_VPEConf0 & (1 << CP0VPEC0_MVP)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D (1 << CP0MVPCo_C=
PA) | (1 << CP0MVPCo_VPC) |
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (1 << CP0MVPCo_EVP);
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 if (env->mvp->CP0_MVPControl & (1 << CP0MVPCo_VPC)=
) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D (1 << CP0MVPCo_S=
TLB);
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 newval =3D (env->mvp->CP0_MVPControl & ~mask) | (a=
rg1 & mask);
 > +
 > +=C2=A0=C2=A0=C2=A0 /* TODO: Enable/disable shared TLB, enable/disable=
 VPEs. */
 > +
 > +=C2=A0=C2=A0=C2=A0 env->mvp->CP0_MVPControl =3D newval;
 > +}
 > +
 > +void helper_mtc0_vpecontrol(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t mask;
 > +=C2=A0=C2=A0=C2=A0 uint32_t newval;
 > +
 > +=C2=A0=C2=A0=C2=A0 mask =3D (1 << CP0VPECo_YSI) | (1 << CP0VPECo_GSI)=
 |
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << CP=
0VPECo_TE) | (0xff << CP0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 newval =3D (env->CP0_VPEControl & ~mask) | (arg1 &=
 mask);
 > +
 > +=C2=A0=C2=A0=C2=A0 /*
 > +=C2=A0=C2=A0=C2=A0=C2=A0 * Yield scheduler intercept not implemented.
 > +=C2=A0=C2=A0=C2=A0=C2=A0 * Gating storage scheduler intercept not imp=
lemented.
 > +=C2=A0=C2=A0=C2=A0=C2=A0 */
 > +
 > +=C2=A0=C2=A0=C2=A0 /* TODO: Enable/disable TCs. */
 > +
 > +=C2=A0=C2=A0=C2=A0 env->CP0_VPEControl =3D newval;
 > +}
 > +
 > +void helper_mttc0_vpecontrol(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +=C2=A0=C2=A0=C2=A0 uint32_t mask;
 > +=C2=A0=C2=A0=C2=A0 uint32_t newval;
 > +
 > +=C2=A0=C2=A0=C2=A0 mask =3D (1 << CP0VPECo_YSI) | (1 << CP0VPECo_GSI)=
 |
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << CP=
0VPECo_TE) | (0xff << CP0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 newval =3D (other->CP0_VPEControl & ~mask) | (arg1=
 & mask);
 > +
 > +=C2=A0=C2=A0=C2=A0 /* TODO: Enable/disable TCs.=C2=A0 */
 > +
 > +=C2=A0=C2=A0=C2=A0 other->CP0_VPEControl =3D newval;
 > +}
 > +
 > +target_ulong helper_mftc0_vpecontrol(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +=C2=A0=C2=A0=C2=A0 /* FIXME: Mask away return zero on read bits.=C2=A0=
 */
 > +=C2=A0=C2=A0=C2=A0 return other->CP0_VPEControl;
 > +}
 > +
 > +target_ulong helper_mftc0_vpeconf0(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 return other->CP0_VPEConf0;
 > +}
 > +
 > +void helper_mtc0_vpeconf0(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t mask =3D 0;
 > +=C2=A0=C2=A0=C2=A0 uint32_t newval;
 > +
 > +=C2=A0=C2=A0=C2=A0 if (env->CP0_VPEConf0 & (1 << CP0VPEC0_MVP)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (env->CP0_VPEConf0 & (1=
 << CP0VPEC0_VPA)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ma=
sk |=3D (0xff << CP0VPEC0_XTC);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D (1 << CP0VPEC0_M=
VP) | (1 << CP0VPEC0_VPA);
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 newval =3D (env->CP0_VPEConf0 & ~mask) | (arg1 & m=
ask);
 > +
 > +=C2=A0=C2=A0=C2=A0 /* TODO: TC exclusive handling due to ERL/EXL. */
 > +
 > +=C2=A0=C2=A0=C2=A0 env->CP0_VPEConf0 =3D newval;
 > +}
 > +
 > +void helper_mttc0_vpeconf0(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +=C2=A0=C2=A0=C2=A0 uint32_t mask =3D 0;
 > +=C2=A0=C2=A0=C2=A0 uint32_t newval;
 > +
 > +=C2=A0=C2=A0=C2=A0 mask |=3D (1 << CP0VPEC0_MVP) | (1 << CP0VPEC0_VPA=
);
 > +=C2=A0=C2=A0=C2=A0 newval =3D (other->CP0_VPEConf0 & ~mask) | (arg1 &=
 mask);
 > +
 > +=C2=A0=C2=A0=C2=A0 /* TODO: TC exclusive handling due to ERL/EXL.=C2=A0=
 */
 > +=C2=A0=C2=A0=C2=A0 other->CP0_VPEConf0 =3D newval;
 > +}
 > +
 > +void helper_mtc0_vpeconf1(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t mask =3D 0;
 > +=C2=A0=C2=A0=C2=A0 uint32_t newval;
 > +
 > +=C2=A0=C2=A0=C2=A0 if (env->mvp->CP0_MVPControl & (1 << CP0MVPCo_VPC)=
)
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D (0xff << CP0VPEC=
1_NCX) | (0xff << CP0VPEC1_NCP2) |
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (0xff << CP0VPEC1_NCP1);
 > +=C2=A0=C2=A0=C2=A0 newval =3D (env->CP0_VPEConf1 & ~mask) | (arg1 & m=
ask);
 > +
 > +=C2=A0=C2=A0=C2=A0 /* UDI not implemented. */
 > +=C2=A0=C2=A0=C2=A0 /* CP2 not implemented. */
 > +
 > +=C2=A0=C2=A0=C2=A0 /* TODO: Handle FPU (CP1) binding. */
 > +
 > +=C2=A0=C2=A0=C2=A0 env->CP0_VPEConf1 =3D newval;
 > +}
 > +
 > +void helper_mtc0_yqmask(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 /* Yield qualifier inputs not implemented. */
 > +=C2=A0=C2=A0=C2=A0 env->CP0_YQMask =3D 0x00000000;
 > +}
 > +
 > +void helper_mtc0_vpeopt(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 env->CP0_VPEOpt =3D arg1 & 0x0000ffff;
 > +}
 > +
 > +#define MTC0_ENTRYLO_MASK(env) ((env->PAMask >> 6) & 0x3FFFFFFF)
 > +
 > +void helper_mtc0_entrylo0(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 /* 1k pages not implemented */
 > +=C2=A0=C2=A0=C2=A0 target_ulong rxi =3D arg1 & (env->CP0_PageGrain & =
(3u << CP0PG_XIE));
 > +=C2=A0=C2=A0=C2=A0 env->CP0_EntryLo0 =3D (arg1 & MTC0_ENTRYLO_MASK(en=
v))
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | (=
rxi << (CP0EnLo_XI - 30));
 > +}
 > +
 > +#if defined(TARGET_MIPS64)
 > +#define DMTC0_ENTRYLO_MASK(env) (env->PAMask >> 6)
 > +
 > +void helper_dmtc0_entrylo0(CPUMIPSState *env, uint64_t arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint64_t rxi =3D arg1 & ((env->CP0_PageGrain & (3u=
ll <<=20
CP0PG_XIE)) << 32);
 > +=C2=A0=C2=A0=C2=A0 env->CP0_EntryLo0 =3D (arg1 & DMTC0_ENTRYLO_MASK(e=
nv)) | rxi;
 > +}
 > +#endif
 > +
 > +void helper_mtc0_tcstatus(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t mask =3D env->CP0_TCStatus_rw_bitmask;
 > +=C2=A0=C2=A0=C2=A0 uint32_t newval;
 > +
 > +=C2=A0=C2=A0=C2=A0 newval =3D (env->active_tc.CP0_TCStatus & ~mask) |=
 (arg1 & mask);
 > +
 > +=C2=A0=C2=A0=C2=A0 env->active_tc.CP0_TCStatus =3D newval;
 > +=C2=A0=C2=A0=C2=A0 sync_c0_tcstatus(env, env->current_tc, newval);
 > +}
 > +
 > +void helper_mttc0_tcstatus(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->active_tc.CP0_TCSta=
tus =3D arg1;
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->tcs[other_tc].CP0_T=
CStatus =3D arg1;
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 sync_c0_tcstatus(other, other_tc, arg1);
 > +}
 > +
 > +void helper_mtc0_tcbind(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t mask =3D (1 << CP0TCBd_TBE);
 > +=C2=A0=C2=A0=C2=A0 uint32_t newval;
 > +
 > +=C2=A0=C2=A0=C2=A0 if (env->mvp->CP0_MVPControl & (1 << CP0MVPCo_VPC)=
) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D (1 << CP0TCBd_Cu=
rVPE);
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 newval =3D (env->active_tc.CP0_TCBind & ~mask) | (=
arg1 & mask);
 > +=C2=A0=C2=A0=C2=A0 env->active_tc.CP0_TCBind =3D newval;
 > +}
 > +
 > +void helper_mttc0_tcbind(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 uint32_t mask =3D (1 << CP0TCBd_TBE);
 > +=C2=A0=C2=A0=C2=A0 uint32_t newval;
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 if (other->mvp->CP0_MVPControl & (1 << CP0MVPCo_VP=
C)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D (1 << CP0TCBd_Cu=
rVPE);
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 newval =3D (other->active_=
tc.CP0_TCBind & ~mask) | (arg1 & mask);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->active_tc.CP0_TCBin=
d =3D newval;
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 newval =3D (other->tcs[oth=
er_tc].CP0_TCBind & ~mask) | (arg1 &=20
mask);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->tcs[other_tc].CP0_T=
CBind =3D newval;
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +void helper_mtc0_tcrestart(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 env->active_tc.PC =3D arg1;
 > +=C2=A0=C2=A0=C2=A0 env->active_tc.CP0_TCStatus &=3D ~(1 << CP0TCSt_TD=
S);
 > +=C2=A0=C2=A0=C2=A0 env->CP0_LLAddr =3D 0;
 > +=C2=A0=C2=A0=C2=A0 env->lladdr =3D 0;
 > +=C2=A0=C2=A0=C2=A0 /* MIPS16 not implemented. */
 > +}
 > +
 > +void helper_mttc0_tcrestart(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->active_tc.PC =3D ar=
g1;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->active_tc.CP0_TCSta=
tus &=3D ~(1 << CP0TCSt_TDS);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->CP0_LLAddr =3D 0;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->lladdr =3D 0;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* MIPS16 not implemented.=
 */
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->tcs[other_tc].PC =3D=
 arg1;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->tcs[other_tc].CP0_T=
CStatus &=3D ~(1 << CP0TCSt_TDS);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->CP0_LLAddr =3D 0;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->lladdr =3D 0;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* MIPS16 not implemented.=
 */
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +void helper_mtc0_tchalt(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 MIPSCPU *cpu =3D env_archcpu(env);
 > +
 > +=C2=A0=C2=A0=C2=A0 env->active_tc.CP0_TCHalt =3D arg1 & 0x1;
 > +
 > +=C2=A0=C2=A0=C2=A0 /* TODO: Halt TC / Restart (if allocated+active) T=
C. */
 > +=C2=A0=C2=A0=C2=A0 if (env->active_tc.CP0_TCHalt & 1) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mips_tc_sleep(cpu, env->cu=
rrent_tc);
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mips_tc_wake(cpu, env->cur=
rent_tc);
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +void helper_mttc0_tchalt(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +=C2=A0=C2=A0=C2=A0 MIPSCPU *other_cpu =3D env_archcpu(other);
 > +
 > +=C2=A0=C2=A0=C2=A0 /* TODO: Halt TC / Restart (if allocated+active) T=
C. */
 > +
 > +=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->active_tc.CP0_TCHal=
t =3D arg1;
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->tcs[other_tc].CP0_T=
CHalt =3D arg1;
 > +=C2=A0=C2=A0=C2=A0 }
 > +
 > +=C2=A0=C2=A0=C2=A0 if (arg1 & 1) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mips_tc_sleep(other_cpu, o=
ther_tc);
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mips_tc_wake(other_cpu, ot=
her_tc);
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +void helper_mtc0_tccontext(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 env->active_tc.CP0_TCContext =3D arg1;
 > +}
 > +
 > +void helper_mttc0_tccontext(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->active_tc.CP0_TCCon=
text =3D arg1;
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->tcs[other_tc].CP0_T=
CContext =3D arg1;
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +void helper_mtc0_tcschedule(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 env->active_tc.CP0_TCSchedule =3D arg1;
 > +}
 > +
 > +void helper_mttc0_tcschedule(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->active_tc.CP0_TCSch=
edule =3D arg1;
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->tcs[other_tc].CP0_T=
CSchedule =3D arg1;
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +void helper_mtc0_tcschefback(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 env->active_tc.CP0_TCScheFBack =3D arg1;
 > +}
 > +
 > +void helper_mttc0_tcschefback(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->active_tc.CP0_TCSch=
eFBack =3D arg1;
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->tcs[other_tc].CP0_T=
CScheFBack =3D arg1;
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +void helper_mtc0_entrylo1(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 /* 1k pages not implemented */
 > +=C2=A0=C2=A0=C2=A0 target_ulong rxi =3D arg1 & (env->CP0_PageGrain & =
(3u << CP0PG_XIE));
 > +=C2=A0=C2=A0=C2=A0 env->CP0_EntryLo1 =3D (arg1 & MTC0_ENTRYLO_MASK(en=
v))
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | (=
rxi << (CP0EnLo_XI - 30));
 > +}
 > +
 > +#if defined(TARGET_MIPS64)
 > +void helper_dmtc0_entrylo1(CPUMIPSState *env, uint64_t arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint64_t rxi =3D arg1 & ((env->CP0_PageGrain & (3u=
ll <<=20
CP0PG_XIE)) << 32);
 > +=C2=A0=C2=A0=C2=A0 env->CP0_EntryLo1 =3D (arg1 & DMTC0_ENTRYLO_MASK(e=
nv)) | rxi;
 > +}
 > +#endif
 > +
 > +void helper_mtc0_context(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 env->CP0_Context =3D (env->CP0_Context & 0x007FFFF=
F) | (arg1 &=20
~0x007FFFFF);
 > +}
 > +
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
 > +void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32_t=20
*pagemask)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint64_t mask =3D arg1 >> (TARGET_PAGE_BITS + 1);
 > +=C2=A0=C2=A0=C2=A0 if (!(env->insn_flags & ISA_MIPS32R6) || (arg1 =3D=
=3D ~0) ||
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (mask =3D=3D 0x0000 || mas=
k =3D=3D 0x0003 || mask =3D=3D 0x000F ||
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask =3D=3D 0x003F |=
| mask =3D=3D 0x00FF || mask =3D=3D 0x03FF ||
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask =3D=3D 0x0FFF |=
| mask =3D=3D 0x3FFF || mask =3D=3D 0xFFFF)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_PageMask =3D arg1=
 & (0x1FFFFFFF & (TARGET_PAGE_MASK=20
<< 1));
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +void helper_mtc0_pagemask(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 update_pagemask(env, arg1, &env->CP0_PageMask);
 > +}
 > +
 > +void helper_mtc0_pagegrain(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 /* SmartMIPS not implemented */
 > +=C2=A0=C2=A0=C2=A0 /* 1k pages not implemented */
 > +=C2=A0=C2=A0=C2=A0 env->CP0_PageGrain =3D (arg1 & env->CP0_PageGrain_=
rw_bitmask) |
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 (env->CP0_PageGrain &=20
~env->CP0_PageGrain_rw_bitmask);
 > +=C2=A0=C2=A0=C2=A0 compute_hflags(env);
 > +=C2=A0=C2=A0=C2=A0 restore_pamask(env);
 > +}
 > +
 > +void helper_mtc0_segctl0(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 CPUState *cs =3D env_cpu(env);
 > +
 > +=C2=A0=C2=A0=C2=A0 env->CP0_SegCtl0 =3D arg1 & CP0SC0_MASK;
 > +=C2=A0=C2=A0=C2=A0 tlb_flush(cs);
 > +}
 > +
 > +void helper_mtc0_segctl1(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 CPUState *cs =3D env_cpu(env);
 > +
 > +=C2=A0=C2=A0=C2=A0 env->CP0_SegCtl1 =3D arg1 & CP0SC1_MASK;
 > +=C2=A0=C2=A0=C2=A0 tlb_flush(cs);
 > +}
 > +
 > +void helper_mtc0_segctl2(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 CPUState *cs =3D env_cpu(env);
 > +
 > +=C2=A0=C2=A0=C2=A0 env->CP0_SegCtl2 =3D arg1 & CP0SC2_MASK;
 > +=C2=A0=C2=A0=C2=A0 tlb_flush(cs);
 > +}
 > +
 > +void helper_mtc0_pwfield(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +#if defined(TARGET_MIPS64)
 > +=C2=A0=C2=A0=C2=A0 uint64_t mask =3D 0x3F3FFFFFFFULL;
 > +=C2=A0=C2=A0=C2=A0 uint32_t old_ptei =3D (env->CP0_PWField >> CP0PF_P=
TEI) & 0x3FULL;
 > +=C2=A0=C2=A0=C2=A0 uint32_t new_ptei =3D (arg1 >> CP0PF_PTEI) & 0x3FU=
LL;
 > +
 > +=C2=A0=C2=A0=C2=A0 if ((env->insn_flags & ISA_MIPS32R6)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (((arg1 >> CP0PF_BDI) &=
 0x3FULL) < 12) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ma=
sk &=3D ~(0x3FULL << CP0PF_BDI);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (((arg1 >> CP0PF_GDI) &=
 0x3FULL) < 12) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ma=
sk &=3D ~(0x3FULL << CP0PF_GDI);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (((arg1 >> CP0PF_UDI) &=
 0x3FULL) < 12) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ma=
sk &=3D ~(0x3FULL << CP0PF_UDI);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (((arg1 >> CP0PF_MDI) &=
 0x3FULL) < 12) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ma=
sk &=3D ~(0x3FULL << CP0PF_MDI);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (((arg1 >> CP0PF_PTI) &=
 0x3FULL) < 12) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ma=
sk &=3D ~(0x3FULL << CP0PF_PTI);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 env->CP0_PWField =3D arg1 & mask;
 > +
 > +=C2=A0=C2=A0=C2=A0 if ((new_ptei >=3D 32) ||
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((=
env->insn_flags & ISA_MIPS32R6) &&
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (new_ptei =3D=3D 0 || new_p=
tei =3D=3D 1))) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_PWField =3D (env-=
>CP0_PWField & ~0x3FULL) |
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (old_ptei << CP0PF_PTEI);
 > +=C2=A0=C2=A0=C2=A0 }
 > +#else
 > +=C2=A0=C2=A0=C2=A0 uint32_t mask =3D 0x3FFFFFFF;
 > +=C2=A0=C2=A0=C2=A0 uint32_t old_ptew =3D (env->CP0_PWField >> CP0PF_P=
TEW) & 0x3F;
 > +=C2=A0=C2=A0=C2=A0 uint32_t new_ptew =3D (arg1 >> CP0PF_PTEW) & 0x3F;
 > +
 > +=C2=A0=C2=A0=C2=A0 if ((env->insn_flags & ISA_MIPS32R6)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (((arg1 >> CP0PF_GDW) &=
 0x3F) < 12) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ma=
sk &=3D ~(0x3F << CP0PF_GDW);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (((arg1 >> CP0PF_UDW) &=
 0x3F) < 12) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ma=
sk &=3D ~(0x3F << CP0PF_UDW);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (((arg1 >> CP0PF_MDW) &=
 0x3F) < 12) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ma=
sk &=3D ~(0x3F << CP0PF_MDW);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (((arg1 >> CP0PF_PTW) &=
 0x3F) < 12) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ma=
sk &=3D ~(0x3F << CP0PF_PTW);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 env->CP0_PWField =3D arg1 & mask;
 > +
 > +=C2=A0=C2=A0=C2=A0 if ((new_ptew >=3D 32) ||
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((=
env->insn_flags & ISA_MIPS32R6) &&
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (new_ptew =3D=3D 0 || new_p=
tew =3D=3D 1))) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_PWField =3D (env-=
>CP0_PWField & ~0x3F) |
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (old_ptew << CP0PF_PTEW);
 > +=C2=A0=C2=A0=C2=A0 }
 > +#endif
 > +}
 > +
 > +void helper_mtc0_pwsize(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +#if defined(TARGET_MIPS64)
 > +=C2=A0=C2=A0=C2=A0 env->CP0_PWSize =3D arg1 & 0x3F7FFFFFFFULL;
 > +#else
 > +=C2=A0=C2=A0=C2=A0 env->CP0_PWSize =3D arg1 & 0x3FFFFFFF;
 > +#endif
 > +}
 > +
 > +void helper_mtc0_wired(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 if (env->insn_flags & ISA_MIPS32R6) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (arg1 < env->tlb->nb_tl=
b) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 en=
v->CP0_Wired =3D arg1;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_Wired =3D arg1 % =
env->tlb->nb_tlb;
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +void helper_mtc0_pwctl(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +#if defined(TARGET_MIPS64)
 > +=C2=A0=C2=A0=C2=A0 /* PWEn =3D 0. Hardware page table walking is not =
implemented. */
 > +=C2=A0=C2=A0=C2=A0 env->CP0_PWCtl =3D (env->CP0_PWCtl & 0x000000C0) |=
 (arg1 &=20
0x5C00003F);
 > +#else
 > +=C2=A0=C2=A0=C2=A0 env->CP0_PWCtl =3D (arg1 & 0x800000FF);
 > +#endif
 > +}
 > +
 > +void helper_mtc0_srsconf0(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 env->CP0_SRSConf0 |=3D arg1 & env->CP0_SRSConf0_rw=
_bitmask;
 > +}
 > +
 > +void helper_mtc0_srsconf1(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 env->CP0_SRSConf1 |=3D arg1 & env->CP0_SRSConf1_rw=
_bitmask;
 > +}
 > +
 > +void helper_mtc0_srsconf2(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 env->CP0_SRSConf2 |=3D arg1 & env->CP0_SRSConf2_rw=
_bitmask;
 > +}
 > +
 > +void helper_mtc0_srsconf3(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 env->CP0_SRSConf3 |=3D arg1 & env->CP0_SRSConf3_rw=
_bitmask;
 > +}
 > +
 > +void helper_mtc0_srsconf4(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 env->CP0_SRSConf4 |=3D arg1 & env->CP0_SRSConf4_rw=
_bitmask;
 > +}
 > +
 > +void helper_mtc0_hwrena(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t mask =3D 0x0000000F;
 > +
 > +=C2=A0=C2=A0=C2=A0 if ((env->CP0_Config1 & (1 << CP0C1_PC)) &&
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (env->insn_flags & ISA_MIP=
S32R6)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D (1 << 4);
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 if (env->insn_flags & ISA_MIPS32R6) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D (1 << 5);
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 if (env->CP0_Config3 & (1 << CP0C3_ULRI)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D (1 << 29);
 > +
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (arg1 & (1 << 29)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 en=
v->hflags |=3D MIPS_HFLAG_HWRENA_ULR;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 en=
v->hflags &=3D ~MIPS_HFLAG_HWRENA_ULR;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 }
 > +
 > +=C2=A0=C2=A0=C2=A0 env->CP0_HWREna =3D arg1 & mask;
 > +}
 > +
 > +void helper_mtc0_count(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 cpu_mips_store_count(env, arg1);
 > +}
 > +
 > +void helper_mtc0_saari(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t target =3D arg1 & 0x3f;
 > +=C2=A0=C2=A0=C2=A0 if (target <=3D 1) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_SAARI =3D target;
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +void helper_mtc0_saar(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t target =3D env->CP0_SAARI & 0x3f;
 > +=C2=A0=C2=A0=C2=A0 if (target < 2) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_SAAR[target] =3D =
arg1 & 0x00000ffffffff03fULL;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (target) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 0:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (env->itu) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 itc_reconfigure(env->itu);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +void helper_mthc0_saar(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t target =3D env->CP0_SAARI & 0x3f;
 > +=C2=A0=C2=A0=C2=A0 if (target < 2) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_SAAR[target] =3D
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((=
(uint64_t) arg1 << 32) & 0x00000fff00000000ULL) |
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (e=
nv->CP0_SAAR[target] & 0x00000000ffffffffULL);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (target) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 0:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (env->itu) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 itc_reconfigure(env->itu);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +void helper_mtc0_entryhi(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 target_ulong old, val, mask;
 > +=C2=A0=C2=A0=C2=A0 mask =3D (TARGET_PAGE_MASK << 1) | env->CP0_EntryH=
i_ASID_mask;
 > +=C2=A0=C2=A0=C2=A0 if (((env->CP0_Config4 >> CP0C4_IE) & 0x3) >=3D 2)=
 {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D 1 << CP0EnHi_EHI=
NV;
 > +=C2=A0=C2=A0=C2=A0 }
 > +
 > +=C2=A0=C2=A0=C2=A0 /* 1k pages not implemented */
 > +#if defined(TARGET_MIPS64)
 > +=C2=A0=C2=A0=C2=A0 if (env->insn_flags & ISA_MIPS32R6) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int entryhi_r =3D extract6=
4(arg1, 62, 2);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int config0_at =3D extract=
32(env->CP0_Config0, 13, 2);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool no_supervisor =3D (en=
v->CP0_Status_rw_bitmask & 0x8) =3D=3D 0;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((entryhi_r =3D=3D 2) |=
|
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (e=
ntryhi_r =3D=3D 1 && (no_supervisor || config0_at =3D=3D 1))) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 skip EntryHi.R field if new value is reserved */
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ma=
sk &=3D ~(0x3ull << 62);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 mask &=3D env->SEGMask;
 > +#endif
 > +=C2=A0=C2=A0=C2=A0 old =3D env->CP0_EntryHi;
 > +=C2=A0=C2=A0=C2=A0 val =3D (arg1 & mask) | (old & ~mask);
 > +=C2=A0=C2=A0=C2=A0 env->CP0_EntryHi =3D val;
 > +=C2=A0=C2=A0=C2=A0 if (env->CP0_Config3 & (1 << CP0C3_MT)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sync_c0_entryhi(env, env->=
current_tc);
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 /* If the ASID changes, flush qemu's TLB.=C2=A0 */
 > +=C2=A0=C2=A0=C2=A0 if ((old & env->CP0_EntryHi_ASID_mask) !=3D
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (val & env->CP0_EntryHi_AS=
ID_mask)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tlb_flush(env_cpu(env));
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +void helper_mttc0_entryhi(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 other->CP0_EntryHi =3D arg1;
 > +=C2=A0=C2=A0=C2=A0 sync_c0_entryhi(other, other_tc);
 > +}
 > +
 > +void helper_mtc0_compare(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 cpu_mips_store_compare(env, arg1);
 > +}
 > +
 > +void helper_mtc0_status(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t val, old;
 > +
 > +=C2=A0=C2=A0=C2=A0 old =3D env->CP0_Status;
 > +=C2=A0=C2=A0=C2=A0 cpu_mips_store_status(env, arg1);
 > +=C2=A0=C2=A0=C2=A0 val =3D env->CP0_Status;
 > +
 > +=C2=A0=C2=A0=C2=A0 if (qemu_loglevel_mask(CPU_LOG_EXEC)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_log("Status %08x (%08=
x) =3D> %08x (%08x) Cause %08x",
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 old, old & env->CP0_Cause & CP0Ca_IP_mask,
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 val, val & env->CP0_Cause & CP0Ca_IP_mask,
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 env->CP0_Cause);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (cpu_mmu_index(env,=
 false)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 3:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qe=
mu_log(", ERL\n");
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case MIPS_HFLAG_UM:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qe=
mu_log(", UM\n");
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case MIPS_HFLAG_SM:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qe=
mu_log(", SM\n");
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case MIPS_HFLAG_KM:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qe=
mu_log("\n");
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cp=
u_abort(env_cpu(env), "Invalid MMU mode!\n");
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +void helper_mttc0_status(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 uint32_t mask =3D env->CP0_Status_rw_bitmask & ~0x=
f1000018;
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 other->CP0_Status =3D (other->CP0_Status & ~mask) =
| (arg1 & mask);
 > +=C2=A0=C2=A0=C2=A0 sync_c0_status(env, other, other_tc);
 > +}
 > +
 > +void helper_mtc0_intctl(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 env->CP0_IntCtl =3D (env->CP0_IntCtl & ~0x000003e0=
) | (arg1 &=20
0x000003e0);
 > +}
 > +
 > +void helper_mtc0_srsctl(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint32_t mask =3D (0xf << CP0SRSCtl_ESS) | (0xf <<=
 CP0SRSCtl_PSS);
 > +=C2=A0=C2=A0=C2=A0 env->CP0_SRSCtl =3D (env->CP0_SRSCtl & ~mask) | (a=
rg1 & mask);
 > +}
 > +
 > +void helper_mtc0_cause(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 cpu_mips_store_cause(env, arg1);
 > +}
 > +
 > +void helper_mttc0_cause(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 cpu_mips_store_cause(other, arg1);
 > +}
 > +
 > +target_ulong helper_mftc0_epc(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 return other->CP0_EPC;
 > +}
 > +
 > +target_ulong helper_mftc0_ebase(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 return other->CP0_EBase;
 > +}
 > +
 > +void helper_mtc0_ebase(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 target_ulong mask =3D 0x3FFFF000 | env->CP0_EBaseW=
G_rw_bitmask;
 > +=C2=A0=C2=A0=C2=A0 if (arg1 & env->CP0_EBaseWG_rw_bitmask) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D ~0x3FFFFFFF;
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 env->CP0_EBase =3D (env->CP0_EBase & ~mask) | (arg=
1 & mask);
 > +}
 > +
 > +void helper_mttc0_ebase(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +=C2=A0=C2=A0=C2=A0 target_ulong mask =3D 0x3FFFF000 | env->CP0_EBaseW=
G_rw_bitmask;
 > +=C2=A0=C2=A0=C2=A0 if (arg1 & env->CP0_EBaseWG_rw_bitmask) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D ~0x3FFFFFFF;
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 other->CP0_EBase =3D (other->CP0_EBase & ~mask) | =
(arg1 & mask);
 > +}
 > +
 > +target_ulong helper_mftc0_configx(CPUMIPSState *env, target_ulong idx=
)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 switch (idx) {
 > +=C2=A0=C2=A0=C2=A0 case 0: return other->CP0_Config0;
 > +=C2=A0=C2=A0=C2=A0 case 1: return other->CP0_Config1;
 > +=C2=A0=C2=A0=C2=A0 case 2: return other->CP0_Config2;
 > +=C2=A0=C2=A0=C2=A0 case 3: return other->CP0_Config3;
 > +=C2=A0=C2=A0=C2=A0 /* 4 and 5 are reserved.=C2=A0 */
 > +=C2=A0=C2=A0=C2=A0 case 6: return other->CP0_Config6;
 > +=C2=A0=C2=A0=C2=A0 case 7: return other->CP0_Config7;
 > +=C2=A0=C2=A0=C2=A0 default:
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 return 0;
 > +}
 > +
 > +void helper_mtc0_config0(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 env->CP0_Config0 =3D (env->CP0_Config0 & 0x81FFFFF=
8) | (arg1 &=20
0x00000007);
 > +}
 > +
 > +void helper_mtc0_config2(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 /* tertiary/secondary caches not implemented */
 > +=C2=A0=C2=A0=C2=A0 env->CP0_Config2 =3D (env->CP0_Config2 & 0x8FFF0FF=
F);
 > +}
 > +
 > +void helper_mtc0_config3(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 if (env->insn_flags & ASE_MICROMIPS) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_Config3 =3D (env-=
>CP0_Config3 & ~(1 <<=20
CP0C3_ISA_ON_EXC)) |
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 (arg1 & (1 << CP0C3_ISA_ON_EXC));
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +void helper_mtc0_config4(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 env->CP0_Config4 =3D (env->CP0_Config4 &=20
(~env->CP0_Config4_rw_bitmask)) |
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (arg1 & e=
nv->CP0_Config4_rw_bitmask);
 > +}
 > +
 > +void helper_mtc0_config5(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 env->CP0_Config5 =3D (env->CP0_Config5 &=20
(~env->CP0_Config5_rw_bitmask)) |
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (arg1 & e=
nv->CP0_Config5_rw_bitmask);
 > +=C2=A0=C2=A0=C2=A0 env->CP0_EntryHi_ASID_mask =3D (env->CP0_Config5 &=
 (1 << CP0C5_MI)) ?
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x=
0 : (env->CP0_Config4 & (1 << CP0C4_AE)) ? 0x3ff : 0xff;
 > +=C2=A0=C2=A0=C2=A0 compute_hflags(env);
 > +}
 > +
 > +void helper_mtc0_lladdr(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 target_long mask =3D env->CP0_LLAddr_rw_bitmask;
 > +=C2=A0=C2=A0=C2=A0 arg1 =3D arg1 << env->CP0_LLAddr_shift;
 > +=C2=A0=C2=A0=C2=A0 env->CP0_LLAddr =3D (env->CP0_LLAddr & ~mask) | (a=
rg1 & mask);
 > +}
 > +
 > +#define MTC0_MAAR_MASK(env) \
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((0x1ULL << 63) | ((env->P=
AMask >> 4) & ~0xFFFull) | 0x3)
 > +
 > +void helper_mtc0_maar(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 env->CP0_MAAR[env->CP0_MAARI] =3D arg1 & MTC0_MAAR=
_MASK(env);
 > +}
 > +
 > +void helper_mthc0_maar(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 env->CP0_MAAR[env->CP0_MAARI] =3D
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (((uint64_t) arg1 << 32) &=
 MTC0_MAAR_MASK(env)) |
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (env->CP0_MAAR[env->CP0_MA=
ARI] & 0x00000000ffffffffULL);
 > +}
 > +
 > +void helper_mtc0_maari(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int index =3D arg1 & 0x3f;
 > +=C2=A0=C2=A0=C2=A0 if (index =3D=3D 0x3f) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Software may write=
 all ones to INDEX to determine the
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0 maximum valu=
e supported.
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_MAARI =3D MIPS_MA=
AR_MAX - 1;
 > +=C2=A0=C2=A0=C2=A0 } else if (index < MIPS_MAAR_MAX) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_MAARI =3D index;
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 /*
 > +=C2=A0=C2=A0=C2=A0=C2=A0 * Other than the all ones, if the value writ=
ten is not supported,
 > +=C2=A0=C2=A0=C2=A0=C2=A0 * then INDEX is unchanged from its previous =
value.
 > +=C2=A0=C2=A0=C2=A0=C2=A0 */
 > +}
 > +
 > +void helper_mtc0_watchlo(CPUMIPSState *env, target_ulong arg1,=20
uint32_t sel)
 > +{
 > +=C2=A0=C2=A0=C2=A0 /*
 > +=C2=A0=C2=A0=C2=A0=C2=A0 * Watch exceptions for instructions, data lo=
ads, data stores
 > +=C2=A0=C2=A0=C2=A0=C2=A0 * not implemented.
 > +=C2=A0=C2=A0=C2=A0=C2=A0 */
 > +=C2=A0=C2=A0=C2=A0 env->CP0_WatchLo[sel] =3D (arg1 & ~0x7);
 > +}
 > +
 > +void helper_mtc0_watchhi(CPUMIPSState *env, target_ulong arg1,=20
uint32_t sel)
 > +{
 > +=C2=A0=C2=A0=C2=A0 uint64_t mask =3D 0x40000FF8 | (env->CP0_EntryHi_A=
SID_mask <<=20
CP0WH_ASID);
 > +=C2=A0=C2=A0=C2=A0 if ((env->CP0_Config5 >> CP0C5_MI) & 1) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D 0xFFFFFFFF000000=
00ULL; /* MMID */
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 env->CP0_WatchHi[sel] =3D arg1 & mask;
 > +=C2=A0=C2=A0=C2=A0 env->CP0_WatchHi[sel] &=3D ~(env->CP0_WatchHi[sel]=
 & arg1 & 0x7);
 > +}
 > +
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
 > +void helper_mtc0_xcontext(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 target_ulong mask =3D (1ULL << (env->SEGBITS - 7))=
 - 1;
 > +=C2=A0=C2=A0=C2=A0 env->CP0_XContext =3D (env->CP0_XContext & mask) |=
 (arg1 & ~mask);
 > +}
 > +
 > +void helper_mtc0_framemask(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 env->CP0_Framemask =3D arg1; /* XXX */
 > +}
 > +
 > +void helper_mtc0_debug(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 env->CP0_Debug =3D (env->CP0_Debug & 0x8C03FC1F) |=
 (arg1 &=20
0x13300120);
 > +=C2=A0=C2=A0=C2=A0 if (arg1 & (1 << CP0DB_DM)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->hflags |=3D MIPS_HFLA=
G_DM;
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->hflags &=3D ~MIPS_HFL=
AG_DM;
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +void helper_mttc0_debug(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 uint32_t val =3D arg1 & ((1 << CP0DB_SSt) | (1 << =
CP0DB_Halt));
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 /* XXX: Might be wrong, check with EJTAG spec. */
 > +=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->active_tc.CP0_Debug=
_tcstatus =3D val;
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->tcs[other_tc].CP0_D=
ebug_tcstatus =3D val;
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 other->CP0_Debug =3D (other->CP0_Debug &
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((1 << CP0DB_SSt) | (=
1 << CP0DB_Halt))) |
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (arg1 & ~((1 << CP0DB=
_SSt) | (1 << CP0DB_Halt)));
 > +}
 > +
 > +void helper_mtc0_performance0(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 env->CP0_Performance0 =3D arg1 & 0x000007ff;
 > +}
 > +
 > +void helper_mtc0_errctl(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int32_t wst =3D arg1 & (1 << CP0EC_WST);
 > +=C2=A0=C2=A0=C2=A0 int32_t spr =3D arg1 & (1 << CP0EC_SPR);
 > +=C2=A0=C2=A0=C2=A0 int32_t itc =3D env->itc_tag ? (arg1 & (1 << CP0EC=
_ITC)) : 0;
 > +
 > +=C2=A0=C2=A0=C2=A0 env->CP0_ErrCtl =3D wst | spr | itc;
 > +
 > +=C2=A0=C2=A0=C2=A0 if (itc && !wst && !spr) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->hflags |=3D MIPS_HFLA=
G_ITC_CACHE;
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->hflags &=3D ~MIPS_HFL=
AG_ITC_CACHE;
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +void helper_mtc0_taglo(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 if (env->hflags & MIPS_HFLAG_ITC_CACHE) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If CACHE instructi=
on is configured for ITC tags then make all
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * CP0.TagLo bits wri=
table. The actual write to ITC=20
Configuration
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Tag will take care=
 of the read-only bits.
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_TagLo =3D arg1;
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_TagLo =3D arg1 & =
0xFFFFFCF6;
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +void helper_mtc0_datalo(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 env->CP0_DataLo =3D arg1; /* XXX */
 > +}
 > +
 > +void helper_mtc0_taghi(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 env->CP0_TagHi =3D arg1; /* XXX */
 > +}
 > +
 > +void helper_mtc0_datahi(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 env->CP0_DataHi =3D arg1; /* XXX */
 > +}
 > +
 > +/* MIPS MT functions */
 > +target_ulong helper_mftgpr(CPUMIPSState *env, uint32_t sel)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->active_tc.gp=
r[sel];
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->tcs[other_tc=
].gpr[sel];
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +target_ulong helper_mftlo(CPUMIPSState *env, uint32_t sel)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->active_tc.LO=
[sel];
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->tcs[other_tc=
].LO[sel];
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +target_ulong helper_mfthi(CPUMIPSState *env, uint32_t sel)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->active_tc.HI=
[sel];
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->tcs[other_tc=
].HI[sel];
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +target_ulong helper_mftacx(CPUMIPSState *env, uint32_t sel)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->active_tc.AC=
X[sel];
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->tcs[other_tc=
].ACX[sel];
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +target_ulong helper_mftdsp(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->active_tc.DS=
PControl;
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->tcs[other_tc=
].DSPControl;
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +void helper_mttgpr(CPUMIPSState *env, target_ulong arg1, uint32_t sel=
)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->active_tc.gpr[sel] =
=3D arg1;
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->tcs[other_tc].gpr[s=
el] =3D arg1;
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +void helper_mttlo(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->active_tc.LO[sel] =3D=
 arg1;
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->tcs[other_tc].LO[se=
l] =3D arg1;
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +void helper_mtthi(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->active_tc.HI[sel] =3D=
 arg1;
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->tcs[other_tc].HI[se=
l] =3D arg1;
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +void helper_mttacx(CPUMIPSState *env, target_ulong arg1, uint32_t sel=
)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->active_tc.ACX[sel] =
=3D arg1;
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->tcs[other_tc].ACX[s=
el] =3D arg1;
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +void helper_mttdsp(CPUMIPSState *env, target_ulong arg1)
 > +{
 > +=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > +=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > +
 > +=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->active_tc.DSPContro=
l =3D arg1;
 > +=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->tcs[other_tc].DSPCo=
ntrol =3D arg1;
 > +=C2=A0=C2=A0=C2=A0 }
 > +}
 > +
 > +/* MIPS MT functions */
 > +target_ulong helper_dmt(void)
 > +{
 > +=C2=A0=C2=A0=C2=A0 /* TODO */
 > +=C2=A0=C2=A0=C2=A0 return 0;
 > +}
 > +
 > +target_ulong helper_emt(void)
 > +{
 > +=C2=A0=C2=A0=C2=A0 /* TODO */
 > +=C2=A0=C2=A0=C2=A0 return 0;
 > +}
 > +
 > +target_ulong helper_dvpe(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 CPUState *other_cs =3D first_cpu;
 > +=C2=A0=C2=A0=C2=A0 target_ulong prev =3D env->mvp->CP0_MVPControl;
 > +
 > +=C2=A0=C2=A0=C2=A0 CPU_FOREACH(other_cs) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MIPSCPU *other_cpu =3D MIP=
S_CPU(other_cs);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Turn off all VPEs excep=
t the one executing the dvpe.=C2=A0 */
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (&other_cpu->env !=3D e=
nv) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ot=
her_cpu->env.mvp->CP0_MVPControl &=3D ~(1 << CP0MVPCo_EVP);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mi=
ps_vpe_sleep(other_cpu);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 return prev;
 > +}
 > +
 > +target_ulong helper_evpe(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 CPUState *other_cs =3D first_cpu;
 > +=C2=A0=C2=A0=C2=A0 target_ulong prev =3D env->mvp->CP0_MVPControl;
 > +
 > +=C2=A0=C2=A0=C2=A0 CPU_FOREACH(other_cs) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MIPSCPU *other_cpu =3D MIP=
S_CPU(other_cs);
 > +
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (&other_cpu->env !=3D e=
nv
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 If the VPE is WFI, don't disturb its sleep.=C2=A0 */
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &&=
 !mips_vpe_is_wfi(other_cpu)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 Enable the VPE.=C2=A0 */
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ot=
her_cpu->env.mvp->CP0_MVPControl |=3D (1 << CP0MVPCo_EVP);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mi=
ps_vpe_wake(other_cpu); /* And wake it up.=C2=A0 */
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 return prev;
 > +}
 > +#endif /* !CONFIG_USER_ONLY */
 > +
 > +/* R6 Multi-threading */
 > +#ifndef CONFIG_USER_ONLY
 > +target_ulong helper_dvp(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 CPUState *other_cs =3D first_cpu;
 > +=C2=A0=C2=A0=C2=A0 target_ulong prev =3D env->CP0_VPControl;
 > +
 > +=C2=A0=C2=A0=C2=A0 if (!((env->CP0_VPControl >> CP0VPCtl_DIS) & 1)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPU_FOREACH(other_cs) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MI=
PSCPU *other_cpu =3D MIPS_CPU(other_cs);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 Turn off all VPs except the one executing the dvp. */
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (&other_cpu->env !=3D env) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mips_vpe_sleep(other_cpu);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_VPControl |=3D (1=
 << CP0VPCtl_DIS);
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 return prev;
 > +}
 > +
 > +target_ulong helper_evp(CPUMIPSState *env)
 > +{
 > +=C2=A0=C2=A0=C2=A0 CPUState *other_cs =3D first_cpu;
 > +=C2=A0=C2=A0=C2=A0 target_ulong prev =3D env->CP0_VPControl;
 > +
 > +=C2=A0=C2=A0=C2=A0 if ((env->CP0_VPControl >> CP0VPCtl_DIS) & 1) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPU_FOREACH(other_cs) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MI=
PSCPU *other_cpu =3D MIPS_CPU(other_cs);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 ((&other_cpu->env !=3D env) &&=20
!mips_vp_is_wfi(other_cpu)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /*
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If the VP is WFI, don't disturb its sleep.
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Otherwise, wake it up.
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mips_vpe_wake(other_cpu);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_VPControl &=3D ~(=
1 << CP0VPCtl_DIS);
 > +=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 return prev;
 > +}
 > +#endif /* !CONFIG_USER_ONLY */
 > diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
 > index 15d05a5..eeb6fa1 100644
 > --- a/target/mips/op_helper.c
 > +++ b/target/mips/op_helper.c
 > @@ -15,7 +15,9 @@
 >=C2=A0=C2=A0 *
 >=C2=A0=C2=A0 * You should have received a copy of the GNU Lesser Genera=
l Public
 >=C2=A0=C2=A0 * License along with this library; if not, see=20
<http://www.gnu.org/licenses/>.
 > + *
 >=C2=A0=C2=A0 */
 > +
 >=C2=A0 #include "qemu/osdep.h"
 >=C2=A0 #include "qemu/main-loop.h"
 >=C2=A0 #include "cpu.h"
 > @@ -28,6 +30,7 @@
 >=C2=A0 #include "sysemu/kvm.h"
 >=C2=A0 #include "fpu/softfloat.h"
 >
 > +
 >=20
/************************************************************************=
*****/
 >=C2=A0 /* Exceptions processing helpers */
 >
 > @@ -560,1689 +563,45 @@ void helper_sdm(CPUMIPSState *env,=20
target_ulong addr, target_ulong reglist,
 >=C2=A0 }
 >=C2=A0 #endif
 >
 > -#ifndef CONFIG_USER_ONLY
 > -/* SMP helpers.=C2=A0 */
 > -static bool mips_vpe_is_wfi(MIPSCPU *c)
 > -{
 > -=C2=A0=C2=A0=C2=A0 CPUState *cpu =3D CPU(c);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *env =3D &c->env;
 > -
 > -=C2=A0=C2=A0=C2=A0 /*
 > -=C2=A0=C2=A0=C2=A0=C2=A0 * If the VPE is halted but otherwise active,=
 it means it's=20
waiting for
 > -=C2=A0=C2=A0=C2=A0=C2=A0 * an interrupt.\
 > -=C2=A0=C2=A0=C2=A0=C2=A0 */
 > -=C2=A0=C2=A0=C2=A0 return cpu->halted && mips_vpe_active(env);
 > -}
 > -
 > -static bool mips_vp_is_wfi(MIPSCPU *c)
 > -{
 > -=C2=A0=C2=A0=C2=A0 CPUState *cpu =3D CPU(c);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *env =3D &c->env;
 > -
 > -=C2=A0=C2=A0=C2=A0 return cpu->halted && mips_vp_active(env);
 > -}
 > -
 > -static inline void mips_vpe_wake(MIPSCPU *c)
 > -{
 > -=C2=A0=C2=A0=C2=A0 /*
 > -=C2=A0=C2=A0=C2=A0=C2=A0 * Don't set ->halted =3D 0 directly, let it =
be done via cpu_has_work
 > -=C2=A0=C2=A0=C2=A0=C2=A0 * because there might be other conditions th=
at state that c should
 > -=C2=A0=C2=A0=C2=A0=C2=A0 * be sleeping.
 > -=C2=A0=C2=A0=C2=A0=C2=A0 */
 > -=C2=A0=C2=A0=C2=A0 qemu_mutex_lock_iothread();
 > -=C2=A0=C2=A0=C2=A0 cpu_interrupt(CPU(c), CPU_INTERRUPT_WAKE);
 > -=C2=A0=C2=A0=C2=A0 qemu_mutex_unlock_iothread();
 > -}
 >
 > -static inline void mips_vpe_sleep(MIPSCPU *cpu)
 > +void helper_fork(target_ulong arg1, target_ulong arg2)
 >=C2=A0 {
 > -=C2=A0=C2=A0=C2=A0 CPUState *cs =3D CPU(cpu);
 > -
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
 > -=C2=A0=C2=A0=C2=A0=C2=A0 * The VPE was shut off, really go to bed.
 > -=C2=A0=C2=A0=C2=A0=C2=A0 * Reset any old _WAKE requests.
 > +=C2=A0=C2=A0=C2=A0=C2=A0 * arg1 =3D rt, arg2 =3D rs
 > +=C2=A0=C2=A0=C2=A0=C2=A0 * TODO: store to TC register
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
 > -=C2=A0=C2=A0=C2=A0 cs->halted =3D 1;
 > -=C2=A0=C2=A0=C2=A0 cpu_reset_interrupt(cs, CPU_INTERRUPT_WAKE);
 > -}
 > -
 > -static inline void mips_tc_wake(MIPSCPU *cpu, int tc)
 > -{
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *c =3D &cpu->env;
 > -
 > -=C2=A0=C2=A0=C2=A0 /* FIXME: TC reschedule.=C2=A0 */
 > -=C2=A0=C2=A0=C2=A0 if (mips_vpe_active(c) && !mips_vpe_is_wfi(cpu)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mips_vpe_wake(cpu);
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -static inline void mips_tc_sleep(MIPSCPU *cpu, int tc)
 > -{
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *c =3D &cpu->env;
 > -
 > -=C2=A0=C2=A0=C2=A0 /* FIXME: TC reschedule.=C2=A0 */
 > -=C2=A0=C2=A0=C2=A0 if (!mips_vpe_active(c)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mips_vpe_sleep(cpu);
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -/**
 > - * mips_cpu_map_tc:
 > - * @env: CPU from which mapping is performed.
 > - * @tc: Should point to an int with the value of the global TC index.
 > - *
 > - * This function will transform @tc into a local index within the
 > - * returned #CPUMIPSState.
 > - */
 > -
 > -/*
 > - * FIXME: This code assumes that all VPEs have the same number of TCs=
,
 > - *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 which depends on runtime=
 setup. Can probably be fixed by
 > - *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 walking the list of CPUM=
IPSStates.
 > - */
 > -static CPUMIPSState *mips_cpu_map_tc(CPUMIPSState *env, int *tc)
 > -{
 > -=C2=A0=C2=A0=C2=A0 MIPSCPU *cpu;
 > -=C2=A0=C2=A0=C2=A0 CPUState *cs;
 > -=C2=A0=C2=A0=C2=A0 CPUState *other_cs;
 > -=C2=A0=C2=A0=C2=A0 int vpe_idx;
 > -=C2=A0=C2=A0=C2=A0 int tc_idx =3D *tc;
 > -
 > -=C2=A0=C2=A0=C2=A0 if (!(env->CP0_VPEConf0 & (1 << CP0VPEC0_MVP))) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Not allowed to address =
other CPUs.=C2=A0 */
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *tc =3D env->current_tc;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return env;
 > -=C2=A0=C2=A0=C2=A0 }
 > -
 > -=C2=A0=C2=A0=C2=A0 cs =3D env_cpu(env);
 > -=C2=A0=C2=A0=C2=A0 vpe_idx =3D tc_idx / cs->nr_threads;
 > -=C2=A0=C2=A0=C2=A0 *tc =3D tc_idx % cs->nr_threads;
 > -=C2=A0=C2=A0=C2=A0 other_cs =3D qemu_get_cpu(vpe_idx);
 > -=C2=A0=C2=A0=C2=A0 if (other_cs =3D=3D NULL) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return env;
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 cpu =3D MIPS_CPU(other_cs);
 > -=C2=A0=C2=A0=C2=A0 return &cpu->env;
 > -}
 > -
 > -/*
 > - * The per VPE CP0_Status register shares some fields with the per TC
 > - * CP0_TCStatus registers. These fields are wired to the same registe=
rs,
 > - * so changes to either of them should be reflected on both registers=
.
 > - *
 > - * Also, EntryHi shares the bottom 8 bit ASID with TCStauts.
 > - *
 > - * These helper call synchronizes the regs for a given cpu.
 > - */
 > -
 > -/*
 > - * Called for updates to CP0_Status.=C2=A0 Defined in "cpu.h" for gdb=
stub.c.
 > - * static inline void sync_c0_status(CPUMIPSState *env, CPUMIPSState=20
*cpu,
 > - *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int tc);
 > - */
 > -
 > -/* Called for updates to CP0_TCStatus.=C2=A0 */
 > -static void sync_c0_tcstatus(CPUMIPSState *cpu, int tc,
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 target_ulong v)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t status;
 > -=C2=A0=C2=A0=C2=A0 uint32_t tcu, tmx, tasid, tksu;
 > -=C2=A0=C2=A0=C2=A0 uint32_t mask =3D ((1U << CP0St_CU3)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | (1 << C=
P0St_CU2)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | (1 << C=
P0St_CU1)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | (1 << C=
P0St_CU0)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | (1 << C=
P0St_MX)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | (3 << C=
P0St_KSU));
 > -
 > -=C2=A0=C2=A0=C2=A0 tcu =3D (v >> CP0TCSt_TCU0) & 0xf;
 > -=C2=A0=C2=A0=C2=A0 tmx =3D (v >> CP0TCSt_TMX) & 0x1;
 > -=C2=A0=C2=A0=C2=A0 tasid =3D v & cpu->CP0_EntryHi_ASID_mask;
 > -=C2=A0=C2=A0=C2=A0 tksu =3D (v >> CP0TCSt_TKSU) & 0x3;
 > -
 > -=C2=A0=C2=A0=C2=A0 status =3D tcu << CP0St_CU0;
 > -=C2=A0=C2=A0=C2=A0 status |=3D tmx << CP0St_MX;
 > -=C2=A0=C2=A0=C2=A0 status |=3D tksu << CP0St_KSU;
 > -
 > -=C2=A0=C2=A0=C2=A0 cpu->CP0_Status &=3D ~mask;
 > -=C2=A0=C2=A0=C2=A0 cpu->CP0_Status |=3D status;
 > -
 > -=C2=A0=C2=A0=C2=A0 /* Sync the TASID with EntryHi.=C2=A0 */
 > -=C2=A0=C2=A0=C2=A0 cpu->CP0_EntryHi &=3D ~cpu->CP0_EntryHi_ASID_mask;
 > -=C2=A0=C2=A0=C2=A0 cpu->CP0_EntryHi |=3D tasid;
 > -
 > -=C2=A0=C2=A0=C2=A0 compute_hflags(cpu);
 > -}
 > -
 > -/* Called for updates to CP0_EntryHi.=C2=A0 */
 > -static void sync_c0_entryhi(CPUMIPSState *cpu, int tc)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int32_t *tcst;
 > -=C2=A0=C2=A0=C2=A0 uint32_t asid, v =3D cpu->CP0_EntryHi;
 > -
 > -=C2=A0=C2=A0=C2=A0 asid =3D v & cpu->CP0_EntryHi_ASID_mask;
 > -
 > -=C2=A0=C2=A0=C2=A0 if (tc =3D=3D cpu->current_tc) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcst =3D &cpu->active_tc.C=
P0_TCStatus;
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcst =3D &cpu->tcs[tc].CP0=
_TCStatus;
 > -=C2=A0=C2=A0=C2=A0 }
 > -
 > -=C2=A0=C2=A0=C2=A0 *tcst &=3D ~cpu->CP0_EntryHi_ASID_mask;
 > -=C2=A0=C2=A0=C2=A0 *tcst |=3D asid;
 > -}
 > -
 > -/* CP0 helpers */
 > -target_ulong helper_mfc0_mvpcontrol(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 return env->mvp->CP0_MVPControl;
 > -}
 > -
 > -target_ulong helper_mfc0_mvpconf0(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 return env->mvp->CP0_MVPConf0;
 > -}
 > -
 > -target_ulong helper_mfc0_mvpconf1(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 return env->mvp->CP0_MVPConf1;
 > -}
 > -
 > -target_ulong helper_mfc0_random(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 return (int32_t)cpu_mips_get_random(env);
 > -}
 > -
 > -target_ulong helper_mfc0_tcstatus(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 return env->active_tc.CP0_TCStatus;
 > -}
 > -
 > -target_ulong helper_mftc0_tcstatus(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->active_tc.CP=
0_TCStatus;
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->tcs[other_tc=
].CP0_TCStatus;
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -target_ulong helper_mfc0_tcbind(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 return env->active_tc.CP0_TCBind;
 > -}
 > -
 > -target_ulong helper_mftc0_tcbind(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->active_tc.CP=
0_TCBind;
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->tcs[other_tc=
].CP0_TCBind;
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -target_ulong helper_mfc0_tcrestart(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 return env->active_tc.PC;
 > -}
 > -
 > -target_ulong helper_mftc0_tcrestart(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->active_tc.PC=
;
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->tcs[other_tc=
].PC;
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -target_ulong helper_mfc0_tchalt(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 return env->active_tc.CP0_TCHalt;
 > -}
 > -
 > -target_ulong helper_mftc0_tchalt(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->active_tc.CP=
0_TCHalt;
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->tcs[other_tc=
].CP0_TCHalt;
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -target_ulong helper_mfc0_tccontext(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 return env->active_tc.CP0_TCContext;
 > -}
 > -
 > -target_ulong helper_mftc0_tccontext(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->active_tc.CP=
0_TCContext;
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->tcs[other_tc=
].CP0_TCContext;
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -target_ulong helper_mfc0_tcschedule(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 return env->active_tc.CP0_TCSchedule;
 >=C2=A0 }
 >
 > -target_ulong helper_mftc0_tcschedule(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->active_tc.CP=
0_TCSchedule;
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->tcs[other_tc=
].CP0_TCSchedule;
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -target_ulong helper_mfc0_tcschefback(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 return env->active_tc.CP0_TCScheFBack;
 > -}
 > -
 > -target_ulong helper_mftc0_tcschefback(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->active_tc.CP=
0_TCScheFBack;
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->tcs[other_tc=
].CP0_TCScheFBack;
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -target_ulong helper_mfc0_count(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 return (int32_t)cpu_mips_get_count(env);
 > -}
 > -
 > -target_ulong helper_mfc0_saar(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 if ((env->CP0_SAARI & 0x3f) < 2) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (int32_t) env->CP0_=
SAAR[env->CP0_SAARI & 0x3f];
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 return 0;
 > -}
 > -
 > -target_ulong helper_mfhc0_saar(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 if ((env->CP0_SAARI & 0x3f) < 2) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return env->CP0_SAAR[env->=
CP0_SAARI & 0x3f] >> 32;
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 return 0;
 > -}
 > -
 > -target_ulong helper_mftc0_entryhi(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 return other->CP0_EntryHi;
 > -}
 > -
 > -target_ulong helper_mftc0_cause(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 int32_t tccause;
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tccause =3D other->CP0_Cau=
se;
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tccause =3D other->CP0_Cau=
se;
 > -=C2=A0=C2=A0=C2=A0 }
 > -
 > -=C2=A0=C2=A0=C2=A0 return tccause;
 > -}
 > -
 > -target_ulong helper_mftc0_status(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 return other->CP0_Status;
 > -}
 > -
 > -target_ulong helper_mfc0_lladdr(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 return (int32_t)(env->CP0_LLAddr >> env->CP0_LLAdd=
r_shift);
 > -}
 > -
 > -target_ulong helper_mfc0_maar(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 return (int32_t) env->CP0_MAAR[env->CP0_MAARI];
 > -}
 > -
 > -target_ulong helper_mfhc0_maar(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 return env->CP0_MAAR[env->CP0_MAARI] >> 32;
 > -}
 > -
 > -target_ulong helper_mfc0_watchlo(CPUMIPSState *env, uint32_t sel)
 > -{
 > -=C2=A0=C2=A0=C2=A0 return (int32_t)env->CP0_WatchLo[sel];
 > -}
 > -
 > -target_ulong helper_mfc0_watchhi(CPUMIPSState *env, uint32_t sel)
 > -{
 > -=C2=A0=C2=A0=C2=A0 return (int32_t) env->CP0_WatchHi[sel];
 > -}
 > -
 > -target_ulong helper_mfhc0_watchhi(CPUMIPSState *env, uint32_t sel)
 > -{
 > -=C2=A0=C2=A0=C2=A0 return env->CP0_WatchHi[sel] >> 32;
 > -}
 > -
 > -target_ulong helper_mfc0_debug(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 target_ulong t0 =3D env->CP0_Debug;
 > -=C2=A0=C2=A0=C2=A0 if (env->hflags & MIPS_HFLAG_DM) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t0 |=3D 1 << CP0DB_DM;
 > -=C2=A0=C2=A0=C2=A0 }
 > -
 > -=C2=A0=C2=A0=C2=A0 return t0;
 > -}
 > -
 > -target_ulong helper_mftc0_debug(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 int32_t tcstatus;
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcstatus =3D other->active=
_tc.CP0_Debug_tcstatus;
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcstatus =3D other->tcs[ot=
her_tc].CP0_Debug_tcstatus;
 > -=C2=A0=C2=A0=C2=A0 }
 > -
 > -=C2=A0=C2=A0=C2=A0 /* XXX: Might be wrong, check with EJTAG spec. */
 > -=C2=A0=C2=A0=C2=A0 return (other->CP0_Debug & ~((1 << CP0DB_SSt) | (1=
 <<=20
CP0DB_Halt))) |
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (t=
cstatus & ((1 << CP0DB_SSt) | (1 << CP0DB_Halt)));
 > -}
 > -
 > -#if defined(TARGET_MIPS64)
 > -target_ulong helper_dmfc0_tcrestart(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 return env->active_tc.PC;
 > -}
 > -
 > -target_ulong helper_dmfc0_tchalt(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 return env->active_tc.CP0_TCHalt;
 > -}
 > -
 > -target_ulong helper_dmfc0_tccontext(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 return env->active_tc.CP0_TCContext;
 > -}
 > -
 > -target_ulong helper_dmfc0_tcschedule(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 return env->active_tc.CP0_TCSchedule;
 > -}
 > -
 > -target_ulong helper_dmfc0_tcschefback(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 return env->active_tc.CP0_TCScheFBack;
 > -}
 > -
 > -target_ulong helper_dmfc0_lladdr(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 return env->CP0_LLAddr >> env->CP0_LLAddr_shift;
 > -}
 > -
 > -target_ulong helper_dmfc0_maar(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 return env->CP0_MAAR[env->CP0_MAARI];
 > -}
 > -
 > -target_ulong helper_dmfc0_watchlo(CPUMIPSState *env, uint32_t sel)
 > -{
 > -=C2=A0=C2=A0=C2=A0 return env->CP0_WatchLo[sel];
 > -}
 > -
 > -target_ulong helper_dmfc0_watchhi(CPUMIPSState *env, uint32_t sel)
 > +target_ulong helper_yield(CPUMIPSState *env, target_ulong arg)
 >=C2=A0 {
 > -=C2=A0=C2=A0=C2=A0 return env->CP0_WatchHi[sel];
 > -}
 > +=C2=A0=C2=A0=C2=A0 target_long arg1 =3D arg;
 >
 > -target_ulong helper_dmfc0_saar(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 if ((env->CP0_SAARI & 0x3f) < 2) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return env->CP0_SAAR[env->=
CP0_SAARI & 0x3f];
 > +=C2=A0=C2=A0=C2=A0 if (arg1 < 0) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* No scheduling policy im=
plemented. */
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (arg1 !=3D -2) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (env->CP0_VPEControl & (1 << CP0VPECo_YSI) &&
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 env->active_tc.CP0_TCStatus & (1 << CP0TCSt_DT)) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 env->CP0_VPEControl &=3D ~(0x7 << CP0VPECo_EXCPT);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 env->CP0_VPEControl |=3D 4 << CP0VPECo_EXCPT;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 do_raise_exception(env, EXCP_THREAD, GETPC());
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 } else if (arg1 =3D=3D 0) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (0) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 TODO: TC underflow */
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 en=
v->CP0_VPEControl &=3D ~(0x7 << CP0VPECo_EXCPT);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do=
_raise_exception(env, EXCP_THREAD, GETPC());
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 TODO: Deallocate TC */
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > +=C2=A0=C2=A0=C2=A0 } else if (arg1 > 0) {
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Yield qualifier inputs =
not implemented. */
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_VPEControl &=3D ~=
(0x7 << CP0VPECo_EXCPT);
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_VPEControl |=3D 2=
 << CP0VPECo_EXCPT;
 > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do_raise_exception(env, EX=
CP_THREAD, GETPC());
 >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 return 0;
 > +=C2=A0=C2=A0=C2=A0 return env->CP0_YQMask;
 >=C2=A0 }
 > -#endif /* TARGET_MIPS64 */
 > -
 > -void helper_mtc0_index(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t index_p =3D env->CP0_Index & 0x80000000;
 > -=C2=A0=C2=A0=C2=A0 uint32_t tlb_index =3D arg1 & 0x7fffffff;
 > -=C2=A0=C2=A0=C2=A0 if (tlb_index < env->tlb->nb_tlb) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (env->insn_flags & ISA_=
MIPS32R6) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in=
dex_p |=3D arg1 & 0x80000000;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_Index =3D index_p=
 | tlb_index;
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -void helper_mtc0_mvpcontrol(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t mask =3D 0;
 > -=C2=A0=C2=A0=C2=A0 uint32_t newval;
 > -
 > -=C2=A0=C2=A0=C2=A0 if (env->CP0_VPEConf0 & (1 << CP0VPEC0_MVP)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D (1 << CP0MVPCo_C=
PA) | (1 << CP0MVPCo_VPC) |
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (1 << CP0MVPCo_EVP);
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 if (env->mvp->CP0_MVPControl & (1 << CP0MVPCo_VPC)=
) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D (1 << CP0MVPCo_S=
TLB);
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 newval =3D (env->mvp->CP0_MVPControl & ~mask) | (a=
rg1 & mask);
 > -
 > -=C2=A0=C2=A0=C2=A0 /* TODO: Enable/disable shared TLB, enable/disable=
 VPEs. */
 > -
 > -=C2=A0=C2=A0=C2=A0 env->mvp->CP0_MVPControl =3D newval;
 > -}
 > -
 > -void helper_mtc0_vpecontrol(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t mask;
 > -=C2=A0=C2=A0=C2=A0 uint32_t newval;
 > -
 > -=C2=A0=C2=A0=C2=A0 mask =3D (1 << CP0VPECo_YSI) | (1 << CP0VPECo_GSI)=
 |
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << CP=
0VPECo_TE) | (0xff << CP0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 newval =3D (env->CP0_VPEControl & ~mask) | (arg1 &=
 mask);
 > -
 > -=C2=A0=C2=A0=C2=A0 /*
 > -=C2=A0=C2=A0=C2=A0=C2=A0 * Yield scheduler intercept not implemented.
 > -=C2=A0=C2=A0=C2=A0=C2=A0 * Gating storage scheduler intercept not imp=
lemented.
 > -=C2=A0=C2=A0=C2=A0=C2=A0 */
 > -
 > -=C2=A0=C2=A0=C2=A0 /* TODO: Enable/disable TCs. */
 > -
 > -=C2=A0=C2=A0=C2=A0 env->CP0_VPEControl =3D newval;
 > -}
 > -
 > -void helper_mttc0_vpecontrol(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -=C2=A0=C2=A0=C2=A0 uint32_t mask;
 > -=C2=A0=C2=A0=C2=A0 uint32_t newval;
 > -
 > -=C2=A0=C2=A0=C2=A0 mask =3D (1 << CP0VPECo_YSI) | (1 << CP0VPECo_GSI)=
 |
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << CP=
0VPECo_TE) | (0xff << CP0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 newval =3D (other->CP0_VPEControl & ~mask) | (arg1=
 & mask);
 > -
 > -=C2=A0=C2=A0=C2=A0 /* TODO: Enable/disable TCs.=C2=A0 */
 > -
 > -=C2=A0=C2=A0=C2=A0 other->CP0_VPEControl =3D newval;
 > -}
 > -
 > -target_ulong helper_mftc0_vpecontrol(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -=C2=A0=C2=A0=C2=A0 /* FIXME: Mask away return zero on read bits.=C2=A0=
 */
 > -=C2=A0=C2=A0=C2=A0 return other->CP0_VPEControl;
 > -}
 > -
 > -target_ulong helper_mftc0_vpeconf0(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 return other->CP0_VPEConf0;
 > -}
 > -
 > -void helper_mtc0_vpeconf0(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t mask =3D 0;
 > -=C2=A0=C2=A0=C2=A0 uint32_t newval;
 > -
 > -=C2=A0=C2=A0=C2=A0 if (env->CP0_VPEConf0 & (1 << CP0VPEC0_MVP)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (env->CP0_VPEConf0 & (1=
 << CP0VPEC0_VPA)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ma=
sk |=3D (0xff << CP0VPEC0_XTC);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D (1 << CP0VPEC0_M=
VP) | (1 << CP0VPEC0_VPA);
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 newval =3D (env->CP0_VPEConf0 & ~mask) | (arg1 & m=
ask);
 > -
 > -=C2=A0=C2=A0=C2=A0 /* TODO: TC exclusive handling due to ERL/EXL. */
 > -
 > -=C2=A0=C2=A0=C2=A0 env->CP0_VPEConf0 =3D newval;
 > -}
 > -
 > -void helper_mttc0_vpeconf0(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -=C2=A0=C2=A0=C2=A0 uint32_t mask =3D 0;
 > -=C2=A0=C2=A0=C2=A0 uint32_t newval;
 > -
 > -=C2=A0=C2=A0=C2=A0 mask |=3D (1 << CP0VPEC0_MVP) | (1 << CP0VPEC0_VPA=
);
 > -=C2=A0=C2=A0=C2=A0 newval =3D (other->CP0_VPEConf0 & ~mask) | (arg1 &=
 mask);
 > -
 > -=C2=A0=C2=A0=C2=A0 /* TODO: TC exclusive handling due to ERL/EXL.=C2=A0=
 */
 > -=C2=A0=C2=A0=C2=A0 other->CP0_VPEConf0 =3D newval;
 > -}
 > -
 > -void helper_mtc0_vpeconf1(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t mask =3D 0;
 > -=C2=A0=C2=A0=C2=A0 uint32_t newval;
 > -
 > -=C2=A0=C2=A0=C2=A0 if (env->mvp->CP0_MVPControl & (1 << CP0MVPCo_VPC)=
)
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D (0xff << CP0VPEC=
1_NCX) | (0xff << CP0VPEC1_NCP2) |
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (0xff << CP0VPEC1_NCP1);
 > -=C2=A0=C2=A0=C2=A0 newval =3D (env->CP0_VPEConf1 & ~mask) | (arg1 & m=
ask);
 > -
 > -=C2=A0=C2=A0=C2=A0 /* UDI not implemented. */
 > -=C2=A0=C2=A0=C2=A0 /* CP2 not implemented. */
 > -
 > -=C2=A0=C2=A0=C2=A0 /* TODO: Handle FPU (CP1) binding. */
 > -
 > -=C2=A0=C2=A0=C2=A0 env->CP0_VPEConf1 =3D newval;
 > -}
 > -
 > -void helper_mtc0_yqmask(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 /* Yield qualifier inputs not implemented. */
 > -=C2=A0=C2=A0=C2=A0 env->CP0_YQMask =3D 0x00000000;
 > -}
 > -
 > -void helper_mtc0_vpeopt(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 env->CP0_VPEOpt =3D arg1 & 0x0000ffff;
 > -}
 > -
 > -#define MTC0_ENTRYLO_MASK(env) ((env->PAMask >> 6) & 0x3FFFFFFF)
 > -
 > -void helper_mtc0_entrylo0(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 /* 1k pages not implemented */
 > -=C2=A0=C2=A0=C2=A0 target_ulong rxi =3D arg1 & (env->CP0_PageGrain & =
(3u << CP0PG_XIE));
 > -=C2=A0=C2=A0=C2=A0 env->CP0_EntryLo0 =3D (arg1 & MTC0_ENTRYLO_MASK(en=
v))
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | (=
rxi << (CP0EnLo_XI - 30));
 > -}
 > -
 > -#if defined(TARGET_MIPS64)
 > -#define DMTC0_ENTRYLO_MASK(env) (env->PAMask >> 6)
 > -
 > -void helper_dmtc0_entrylo0(CPUMIPSState *env, uint64_t arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint64_t rxi =3D arg1 & ((env->CP0_PageGrain & (3u=
ll <<=20
CP0PG_XIE)) << 32);
 > -=C2=A0=C2=A0=C2=A0 env->CP0_EntryLo0 =3D (arg1 & DMTC0_ENTRYLO_MASK(e=
nv)) | rxi;
 > -}
 > -#endif
 > -
 > -void helper_mtc0_tcstatus(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t mask =3D env->CP0_TCStatus_rw_bitmask;
 > -=C2=A0=C2=A0=C2=A0 uint32_t newval;
 > -
 > -=C2=A0=C2=A0=C2=A0 newval =3D (env->active_tc.CP0_TCStatus & ~mask) |=
 (arg1 & mask);
 > -
 > -=C2=A0=C2=A0=C2=A0 env->active_tc.CP0_TCStatus =3D newval;
 > -=C2=A0=C2=A0=C2=A0 sync_c0_tcstatus(env, env->current_tc, newval);
 > -}
 > -
 > -void helper_mttc0_tcstatus(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->active_tc.CP0_TCSta=
tus =3D arg1;
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->tcs[other_tc].CP0_T=
CStatus =3D arg1;
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 sync_c0_tcstatus(other, other_tc, arg1);
 > -}
 > -
 > -void helper_mtc0_tcbind(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t mask =3D (1 << CP0TCBd_TBE);
 > -=C2=A0=C2=A0=C2=A0 uint32_t newval;
 > -
 > -=C2=A0=C2=A0=C2=A0 if (env->mvp->CP0_MVPControl & (1 << CP0MVPCo_VPC)=
) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D (1 << CP0TCBd_Cu=
rVPE);
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 newval =3D (env->active_tc.CP0_TCBind & ~mask) | (=
arg1 & mask);
 > -=C2=A0=C2=A0=C2=A0 env->active_tc.CP0_TCBind =3D newval;
 > -}
 > -
 > -void helper_mttc0_tcbind(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 uint32_t mask =3D (1 << CP0TCBd_TBE);
 > -=C2=A0=C2=A0=C2=A0 uint32_t newval;
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 if (other->mvp->CP0_MVPControl & (1 << CP0MVPCo_VP=
C)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D (1 << CP0TCBd_Cu=
rVPE);
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 newval =3D (other->active_=
tc.CP0_TCBind & ~mask) | (arg1 & mask);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->active_tc.CP0_TCBin=
d =3D newval;
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 newval =3D (other->tcs[oth=
er_tc].CP0_TCBind & ~mask) | (arg1 &=20
mask);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->tcs[other_tc].CP0_T=
CBind =3D newval;
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -void helper_mtc0_tcrestart(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 env->active_tc.PC =3D arg1;
 > -=C2=A0=C2=A0=C2=A0 env->active_tc.CP0_TCStatus &=3D ~(1 << CP0TCSt_TD=
S);
 > -=C2=A0=C2=A0=C2=A0 env->CP0_LLAddr =3D 0;
 > -=C2=A0=C2=A0=C2=A0 env->lladdr =3D 0;
 > -=C2=A0=C2=A0=C2=A0 /* MIPS16 not implemented. */
 > -}
 > -
 > -void helper_mttc0_tcrestart(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->active_tc.PC =3D ar=
g1;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->active_tc.CP0_TCSta=
tus &=3D ~(1 << CP0TCSt_TDS);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->CP0_LLAddr =3D 0;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->lladdr =3D 0;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* MIPS16 not implemented.=
 */
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->tcs[other_tc].PC =3D=
 arg1;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->tcs[other_tc].CP0_T=
CStatus &=3D ~(1 << CP0TCSt_TDS);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->CP0_LLAddr =3D 0;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->lladdr =3D 0;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* MIPS16 not implemented.=
 */
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -void helper_mtc0_tchalt(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 MIPSCPU *cpu =3D env_archcpu(env);
 > -
 > -=C2=A0=C2=A0=C2=A0 env->active_tc.CP0_TCHalt =3D arg1 & 0x1;
 > -
 > -=C2=A0=C2=A0=C2=A0 /* TODO: Halt TC / Restart (if allocated+active) T=
C. */
 > -=C2=A0=C2=A0=C2=A0 if (env->active_tc.CP0_TCHalt & 1) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mips_tc_sleep(cpu, env->cu=
rrent_tc);
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mips_tc_wake(cpu, env->cur=
rent_tc);
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -void helper_mttc0_tchalt(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -=C2=A0=C2=A0=C2=A0 MIPSCPU *other_cpu =3D env_archcpu(other);
 > -
 > -=C2=A0=C2=A0=C2=A0 /* TODO: Halt TC / Restart (if allocated+active) T=
C. */
 > -
 > -=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->active_tc.CP0_TCHal=
t =3D arg1;
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->tcs[other_tc].CP0_T=
CHalt =3D arg1;
 > -=C2=A0=C2=A0=C2=A0 }
 > -
 > -=C2=A0=C2=A0=C2=A0 if (arg1 & 1) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mips_tc_sleep(other_cpu, o=
ther_tc);
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mips_tc_wake(other_cpu, ot=
her_tc);
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -void helper_mtc0_tccontext(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 env->active_tc.CP0_TCContext =3D arg1;
 > -}
 > -
 > -void helper_mttc0_tccontext(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->active_tc.CP0_TCCon=
text =3D arg1;
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->tcs[other_tc].CP0_T=
CContext =3D arg1;
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -void helper_mtc0_tcschedule(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 env->active_tc.CP0_TCSchedule =3D arg1;
 > -}
 > -
 > -void helper_mttc0_tcschedule(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->active_tc.CP0_TCSch=
edule =3D arg1;
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->tcs[other_tc].CP0_T=
CSchedule =3D arg1;
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -void helper_mtc0_tcschefback(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 env->active_tc.CP0_TCScheFBack =3D arg1;
 > -}
 > -
 > -void helper_mttc0_tcschefback(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->active_tc.CP0_TCSch=
eFBack =3D arg1;
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->tcs[other_tc].CP0_T=
CScheFBack =3D arg1;
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -void helper_mtc0_entrylo1(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 /* 1k pages not implemented */
 > -=C2=A0=C2=A0=C2=A0 target_ulong rxi =3D arg1 & (env->CP0_PageGrain & =
(3u << CP0PG_XIE));
 > -=C2=A0=C2=A0=C2=A0 env->CP0_EntryLo1 =3D (arg1 & MTC0_ENTRYLO_MASK(en=
v))
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | (=
rxi << (CP0EnLo_XI - 30));
 > -}
 > -
 > -#if defined(TARGET_MIPS64)
 > -void helper_dmtc0_entrylo1(CPUMIPSState *env, uint64_t arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint64_t rxi =3D arg1 & ((env->CP0_PageGrain & (3u=
ll <<=20
CP0PG_XIE)) << 32);
 > -=C2=A0=C2=A0=C2=A0 env->CP0_EntryLo1 =3D (arg1 & DMTC0_ENTRYLO_MASK(e=
nv)) | rxi;
 > -}
 > -#endif
 > -
 > -void helper_mtc0_context(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 env->CP0_Context =3D (env->CP0_Context & 0x007FFFF=
F) | (arg1 &=20
~0x007FFFFF);
 > -}
 > -
 > -void helper_mtc0_memorymapid(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int32_t old;
 > -=C2=A0=C2=A0=C2=A0 old =3D env->CP0_MemoryMapID;
 > -=C2=A0=C2=A0=C2=A0 env->CP0_MemoryMapID =3D (int32_t) arg1;
 > -=C2=A0=C2=A0=C2=A0 /* If the MemoryMapID changes, flush qemu's TLB.=C2=
=A0 */
 > -=C2=A0=C2=A0=C2=A0 if (old !=3D env->CP0_MemoryMapID) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_mips_tlb_flush(env);
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32_t=20
*pagemask)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint64_t mask =3D arg1 >> (TARGET_PAGE_BITS + 1);
 > -=C2=A0=C2=A0=C2=A0 if (!(env->insn_flags & ISA_MIPS32R6) || (arg1 =3D=
=3D ~0) ||
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (mask =3D=3D 0x0000 || mas=
k =3D=3D 0x0003 || mask =3D=3D 0x000F ||
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask =3D=3D 0x003F |=
| mask =3D=3D 0x00FF || mask =3D=3D 0x03FF ||
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask =3D=3D 0x0FFF |=
| mask =3D=3D 0x3FFF || mask =3D=3D 0xFFFF)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_PageMask =3D arg1=
 & (0x1FFFFFFF & (TARGET_PAGE_MASK=20
<< 1));
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -void helper_mtc0_pagemask(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 update_pagemask(env, arg1, &env->CP0_PageMask);
 > -}
 > -
 > -void helper_mtc0_pagegrain(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 /* SmartMIPS not implemented */
 > -=C2=A0=C2=A0=C2=A0 /* 1k pages not implemented */
 > -=C2=A0=C2=A0=C2=A0 env->CP0_PageGrain =3D (arg1 & env->CP0_PageGrain_=
rw_bitmask) |
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 (env->CP0_PageGrain &=20
~env->CP0_PageGrain_rw_bitmask);
 > -=C2=A0=C2=A0=C2=A0 compute_hflags(env);
 > -=C2=A0=C2=A0=C2=A0 restore_pamask(env);
 > -}
 > -
 > -void helper_mtc0_segctl0(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 CPUState *cs =3D env_cpu(env);
 > -
 > -=C2=A0=C2=A0=C2=A0 env->CP0_SegCtl0 =3D arg1 & CP0SC0_MASK;
 > -=C2=A0=C2=A0=C2=A0 tlb_flush(cs);
 > -}
 > -
 > -void helper_mtc0_segctl1(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 CPUState *cs =3D env_cpu(env);
 > -
 > -=C2=A0=C2=A0=C2=A0 env->CP0_SegCtl1 =3D arg1 & CP0SC1_MASK;
 > -=C2=A0=C2=A0=C2=A0 tlb_flush(cs);
 > -}
 > -
 > -void helper_mtc0_segctl2(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 CPUState *cs =3D env_cpu(env);
 > -
 > -=C2=A0=C2=A0=C2=A0 env->CP0_SegCtl2 =3D arg1 & CP0SC2_MASK;
 > -=C2=A0=C2=A0=C2=A0 tlb_flush(cs);
 > -}
 > -
 > -void helper_mtc0_pwfield(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -#if defined(TARGET_MIPS64)
 > -=C2=A0=C2=A0=C2=A0 uint64_t mask =3D 0x3F3FFFFFFFULL;
 > -=C2=A0=C2=A0=C2=A0 uint32_t old_ptei =3D (env->CP0_PWField >> CP0PF_P=
TEI) & 0x3FULL;
 > -=C2=A0=C2=A0=C2=A0 uint32_t new_ptei =3D (arg1 >> CP0PF_PTEI) & 0x3FU=
LL;
 > -
 > -=C2=A0=C2=A0=C2=A0 if ((env->insn_flags & ISA_MIPS32R6)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (((arg1 >> CP0PF_BDI) &=
 0x3FULL) < 12) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ma=
sk &=3D ~(0x3FULL << CP0PF_BDI);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (((arg1 >> CP0PF_GDI) &=
 0x3FULL) < 12) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ma=
sk &=3D ~(0x3FULL << CP0PF_GDI);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (((arg1 >> CP0PF_UDI) &=
 0x3FULL) < 12) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ma=
sk &=3D ~(0x3FULL << CP0PF_UDI);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (((arg1 >> CP0PF_MDI) &=
 0x3FULL) < 12) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ma=
sk &=3D ~(0x3FULL << CP0PF_MDI);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (((arg1 >> CP0PF_PTI) &=
 0x3FULL) < 12) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ma=
sk &=3D ~(0x3FULL << CP0PF_PTI);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 env->CP0_PWField =3D arg1 & mask;
 > -
 > -=C2=A0=C2=A0=C2=A0 if ((new_ptei >=3D 32) ||
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((=
env->insn_flags & ISA_MIPS32R6) &&
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (new_ptei =3D=3D 0 || new_p=
tei =3D=3D 1))) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_PWField =3D (env-=
>CP0_PWField & ~0x3FULL) |
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (old_ptei << CP0PF_PTEI);
 > -=C2=A0=C2=A0=C2=A0 }
 > -#else
 > -=C2=A0=C2=A0=C2=A0 uint32_t mask =3D 0x3FFFFFFF;
 > -=C2=A0=C2=A0=C2=A0 uint32_t old_ptew =3D (env->CP0_PWField >> CP0PF_P=
TEW) & 0x3F;
 > -=C2=A0=C2=A0=C2=A0 uint32_t new_ptew =3D (arg1 >> CP0PF_PTEW) & 0x3F;
 > -
 > -=C2=A0=C2=A0=C2=A0 if ((env->insn_flags & ISA_MIPS32R6)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (((arg1 >> CP0PF_GDW) &=
 0x3F) < 12) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ma=
sk &=3D ~(0x3F << CP0PF_GDW);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (((arg1 >> CP0PF_UDW) &=
 0x3F) < 12) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ma=
sk &=3D ~(0x3F << CP0PF_UDW);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (((arg1 >> CP0PF_MDW) &=
 0x3F) < 12) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ma=
sk &=3D ~(0x3F << CP0PF_MDW);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (((arg1 >> CP0PF_PTW) &=
 0x3F) < 12) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ma=
sk &=3D ~(0x3F << CP0PF_PTW);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 env->CP0_PWField =3D arg1 & mask;
 > -
 > -=C2=A0=C2=A0=C2=A0 if ((new_ptew >=3D 32) ||
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((=
env->insn_flags & ISA_MIPS32R6) &&
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (new_ptew =3D=3D 0 || new_p=
tew =3D=3D 1))) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_PWField =3D (env-=
>CP0_PWField & ~0x3F) |
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (old_ptew << CP0PF_PTEW);
 > -=C2=A0=C2=A0=C2=A0 }
 > -#endif
 > -}
 > -
 > -void helper_mtc0_pwsize(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -#if defined(TARGET_MIPS64)
 > -=C2=A0=C2=A0=C2=A0 env->CP0_PWSize =3D arg1 & 0x3F7FFFFFFFULL;
 > -#else
 > -=C2=A0=C2=A0=C2=A0 env->CP0_PWSize =3D arg1 & 0x3FFFFFFF;
 > -#endif
 > -}
 > -
 > -void helper_mtc0_wired(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 if (env->insn_flags & ISA_MIPS32R6) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (arg1 < env->tlb->nb_tl=
b) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 en=
v->CP0_Wired =3D arg1;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_Wired =3D arg1 % =
env->tlb->nb_tlb;
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -void helper_mtc0_pwctl(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -#if defined(TARGET_MIPS64)
 > -=C2=A0=C2=A0=C2=A0 /* PWEn =3D 0. Hardware page table walking is not =
implemented. */
 > -=C2=A0=C2=A0=C2=A0 env->CP0_PWCtl =3D (env->CP0_PWCtl & 0x000000C0) |=
 (arg1 &=20
0x5C00003F);
 > -#else
 > -=C2=A0=C2=A0=C2=A0 env->CP0_PWCtl =3D (arg1 & 0x800000FF);
 > -#endif
 > -}
 > -
 > -void helper_mtc0_srsconf0(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 env->CP0_SRSConf0 |=3D arg1 & env->CP0_SRSConf0_rw=
_bitmask;
 > -}
 > -
 > -void helper_mtc0_srsconf1(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 env->CP0_SRSConf1 |=3D arg1 & env->CP0_SRSConf1_rw=
_bitmask;
 > -}
 > -
 > -void helper_mtc0_srsconf2(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 env->CP0_SRSConf2 |=3D arg1 & env->CP0_SRSConf2_rw=
_bitmask;
 > -}
 > -
 > -void helper_mtc0_srsconf3(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 env->CP0_SRSConf3 |=3D arg1 & env->CP0_SRSConf3_rw=
_bitmask;
 > -}
 > -
 > -void helper_mtc0_srsconf4(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 env->CP0_SRSConf4 |=3D arg1 & env->CP0_SRSConf4_rw=
_bitmask;
 > -}
 > -
 > -void helper_mtc0_hwrena(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t mask =3D 0x0000000F;
 > -
 > -=C2=A0=C2=A0=C2=A0 if ((env->CP0_Config1 & (1 << CP0C1_PC)) &&
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (env->insn_flags & ISA_MIP=
S32R6)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D (1 << 4);
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 if (env->insn_flags & ISA_MIPS32R6) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D (1 << 5);
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 if (env->CP0_Config3 & (1 << CP0C3_ULRI)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D (1 << 29);
 > -
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (arg1 & (1 << 29)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 en=
v->hflags |=3D MIPS_HFLAG_HWRENA_ULR;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 en=
v->hflags &=3D ~MIPS_HFLAG_HWRENA_ULR;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 }
 > -
 > -=C2=A0=C2=A0=C2=A0 env->CP0_HWREna =3D arg1 & mask;
 > -}
 > -
 > -void helper_mtc0_count(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 cpu_mips_store_count(env, arg1);
 > -}
 > -
 > -void helper_mtc0_saari(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t target =3D arg1 & 0x3f;
 > -=C2=A0=C2=A0=C2=A0 if (target <=3D 1) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_SAARI =3D target;
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -void helper_mtc0_saar(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t target =3D env->CP0_SAARI & 0x3f;
 > -=C2=A0=C2=A0=C2=A0 if (target < 2) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_SAAR[target] =3D =
arg1 & 0x00000ffffffff03fULL;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (target) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 0:
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (env->itu) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 itc_reconfigure(env->itu);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -void helper_mthc0_saar(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t target =3D env->CP0_SAARI & 0x3f;
 > -=C2=A0=C2=A0=C2=A0 if (target < 2) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_SAAR[target] =3D
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((=
(uint64_t) arg1 << 32) & 0x00000fff00000000ULL) |
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (e=
nv->CP0_SAAR[target] & 0x00000000ffffffffULL);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (target) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 0:
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (env->itu) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 itc_reconfigure(env->itu);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -void helper_mtc0_entryhi(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 target_ulong old, val, mask;
 > -=C2=A0=C2=A0=C2=A0 mask =3D (TARGET_PAGE_MASK << 1) | env->CP0_EntryH=
i_ASID_mask;
 > -=C2=A0=C2=A0=C2=A0 if (((env->CP0_Config4 >> CP0C4_IE) & 0x3) >=3D 2)=
 {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D 1 << CP0EnHi_EHI=
NV;
 > -=C2=A0=C2=A0=C2=A0 }
 > -
 > -=C2=A0=C2=A0=C2=A0 /* 1k pages not implemented */
 > -#if defined(TARGET_MIPS64)
 > -=C2=A0=C2=A0=C2=A0 if (env->insn_flags & ISA_MIPS32R6) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int entryhi_r =3D extract6=
4(arg1, 62, 2);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int config0_at =3D extract=
32(env->CP0_Config0, 13, 2);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool no_supervisor =3D (en=
v->CP0_Status_rw_bitmask & 0x8) =3D=3D 0;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((entryhi_r =3D=3D 2) |=
|
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (e=
ntryhi_r =3D=3D 1 && (no_supervisor || config0_at =3D=3D 1))) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 skip EntryHi.R field if new value is reserved */
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ma=
sk &=3D ~(0x3ull << 62);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 mask &=3D env->SEGMask;
 > -#endif
 > -=C2=A0=C2=A0=C2=A0 old =3D env->CP0_EntryHi;
 > -=C2=A0=C2=A0=C2=A0 val =3D (arg1 & mask) | (old & ~mask);
 > -=C2=A0=C2=A0=C2=A0 env->CP0_EntryHi =3D val;
 > -=C2=A0=C2=A0=C2=A0 if (env->CP0_Config3 & (1 << CP0C3_MT)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sync_c0_entryhi(env, env->=
current_tc);
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 /* If the ASID changes, flush qemu's TLB.=C2=A0 */
 > -=C2=A0=C2=A0=C2=A0 if ((old & env->CP0_EntryHi_ASID_mask) !=3D
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (val & env->CP0_EntryHi_AS=
ID_mask)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tlb_flush(env_cpu(env));
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -void helper_mttc0_entryhi(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 other->CP0_EntryHi =3D arg1;
 > -=C2=A0=C2=A0=C2=A0 sync_c0_entryhi(other, other_tc);
 > -}
 > -
 > -void helper_mtc0_compare(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 cpu_mips_store_compare(env, arg1);
 > -}
 > -
 > -void helper_mtc0_status(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t val, old;
 > -
 > -=C2=A0=C2=A0=C2=A0 old =3D env->CP0_Status;
 > -=C2=A0=C2=A0=C2=A0 cpu_mips_store_status(env, arg1);
 > -=C2=A0=C2=A0=C2=A0 val =3D env->CP0_Status;
 > -
 > -=C2=A0=C2=A0=C2=A0 if (qemu_loglevel_mask(CPU_LOG_EXEC)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_log("Status %08x (%08=
x) =3D> %08x (%08x) Cause %08x",
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 old, old & env->CP0_Cause & CP0Ca_IP_mask,
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 val, val & env->CP0_Cause & CP0Ca_IP_mask,
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 env->CP0_Cause);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (cpu_mmu_index(env,=
 false)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 3:
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qe=
mu_log(", ERL\n");
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case MIPS_HFLAG_UM:
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qe=
mu_log(", UM\n");
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case MIPS_HFLAG_SM:
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qe=
mu_log(", SM\n");
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case MIPS_HFLAG_KM:
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qe=
mu_log("\n");
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cp=
u_abort(env_cpu(env), "Invalid MMU mode!\n");
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -void helper_mttc0_status(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 uint32_t mask =3D env->CP0_Status_rw_bitmask & ~0x=
f1000018;
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 other->CP0_Status =3D (other->CP0_Status & ~mask) =
| (arg1 & mask);
 > -=C2=A0=C2=A0=C2=A0 sync_c0_status(env, other, other_tc);
 > -}
 > -
 > -void helper_mtc0_intctl(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 env->CP0_IntCtl =3D (env->CP0_IntCtl & ~0x000003e0=
) | (arg1 &=20
0x000003e0);
 > -}
 > -
 > -void helper_mtc0_srsctl(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint32_t mask =3D (0xf << CP0SRSCtl_ESS) | (0xf <<=
 CP0SRSCtl_PSS);
 > -=C2=A0=C2=A0=C2=A0 env->CP0_SRSCtl =3D (env->CP0_SRSCtl & ~mask) | (a=
rg1 & mask);
 > -}
 > -
 > -void helper_mtc0_cause(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 cpu_mips_store_cause(env, arg1);
 > -}
 > -
 > -void helper_mttc0_cause(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 cpu_mips_store_cause(other, arg1);
 > -}
 > -
 > -target_ulong helper_mftc0_epc(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 return other->CP0_EPC;
 > -}
 > -
 > -target_ulong helper_mftc0_ebase(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 return other->CP0_EBase;
 > -}
 > -
 > -void helper_mtc0_ebase(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 target_ulong mask =3D 0x3FFFF000 | env->CP0_EBaseW=
G_rw_bitmask;
 > -=C2=A0=C2=A0=C2=A0 if (arg1 & env->CP0_EBaseWG_rw_bitmask) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D ~0x3FFFFFFF;
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 env->CP0_EBase =3D (env->CP0_EBase & ~mask) | (arg=
1 & mask);
 > -}
 > -
 > -void helper_mttc0_ebase(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -=C2=A0=C2=A0=C2=A0 target_ulong mask =3D 0x3FFFF000 | env->CP0_EBaseW=
G_rw_bitmask;
 > -=C2=A0=C2=A0=C2=A0 if (arg1 & env->CP0_EBaseWG_rw_bitmask) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D ~0x3FFFFFFF;
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 other->CP0_EBase =3D (other->CP0_EBase & ~mask) | =
(arg1 & mask);
 > -}
 > -
 > -target_ulong helper_mftc0_configx(CPUMIPSState *env, target_ulong idx=
)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 switch (idx) {
 > -=C2=A0=C2=A0=C2=A0 case 0: return other->CP0_Config0;
 > -=C2=A0=C2=A0=C2=A0 case 1: return other->CP0_Config1;
 > -=C2=A0=C2=A0=C2=A0 case 2: return other->CP0_Config2;
 > -=C2=A0=C2=A0=C2=A0 case 3: return other->CP0_Config3;
 > -=C2=A0=C2=A0=C2=A0 /* 4 and 5 are reserved.=C2=A0 */
 > -=C2=A0=C2=A0=C2=A0 case 6: return other->CP0_Config6;
 > -=C2=A0=C2=A0=C2=A0 case 7: return other->CP0_Config7;
 > -=C2=A0=C2=A0=C2=A0 default:
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 return 0;
 > -}
 > -
 > -void helper_mtc0_config0(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 env->CP0_Config0 =3D (env->CP0_Config0 & 0x81FFFFF=
8) | (arg1 &=20
0x00000007);
 > -}
 > -
 > -void helper_mtc0_config2(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 /* tertiary/secondary caches not implemented */
 > -=C2=A0=C2=A0=C2=A0 env->CP0_Config2 =3D (env->CP0_Config2 & 0x8FFF0FF=
F);
 > -}
 > -
 > -void helper_mtc0_config3(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 if (env->insn_flags & ASE_MICROMIPS) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_Config3 =3D (env-=
>CP0_Config3 & ~(1 <<=20
CP0C3_ISA_ON_EXC)) |
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 (arg1 & (1 << CP0C3_ISA_ON_EXC));
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -void helper_mtc0_config4(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 env->CP0_Config4 =3D (env->CP0_Config4 &=20
(~env->CP0_Config4_rw_bitmask)) |
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (arg1 & e=
nv->CP0_Config4_rw_bitmask);
 > -}
 > -
 > -void helper_mtc0_config5(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 env->CP0_Config5 =3D (env->CP0_Config5 &=20
(~env->CP0_Config5_rw_bitmask)) |
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (arg1 & e=
nv->CP0_Config5_rw_bitmask);
 > -=C2=A0=C2=A0=C2=A0 env->CP0_EntryHi_ASID_mask =3D (env->CP0_Config5 &=
 (1 << CP0C5_MI)) ?
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x=
0 : (env->CP0_Config4 & (1 << CP0C4_AE)) ? 0x3ff : 0xff;
 > -=C2=A0=C2=A0=C2=A0 compute_hflags(env);
 > -}
 > -
 > -void helper_mtc0_lladdr(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 target_long mask =3D env->CP0_LLAddr_rw_bitmask;
 > -=C2=A0=C2=A0=C2=A0 arg1 =3D arg1 << env->CP0_LLAddr_shift;
 > -=C2=A0=C2=A0=C2=A0 env->CP0_LLAddr =3D (env->CP0_LLAddr & ~mask) | (a=
rg1 & mask);
 > -}
 > -
 > -#define MTC0_MAAR_MASK(env) \
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((0x1ULL << 63) | ((env->P=
AMask >> 4) & ~0xFFFull) | 0x3)
 > -
 > -void helper_mtc0_maar(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 env->CP0_MAAR[env->CP0_MAARI] =3D arg1 & MTC0_MAAR=
_MASK(env);
 > -}
 > -
 > -void helper_mthc0_maar(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 env->CP0_MAAR[env->CP0_MAARI] =3D
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (((uint64_t) arg1 << 32) &=
 MTC0_MAAR_MASK(env)) |
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (env->CP0_MAAR[env->CP0_MA=
ARI] & 0x00000000ffffffffULL);
 > -}
 > -
 > -void helper_mtc0_maari(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int index =3D arg1 & 0x3f;
 > -=C2=A0=C2=A0=C2=A0 if (index =3D=3D 0x3f) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Software may write=
 all ones to INDEX to determine the
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0 maximum valu=
e supported.
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_MAARI =3D MIPS_MA=
AR_MAX - 1;
 > -=C2=A0=C2=A0=C2=A0 } else if (index < MIPS_MAAR_MAX) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_MAARI =3D index;
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 /*
 > -=C2=A0=C2=A0=C2=A0=C2=A0 * Other than the all ones, if the value writ=
ten is not supported,
 > -=C2=A0=C2=A0=C2=A0=C2=A0 * then INDEX is unchanged from its previous =
value.
 > -=C2=A0=C2=A0=C2=A0=C2=A0 */
 > -}
 > -
 > -void helper_mtc0_watchlo(CPUMIPSState *env, target_ulong arg1,=20
uint32_t sel)
 > -{
 > -=C2=A0=C2=A0=C2=A0 /*
 > -=C2=A0=C2=A0=C2=A0=C2=A0 * Watch exceptions for instructions, data lo=
ads, data stores
 > -=C2=A0=C2=A0=C2=A0=C2=A0 * not implemented.
 > -=C2=A0=C2=A0=C2=A0=C2=A0 */
 > -=C2=A0=C2=A0=C2=A0 env->CP0_WatchLo[sel] =3D (arg1 & ~0x7);
 > -}
 > -
 > -void helper_mtc0_watchhi(CPUMIPSState *env, target_ulong arg1,=20
uint32_t sel)
 > -{
 > -=C2=A0=C2=A0=C2=A0 uint64_t mask =3D 0x40000FF8 | (env->CP0_EntryHi_A=
SID_mask <<=20
CP0WH_ASID);
 > -=C2=A0=C2=A0=C2=A0 if ((env->CP0_Config5 >> CP0C5_MI) & 1) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask |=3D 0xFFFFFFFF000000=
00ULL; /* MMID */
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 env->CP0_WatchHi[sel] =3D arg1 & mask;
 > -=C2=A0=C2=A0=C2=A0 env->CP0_WatchHi[sel] &=3D ~(env->CP0_WatchHi[sel]=
 & arg1 & 0x7);
 > -}
 > -
 > -void helper_mthc0_watchhi(CPUMIPSState *env, target_ulong arg1,=20
uint32_t sel)
 > -{
 > -=C2=A0=C2=A0=C2=A0 env->CP0_WatchHi[sel] =3D ((uint64_t) (arg1) << 32=
) |
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (env->CP0_WatchHi[sel] &=20
0x00000000ffffffffULL);
 > -}
 > -
 > -void helper_mtc0_xcontext(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 target_ulong mask =3D (1ULL << (env->SEGBITS - 7))=
 - 1;
 > -=C2=A0=C2=A0=C2=A0 env->CP0_XContext =3D (env->CP0_XContext & mask) |=
 (arg1 & ~mask);
 > -}
 > -
 > -void helper_mtc0_framemask(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 env->CP0_Framemask =3D arg1; /* XXX */
 > -}
 > -
 > -void helper_mtc0_debug(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 env->CP0_Debug =3D (env->CP0_Debug & 0x8C03FC1F) |=
 (arg1 &=20
0x13300120);
 > -=C2=A0=C2=A0=C2=A0 if (arg1 & (1 << CP0DB_DM)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->hflags |=3D MIPS_HFLA=
G_DM;
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->hflags &=3D ~MIPS_HFL=
AG_DM;
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -void helper_mttc0_debug(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 uint32_t val =3D arg1 & ((1 << CP0DB_SSt) | (1 << =
CP0DB_Halt));
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 /* XXX: Might be wrong, check with EJTAG spec. */
 > -=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->active_tc.CP0_Debug=
_tcstatus =3D val;
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->tcs[other_tc].CP0_D=
ebug_tcstatus =3D val;
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 other->CP0_Debug =3D (other->CP0_Debug &
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((1 << CP0DB_SSt) | (=
1 << CP0DB_Halt))) |
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (arg1 & ~((1 << CP0DB=
_SSt) | (1 << CP0DB_Halt)));
 > -}
 > -
 > -void helper_mtc0_performance0(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 env->CP0_Performance0 =3D arg1 & 0x000007ff;
 > -}
 > -
 > -void helper_mtc0_errctl(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int32_t wst =3D arg1 & (1 << CP0EC_WST);
 > -=C2=A0=C2=A0=C2=A0 int32_t spr =3D arg1 & (1 << CP0EC_SPR);
 > -=C2=A0=C2=A0=C2=A0 int32_t itc =3D env->itc_tag ? (arg1 & (1 << CP0EC=
_ITC)) : 0;
 > -
 > -=C2=A0=C2=A0=C2=A0 env->CP0_ErrCtl =3D wst | spr | itc;
 > -
 > -=C2=A0=C2=A0=C2=A0 if (itc && !wst && !spr) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->hflags |=3D MIPS_HFLA=
G_ITC_CACHE;
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->hflags &=3D ~MIPS_HFL=
AG_ITC_CACHE;
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -void helper_mtc0_taglo(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 if (env->hflags & MIPS_HFLAG_ITC_CACHE) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If CACHE instructi=
on is configured for ITC tags then make all
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * CP0.TagLo bits wri=
table. The actual write to ITC=20
Configuration
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Tag will take care=
 of the read-only bits.
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_TagLo =3D arg1;
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_TagLo =3D arg1 & =
0xFFFFFCF6;
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -void helper_mtc0_datalo(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 env->CP0_DataLo =3D arg1; /* XXX */
 > -}
 > -
 > -void helper_mtc0_taghi(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 env->CP0_TagHi =3D arg1; /* XXX */
 > -}
 > -
 > -void helper_mtc0_datahi(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 env->CP0_DataHi =3D arg1; /* XXX */
 > -}
 > -
 > -/* MIPS MT functions */
 > -target_ulong helper_mftgpr(CPUMIPSState *env, uint32_t sel)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->active_tc.gp=
r[sel];
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->tcs[other_tc=
].gpr[sel];
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -target_ulong helper_mftlo(CPUMIPSState *env, uint32_t sel)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->active_tc.LO=
[sel];
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->tcs[other_tc=
].LO[sel];
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -target_ulong helper_mfthi(CPUMIPSState *env, uint32_t sel)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->active_tc.HI=
[sel];
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->tcs[other_tc=
].HI[sel];
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -target_ulong helper_mftacx(CPUMIPSState *env, uint32_t sel)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->active_tc.AC=
X[sel];
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->tcs[other_tc=
].ACX[sel];
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -target_ulong helper_mftdsp(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->active_tc.DS=
PControl;
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return other->tcs[other_tc=
].DSPControl;
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -void helper_mttgpr(CPUMIPSState *env, target_ulong arg1, uint32_t sel=
)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->active_tc.gpr[sel] =
=3D arg1;
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->tcs[other_tc].gpr[s=
el] =3D arg1;
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -void helper_mttlo(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->active_tc.LO[sel] =3D=
 arg1;
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->tcs[other_tc].LO[se=
l] =3D arg1;
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -void helper_mtthi(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->active_tc.HI[sel] =3D=
 arg1;
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->tcs[other_tc].HI[se=
l] =3D arg1;
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -void helper_mttacx(CPUMIPSState *env, target_ulong arg1, uint32_t sel=
)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->active_tc.ACX[sel] =
=3D arg1;
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->tcs[other_tc].ACX[s=
el] =3D arg1;
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -void helper_mttdsp(CPUMIPSState *env, target_ulong arg1)
 > -{
 > -=C2=A0=C2=A0=C2=A0 int other_tc =3D env->CP0_VPEControl & (0xff << CP=
0VPECo_TargTC);
 > -=C2=A0=C2=A0=C2=A0 CPUMIPSState *other =3D mips_cpu_map_tc(env, &othe=
r_tc);
 > -
 > -=C2=A0=C2=A0=C2=A0 if (other_tc =3D=3D other->current_tc) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->active_tc.DSPContro=
l =3D arg1;
 > -=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 other->tcs[other_tc].DSPCo=
ntrol =3D arg1;
 > -=C2=A0=C2=A0=C2=A0 }
 > -}
 > -
 > -/* MIPS MT functions */
 > -target_ulong helper_dmt(void)
 > -{
 > -=C2=A0=C2=A0=C2=A0 /* TODO */
 > -=C2=A0=C2=A0=C2=A0 return 0;
 > -}
 > -
 > -target_ulong helper_emt(void)
 > -{
 > -=C2=A0=C2=A0=C2=A0 /* TODO */
 > -=C2=A0=C2=A0=C2=A0 return 0;
 > -}
 > -
 > -target_ulong helper_dvpe(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 CPUState *other_cs =3D first_cpu;
 > -=C2=A0=C2=A0=C2=A0 target_ulong prev =3D env->mvp->CP0_MVPControl;
 > -
 > -=C2=A0=C2=A0=C2=A0 CPU_FOREACH(other_cs) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MIPSCPU *other_cpu =3D MIP=
S_CPU(other_cs);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Turn off all VPEs excep=
t the one executing the dvpe.=C2=A0 */
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (&other_cpu->env !=3D e=
nv) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ot=
her_cpu->env.mvp->CP0_MVPControl &=3D ~(1 << CP0MVPCo_EVP);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mi=
ps_vpe_sleep(other_cpu);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 return prev;
 > -}
 > -
 > -target_ulong helper_evpe(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 CPUState *other_cs =3D first_cpu;
 > -=C2=A0=C2=A0=C2=A0 target_ulong prev =3D env->mvp->CP0_MVPControl;
 > -
 > -=C2=A0=C2=A0=C2=A0 CPU_FOREACH(other_cs) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MIPSCPU *other_cpu =3D MIP=
S_CPU(other_cs);
 > -
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (&other_cpu->env !=3D e=
nv
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 If the VPE is WFI, don't disturb its sleep.=C2=A0 */
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &&=
 !mips_vpe_is_wfi(other_cpu)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 Enable the VPE.=C2=A0 */
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ot=
her_cpu->env.mvp->CP0_MVPControl |=3D (1 << CP0MVPCo_EVP);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mi=
ps_vpe_wake(other_cpu); /* And wake it up.=C2=A0 */
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 return prev;
 > -}
 > -#endif /* !CONFIG_USER_ONLY */
 > -
 > -void helper_fork(target_ulong arg1, target_ulong arg2)
 > -{
 > -=C2=A0=C2=A0=C2=A0 /*
 > -=C2=A0=C2=A0=C2=A0=C2=A0 * arg1 =3D rt, arg2 =3D rs
 > -=C2=A0=C2=A0=C2=A0=C2=A0 * TODO: store to TC register
 > -=C2=A0=C2=A0=C2=A0=C2=A0 */
 > -}
 > -
 > -target_ulong helper_yield(CPUMIPSState *env, target_ulong arg)
 > -{
 > -=C2=A0=C2=A0=C2=A0 target_long arg1 =3D arg;
 > -
 > -=C2=A0=C2=A0=C2=A0 if (arg1 < 0) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* No scheduling policy im=
plemented. */
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (arg1 !=3D -2) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (env->CP0_VPEControl & (1 << CP0VPECo_YSI) &&
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 env->active_tc.CP0_TCStatus & (1 << CP0TCSt_DT)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 env->CP0_VPEControl &=3D ~(0x7 << CP0VPECo_EXCPT);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 env->CP0_VPEControl |=3D 4 << CP0VPECo_EXCPT;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 do_raise_exception(env, EXCP_THREAD, GETPC());
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 } else if (arg1 =3D=3D 0) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (0) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 TODO: TC underflow */
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 en=
v->CP0_VPEControl &=3D ~(0x7 << CP0VPECo_EXCPT);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do=
_raise_exception(env, EXCP_THREAD, GETPC());
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 TODO: Deallocate TC */
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 } else if (arg1 > 0) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Yield qualifier inputs =
not implemented. */
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_VPEControl &=3D ~=
(0x7 << CP0VPECo_EXCPT);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_VPEControl |=3D 2=
 << CP0VPECo_EXCPT;
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do_raise_exception(env, EX=
CP_THREAD, GETPC());
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 return env->CP0_YQMask;
 > -}
 > -
 > -/* R6 Multi-threading */
 > -#ifndef CONFIG_USER_ONLY
 > -target_ulong helper_dvp(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 CPUState *other_cs =3D first_cpu;
 > -=C2=A0=C2=A0=C2=A0 target_ulong prev =3D env->CP0_VPControl;
 > -
 > -=C2=A0=C2=A0=C2=A0 if (!((env->CP0_VPControl >> CP0VPCtl_DIS) & 1)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPU_FOREACH(other_cs) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MI=
PSCPU *other_cpu =3D MIPS_CPU(other_cs);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 Turn off all VPs except the one executing the dvp. */
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (&other_cpu->env !=3D env) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mips_vpe_sleep(other_cpu);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_VPControl |=3D (1=
 << CP0VPCtl_DIS);
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 return prev;
 > -}
 > -
 > -target_ulong helper_evp(CPUMIPSState *env)
 > -{
 > -=C2=A0=C2=A0=C2=A0 CPUState *other_cs =3D first_cpu;
 > -=C2=A0=C2=A0=C2=A0 target_ulong prev =3D env->CP0_VPControl;
 > -
 > -=C2=A0=C2=A0=C2=A0 if ((env->CP0_VPControl >> CP0VPCtl_DIS) & 1) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPU_FOREACH(other_cs) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MI=
PSCPU *other_cpu =3D MIPS_CPU(other_cs);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 ((&other_cpu->env !=3D env) &&=20
!mips_vp_is_wfi(other_cpu)) {
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /*
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If the VP is WFI, don't disturb its sleep.
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Otherwise, wake it up.
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mips_vpe_wake(other_cpu);
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->CP0_VPControl &=3D ~(=
1 << CP0VPCtl_DIS);
 > -=C2=A0=C2=A0=C2=A0 }
 > -=C2=A0=C2=A0=C2=A0 return prev;
 > -}
 > -#endif /* !CONFIG_USER_ONLY */
 >
 >=C2=A0 #ifndef CONFIG_USER_ONLY
 >=C2=A0 /* TLB management */

Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>


