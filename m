Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F4DC10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 13:38:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3933420652
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 13:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3933420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41667 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH7El-0006ic-D6
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 09:37:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hH7DA-00064g-LS
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 09:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hH7D4-0005Dk-3P
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 09:36:20 -0400
Received: from indium.canonical.com ([91.189.90.7]:39452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hH7D3-0005DP-7W
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 09:36:13 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hH7CV-0002zn-WD
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 13:35:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CF6E92E80CB
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 13:35:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Apr 2019 13:27:29 -0000
From: Shahab Vahedi <1825359@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Tags: fetch mmu mpu
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: pmaydell shahab-vahedi
X-Launchpad-Bug-Reporter: Shahab Vahedi (shahab-vahedi)
X-Launchpad-Bug-Modifier: Shahab Vahedi (shahab-vahedi)
References: <155558881987.7164.1099557133760519082.malonedeb@chaenomeles.canonical.com>
Message-Id:
 <155559404968.17129.2648908073175530835.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 316bd22210e07534bf0c0cb734acb6f3edda2563
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1825359] Re: cpu_ld*_code() triggers
 MMU_DATA_LOAD i.s.o. MMU_INST_FETCH
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1825359 <1825359@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418132729.-u_SG7Xz8DO6RTBrI2Yf2ZPcr5GRfhNRy0lPDbrOxXw@z>

** Patch added: "bug1825359_io_readx.patch"
   https://bugs.launchpad.net/qemu/+bug/1825359/+attachment/5256724/+files/=
bug1825359_io_readx.patch

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1825359

Title:
  cpu_ld*_code() triggers MMU_DATA_LOAD i.s.o. MMU_INST_FETCH

Status in QEMU:
  Confirmed

Bug description:
  commit 377b155bde451d5ac545fbdcdfbf6ca17a4228f5
  Merge: c876180938 328eb60dc1
  Author: Peter Maydell <peter.x@x.x>        ; masked for anti-spamming pur=
poses
  Date:   Mon Mar 11 18:26:37 2019 +0000
  https://github.com/qemu/qemu/commit/377b155bde451d5ac545fbdcdfbf6ca17a422=
8f5
  --------------------------------------------------

  cpu_ld*_code() is used for loading code data as the name suggests. Althou=
gh, it begins accessing memory with MMU_INST_FETCH access type, somewhere d=
own
  the road, when the "io_readx(..., access_type=3DMMU_INST_FETCH, ...)" is
  called, it is ignoring this "access_type" while calling the "tlb_fill()"
  with a _hardcoded_ MMU_DATA_LOAD:

  cputlb.c
  --------
  static uint64_t io_readx(..., MMUAccessType access_type, ...)
  {

  =C2=A0=C2=A0=C2=A0=C2=A0if (recheck) {
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CPUTLBEntry *entry;
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0target_ulong tlb_addr;

  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tlb_fill(cpu, addr, size,=
 MMU_DATA_LOAD, mmu_idx, retaddr);
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0...
  }
  --------

  This is an issue, because there can exist _small_ regions of memory (smal=
ler
  than the TARGET_PAGE_SIZE) that are only executable and not readable.

  TL;DR

  What happens is at first, a "tlb_fill(..., access_type=3DMMU_INST_FETCH, =
...)"
  is triggered by "tb_lookup_cpu_state()". To be precise, this is the call
  stack which is good behavior:
  ---
  #0  tlb_fill (cs=3D..., vaddr=3D684, size=3D0, access_type=3DMMU_INST_FET=
CH, mmu_idx=3D0, retaddr=3D0) at target/arc/mmu.c:602
  #1  get_page_addr_code (env=3D..., addr=3D684) at accel/tcg/cputlb.c:1045
  #2  tb_htable_lookup (cpu=3D..., pc=3D684, cs_base=3D0, flags=3D0, cf_mas=
k=3D4278190080) at accel/tcg/cpu-exec.c:337
  #3  tb_lookup__cpu_state (cpu=3D..., pc=3D..., cs_base=3D..., flags=3D...=
, cf_mask=3D4278190080) at include/exec/tb-lookup.h:43
  #4  tb_find (cpu=3D..., last_tb=3D... <code_gen_buffer+17811>, tb_exit=3D=
0, cf_mask=3D0) at accel/tcg/cpu-exec.c:404
  #5  cpu_exec (cpu=3D...) at accel/tcg/cpu-exec.c:729
  #6  tcg_cpu_exec (cpu=3D...) at cpus.c:1430
  #7  qemu_tcg_rr_cpu_thread_fn (arg=3D...) at cpus.c:1531
  #8  qemu_thread_start (args=3D...) at util/qemu-thread-posix.c:502
  ---

  After this call, TLB is filled with an entry that its size field is small,
  say 32 bytes. This causes a TLB_RECHECK for consequent memory accesses, w=
hich =

  is logical. However, in our decoder, we use cpu_lduw_code() to read the
  instructions and decode them. As mentioned, in the beginning, the
  access_type=3DMMU_INST_FETCH is lost in "io_readx()" while calling tlb_fi=
ll()",
  and now THIS CAUSES A GUEST EXCEPTION BECAUSE THAT REGION IS NOT ALLOWED =
TO
  BE READ. Here, comes that trace call of the _bad_ behavior:
  ---
  #0  tlb_fill (..., access_type=3DMMU_DATA_LOAD, ...) at target/arc/mmu.c:=
605
  #1  io_readx (..., access_type=3DMMU_INST_FETCH, size=3D2) at accel/tcg/c=
putlb.c:881
  #2  io_readw (..., access_type=3DMMU_INST_FETCH) at accel/tcg/softmmu_tem=
plate.h:106
  #3  helper_le_ldw_cmmu (..., oi=3D16, retaddr=3D0) at accel/tcg/softmmu_t=
emplate.h:146
  #4  cpu_lduw_code_ra (env=3D..., ptr=3D684, retaddr=3D0) at include/exec/=
cpu_ldst_template.h:102
  #5  cpu_lduw_code (env=3D..., ptr=3D684) at include/exec/cpu_ldst_templat=
e.h:114
  #6  read_and_decode_context (ctx=3D..., opcode_p=3D...) at target/arc/arc=
-decoder.c:1479
  #7  arc_decode (ctx=3D...) at target/arc/arc-decoder.c:1736
  #8  decode_opc (env=3D..., ctx=3D...) at target/arc/translate.c:313
  #9  arc_tr_translate_insn (dcbase=3D..., cpu=3D...) at target/arc/transla=
te.c:335
  #10 translator_loop (.. <code_gen_buffer+18131>) at accel/tcg/translator.=
c:107
  #11 gen_intermediate_code (cpu=3D..., tb=3D... <code_gen_buffer+18131>) a=
t target/arc/translate.c:413
  #12 tb_gen_code (cpu=3D..., pc=3D684, cs_base=3D0, flags=3D0, cflags=3D-1=
6711679) at accel/tcg/translate-all.c:1723
  #13 tb_find (cpu=3D..., last_tb=3D... <code_gen_buffer+17811>, tb_exit=3D=
0, cf_mask=3D0) at accel/tcg/cpu-exec.c:407
  #14 cpu_exec (cpu=3D...) at accel/tcg/cpu-exec.c:729
  #15 tcg_cpu_exec (cpu=3D...) at cpus.c:1430

  ---

  Do you confirm if this is an issue? Maybe there are other ways to read
  an instruction with MMU_INST_FETCH access that I don't know about.

  Last but not least, although this is not a security issue for QEMU per
  se, but it is hindering a security feature for the guest.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1825359/+subscriptions

