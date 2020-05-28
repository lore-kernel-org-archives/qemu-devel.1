Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275C2C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 16:54:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E942D207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 16:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u6Igfaqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E942D207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeLn8-0002NI-2Q
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 12:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jeLmH-0001NT-Ti
 for qemu-devel@nongnu.org; Thu, 28 May 2020 12:53:09 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:40076)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jeLmH-00058x-0V
 for qemu-devel@nongnu.org; Thu, 28 May 2020 12:53:09 -0400
Received: by mail-wm1-x32e.google.com with SMTP id r15so4063806wmh.5
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 09:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K/nysHAqgFCs6bMEH8BvGy1RP6HKrbBmm6plo1b4lp4=;
 b=u6Igfaqc1Uryrk4pb7w5BtfIk3lrCxY1sssNd6FcABDLIia/2jctL0Zd6kO+Gih+cC
 9RU12ZH8VmdsQrP5PMESfHLTzyutUliPVNM4VFsTSHgWl8jAX4Mp6jzbP1/zpip4ya8A
 t3qFRm2a2O5fJFRniZz2Yi46pu19gEaF+vhbK5RVZCpC/hfBrrYo+xFNUuefVvKOGjtK
 wsKNT1B+Yu1UhDpWEy81Qj1hSYu3Vl1Wn4nbTLjVT+dOdgy1cT/Lzd75u+vyzwCYxEWi
 lcutkyxGHzLLC8u/CTZZh5BuVqwoRkwltSqKCWWtQd9zMGye+ImAY8rXo2YwJY9Rqx6V
 qi1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=K/nysHAqgFCs6bMEH8BvGy1RP6HKrbBmm6plo1b4lp4=;
 b=Kvu1u1YrE6FiPBCewCjTTrI2sPAZbiugKzyTnYhMUGfqIC21aQNiAS0Nc6h16y3znW
 HWDdSakBgCwSjlrCDlwvNEh063bXm+OniJjdVlmofVUlzQcpJkGWV3KxDh26W/S6omZM
 ePHP+RemJo8n+ZYnQBIMokdcC7+wL2z4xTlfsu4piDfGUUr9nwhcylW3cs6SB5b0L/0K
 dl5ECpMDMiCgY6W5JxJ1IdKqr4DfyapVd36++C3O+DblR4m9DXkOas9K7GEcsbfc1GZL
 9jtBhD5sBY3mo54IbRR5fYG2lBpuR1gSccwR7qQ2+UhOYAJ4SPF9wMjrx74ey/QQkbDi
 uvxg==
X-Gm-Message-State: AOAM532TLA28MzBsGCR1Ub4MBg2JZVSYkuJZ+6xVK/uvSgjt8SaPL+dU
 vCZrmIPpbk3CHNwVkDaPH4ncVY9D
X-Google-Smtp-Source: ABdhPJwtj0QzkqutMiQd2bAZKpnpOacId9n+bkgGwVBfg34qi4h4WQHA94m21mGqUfZT5FQLRpZeJg==
X-Received: by 2002:a7b:cbd0:: with SMTP id n16mr4461132wmi.38.1590684787183; 
 Thu, 28 May 2020 09:53:07 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id o15sm7445447wmm.31.2020.05.28.09.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 09:53:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/1] tests/qtest/fuzz: Add faster virtio tests
Date: Thu, 28 May 2020 18:53:03 +0200
Message-Id: <20200528165303.1877-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200528165303.1877-1-f4bug@amsat.org>
References: <20200528165303.1877-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't need to serialize over QTest chardev when we can
directly access the MMIO address space via the first
registered CPU view.
Rename the currents tests as $TEST-qtest, add add faster
tests that don't use the qtest chardev.

virtio-net-socket gets ~50% performance improvement.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/qtest/fuzz/virtio_net_fuzz.c  | 42 ++++++++++++++++++++---
 tests/qtest/fuzz/virtio_scsi_fuzz.c | 53 +++++++++++++++++++++++++----
 2 files changed, 84 insertions(+), 11 deletions(-)

diff --git a/tests/qtest/fuzz/virtio_net_fuzz.c b/tests/qtest/fuzz/virtio_net_fuzz.c
index d08a47e278..7a39cfbb75 100644
--- a/tests/qtest/fuzz/virtio_net_fuzz.c
+++ b/tests/qtest/fuzz/virtio_net_fuzz.c
@@ -19,6 +19,8 @@
 #include "fork_fuzz.h"
 #include "qos_fuzz.h"
 
+#include "exec/address-spaces.h"
+#include "hw/core/cpu.h"
 
 #define QVIRTIO_NET_TIMEOUT_US (30 * 1000 * 1000)
 #define QVIRTIO_RX_VQ 0
@@ -29,7 +31,9 @@ static int sockfds[2];
 static bool sockfds_initialized;
 
 static void virtio_net_fuzz_multi(QTestState *s,
-        const unsigned char *Data, size_t Size, bool check_used)
+                                  const unsigned char *Data, size_t Size,
+                                  bool check_used, bool use_qtest_chardev)
+
 {
     typedef struct vq_action {
         uint8_t queue;
@@ -69,8 +73,13 @@ static void virtio_net_fuzz_multi(QTestState *s,
              * If checking used ring, ensure that the fuzzer doesn't trigger
              * trivial asserion failure on zero-zied buffer
              */
-            qtest_memwrite(s, req_addr, Data, vqa.length);
-
+            if (use_qtest_chardev) {
+                qtest_memwrite(s, req_addr, Data, vqa.length);
+            } else {
+                address_space_write(first_cpu->as, req_addr,
+                                     MEMTXATTRS_UNSPECIFIED,
+                                     &Data, vqa.length);
+            }
 
             free_head = qvirtqueue_add(s, q, req_addr, vqa.length,
                     vqa.write, vqa.next);
@@ -118,7 +127,20 @@ static void virtio_net_fork_fuzz(QTestState *s,
         const unsigned char *Data, size_t Size)
 {
     if (fork() == 0) {
-        virtio_net_fuzz_multi(s, Data, Size, false);
+        virtio_net_fuzz_multi(s, Data, Size, false, false);
+        flush_events(s);
+        _Exit(0);
+    } else {
+        wait(NULL);
+    }
+}
+
+static void virtio_net_fork_fuzz_qtest(QTestState *s,
+                                       const unsigned char *Data,
+                                       size_t Size)
+{
+    if (fork() == 0) {
+        virtio_net_fuzz_multi(s, Data, Size, false, true);
         flush_events(s);
         _Exit(0);
     } else {
@@ -130,7 +152,7 @@ static void virtio_net_fork_fuzz_check_used(QTestState *s,
         const unsigned char *Data, size_t Size)
 {
     if (fork() == 0) {
-        virtio_net_fuzz_multi(s, Data, Size, true);
+        virtio_net_fuzz_multi(s, Data, Size, true, false);
         flush_events(s);
         _Exit(0);
     } else {
@@ -173,6 +195,16 @@ static void register_virtio_net_fuzz_targets(void)
             &(QOSGraphTestOptions){.before = virtio_net_test_setup_socket}
             );
 
+    fuzz_add_qos_target(&(FuzzTarget){
+            .name = "virtio-net-socket-qtest",
+            .description = "Fuzz the virtio-net virtual queues. Fuzz incoming "
+            "traffic using the socket backend (over a qtest chardev)",
+            .pre_fuzz = &virtio_net_pre_fuzz,
+            .fuzz = virtio_net_fork_fuzz_qtest,},
+            "virtio-net",
+            &(QOSGraphTestOptions){.before = virtio_net_test_setup_socket}
+            );
+
     fuzz_add_qos_target(&(FuzzTarget){
             .name = "virtio-net-socket-check-used",
             .description = "Fuzz the virtio-net virtual queues. Wait for the "
diff --git a/tests/qtest/fuzz/virtio_scsi_fuzz.c b/tests/qtest/fuzz/virtio_scsi_fuzz.c
index 3b95247f12..27b63b2e32 100644
--- a/tests/qtest/fuzz/virtio_scsi_fuzz.c
+++ b/tests/qtest/fuzz/virtio_scsi_fuzz.c
@@ -23,6 +23,9 @@
 #include "fork_fuzz.h"
 #include "qos_fuzz.h"
 
+#include "exec/address-spaces.h"
+#include "hw/core/cpu.h"
+
 #define PCI_SLOT                0x02
 #define PCI_FN                  0x00
 #define QVIRTIO_SCSI_TIMEOUT_US (1 * 1000 * 1000)
@@ -63,7 +66,8 @@ static QVirtioSCSIQueues *qvirtio_scsi_init(QVirtioDevice *dev, uint64_t mask)
 }
 
 static void virtio_scsi_fuzz(QTestState *s, QVirtioSCSIQueues* queues,
-        const unsigned char *Data, size_t Size)
+                             const unsigned char *Data, size_t Size,
+                             bool use_qtest_chardev)
 {
     /*
      * Data is a sequence of random bytes. We split them up into "actions",
@@ -108,7 +112,13 @@ static void virtio_scsi_fuzz(QTestState *s, QVirtioSCSIQueues* queues,
 
         /* Copy the data into ram, and place it on the virtqueue */
         uint64_t req_addr = guest_alloc(t_alloc, vqa.length);
-        qtest_memwrite(s, req_addr, Data, vqa.length);
+        if (use_qtest_chardev) {
+            qtest_memwrite(s, req_addr, Data, vqa.length);
+        } else {
+            address_space_write(first_cpu->as, req_addr,
+                                 MEMTXATTRS_UNSPECIFIED,
+                                 &Data, vqa.length);
+        }
         if (vq_touched[vqa.queue] == 0) {
             vq_touched[vqa.queue] = 1;
             free_head[vqa.queue] = qvirtqueue_add(s, q, req_addr, vqa.length,
@@ -141,7 +151,25 @@ static void virtio_scsi_fork_fuzz(QTestState *s,
         queues = qvirtio_scsi_init(scsi->vdev, 0);
     }
     if (fork() == 0) {
-        virtio_scsi_fuzz(s, queues, Data, Size);
+        virtio_scsi_fuzz(s, queues, Data, Size, false);
+        flush_events(s);
+        _Exit(0);
+    } else {
+        wait(NULL);
+    }
+}
+
+static void virtio_scsi_fork_fuzz_qtest(QTestState *s,
+                                        const unsigned char *Data,
+                                        size_t Size)
+{
+    QVirtioSCSI *scsi = fuzz_qos_obj;
+    static QVirtioSCSIQueues *queues;
+    if (!queues) {
+        queues = qvirtio_scsi_init(scsi->vdev, 0);
+    }
+    if (fork() == 0) {
+        virtio_scsi_fuzz(s, queues, Data, Size, true);
         flush_events(s);
         _Exit(0);
     } else {
@@ -159,7 +187,9 @@ static void virtio_scsi_with_flag_fuzz(QTestState *s,
         if (Size >= sizeof(uint64_t)) {
             queues = qvirtio_scsi_init(scsi->vdev, *(uint64_t *)Data);
             virtio_scsi_fuzz(s, queues,
-                             Data + sizeof(uint64_t), Size - sizeof(uint64_t));
+                             Data + sizeof(uint64_t),
+                             Size - sizeof(uint64_t),
+                             false);
             flush_events(s);
         }
         _Exit(0);
@@ -189,7 +219,7 @@ static void register_virtio_scsi_fuzz_targets(void)
 {
     fuzz_add_qos_target(&(FuzzTarget){
                 .name = "virtio-scsi-fuzz",
-                .description = "Fuzz the virtio-scsi virtual queues, forking"
+                .description = "Fuzz the virtio-scsi virtual queues, forking "
                                 "for each fuzz run",
                 .pre_vm_init = &counter_shm_init,
                 .pre_fuzz = &virtio_scsi_pre_fuzz,
@@ -198,9 +228,20 @@ static void register_virtio_scsi_fuzz_targets(void)
                 &(QOSGraphTestOptions){.before = virtio_scsi_test_setup}
                 );
 
+    fuzz_add_qos_target(&(FuzzTarget){
+                .name = "virtio-scsi-fuzz-qtest",
+                .description = "Fuzz the virtio-scsi virtual queues, forking "
+                                "for each fuzz run (over a qtest chardev)",
+                .pre_vm_init = &counter_shm_init,
+                .pre_fuzz = &virtio_scsi_pre_fuzz,
+                .fuzz = virtio_scsi_fork_fuzz_qtest,},
+                "virtio-scsi",
+                &(QOSGraphTestOptions){.before = virtio_scsi_test_setup}
+                );
+
     fuzz_add_qos_target(&(FuzzTarget){
                 .name = "virtio-scsi-flags-fuzz",
-                .description = "Fuzz the virtio-scsi virtual queues, forking"
+                .description = "Fuzz the virtio-scsi virtual queues, forking "
                 "for each fuzz run (also fuzzes the virtio flags)",
                 .pre_vm_init = &counter_shm_init,
                 .pre_fuzz = &virtio_scsi_pre_fuzz,
-- 
2.21.3


