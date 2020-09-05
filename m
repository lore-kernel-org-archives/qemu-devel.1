Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47362C43461
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 06:27:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C414B208DB
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 06:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGY3srBk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C414B208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kERfl-00042n-Tp
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 02:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kERcR-00076D-Ft; Sat, 05 Sep 2020 02:24:12 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:40465)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kERcP-0003Xd-AA; Sat, 05 Sep 2020 02:24:11 -0400
Received: by mail-pl1-x644.google.com with SMTP id z15so2124982plo.7;
 Fri, 04 Sep 2020 23:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=S0CdT7EJuAl1EvDXm+oKp2XSA+jKypIYBOFAUPRceZg=;
 b=AGY3srBkrJ8hAMq30GuKDomzi7MVozMGpAejXJis8rx7KAU2uM6a7XJklnKp21lZfY
 BnCRsGuGQqdjNZ2ESpJAdjsBYSwWiN3SbrbbhgmAM+ZntfEwHRWSqr7wqO6GFbUsFZKk
 S9mUqLjvP3/PfVfOYlUTVz/yGOOHBr/FWp2Dp7znmNys3ukt6bjnIk39SheXrrKsDN7e
 VoYsj98hgx4JzbtG70fqezXqQcH3+PF5MKH5JUNAfHuA1xG676OkMBTbMB+P6/xWdPIq
 /bJ0feoqOa1aQc5ZGkAjY1GokJ2OllQtIMJgLB7Kv+81h15KUqH3E40oXP5UkOWiB/Qt
 C+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S0CdT7EJuAl1EvDXm+oKp2XSA+jKypIYBOFAUPRceZg=;
 b=lbiW//b7Q3TyDBrVPt7N1vuX7y0m/9r0oZgYR7qCIon3RoQ/JLa6Vf32QdBqZ8Vkuh
 KTOs7eEKXNOW4InEcAqBThAmzD8E369G9PDKaABIzSwxBhCjL5/DaZOoX5bDo+tQjQww
 cX4hc4rimf5wuaBvmMfq5+C6YHzLl4iL2EEIkyz84XEsQN/W+pDYftEI6+oxFgyVlPNr
 Ud3ys54MNK53KUB2dbA/6DE5r177DgXT5ug9SLZtGnWPjyhWgvnbN2L2rFI4kphOcBl2
 +xCDPHAV2fhKY0aCiDeEwFQ/Hi8o+Z5C+dBnMZGEG4dx8Zyb3B1MdkHadnt9+QEDjxqs
 OPnA==
X-Gm-Message-State: AOAM533W5Ki6+pmp/eGIRKY6EctlWJA176gq53LiOlp4U5R1bOIuyLLU
 kbbsSNo6Hq9yJ92JIUD7AANpxH+vkBBqq7IC
X-Google-Smtp-Source: ABdhPJzj2rJz8oO4+aR3EzrqGR6k8EHpEZI4E/1qOHEKkVWkuQCbG4mxBOTOBHotdvmhQuvzQq1y6A==
X-Received: by 2002:a17:90b:4acd:: with SMTP id
 mh13mr11709545pjb.147.1599287047099; 
 Fri, 04 Sep 2020 23:24:07 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id v8sm21436381pju.1.2020.09.04.23.24.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 23:24:06 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 06/11] tests: Trying fixes test-replication.c on msys2.
Date: Sat,  5 Sep 2020 14:23:28 +0800
Message-Id: <20200905062333.1087-7-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200905062333.1087-1-luoyonggang@gmail.com>
References: <20200905062333.1087-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Block <qemu-block@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/test-replication.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tests/test-replication.c b/tests/test-replication.c
index 9ab3666a90..d0e06f8d77 100644
--- a/tests/test-replication.c
+++ b/tests/test-replication.c
@@ -23,14 +23,18 @@
 
 /* primary */
 #define P_ID "primary-id"
-static char p_local_disk[] = "/tmp/p_local_disk.XXXXXX";
+#define P_LOCAL_DISK "%s/p_local_disk.XXXXXX"
+static char p_local_disk[PATH_MAX];
 
 /* secondary */
 #define S_ID "secondary-id"
 #define S_LOCAL_DISK_ID "secondary-local-disk-id"
-static char s_local_disk[] = "/tmp/s_local_disk.XXXXXX";
-static char s_active_disk[] = "/tmp/s_active_disk.XXXXXX";
-static char s_hidden_disk[] = "/tmp/s_hidden_disk.XXXXXX";
+#define S_LOCAL_DISK "%s/s_local_disk.XXXXXX"
+static char s_local_disk[PATH_MAX];
+#define S_ACTIVE_DISK "%s/s_active_disk.XXXXXX"
+static char s_active_disk[PATH_MAX];
+#define S_HIDDEN_DISK "%s/s_hidden_disk.XXXXXX"
+static char s_hidden_disk[PATH_MAX];
 
 /* FIXME: steal from blockdev.c */
 QemuOptsList qemu_drive_opts = {
@@ -571,7 +575,12 @@ static void setup_sigabrt_handler(void)
 int main(int argc, char **argv)
 {
     int ret;
+    const char *tmpdir = g_get_tmp_dir();
     qemu_init_main_loop(&error_fatal);
+    sprintf(p_local_disk, P_LOCAL_DISK, tmpdir);
+    sprintf(s_local_disk, S_LOCAL_DISK, tmpdir);
+    sprintf(s_active_disk, S_ACTIVE_DISK, tmpdir);
+    sprintf(s_hidden_disk, S_HIDDEN_DISK, tmpdir);
     bdrv_init();
 
     g_test_init(&argc, &argv, NULL);
-- 
2.28.0.windows.1


