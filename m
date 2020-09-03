Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2347FC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 18:07:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C77A420716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 18:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFlg02lR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C77A420716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDtds-0003Zl-R9
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 14:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDtZ3-0003yM-Ig
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 14:02:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21542)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDtZ0-0007Rc-L2
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 14:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599156141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qzh45HlgbQShaUHQkdID/1mpSxLcqgTNt/3XaxKn/B4=;
 b=AFlg02lRDEhvCyubuvnBkhxq0NyDTmEEdCzSfxdWuM3gJ5WeTLao5bLG2BbV/r7kB/Fdqm
 wphEHIK9GM2l1Qbz6v+0zaazMbJfCkYHx2hMbEVm+jWbIPZlBDPXqSl/aGkUXLdMK126Vh
 T1E/E+CeFDTODmMBqBZ9pdAWW8ieW/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-vftowrdJNMGwtx23Q7tWLg-1; Thu, 03 Sep 2020 14:02:20 -0400
X-MC-Unique: vftowrdJNMGwtx23Q7tWLg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37462185A0C2;
 Thu,  3 Sep 2020 18:02:18 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 310975D9CC;
 Thu,  3 Sep 2020 18:02:11 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	"Daniel P. Berrange" <berrange@redhat.com>
Subject: [PATCH 6/8] esp-pci: Rename TYPE_AM53C974_DEVICE to TYPE_AM53C974
Date: Thu,  3 Sep 2020 14:01:26 -0400
Message-Id: <20200903180128.1523959-7-ehabkost@redhat.com>
In-Reply-To: <20200903180128.1523959-1-ehabkost@redhat.com>
References: <20200903180128.1523959-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will make the type name constant consistent with the QOM
type name string ("am53c974").

Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Suggested-by: "Daniel P. Berrangé" <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* v1 subject was "scsi: Rename TYPE_AM53C974_DEVICE to TYPE_PCI_ESP"
* Rename it to TYPE_AM53C974 instead, to be consistent with QOM
  type name ("am53c974")
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <fam@euphon.net>
Cc: qemu-devel@nongnu.org
---
 hw/scsi/esp-pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index 2ce96dc56e..e30a911b21 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -35,11 +35,11 @@
 #include "qemu/module.h"
 #include "qom/object.h"
 
-#define TYPE_AM53C974_DEVICE "am53c974"
+#define TYPE_AM53C974 "am53c974"
 
 typedef struct PCIESPState PCIESPState;
 DECLARE_INSTANCE_CHECKER(PCIESPState, PCI_ESP,
-                         TYPE_AM53C974_DEVICE)
+                         TYPE_AM53C974)
 
 #define DMA_CMD   0x0
 #define DMA_STC   0x1
@@ -400,7 +400,7 @@ static void esp_pci_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo esp_pci_info = {
-    .name = TYPE_AM53C974_DEVICE,
+    .name = TYPE_AM53C974,
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIESPState),
     .class_init = esp_pci_class_init,
@@ -525,7 +525,7 @@ static void dc390_class_init(ObjectClass *klass, void *data)
 
 static const TypeInfo dc390_info = {
     .name = TYPE_DC390_DEVICE,
-    .parent = TYPE_AM53C974_DEVICE,
+    .parent = TYPE_AM53C974,
     .instance_size = sizeof(DC390State),
     .class_init = dc390_class_init,
 };
-- 
2.26.2


