Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29933C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 22:06:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE32A206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 22:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE32A206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsaGG-0007n4-UB
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 18:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42859)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hsZs3-0004Ba-1W
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 17:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hsZs0-00035z-T9
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 17:41:22 -0400
Received: from indium.canonical.com ([91.189.90.7]:48072)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hsZrr-0002ze-G0
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 17:41:14 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hsZrX-0001Uz-ES
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 21:40:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6BD802E80C9
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 21:40:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jul 2019 21:32:12 -0000
From: KD <buckfobb@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: buckfobb
X-Launchpad-Bug-Reporter: KD (buckfobb)
X-Launchpad-Bug-Modifier: KD (buckfobb)
Message-Id: <156452233283.15483.3370838341008169030.malonedeb@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19012";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 1236ba116782d3d81e09d7c95e5d4ddf9ca965ef
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Tue, 30 Jul 2019 18:04:22 -0400
Subject: [Qemu-devel] [Bug 1838475] [NEW] qemu-system-arm exits when
 cortex-m4 floating point used and irq occurs
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
Reply-To: Bug 1838475 <1838475@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

qemu-system-arm exits with

"...Secure UsageFault with CFSR.NOCP because NSACR.CP10 prevents stacking F=
P regs
...taking pending nonsecure exception 3
Taking exception 7 [Breakpoint]
qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)" =


when emulating Cortex-m4, executing at least 1 floating point
instruction, and then an irq (e.g. sys tick) occurring.

CPACR.CP10 and CPACR.CP11 are set to 0x3 respectively prior to executing
the fp instructions.

NOTE: NSACR does not appear to be a cortex m4 register.

Attached is a simplified elf to repro the issue.

The qemu command line is: "qemu-system-arm --gdb tcp::1234 -cpu
cortex-m4 -machine lm3s6965evb -nographic -semihosting-config
enable=3Don,target=3Dnative -kernel QemuExitWhenUsingFPAndIRQOccurs.elf -d
int"

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "QemuExitWhenUsingFPAndIRQOccurs.elf"
   https://bugs.launchpad.net/bugs/1838475/+attachment/5280090/+files/QemuE=
xitWhenUsingFPAndIRQOccurs.elf

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1838475

Title:
  qemu-system-arm exits when cortex-m4 floating point used and irq
  occurs

Status in QEMU:
  New

Bug description:
  qemu-system-arm exits with

  "...Secure UsageFault with CFSR.NOCP because NSACR.CP10 prevents stacking=
 FP regs
  ...taking pending nonsecure exception 3
  Taking exception 7 [Breakpoint]
  qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)" =


  when emulating Cortex-m4, executing at least 1 floating point
  instruction, and then an irq (e.g. sys tick) occurring.

  CPACR.CP10 and CPACR.CP11 are set to 0x3 respectively prior to
  executing the fp instructions.

  NOTE: NSACR does not appear to be a cortex m4 register.

  Attached is a simplified elf to repro the issue.

  The qemu command line is: "qemu-system-arm --gdb tcp::1234 -cpu
  cortex-m4 -machine lm3s6965evb -nographic -semihosting-config
  enable=3Don,target=3Dnative -kernel QemuExitWhenUsingFPAndIRQOccurs.elf -d
  int"

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1838475/+subscriptions

