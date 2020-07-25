Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25DFC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 02:56:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5344206EB
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 02:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5344206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzAMG-0007qh-UD
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 22:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jzALa-00075L-41
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 22:55:38 -0400
Received: from indium.canonical.com ([91.189.90.7]:53048)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jzALY-0008I1-33
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 22:55:37 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jzALW-0000Ro-V1
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2020 02:55:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E74B22E806D
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2020 02:55:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2020 02:47:49 -0000
From: Matthieu Bucchianeri <1888918@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: floating ppc spe
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: matthieu-bucchianeri
X-Launchpad-Bug-Reporter: Matthieu Bucchianeri (matthieu-bucchianeri)
X-Launchpad-Bug-Modifier: Matthieu Bucchianeri (matthieu-bucchianeri)
References: <159564442748.29789.2028598939567190639.malonedeb@chaenomeles.canonical.com>
Message-Id: <159564526948.4278.11772086539548531559.malone@wampee.canonical.com>
Subject: [Bug 1888918] Re: qemu-ppc: Floating point instructions do not
 properly generate the SPE/Embedded Floating-Point Unavailable interrupt
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e85d0ab92e2924d39b8285aeae075a01d25eff06";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 6a4cc4f401adf62fae67af807e2c5e39ecf04dc5
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 22:40:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1888918 <1888918@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Attaching the output of the test module (above) when run on a real
MPC8548. This is to establish a baseline validating which instructions
shall or shall not generate the SPE/Embedded Floating-Point Unavailable
interrupt.

Note that on the MPC8548, it is observed that the "brinc" instruction
does generate the interrupt, which contradicts section 4.2.3
SPE/Embedded Floating-Point Unavailable Interrupt of the Signal
Processing Engine (SPE) Programming Environments Manual, Rev. 0 (see the
quote in the description). The test program was modified to pass 100% on
real hardware, hence claiming that "brinc" shall generate the interrupt.

** Attachment added: "Results on real hardware (MPC8548)"
   https://bugs.launchpad.net/qemu/+bug/1888918/+attachment/5395640/+files/=
result_mpc8548.txt

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1888918

Title:
  qemu-ppc: Floating point instructions do not properly generate the
  SPE/Embedded Floating-Point Unavailable interrupt

Status in QEMU:
  New

Bug description:
  When emulating certain floating point instructions or vector
  instructions on PowerPC machines, QEMU does not properly generate the
  SPE/Embedded Floating-Point Unavailable interrupt.

  As described in the Signal Processing Engine (SPE) Programming
  Environments Manual, Rev. 0, available at https://www.nxp.com/docs/en
  /reference-manual/SPEPEM.pdf:

  > An SPE/embedded floating-point unavailable exception occurs on an attem=
pt to execute any of the
  > following instructions and MSR[SPV] is not set:
  > * SPE instruction (except brinc)
  > * An embedded scalar double-precision instruction
  > * A vector single-precision floating-point instructions
  > It is not used by embedded scalar single-precision floating-point instr=
uctions

  This behavior was partially reported in Bug #1611394, however the
  issue is larger than what is described in that bug. As mentioned in
  that bug, some single-precision instructions generate the exception
  (while they should not), which is incorrect but does not typically
  produce an incorrect output. What is more of an issue is that several
  double-precision and vector instructions do not generate the exception
  (while they should), and this break support for lazy FPU/vector
  context switching in Linux (for example).

  The upper 32-bit of the double-precision/vector registers (which are
  in fact hidden in the general purpose registers) is not properly
  saved/restored, and this causes arithmetic errors. This was observed
  very frequently on a commercial project that does a lot of double-
  precision computations. The application works perfectly fine on an
  MPC8548 CPU, but fails often with QEMU.

  The issue can be reproduced using the attached Linux program "spe-
  bug.c". This program properly prints the number 42 (as the result of
  some very simple double-precision computation) on real PowerPC
  hardware, but prints an incorrect result (typically 0) on QEMU.

  This issue was first discovered in an older version of QEMU, but is
  also reproduced in the latest:

  # git rev-parse HEAD
  7adfbea8fd1efce36019a0c2f198ca73be9d3f18
  # ppc-softmmu/qemu-system-ppc --version
  QEMU emulator version 5.0.91 (v5.1.0-rc1-28-g7adfbea8fd-dirty)
  Copyright (c) 2003-2020 Fabrice Bellard and the QEMU Project developers

  Upon further analysis a total of 39 instructions are misbehaving:

  efsabs: raised: 1, expected: 0
  efsnabs: raised: 1, expected: 0
  efsneg: raised: 1, expected: 0
  efdcfs: raised: 0, expected: 1
  efdcfsf: raised: 0, expected: 1
  efdcfsi: raised: 0, expected: 1
  efdcfuf: raised: 0, expected: 1
  efdcfui: raised: 0, expected: 1
  efdctsf: raised: 0, expected: 1
  efdctsi: raised: 0, expected: 1
  efdctsiz: raised: 0, expected: 1
  efdctuf: raised: 0, expected: 1
  efdctui: raised: 0, expected: 1
  efdctuiz: raised: 0, expected: 1
  efscfd: raised: 0, expected: 1
  evfscfsf: raised: 0, expected: 1
  evfscfsi: raised: 0, expected: 1
  evfscfuf: raised: 0, expected: 1
  evfscfui: raised: 0, expected: 1
  evfsctsf: raised: 0, expected: 1
  evfsctsi: raised: 0, expected: 1
  evfsctsiz: raised: 0, expected: 1
  evfsctuf: raised: 0, expected: 1
  evfsctui: raised: 0, expected: 1
  evfsctuiz: raised: 0, expected: 1
  brinc: raised: 0, expected: 1
  efsadd: raised: 1, expected: 0
  efsdiv: raised: 1, expected: 0
  efsmul: raised: 1, expected: 0
  efssub: raised: 1, expected: 0
  evsplatfi: raised: 0, expected: 1
  evsplati: raised: 0, expected: 1
  efscmpeq: raised: 1, expected: 0
  efscmpgt: raised: 1, expected: 0
  efscmplt: raised: 1, expected: 0
  efststeq: raised: 1, expected: 0
  efststgt: raised: 1, expected: 0
  efststlt: raised: 1, expected: 0
  evsel: raised: 0, expected: 1

  When "raised" is 0 and "expected" is 1, this means that the SPE/Embedded =
Floating-Point Unavailable interrupt was not generated while it should have.
  When "raised" is 1 and "expected" is 0, this means that the SPE/Embedded =
Floating-Point Unavailable interrupt was generated while it should not have=
 (Bug #1611394).

  A comprehensive program testing all the instructions listed in the
  Signal Processing Engine (SPE) Programming Environments Manual, Rev. 0
  is posted in the comments of this ticket, and can be used to reproduce
  the issue, and validate the future fix.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1888918/+subscriptions

