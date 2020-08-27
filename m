Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB2AC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:32:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EA2B207DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDl68Js4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA2B207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBNd1-0000ky-OJ
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 15:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kBNTS-0006zQ-JM
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:22:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38725)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kBNTN-0000P4-SZ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598556128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hPDjoY8jkGB1MgoQ/65yzg7OMQsY2JF2LvIv8HRp7SM=;
 b=VDl68Js4mYZwRlslZtU46zEjch9+b6I6wB5zoXKBQmgarvpnIBW03gtdmdX0y8GsfNiaCZ
 MqYlQB9M5U5WaP6a/zwXwAhFHgeeneEfi+RK5UerPTsmx7w/2W6JVL3kihbb3f1H0GlDh/
 zJJl1u4LGo7Ymb7bJDVOXrTtAjaizec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-WMRjcQH5P32g4nKrrBOaHQ-1; Thu, 27 Aug 2020 15:22:01 -0400
X-MC-Unique: WMRjcQH5P32g4nKrrBOaHQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4C18801AB9;
 Thu, 27 Aug 2020 19:21:59 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B1C261100;
 Thu, 27 Aug 2020 19:21:56 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 13/53] hcd-dwc2: Rename USB_*CLASS macros for consistency
Date: Thu, 27 Aug 2020 15:20:42 -0400
Message-Id: <20200827192122.658035-14-ehabkost@redhat.com>
In-Reply-To: <20200827192122.658035-1-ehabkost@redhat.com>
References: <20200827192122.658035-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:54:02
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename the DWC2_CLASS to DWC2_USB_CLASS and DWC2_GET_CLASS to
DWC2_USB_GET_CLASS, for consistency with the DWC2_USB macro.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-By: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20200825192110.3528606-15-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/usb/hcd-dwc2.h | 4 ++--
 hw/usb/hcd-dwc2.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/usb/hcd-dwc2.h b/hw/usb/hcd-dwc2.h
index 4ba809a07b..54111d835e 100644
--- a/hw/usb/hcd-dwc2.h
+++ b/hw/usb/hcd-dwc2.h
@@ -182,9 +182,9 @@ struct DWC2Class {
 #define TYPE_DWC2_USB   "dwc2-usb"
 #define DWC2_USB(obj) \
     OBJECT_CHECK(DWC2State, (obj), TYPE_DWC2_USB)
-#define DWC2_CLASS(klass) \
+#define DWC2_USB_CLASS(klass) \
     OBJECT_CLASS_CHECK(DWC2Class, (klass), TYPE_DWC2_USB)
-#define DWC2_GET_CLASS(obj) \
+#define DWC2_USB_GET_CLASS(obj) \
     OBJECT_GET_CLASS(DWC2Class, (obj), TYPE_DWC2_USB)
 
 #endif
diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
index 56f91f6bee..97688d21bf 100644
--- a/hw/usb/hcd-dwc2.c
+++ b/hw/usb/hcd-dwc2.c
@@ -1155,7 +1155,7 @@ static void dwc2_work_timer(void *opaque)
 
 static void dwc2_reset_enter(Object *obj, ResetType type)
 {
-    DWC2Class *c = DWC2_GET_CLASS(obj);
+    DWC2Class *c = DWC2_USB_GET_CLASS(obj);
     DWC2State *s = DWC2_USB(obj);
     int i;
 
@@ -1239,7 +1239,7 @@ static void dwc2_reset_enter(Object *obj, ResetType type)
 
 static void dwc2_reset_hold(Object *obj)
 {
-    DWC2Class *c = DWC2_GET_CLASS(obj);
+    DWC2Class *c = DWC2_USB_GET_CLASS(obj);
     DWC2State *s = DWC2_USB(obj);
 
     trace_usb_dwc2_reset_hold();
@@ -1253,7 +1253,7 @@ static void dwc2_reset_hold(Object *obj)
 
 static void dwc2_reset_exit(Object *obj)
 {
-    DWC2Class *c = DWC2_GET_CLASS(obj);
+    DWC2Class *c = DWC2_USB_GET_CLASS(obj);
     DWC2State *s = DWC2_USB(obj);
 
     trace_usb_dwc2_reset_exit();
@@ -1382,7 +1382,7 @@ static Property dwc2_usb_properties[] = {
 static void dwc2_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    DWC2Class *c = DWC2_CLASS(klass);
+    DWC2Class *c = DWC2_USB_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->realize = dwc2_realize;
-- 
2.26.2


