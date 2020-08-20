Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C22C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 23:56:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0185A20702
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 23:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5suQYgd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0185A20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8uPw-0002oF-88
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 19:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1k8uOH-0000VS-L6; Thu, 20 Aug 2020 19:54:41 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39488)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1k8uOF-000725-I3; Thu, 20 Aug 2020 19:54:41 -0400
Received: by mail-wr1-x444.google.com with SMTP id a5so342964wrm.6;
 Thu, 20 Aug 2020 16:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IemM2Uq8S1/BmOQeRYPD0lV6cTknW/ZTdpXLM2UH07I=;
 b=g5suQYgdTiEFWtt82U8pDCLIxl6a/9W56ol68qvg+4enbNcucQqKhAkaohrnkaJZ8T
 rK8KvWXA9KcffvSvM5frRCTX1LgDNiI3193Q93lDDYgnbHs5NyEKGPOqoQY9uvJLzHCN
 Nc+pJ7iBbRRpCkR7Y/MuHxtZ0FnhK6ljZ/VI/fw8gw4nadvriTFAj70vDd+i+GMrdIWV
 KV3i2eyYg8NiQMXz0LqOIrwMECnSUrCmBqkqLXnARsiaQvhopVBrauKUjcxc2ixE5yhQ
 h4dAbexPOahrX3kNLY51fzkQFchPgi1UZZk1dXJp7K/bHTb/o3lAGkYA8Ve4BI3jMY5v
 MzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IemM2Uq8S1/BmOQeRYPD0lV6cTknW/ZTdpXLM2UH07I=;
 b=qk+2FPCknxvpBbgRwuQcni/MHsohsu4b1vkTWnKd3luNgD4PPLg0ws4GmiuGtCvBZU
 y3l7c/0lsBsAadKbV2jn0fQ+GEBK7ni/r39T0CMxmQHA/NE7OcD26Sx/pcA3sXfGy+qL
 hZ2L3H3ztgOx3eDboaDLi8UKN5IQu5FUKc9AYK7sdHNAq1mPfvqCZBv/Y4/bCGe4pe4r
 M8nIQ/mNRpjuoeSTzv/IeopvIvFTfeoYhJkh55r4n42uL1ZxLYW+s20P+6TT+RzH9g7k
 +I03D+iATDARX+Y4SKsbhql+GYOqvsix6G017WEuZfIP7Tnx3ke5Sk9QtUOfIiLh3WMP
 EZdw==
X-Gm-Message-State: AOAM533wJ5ijCdaNjkYK/Kv4oJNqx2Lxf4hgw5UGRitKUz8hoMgfLGKd
 t4sSWNAw0+RncXuTvPsSutb8zFIssoMPXgam
X-Google-Smtp-Source: ABdhPJyPo8WFg+RmMMt47KLGl9YZ7sf0r9969AmuIfRS2eoCiVAqQlY2UCzu1FC5ATAajHlW/gdeHA==
X-Received: by 2002:adf:c789:: with SMTP id l9mr167455wrg.41.1597967677140;
 Thu, 20 Aug 2020 16:54:37 -0700 (PDT)
Received: from localhost.localdomain (109-186-18-89.bb.netvision.net.il.
 [109.186.18.89])
 by smtp.gmail.com with ESMTPSA id o128sm556506wmo.39.2020.08.20.16.54.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 16:54:36 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/5] qemu-iotests: Merge FilePaths and FilePath
Date: Fri, 21 Aug 2020 02:54:26 +0300
Message-Id: <20200820235427.374645-5-nsoffer@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200820235427.374645-1-nsoffer@redhat.com>
References: <20200820235427.374645-1-nsoffer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=nirsof@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
---
 tests/qemu-iotests/194        |  2 +-
 tests/qemu-iotests/208        |  2 +-
 tests/qemu-iotests/222        |  2 +-
 tests/qemu-iotests/257        |  4 ++--
 tests/qemu-iotests/iotests.py | 23 +++++++++++------------
 5 files changed, 16 insertions(+), 17 deletions(-)

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
index cdcdc2ad8b..1b5cdd493e 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -448,18 +448,23 @@ class Timeout:
 def file_pattern(name):
     return "{0}-{1}".format(os.getpid(), name)
 
-class FilePaths:
+class FilePath:
     """
     Context manager generating multiple file names. The generated files are
     removed when exiting the context.
 
     Example usage:
 
-        with FilePaths('test.img', 'test.sock') as (img_path, sock_path):
+        with FilePath('test.img', 'test.sock') as (img_path, sock_path):
             # Use img_path and sock_path here...
 
         # img_path and sock_path are automatically removed here.
 
+    For convenience, calling with one argument yields a single file instead of
+    a tuple with one item:
+
+        with FilePath("a") as a:
+
     """
     def __init__(self, *names, base_dir=test_dir):
         self.paths = []
@@ -467,7 +472,10 @@ class FilePaths:
             self.paths.append(os.path.join(base_dir, file_pattern(name)))
 
     def __enter__(self):
-        return self.paths
+        if len(self.paths) == 1:
+            return self.paths[0]
+        else:
+            return self.paths
 
     def __exit__(self, exc_type, exc_val, exc_tb):
         for path in self.paths:
@@ -477,15 +485,6 @@ class FilePaths:
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


