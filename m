Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF17C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:53:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5537320767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hfiltdsd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5537320767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDbd0-0003vK-DX
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 18:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbUc-0003Iu-39
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:44:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56814
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbUZ-0008PB-5J
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RgzaG8X4ZM/mnLdMi8n7iK/N9E49amWId0S3jwUctVg=;
 b=Hfiltdsd+d4U8v7RANPbpG49x837c/QIDNHiiDFU28Q68YP1Y9YpnsN+IDSCvmaXr3agVa
 Lmt20hsr5aZA1aaZ0i9xO2xmcm9lvOmGRVsKPcepTd8POIivQtR/ITgULQa8wnHfmFTVWB
 X+0CP4pcKJCbAn2QQrYrTLtnhQHq/II=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-fn-tSKjWNzOxa5UWVRkIcA-1; Wed, 02 Sep 2020 18:44:32 -0400
X-MC-Unique: fn-tSKjWNzOxa5UWVRkIcA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B550E18A2256;
 Wed,  2 Sep 2020 22:44:31 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E10219C59;
 Wed,  2 Sep 2020 22:44:31 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 24/63] scsi: Rename TYPE_AM53C974_DEVICE to TYPE_PCI_ESP
Date: Wed,  2 Sep 2020 18:42:32 -0400
Message-Id: <20200902224311.1321159-25-ehabkost@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 17:27:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will make the type name constant consistent with the name of
the type checking macro.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <fam@euphon.net>
Cc: qemu-devel@nongnu.org
---
 hw/scsi/esp-pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index 2ce96dc56e..2b1198380b 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -35,11 +35,11 @@
 #include "qemu/module.h"
 #include "qom/object.h"
 
-#define TYPE_AM53C974_DEVICE "am53c974"
+#define TYPE_PCI_ESP "am53c974"
 
 typedef struct PCIESPState PCIESPState;
 DECLARE_INSTANCE_CHECKER(PCIESPState, PCI_ESP,
-                         TYPE_AM53C974_DEVICE)
+                         TYPE_PCI_ESP)
 
 #define DMA_CMD   0x0
 #define DMA_STC   0x1
@@ -400,7 +400,7 @@ static void esp_pci_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo esp_pci_info = {
-    .name = TYPE_AM53C974_DEVICE,
+    .name = TYPE_PCI_ESP,
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIESPState),
     .class_init = esp_pci_class_init,
@@ -525,7 +525,7 @@ static void dc390_class_init(ObjectClass *klass, void *data)
 
 static const TypeInfo dc390_info = {
     .name = TYPE_DC390_DEVICE,
-    .parent = TYPE_AM53C974_DEVICE,
+    .parent = TYPE_PCI_ESP,
     .instance_size = sizeof(DC390State),
     .class_init = dc390_class_init,
 };
-- 
2.26.2


