Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6C0C76199
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 21:40:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DFA82084E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 21:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFA82084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3Reh-0005aD-QK
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 16:40:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j3Rdy-0004bU-Bs
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:40:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j3Rdw-0001aw-PQ
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:40:01 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:30206)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1j3Rdw-0001OH-Il; Sun, 16 Feb 2020 16:40:00 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 8E116747DFE;
 Sun, 16 Feb 2020 22:39:51 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 15C2A747DCF; Sun, 16 Feb 2020 22:39:51 +0100 (CET)
Message-Id: <5b50e9e7eec2c383ae878b397d0b2927efc9ea43.1581888834.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1581888834.git.balaton@eik.bme.hu>
References: <cover.1581888834.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sun, 16 Feb 2020 22:23:54 +0100
Subject: [PATCH 1/2] target/ppc/cpu.h: Move fpu related members closer in cpu
 env
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move fp_status and fpscr closer to other floating point and vector
related members in cpu env definition so they are in one group.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/cpu.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 07dd2b4da7..c3b0a00064 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -997,11 +997,6 @@ struct CPUPPCState {
     /* temporary general purpose registers */
     target_ulong tgpr[4]; /* Used to speed-up TLB assist handlers */
 
-    /* Floating point execution context */
-    float_status fp_status;
-    /* floating point status and control register */
-    target_ulong fpscr;
-
     /* Next instruction pointer */
     target_ulong nip;
 
@@ -1060,6 +1055,10 @@ struct CPUPPCState {
      * used simultaneously
      */
     float_status vec_status;
+    /* Floating point execution context */
+    float_status fp_status;
+    /* floating point status and control register */
+    target_ulong fpscr;
 
     /* Internal devices resources */
     /* Time base and decrementer */
-- 
2.21.1


