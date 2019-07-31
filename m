Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EB1C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 09:26:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B75720693
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 09:26:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B75720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsks2-0005QG-Oo
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 05:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60689)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hskrX-0004Zs-Jw
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 05:25:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hskrW-0001oS-Iz
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 05:25:35 -0400
Received: from indium.canonical.com ([91.189.90.7]:33652)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hskrW-0001oA-DD
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 05:25:34 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hskrV-0003Da-AZ
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:25:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1B5D02E8019
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:25:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 31 Jul 2019 09:20:12 -0000
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: arm mprofile tcg testcase
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: buckfobb
X-Launchpad-Bug-Reporter: KD (buckfobb)
X-Launchpad-Bug-Modifier: =?utf-8?q?Alex_Benn=C3=A9e_=28ajbennee=29?=
References: <156452233283.15483.3370838341008169030.malonedeb@wampee.canonical.com>
Message-Id: <156456481256.15599.6617072288313710395.launchpad@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19012";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 55c24c09740501755c161b44f7b23117d096e663
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1838475] Re: qemu-system-arm exits when cortex-m4
 floating point used and irq occurs
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

** Tags added: arm mprofile tcg

** Tags added: testcase

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

