Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E79C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 307FA206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miA0lScl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307FA206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYJj-0004CV-Re
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:20:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3D-0006QG-D7
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3C-0000s2-3r
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:35 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45881)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY3B-0000oB-M4
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:33 -0500
Received: by mail-wr1-x442.google.com with SMTP id j42so1973029wrj.12
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6P+O7fP7RdRxtrVlibSaBNIUsO6tN03n2SE/FwGlPpk=;
 b=miA0lSclqjGTCqb16hKq7TUktdbqTH6EHMZ0cO9YhwK56Tet4Lpkad0yOMsLx3o35B
 EbPjQmLDuREmFaFc5yblwlVZWLTMo6l3c7ggiTUEusGORrmb3Y/3WYaUWkdGsEbTuu5U
 mXh7BPUqnuR0ueMPyXVrIMrJE4ppSal7s03CquV8N4PfJ1UQezfnSNrOw5V6lDzZ7RIw
 rE16sda+6sJwEyNKXI4ZcQk/1jMtKwJO88kMLvEDq/HR8Ags07+9as3xTVyAIax32h6v
 9jL6yu4g0Pcy2kdJqjWEEsEaDYSLC+UoelYWVrD1l0YCZU3yjnVoj+cn1DM07wdFUplF
 uHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=6P+O7fP7RdRxtrVlibSaBNIUsO6tN03n2SE/FwGlPpk=;
 b=M+JgVYP595UoQPOlJx9Z5tj42srwJLLp1CrFlLN+Tdf38ZUfCQLXgT1S3w9sXgje+6
 I66bcf/oonU5VclmPGdKUEOv1jKkxd/3He5ujn+FXk2F7zZeKrmP/BkkD/m7Pfpg36P8
 kBLyzqElK9vedO0ZuUBJ7qWa1GdKtxGtm1KAIe2i1DgI2rip1k7mBM7whh5mZkhs/v7Z
 9YcOB208V5xhd4mTKqZLnZeZTYZ7MhB2ImFVTQvlDpseSqUKR5HWDEmANw+tVIxtN2gb
 H6i9r75NW5k05k+nFEFX9MJjr6cDzf3BHs5eEL+7i1xPQn+urrjl1GkXVtQ51bGiK8iK
 rbqQ==
X-Gm-Message-State: APjAAAVP6dor6LT2jugh9rprRSpt0kdPfOIhDsJxebCsgOF3hf6FJknM
 TvP1WnJO+0K/LXk4RdMXHbx8QUJV
X-Google-Smtp-Source: APXvYqxoQCnU/nZNlnbJF3WG5vf098NEyOV8+e4CbePt/kVlJvX8VOvZm1T6AWMumYA5rSrXynUJ8g==
X-Received: by 2002:a5d:50cf:: with SMTP id f15mr2430490wrt.381.1576670612469; 
 Wed, 18 Dec 2019 04:03:32 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:31 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 37/87] os-posix: simplify os_find_datadir
Date: Wed, 18 Dec 2019 13:02:03 +0100
Message-Id: <1576670573-48048-38-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Use g_build_filename instead of sprintf, and g_autofree instead of
manual freeing.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 os-posix.c | 41 +++++++++++++----------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/os-posix.c b/os-posix.c
index 86cffd2..3cd52e1 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -80,41 +80,26 @@ void os_setup_signal_handling(void)
     sigaction(SIGTERM, &act, NULL);
 }
 
-/* Find a likely location for support files using the location of the binary.
-   For installed binaries this will be "$bindir/../share/qemu".  When
-   running from the build tree this will be "$bindir/../pc-bios".  */
-#define SHARE_SUFFIX "/share/qemu"
-#define BUILD_SUFFIX "/pc-bios"
+/*
+ * Find a likely location for support files using the location of the binary.
+ * When running from the build tree this will be "$bindir/../pc-bios".
+ * Otherwise, this is CONFIG_QEMU_DATADIR.
+ */
 char *os_find_datadir(void)
 {
-    char *dir, *exec_dir;
-    char *res;
-    size_t max_len;
+    g_autofree char *exec_dir = NULL;
+    g_autofree char *dir = NULL;
 
     exec_dir = qemu_get_exec_dir();
-    if (exec_dir == NULL) {
-        return NULL;
-    }
-    dir = g_path_get_dirname(exec_dir);
-
-    max_len = strlen(dir) +
-        MAX(strlen(SHARE_SUFFIX), strlen(BUILD_SUFFIX)) + 1;
-    res = g_malloc0(max_len);
-    snprintf(res, max_len, "%s%s", dir, SHARE_SUFFIX);
-    if (access(res, R_OK)) {
-        snprintf(res, max_len, "%s%s", dir, BUILD_SUFFIX);
-        if (access(res, R_OK)) {
-            g_free(res);
-            res = NULL;
-        }
+    g_return_val_if_fail(exec_dir != NULL, NULL);
+
+    dir = g_build_filename(exec_dir, "..", "pc-bios", NULL);
+    if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
+        return g_steal_pointer(&dir);
     }
 
-    g_free(dir);
-    g_free(exec_dir);
-    return res;
+    return g_strdup(CONFIG_QEMU_DATADIR);
 }
-#undef SHARE_SUFFIX
-#undef BUILD_SUFFIX
 
 void os_set_proc_name(const char *s)
 {
-- 
1.8.3.1



