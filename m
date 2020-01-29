Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8F2C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 18:37:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA82F20708
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 18:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA82F20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwsD2-00022d-Ra
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 13:37:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iwsAm-00065y-OM
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 13:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iwsAl-0003hT-OX
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 13:34:44 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:33030 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iwsAl-0003ft-HO
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 13:34:43 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 653941A1FAD;
 Wed, 29 Jan 2020 19:34:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 4E8241A1CEF;
 Wed, 29 Jan 2020 19:34:41 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/6] disas: Add a field for target-dependant data to
 disassemble_info
Date: Wed, 29 Jan 2020 19:34:13 +0100
Message-Id: <1580322857-14331-3-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580322857-14331-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1580322857-14331-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

This patch adds a field "target_info" to the structure
disassemble_info. The purpose of this field is to enable targets
to pass to disassembler code any additional data thet deem suitable.

Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1579883929-1517-6-git-send-email-aleksandar.markovic@rt-rk.com>
---
 include/disas/dis-asm.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
index e9c7dd8..f87f468 100644
--- a/include/disas/dis-asm.h
+++ b/include/disas/dis-asm.h
@@ -372,6 +372,9 @@ typedef struct disassemble_info {
   /* Command line options specific to the target disassembler.  */
   char * disassembler_options;
 
+  /* Field intended to be used by targets in any way they deem suitable.  */
+  int64_t target_info;
+
   /* Options for Capstone disassembly.  */
   int cap_arch;
   int cap_mode;
-- 
2.7.4


