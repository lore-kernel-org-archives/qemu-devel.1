Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30A1C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 17:37:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 805382077B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 17:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 805382077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGRVt-0001Fz-PK
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 13:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iGRSU-0007nb-Lb
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 13:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iGRSR-0006co-Dw
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 13:33:37 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:2375)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iGRSP-0006a8-0L
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 13:33:34 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by
 rmmx-syy-dmz-app10-12010 (RichMail) with SMTP id 2eea5d97825004a-b8e93;
 Sat, 05 Oct 2019 01:33:06 +0800 (CST)
X-RM-TRANSID: 2eea5d97825004a-b8e93
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from maozy-host.lan (unknown[180.108.8.156])
 by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea5d978248272-cd7f0;
 Sat, 05 Oct 2019 01:33:05 +0800 (CST)
X-RM-TRANSID: 2eea5d978248272-cd7f0
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 3/3] =?UTF-8?q?tests/migration=EF=BC=9Afix=20unreachabl?=
 =?UTF-8?q?e=20path=20in=20stress=20test?=
Date: Sat,  5 Oct 2019 01:32:50 +0800
Message-Id: <8e28cb658bc89a14958e1a7e1073f8cda4349019.1570208781.git.maozhongyi@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1570208781.git.maozhongyi@cmss.chinamobile.com>
References: <cover.1570208781.git.maozhongyi@cmss.chinamobile.com>
In-Reply-To: <cover.1570208781.git.maozhongyi@cmss.chinamobile.com>
References: <cover.1570208781.git.maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
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

If stressone() or stress() exits it's because of a failure
because the test runs forever otherwise, so change stressone
and stress type to void to make the exit_failure() as the exit
function of main().

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
---
 tests/migration/stress.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/tests/migration/stress.c b/tests/migration/stress.c
index f9626d50ee..a062ef6b55 100644
--- a/tests/migration/stress.c
+++ b/tests/migration/stress.c
@@ -167,7 +167,7 @@ static unsigned long long now(void)
     return (tv.tv_sec * 1000ull) + (tv.tv_usec / 1000ull);
 }
 
-static int stressone(unsigned long long ramsizeMB)
+static void stressone(unsigned long long ramsizeMB)
 {
     size_t pagesPerMB = 1024 * 1024 / PAGE_SIZE;
     g_autofree char *ram = g_malloc(ramsizeMB * 1024 * 1024);
@@ -186,7 +186,7 @@ static int stressone(unsigned long long ramsizeMB)
     memset(ram, 0xfe, ramsizeMB * 1024 * 1024);
 
     if (random_bytes(data, PAGE_SIZE) < 0) {
-        return -1;
+        return;
     }
 
     before = now();
@@ -225,7 +225,7 @@ static void *stressthread(void *arg)
     return NULL;
 }
 
-static int stress(unsigned long long ramsizeGB, int ncpus)
+static void stress(unsigned long long ramsizeGB, int ncpus)
 {
     size_t i;
     unsigned long long ramsizeMB = ramsizeGB * 1024 / ncpus;
@@ -238,8 +238,6 @@ static int stress(unsigned long long ramsizeGB, int ncpus)
     }
 
     stressone(ramsizeMB);
-
-    return 0;
 }
 
 
@@ -335,8 +333,7 @@ int main(int argc, char **argv)
     fprintf(stdout, "%s (%05d): INFO: RAM %llu GiB across %d CPUs\n",
             argv0, gettid(), ramsizeGB, ncpus);
 
-    if (stress(ramsizeGB, ncpus) < 0)
-        exit_failure();
+    stress(ramsizeGB, ncpus);
 
-    exit_success();
+    exit_failure();
 }
-- 
2.17.1




