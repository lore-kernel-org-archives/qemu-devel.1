Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D648C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 22:34:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 063CE204EC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 22:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VyLvyuW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 063CE204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6LnZ-0008Rf-9j
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 18:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k6LgE-0004uY-Cs
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 18:26:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29964
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k6LgB-0002of-NP
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 18:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597357594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+IPsPfjQQXtFCSiQ2JA/03hk2P6G+mxGHlD5ub3oDPg=;
 b=VyLvyuW2RtJs7tIcmWWpZb6jS4ohxVNcAJkpRXNrh1ncXRu4M/WXcSkuq/m1HkxhG/ThZ9
 CF+vDQ6oqxzAcmCC/Q2mLmWk3GSkTfN0/fKOnNShM3TutAr8dsHZF/tDTRQMYpmM3RjK4T
 ia9DQTgCYV8M04XPbjnb7ornS41TiBg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-MwzOlMfSMyKDvhiiJrRcLg-1; Thu, 13 Aug 2020 18:26:32 -0400
X-MC-Unique: MwzOlMfSMyKDvhiiJrRcLg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B05FF57086
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 22:26:31 +0000 (UTC)
Received: from localhost (ovpn-117-153.rdu2.redhat.com [10.10.117.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C5005D9D2;
 Thu, 13 Aug 2020 22:26:31 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/41] megasas: Rename QOM class cast macros
Date: Thu, 13 Aug 2020 18:25:47 -0400
Message-Id: <20200813222625.243136-4-ehabkost@redhat.com>
In-Reply-To: <20200813222625.243136-1-ehabkost@redhat.com>
References: <20200813222625.243136-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 18:26:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename the MEGASAS_DEVICE_CLASS() and MEGASAS_DEVICE_GET_CLASS()
macros to be consistent with the MEGASAS() instance cast macro.

This will allow us to register the type cast macros using
OBJECT_DECLARE_TYPE later.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/scsi/megasas.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 5cfd1bf22e..390c2f2edb 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -134,9 +134,9 @@ typedef struct MegasasBaseClass {
 #define MEGASAS(obj) \
     OBJECT_CHECK(MegasasState, (obj), TYPE_MEGASAS_BASE)
 
-#define MEGASAS_DEVICE_CLASS(oc) \
+#define MEGASAS_CLASS(oc) \
     OBJECT_CLASS_CHECK(MegasasBaseClass, (oc), TYPE_MEGASAS_BASE)
-#define MEGASAS_DEVICE_GET_CLASS(oc) \
+#define MEGASAS_GET_CLASS(oc) \
     OBJECT_GET_CLASS(MegasasBaseClass, (oc), TYPE_MEGASAS_BASE)
 
 #define MEGASAS_INTR_DISABLED_MASK 0xFFFFFFFF
@@ -733,7 +733,7 @@ static int megasas_ctrl_get_info(MegasasState *s, MegasasCmd *cmd)
 {
     PCIDevice *pci_dev = PCI_DEVICE(s);
     PCIDeviceClass *pci_class = PCI_DEVICE_GET_CLASS(pci_dev);
-    MegasasBaseClass *base_class = MEGASAS_DEVICE_GET_CLASS(s);
+    MegasasBaseClass *base_class = MEGASAS_GET_CLASS(s);
     struct mfi_ctrl_info info;
     size_t dcmd_size = sizeof(info);
     BusChild *kid;
@@ -1999,7 +1999,7 @@ static uint64_t megasas_mmio_read(void *opaque, hwaddr addr,
 {
     MegasasState *s = opaque;
     PCIDevice *pci_dev = PCI_DEVICE(s);
-    MegasasBaseClass *base_class = MEGASAS_DEVICE_GET_CLASS(s);
+    MegasasBaseClass *base_class = MEGASAS_GET_CLASS(s);
     uint32_t retval = 0;
 
     switch (addr) {
@@ -2322,7 +2322,7 @@ static const struct SCSIBusInfo megasas_scsi_info = {
 static void megasas_scsi_realize(PCIDevice *dev, Error **errp)
 {
     MegasasState *s = MEGASAS(dev);
-    MegasasBaseClass *b = MEGASAS_DEVICE_GET_CLASS(s);
+    MegasasBaseClass *b = MEGASAS_GET_CLASS(s);
     uint8_t *pci_conf;
     int i, bar_type;
     Error *err = NULL;
@@ -2506,7 +2506,7 @@ static void megasas_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
-    MegasasBaseClass *e = MEGASAS_DEVICE_CLASS(oc);
+    MegasasBaseClass *e = MEGASAS_CLASS(oc);
     const MegasasInfo *info = data;
 
     pc->realize = megasas_scsi_realize;
-- 
2.26.2


