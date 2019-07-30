Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C246DC0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:38:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9523F2087F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljNqGT0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9523F2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsW4r-0007zD-TK
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 13:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35686)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hsW2l-00056p-Pi
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hsW2i-0000I7-F8
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:36:11 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36270)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hsW2i-0000GV-9I; Tue, 30 Jul 2019 13:36:08 -0400
Received: by mail-pf1-x444.google.com with SMTP id r7so30210150pfl.3;
 Tue, 30 Jul 2019 10:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LR9iVRChMwWQAhc5h02KM+c31gdyfKaD2veUCMmmXek=;
 b=ljNqGT0v88BWGitSuQxQKxdBATRBE7iYjEir8Vzs1vhSMHNf2w/PO7Raw/WOOJwSLS
 g9jDSKkHIwHx2dBRvRPLnZN4I4hIHzMoUV6U6RsZHvwM3D4DAEB+VfEY9qHpxqEKb4sV
 vK9CnjGxN71EdBlec9/WEQJSmFeS9fz29L+UMq6o/NeFEFaqenwxO63b0LjdLEI0uMU0
 /Emh1a6wMmmRDNlZwg9VfpFOwwX2slLdUTwaSOQpjzakGCzW8ql7zwzBx1F8iOffj0w9
 bFsGfTRX7npRHqbDQc1H18xMy8aCS3Ecil+2sKuiq5HdzHBqxA/cvCRvFfErFkMceLls
 53rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LR9iVRChMwWQAhc5h02KM+c31gdyfKaD2veUCMmmXek=;
 b=OlVYX9mUsn1F+4o/Kil3iALxtOpqH6tkfxOx3Cde640DARtjRJ4SLr4LYGT6YhcJhS
 ys6VFSvqPGGLol1MVY/Shpfg82XXN4t6YU4a+HuxAo/AB48G40FMyZh1TWiUMdlNClit
 yn/ZNo+uXN/ZnIL3lIUFIrAjx85ZmersVJFI0oRuy3VmDPrGhNJenEJuy42WLzqFdVDI
 gBvqa3k7su/t2l3HqEcj34/I7TOujDvfHyCpG575oFGXbGfz6c+RW7Hf+KaHqftC4Yjp
 FOgSl5LC9MlcCpW+ZmsZIDKVyv0SEnoky1w0wjwars4/EJ40KynPgIaoSTgF5bJ3AmBG
 B0Kg==
X-Gm-Message-State: APjAAAXeoptLn+CaLFdRFDBTNd0hiEjPWj70pZVMo2+Qut+oa3RqksVw
 kmtcgnpw9BZRrGvZCZHR19a9ZxmpbIzHkw==
X-Google-Smtp-Source: APXvYqzw5R8eFhUbe7Q6LffvmT2UY0cd+SGO8NIhkQ1AG5GNq3pLAowycUwvGxiLCsBPeamWRZWZdQ==
X-Received: by 2002:a62:874d:: with SMTP id i74mr42127209pfe.94.1564508161933; 
 Tue, 30 Jul 2019 10:36:01 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.97])
 by smtp.gmail.com with ESMTPSA id q24sm59122895pjp.14.2019.07.30.10.35.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 30 Jul 2019 10:36:01 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 30 Jul 2019 23:04:32 +0530
Message-Id: <20190730173441.26486-8-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730173441.26486-1-mehta.aaru20@gmail.com>
References: <20190730173441.26486-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v8 07/16] blockdev: adds bdrv_parse_aio to use
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
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


