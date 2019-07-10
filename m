Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29901C74A36
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 17:36:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0343C208C4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 17:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0343C208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlGVv-0002no-QE
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 13:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51096)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hlGQU-00010F-DQ
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 13:30:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hlGQT-0007Gd-7R
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 13:30:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:55018)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hlGQT-0007Fu-1o
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 13:30:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hlGQS-0004bX-9I
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 17:30:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 430FC2E80CB
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 17:30:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jul 2019 17:24:37 -0000
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=In Progress; importance=Undecided;
 assignee=alex.bennee@linaro.org; 
X-Launchpad-Bug-Tags: arm testcase
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ajbennee christophe-lyon
X-Launchpad-Bug-Reporter: Christophe Lyon (christophe-lyon)
X-Launchpad-Bug-Modifier: =?utf-8?q?Alex_Benn=C3=A9e_=28ajbennee=29?=
References: <156277131341.2267.3199507288563083183.malonedeb@wampee.canonical.com>
Message-Id: <20190710172437.628-1-alex.bennee@linaro.org>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19007";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 854f0f6f70d91f5f03d6144746cfe0b5d199e219
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1836078] [PATCH for 4.1] target/arm: report
 ARMv8.2 FP16 for ARM -cpu max
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
Reply-To: Bug 1836078 <1836078@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190710172437.REoKtKHtUf66Ym6-UECjj1b5aMure2PVVwZUI89OtGQ@z>

When we converted to using feature bits in 602f6e42cfbf we missed out
the fact (dp && arm_dc_feature(s, ARM_FEATURE_V8)) was supported for
-cpu max configurations. This caused a regression in the GCC test
suite. Fix this by setting the appropriate FP16 bits in mvfr1.FPHP.

Fixes: https://bugs.launchpad.net/qemu/+bug/1836078
Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
---
 target/arm/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e75a64a25a..0a0a202fe3 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2452,6 +2452,10 @@ static void arm_max_initfn(Object *obj)
             t =3D FIELD_DP32(t, ID_ISAR6, SPECRES, 1);
             cpu->isar.id_isar6 =3D t;
 =

+            t =3D cpu->isar.mvfr1;
+            t =3D FIELD_DP32(t, MVFR1, FPHP, 2);     /* v8.2 FP16 */
+            cpu->isar.mvfr1 =3D t;
+
             t =3D cpu->isar.mvfr2;
             t =3D FIELD_DP32(t, MVFR2, SIMDMISC, 3); /* SIMD MaxNum */
             t =3D FIELD_DP32(t, MVFR2, FPMISC, 4);   /* FP MaxNum */
-- =

2.20.1

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1836078

Title:
  Regressions on arm-linux-gnueabihf target with some GCC tests

Status in QEMU:
  In Progress

Bug description:
  Hi,

  After trying qemu master:
  commit 474f3938d79ab36b9231c9ad3b5a9314c2aeacde
  Merge: 68d7ff0 14f5d87
  Author: Peter Maydell <email address hidden>
  Date: Fri Jun 21 15:40:50 2019 +0100

  even with the fix for https://bugs.launchpad.net/qemu/+bug/1834496,
  I've noticed several regressions compared to qemu-3.1 when running the GC=
C testsuite.
  I'm attaching a tarball containing several GCC tests (binaries), needed s=
hared libs, and a short script to run all the tests.

  All tests used to pass w/o error, but with a recent qemu, all of them
  make qemu crash.

  This was noticed with GCC master configured with
  --target arm-none-linux-gnueabihf
  --with-cpu cortex-a57
  --with-fpu crypto-neon-fp-armv8

  Thanks

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1836078/+subscriptions

