Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE149C352A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 01:51:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81B2720724
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 01:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B2720724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j23fP-0005OZ-Na
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 20:51:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1j23bd-0005y4-77
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 20:47:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1j23bc-0004Vo-52
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 20:47:53 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:40553 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1j23bb-0004Tl-U6
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 20:47:52 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 08DF51A1FF3;
 Thu, 13 Feb 2020 02:46:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id D2FEF1A2152;
 Thu, 13 Feb 2020 02:46:47 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 9/9] linux-user: xtensa: Remove unused constant
 TARGET_NR_syscall_count
Date: Thu, 13 Feb 2020 02:46:33 +0100
Message-Id: <1581558393-9182-10-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581558393-9182-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1581558393-9182-1-git-send-email-aleksandar.markovic@rt-rk.com>
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, laurent@vivier.eu,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Currently, there is no usage of TARGET_NR_syscall_count for target
xtensa, and there is no obvious indication if there is some planned
usage in future.

CC: Max Filippov <jcmvbkbc@gmail.com>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/xtensa/syscall_nr.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/linux-user/xtensa/syscall_nr.h b/linux-user/xtensa/syscall_nr.h
index 3d19d0c..39bff65 100644
--- a/linux-user/xtensa/syscall_nr.h
+++ b/linux-user/xtensa/syscall_nr.h
@@ -466,6 +466,4 @@
 #define TARGET_NR_pidfd_open                         434
 #define TARGET_NR_clone3                             435
 
-#define TARGET_NR_syscall_count                      436
-
 #endif /* XTENSA_SYSCALL_NR_H */
-- 
2.7.4


