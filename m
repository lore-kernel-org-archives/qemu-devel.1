Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F127C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:25:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 132CF20838
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="su84LV7F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132CF20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBnkF-0005Zo-81
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 19:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1kBnh7-0001iu-Eu; Fri, 28 Aug 2020 19:22:05 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:36942)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1kBnh5-0006Jm-L6; Fri, 28 Aug 2020 19:22:05 -0400
Received: by mail-ej1-x644.google.com with SMTP id e23so1236447ejb.4;
 Fri, 28 Aug 2020 16:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lJC7yqn+aYrJFGPSXOQj9C6bCyzL+YLObXLu10CJu2E=;
 b=su84LV7FrdSKS48qJv2WmNLin8ZufKiPUyyoDfSWX/fDrIJXAk+NTlLBfOHePm0Z+l
 TS39fgkb8GUFp5p4JdrM7Mnv18L6rW5Z+nECrCwSMnRJbRG2jIrA/pgeEX/oOoXWyqTK
 khJHsMhu1QCcQAtgXJuX2H/63mu0TtqDRWe+a0MLcnLJla9JQp1Mi4uh9Gp0S4Swzpvq
 s9w2jutwPbGJccPDEKcJAAR8qITRvFnyi1uVdJ7hID0HwHODqZFAPjNbDZnwGWZ+0W1U
 7X6NgdQos1aqKVilFM6ANLUpVXlZrCZi5bnenHTriKpAbzJYNQhHU2lcO/FvKyM1bOz2
 ujsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lJC7yqn+aYrJFGPSXOQj9C6bCyzL+YLObXLu10CJu2E=;
 b=jRb4gh0Bioc+npRP0qu3NdMLXoP+8gF4eDYdI2xZw/s7XN7Bp/zyWmfPLtl85MyDCs
 Gb/4O6jVz8U3M6ewhFQRMGuOZgpeg618DM0WAnxktlqjLnEg8ci9yLbqT9vSR6IHtmqm
 ZBxjlfkbtt3a03NOEeCSROh9b6HYjXqyPRr3gIUvWteOUtaPjzHUx4NaM2tr7p0gWKsO
 h+Q44IRvoj+GVYNBvatci6T4shuDKOXHBDMpzJB72AO6n99zJxafFlccumFjs/JbGqOs
 pEu9hSlgySPQc7FOtlZnnbRf4qE4KN575icGzih6ho1Yq9+6iT2zrRSjMicp4OSd78rE
 AaTQ==
X-Gm-Message-State: AOAM53091z33z8fqfKmtscHEn/MmipuCbuoupMKUWjVXMfOvUfvwFLGg
 oqlg7Dt2qlMZTU4uKr+BzZnIvceSkuExEgEx
X-Google-Smtp-Source: ABdhPJx4XJONk+930Fjs84XWBG3u3JLQM+pUYFNhVfR1YtxkhoV7558nqVqcEVRUEGm7gvsWO+RQmg==
X-Received: by 2002:a17:906:289a:: with SMTP id
 o26mr1086286ejd.309.1598656921636; 
 Fri, 28 Aug 2020 16:22:01 -0700 (PDT)
Received: from localhost.localdomain (109-186-204-55.bb.netvision.net.il.
 [109.186.204.55])
 by smtp.gmail.com with ESMTPSA id j21sm523436eja.109.2020.08.28.16.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 16:22:01 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/5] qemu-iotests: Support varargs syntax in FilePaths
Date: Sat, 29 Aug 2020 02:21:50 +0300
Message-Id: <20200828232152.205833-4-nsoffer@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200828232152.205833-1-nsoffer@redhat.com>
References: <20200828232152.205833-1-nsoffer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=nirsof@gmail.com; helo=mail-ej1-x644.google.com
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
 John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Accept variable number of names instead of a sequence:

    with FilePaths("a", "b", "c") as (a, b, c):

The disadvantage is that base_dir must be used as kwarg:

    with FilePaths("a", "b", base_dir=soc_dir) as (sock1, sock2):

But this is more clear and calling optional argument as positional
arguments is bad idea anyway.

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/194        |  4 ++--
 tests/qemu-iotests/257        | 10 ++++------
 tests/qemu-iotests/iotests.py |  8 ++++----
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
index da7c4265ec..08389f474e 100755
--- a/tests/qemu-iotests/194
+++ b/tests/qemu-iotests/194
@@ -26,8 +26,8 @@ iotests.script_initialize(supported_fmts=['qcow2', 'qed', 'raw'],
 
 with iotests.FilePath('source.img') as source_img_path, \
      iotests.FilePath('dest.img') as dest_img_path, \
-     iotests.FilePaths(['migration.sock', 'nbd.sock'], iotests.sock_dir) as \
-         [migration_sock_path, nbd_sock_path], \
+     iotests.FilePaths('migration.sock', 'nbd.sock', base_dir=iotests.sock_dir) \
+        as (migration_sock_path, nbd_sock_path), \
      iotests.VM('source') as source_vm, \
      iotests.VM('dest') as dest_vm:
 
diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index e1e6077219..a9aa65bbe3 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -275,10 +275,9 @@ def test_bitmap_sync(bsync_mode, msync_mode='bitmap', failure=None):
                         an incomplete backup. Testing limitations prevent
                         testing competing writes.
     """
-    with iotests.FilePaths(['img', 'bsync1', 'bsync2',
-                            'fbackup0', 'fbackup1', 'fbackup2']) as \
-                            (img_path, bsync1, bsync2,
-                             fbackup0, fbackup1, fbackup2), \
+    with iotests.FilePaths(
+            'img', 'bsync1', 'bsync2', 'fbackup0', 'fbackup1', 'fbackup2') as \
+            (img_path, bsync1, bsync2, fbackup0, fbackup1, fbackup2), \
          iotests.VM() as vm:
 
         mode = "Mode {:s}; Bitmap Sync {:s}".format(msync_mode, bsync_mode)
@@ -441,8 +440,7 @@ def test_backup_api():
     """
     Test malformed and prohibited invocations of the backup API.
     """
-    with iotests.FilePaths(['img', 'bsync1']) as \
-         (img_path, backup_path), \
+    with iotests.FilePaths('img', 'bsync1') as (img_path, backup_path), \
          iotests.VM() as vm:
 
         log("\n=== API failure tests ===\n")
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 4abfe63662..0d22ad5b03 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -455,7 +455,7 @@ class FilePaths:
 
     Example usage:
 
-        with FilePaths(['a.img', 'b.img']) as (img_a, img_b):
+        with FilePaths('a.img', 'b.img') as (img_a, img_b):
             # Use img_a and img_b here...
 
         # a.img and b.img are automatically removed here.
@@ -463,10 +463,10 @@ class FilePaths:
     By default images are created in iotests.test_dir. To create socket use
     iotests.sock_dir:
 
-       with FilePaths(['a.sock'], base_dir=iotests.sock_dir) as (sock,):
+       with FilePaths('a.sock', base_dir=iotests.sock_dir) as (sock,):
 
     """
-    def __init__(self, names, base_dir=test_dir):
+    def __init__(self, *names, base_dir=test_dir):
         self.paths = []
         for name in names:
             self.paths.append(os.path.join(base_dir, file_pattern(name)))
@@ -487,7 +487,7 @@ class FilePath(FilePaths):
     FilePath is a specialization of FilePaths that takes a single filename.
     """
     def __init__(self, name, base_dir=test_dir):
-        super(FilePath, self).__init__([name], base_dir)
+        super(FilePath, self).__init__(name, base_dir=base_dir)
 
     def __enter__(self):
         return self.paths[0]
-- 
2.26.2


