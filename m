Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE44C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 19:51:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 719E520787
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 19:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 719E520787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw9ui-00087B-On
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 15:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jw9tw-0007gy-Ro
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 15:50:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:48080)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jw9tu-0004p2-Jv
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 15:50:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jw9ts-00019s-IN
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 19:50:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 817252E80ED
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 19:50:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2020 19:36:17 -0000
From: K <1887854@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: opticron
X-Launchpad-Bug-Reporter: K (opticron)
X-Launchpad-Bug-Modifier: K (opticron)
Message-Id: <159492817809.19148.14056725236873205625.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1887854] [NEW] Spurious Data Abort on qemu-system-aarch64
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="4809fcb62f445aaa3ae919f7f6c3cc7d156ea57a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 78b61502a63dd6a7d94a11485280db1d7ca1eead
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 15:50:36
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

Public bug reported:

When running RTEMS test psxndbm01.exe built for AArch64-ilp32 (this code is=
 not yet publically available), the test generates a spurious data abort (t=
he MMU and alignment checks should be disabled according to bits 1, 0 of SC=
TLR_EL1). The abort information is as follows:
Taking exception 4 [Data Abort]
...from EL1 to EL1
...with ESR 0x25/0x96000010
...with FAR 0x104010ca28
...with ELR 0x400195d8
...to EL1 PC 0x40018200 PSTATE 0x3c5

The ESR indicates that a synchronous external abort has occurred.
ESR EC field: 0b100101

>From the ARMv8 technical manual: Data Abort taken without a change in
Exception level. Used for MMU faults generated by data accesses,
alignment faults other than those caused by Stack Pointer misalignment,
and synchronous External aborts, including synchronous parity or ECC
errors. Not used for debug related exceptions.

ESR ISS field: 0b10000

>From the ARMv8 technical manual: Synchronous External abort, not on
translation table walk or hardware update of translation table.

The following command line is used to invoke qemu:
qemu-system-aarch64 -machine virt -cpu cortex-a53 -m 256M -no-reboot -nogra=
phic -serial mon:stdio -kernel build/aarch64/a53_ilp32_qemu/testsuites/psxt=
ests/psxndbm01.exe -D qemu.log -d in_asm,int,cpu_reset,unimp,guest_errors

This occurs on Qemu 3.1.0 as distributed via Debian and on Qemu 4.1 as
built by the RTEMS source builder (4.1+minor patches).

Edit: This bug can be worked around by getting and setting SCTLR without
changing its value.

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "Qemu execution log and binary"
   https://bugs.launchpad.net/bugs/1887854/+attachment/5393233/+files/data_=
abort.tar.gz

** Description changed:

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
  =

  The ESR indicates that a synchronous external abort has occurred.
  ESR EC field: 0b100101
  =

  From the ARMv8 technical manual: Data Abort taken without a change in
  Exception level. Used for MMU faults generated by data accesses,
  alignment faults other than those caused by Stack Pointer misalignment,
  and synchronous External aborts, including synchronous parity or ECC
  errors. Not used for debug related exceptions.
  =

  ESR ISS field: 0b10000
  =

  From the ARMv8 technical manual: Synchronous External abort, not on
  translation table walk or hardware update of translation table.
  =

  The following command line is used to invoke qemu:
  qemu-system-aarch64 -machine virt -cpu cortex-a53 -m 256M -no-reboot -nog=
raphic -serial mon:stdio -kernel build/aarch64/a53_ilp32_qemu/testsuites/ps=
xtests/psxndbm01.exe -D qemu.log -d in_asm,int,cpu_reset,unimp,guest_errors
  =

  This occurs on Qemu 3.1.0 as distributed via Debian and on Qemu 4.1 as
  built by the RTEMS source builder (4.1+minor patches).
+ =

+ Edit: This bug can be worked around by getting and setting SCTLR without
+ changing its value.

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
  without changing its value.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1887854/+subscriptions

