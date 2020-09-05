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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29ADC433E2
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 21:13:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 529EE20709
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 21:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2pfd2z6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 529EE20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEfUf-000701-CN
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 17:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kEfSg-0005Fj-9d; Sat, 05 Sep 2020 17:11:02 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:38491)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kEfSd-0006dd-4R; Sat, 05 Sep 2020 17:11:00 -0400
Received: by mail-pl1-x642.google.com with SMTP id c3so2452296plz.5;
 Sat, 05 Sep 2020 14:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RYTSwUG4Szrk3/bEJFR9FTm/dK9H9YQKE9Ykyfw7eKM=;
 b=e2pfd2z620LYxvunSr0XzhlsQuKep439VY5cl7KQ9w88eInCUDM2g42HHf7WxB/6f6
 BaJS75/cfnU06sHNJHKNQVgyApeLFIiutAnswR+W1iU+uS1S6ltNK5Tbb249/z12OnR3
 hUjRzV7BArr2iQ4TwgSULpdgwNCEpH+CmoT3gLleIdqQebXBU5kYgWSTOvMtb0wr3ABZ
 U8T6+l2KkymgahnrdjFbKC2uNP6RP4mGq+PxUbZUAL/dq0vXmcJWMhbi+aDOXKmqccZh
 BX2gapLTml5rEiMrR32J2mkS9UPnv1ZVhAFmGW+5dx5DqK4t1NUMRF3oxM6VBSjAfq0y
 isRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RYTSwUG4Szrk3/bEJFR9FTm/dK9H9YQKE9Ykyfw7eKM=;
 b=po3jm3JrzotqJPfsloc6d5oY5Qb8ve7tZ8Q3EwFTBpgp6iU/UwKbRPC3B8+BCtETlu
 +ids+exH8ouH/b9ndt0AuoXipAwvhOpxr7pfqEYISNehaTozK4dl1n4NyxNfKTFT92j1
 9hzYh09GjJrxo0RAAAN8jJf6kovgIytx8/v0D5oS7pQMDADu+K+61t1MZMtka8E+jjbo
 olpf+7Z+KJ40PQlQQ1/U9uNDfqjSCfdD6xGDpqVUOjJLiQANa1nI4rseA5UnlEL570cf
 e0OgP9sCmE8z690k+hsuWT7pyfre0PtafA1zlHAUrVh7Maznlkb7cG/c5qVHuI3jNiju
 ZM1g==
X-Gm-Message-State: AOAM530EGrq6Z7rswLQMKEhHTwLqQ7bQ7/hcQ2BRQYU24K26u5fuPVqq
 pcH9uxk7YOCK5Bq6y1DfZai9QZXgLm2FM2Kq
X-Google-Smtp-Source: ABdhPJyV12iqHkme4UCSfdR/Nwh24V4zZIF7D/R8U/qY6ptViKE2gKRnU6ED77pCZAwTfUVZsbsqiA==
X-Received: by 2002:a17:90a:4687:: with SMTP id
 z7mr6881443pjf.144.1599340256797; 
 Sat, 05 Sep 2020 14:10:56 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id k88sm8576010pjk.19.2020.09.05.14.10.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2020 14:10:56 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] tests: Trying fixes test-replication.c on msys2/mingw.
Date: Sun,  6 Sep 2020 05:10:37 +0800
Message-Id: <20200905211038.904-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200905211038.904-1-luoyonggang@gmail.com>
References: <20200905211038.904-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x642.google.com
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
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Wen Congyang <wencongyang2@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Windows there is no path like /tmp/s_local_disk.XXXXXX

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/test-replication.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tests/test-replication.c b/tests/test-replication.c
index 9ab3666a90..3cf544a133 100644
--- a/tests/test-replication.c
+++ b/tests/test-replication.c
@@ -23,14 +23,14 @@
 
 /* primary */
 #define P_ID "primary-id"
-static char p_local_disk[] = "/tmp/p_local_disk.XXXXXX";
+static char p_local_disk[PATH_MAX];
 
 /* secondary */
 #define S_ID "secondary-id"
 #define S_LOCAL_DISK_ID "secondary-local-disk-id"
-static char s_local_disk[] = "/tmp/s_local_disk.XXXXXX";
-static char s_active_disk[] = "/tmp/s_active_disk.XXXXXX";
-static char s_hidden_disk[] = "/tmp/s_hidden_disk.XXXXXX";
+static char s_local_disk[PATH_MAX];
+static char s_active_disk[PATH_MAX];
+static char s_hidden_disk[PATH_MAX];
 
 /* FIXME: steal from blockdev.c */
 QemuOptsList qemu_drive_opts = {
@@ -571,6 +571,11 @@ static void setup_sigabrt_handler(void)
 int main(int argc, char **argv)
 {
     int ret;
+    const char *tmpdir = g_get_tmp_dir();
+    sprintf(p_local_disk, "%s/p_local_disk.XXXXXX", tmpdir);
+    sprintf(s_local_disk, "%s/s_local_disk.XXXXXX", tmpdir);
+    sprintf(s_active_disk, "%s/s_active_disk.XXXXXX", tmpdir);
+    sprintf(s_hidden_disk, "%s/s_hidden_disk.XXXXXX", tmpdir);
     qemu_init_main_loop(&error_fatal);
     bdrv_init();
 
-- 
2.28.0.windows.1


