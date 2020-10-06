Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A1BC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 08:02:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8187206F4
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 08:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZbyErKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8187206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPhvh-0006nb-L5
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 04:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQL-00034j-Jz
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:13 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:35485)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQJ-0001TO-I4
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:13 -0400
Received: by mail-wm1-x334.google.com with SMTP id q5so1203347wmq.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 00:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0sroHSxG+CDkmdBtRayI+aa5wxYg8jTsjHn44flQrBg=;
 b=KZbyErKhi0j2XPt4s/tuXwyy3bVQKfEx4SF+5wSa73uvUF4wzNAmbmqFFpQ3aEexkP
 h2386QAMsacltax89c2dro0Uth0bIiPcCaFnwuDDR/Kg8wraDlBLCShSDBTnJbvrjJ73
 npE0AYxslvX6Ca90mpV2EUe1liBbWe5V5FbWxbwp+wlwooTfR9yF4uAHgRI5CoT37RZ7
 hNbmshUX4g2Ptqn3ly6P/jwdwCpP80zFbfeqH5gCt7cX1MaDM4+zoVMvqSNMbOmOddrO
 Gjy4BbX/PCxnPgIYCbgfkbjuBJLGmHaw2M+k+hkwLs37gDnH4VddRFdGQt3Mes/jp10M
 aeFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0sroHSxG+CDkmdBtRayI+aa5wxYg8jTsjHn44flQrBg=;
 b=EpUQJg5VOnwofpGtrrh8YcBUkad8gwgWt0/0rQTprU1FwdFT43SpW1oP9uETG/OOwI
 ke6Vh8FLLKAraL+tec9xv/pDXmpZDWc0STxaXy44Wi1gAQiuAbuRm5H3dV+rSqmBqNf0
 zSizY+iKBVvoZQf29rRj50c39oHZJEpY9+tgvnJVrVUBft/jv0eZjONr1BPZNzLvD62b
 gmNw4MM5KSFTPhN9bHMaBbdzWHBMQTcpoB6APAmJOXwsoyRFQvpXvqGMucmdjkGDWE66
 yUjZZQMzn+TZodGzIdxCB2TxmldR1kDKog3WBKoYiqCvli7C9oY8O0G4c7epIQv2N6Gf
 CSYQ==
X-Gm-Message-State: AOAM533TglT14ARleVUR9cjZghLBZsm869DSXudeTlRRaKE0ZOklJxDz
 XsDT6v3o6Esa+06FawiXHnuARGuZ0js=
X-Google-Smtp-Source: ABdhPJzKbg7lUVCv/kSkXECurZUqqLorZUhXXQ+Z4tXL1jLeN7sdbja/zF60gL6pAvcIQjYoiQwewg==
X-Received: by 2002:a1c:c342:: with SMTP id t63mr3081494wmf.145.1601969409736; 
 Tue, 06 Oct 2020 00:30:09 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id i9sm2576329wma.47.2020.10.06.00.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 00:30:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 26/37] qcow2: introduce icount field for snapshots
Date: Tue,  6 Oct 2020 09:29:36 +0200
Message-Id: <20201006072947.487729-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006072947.487729-1-pbonzini@redhat.com>
References: <20201006072947.487729-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x334.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>

This patch introduces the icount field for saving within the snapshot.
It is required for navigation between the snapshots in record/replay mode.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Acked-by: Kevin Wolf <kwolf@redhat.com>

--

v7 changes:
 - also fix the test which checks qcow2 snapshot extra data
Message-Id: <160174518284.12451.2301137308458777398.stgit@pasha-ThinkPad-X280>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/qcow2-snapshot.c     |  7 ++++++
 block/qcow2.h              |  3 +++
 docs/interop/qcow2.txt     |  5 ++++
 tests/qemu-iotests/261     | 15 ++++++-----
 tests/qemu-iotests/261.out | 51 +++++++++++++++++++++++++-------------
 5 files changed, 58 insertions(+), 23 deletions(-)

diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index 9b68690f56..d68b25e0c5 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -164,6 +164,12 @@ static int qcow2_do_read_snapshots(BlockDriverState *bs, bool repair,
             sn->disk_size = bs->total_sectors * BDRV_SECTOR_SIZE;
         }
 
+        if (sn->extra_data_size >= endof(QCowSnapshotExtraData, icount)) {
+            sn->icount = be64_to_cpu(extra.icount);
+        } else {
+            sn->icount = -1ULL;
+        }
+
         if (sn->extra_data_size > sizeof(extra)) {
             uint64_t extra_data_end;
             size_t unknown_extra_data_size;
@@ -333,6 +339,7 @@ int qcow2_write_snapshots(BlockDriverState *bs)
         memset(&extra, 0, sizeof(extra));
         extra.vm_state_size_large = cpu_to_be64(sn->vm_state_size);
         extra.disk_size = cpu_to_be64(sn->disk_size);
+        extra.icount = cpu_to_be64(sn->icount);
 
         id_str_size = strlen(sn->id_str);
         name_size = strlen(sn->name);
diff --git a/block/qcow2.h b/block/qcow2.h
index b71e444fca..125ea9679b 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -206,6 +206,7 @@ typedef struct QEMU_PACKED QCowSnapshotHeader {
 typedef struct QEMU_PACKED QCowSnapshotExtraData {
     uint64_t vm_state_size_large;
     uint64_t disk_size;
+    uint64_t icount;
 } QCowSnapshotExtraData;
 
 
@@ -219,6 +220,8 @@ typedef struct QCowSnapshot {
     uint32_t date_sec;
     uint32_t date_nsec;
     uint64_t vm_clock_nsec;
+    /* icount value for the moment when snapshot was taken */
+    uint64_t icount;
     /* Size of all extra data, including QCowSnapshotExtraData if available */
     uint32_t extra_data_size;
     /* Data beyond QCowSnapshotExtraData, if any */
diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index 7da0d81df8..0463f761ef 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -707,6 +707,11 @@ Snapshot table entry:
 
                     Byte 48 - 55:   Virtual disk size of the snapshot in bytes
 
+                    Byte 56 - 63:   icount value which corresponds to
+                                    the record/replay instruction count
+                                    when the snapshot was taken. Set to -1
+                                    if icount was disabled
+
                     Version 3 images must include extra data at least up to
                     byte 55.
 
diff --git a/tests/qemu-iotests/261 b/tests/qemu-iotests/261
index ddcb04f285..848ffa760d 100755
--- a/tests/qemu-iotests/261
+++ b/tests/qemu-iotests/261
@@ -91,7 +91,10 @@ print_snapshot_table()
         if [ $extra_len -ge 16 ]; then
             echo "    Disk size: $(peek_file_be "$1" $((extra_ofs + 8)) 8)"
         fi
-        if [ $extra_len -gt 16 ]; then
+        if [ $extra_len -ge 24 ]; then
+            echo "    Icount: $(peek_file_be "$1" $((extra_ofs + 16)) 8)"
+        fi
+        if [ $extra_len -gt 24 ]; then
             echo '    Unknown extra data:' \
                 "$(peek_file_raw "$1" $((extra_ofs + 16)) $((extra_len - 16)) \
                    | tr -d '\0')"
@@ -198,12 +201,12 @@ truncate -s 0 "$TEST_DIR/sn0-extra"
 truncate -s $(($(snapshot_table_entry_size "$TEST_DIR/sn0-pre") - 40)) \
     "$TEST_DIR/sn0-post"
 
-# Set sn1's extra data size to 42
-poke_file "$TEST_DIR/sn1-pre" 36 '\x00\x00\x00\x2a'
-truncate -s 42 "$TEST_DIR/sn1-extra"
-poke_file "$TEST_DIR/sn1-extra" 16 'very important data'
+# Set sn1's extra data size to 50
+poke_file "$TEST_DIR/sn1-pre" 36 '\x00\x00\x00\x32'
+truncate -s 50 "$TEST_DIR/sn1-extra"
+poke_file "$TEST_DIR/sn1-extra" 24 'very important data'
 # Grow sn1-post to pad
-truncate -s $(($(snapshot_table_entry_size "$TEST_DIR/sn1-pre") - 82)) \
+truncate -s $(($(snapshot_table_entry_size "$TEST_DIR/sn1-pre") - 90)) \
     "$TEST_DIR/sn1-post"
 
 # Set sn2's extra data size to 8
diff --git a/tests/qemu-iotests/261.out b/tests/qemu-iotests/261.out
index 2600354566..612433ae40 100644
--- a/tests/qemu-iotests/261.out
+++ b/tests/qemu-iotests/261.out
@@ -12,9 +12,10 @@ Snapshots in TEST_DIR/t.IMGFMT.v2.orig:
   [1]
     ID: 2
     Name: sn1
-    Extra data size: 42
+    Extra data size: 50
     VM state size: 0
     Disk size: 67108864
+    Icount: 0
     Unknown extra data: very important data
   [2]
     ID: 3
@@ -29,22 +30,25 @@ Snapshots in TEST_DIR/t.IMGFMT.v3.orig:
   [0]
     ID: 1
     Name: sn0
-    Extra data size: 16
+    Extra data size: 24
     VM state size: 0
     Disk size: 67108864
+    Icount: 18446744073709551615
   [1]
     ID: 2
     Name: sn1
-    Extra data size: 42
+    Extra data size: 50
     VM state size: 0
     Disk size: 67108864
+    Icount: 0
     Unknown extra data: very important data
   [2]
     ID: 3
     Name: sn2
-    Extra data size: 16
+    Extra data size: 24
     VM state size: 0
     Disk size: 67108864
+    Icount: 18446744073709551615
 
 === Repair botched v3 ===
 
@@ -61,22 +65,25 @@ Snapshots in TEST_DIR/t.IMGFMT:
   [0]
     ID: 1
     Name: sn0
-    Extra data size: 16
+    Extra data size: 24
     VM state size: 0
     Disk size: 67108864
+    Icount: 18446744073709551615
   [1]
     ID: 2
     Name: sn1
-    Extra data size: 42
+    Extra data size: 50
     VM state size: 0
     Disk size: 67108864
+    Icount: 0
     Unknown extra data: very important data
   [2]
     ID: 3
     Name: sn2
-    Extra data size: 16
+    Extra data size: 24
     VM state size: 0
     Disk size: 67108864
+    Icount: 18446744073709551615
 
 === Add new snapshot ===
 
@@ -85,28 +92,32 @@ Snapshots in TEST_DIR/t.IMGFMT:
   [0]
     ID: 1
     Name: sn0
-    Extra data size: 16
+    Extra data size: 24
     VM state size: 0
     Disk size: 67108864
+    Icount: 18446744073709551615
   [1]
     ID: 2
     Name: sn1
-    Extra data size: 42
+    Extra data size: 50
     VM state size: 0
     Disk size: 67108864
+    Icount: 0
     Unknown extra data: very important data
   [2]
     ID: 3
     Name: sn2
-    Extra data size: 16
+    Extra data size: 24
     VM state size: 0
     Disk size: 67108864
+    Icount: 18446744073709551615
   [3]
     ID: 4
     Name: sn3
-    Extra data size: 16
+    Extra data size: 24
     VM state size: 0
     Disk size: 67108864
+    Icount: 0
 
 === Remove different snapshots ===
 
@@ -116,16 +127,18 @@ Snapshots in TEST_DIR/t.IMGFMT:
   [0]
     ID: 2
     Name: sn1
-    Extra data size: 42
+    Extra data size: 50
     VM state size: 0
     Disk size: 67108864
+    Icount: 0
     Unknown extra data: very important data
   [1]
     ID: 3
     Name: sn2
-    Extra data size: 16
+    Extra data size: 24
     VM state size: 0
     Disk size: 67108864
+    Icount: 18446744073709551615
 
 --- sn1 ---
 No errors were found on the image.
@@ -133,15 +146,17 @@ Snapshots in TEST_DIR/t.IMGFMT:
   [0]
     ID: 1
     Name: sn0
-    Extra data size: 16
+    Extra data size: 24
     VM state size: 0
     Disk size: 67108864
+    Icount: 18446744073709551615
   [1]
     ID: 3
     Name: sn2
-    Extra data size: 16
+    Extra data size: 24
     VM state size: 0
     Disk size: 67108864
+    Icount: 18446744073709551615
 
 --- sn2 ---
 No errors were found on the image.
@@ -149,15 +164,17 @@ Snapshots in TEST_DIR/t.IMGFMT:
   [0]
     ID: 1
     Name: sn0
-    Extra data size: 16
+    Extra data size: 24
     VM state size: 0
     Disk size: 67108864
+    Icount: 18446744073709551615
   [1]
     ID: 2
     Name: sn1
-    Extra data size: 42
+    Extra data size: 50
     VM state size: 0
     Disk size: 67108864
+    Icount: 0
     Unknown extra data: very important data
 
 === Reject too much unknown extra data ===
-- 
2.26.2



