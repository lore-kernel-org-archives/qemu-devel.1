Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E23C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:07:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E985520767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="if4pOX4s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E985520767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDbqX-0006TG-3B
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 19:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbVU-0005KP-AZ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:45:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40294
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbVS-0000E3-EN
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wQm3du+TqRuHZik76gITpJwg1dj5vxMe7ipcLbq5xvM=;
 b=if4pOX4shFGr/eF86iy6J+s35oExdptN/kQiKrFFrsOusm7ov+dDh1DgkIcEGeYl++PZDb
 iL2lxaIGrmFU50mDhyK1Lk7+QSOJ49KFRIBVyEuTeqSpG6AZcjglLDqXg1NiPxV1SbSTX4
 XEVPdX78BVG5wyX/GMVwSX2XXCdpJmc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-FE8x5ugnOtKWYKToT_CcyQ-1; Wed, 02 Sep 2020 18:45:28 -0400
X-MC-Unique: FE8x5ugnOtKWYKToT_CcyQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50CAA1005E66
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 22:45:27 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 370107E670;
 Wed,  2 Sep 2020 22:45:24 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 52/63] usb: Rename USB_REDIRECT to USB_REDIR
Date: Wed,  2 Sep 2020 18:43:00 -0400
Message-Id: <20200902224311.1321159-53-ehabkost@redhat.com>
In-Reply-To: <20200902224311.1321159-1-ehabkost@redhat.com>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
 hw/usb/redirect.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index a079ecd50c..721af75da4 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -145,7 +145,7 @@ struct USBRedirDevice {
 };
 
 #define TYPE_USB_REDIR "usb-redir"
-DECLARE_INSTANCE_CHECKER(USBRedirDevice, USB_REDIRECT,
+DECLARE_INSTANCE_CHECKER(USBRedirDevice, USB_REDIR,
                          TYPE_USB_REDIR)
 
 static void usbredir_hello(void *priv, struct usb_redir_hello_header *h);
@@ -375,7 +375,7 @@ static void packet_id_queue_empty(struct PacketIdQueue *q)
 
 static void usbredir_cancel_packet(USBDevice *udev, USBPacket *p)
 {
-    USBRedirDevice *dev = USB_REDIRECT(udev);
+    USBRedirDevice *dev = USB_REDIR(udev);
     int i = USBEP2I(p->ep);
 
     if (p->combined) {
@@ -516,7 +516,7 @@ static void usbredir_free_bufpq(USBRedirDevice *dev, uint8_t ep)
 
 static void usbredir_handle_reset(USBDevice *udev)
 {
-    USBRedirDevice *dev = USB_REDIRECT(udev);
+    USBRedirDevice *dev = USB_REDIR(udev);
 
     DPRINTF("reset device\n");
     usbredirparser_send_reset(dev->parser);
@@ -955,7 +955,7 @@ static void usbredir_stop_interrupt_receiving(USBRedirDevice *dev,
 
 static void usbredir_handle_data(USBDevice *udev, USBPacket *p)
 {
-    USBRedirDevice *dev = USB_REDIRECT(udev);
+    USBRedirDevice *dev = USB_REDIR(udev);
     uint8_t ep;
 
     ep = p->ep->nr;
@@ -1024,7 +1024,7 @@ static void usbredir_stop_ep(USBRedirDevice *dev, int i)
 
 static void usbredir_ep_stopped(USBDevice *udev, USBEndpoint *uep)
 {
-    USBRedirDevice *dev = USB_REDIRECT(udev);
+    USBRedirDevice *dev = USB_REDIR(udev);
 
     usbredir_stop_ep(dev, USBEP2I(uep));
     usbredirparser_do_write(dev->parser);
@@ -1094,7 +1094,7 @@ static void usbredir_get_interface(USBRedirDevice *dev, USBPacket *p,
 static void usbredir_handle_control(USBDevice *udev, USBPacket *p,
         int request, int value, int index, int length, uint8_t *data)
 {
-    USBRedirDevice *dev = USB_REDIRECT(udev);
+    USBRedirDevice *dev = USB_REDIR(udev);
     struct usb_redir_control_packet_header control_packet;
 
     if (usbredir_already_in_flight(dev, p->id)) {
@@ -1149,7 +1149,7 @@ static void usbredir_handle_control(USBDevice *udev, USBPacket *p,
 static int usbredir_alloc_streams(USBDevice *udev, USBEndpoint **eps,
                                   int nr_eps, int streams)
 {
-    USBRedirDevice *dev = USB_REDIRECT(udev);
+    USBRedirDevice *dev = USB_REDIR(udev);
 #if USBREDIR_VERSION >= 0x000700
     struct usb_redir_alloc_bulk_streams_header alloc_streams;
     int i;
@@ -1188,7 +1188,7 @@ static void usbredir_free_streams(USBDevice *udev, USBEndpoint **eps,
                                   int nr_eps)
 {
 #if USBREDIR_VERSION >= 0x000700
-    USBRedirDevice *dev = USB_REDIRECT(udev);
+    USBRedirDevice *dev = USB_REDIR(udev);
     struct usb_redir_free_bulk_streams_header free_streams;
     int i;
 
@@ -1417,7 +1417,7 @@ static void usbredir_init_endpoints(USBRedirDevice *dev)
 
 static void usbredir_realize(USBDevice *udev, Error **errp)
 {
-    USBRedirDevice *dev = USB_REDIRECT(udev);
+    USBRedirDevice *dev = USB_REDIR(udev);
     int i;
 
     if (!qemu_chr_fe_backend_connected(&dev->cs)) {
@@ -1472,7 +1472,7 @@ static void usbredir_cleanup_device_queues(USBRedirDevice *dev)
 
 static void usbredir_unrealize(USBDevice *udev)
 {
-    USBRedirDevice *dev = USB_REDIRECT(udev);
+    USBRedirDevice *dev = USB_REDIR(udev);
 
     qemu_chr_fe_deinit(&dev->cs, true);
 
@@ -2593,7 +2593,7 @@ static void usbredir_class_initfn(ObjectClass *klass, void *data)
 static void usbredir_instance_init(Object *obj)
 {
     USBDevice *udev = USB_DEVICE(obj);
-    USBRedirDevice *dev = USB_REDIRECT(udev);
+    USBRedirDevice *dev = USB_REDIR(udev);
 
     device_add_bootindex_property(obj, &dev->bootindex,
                                   "bootindex", NULL,
-- 
2.26.2


