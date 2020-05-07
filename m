Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6E0C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 11:02:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5CEB2083B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 11:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1vSwoK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5CEB2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWeIJ-0005oC-QB
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 07:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jWeH6-0004vf-T4
 for qemu-devel@nongnu.org; Thu, 07 May 2020 07:01:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44560
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jWeH5-0000JO-QY
 for qemu-devel@nongnu.org; Thu, 07 May 2020 07:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588849265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ucJW6YRG27yTLifxVgOu0eCVP2hNaEp/EhH/srKQNfc=;
 b=h1vSwoK/G/xYPN27LUDMgL9/2Miha99NxnL4tUdJCKDhphEL2SMijA7vkY3VI2+pItVyH9
 pj2nTMibXMJYPudc+6pqAPickerJrLKexZhvRYDRrofj9AccCKZXs5Zn0hgNosYg5hRz1P
 gY8xqP9/nX7K9Zwj55IzRQ914MO/lmE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-F2EGXU3yMX2ayNeIm5a8gQ-1; Thu, 07 May 2020 06:59:31 -0400
X-MC-Unique: F2EGXU3yMX2ayNeIm5a8gQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D154B80183C;
 Thu,  7 May 2020 10:59:29 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.74.8.13])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A158649A9;
 Thu,  7 May 2020 10:59:27 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Subject: [PATCH 2/2] megasas: use unsigned type for positive numeric fields
Date: Thu,  7 May 2020 16:27:18 +0530
Message-Id: <20200507105718.1319187-3-ppandit@redhat.com>
In-Reply-To: <20200507105718.1319187-1-ppandit@redhat.com>
References: <20200507105718.1319187-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 02:00:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Ren Ding <rding@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Use unsigned type for the MegasasState fields which hold positive
numeric values.

Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/scsi/megasas.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 433353bad0..fffcb18bdb 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -86,34 +86,34 @@ typedef struct MegasasState {
     MemoryRegion queue_io;
     uint32_t frame_hi;
=20
-    int fw_state;
+    uint32_t fw_state;
     uint32_t fw_sge;
     uint32_t fw_cmds;
     uint32_t flags;
-    int fw_luns;
-    int intr_mask;
-    int doorbell;
-    int busy;
-    int diag;
-    int adp_reset;
+    uint32_t fw_luns;
+    uint32_t intr_mask;
+    uint32_t doorbell;
+    uint32_t busy;
+    uint32_t diag;
+    uint32_t adp_reset;
     OnOffAuto msi;
     OnOffAuto msix;
=20
     MegasasCmd *event_cmd;
-    int event_locale;
+    uint16_t event_locale;
     int event_class;
-    int event_count;
-    int shutdown_event;
-    int boot_event;
+    uint32_t event_count;
+    uint32_t shutdown_event;
+    uint32_t boot_event;
=20
     uint64_t sas_addr;
     char *hba_serial;
=20
     uint64_t reply_queue_pa;
     void *reply_queue;
-    int reply_queue_len;
+    uint16_t reply_queue_len;
     uint16_t reply_queue_head;
-    int reply_queue_tail;
+    uint16_t reply_queue_tail;
     uint64_t consumer_pa;
     uint64_t producer_pa;
=20
@@ -2259,9 +2259,9 @@ static const VMStateDescription vmstate_megasas_gen1 =
=3D {
         VMSTATE_PCI_DEVICE(parent_obj, MegasasState),
         VMSTATE_MSIX(parent_obj, MegasasState),
=20
-        VMSTATE_INT32(fw_state, MegasasState),
-        VMSTATE_INT32(intr_mask, MegasasState),
-        VMSTATE_INT32(doorbell, MegasasState),
+        VMSTATE_UINT32(fw_state, MegasasState),
+        VMSTATE_UINT32(intr_mask, MegasasState),
+        VMSTATE_UINT32(doorbell, MegasasState),
         VMSTATE_UINT64(reply_queue_pa, MegasasState),
         VMSTATE_UINT64(consumer_pa, MegasasState),
         VMSTATE_UINT64(producer_pa, MegasasState),
@@ -2278,9 +2278,9 @@ static const VMStateDescription vmstate_megasas_gen2 =
=3D {
         VMSTATE_PCI_DEVICE(parent_obj, MegasasState),
         VMSTATE_MSIX(parent_obj, MegasasState),
=20
-        VMSTATE_INT32(fw_state, MegasasState),
-        VMSTATE_INT32(intr_mask, MegasasState),
-        VMSTATE_INT32(doorbell, MegasasState),
+        VMSTATE_UINT32(fw_state, MegasasState),
+        VMSTATE_UINT32(intr_mask, MegasasState),
+        VMSTATE_UINT32(doorbell, MegasasState),
         VMSTATE_UINT64(reply_queue_pa, MegasasState),
         VMSTATE_UINT64(consumer_pa, MegasasState),
         VMSTATE_UINT64(producer_pa, MegasasState),
--=20
2.25.4


