Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88E4C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:00:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B103D20707
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QcqveYA5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B103D20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jefYw-0006Zo-S5
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 10:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jefKX-00038N-La
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:45:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44647
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jefKM-00076g-MT
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:45:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590759936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+3HwdQ/vrS+EzUTy7Re0yu+XdKukHh0BNQWMv9zUDLg=;
 b=QcqveYA546wuoQ9ruEZlmU/WtF4klMgJpMJha8s7pqE9Y01fz1lWl8zZhSkwoMM8jRdOkV
 tLECksVXBw3u34KIsONmHzn5DKGVSgb5cRHme+ueKxIyAWoNFocOgRbWJBAlRnZnE+sQm0
 hjlqt7uoipcpy2LRjr/yEhfsJCRqHHw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-_aSq9WZGM0CmiTwF4j8jUA-1; Fri, 29 May 2020 09:45:35 -0400
X-MC-Unique: _aSq9WZGM0CmiTwF4j8jUA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23902835B44
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 13:45:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EE46768B1;
 Fri, 29 May 2020 13:45:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3BAF611358DD; Fri, 29 May 2020 15:45:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 28/58] usb: usb_create() is now unused, drop
Date: Fri, 29 May 2020 15:44:53 +0200
Message-Id: <20200529134523.8477-29-armbru@redhat.com>
In-Reply-To: <20200529134523.8477-1-armbru@redhat.com>
References: <20200529134523.8477-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 03:05:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/usb.h | 1 -
 hw/usb/bus.c     | 8 --------
 2 files changed, 9 deletions(-)

diff --git a/include/hw/usb.h b/include/hw/usb.h
index 86093d941a..817dcebbef 100644
--- a/include/hw/usb.h
+++ b/include/hw/usb.h
@@ -535,7 +535,6 @@ void usb_legacy_register(const char *typename, const char *usbdevice_name,
                          USBDevice *(*usbdevice_init)(const char *params));
 USBDevice *usb_new(const char *name);
 bool usb_realize_and_unref(USBDevice *dev, USBBus *bus, Error **errp);
-USBDevice *usb_create(USBBus *bus, const char *name);
 USBDevice *usb_create_simple(USBBus *bus, const char *name);
 USBDevice *usbdevice_create(const char *cmdline);
 void usb_register_port(USBBus *bus, USBPort *port, void *opaque, int index,
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index da85b8b005..5c4d31614e 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -323,14 +323,6 @@ bool usb_realize_and_unref(USBDevice *dev, USBBus *bus, Error **errp)
     return qdev_realize_and_unref(&dev->qdev, &bus->qbus, errp);
 }
 
-USBDevice *usb_create(USBBus *bus, const char *name)
-{
-    DeviceState *dev;
-
-    dev = qdev_create(&bus->qbus, name);
-    return USB_DEVICE(dev);
-}
-
 static USBDevice *usb_try_create_simple(USBBus *bus, const char *name,
                                         Error **errp)
 {
-- 
2.21.3


