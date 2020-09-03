Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E979C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:57:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED5D4206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwUhmoUC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5D4206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwI5-0007AN-1L
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 16:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDwEU-0000wX-Jd
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 16:53:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30048
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDwES-0006av-Rn
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 16:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599166400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l3+rjCng41Ul0hAk/KtTt47/0GlS9R28kPcYZE4pXD0=;
 b=JwUhmoUCBrZDr0bSesAB7Tl8aL1ltEloxFXX7fb4rcIJGOPPH+WRMRrjZevDdOaniIAgjn
 LTPn6FubA/xoWxERUeig7u4zFaWNH3N0NmiMbtzChEh/9z2NhwDpb9WyNjCAeANRHrH1f9
 qIz4dyzVrVOw59jrveImdvpnGq0C9HI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-5Qvd7RcfPpiI0RTmnDB9vA-1; Thu, 03 Sep 2020 16:53:17 -0400
X-MC-Unique: 5Qvd7RcfPpiI0RTmnDB9vA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2B8518BA291;
 Thu,  3 Sep 2020 20:53:16 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 397E15D9EF;
 Thu,  3 Sep 2020 20:53:16 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 16/27] dev-smartcard-reader: Rename CCID_DEV_NAME to
 TYPE_USB_CCID_DEV
Date: Thu,  3 Sep 2020 16:52:36 -0400
Message-Id: <20200903205247.1667472-17-ehabkost@redhat.com>
In-Reply-To: <20200903205247.1667472-1-ehabkost@redhat.com>
References: <20200903205247.1667472-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:58:20
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will make the type name constant consistent with the name of
the type checking macro.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200902224311.1321159-7-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
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


