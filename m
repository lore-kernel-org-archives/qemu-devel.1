Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4E9C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:09:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44D1520767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PCDBebXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D1520767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDbsv-0002rx-Fl
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 19:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbVd-0005fF-3t
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:45:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbVb-0000Eq-9i
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VvizHAmeZMzi5ksn/YUPmtfcYhTkdeqSRpKS2+BNn4Q=;
 b=PCDBebXbNM7IjYZU2nF3c/PmWxqKjwjN/TgzR9pt3ryoRc9kcdpVgi9K2YEtQEHYp11ETL
 RrerBMb4Yadc751lEFwnqQdI7YR+PZ74P0CR6AwREL1oSYdoqjWxauyIqy2W0ugg3CjD9B
 kitPoWvonZ1JoXuAXpAWsqEnHPLsLHc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-5ST8YiQtOcCTfGY_WiqXbQ-1; Wed, 02 Sep 2020 18:45:36 -0400
X-MC-Unique: 5ST8YiQtOcCTfGY_WiqXbQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F1628030C7
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 22:45:36 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E77EB19C59;
 Wed,  2 Sep 2020 22:45:31 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 54/63] usb: Rename USB_STORAGE_DEV to USB_STORAGE
Date: Wed,  2 Sep 2020 18:43:02 -0400
Message-Id: <20200902224311.1321159-55-ehabkost@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 17:54:06
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
Cc: berrange@redhat.com, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the type checking macro name consistent with the TYPE_*
constant.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hw/usb/dev-storage.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 648340323f..bbc5d904bf 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -70,7 +70,7 @@ struct MSDState {
 typedef struct MSDState MSDState;
 
 #define TYPE_USB_STORAGE "usb-storage-dev"
-DECLARE_INSTANCE_CHECKER(MSDState, USB_STORAGE_DEV,
+DECLARE_INSTANCE_CHECKER(MSDState, USB_STORAGE,
                          TYPE_USB_STORAGE)
 
 struct usb_msd_cbw {
@@ -400,7 +400,7 @@ static void usb_msd_handle_control(USBDevice *dev, USBPacket *p,
 
 static void usb_msd_cancel_io(USBDevice *dev, USBPacket *p)
 {
-    MSDState *s = USB_STORAGE_DEV(dev);
+    MSDState *s = USB_STORAGE(dev);
 
     assert(s->packet == p);
     s->packet = NULL;
@@ -605,7 +605,7 @@ static const struct SCSIBusInfo usb_msd_scsi_info_bot = {
 
 static void usb_msd_storage_realize(USBDevice *dev, Error **errp)
 {
-    MSDState *s = USB_STORAGE_DEV(dev);
+    MSDState *s = USB_STORAGE(dev);
     BlockBackend *blk = s->conf.blk;
     SCSIDevice *scsi_dev;
 
@@ -656,7 +656,7 @@ static void usb_msd_storage_realize(USBDevice *dev, Error **errp)
 
 static void usb_msd_bot_realize(USBDevice *dev, Error **errp)
 {
-    MSDState *s = USB_STORAGE_DEV(dev);
+    MSDState *s = USB_STORAGE(dev);
     DeviceState *d = DEVICE(dev);
 
     usb_desc_create_serial(dev);
@@ -725,7 +725,7 @@ static void usb_msd_get_bootindex(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
 {
     USBDevice *dev = USB_DEVICE(obj);
-    MSDState *s = USB_STORAGE_DEV(dev);
+    MSDState *s = USB_STORAGE(dev);
 
     visit_type_int32(v, name, &s->conf.bootindex, errp);
 }
@@ -734,7 +734,7 @@ static void usb_msd_set_bootindex(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
 {
     USBDevice *dev = USB_DEVICE(obj);
-    MSDState *s = USB_STORAGE_DEV(dev);
+    MSDState *s = USB_STORAGE(dev);
     int32_t boot_index;
     Error *local_err = NULL;
 
-- 
2.26.2


