Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97427C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:56:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C5532053B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C5532053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k403H-0002Dr-Pc
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 06:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k401v-0000Pz-9q
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:55:19 -0400
Received: from indium.canonical.com ([91.189.90.7]:46976)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k401s-0004bu-Kx
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:55:18 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k401q-00082r-Ez
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 10:55:14 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6E5982E8081
 for <qemu-devel@nongnu.org>; Fri,  7 Aug 2020 10:55:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2020 10:38:17 -0000
From: Sebastian Huber <1277433@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: sebastian-huber th-huth
X-Launchpad-Bug-Reporter: Sebastian Huber (sebastian-huber)
X-Launchpad-Bug-Modifier: Sebastian Huber (sebastian-huber)
References: <20140207101533.1830.3618.malonedeb@chaenomeles.canonical.com>
Message-Id: <159679669750.25952.2004903783394104230.malone@gac.canonical.com>
Subject: [Bug 1277433] Re: GDB context is inconsistent after "monitor
 system_reset"
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="6a138c03da9cc3e2e03f6dd3bbb4a615b0be6ec2";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 2f27ffc0e495b405497df3d357e60d1c18521c55
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 01:41:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1277433 <1277433@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With this Qemu:

qemu-system-arm --version
QEMU emulator version 4.2.50 (v4.2.0-1276-g863d2ed582)
Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

I still have the same issue:

(gdb) info registers
r0             0x0                 0
r1             0x9010001           151060481
r2             0x0                 0
r3             0x428c89            4361353
r4             0x640f08            6557448
r5             0x672480            6759552
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x60bb80            6339456
sp             0x6783f0            0x6783f0 <_Thread_Idle_stacks+4080>
lr             0x425fa1            4349857
pc             0x428c8a            0x428c8a <_CPU_Thread_Idle_body+2>
cpsr           0x60070173          1611071859
fpscr          0x0                 0
fpsid          0x41033090          1090728080
fpexc          0x40000000          1073741824
[...]
(gdb) monitor info registers
R00=3D00000000 R01=3D09010001 R02=3D00000000 R03=3D00428c89
R04=3D00640f08 R05=3D00672480 R06=3D00000000 R07=3D00000000
R08=3D00000000 R09=3D00000000 R10=3D00000000 R11=3D00000000
R12=3D0060bb80 R13=3D006783f0 R14=3D00425fa1 R15=3D00428c8a
PSR=3D60070173 -ZC- T svc32
s00=3D00013831 s01=3D00000000 d00=3D0000000000013831
s02=3D00000e0f s03=3D00000000 d01=3D0000000000000e0f
s04=3D00000000 s05=3D00000000 d02=3D0000000000000000
s06=3D00000000 s07=3D00000000 d03=3D0000000000000000
s08=3D00000000 s09=3D00000000 d04=3D0000000000000000
s10=3D00000000 s11=3D00000000 d05=3D0000000000000000
s12=3D00000000 s13=3D00000000 d06=3D0000000000000000
s14=3D00000000 s15=3D00000000 d07=3D0000000000000000
s16=3D00000000 s17=3D00000000 d08=3D0000000000000000
s18=3D00000000 s19=3D00000000 d09=3D0000000000000000
s20=3D00000000 s21=3D00000000 d10=3D0000000000000000
s22=3D00000000 s23=3D00000000 d11=3D0000000000000000
s24=3D00000000 s25=3D00000000 d12=3D0000000000000000
s26=3D00000000 s27=3D00000000 d13=3D0000000000000000
s28=3D00000000 s29=3D00000000 d14=3D0000000000000000
s30=3D00000000 s31=3D00000000 d15=3D0000000000000000
s32=3D00000000 s33=3D00000000 d16=3D0000000000000000
s34=3D00000000 s35=3D00000000 d17=3D0000000000000000
s36=3D00000000 s37=3D00000000 d18=3D0000000000000000
s38=3D00000000 s39=3D00000000 d19=3D0000000000000000
s40=3D00000000 s41=3D00000000 d20=3D0000000000000000
s42=3D00000000 s43=3D00000000 d21=3D0000000000000000
s44=3D00000000 s45=3D00000000 d22=3D0000000000000000
s46=3D00000000 s47=3D00000000 d23=3D0000000000000000
s48=3D00000000 s49=3D00000000 d24=3D0000000000000000
s50=3D00000000 s51=3D00000000 d25=3D0000000000000000
s52=3D00000000 s53=3D00000000 d26=3D0000000000000000
s54=3D00000000 s55=3D00000000 d27=3D0000000000000000
s56=3D00000000 s57=3D00000000 d28=3D0000000000000000
s58=3D00000000 s59=3D00000000 d29=3D0000000000000000
s60=3D00000000 s61=3D00000000 d30=3D0000000000000000
s62=3D00000000 s63=3D00000000 d31=3D0000000000000000
FPSCR: 00000000
(gdb) monitor system_reset
(gdb) info registers
r0             0x0                 0
r1             0x9010001           151060481
r2             0x0                 0
r3             0x428c89            4361353
r4             0x640f08            6557448
r5             0x672480            6759552
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x60bb80            6339456
sp             0x6783f0            0x6783f0 <_Thread_Idle_stacks+4080>
lr             0x425fa1            4349857
pc             0x428c8a            0x428c8a <_CPU_Thread_Idle_body+2>
cpsr           0x60070173          1611071859
fpscr          0x0                 0
fpsid          0x41033090          1090728080
fpexc          0x40000000          1073741824
[...]
(gdb) monitor info registers
R00=3D00000000 R01=3D00000000 R02=3D00000000 R03=3D00000000
R04=3D00000000 R05=3D00000000 R06=3D00000000 R07=3D00000000
R08=3D00000000 R09=3D00000000 R10=3D00000000 R11=3D00000000
R12=3D00000000 R13=3D00000000 R14=3D00000000 R15=3D00104040
PSR=3D400001d3 -Z-- A svc32
s00=3D00000000 s01=3D00000000 d00=3D0000000000000000
s02=3D00000000 s03=3D00000000 d01=3D0000000000000000
s04=3D00000000 s05=3D00000000 d02=3D0000000000000000
s06=3D00000000 s07=3D00000000 d03=3D0000000000000000
s08=3D00000000 s09=3D00000000 d04=3D0000000000000000
s10=3D00000000 s11=3D00000000 d05=3D0000000000000000
s12=3D00000000 s13=3D00000000 d06=3D0000000000000000
s14=3D00000000 s15=3D00000000 d07=3D0000000000000000
s16=3D00000000 s17=3D00000000 d08=3D0000000000000000
s18=3D00000000 s19=3D00000000 d09=3D0000000000000000
s20=3D00000000 s21=3D00000000 d10=3D0000000000000000
s22=3D00000000 s23=3D00000000 d11=3D0000000000000000
s24=3D00000000 s25=3D00000000 d12=3D0000000000000000
s26=3D00000000 s27=3D00000000 d13=3D0000000000000000
s28=3D00000000 s29=3D00000000 d14=3D0000000000000000
s30=3D00000000 s31=3D00000000 d15=3D0000000000000000
s32=3D00000000 s33=3D00000000 d16=3D0000000000000000
s34=3D00000000 s35=3D00000000 d17=3D0000000000000000
s36=3D00000000 s37=3D00000000 d18=3D0000000000000000
s38=3D00000000 s39=3D00000000 d19=3D0000000000000000
s40=3D00000000 s41=3D00000000 d20=3D0000000000000000
s42=3D00000000 s43=3D00000000 d21=3D0000000000000000
s44=3D00000000 s45=3D00000000 d22=3D0000000000000000
s46=3D00000000 s47=3D00000000 d23=3D0000000000000000
s48=3D00000000 s49=3D00000000 d24=3D0000000000000000
s50=3D00000000 s51=3D00000000 d25=3D0000000000000000
s52=3D00000000 s53=3D00000000 d26=3D0000000000000000
s54=3D00000000 s55=3D00000000 d27=3D0000000000000000
s56=3D00000000 s57=3D00000000 d28=3D0000000000000000
s58=3D00000000 s59=3D00000000 d29=3D0000000000000000
s60=3D00000000 s61=3D00000000 d30=3D0000000000000000
s62=3D00000000 s63=3D00000000 d31=3D0000000000000000
FPSCR: 00000000
(gdb) si
bsp_start_vector_table_end () at /home/EB/sebastian_h/src/rtems/bsps/arm/sh=
ared/start/start.S:166
166             mov     r6, r2          /* physical address of ATAGs or DTB=
 */
(gdb) info registers
r0             0x0                 0
r1             0x0                 0
r2             0x0                 0
r3             0x0                 0
r4             0x0                 0
r5             0x0                 0
r6             0x0                 0
r7             0x0                 0
r8             0x0                 0
r9             0x0                 0
r10            0x0                 0
r11            0x0                 0
r12            0x0                 0
sp             0x0                 0x0
lr             0x0                 0
pc             0x104044            0x104044 <bsp_start_vector_table_end+4>
cpsr           0x400001d3          1073742291
fpscr          0x0                 0
fpsid          0x41033090          1090728080
fpexc          0x0                 0
[...]

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1277433

Title:
  GDB context is inconsistent after "monitor system_reset"

Status in QEMU:
  Incomplete

Bug description:
  After a "monitor system_reset" the GDB view to the system state
  differs from QEMUs processor state.

  Breakpoint 8, _ARMV4_Exception_interrupt () at /home/sh/rtems-4.11/c/src/=
../../cpukit/score/cpu/arm/arm_exc_interrupt.S:74
  74              mov     EXCHANGE_LR, lr
  (gdb) info registers
  r0             0x2027e8 2107368
  r1             0x204208 2114056
  r2             0x13     19
  r3             0x204238 2114104
  r4             0x0      0
  r5             0x0      0
  r6             0x0      0
  r7             0x0      0
  r8             0x0      0
  r9             0x0      0
  r10            0x0      0
  r11            0x0      0
  r12            0x0      0
  sp             0x201480 0x201480
  lr             0x110958 1116504
  pc             0x11073c 0x11073c <_ARMV4_Exception_interrupt+4>
  cpsr           0x192    402
  (gdb) monitor info registers
  R00=3D002027e8 R01=3D00204208 R02=3D00000013 R03=3D00204238
  R04=3D00000000 R05=3D00000000 R06=3D00000000 R07=3D00000000
  R08=3D00000000 R09=3D00000000 R10=3D00000000 R11=3D00000000
  R12=3D00000000 R13=3D00201480 R14=3D00110958 R15=3D0011073c
  PSR=3D00000192 ---- A irq32
  (gdb) monitor system_reset
  (gdb) info registers
  r0             0x2027e8 2107368
  r1             0x204208 2114056
  r2             0x13     19
  r3             0x204238 2114104
  r4             0x0      0
  r5             0x0      0
  r6             0x0      0
  r7             0x0      0
  r8             0x0      0
  r9             0x0      0
  r10            0x0      0
  r11            0x0      0
  r12            0x0      0
  sp             0x201480 0x201480
  lr             0x110958 1116504
  pc             0x11073c 0x11073c <_ARMV4_Exception_interrupt+4>
  cpsr           0x192    402
  (gdb) monitor info registers
  R00=3D00000000 R01=3D00000000 R02=3D00000000 R03=3D00000000
  R04=3D00000000 R05=3D00000000 R06=3D00000000 R07=3D00000000
  R08=3D00000000 R09=3D00000000 R10=3D00000000 R11=3D00000000
  R12=3D00000000 R13=3D00000000 R14=3D00000000 R15=3D00100040
  PSR=3D400001d3 -Z-- A svc32

  Why does the second "info registers" and "monitor info registers"
  differ?

  After a single instruction step they are synchronized at least on ARM
  (on SPARC this is different).

  (gdb) si
  bsp_start_vector_table_end () at /home/sh/rtems-4.11/c/src/lib/libbsp/arm=
/realview-pbx-a9/../shared/start/start.S:144
  144             msr     cpsr, r0
  (gdb) info registers
  r0             0xd3     211
  r1             0x0      0
  r2             0x0      0
  r3             0x0      0
  r4             0x0      0
  r5             0x0      0
  r6             0x0      0
  r7             0x0      0
  r8             0x0      0
  r9             0x0      0
  r10            0x0      0
  r11            0x0      0
  r12            0x0      0
  sp             0x0      0x0
  lr             0x0      0
  pc             0x100044 0x100044 <bsp_start_vector_table_end+4>
  cpsr           0x400001d3       1073742291
  (gdb) monitor info registers
  R00=3D000000d3 R01=3D00000000 R02=3D00000000 R03=3D00000000
  R04=3D00000000 R05=3D00000000 R06=3D00000000 R07=3D00000000
  R08=3D00000000 R09=3D00000000 R10=3D00000000 R11=3D00000000
  R12=3D00000000 R13=3D00000000 R14=3D00000000 R15=3D00100044
  PSR=3D400001d3 -Z-- A svc32

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1277433/+subscriptions

