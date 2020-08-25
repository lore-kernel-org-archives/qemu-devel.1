Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247ADC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:22:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE9B22071E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eoDBhvnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE9B22071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAeWU-00085D-8M
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeVZ-0006JU-9D
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:21:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28698)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeVX-00061L-Dl
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598383282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UFVSPpKNsJ4GtROn1SjP6U6WtnAWBNC+GV8OVQyPMUs=;
 b=eoDBhvnZFeU55COfU6SKSegoFw1Ll2CqMwIDn5c90y49zmb2wRL+LxAtaWgyHrObBOqS6g
 1swKiR4Tnwa8I0mdACVymUAuDqaQ88vrHejrnj5+uSGb7SD9Kr9xId0sbGia6v+UsUQF1Q
 Ev6NXiaYlFqYCM94bDiMQtYulADXALY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-3emnBBR3Ma-j_634wDHCyA-1; Tue, 25 Aug 2020 15:21:20 -0400
X-MC-Unique: 3emnBBR3Ma-j_634wDHCyA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C57D3FD1;
 Tue, 25 Aug 2020 19:21:19 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAEC319C58;
 Tue, 25 Aug 2020 19:21:18 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/74] megasas: Rename QOM class cast macros
Date: Tue, 25 Aug 2020 15:19:58 -0400
Message-Id: <20200825192110.3528606-3-ehabkost@redhat.com>
In-Reply-To: <20200825192110.3528606-1-ehabkost@redhat.com>
References: <20200825192110.3528606-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:03:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Hannes Reinecke <hare@suse.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename the MEGASAS_DEVICE_CLASS() and MEGASAS_DEVICE_GET_CLASS()
macros to be consistent with the MEGASAS() instance cast macro.

This will allow us to register the type cast macros using
OBJECT_DECLARE_TYPE later.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v2 -> v3: none

Changes v1 -> v2: none

---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <fam@euphon.net>
Cc: Hannes Reinecke <hare@suse.com>
Cc: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
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


