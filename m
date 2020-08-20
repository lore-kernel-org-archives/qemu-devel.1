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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC798C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 23:57:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A1E820702
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 23:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhZzI2e/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1E820702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8uQu-0004yI-GB
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 19:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1k8uOF-0000Os-GI; Thu, 20 Aug 2020 19:54:39 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33403)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1k8uOD-00071e-Jd; Thu, 20 Aug 2020 19:54:39 -0400
Received: by mail-wr1-x441.google.com with SMTP id p20so371962wrf.0;
 Thu, 20 Aug 2020 16:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sUR7IDboo7GrecxA9+uabpx4vhCBi+2dceKv7WvVfWI=;
 b=qhZzI2e/IYT9QCe127JBq1W6JohxT5zKZfEzIVILEA4ROuRS9WRo3Tb6nlB/1ai2BB
 mFhqA+7i8GSais4EoYirrlCRGfjN/mZYu7oTfFW4LQSnIV2Onkf/M8PqxOOK2ZtiXh4L
 9+pkii+rKgUAEGPMlcQa+Hc2svhMoGm/auBi4VeqQPQP4kubPjajvDV3hdmgmyEI0jkB
 3c6AqlGjGwAXI6z7Pp7vG8hvEfkwOA5dXVq3ulureE9EWGCQdb0m76A8wOoqIKOp2oMQ
 gXhhtUVW1gRWN863TO9laBwjXzsiYKgs4b+KnuG6y5zS31QjlWqjJFSuGT/LtD1k5g+6
 /+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sUR7IDboo7GrecxA9+uabpx4vhCBi+2dceKv7WvVfWI=;
 b=k4eFNXaulem5iwJSRJx/a7V3sPKYPxYHWyuKwABuT7bjasotBgvrA4qUisHV9WYcjU
 43nyVNKqRUBbKDSgwN0ph31Hm1MpaD5XfT3V4xFBXDY7DeJYmKif0Tx49cVDlaHZa2nR
 fn3sZC+aOpUill9kZtKtTxaxnA/goSWe9GmCWs9DcALlZqvWhQzPfKgDfGeHUk250ebD
 oX/OX/iyTqnGOVuWgwBh7/c+E6/ngrvcjnr1ey17gjLf4t4Rmiyf1Lv5NXfZEZwWDR5i
 +sWWu/6QsHuVsrEY6pmj2j8Ytwu43LsdypJ36TGficGSlRvp5HqrqCn/gr9zl7Bchcfn
 EG3Q==
X-Gm-Message-State: AOAM5321RglmJf0ys4O0pPChRA86orpr2upSfl0n+v7yqbvsmJnAHJC0
 PJW/6PEH58xp5gqc96NXMAuKzuWZqqrjMTiI
X-Google-Smtp-Source: ABdhPJy38bO73trNcWLwOhDTmpa5vOPLkSkQPZwCrsJns1Ix+CBhfVtLk5Us9KsyfpT0XZqZfAzqHw==
X-Received: by 2002:a5d:6348:: with SMTP id b8mr158569wrw.362.1597967675561;
 Thu, 20 Aug 2020 16:54:35 -0700 (PDT)
Received: from localhost.localdomain (109-186-18-89.bb.netvision.net.il.
 [109.186.18.89])
 by smtp.gmail.com with ESMTPSA id o128sm556506wmo.39.2020.08.20.16.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 16:54:34 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/5] qemu-iotests: Support varargs syntax in FilePaths
Date: Fri, 21 Aug 2020 02:54:25 +0300
Message-Id: <20200820235427.374645-4-nsoffer@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200820235427.374645-1-nsoffer@redhat.com>
References: <20200820235427.374645-1-nsoffer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=nirsof@gmail.com; helo=mail-wr1-x441.google.com
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

Accept variable number of names instead of a sequence:

    with FilePaths("a", "b", "c") as (a, b, c):

The disadvantage is that base_dir must be used as kwarg:

    with FilePaths("a", "b", base_dir=soc_dir) as (sock1, sock2):

But this is more clear and calling optional argument as positional
arguments is bad idea anyway.

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
---
 tests/qemu-iotests/194        |  4 ++--
 tests/qemu-iotests/257        | 10 ++++------
 tests/qemu-iotests/iotests.py |  6 +++---
 3 files changed, 9 insertions(+), 11 deletions(-)

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
index f34a1d7ef1..cdcdc2ad8b 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -455,13 +455,13 @@ class FilePaths:
 
     Example usage:
 
-        with FilePaths(['test.img', 'test.sock']) as (img_path, sock_path):
+        with FilePaths('test.img', 'test.sock') as (img_path, sock_path):
             # Use img_path and sock_path here...
 
         # img_path and sock_path are automatically removed here.
 
     """
-    def __init__(self, names, base_dir=test_dir):
+    def __init__(self, *names, base_dir=test_dir):
         self.paths = []
         for name in names:
             self.paths.append(os.path.join(base_dir, file_pattern(name)))
@@ -482,7 +482,7 @@ class FilePath(FilePaths):
     FilePath is a specialization of FilePaths that takes a single filename.
     """
     def __init__(self, name, base_dir=test_dir):
-        super(FilePath, self).__init__([name], base_dir)
+        super(FilePath, self).__init__(name, base_dir=base_dir)
 
     def __enter__(self):
         return self.paths[0]
-- 
2.26.2


