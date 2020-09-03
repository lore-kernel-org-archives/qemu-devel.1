Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F90C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:20:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4590F206CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvmswsPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4590F206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwel-0000yz-Bc
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwKx-0003Kj-5O; Thu, 03 Sep 2020 17:00:03 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwKu-0007ML-UO; Thu, 03 Sep 2020 17:00:02 -0400
Received: by mail-oi1-x241.google.com with SMTP id w16so4535214oia.2;
 Thu, 03 Sep 2020 14:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=WbB6VAhtrBT4SG9Vr6ej0HJWL2xXc11PC/dJaX/FHdI=;
 b=IvmswsPYXOQ5wSszAzBpxdaKmcOafWtZkUB74WnlL4Fa0nuwnoFdyZaPq8NW5lQ7ik
 Z9ib/HyJN2+dB0GsWkEFOW/G6EDyPi85j3pqG+/aYJn8SMCY157Q+X7k/5mrh0FTfoN2
 G02ecmiRMCLnEbLKbsBdVoTzSDJj6/Mmd0t/ietrmXi+SMccieyFiqOl35rghu2Lrb3m
 D6ExOd7aQdfXI04MJ6fLvIVB1pqRRQddDe+N78MMOOdGLRXy3u50SVvk1sTuL1pf4QkY
 mIbnxCnFbtGHQvF4RYxU0bo/GkoX3X762w+QdTECEsfhKN0vOzjuF6WYT8ka7Q1RHwPh
 qCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=WbB6VAhtrBT4SG9Vr6ej0HJWL2xXc11PC/dJaX/FHdI=;
 b=BlK9Jt68MqTccY1e54l8ABmOUs/CTJmv+TpGO4zWOHaGflwuRZkpupspyLthEEsDQO
 0UcOFvsNCF/B1ACJW3wb5BzcJjaSghXkgBy71R5sCIZsertHAKT/AMrenGvXPWdXIDEw
 +tnOuqd493lf02I290XHAKpO32jmLduQJSLkODS1WXkNYpDJ9CFSRBRxbJ8sJY2gYXy+
 F1P9PIfySGfV5cOHzzQeaa7tT4alodclRDybUmU5uZ0i5GNk8hJetxXgF4V2aWR7KhwH
 WfwNMNRTKYJktBD1qgYRPHAhWsE+/4ewSChxdAHe22Og5/JjcYVDNb5TVSboczPcIQrV
 2ByA==
X-Gm-Message-State: AOAM530nwNmm/XDDjkKfH1k6SDMUJ1y7/q39Xc3EOF118cyCYKV5YQ6Y
 oY0bDUaEMZNOe8u3FRrW2tCZEs/+0dA=
X-Google-Smtp-Source: ABdhPJxor51/r4+wQK9BhGxTVJ/eSzH8MFU+af+VMR1muKggmi7rEH80t5SiRO8rdssLEYicpL2X5w==
X-Received: by 2002:aca:bc57:: with SMTP id m84mr3224034oif.14.1599166799088; 
 Thu, 03 Sep 2020 13:59:59 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id x38sm776992ota.72.2020.09.03.13.59.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 13:59:58 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/77] xen/9pfs: yield when there isn't enough room on the ring
Date: Thu,  3 Sep 2020 15:58:33 -0500
Message-Id: <20200903205935.27832-16-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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
Cc: Stefano Stabellini <stefano.stabellini@xilinx.com>, qemu-stable@nongnu.org,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefano Stabellini <stefano.stabellini@xilinx.com>

Instead of truncating replies, which is problematic, wait until the
client reads more data and frees bytes on the reply ring.

Do that by calling qemu_coroutine_yield(). The corresponding
qemu_coroutine_enter_if_inactive() is called from xen_9pfs_bh upon
receiving the next notification from the client.

We need to be careful to avoid races in case xen_9pfs_bh and the
coroutine are both active at the same time. In xen_9pfs_bh, wait until
either the critical section is over (ring->co == NULL) or until the
coroutine becomes inactive (qemu_coroutine_yield() was called) before
continuing. Then, simply wake up the coroutine if it is inactive.

Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-Id: <20200521192627.15259-2-sstabellini@kernel.org>
Signed-off-by: Greg Kurz <groug@kaod.org>
(cherry picked from commit a4c4d462729466c4756bac8a0a8d77eb63b21ef7)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/9pfs/xen-9p-backend.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index fc197f6c8a..3c84c86ab8 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -37,6 +37,7 @@ typedef struct Xen9pfsRing {
 
     struct iovec *sg;
     QEMUBH *bh;
+    Coroutine *co;
 
     /* local copies, so that we can read/write PDU data directly from
      * the ring */
@@ -198,16 +199,20 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
     g_free(ring->sg);
 
     ring->sg = g_new0(struct iovec, 2);
-    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, size);
+    ring->co = qemu_coroutine_self();
+    /* make sure other threads see ring->co changes before continuing */
+    smp_wmb();
 
+again:
+    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, size);
     buf_size = iov_size(ring->sg, num);
     if (buf_size  < size) {
-        xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs request type %d"
-                "needs %zu bytes, buffer has %zu\n", pdu->id, size,
-                buf_size);
-        xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
-        xen_9pfs_disconnect(&xen_9pfs->xendev);
+        qemu_coroutine_yield();
+        goto again;
     }
+    ring->co = NULL;
+    /* make sure other threads see ring->co changes before continuing */
+    smp_wmb();
 
     *piov = ring->sg;
     *pniov = num;
@@ -292,6 +297,20 @@ static int xen_9pfs_receive(Xen9pfsRing *ring)
 static void xen_9pfs_bh(void *opaque)
 {
     Xen9pfsRing *ring = opaque;
+    bool wait;
+
+again:
+    wait = ring->co != NULL && qemu_coroutine_entered(ring->co);
+    /* paired with the smb_wmb barriers in xen_9pfs_init_in_iov_from_pdu */
+    smp_rmb();
+    if (wait) {
+        cpu_relax();
+        goto again;
+    }
+
+    if (ring->co != NULL) {
+        qemu_coroutine_enter_if_inactive(ring->co);
+    }
     xen_9pfs_receive(ring);
 }
 
-- 
2.17.1


