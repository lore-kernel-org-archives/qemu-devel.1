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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C82C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:26:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF79E20838
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzdJrdbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF79E20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBnlN-0007CL-6L
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 19:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1kBnh9-0001l2-Ni; Fri, 28 Aug 2020 19:22:07 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:44584)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1kBnh7-0006Jw-90; Fri, 28 Aug 2020 19:22:07 -0400
Received: by mail-ej1-x643.google.com with SMTP id bo3so1187646ejb.11;
 Fri, 28 Aug 2020 16:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DfQdOmDWDR7CywBxhlqnr+z6I//LZ+YDpkFuKYbiMMg=;
 b=hzdJrdbwFVdaWVTrr6/Lyj9cgSgOLt52i0nlTOLvRTax6vxct9AmcSMmXsiGGE0jtH
 KTQW/11HuDEHda87vecNanVgo77hBbd1/xI1WP/L3bVoSMtdWApMBHL5Vv2PcOg37x/B
 GgG9l0c1vnwjulYDIDvlW9T1KGatM/hNiWoL3vpd7TxGoQ3qIP+EBa2N+tJb4ieQIrZt
 4bDT4A5OYzXoqIzdR9JpNxBlO+EY6kl+//YgnEKtrL0wdogOWzDbMhVgJEYt8tYSnGaf
 M/KbuXyy1I6LWIx5Sk/tX8Gt0qC9xligjZ4rCQ2nF8ZERb6/AT8G9mEIp3g8sQu+mFDP
 rdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DfQdOmDWDR7CywBxhlqnr+z6I//LZ+YDpkFuKYbiMMg=;
 b=rA5j+XpVlJpjVdJMQVuMPrpfAeleHpRzyjhhXnAmSpMIFbAGtSCOU45xnEqmOcrQqq
 NuDS8gDJNDoWCGTrS2NbQD7ilKKiCoHgVv8zY5oVVS731pr2OAnncHD5TnFKXClHDyQ/
 /iPwLZX9ixkp0VloFkB0w2/KvJOVzHn7e7xlX3XlEKSZ3re1LKbdUloLjt3HhVuErtEc
 nSNrIMqw9ns2XvOMOV8hCyHrQXjOQ6SLJLgk/OYela9jBPFzFg1Duvqe+Y6wzwXiwBW0
 2fT5WeAItDOBmqsx+WEmsfnx3Ybco3ytVvMIm6hZJvz2rx0Ll4wQdF1dW0vEp+dDuwGY
 Gvgw==
X-Gm-Message-State: AOAM530wJDwQ5YcXWW0AB+GjnzKNFHp4f1r37WfgCG7rl40d2/62NZj1
 N7O/wDsTP5k4Id8eYukKvXhtghlZX4dAaLcJ
X-Google-Smtp-Source: ABdhPJzb/ddDrn0EPX9Vzpd41i2wf97PIV72zM5s+jkYrQu31U7ecJZj4SqKMuOSjpMOllJHymJyig==
X-Received: by 2002:a17:907:94c3:: with SMTP id
 dn3mr1115216ejc.186.1598656923193; 
 Fri, 28 Aug 2020 16:22:03 -0700 (PDT)
Received: from localhost.localdomain (109-186-204-55.bb.netvision.net.il.
 [109.186.204.55])
 by smtp.gmail.com with ESMTPSA id j21sm523436eja.109.2020.08.28.16.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 16:22:02 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/5] qemu-iotests: Merge FilePaths and FilePath
Date: Sat, 29 Aug 2020 02:21:51 +0300
Message-Id: <20200828232152.205833-5-nsoffer@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200828232152.205833-1-nsoffer@redhat.com>
References: <20200828232152.205833-1-nsoffer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=nirsof@gmail.com; helo=mail-ej1-x643.google.com
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

FilePath creates now one temporary file:

    with FilePath("a") as a:

Or more:

    with FilePath("a", "b", "c") as (a, b, c):

This is also the behavior of the file_path() helper, used by some of the
tests. Now we have only 2 helpers for creating temporary files instead
of 3.

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/194        |  2 +-
 tests/qemu-iotests/208        |  2 +-
 tests/qemu-iotests/222        |  2 +-
 tests/qemu-iotests/257        |  4 ++--
 tests/qemu-iotests/iotests.py | 23 ++++++++++-------------
 5 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
index 08389f474e..7a4863ab18 100755
--- a/tests/qemu-iotests/194
+++ b/tests/qemu-iotests/194
@@ -26,7 +26,7 @@ iotests.script_initialize(supported_fmts=['qcow2', 'qed', 'raw'],
 
 with iotests.FilePath('source.img') as source_img_path, \
      iotests.FilePath('dest.img') as dest_img_path, \
-     iotests.FilePaths('migration.sock', 'nbd.sock', base_dir=iotests.sock_dir) \
+     iotests.FilePath('migration.sock', 'nbd.sock', base_dir=iotests.sock_dir) \
         as (migration_sock_path, nbd_sock_path), \
      iotests.VM('source') as source_vm, \
      iotests.VM('dest') as dest_vm:
diff --git a/tests/qemu-iotests/208 b/tests/qemu-iotests/208
index 6cb642f821..54aa4be273 100755
--- a/tests/qemu-iotests/208
+++ b/tests/qemu-iotests/208
@@ -26,7 +26,7 @@ iotests.script_initialize(supported_fmts=['generic'])
 
 with iotests.FilePath('disk.img') as disk_img_path, \
      iotests.FilePath('disk-snapshot.img') as disk_snapshot_img_path, \
-     iotests.FilePath('nbd.sock', iotests.sock_dir) as nbd_sock_path, \
+     iotests.FilePath('nbd.sock', base_dir=iotests.sock_dir) as nbd_sock_path, \
      iotests.VM() as vm:
 
     img_size = '10M'
diff --git a/tests/qemu-iotests/222 b/tests/qemu-iotests/222
index 6602f6b4ba..14d67c875b 100755
--- a/tests/qemu-iotests/222
+++ b/tests/qemu-iotests/222
@@ -49,7 +49,7 @@ remainder = [("0xd5", "0x108000",  "32k"), # Right-end of partial-left [1]
 
 with iotests.FilePath('base.img') as base_img_path, \
      iotests.FilePath('fleece.img') as fleece_img_path, \
-     iotests.FilePath('nbd.sock', iotests.sock_dir) as nbd_sock_path, \
+     iotests.FilePath('nbd.sock', base_dir=iotests.sock_dir) as nbd_sock_path, \
      iotests.VM() as vm:
 
     log('--- Setting up images ---')
diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index a9aa65bbe3..c80e06ae28 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -275,7 +275,7 @@ def test_bitmap_sync(bsync_mode, msync_mode='bitmap', failure=None):
                         an incomplete backup. Testing limitations prevent
                         testing competing writes.
     """
-    with iotests.FilePaths(
+    with iotests.FilePath(
             'img', 'bsync1', 'bsync2', 'fbackup0', 'fbackup1', 'fbackup2') as \
             (img_path, bsync1, bsync2, fbackup0, fbackup1, fbackup2), \
          iotests.VM() as vm:
@@ -440,7 +440,7 @@ def test_backup_api():
     """
     Test malformed and prohibited invocations of the backup API.
     """
-    with iotests.FilePaths('img', 'bsync1') as (img_path, backup_path), \
+    with iotests.FilePath('img', 'bsync1') as (img_path, backup_path), \
          iotests.VM() as vm:
 
         log("\n=== API failure tests ===\n")
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 0d22ad5b03..7a233330c9 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -448,14 +448,14 @@ class Timeout:
 def file_pattern(name):
     return "{0}-{1}".format(os.getpid(), name)
 
-class FilePaths:
+class FilePath:
     """
     Context manager generating multiple file names. The generated files are
     removed when exiting the context.
 
     Example usage:
 
-        with FilePaths('a.img', 'b.img') as (img_a, img_b):
+        with FilePath('a.img', 'b.img') as (img_a, img_b):
             # Use img_a and img_b here...
 
         # a.img and b.img are automatically removed here.
@@ -463,7 +463,10 @@ class FilePaths:
     By default images are created in iotests.test_dir. To create socket use
     iotests.sock_dir:
 
-       with FilePaths('a.sock', base_dir=iotests.sock_dir) as (sock,):
+       with FilePath('a.sock', base_dir=iotests.sock_dir) as sock:
+
+    For convenience, calling with one argument yields a single file instead of
+    a tuple with one item.
 
     """
     def __init__(self, *names, base_dir=test_dir):
@@ -472,7 +475,10 @@ class FilePaths:
             self.paths.append(os.path.join(base_dir, file_pattern(name)))
 
     def __enter__(self):
-        return self.paths
+        if len(self.paths) == 1:
+            return self.paths[0]
+        else:
+            return self.paths
 
     def __exit__(self, exc_type, exc_val, exc_tb):
         for path in self.paths:
@@ -482,15 +488,6 @@ class FilePaths:
                 pass
         return False
 
-class FilePath(FilePaths):
-    """
-    FilePath is a specialization of FilePaths that takes a single filename.
-    """
-    def __init__(self, name, base_dir=test_dir):
-        super(FilePath, self).__init__(name, base_dir=base_dir)
-
-    def __enter__(self):
-        return self.paths[0]
 
 def file_path_remover():
     for path in reversed(file_path_remover.paths):
-- 
2.26.2


