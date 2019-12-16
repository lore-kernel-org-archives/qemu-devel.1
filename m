Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E31C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:58:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAF1D206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZC3DGLH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF1D206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igthJ-0007al-8i
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 11:58:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFO-0005TF-Ui
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFN-0008Bk-Rc
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:26 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51526)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtFN-0008AF-Ku
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:25 -0500
Received: by mail-wm1-x343.google.com with SMTP id d73so7442287wmd.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6P+O7fP7RdRxtrVlibSaBNIUsO6tN03n2SE/FwGlPpk=;
 b=XZC3DGLH7mD2D6Ov17IfdNUjwwHtiaAxWokeXKTpnrYblSxYPjvgQVQbxpxae/tZmP
 fz/wCpjENNCg383tZ8bya3zYZNFhoeO0DxKL7PPB6j4njVyelnvi+gVPP7RAE6Biul0A
 9S79ZTf5PBem3BlKPuAfV7s/FudJJh6iRfxqPdt/k9QrP7+sPwq+3+S0G/9XmDJ15Uw/
 Wlxn6E/1DZ2bp6MIGz1HurmbpKftfe6k7+Syt9BMYCu/IizL/J+jaCy5cPnaqktkL3sj
 gtnf+rvcNsRYNru5poc8dPx+5twTaOoa5826P+EQEexiFIRv0KScm4gU3vfruAFtr6PG
 C+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=6P+O7fP7RdRxtrVlibSaBNIUsO6tN03n2SE/FwGlPpk=;
 b=EsvQq5BEga7iL2O4dD+Xr58Zb1HIFEfRm6549oL7dQrD9m6FTHA7M/jbzG2TKaT+pH
 qlTQ8FQ7y4YpEqBDuG+fhhfI3HXwvgL+ytegY5jpiiu9HfAUzLQ0PZgS4pz9E6TVUitT
 LSA/P+zeeHb4K+hhAfeZ14OjCFYBrQ3B4RXx8zyPrcG+8nl3uxDyIi7HQ4KxOlNpwjnz
 yLhPVVuibx13272DrhbvZ3NtGeEG5zxOpTUcfEaYICB+KcTBIObrHrXzET6+THiGzSpA
 hshUyzBvtmXCVQcK7BVdkTPfrFc8uwZwsVZ3SMSenq4dKXtodjQz31Em6PxZ1qZKzeoS
 ol5Q==
X-Gm-Message-State: APjAAAVUa36gzSyREWQgz7CSgFWOxxfcNT+mKZuWgV9tm9gn/tY+nb3D
 BLOrhrvmWLcQHKxyz3Q3fbRN3i3Q
X-Google-Smtp-Source: APXvYqyBCsKVypV4RKf5k1wegG9Dbpb/4umYuP+1VGpQ96ucG+EQzRwoP/H+N3e6EmlpjIt0RkjPLQ==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr31378772wmj.96.1576513764441; 
 Mon, 16 Dec 2019 08:29:24 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 37/62] os-posix: simplify os_find_datadir
Date: Mon, 16 Dec 2019 17:28:21 +0100
Message-Id: <1576513726-53700-38-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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



