Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A17BC433E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 22:01:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 177B620809
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 22:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVoqSPcq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 177B620809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0BBN-0001IR-90
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 18:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1k0B9F-00083S-4i; Mon, 27 Jul 2020 17:59:05 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:39569)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1k0B9D-0004Ls-8s; Mon, 27 Jul 2020 17:59:04 -0400
Received: by mail-wm1-x333.google.com with SMTP id t142so9835649wmt.4;
 Mon, 27 Jul 2020 14:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YxkYB4mtsedDfq3OADLqoKGrrr9VRyJd5kW4UXFdOtQ=;
 b=BVoqSPcqpqZih8B18GX/smub9v22DY/4t+1BkGIb6gRsp6Fu3GuGP/HjLukHiHPW7e
 oJbBXrwx0noJvLliGkFGiYSKmn3Wz/Nw+i4soy/aw3da6Z30UAlH1p4VzUhpe/ts2l7e
 T2FP0vQJZn826hVzwk08dRF4RneWOajzjXYQg0O/w1KlclcD6yX7Mfgk6E6h6UAGXuc3
 46FPRH8SLx0QGb7xORHN41Kt8EvhiqjtY5Avi7OAfXakd5KS7zTcVG3dK2/z4imCA06L
 +oJvRwGUl/EsWYY8xWtWRk6WcodiVwCMoxOfBGVqeK+7M8KSf9TdzpISraAUThZHICRl
 mRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YxkYB4mtsedDfq3OADLqoKGrrr9VRyJd5kW4UXFdOtQ=;
 b=OQPp8hF3Z2u6C+n6zzmMGgkS/pSV8O9qAlo3rvNFZmNmtG3TR62jAf1dMI1l9V9xDV
 B666WSH9/l0nwkdradSWCl5v+2Rsk6SczzKzR/ReDhJLHPRQPauG1X+b2qlGzVrzIbyX
 xPRprJlgy+EVWu2uiil3QJR8iNojwZAg5qKp87UWTtW57dQLDbSTQ+Dvsl8yBhNdUWgL
 DB72T127O9V86h4hinFAYrn5B1g1zezET+J6i0Jqn6w/8TBQu8iJBDwXoBvxOZD9CaTM
 e0RQWPL3ZuOUsNL0NnbxDY1DrCrLiY45EgiJuA9ISjCwAjabS6m0y1ubYBECGyoME7xm
 Ntww==
X-Gm-Message-State: AOAM531gWanmXqPSlMOUtrAaysXoedVvHC5XohttxTLEMH49HDY62q+D
 OrvOtMSbSrxPijYJByRwWtE90vhzxb0=
X-Google-Smtp-Source: ABdhPJyikwlpDKbC++I50eFvhJjNBkQERvAavZvfWk7Dh1HFVcEpvDqnT4LGF0oMY2ZK4qvKBayEvQ==
X-Received: by 2002:a1c:f219:: with SMTP id s25mr1067199wmc.2.1595887140970;
 Mon, 27 Jul 2020 14:59:00 -0700 (PDT)
Received: from localhost.localdomain (109-186-134-209.bb.netvision.net.il.
 [109.186.134.209])
 by smtp.gmail.com with ESMTPSA id p14sm14492940wrx.90.2020.07.27.14.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 14:58:56 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Subject: [PATCH v2 4/4] iotests: Test convert to qcow2 compressed to NBD
Date: Tue, 28 Jul 2020 00:58:46 +0300
Message-Id: <20200727215846.395443-5-nsoffer@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200727215846.395443-1-nsoffer@redhat.com>
References: <20200727215846.395443-1-nsoffer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=nirsof@gmail.com; helo=mail-wm1-x333.google.com
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
 vsementsov@virtuozzo.com, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add test for "qemu-img convert -O qcow2 -c" to NBD target. The tests    
create a OVA file and write compressed qcow2 disk content directly into
the OVA file via qemu-nbd.

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
---
 tests/qemu-iotests/302     | 127 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/302.out |  31 +++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 159 insertions(+)
 create mode 100755 tests/qemu-iotests/302
 create mode 100644 tests/qemu-iotests/302.out

diff --git a/tests/qemu-iotests/302 b/tests/qemu-iotests/302
new file mode 100755
index 0000000000..a8506bda15
--- /dev/null
+++ b/tests/qemu-iotests/302
@@ -0,0 +1,127 @@
+#!/usr/bin/env python3
+#
+# Tests converting qcow2 compressed to NBD
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
+import io
+import tarfile
+
+import iotests
+
+from iotests import (
+    file_path,
+    qemu_img,
+    qemu_img_check,
+    qemu_img_create,
+    qemu_img_log,
+    qemu_img_measure,
+    qemu_io,
+    qemu_nbd_popen,
+)
+
+iotests.script_initialize(supported_fmts=["qcow2"])
+
+# Create source disk. Using qcow2 to enable strict comparing later, and
+# avoid issues with random filesystem on CI environment.
+src_disk = file_path("disk.qcow2")
+qemu_img_create("-f", iotests.imgfmt, src_disk, "1g")
+qemu_io("-f", iotests.imgfmt, "-c", "write 1m 64k", src_disk)
+
+# The use case is writing qcow2 image directly into an ova file, which
+# is a tar file with specific layout. This is tricky since we don't know the
+# size of the image before compressing, so we have to do:
+# 1. Add an ovf file.
+# 2. Find the offset of the next member data.
+# 3. Make room for image data, allocating for the worst case.
+# 4. Write compressed image data into the tar.
+# 5. Add a tar entry with the actual image size.
+# 6. Shrink the tar to the actual size, aligned to 512 bytes.
+
+tar_file = file_path("test.ova")
+
+with tarfile.open(tar_file, "w") as tar:
+
+    # 1. Add an ovf file.
+
+    ovf_data = b"<xml/>"
+    ovf = tarfile.TarInfo("vm.ovf")
+    ovf.size = len(ovf_data)
+    tar.addfile(ovf, io.BytesIO(ovf_data))
+
+    # 2. Find the offset of the next member data.
+
+    offset = tar.fileobj.tell() + 512
+
+    # 3. Make room for image data, allocating for the worst case.
+
+    measure = qemu_img_measure("-O", "qcow2", src_disk)
+    tar.fileobj.truncate(offset + measure["required"])
+
+    # 4. Write compressed image data into the tar.
+
+    nbd_sock = file_path("nbd-sock", base_dir=iotests.sock_dir)
+    nbd_uri = "nbd+unix:///exp?socket=" + nbd_sock
+
+    # Use raw format to allow creating qcow2 directly into tar file.
+    with qemu_nbd_popen(
+            "--socket", nbd_sock,
+            "--export-name", "exp",
+            "--format", "raw",
+            "--offset", str(offset),
+            tar_file):
+
+        iotests.log("=== Target image info ===")
+        qemu_img_log("info", nbd_uri)
+
+        qemu_img(
+            "convert",
+            "-f", iotests.imgfmt,
+            "-O", "qcow2",
+            "-c",
+            src_disk,
+            nbd_uri)
+
+        iotests.log("=== Converted image info ===")
+        qemu_img_log("info", nbd_uri)
+
+        iotests.log("=== Converted image check ===")
+        qemu_img_log("check", nbd_uri)
+
+        iotests.log("=== Comparing to source disk ===")
+        qemu_img_log("compare", src_disk, nbd_uri)
+
+        actual_size = qemu_img_check(nbd_uri)["image-end-offset"]
+
+    # 5. Add a tar entry with the actual image size.
+
+    disk = tarfile.TarInfo("disk")
+    disk.size = actual_size
+    tar.addfile(disk)
+
+    # 6. Shrink the tar to the actual size, aligned to 512 bytes.
+
+    tar_size = offset + (disk.size + 511) & ~511
+    tar.fileobj.seek(tar_size)
+    tar.fileobj.truncate(tar_size)
+
+with tarfile.open(tar_file) as tar:
+    members = [{"name": m.name, "size": m.size, "offset": m.offset_data}
+               for m in tar]
+    iotests.log("=== OVA file contents ===")
+    iotests.log(members)
diff --git a/tests/qemu-iotests/302.out b/tests/qemu-iotests/302.out
new file mode 100644
index 0000000000..e37d3a1030
--- /dev/null
+++ b/tests/qemu-iotests/302.out
@@ -0,0 +1,31 @@
+Start NBD server
+=== Target image info ===
+image: nbd+unix:///exp?socket=SOCK_DIR/PID-nbd-sock
+file format: raw
+virtual size: 448 KiB (458752 bytes)
+disk size: unavailable
+
+=== Converted image info ===
+image: nbd+unix:///exp?socket=SOCK_DIR/PID-nbd-sock
+file format: qcow2
+virtual size: 1 GiB (1073741824 bytes)
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
+1/16384 = 0.01% allocated, 100.00% fragmented, 100.00% compressed clusters
+Image end offset: 393216
+
+=== Comparing to source disk ===
+Images are identical.
+
+Kill NBD server
+=== OVA file contents ===
+[{"name": "vm.ovf", "offset": 512, "size": 6}, {"name": "disk", "offset": 1536, "size": 393216}]
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


