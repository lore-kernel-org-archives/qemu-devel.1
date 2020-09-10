Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3B6C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:44:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E097721941
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9eJCs9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E097721941
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRYK-0002xR-Tz
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGRCt-0005xt-8Z
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:22:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23804
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGRCh-00038F-2p
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599762109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oFZO6p04Xo1cCQTwbHus+a7/KxGBO0PW+N9S1mCxOuY=;
 b=U9eJCs9//GXYkYziti5yQAsRb/6Ew8MeyJ9/O4pMmXp2Tey5lVedo2LKQtZqNk8K48dD3k
 JZM3Sb4hsTfDjCoGOOhpUI3DZ0HLtsnENQbjvhUsHxcp91mED09Dbm4EZe0toG1hkCiJq6
 35WalYCnB3fU2RG0imcJrXbxdMND0vE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-SPm3ZsbKP-S2gT3DgiDvyQ-1; Thu, 10 Sep 2020 14:21:44 -0400
X-MC-Unique: SPm3ZsbKP-S2gT3DgiDvyQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 316A81084C85;
 Thu, 10 Sep 2020 18:21:43 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4C1A5C1BD;
 Thu, 10 Sep 2020 18:21:42 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 23/33] sabre: Rename SABRE_DEVICE to SABRE
Date: Thu, 10 Sep 2020 14:21:02 -0400
Message-Id: <20200910182112.4030917-24-ehabkost@redhat.com>
In-Reply-To: <20200910182112.4030917-1-ehabkost@redhat.com>
References: <20200910182112.4030917-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 08:38:09
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the type checking macro name consistent with the TYPE_*
constant.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200902224311.1321159-49-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
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
index 67985414e2..b4aabfc076 100644
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


