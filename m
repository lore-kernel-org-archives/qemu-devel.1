Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A051C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:06:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D14420767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Axz4Zp88"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D14420767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDbq3-0005OP-6d
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 19:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbVR-0005Cp-7F
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:45:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35212
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbVO-0000D7-EM
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MBobJ7wbc5BT+RjpuF/DJunoPaAC6xsL1WWsMG5REsU=;
 b=Axz4Zp88bnUg05B98ce2dqHNbp/JixLLJbJwKWUMr+PXjowxosu1MUmezM97osM8y5wSoS
 2lDnU3t0n79xiI1E+AK75oFAbzioPtl4rEFThmyvLneVcvf9qqnwTiJ2Q8dQTyjHdxMMYW
 WJ1I5QUKgff4cOrSJqwnl//6GeKlQ+g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-hYVMiU-OMR2feh4p5s5J2w-1; Wed, 02 Sep 2020 18:45:22 -0400
X-MC-Unique: hYVMiU-OMR2feh4p5s5J2w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A0A11DE00;
 Wed,  2 Sep 2020 22:45:20 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C83619C59;
 Wed,  2 Sep 2020 22:45:20 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 48/63] sabre: Rename SABRE_DEVICE to SABRE
Date: Wed,  2 Sep 2020 18:42:56 -0400
Message-Id: <20200902224311.1321159-49-ehabkost@redhat.com>
In-Reply-To: <20200902224311.1321159-1-ehabkost@redhat.com>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 16:25:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, berrange@redhat.com,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the type checking macro name consistent with the TYPE_*
constant.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: qemu-devel@nongnu.org
---
 include/hw/pci-host/sabre.h | 2 +-
 hw/pci-host/sabre.c         | 8 ++++----
 hw/sparc64/sun4u.c          | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/pci-host/sabre.h b/include/hw/pci-host/sabre.h
index 597bf70d69..7a76de4b9e 100644
--- a/include/hw/pci-host/sabre.h
+++ b/include/hw/pci-host/sabre.h
@@ -51,7 +51,7 @@ struct SabreState {
 typedef struct SabreState SabreState;
 
 #define TYPE_SABRE "sabre"
-DECLARE_INSTANCE_CHECKER(SabreState, SABRE_DEVICE,
+DECLARE_INSTANCE_CHECKER(SabreState, SABRE,
                          TYPE_SABRE)
 
 #endif
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index 0cc68585f8..5ac6283623 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -338,7 +338,7 @@ static void pci_sabre_set_irq(void *opaque, int irq_num, int level)
 
 static void sabre_reset(DeviceState *d)
 {
-    SabreState *s = SABRE_DEVICE(d);
+    SabreState *s = SABRE(d);
     PCIDevice *pci_dev;
     unsigned int i;
     uint16_t cmd;
@@ -376,7 +376,7 @@ static const MemoryRegionOps pci_config_ops = {
 
 static void sabre_realize(DeviceState *dev, Error **errp)
 {
-    SabreState *s = SABRE_DEVICE(dev);
+    SabreState *s = SABRE(dev);
     PCIHostState *phb = PCI_HOST_BRIDGE(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(s);
     PCIDevice *pci_dev;
@@ -421,7 +421,7 @@ static void sabre_realize(DeviceState *dev, Error **errp)
 
 static void sabre_init(Object *obj)
 {
-    SabreState *s = SABRE_DEVICE(obj);
+    SabreState *s = SABRE(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     unsigned int i;
 
@@ -502,7 +502,7 @@ static const TypeInfo sabre_pci_info = {
 
 static char *sabre_ofw_unit_address(const SysBusDevice *dev)
 {
-    SabreState *s = SABRE_DEVICE(dev);
+    SabreState *s = SABRE(dev);
 
     return g_strdup_printf("%x,%x",
                (uint32_t)((s->special_base >> 32) & 0xffffffff),
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index fe0d84bf6c..b746c3bf38 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -585,7 +585,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     prom_init(hwdef->prom_addr, bios_name);
 
     /* Init sabre (PCI host bridge) */
-    sabre = SABRE_DEVICE(qdev_new(TYPE_SABRE));
+    sabre = SABRE(qdev_new(TYPE_SABRE));
     qdev_prop_set_uint64(DEVICE(sabre), "special-base", PBM_SPECIAL_BASE);
     qdev_prop_set_uint64(DEVICE(sabre), "mem-base", PBM_MEM_BASE);
     object_property_set_link(OBJECT(sabre), "iommu", OBJECT(iommu),
-- 
2.26.2


