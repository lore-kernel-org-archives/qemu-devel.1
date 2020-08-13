Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EBFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 22:32:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B807207DA
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 22:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RB08D6Ja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B807207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6LlX-000536-FF
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 18:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k6LgD-0004tm-P3
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 18:26:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51637
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k6LgB-0002ok-Ut
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 18:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597357595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ubFG9258ksaM+YE1gG4xfg6uJDM8FoGJb0qcKKBZGcg=;
 b=RB08D6JaBf0G6j6sik1fwejW+gnmy8yrXhZmKUDpWKAZoulIsbYauc27UMdciKVAvYDbJh
 12Ya7cXelY9fpZX0KBhWHVztpBV5eXOicTrOQGDEt/Ti//quk9S/AGmRXQe1T3aaAGiH8B
 sl5hYjxGKfMy0VJ/Qd//q0VMlPObBUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-IhzblaBGNUqZXHCLGOZJ9g-1; Thu, 13 Aug 2020 18:26:33 -0400
X-MC-Unique: IhzblaBGNUqZXHCLGOZJ9g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9E7818B9EC1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 22:26:32 +0000 (UTC)
Received: from localhost (ovpn-117-153.rdu2.redhat.com [10.10.117.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F81619482;
 Thu, 13 Aug 2020 22:26:32 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/41] vmw_pvscsi: Rename QOM class cast macros
Date: Thu, 13 Aug 2020 18:25:48 -0400
Message-Id: <20200813222625.243136-5-ehabkost@redhat.com>
In-Reply-To: <20200813222625.243136-1-ehabkost@redhat.com>
References: <20200813222625.243136-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

Rename the PVSCSI_DEVICE_CLASS() and PVSCSI_DEVICE_GET_CLASS()
macros to be consistent with the PVSCSI() instance cast macro.

This will allow us to register the type cast macros using
OBJECT_DECLARE_TYPE later.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/scsi/vmw_pvscsi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index df07ab6bfb..c071e0c7aa 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -64,9 +64,9 @@ typedef struct PVSCSIClass {
 #define TYPE_PVSCSI "pvscsi"
 #define PVSCSI(obj) OBJECT_CHECK(PVSCSIState, (obj), TYPE_PVSCSI)
 
-#define PVSCSI_DEVICE_CLASS(klass) \
+#define PVSCSI_CLASS(klass) \
     OBJECT_CLASS_CHECK(PVSCSIClass, (klass), TYPE_PVSCSI)
-#define PVSCSI_DEVICE_GET_CLASS(obj) \
+#define PVSCSI_GET_CLASS(obj) \
     OBJECT_GET_CLASS(PVSCSIClass, (obj), TYPE_PVSCSI)
 
 /* Compatibility flags for migration */
@@ -1265,7 +1265,7 @@ static Property pvscsi_properties[] = {
 
 static void pvscsi_realize(DeviceState *qdev, Error **errp)
 {
-    PVSCSIClass *pvs_c = PVSCSI_DEVICE_GET_CLASS(qdev);
+    PVSCSIClass *pvs_c = PVSCSI_GET_CLASS(qdev);
     PCIDevice *pci_dev = PCI_DEVICE(qdev);
     PVSCSIState *s = PVSCSI(qdev);
 
@@ -1280,7 +1280,7 @@ static void pvscsi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
-    PVSCSIClass *pvs_k = PVSCSI_DEVICE_CLASS(klass);
+    PVSCSIClass *pvs_k = PVSCSI_CLASS(klass);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
 
     k->realize = pvscsi_realizefn;
-- 
2.26.2


