Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE210C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:50:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 982FA20767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITNO6lvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982FA20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDbZt-0004qN-Kq
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 18:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbTz-0001hJ-PN
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:43:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54446
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbTx-0008Je-VX
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eHPViNanObRmLRaMcxKOuW5QoC3ysriW80rMxyY6O0I=;
 b=ITNO6lvBrGSROM8p3YLHub5v4GjmYlC61cu7CvuUoYJxXyPlAkx5rJ9lpLOpTSoNT7ylDn
 SqSmV4tutOcKfVEzIA5S9SnG/kivJ+7U9dh9n3VVnT/2dswex+c4Fh3Ni0SO1yZr2WNp7j
 IEabYeWwpvV89JL96v9MUCbseSQo4fs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-buWvsCdtM6-PDsCe6Q9bKQ-1; Wed, 02 Sep 2020 18:43:44 -0400
X-MC-Unique: buWvsCdtM6-PDsCe6Q9bKQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 529F418A2251
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 22:43:43 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC28D19C59;
 Wed,  2 Sep 2020 22:43:39 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/63] dev-smartcard-reader: Rename CCID_DEV_NAME to
 TYPE_USB_CCID_DEV
Date: Wed,  2 Sep 2020 18:42:14 -0400
Message-Id: <20200902224311.1321159-7-ehabkost@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 17:54:07
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
Cc: berrange@redhat.com, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will make the type name constant consistent with the name of
the type checking macro.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hw/usb/dev-smartcard-reader.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 432508c478..59b2248f34 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -60,10 +60,10 @@ do { \
 #define D_MORE_INFO 3
 #define D_VERBOSE 4
 
-#define CCID_DEV_NAME "usb-ccid"
+#define TYPE_USB_CCID_DEV "usb-ccid"
 typedef struct USBCCIDState USBCCIDState;
 DECLARE_INSTANCE_CHECKER(USBCCIDState, USB_CCID_DEV,
-                         CCID_DEV_NAME)
+                         TYPE_USB_CCID_DEV)
 /*
  * The two options for variable sized buffers:
  * make them constant size, for large enough constant,
@@ -1462,7 +1462,7 @@ static void ccid_class_initfn(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo ccid_info = {
-    .name          = CCID_DEV_NAME,
+    .name          = TYPE_USB_CCID_DEV,
     .parent        = TYPE_USB_DEVICE,
     .instance_size = sizeof(USBCCIDState),
     .class_init    = ccid_class_initfn,
@@ -1495,7 +1495,7 @@ static void ccid_register_types(void)
     type_register_static(&ccid_bus_info);
     type_register_static(&ccid_card_type_info);
     type_register_static(&ccid_info);
-    usb_legacy_register(CCID_DEV_NAME, "ccid", NULL);
+    usb_legacy_register(TYPE_USB_CCID_DEV, "ccid", NULL);
 }
 
 type_init(ccid_register_types)
-- 
2.26.2


