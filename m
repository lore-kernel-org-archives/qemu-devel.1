Return-Path: <SRS0=rO5d=BF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8212C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2020 15:26:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AC1F2065E
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2020 15:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGpX/P9y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC1F2065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jziXo-0002HL-86
	for qemu-devel@archiver.kernel.org; Sun, 26 Jul 2020 11:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1jziX1-0001CM-EP; Sun, 26 Jul 2020 11:25:43 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:38249)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1jziWz-0001v3-Kn; Sun, 26 Jul 2020 11:25:43 -0400
Received: by mail-wr1-x432.google.com with SMTP id a14so12472031wra.5;
 Sun, 26 Jul 2020 08:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xyvYgYXYDDM1UjrbjwOPiOJcKtFg0H3V534tt6M6PgM=;
 b=rGpX/P9yBGHCh6GfEmKx1aId+C2EhzGF8eajLy6eZ3/29KLJ6hNZD2yMnD6EyBOlmx
 L4dsFm3bUpZt80Pn12fQb/12+h7N5R46op9iVZMe2lmkQo+ynjOXJFNFhcjaFYcOmzh4
 cQYSjsJRBxTiSCTpGG+eA93GUCFoMqpt3UzemZYdSjtOcZDMPNR0TXXiUWj7iunjDgB7
 zBglV4vjFFk0AVzsqrsP7ri09llmlIlZShx5zf5I9S9/UTv0Okliofm7zRouSBvjHt7i
 60OLNLIKc9s7YbYpBgW+WVeQEve3rjX6s8RH1YTH7eDh+GE7Oe2GdS9vh2gBNrUuvDLp
 hEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xyvYgYXYDDM1UjrbjwOPiOJcKtFg0H3V534tt6M6PgM=;
 b=HXAoe7ikCgWjeNWaxzqhR8svecwzTIRbNh5gbStaPEnJztjEg8KSVnn2GJPPRFuHW6
 lE0bw4269NQCS50OCDIcVpsInrMm8F9I9X751x88ONh2yJFim1YS91PpltZI086XgGz9
 jMfTCVbj/jnZs0e1JcdPt/rjXt4kOHyTcyjNbOW3wO8GwD17F2K2fD8ez1VDJ51s9J7m
 t6zMo/hHrvNtucrVzaWrXMpkGcTOEWdq6IGLr7i1VwHaRtu1xd6q9+fUiePXcR4WZwfn
 vb0gRhnpTpiN+WO846eNqCyMY1yPi0OCyvIE6tDosmQezEV2WbUT1Jm3kj+Lj6YKJi4t
 EM1Q==
X-Gm-Message-State: AOAM533xTth/LIRDCmy/VTvhrJ1vmB03X45GJ3IchDTJ73xy+rxZgBtV
 kuPWAtBuxQb6bzi8/iFwjxp3MvYVdz4=
X-Google-Smtp-Source: ABdhPJz0k8/xai6g6h9X6Xq+gvMGIpiIF9qdYOrWLFFGzFUi6cFCwq4VOXSRl5GOOgwT5ZhfJtZKdA==
X-Received: by 2002:adf:dcc9:: with SMTP id x9mr18274335wrm.153.1595777139589; 
 Sun, 26 Jul 2020 08:25:39 -0700 (PDT)
Received: from localhost.localdomain (109-186-134-209.bb.netvision.net.il.
 [109.186.134.209])
 by smtp.gmail.com with ESMTPSA id 14sm14160206wmk.19.2020.07.26.08.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2020 08:25:38 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/2] qemu-iotests: Test convert to qcow2 compressed to NBD
Date: Sun, 26 Jul 2020 18:25:32 +0300
Message-Id: <20200726152532.256261-3-nsoffer@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200726152532.256261-1-nsoffer@redhat.com>
References: <20200726152532.256261-1-nsoffer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=nirsof@gmail.com; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add test for "qemu-img convert -O qcow2 -c" to NBD target. The use case
is writing compressed disk content to OVA archive.

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
---
 tests/qemu-iotests/302     | 83 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/302.out | 27 +++++++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 111 insertions(+)
 create mode 100755 tests/qemu-iotests/302
 create mode 100644 tests/qemu-iotests/302.out

diff --git a/tests/qemu-iotests/302 b/tests/qemu-iotests/302
new file mode 100755
index 0000000000..cefde1f7cf
--- /dev/null
+++ b/tests/qemu-iotests/302
@@ -0,0 +1,83 @@
+#!/usr/bin/env python3
+#
+# Tests conveting qcow2 compressed to NBD
+#
+# Copyright (c) 2020 Nir Soffer <nirsof@gmail.com>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+# owner=nirsof@gmail.com
+
+import json
+import iotests
+
+from iotests import (
+    file_path,
+    qemu_img,
+    qemu_img_create,
+    qemu_img_log,
+    qemu_img_pipe,
+    qemu_io,
+    qemu_nbd,
+)
+
+iotests.script_initialize(supported_fmts=["qcow2"])
+
+# Create source disk, format does not matter.
+src_disk = file_path("disk.img")
+qemu_img_create("-f", "raw", src_disk, "10m")
+qemu_io("-f", "raw", "-c", "write 1m 64K", src_disk)
+
+# The use case is writing qcow2 image directly into a tar file. Code to create
+# real tar file not included.
+#
+# offset    content
+# -------------------------------
+#      0    first memebr header
+#    512    first member data
+#   1024    second memeber header
+#   1536    second member data
+
+tar_file = file_path("test.tar")
+out = qemu_img_pipe("measure", "-O", "qcow2", "--output", "json", src_disk)
+measure = json.loads(out)
+qemu_img_create("-f", "raw", tar_file, str(measure["required"]))
+
+nbd_sock = file_path("nbd-sock", base_dir=iotests.sock_dir)
+nbd_uri = "nbd+unix:///exp?socket=" + nbd_sock
+
+# Use raw format to allow creating qcow2 directy into tar file.
+qemu_nbd(
+    "--socket", nbd_sock,
+    "--persistent",
+    "--export-name", "exp",
+    "--format", "raw",
+    "--offset", "1536",
+    tar_file)
+
+iotests.log("=== Target image info ===")
+qemu_img_log("info", nbd_uri)
+
+# Write image into the tar file. In a real applicatio we would write a tar
+# entry after writing the image.
+qemu_img("convert", "-f", "raw", "-O", "qcow2", "-c", src_disk, nbd_uri)
+
+iotests.log("=== Converted image info ===")
+qemu_img_log("info", nbd_uri)
+
+iotests.log("=== Converted image check ===")
+qemu_img_log("check", nbd_uri)
+
+iotests.log("=== Comparing to source disk ===")
+qemu_img_log("compare", src_disk, nbd_uri)
diff --git a/tests/qemu-iotests/302.out b/tests/qemu-iotests/302.out
new file mode 100644
index 0000000000..babef3d574
--- /dev/null
+++ b/tests/qemu-iotests/302.out
@@ -0,0 +1,27 @@
+=== Target image info ===
+image: nbd+unix:///exp?socket=SOCK_DIR/PID-nbd-sock
+file format: raw
+virtual size: 446 KiB (457216 bytes)
+disk size: unavailable
+
+=== Converted image info ===
+image: nbd+unix:///exp?socket=SOCK_DIR/PID-nbd-sock
+file format: qcow2
+virtual size: 10 MiB (10485760 bytes)
+disk size: unavailable
+cluster_size: 65536
+Format specific information:
+    compat: 1.1
+    compression type: zlib
+    lazy refcounts: false
+    refcount bits: 16
+    corrupt: false
+
+=== Converted image check ===
+No errors were found on the image.
+1/160 = 0.62% allocated, 100.00% fragmented, 100.00% compressed clusters
+Image end offset: 393216
+
+=== Comparing to source disk ===
+Images are identical.
+
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 1d0252e1f0..1e1cb27bc8 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -308,3 +308,4 @@
 297 meta
 299 auto quick
 301 backing quick
+302 quick
-- 
2.25.4


