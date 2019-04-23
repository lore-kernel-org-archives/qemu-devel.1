Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFA6C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 11:38:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F6252077C
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 11:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6252077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52158 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hItlI-00073w-QZ
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 07:38:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hItdb-0001do-Ia
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hItda-0005Xv-An
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:30:59 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45020 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hItda-0005WR-3z
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:30:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 91D891A1E4D;
	Tue, 23 Apr 2019 13:29:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
	[10.10.13.43])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 696B71A243C;
	Tue, 23 Apr 2019 13:29:53 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Tue, 23 Apr 2019 13:29:40 +0200
Message-Id: <1556018982-3715-7-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556018982-3715-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1556018982-3715-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH 6/8] target/mips: Clean up lmi_helper.c
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
Message-ID: <20190423112940.4a3ptway7R0f13OYPw9qmhFFEOghxcJboXb5VJ9zOlY@z>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Remove several minor checkpatch warnings and errors.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/lmi_helper.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/mips/lmi_helper.c b/target/mips/lmi_helper.c
index fb1245b..6c645cf 100644
--- a/target/mips/lmi_helper.c
+++ b/target/mips/lmi_helper.c
@@ -21,9 +21,11 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 
-/* If the byte ordering doesn't matter, i.e. all columns are treated
-   identically, then this union can be used directly.  If byte ordering
-   does matter, we generally ignore dumping to memory.  */
+/*
+ * If the byte ordering doesn't matter, i.e. all columns are treated
+ * identically, then this union can be used directly.  If byte ordering
+ * does matter, we generally ignore dumping to memory.
+ */
 typedef union {
     uint8_t  ub[8];
     int8_t   sb[8];
-- 
2.7.4


