Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD45C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 12:41:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EC26206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 12:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC26206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwPgH-0001LY-BR
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 08:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jwPff-0000tW-In
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:40:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:55924)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jwPfd-0005SB-BA
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:40:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jwPfb-0006Lr-8b
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 12:40:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 3FCF12E80EC
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 12:40:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2020 12:32:50 -0000
From: Peter Maydell <1887854@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: opticron pmaydell
X-Launchpad-Bug-Reporter: K (opticron)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <159492817809.19148.14056725236873205625.malonedeb@chaenomeles.canonical.com>
Message-Id: <159498917051.12817.12882227203582589989.malone@gac.canonical.com>
Subject: [Bug 1887854] Re: Spurious Data Abort on qemu-system-aarch64
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="4809fcb62f445aaa3ae919f7f6c3cc7d156ea57a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 5ba316ee755d8c8b0ea8a77ceb453379ea54138f
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 08:00:58
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
Reply-To: Bug 1887854 <1887854@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It does still crash on current QEMU. The proximate cause of the crash is
that you are trying to read from an address which is way outside RAM:

Trace 0: 0x7f8d50054340 [0000000000000000/00000000400195d8/0x82104000] strc=
mp
 PC=3D00000000400195d8 X00=3D000000104010ca28 X01=3D000000004001ec28
X02=3D0000000000000fe8 X03=3D00000000401098c8 X04=3D000000004010ba40
X05=3D5641526f44654b00 X06=3D1f276f6c62717372 X07=3D0000000000000000
X08=3D00000000ffffffda X09=3D00000000401097d0 X10=3D0101010101010101
X11=3D0000000000000000 X12=3D0000000000000000 X13=3D0000000000000000
X14=3D0000000000000000 X15=3D0000000000000000 X16=3D0000000040014610
X17=3D0000000000000008 X18=3D0000000000000000 X19=3D000000004010b9f0
X20=3D000000004001ec28 X21=3D000000084001ec20 X22=3D000000004001ec60
X23=3D000000004001ec40 X24=3D000000004001f548 X25=3D000000104001ec28
X26=3D000000104001ec40 X27=3D000000034001ec38 X28=3D0000000000000000
X29=3D00000000401098d0 X30=3D0000000040008a38  SP=3D00000000401098d0
PSTATE=3D40000005 -Z-- EL1h
Taking exception 4 [Data Abort]
...from EL1 to EL1
...with ESR 0x25/0x96000010
...with FAR 0x104010ca28
...with ELR 0x400195d8
...to EL1 PC 0x40018200 PSTATE 0x3c5

where the insn at 0x400195d8 is (inside strcmp)
0x400195d8:  f8408402  ldr      x2, [x0], #8

You can see that x0 is is 000000104010ca28, so QEMU is correct to give
the data abort here. Further diagnosis would require working back
through the log to find out where that address came from, which will be
easier for you to do since you have the source.

NB: I recommend these options for producing the logfile:
 /tmp/q.log -d in_asm,int,cpu_reset,exec,cpu,guest_errors,nochain -singlest=
ep
Execution will be slower, but the crash here is pretty quick so that's not =
a problem, and these options mean that every insn executed will produce a "=
Trace" line and a CPU register dump. That's easier to understand and read (=
especially reading backwards) than logs produced when QEMU is doing its nor=
mal optimisations of chaining TBs together and putting multiple guest insns=
 in each TB.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1887854

Title:
  Spurious Data Abort on qemu-system-aarch64

Status in QEMU:
  New

Bug description:
  When running RTEMS test psxndbm01.exe built for AArch64-ilp32 (this code =
is not yet publically available), the test generates a spurious data abort =
(the MMU and alignment checks should be disabled according to bits 1, 0 of =
SCTLR_EL1). The abort information is as follows:
  Taking exception 4 [Data Abort]
  ...from EL1 to EL1
  ...with ESR 0x25/0x96000010
  ...with FAR 0x104010ca28
  ...with ELR 0x400195d8
  ...to EL1 PC 0x40018200 PSTATE 0x3c5

  The ESR indicates that a synchronous external abort has occurred.
  ESR EC field: 0b100101

  From the ARMv8 technical manual: Data Abort taken without a change in
  Exception level. Used for MMU faults generated by data accesses,
  alignment faults other than those caused by Stack Pointer
  misalignment, and synchronous External aborts, including synchronous
  parity or ECC errors. Not used for debug related exceptions.

  ESR ISS field: 0b10000

  From the ARMv8 technical manual: Synchronous External abort, not on
  translation table walk or hardware update of translation table.

  The following command line is used to invoke qemu:
  qemu-system-aarch64 -machine virt -cpu cortex-a53 -m 256M -no-reboot -nog=
raphic -serial mon:stdio -kernel build/aarch64/a53_ilp32_qemu/testsuites/ps=
xtests/psxndbm01.exe -D qemu.log -d in_asm,int,cpu_reset,unimp,guest_errors

  This occurs on Qemu 3.1.0 as distributed via Debian and on Qemu 4.1 as
  built by the RTEMS source builder (4.1+minor patches).

  Edit: This bug can be worked around by getting and setting SCTLR
  without changing its value before each data abort would occur. This
  test needs 6 of these workarounds to operate successfully.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1887854/+subscriptions

