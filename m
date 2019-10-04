Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC44DC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 03:48:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD0A220862
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 03:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0A220862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGEaG-0007L8-Ro
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 23:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iGEW0-0003pH-Ug
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 23:44:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iGEVy-0001r4-Rt
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 23:44:24 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:6351)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iGEVx-0001js-Sf
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 23:44:22 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1]) by
 rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee25d96c007f64-b2faf;
 Fri, 04 Oct 2019 11:44:08 +0800 (CST)
X-RM-TRANSID: 2ee25d96c007f64-b2faf
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from maozy-host.lan (unknown[180.108.8.156])
 by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee15d96bff81ac-a1b07;
 Fri, 04 Oct 2019 11:44:08 +0800 (CST)
X-RM-TRANSID: 2ee15d96bff81ac-a1b07
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/3] =?UTF-8?q?tests/migration=EF=BC=9Afix=20unreachabl?=
 =?UTF-8?q?e=20path=20in=20stress=20test?=
Date: Fri,  4 Oct 2019 11:43:48 +0800
Message-Id: <4d7e66c152fad6230978619000766fa4d01db078.1570159624.git.maozhongyi@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1570159624.git.maozhongyi@cmss.chinamobile.com>
References: <cover.1570159624.git.maozhongyi@cmss.chinamobile.com>
In-Reply-To: <cover.1570159624.git.maozhongyi@cmss.chinamobile.com>
References: <cover.1570159624.git.maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 221.176.66.79
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
type to void and stress should always return -1 to make the
path of 'if (stress(ramsizeGB, ncpus) < 0)' can be reached.

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
---
 tests/migration/stress.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tests/migration/stress.c b/tests/migration/stress.c
index debf34359f..b0df1323bb 100644
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
@@ -181,12 +181,12 @@ static int stressone(unsigned long long ramsizeMB)
     if (!ram) {
         fprintf(stderr, "%s (%05d): ERROR: cannot allocate %llu MB of RAM: %s\n",
                 argv0, gettid(), ramsizeMB, strerror(errno));
-        return -1;
+        return;
     }
     if (!data) {
         fprintf(stderr, "%s (%d): ERROR: cannot allocate %d bytes of RAM: %s\n",
                 argv0, gettid(), PAGE_SIZE, strerror(errno));
-        return -1;
+        return;
     }
 
     /* We don't care about initial state, but we do want
@@ -197,7 +197,7 @@ static int stressone(unsigned long long ramsizeMB)
     memset(ram, 0xfe, ramsizeMB * 1024 * 1024);
 
     if (random_bytes(data, PAGE_SIZE) < 0) {
-        return -1;
+        return;
     }
 
     before = now();
@@ -250,7 +250,7 @@ static int stress(unsigned long long ramsizeGB, int ncpus)
 
     stressone(ramsizeMB);
 
-    return 0;
+    return -1;
 }
 
 
@@ -348,6 +348,4 @@ int main(int argc, char **argv)
 
     if (stress(ramsizeGB, ncpus) < 0)
         exit_failure();
-
-    exit_success();
 }
-- 
2.17.1




