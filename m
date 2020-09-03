Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A79C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:10:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11E43206C9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BbGyt8Fa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E43206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwVK-0002W8-5x
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDwEZ-000131-Ls
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 16:53:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38693)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDwEV-0006bQ-Cj
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 16:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599166402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zqa6aaKmwm6Igb+aD9Zq+/iOUndIFn2SdOJEhdzGFFY=;
 b=BbGyt8FaS+KPUiNpn5CtHwCT6fQe17h16HZY/jKyWTLgrkpabUfh9jUmUAK/a64szyOZmh
 uxvGYydvzOINTq8JtlmiFWBit3Esf66dAB8K+LQOCKWH08dgLV51xhHEm8NixONRXB5p1N
 ZnNwy2EhO7suWnU2W3AFqyGAhq2LcXM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-vsYtSVjvOCurm16WUs9gJA-1; Thu, 03 Sep 2020 16:53:20 -0400
X-MC-Unique: vsYtSVjvOCurm16WUs9gJA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B266181F00A;
 Thu,  3 Sep 2020 20:53:19 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 811CA5C1C2;
 Thu,  3 Sep 2020 20:53:19 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 19/27] ahci: Rename ICH_AHCI to ICH9_AHCI
Date: Thu,  3 Sep 2020 16:52:39 -0400
Message-Id: <20200903205247.1667472-20-ehabkost@redhat.com>
In-Reply-To: <20200903205247.1667472-1-ehabkost@redhat.com>
References: <20200903205247.1667472-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the type checking macro name consistent with the TYPE_*
constant.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200902224311.1321159-33-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/ide/ahci.h | 2 +-
 hw/ide/ahci.c         | 4 ++--
 hw/ide/ich.c          | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
index 4cf6813d80..da3cddcc65 100644
--- a/include/hw/ide/ahci.h
+++ b/include/hw/ide/ahci.h
@@ -54,7 +54,7 @@ typedef struct AHCIState {
 typedef struct AHCIPCIState AHCIPCIState;
 
 #define TYPE_ICH9_AHCI "ich9-ahci"
-DECLARE_INSTANCE_CHECKER(AHCIPCIState, ICH_AHCI,
+DECLARE_INSTANCE_CHECKER(AHCIPCIState, ICH9_AHCI,
                          TYPE_ICH9_AHCI)
 
 int32_t ahci_get_num_ports(PCIDevice *dev);
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index b696c6291a..ee1d47ff75 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1819,7 +1819,7 @@ type_init(sysbus_ahci_register_types)
 
 int32_t ahci_get_num_ports(PCIDevice *dev)
 {
-    AHCIPCIState *d = ICH_AHCI(dev);
+    AHCIPCIState *d = ICH9_AHCI(dev);
     AHCIState *ahci = &d->ahci;
 
     return ahci->ports;
@@ -1827,7 +1827,7 @@ int32_t ahci_get_num_ports(PCIDevice *dev)
 
 void ahci_ide_create_devs(PCIDevice *dev, DriveInfo **hd)
 {
-    AHCIPCIState *d = ICH_AHCI(dev);
+    AHCIPCIState *d = ICH9_AHCI(dev);
     AHCIState *ahci = &d->ahci;
     int i;
 
diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index eff3188fff..51cd2f38b7 100644
--- a/hw/ide/ich.c
+++ b/hw/ide/ich.c
@@ -91,14 +91,14 @@ static const VMStateDescription vmstate_ich9_ahci = {
 
 static void pci_ich9_reset(DeviceState *dev)
 {
-    AHCIPCIState *d = ICH_AHCI(dev);
+    AHCIPCIState *d = ICH9_AHCI(dev);
 
     ahci_reset(&d->ahci);
 }
 
 static void pci_ich9_ahci_init(Object *obj)
 {
-    struct AHCIPCIState *d = ICH_AHCI(obj);
+    struct AHCIPCIState *d = ICH9_AHCI(obj);
 
     ahci_init(&d->ahci, DEVICE(obj));
 }
@@ -108,7 +108,7 @@ static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
     struct AHCIPCIState *d;
     int sata_cap_offset;
     uint8_t *sata_cap;
-    d = ICH_AHCI(dev);
+    d = ICH9_AHCI(dev);
     int ret;
 
     ahci_realize(&d->ahci, DEVICE(dev), pci_get_address_space(dev), 6);
@@ -154,7 +154,7 @@ static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
 static void pci_ich9_uninit(PCIDevice *dev)
 {
     struct AHCIPCIState *d;
-    d = ICH_AHCI(dev);
+    d = ICH9_AHCI(dev);
 
     msi_uninit(dev);
     ahci_uninit(&d->ahci);
-- 
2.26.2


