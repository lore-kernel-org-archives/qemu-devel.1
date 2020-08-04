Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC18C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 19:06:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D95AD2086A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 19:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95AD2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k32Gj-0006Yj-1x
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 15:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k32GA-00068W-So
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 15:06:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:41496)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k32G8-0004Jg-P1
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 15:06:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k32G5-0001Uq-MN
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 19:05:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 9E0622E8109
 for <qemu-devel@nongnu.org>; Tue,  4 Aug 2020 19:05:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2020 19:00:27 -0000
From: Julien Freche <1879587@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=In Progress; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: arm
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jfreche pmaydell
X-Launchpad-Bug-Reporter: Julien Freche (jfreche)
X-Launchpad-Bug-Modifier: Julien Freche (jfreche)
References: <158993429952.22373.5947926664408541430.malonedeb@wampee.canonical.com>
Message-Id: <159656762727.3307.10681427266283405211.malone@gac.canonical.com>
Subject: [Bug 1879587] Re: Register number in ESR is incorrect for certain
 banked registers when switching from AA32 to AA64
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 479a02cd1917b8bfa5d7efe15e5c68ab8c19aef8
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 15:05:58
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
Reply-To: Bug 1879587 <1879587@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Unfortunately, I won't be able to send the code or binary for the
hypervisor as of now (it will become available at some point in the
future though). I've done a bit of debugging on the QEMU code and it
seems like the approach you are taking works fine in general but the
register mapping code doesn't seem quite right. Applying this patch (on
top of yours):

>From e2182581dcdeedc2cb88cd21b88b4db744677737 Mon Sep 17 00:00:00 2001
From: Julien Freche <julien@bedrocksystems.com>
Date: Tue, 4 Aug 2020 11:54:49 -0700
Subject: [PATCH] Possible fix

---
 target/arm/helper.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 60b80228fd..455c92b891 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9619,17 +9619,16 @@ static int aarch64_regnum(CPUARMState *env, int aar=
ch32_reg)
         switch (mode) {
         case ARM_CPU_MODE_USR:
         case ARM_CPU_MODE_SYS:
-            return 14;
         case ARM_CPU_MODE_HYP:
-            return 16;
+            return 14;
         case ARM_CPU_MODE_IRQ:
-            return 18;
+            return 16;
         case ARM_CPU_MODE_SVC:
-            return 20;
+            return 18;
         case ARM_CPU_MODE_ABT:
-            return 22;
+            return 20;
         case ARM_CPU_MODE_UND:
-            return 24;
+            return 22;
         case ARM_CPU_MODE_FIQ:
             return 30;
         default:
-- =

2.28.0

Based on the ARM documentation, I would think that LR_svc maps to X18,
not X20. I fixed the ones that seemed wrong but I haven't check every
possible case so you may want to double check this. With the patch I was
able to boot Linux correctly.

Let me know if that makes sense

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1879587

Title:
  Register number in ESR is incorrect for certain banked registers when
  switching from AA32 to AA64

Status in QEMU:
  In Progress

Bug description:
  I am running into a situation where I have:
  - A hypervisor running in EL2, AA64
  - A guest running in EL1, AA32

  We trap certain accesses to special registers such as DACR (via
  HCR.TVM). One instruction that is trapped is:

  ee03ef10  ->    mcr     15, 0, lr, cr3, cr0, {0}

  The guest is running in SVC mode. So, LR should refer to LR_svc there.
  LR_svc is mapped to X18 in AA64. So, ESR should reflect that. However,
  the actual ESR value is: 0xfe00dc0

  If we decode the 'rt':
  >>> (0xfe00dc0 >> 5) & 0x1f
  14

  My understanding is that 14 is incorrect in the context of AA64. rt
  should be set to 18. The current mode being SVC, LR refers to LR_svc
  not LR_usr. In other words, the mapping between registers in AA64 and
  AA32 doesn't seem to be accounted for. I've tested this with Qemu
  5.0.0

  Let me know if that makes sense and if you would like more info. I am als=
o happy to test patches.
  Thanks for all the great work on Qemu!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1879587/+subscriptions

