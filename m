Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94F2C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:30:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA4F02072D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TtzNQYqI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA4F02072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAee2-000754-RJ
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeVy-0007Oh-Iv
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:21:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34861
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeVw-00067G-SA
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598383308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mPS0Kxl6xOaIxVH+LrL8xyENSTMDh7aIsJnItlJolQI=;
 b=TtzNQYqIuI0Gfofgc2PcdpPtFi6IU6wbfFY/7ZPDlKej7zNYIDA7dgZLwxZAojMb2zOmXu
 aJa2xnL/bXCP9/0vUD0yLhk851GAHXkLohUzpfy2/7e0FzrH3AnMduBo0ml7MCRO9XjWXC
 iQyI+aFgLdFEQe5wWbLiru7/Pxoy96g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-9whbQ3p7Oomht_edHC8bzA-1; Tue, 25 Aug 2020 15:21:43 -0400
X-MC-Unique: 9whbQ3p7Oomht_edHC8bzA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 479C681CAFC;
 Tue, 25 Aug 2020 19:21:42 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 76FF35D9D3;
 Tue, 25 Aug 2020 19:21:39 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 14/74] hcd-dwc2: Rename USB_*CLASS macros for consistency
Date: Tue, 25 Aug 2020 15:20:10 -0400
Message-Id: <20200825192110.3528606-15-ehabkost@redhat.com>
In-Reply-To: <20200825192110.3528606-1-ehabkost@redhat.com>
References: <20200825192110.3528606-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 15:21:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename the DWC2_CLASS to DWC2_USB_CLASS and DWC2_GET_CLASS to
DWC2_USB_GET_CLASS, for consistency with the DWC2_USB macro.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v2 -> v3: none

Changes v1 -> v2: none

---
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
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


