Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67A2C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:29:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75645206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sgr4c1ga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75645206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7af-0004mQ-JC
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43808)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hs7Pq-0007aw-Fj
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:18:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hs7Pp-0008CP-BF
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:18:22 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:40019)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hs7Pp-00087l-5Z; Mon, 29 Jul 2019 11:18:21 -0400
Received: by mail-pf1-x444.google.com with SMTP id p184so28192982pfp.7;
 Mon, 29 Jul 2019 08:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LR9iVRChMwWQAhc5h02KM+c31gdyfKaD2veUCMmmXek=;
 b=Sgr4c1gaaymXX9q50sFv4ldrhDJdicYmnBDuitQlWwDxPKGeQXC7go2X8lOnyaY9We
 8sc68s3aplsAN+f6K5B5uZWCk4elVDYV/B703KFq7Xh8x9bOM0hWtyjSBjM5vzzvBjB6
 v5Cwn9Q4d1bjw0YrLHQ57pu+klxj6yjC+LAzK0ZNRcZ3lYU5zlVj8w/Tp+qaDU7AwZ/l
 5iKk3niFMKzvIYIyCWaxhBYQfxzgeL10vaZyrYyBsDqiV2jFiv9rMJ8kAZ3sWUxbg0Au
 BItDzZY53OTiga11ZC72O+OazQyktYtK1feGmqwJHUakJvmMx3hBRTiv6tFGcWlFQw6p
 5qtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LR9iVRChMwWQAhc5h02KM+c31gdyfKaD2veUCMmmXek=;
 b=HgYczwJSejJfj6QOEyr/pVaAB95VJIDN79eyJuqzfIc7ZeFx/8XSDmE8doni0lBLQM
 6t00fVTEmVijhtuykd6OOHChAFaA1QeU3GojHsfidZnY2qS9sWrvWnvpyvIqrXpJhe88
 5SFicWTx/LIKjJQs9pZh9piKU2HZd3Zo18tk3fMmlaunW47Utej9r1mikGSrBEjXfhxV
 O+8HwUVuAzbuqrlia0zsSbBOGx/8P91i1SYQDdL94T9RiQgCaYRoaJ1FHHeQ8DV/bW49
 XRBJd+zFWEczJalnpUdjvjv8rZbe6adqgyVe8apc27Hq4Yt4TzuRRhP1vf/Y46YYK0Wm
 l5lw==
X-Gm-Message-State: APjAAAUl52ORJ7NpNv4g1EB3ChpjKtPtrlyBZH9WwF4NuZIduHrf2DO/
 +luY7aAhpzKjhYW2I/moA2qlW3iVTWiIKg==
X-Google-Smtp-Source: APXvYqw8cZH38oX1QNztMZ9AX7tTFRbv/Mh3dNgH7okgmRCZk9gl0YLlCbggnTZoQUkps/4k0BpGaA==
X-Received: by 2002:aa7:97bb:: with SMTP id d27mr36899936pfq.93.1564413499891; 
 Mon, 29 Jul 2019 08:18:19 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.97])
 by smtp.gmail.com with ESMTPSA id h129sm58693941pfb.110.2019.07.29.08.18.11
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 29 Jul 2019 08:18:19 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 20:46:43 +0530
Message-Id: <20190729151651.21306-8-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729151651.21306-1-mehta.aaru20@gmail.com>
References: <20190729151651.21306-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v7 07/15] blockdev: adds bdrv_parse_aio to use
 io_uring
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 saket.sinha89@gmail.com, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block.c               | 22 ++++++++++++++++++++++
 blockdev.c            | 12 ++++--------
 include/block/block.h |  1 +
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/block.c b/block.c
index cbd8da5f3b..401831e28d 100644
--- a/block.c
+++ b/block.c
@@ -844,6 +844,28 @@ static BlockdevDetectZeroesOptions bdrv_parse_detect_zeroes(QemuOpts *opts,
     return detect_zeroes;
 }
 
+/**
+ * Set open flags for aio engine
+ *
+ * Return 0 on success, -1 if the engine specified is invalid
+ */
+int bdrv_parse_aio(const char *mode, int *flags)
+{
+    if (!strcmp(mode, "threads")) {
+        /* do nothing, default */
+    } else if (!strcmp(mode, "native")) {
+        *flags |= BDRV_O_NATIVE_AIO;
+#ifdef CONFIG_LINUX_IO_URING
+    } else if (!strcmp(mode, "io_uring")) {
+        *flags |= BDRV_O_IO_URING;
+#endif
+    } else {
+        return -1;
+    }
+
+    return 0;
+}
+
 /**
  * Set open flags for a given discard mode
  *
diff --git a/blockdev.c b/blockdev.c
index 4d141e9a1f..a41623ae9a 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -383,13 +383,9 @@ static void extract_common_blockdev_options(QemuOpts *opts, int *bdrv_flags,
         }
 
         if ((aio = qemu_opt_get(opts, "aio")) != NULL) {
-            if (!strcmp(aio, "native")) {
-                *bdrv_flags |= BDRV_O_NATIVE_AIO;
-            } else if (!strcmp(aio, "threads")) {
-                /* this is the default */
-            } else {
-               error_setg(errp, "invalid aio option");
-               return;
+            if (bdrv_parse_aio(aio, bdrv_flags) < 0) {
+                error_setg(errp, "invalid aio option");
+                return;
             }
         }
     }
@@ -4574,7 +4570,7 @@ QemuOptsList qemu_common_drive_opts = {
         },{
             .name = "aio",
             .type = QEMU_OPT_STRING,
-            .help = "host AIO implementation (threads, native)",
+            .help = "host AIO implementation (threads, native, io_uring)",
         },{
             .name = BDRV_OPT_CACHE_WB,
             .type = QEMU_OPT_BOOL,
diff --git a/include/block/block.h b/include/block/block.h
index e29baa172c..ec6b9ea4c8 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -297,6 +297,7 @@ void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
 void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
                        Error **errp);
 
+int bdrv_parse_aio(const char *mode, int *flags);
 int bdrv_parse_cache_mode(const char *mode, int *flags, bool *writethrough);
 int bdrv_parse_discard_flags(const char *mode, int *flags);
 BdrvChild *bdrv_open_child(const char *filename,
-- 
2.21.0


