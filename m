Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536DEC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 14:04:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BDC82083E
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 14:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7rPsJjW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BDC82083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCkPx-0003yz-9Z
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 10:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1kCkNR-0001Z0-2U; Mon, 31 Aug 2020 10:01:41 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35789)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1kCkNO-0005Rq-LS; Mon, 31 Aug 2020 10:01:40 -0400
Received: by mail-wm1-x344.google.com with SMTP id o21so5427720wmc.0;
 Mon, 31 Aug 2020 07:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CxVi3AwzX6wIEGts+Qx2coeo7yCmSP7/IF+d/L8k3BM=;
 b=c7rPsJjWpEeXVO4uVAIk79AqHacG3klAN6NI5+BuOI/rxSL4zkvTh3a51wgdLzeAZR
 OGLEv7Vb3tawX9GfwkXS502hXz6rAS35VQXDFyBTWr75gElHlLKTX58F3+cxXRgZg0h0
 +zIkirU/TqyZmfVtREHc7DWwatAnF4j/MW/uDFlVL+DYum1BPomL5cg13MtbM9BhFfz0
 qA6qCs6h8lwtyagxZbwAwA3yl8OTLT4EaP7/J9924eCnbSoDJMpmnPMG5Q+LW2uyRrn7
 D07gRQ0AMqW2yhAmnwYQKU4K9Bib3wPt0W8QPoINSKQd5RG2HxFZ1SzTGfxVjGUyUJpc
 BavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CxVi3AwzX6wIEGts+Qx2coeo7yCmSP7/IF+d/L8k3BM=;
 b=Pr5nVDFgjZ+SwGQtpVrl6plcDRFv7kZ4bZLdwFBHPnKxrKgfnmt/BBxozAIVnC7fQF
 CKYqa80sv0C6rU6VwIS9VxlxLewiYIFM2M5VqNhTcvS266ATq84jrMJRU2yi0816qhNE
 XUYesQAZ1j4u9rrPM8yGKk7Kx2XK35i4oYcNm2u+p625+fY8CqCgDIh+5dPfRndV7Bg3
 T3V6uNrPHFzLWqQ/A/qw2/yGKckA6aF9St1pWNb2Sqp7g/MBenDwnhMs5Q5AJ5MoEroH
 XHGPRxeiKZ6JNceDm6TugLvgnRsyfLS16L/Bnu4GwRFvdELSoFPTGwTw3iqRuR09k/5S
 62Tw==
X-Gm-Message-State: AOAM533Kia34u8mIa9cD4Wg7i238pctJSBHYyMy5pvSUA6O0/iLcoWbn
 KFRneTYvsbQdSEIGpthdzEsbrv288qG866mO
X-Google-Smtp-Source: ABdhPJxkaHCLMG1nHD1HOldcLB3hqbSOgp1OTw5zi8G4B6rAV/Bhxd2IPjhUcQXLxgg/ptlYCE+kXA==
X-Received: by 2002:a7b:c055:: with SMTP id u21mr1423972wmc.64.1598882495596; 
 Mon, 31 Aug 2020 07:01:35 -0700 (PDT)
Received: from localhost.localdomain (109-186-204-55.bb.netvision.net.il.
 [109.186.204.55])
 by smtp.gmail.com with ESMTPSA id q192sm12413320wme.13.2020.08.31.07.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 07:01:35 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] block: file-posix: Replace posix_fallocate with fallocate
Date: Mon, 31 Aug 2020 17:01:27 +0300
Message-Id: <20200831140127.657134-3-nsoffer@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200831140127.657134-1-nsoffer@redhat.com>
References: <20200831140127.657134-1-nsoffer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=nirsof@gmail.com; helo=mail-wm1-x344.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If fallocate() is not supported, posix_fallocate() falls back to
inefficient allocation, writing one byte for every 4k bytes[1]. This is
very slow compared with writing zeros. In oVirt we measured ~400%
improvement in allocation time when replacing posix_fallocate() with
manually writing zeroes[2].

We also know that posix_fallocated() does not work well when using OFD
locks[3]. We don't know the reason yet for this issue yet.

Change preallocate_falloc() to use fallocate() instead of
posix_falloate(), and fall back to full preallocation if not supported.

Here are quick test results with this change.

Before (qemu-img-5.1.0-2.fc32.x86_64):

$ time qemu-img create -f raw -o preallocation=falloc /tmp/nfs3/test.raw 6g
Formatting '/tmp/nfs3/test.raw', fmt=raw size=6442450944 preallocation=falloc

real 0m42.100s
user 0m0.602s
sys 0m4.137s

NFS stats:
calls      retrans    authrefrsh    write
1571583    0          1572205       1571321

After:

$ time ./qemu-img create -f raw -o preallocation=falloc /tmp/nfs3/test.raw 6g
Formatting '/tmp/nfs3/test.raw', fmt=raw size=6442450944 preallocation=falloc

real 0m15.551s
user 0m0.070s
sys 0m2.623s

NFS stats:
calls      retrans    authrefrsh    write
24620      0          24624         24567  

[1] https://code.woboq.org/userspace/glibc/sysdeps/posix/posix_fallocate.c.html#96
[2] https://bugzilla.redhat.com/1850267#c25
[3] https://bugzilla.redhat.com/1851097

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
---
 block/file-posix.c                     | 32 +++++++++-----------------
 docs/system/qemu-block-drivers.rst.inc | 11 +++++----
 docs/tools/qemu-img.rst                | 11 +++++----
 qapi/block-core.json                   |  4 ++--
 4 files changed, 25 insertions(+), 33 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 341ffb1cb4..eac3c0b412 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1835,36 +1835,24 @@ static int allocate_first_block(int fd, size_t max_size)
 static int preallocate_falloc(int fd, int64_t current_length, int64_t offset,
                               Error **errp)
 {
-#ifdef CONFIG_POSIX_FALLOCATE
+#ifdef CONFIG_FALLOCATE
     int result;
 
     if (offset == current_length)
         return 0;
 
-    /*
-     * Truncating before posix_fallocate() makes it about twice slower on
-     * file systems that do not support fallocate(), trying to check if a
-     * block is allocated before allocating it, so don't do that here.
-     */
-
-    result = -posix_fallocate(fd, current_length,
-                              offset - current_length);
+    result = do_fallocate(fd, 0, current_length, offset - current_length);
     if (result != 0) {
-        /* posix_fallocate() doesn't set errno. */
-        error_setg_errno(errp, -result,
-                         "Could not preallocate new data");
+        error_setg_errno(errp, -result, "Could not preallocate new data");
         return result;
     }
 
     if (current_length == 0) {
         /*
-         * posix_fallocate() uses fallocate() if the filesystem supports
-         * it, or fallback to manually writing zeroes. If fallocate()
-         * was used, unaligned reads from the fallocated area in
-         * raw_probe_alignment() will succeed, hence we need to allocate
-         * the first block.
+         * Unaligned reads from the fallocated area in raw_probe_alignment()
+         * will succeed, hence we need to allocate the first block.
          *
-         * Optimize future alignment probing; ignore failures.
+         * Optimizes future alignment probing; ignore failures.
          */
         allocate_first_block(fd, offset);
     }
@@ -1973,10 +1961,12 @@ static int handle_aiocb_truncate(void *opaque)
     }
 
     switch (prealloc) {
-#ifdef CONFIG_POSIX_FALLOCATE
+#ifdef CONFIG_FALLOCATE
     case PREALLOC_MODE_FALLOC:
         result = preallocate_falloc(fd, current_length, offset, errp);
-        goto out;
+        if (result != -ENOTSUP)
+            goto out;
+        /* If fallocate() is not supported, fallback to full preallocation. */
 #endif
     case PREALLOC_MODE_FULL:
         result = preallocate_full(fd, current_length, offset, errp);
@@ -3080,7 +3070,7 @@ static QemuOptsList raw_create_opts = {
             .name = BLOCK_OPT_PREALLOC,
             .type = QEMU_OPT_STRING,
             .help = "Preallocation mode (allowed values: off"
-#ifdef CONFIG_POSIX_FALLOCATE
+#ifdef CONFIG_FALLOCATE
                     ", falloc"
 #endif
                     ", full)"
diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-block-drivers.rst.inc
index b052a6d14e..8e4acf397e 100644
--- a/docs/system/qemu-block-drivers.rst.inc
+++ b/docs/system/qemu-block-drivers.rst.inc
@@ -25,11 +25,12 @@ This section describes each format and the options that are supported for it.
   .. program:: raw
   .. option:: preallocation
 
-    Preallocation mode (allowed values: ``off``, ``falloc``,
-    ``full``). ``falloc`` mode preallocates space for image by
-    calling ``posix_fallocate()``. ``full`` mode preallocates space
-    for image by writing data to underlying storage. This data may or
-    may not be zero, depending on the storage location.
+    Preallocation mode (allowed values: ``off``, ``falloc``, ``full``).
+    ``falloc`` mode preallocates space for image by calling
+    ``fallocate()``, and falling back to ``full` mode if not supported.
+    ``full`` mode preallocates space for image by writing data to
+    underlying storage. This data may or may not be zero, depending on
+    the storage location.
 
 .. program:: image-formats
 .. option:: qcow2
diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index c35bd64822..a2089bd1b7 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -750,11 +750,12 @@ Supported image file formats:
   Supported options:
 
   ``preallocation``
-    Preallocation mode (allowed values: ``off``, ``falloc``,
-    ``full``).  ``falloc`` mode preallocates space for image by
-    calling ``posix_fallocate()``.  ``full`` mode preallocates space
-    for image by writing data to underlying storage.  This data may or
-    may not be zero, depending on the storage location.
+    Preallocation mode (allowed values: ``off``, ``falloc``, ``full``).
+    ``falloc`` mode preallocates space for image by calling
+    ``fallocate()``, and falling back to ``full` mode if not supported.
+    ``full`` mode preallocates space for image by writing data to
+    underlying storage. This data may or may not be zero, depending on
+    the storage location.
 
 ``qcow2``
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index db08c58d78..681d79ec63 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5021,8 +5021,8 @@
 #
 # @off: no preallocation
 # @metadata: preallocate only for metadata
-# @falloc: like @full preallocation but allocate disk space by
-#          posix_fallocate() rather than writing data.
+# @falloc: try to allocate disk space by fallocate(), and fallback to
+#          @full preallocation if not supported.
 # @full: preallocate all data by writing it to the device to ensure
 #        disk space is really available. This data may or may not be
 #        zero, depending on the image format and storage.
-- 
2.26.2


