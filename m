Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F5AC47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 03:47:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18D5D20862
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 03:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D5D20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGEYY-0005L5-Ex
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 23:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iGEVw-0003nA-HP
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 23:44:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iGEVu-0001lw-Mf
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 23:44:20 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:2522)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iGEVu-0001i2-32
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 23:44:18 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1]) by
 rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee95d96c006d8c-b2cfe;
 Fri, 04 Oct 2019 11:44:07 +0800 (CST)
X-RM-TRANSID: 2ee95d96c006d8c-b2cfe
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from maozy-host.lan (unknown[180.108.8.156])
 by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee15d96bff81ac-a1b04;
 Fri, 04 Oct 2019 11:44:07 +0800 (CST)
X-RM-TRANSID: 2ee15d96bff81ac-a1b04
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/3] tests/migration: fix a typo in comment
Date: Fri,  4 Oct 2019 11:43:47 +0800
Message-Id: <927b1b1f9365e0d5d9683746b498c16b88405174.1570159624.git.maozhongyi@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1570159624.git.maozhongyi@cmss.chinamobile.com>
References: <cover.1570159624.git.maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
In-Reply-To: <cover.1570159624.git.maozhongyi@cmss.chinamobile.com>
References: <cover.1570159624.git.maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 221.176.66.81
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
Cc: tony.nguyen@bt.com, alex.bennee@linaro.org, armbru@redhat.com,
 Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 tests/migration/stress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/migration/stress.c b/tests/migration/stress.c
index 9e128eef50..debf34359f 100644
--- a/tests/migration/stress.c
+++ b/tests/migration/stress.c
@@ -191,7 +191,7 @@ static int stressone(unsigned long long ramsizeMB)
 
     /* We don't care about initial state, but we do want
      * to fault it all into RAM, otherwise the first iter
-     * of the loop below will be quite slow. We cna't use
+     * of the loop below will be quite slow. We can't use
      * 0x0 as the byte as gcc optimizes that away into a
      * calloc instead :-) */
     memset(ram, 0xfe, ramsizeMB * 1024 * 1024);
-- 
2.17.1




