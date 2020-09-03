Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC982C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:14:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B3DB20716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWxcHhti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3DB20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDxUv-0001io-Mx
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 18:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDxNy-0006rD-Qo
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 18:07:14 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33072)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDxNu-0007UO-Cp
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 18:07:14 -0400
Received: by mail-pf1-x444.google.com with SMTP id u20so3462903pfn.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 15:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=S0CdT7EJuAl1EvDXm+oKp2XSA+jKypIYBOFAUPRceZg=;
 b=nWxcHhtim+SJ0TqIpLvEQNeKszcNMKWmh2fb+avlWbUhavvyzvPa4n3jZoRH8Y8Prw
 FTTjfXBcYAAmXq7t1ilzbpq3+w4gBDDpaiVDbrqYynSiAMB5JCgdrcqw0y2//NQ4fVs9
 gZ/rXVV1lsXhegA7dLNMtAk+hQ1FA3W9zb7J12nEYNuPMR/nHuHRsTtITz0uhOmbFNhS
 9f/b9kQ1iLRveFdMAsxGo4PQohqV9M32cFgsT5LpLvMKGJBt7zcQCBNEJp/YyIoiO0hu
 OmVGKiHO1Jp8tzDpjzLgXyMUvho73xZwgffJ6Q7j+zZNwio1TjFdRE8o/cFW6hKzlpzl
 NoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=S0CdT7EJuAl1EvDXm+oKp2XSA+jKypIYBOFAUPRceZg=;
 b=AlRWKphqg3I8TH5vWBgmjOSl3ZoKSNdXB2cKODDrH8SXzJQZV/7OesLCoZ4ctKrnWE
 zNS7muASvzT413S8rCBRVYDby2+KgPNQI2LKBxB/cCprMXRhHa7Adn0cqAAaY9SAWPQn
 FbNJYbRGwMtVLK48nzuN4XImMdhQmtIzp6SIlmkFSneWZobnfZC7OFEx6G6DQGU7UDgs
 AVjdkSTThUXt6ediUrIY4RjtHkqvjfl6FZK/1pBcdMljhg9laei1O4pOx1uJu8f1nI+v
 Xml7hHCmQEAC6YbE2wuzxDvWwkdUQFoVyeL2ZW7bmdnO5AGryfm5aX/RSZYppr4ODWQO
 jRPg==
X-Gm-Message-State: AOAM5326/6tfYJASmv7yJdfft7V3pEsdVpM2jUMXrlqGmr6mtwsljweV
 Aq/yBXQe2h9Xf0N8NAXRT6sWTw4FQJIIbw==
X-Google-Smtp-Source: ABdhPJwfPsblUJqDec1QCC5LY9ewDiTXTxtCSnaEqx24ODuYNo2mHNCWjPqYX6glLwJcx9b4PqFhLQ==
X-Received: by 2002:a17:902:bcc5:b029:d0:89f3:28d0 with SMTP id
 o5-20020a170902bcc5b02900d089f328d0mr4309862pls.12.1599170828517; 
 Thu, 03 Sep 2020 15:07:08 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id g5sm4393218pfh.168.2020.09.03.15.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 15:07:07 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] tests: Trying fixes test-replication.c on msys2.
Date: Fri,  4 Sep 2020 06:06:55 +0800
Message-Id: <20200903220655.1333-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x444.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
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


