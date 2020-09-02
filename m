Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48C9C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D6E020767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K8rvH6ro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D6E020767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDbgv-0004vN-Ax
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 18:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbUj-0003Yg-Jo
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:44:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21343
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbUh-0008Rn-Ta
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VveOuf1NqcZqKq/VckNh6Ry5KVWolwLEYxHftHR/p48=;
 b=K8rvH6rojohOaZkDzXPbIJAu43yTBdNUGuUdzoK7CEpn+IkKeLK02n7wdZvcu7SMblmQ79
 xFzFojdPszrGq9veOkzRrth7VV8jJPQ81Gadm/2D+EMKOX1z24xJtrq63lJ15YljtPkxOU
 mI9cwDvrHIoAYcaTlPzT0nsS5ucw0eI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-mT8hOFRsNoOWDa1VAE63jQ-1; Wed, 02 Sep 2020 18:44:40 -0400
X-MC-Unique: mT8hOFRsNoOWDa1VAE63jQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E54238064BF;
 Wed,  2 Sep 2020 22:44:39 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC5F95D9CC;
 Wed,  2 Sep 2020 22:44:39 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 29/63] versatile: Rename TYPE_VERSATILE_PCI_HOST to
 TYPE_PCI_VPB_HOST
Date: Wed,  2 Sep 2020 18:42:37 -0400
Message-Id: <20200902224311.1321159-30-ehabkost@redhat.com>
In-Reply-To: <20200902224311.1321159-1-ehabkost@redhat.com>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will make the type name constant consistent with the name of
the type checking macro.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org
---
 hw/pci-host/versatile.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index 3553277f94..7b6a754b8b 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -161,9 +161,9 @@ static const VMStateDescription pci_vpb_vmstate = {
 DECLARE_INSTANCE_CHECKER(PCIVPBState, PCI_VPB,
                          TYPE_VERSATILE_PCI)
 
-#define TYPE_VERSATILE_PCI_HOST "versatile_pci_host"
+#define TYPE_PCI_VPB_HOST "versatile_pci_host"
 DECLARE_INSTANCE_CHECKER(PCIDevice, PCI_VPB_HOST,
-                         TYPE_VERSATILE_PCI_HOST)
+                         TYPE_PCI_VPB_HOST)
 
 typedef enum {
     PCI_IMAP0 = 0x0,
@@ -410,7 +410,7 @@ static void pci_vpb_realize(DeviceState *dev, Error **errp)
                              PCI_DEVFN(11, 0), TYPE_PCI_BUS);
     h->bus = &s->pci_bus;
 
-    object_initialize(&s->pci_dev, sizeof(s->pci_dev), TYPE_VERSATILE_PCI_HOST);
+    object_initialize(&s->pci_dev, sizeof(s->pci_dev), TYPE_PCI_VPB_HOST);
 
     for (i = 0; i < 4; i++) {
         sysbus_init_irq(sbd, &s->irq[i]);
@@ -487,7 +487,7 @@ static void versatile_pci_host_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo versatile_pci_host_info = {
-    .name          = TYPE_VERSATILE_PCI_HOST,
+    .name          = TYPE_PCI_VPB_HOST,
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIDevice),
     .class_init    = versatile_pci_host_class_init,
-- 
2.26.2


