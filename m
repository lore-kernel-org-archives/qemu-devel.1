Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA18C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:00:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 419412071A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHFf/ehp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419412071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdSdW-00033z-Aw
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 02:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdSbb-0000uo-V9
 for qemu-devel@nongnu.org; Tue, 26 May 2020 01:58:27 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdSbb-0006PX-BD
 for qemu-devel@nongnu.org; Tue, 26 May 2020 01:58:27 -0400
Received: by mail-wr1-x443.google.com with SMTP id q11so6995204wrp.3
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 22:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XH9llzwJNkgaAMSzcOAlp2rXhFcxO11cY7x6A57exXY=;
 b=aHFf/ehpmPAqwjEJlCeZM5aPdV6viwn++bUCLpSu5n0zmL7lxMrCqhxwZl1QcwivFg
 p5QXMV+KMRy8XcR5B4GQdUsL3jWUNvMHNq+uRj5tgM50MI5lx3JEaVck0MqFPWbheFbl
 sIPyyqC1m/8KjA1oYLd21TKX5JyEhnT4rdZl3ObvnzrKm0yUS79VewFMpn17w3FwXwzo
 QyovBimK/0ZrXfaP4I0FSojj/eD7kdkb0wSlRfEvdCI9ZdmdpNjkHSVkIztX97iDhQiV
 uV3MiQN3XiZHLHdPlVkzs8mC/lOQeycpG5NxrPOb3L/h+nt9yxrOxmxhXmvNkdEqkRLC
 bPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=XH9llzwJNkgaAMSzcOAlp2rXhFcxO11cY7x6A57exXY=;
 b=tVveXdM4e0AM0RRji/ubIA+yog4lMArS/9f7fJyc13y7SxfvJ6NmwdWd2nDC0DoNGB
 o1wVEAeATBHqBT7LICXaGrvKj/yMiqVbUNX3vvIgG4T75sY+VKj/+48bwkAC9/sRVg6f
 bFh4V+joHzCLpt9mcCFH9nZ7viwYKZ360F6imurqy8BdmAA9VAmdzKt5D9TfE5t8s1Df
 NM6PE/1y7QnYon57NXX0iz9WrGyWV3/voJLKfHEsqjlGqew3fUz+E8cbR5fQjIrdyZvW
 3CcIHoYsuP7j2vN4vbkHrOGggafbOWx12rb2QGlAd3nQ5dUQFdG8krqVBwcDkvpDKDpg
 6OWA==
X-Gm-Message-State: AOAM532M+LSwGbI6x4FdJHEb9pYLbqDrT8OG/1HT0TL9402lWrO44j9+
 rJICImPUFPblw7pai9CHNvDDZlP01H0=
X-Google-Smtp-Source: ABdhPJyyUQp3zN3S4xY1NQtqj8OZQkL8c4d30WjEA4+KFoo+U7feaDO+oIwQq6qmpqmnPRNF2aBQrA==
X-Received: by 2002:a5d:694a:: with SMTP id r10mr8862386wrw.266.1590472705874; 
 Mon, 25 May 2020 22:58:25 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id s8sm19887710wrt.69.2020.05.25.22.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 22:58:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] tests/qtest/fuzz: Avoid QTest mmio serialization
Date: Tue, 26 May 2020 07:58:20 +0200
Message-Id: <20200526055820.12999-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526055820.12999-1-f4bug@amsat.org>
References: <20200526055820.12999-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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

virtio-net-socket gets ~50% performance improvement.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/qtest/fuzz/virtio_net_fuzz.c  | 6 ++++--
 tests/qtest/fuzz/virtio_scsi_fuzz.c | 6 +++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/fuzz/virtio_net_fuzz.c b/tests/qtest/fuzz/virtio_net_fuzz.c
index d08a47e278..ec993c9d5f 100644
--- a/tests/qtest/fuzz/virtio_net_fuzz.c
+++ b/tests/qtest/fuzz/virtio_net_fuzz.c
@@ -19,6 +19,8 @@
 #include "fork_fuzz.h"
 #include "qos_fuzz.h"
 
+#include "exec/address-spaces.h"
+#include "hw/core/cpu.h"
 
 #define QVIRTIO_NET_TIMEOUT_US (30 * 1000 * 1000)
 #define QVIRTIO_RX_VQ 0
@@ -69,8 +71,8 @@ static void virtio_net_fuzz_multi(QTestState *s,
              * If checking used ring, ensure that the fuzzer doesn't trigger
              * trivial asserion failure on zero-zied buffer
              */
-            qtest_memwrite(s, req_addr, Data, vqa.length);
-
+            address_space_write(first_cpu->as, req_addr, MEMTXATTRS_UNSPECIFIED,
+                                &Data, vqa.length);
 
             free_head = qvirtqueue_add(s, q, req_addr, vqa.length,
                     vqa.write, vqa.next);
diff --git a/tests/qtest/fuzz/virtio_scsi_fuzz.c b/tests/qtest/fuzz/virtio_scsi_fuzz.c
index 3b95247f12..5096a5a730 100644
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
@@ -108,7 +111,8 @@ static void virtio_scsi_fuzz(QTestState *s, QVirtioSCSIQueues* queues,
 
         /* Copy the data into ram, and place it on the virtqueue */
         uint64_t req_addr = guest_alloc(t_alloc, vqa.length);
-        qtest_memwrite(s, req_addr, Data, vqa.length);
+        address_space_write(first_cpu->as, req_addr, MEMTXATTRS_UNSPECIFIED,
+                            &Data, vqa.length);
         if (vq_touched[vqa.queue] == 0) {
             vq_touched[vqa.queue] = 1;
             free_head[vqa.queue] = qvirtqueue_add(s, q, req_addr, vqa.length,
-- 
2.21.3


