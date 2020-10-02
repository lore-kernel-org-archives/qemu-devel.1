Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F94C4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:42:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A548206A5
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jM994VAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A548206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOP4N-0005wt-2s
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 13:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kOOyc-0000a5-5C
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:36:15 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34154)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kOOyY-0003L3-Th
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:36:12 -0400
Received: by mail-wm1-x343.google.com with SMTP id l15so1578467wmh.1
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 10:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3dT+wfpw6iT83ImSmB/t0Y9AbcGGqtgwVgpoltnvTmU=;
 b=jM994VAwFUd4S6HLbQikrvILMHMn7E6vYTB7EcTD3IqNL9SHCAvCm46tfv1s9bpMwo
 +5ZdUDrE6OtbQtO4dQso6RfvNda5aB3jX35s1g5RiXR8UwBKEifsp1GmTpE5iimE58AT
 B7hc2eG3PjtKdDQlpdpK52QUs0z6TOFaVIDst7JTCw/mmR1oFf41scQo+0RI1FE+ErPq
 sc3K/hRugS49YU8kVSKTUC7IBxRQVGfH06Z5gCkduMWcirgJfiNiMg/9FD9TO7JGoUed
 4aTB1XPnH/f/cWaxpUa2SNkN/tnnOwKUHDhCTwHBtlCMsKOUKOkie5AprHIypZRoGArd
 WZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=3dT+wfpw6iT83ImSmB/t0Y9AbcGGqtgwVgpoltnvTmU=;
 b=GxR9r6k+/VNYEywFYgOfffjvpEDrnUjWCPNiOO+GWeH9MOd9ZCeCmxeZ5pU3HtnC1n
 xKYoaXhqv6f7WsUJauhVwyp+JrMvafZhTM0vfE75FcDAthV3+uJ4Xva0SIPGDA7S57Ea
 muaIIfZ1m+Ky09DHIiGD3nr1+tY2TH+z+ASeq7kCtNQtDAR1037LRwTvfHRcLOcnLSob
 ck22mIEYS26e29PGkgMLgnOm32/vxEryLESDxosvKbcoY4+GZknoFKARGnXj3q5VKpqP
 SXsBss7SuqU5iJR8uff1o2aaqN+VJlvmcX7eG8NdQPTvotQqL+CQr1BTqpwqj9dCEQjg
 5Z9A==
X-Gm-Message-State: AOAM530tmOZNbJBHb8KuD1LlFoofpRMaG8xYh0knTAe7jFDwCksUDeLO
 c6Nf138ETSpvZ2d2xrAzzJTOqM7GbvQ=
X-Google-Smtp-Source: ABdhPJyYuF53zLkewCty6KI9zEMvxliH6sNtLoTafWZ/3+3Fs1FBMvnsO6IoycuRe8jY/qCTTesBxg==
X-Received: by 2002:a1c:7405:: with SMTP id p5mr4042979wmc.35.1601660169085;
 Fri, 02 Oct 2020 10:36:09 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:47e0:e742:75ba:b84d])
 by smtp.gmail.com with ESMTPSA id
 l8sm2516454wrx.22.2020.10.02.10.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 10:36:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 10/10] scsi/scsi_bus: fix races in REPORT LUNS
Date: Fri,  2 Oct 2020 19:35:58 +0200
Message-Id: <20201002173558.232960-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201002173558.232960-1-pbonzini@redhat.com>
References: <20201002173558.232960-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxim Levitsky <mlevitsk@redhat.com>

Currently scsi_target_emulate_report_luns iterates over the child device list
twice, and there is no guarantee that this list is the same in both iterations.

The reason for iterating twice is that the first iteration calculates
how much memory to allocate.  However if we use a dynamic array we can
avoid iterating twice, and therefore we avoid this race.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1866707

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200913160259.32145-10-mlevitsk@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-bus.c | 68 ++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index eda8cb7e70..b901e701f0 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -438,19 +438,23 @@ struct SCSITargetReq {
 static void store_lun(uint8_t *outbuf, int lun)
 {
     if (lun < 256) {
+        /* Simple logical unit addressing method*/
+        outbuf[0] = 0;
         outbuf[1] = lun;
-        return;
+    } else {
+        /* Flat space addressing method */
+        outbuf[0] = 0x40 | (lun >> 8);
+        outbuf[1] = (lun & 255);
     }
-    outbuf[1] = (lun & 255);
-    outbuf[0] = (lun >> 8) | 0x40;
 }
 
 static bool scsi_target_emulate_report_luns(SCSITargetReq *r)
 {
     BusChild *kid;
-    int i, len, n;
     int channel, id;
-    bool found_lun0;
+    uint8_t tmp[8] = {0};
+    int len = 0;
+    GByteArray *buf;
 
     if (r->req.cmd.xfer < 16) {
         return false;
@@ -458,46 +462,40 @@ static bool scsi_target_emulate_report_luns(SCSITargetReq *r)
     if (r->req.cmd.buf[2] > 2) {
         return false;
     }
+
+    /* reserve space for 63 LUNs*/
+    buf = g_byte_array_sized_new(512);
+
     channel = r->req.dev->channel;
     id = r->req.dev->id;
-    found_lun0 = false;
-    n = 0;
 
-    RCU_READ_LOCK_GUARD();
+    /* add size (will be updated later to correct value */
+    g_byte_array_append(buf, tmp, 8);
+    len += 8;
 
-    QTAILQ_FOREACH_RCU(kid, &r->req.bus->qbus.children, sibling) {
-        DeviceState *qdev = kid->child;
-        SCSIDevice *dev = SCSI_DEVICE(qdev);
+    /* add LUN0 */
+    g_byte_array_append(buf, tmp, 8);
+    len += 8;
 
-        if (dev->channel == channel && dev->id == id) {
-            if (dev->lun == 0) {
-                found_lun0 = true;
+    WITH_RCU_READ_LOCK_GUARD() {
+        QTAILQ_FOREACH_RCU(kid, &r->req.bus->qbus.children, sibling) {
+            DeviceState *qdev = kid->child;
+            SCSIDevice *dev = SCSI_DEVICE(qdev);
+
+            if (dev->channel == channel && dev->id == id && dev->lun != 0) {
+                store_lun(tmp, dev->lun);
+                g_byte_array_append(buf, tmp, 8);
+                len += 8;
             }
-            n += 8;
         }
     }
-    if (!found_lun0) {
-        n += 8;
-    }
-
-    scsi_target_alloc_buf(&r->req, n + 8);
-
-    len = MIN(n + 8, r->req.cmd.xfer & ~7);
-    memset(r->buf, 0, len);
-    stl_be_p(&r->buf[0], n);
-    i = found_lun0 ? 8 : 16;
-    QTAILQ_FOREACH_RCU(kid, &r->req.bus->qbus.children, sibling) {
-        DeviceState *qdev = kid->child;
-        SCSIDevice *dev = SCSI_DEVICE(qdev);
 
-        if (dev->channel == channel && dev->id == id) {
-            store_lun(&r->buf[i], dev->lun);
-            i += 8;
-        }
-    }
+    r->buf_len = len;
+    r->buf = g_byte_array_free(buf, FALSE);
+    r->len = MIN(len, r->req.cmd.xfer & ~7);
 
-    assert(i == n + 8);
-    r->len = len;
+    /* store the LUN list length */
+    stl_be_p(&r->buf[0], len - 8);
     return true;
 }
 
-- 
2.26.2


