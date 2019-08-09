Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E233C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 12:53:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7198620B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 12:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7198620B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw4Oe-0002aV-OZ
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 08:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52942)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hw4K0-0002Ft-6F
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 08:48:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hw4Jz-0001EX-7i
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 08:48:40 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:52524 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hw4Jy-000193-ST
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 08:48:39 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 3C5FF1A2087;
 Fri,  9 Aug 2019 14:48:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 09C8C1A1E5E;
 Fri,  9 Aug 2019 14:48:25 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Fri,  9 Aug 2019 14:46:46 +0200
Message-Id: <1565354819-1495-14-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565354819-1495-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1565354819-1495-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH for 4.2 v7 13/26] target/mips: Style
 improvements in mips_int.c
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
Cc: arikalo@wavecomp.com, philmd@redhat.com, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Fixes mostly errors and warnings reported by 'checkpatch.pl -f'.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 hw/mips/mips_int.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
index f899f6c..4c731ab 100644
--- a/hw/mips/mips_int.c
+++ b/hw/mips/mips_int.c
@@ -35,8 +35,9 @@ static void cpu_mips_irq_request(void *opaque, int irq, int level)
     CPUState *cs = CPU(cpu);
     bool locked = false;
 
-    if (irq < 0 || irq > 7)
+    if (irq < 0 || irq > 7) {
         return;
+    }
 
     /* Make sure locking works even if BQL is already held by the caller */
     if (!qemu_mutex_iothread_locked()) {
-- 
2.7.4


