Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEAEC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:35:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BD862087E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPY3k8ev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BD862087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBNfq-0006Ep-Bt
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 15:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kBNSr-00061p-FX
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:21:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41091)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kBNSp-0000Ly-HY
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598556094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XORl44+j8TFh3b0H7QYnOfMrVv/VIn1njDV+WEZfPMU=;
 b=RPY3k8evjBLXz6fLeLcVLZafyHo7YFhbp09OR18Y4k+JPC3jB0hNWdKrOve6N1CSGQSiZd
 un8dMAQboCNFfwVi+WREKu0ZLYDAePk3B5lY4eqzhjZ2B5VH5RPn4AIpTj8nSScQBDDhPy
 3+a4Tjkoi3TYqKfwLZCctfZ88T18zUo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-fbT4B-PYMoKZ4obuBVp8Qg-1; Thu, 27 Aug 2020 15:21:32 -0400
X-MC-Unique: fbT4B-PYMoKZ4obuBVp8Qg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 594C21DE08;
 Thu, 27 Aug 2020 19:21:31 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18F4F10013C1;
 Thu, 27 Aug 2020 19:21:30 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 03/53] megasas: Rename QOM class cast macros
Date: Thu, 27 Aug 2020 15:20:32 -0400
Message-Id: <20200827192122.658035-4-ehabkost@redhat.com>
In-Reply-To: <20200827192122.658035-1-ehabkost@redhat.com>
References: <20200827192122.658035-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:10:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Roman Bolshakov <r.bolshakov@yadro.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename the MEGASAS_DEVICE_CLASS() and MEGASAS_DEVICE_GET_CLASS()
macros to be consistent with the MEGASAS() instance cast macro.

This will allow us to register the type cast macros using
OBJECT_DECLARE_TYPE later.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Tested-By: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20200825192110.3528606-3-ehabkost@redhat.com>
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


