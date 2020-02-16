Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E86FC7619B
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 23:06:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2661620675
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 23:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2661620675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3Szx-0004n5-Cr
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 18:06:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j3Syq-0003vE-JE
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 18:05:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j3Syo-0002dj-S7
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 18:05:40 -0500
Received: from indium.canonical.com ([91.189.90.7]:57414)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j3Syo-0002bS-MW
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 18:05:38 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j3Syn-0006Ku-Ts
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 23:05:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E00272E80C0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 23:05:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Feb 2020 22:56:27 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1863526@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: arm nvic
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <158189363238.15370.16875925531014106433.malonedeb@soybean.canonical.com>
Message-Id: <158189378718.30775.4013963498557864681.malone@wampee.canonical.com>
Subject: [Bug 1863526] Re: NVIC CCR register not 8-bit accessible using
 Cortex-M4
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="19413b719a8df7423ab1390528edadce9e0e4aca";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 786fd2fa330c757c9159e398124b4d558e5bd8ef
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
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
Reply-To: Bug 1863526 <1863526@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I am not sure this register can not be accessed differently than 32-bit.
Still I used this patch as a kludge, but it doesn't seem a clean fix:

-- >8 --
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2160,6 +2161,10 @@ static MemTxResult nvic_sysreg_read(void *opaque, hw=
addr addr,
             }
         }
         break;
+    case 0xd14 ... 0xd17: /* Configuration and Control Register */
+        val =3D extract32(nvic_readl(s, offset & ~3, attrs),
+                        (offset - 0xd14) * 8, size * 8);
+        break;
     case 0xd18 ... 0xd1b: /* System Handler Priority (SHPR1) */
         if (!arm_feature(&s->cpu->env, ARM_FEATURE_M_MAIN)) {
             val =3D 0;
@@ -2282,6 +2287,11 @@ static MemTxResult nvic_sysreg_write(void *opaque, h=
waddr addr,
         }
         nvic_irq_update(s);
         goto exit_ok;
+    case 0xd14 ... 0xd17: /* Configuration and Control Register */
+        value =3D deposit32(value, (offset - 0xd14) * 8, size * 8,
+                          nvic_readl(s, offset & ~3, attrs));
+        nvic_writel(s, offset & ~3, value, attrs);
+        goto exit_ok;
     case 0xd18 ... 0xd1b: /* System Handler Priority (SHPR1) */
         if (!arm_feature(&s->cpu->env, ARM_FEATURE_M_MAIN)) {
             goto exit_ok;
---

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1863526

Title:
  NVIC CCR register not 8-bit accessible using Cortex-M4

Status in QEMU:
  New

Bug description:
  Head at commit b29c3e23f64938.

  Running with '-d unimp,guest_errors -trace nvic\*' I get:

  8871@1581892794.295746:nvic_sysreg_read NVIC sysreg read addr 0xd88 data =
0xf00000 size 4
  8871@1581892794.295752:nvic_sysreg_write NVIC sysreg write addr 0xd88 dat=
a 0xf00000 size 4
  8871@1581892794.297780:nvic_sysreg_write NVIC sysreg write addr 0xd08 dat=
a 0x4200 size 4
  8871@1581892794.298040:nvic_sysreg_write NVIC sysreg write addr 0xd15 dat=
a 0x0 size 1
  NVIC: Bad write of size 1 at offset 0xd15
  8871@1581892794.298081:nvic_sysreg_write NVIC sysreg write addr 0xd16 dat=
a 0x0 size 1
  NVIC: Bad write of size 1 at offset 0xd16
  8871@1581892794.298116:nvic_sysreg_write NVIC sysreg write addr 0xd17 dat=
a 0x0 size 1
  NVIC: Bad write of size 1 at offset 0xd17
  8871@1581892794.298156:nvic_sysreg_write NVIC sysreg write addr 0xd18 dat=
a 0x0 size 1
  8871@1581892794.298161:nvic_set_prio NVIC set irq 4 secure-bank 0 priorit=
y 0
  8871@1581892794.298164:nvic_recompute_state NVIC state recomputed: vectpe=
nding 0 vectpending_prio 256 exception_prio 256
  8871@1581892794.298168:nvic_irq_update NVIC vectpending 0 pending prio 25=
6 exception_prio 256: setting irq line to 0
  8871@1581892794.298201:nvic_sysreg_write NVIC sysreg write addr 0xd19 dat=
a 0x0 size 1
  8871@1581892794.298206:nvic_set_prio NVIC set irq 5 secure-bank 0 priorit=
y 0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1863526/+subscriptions

