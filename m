Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2279AC282DD
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 11:35:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D77522077C
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 11:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77522077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52096 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIthi-0004OL-5S
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 07:35:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hItda-0001cx-7P
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hItdZ-0005Vv-3l
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:30:58 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:41186 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hItdY-0004BG-TK
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:30:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 8175E1A245B;
	Tue, 23 Apr 2019 13:29:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
	[10.10.13.43])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 549CA1A1E4D;
	Tue, 23 Apr 2019 13:29:53 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Tue, 23 Apr 2019 13:29:38 +0200
Message-Id: <1556018982-3715-5-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556018982-3715-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1556018982-3715-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH 4/8] target/mips: Add * to comments and realign
 them to fix checkpatch warnings
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190423112938.zxtWdW15YZTQX3m8ulMn2XoWGXvx4Avlv4UhCIEpMpw@z>

From: Jules Irenge <jbi.octave@gmail.com>

Add * to comments and realign to fix warnings issued by checkpatch.pl
tool "WARNING: Block comments use a leading /* on a separate line"
within the file target/mips/cp0_timer.c.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <20190327181650.23992-1-jbi.octave@gmail.com>
---
 target/mips/cp0_timer.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/target/mips/cp0_timer.c b/target/mips/cp0_timer.c
index 742f4b2..d80b007 100644
--- a/target/mips/cp0_timer.c
+++ b/target/mips/cp0_timer.c
@@ -42,8 +42,10 @@ uint32_t cpu_mips_get_random(CPUMIPSState *env)
 
     /* Don't return same value twice, so get another value */
     do {
-        /* Use a simple algorithm of Linear Congruential Generator
-         * from ISO/IEC 9899 standard. */
+        /*
+         * Use a simple algorithm of Linear Congruential Generator
+         * from ISO/IEC 9899 standard.
+         */
         seed = 1103515245 * seed + 12345;
         idx = (seed >> 16) % nb_rand_tlb + env->CP0_Wired;
     } while (idx == prev_idx);
@@ -143,9 +145,11 @@ static void mips_timer_cb(void *opaque)
     if (env->CP0_Cause & (1 << CP0Ca_DC))
         return;
 
-    /* ??? This callback should occur when the counter is exactly equal to
-       the comparator value.  Offset the count by one to avoid immediately
-       retriggering the callback before any virtual time has passed.  */
+    /*
+     * ??? This callback should occur when the counter is exactly equal to
+     * the comparator value.  Offset the count by one to avoid immediately
+     * retriggering the callback before any virtual time has passed.
+     */
     env->CP0_Count++;
     cpu_mips_timer_expire(env);
     env->CP0_Count--;
-- 
2.7.4


