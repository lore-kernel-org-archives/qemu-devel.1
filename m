Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6143C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:02:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FE3B206B7
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKjsT3NY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE3B206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrjgA-0006fN-TR
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 11:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjUq-0002Bp-8f; Sat, 04 Jul 2020 10:50:28 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjUo-0003tB-CY; Sat, 04 Jul 2020 10:50:27 -0400
Received: by mail-wm1-x341.google.com with SMTP id o2so37045109wmh.2;
 Sat, 04 Jul 2020 07:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dSp90TZcMkhYVN1myg6NdGD6Nbq0gZQK2ClNXRKzwCU=;
 b=mKjsT3NYlThJ+LvUmtlSMZy5vL935vqJl78XXQCOfn95V8qATFdthcq6p9KJZvenD6
 DffdeGJvs+v064CCp2bsGhza6HQ140vH4JRai4A3w+oS3o1wIspj2Cju5MMVDflqztas
 XqxwrLwqtwKNKEg6aekNLR2FAcywQVHY/ZPzG6wsvXMQx0+h11VfEUR7kqHBPv3peOBX
 gfriguM3HSKDBd5gYz5iWvxaoezeQw/GUCx443CDTct4IA4h1LI8tVQdQU/ugz11KIv+
 BiB3KOhE8U5/19gm2x+V5J/zs6cl0vA9D1NhrqwmqhZr47fh9n3rf96aJTJhrioPyh+C
 odGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=dSp90TZcMkhYVN1myg6NdGD6Nbq0gZQK2ClNXRKzwCU=;
 b=A9h3A9dEjUqQfdHhHKGdb45suA/gXf0l7R7fZ310mmxrJrBzM0ikxszYd54g8qNiX6
 44N2438sB3AbDHjLPHDlryituXodxSPoVfXCoAYx66KRCWtjpyankVGcrpwN8kv03cYM
 N/plKcPmTsZU1wBAadALcHp4zQE7eXTS62AGJ3R2acd/uqntpdkmZnvGH9h8djWgcT8i
 h+z37bFJB+h84u+8E7JOBYDprt2zeP/6G0wP5JVgm0AW3G6YjKecjA9kVc6CPBltUYFK
 5TfjGfOHh03bHXEvuO+e7v2c1RsicxkmtQgODdLyQF6A4gt4IGh4HrCqNo0jGFZ8XDFU
 VZ7A==
X-Gm-Message-State: AOAM532XXRAcNyArQapZrnycvRibnER7KCrQ/B1l6u9vL73Bs6kfVzN2
 2kAv2iTnRD8Buryi4q6C9tSINAtQwMQ=
X-Google-Smtp-Source: ABdhPJzvKUoOtrkVjzZQp6DwlQyiHYdZ94BKN5ozpyFIsmy9iEQycoO+prQidokC2C86DctB5wk5ig==
X-Received: by 2002:a1c:18e:: with SMTP id 136mr10977710wmb.93.1593874224206; 
 Sat, 04 Jul 2020 07:50:24 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id r10sm17135019wrm.17.2020.07.04.07.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 07:50:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 18/26] hw/usb/bus: Add usb_get_port_path()
Date: Sat,  4 Jul 2020 16:49:35 +0200
Message-Id: <20200704144943.18292-19-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704144943.18292-1-f4bug@amsat.org>
References: <20200704144943.18292-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Durrant <paul@xen.org>, Magnus Damm <magnus.damm@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Leif Lindholm <leif@nuviainc.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paul Zimmerman <pauldzim@gmail.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Refactor usb_get_full_dev_path() to take a 'want_full_path'
argument, and add usb_get_port_path() which returns a short
path.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/usb.h | 10 ++++++++++
 hw/usb/bus.c     | 18 +++++++++++++-----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/include/hw/usb.h b/include/hw/usb.h
index 8c3bc920ff..7ea502d421 100644
--- a/include/hw/usb.h
+++ b/include/hw/usb.h
@@ -506,6 +506,16 @@ void usb_port_location(USBPort *downstream, USBPort *upstream, int portnr);
 void usb_unregister_port(USBBus *bus, USBPort *port);
 void usb_claim_port(USBDevice *dev, Error **errp);
 void usb_release_port(USBDevice *dev);
+/**
+ * usb_get_port_path:
+ * @dev: the USB device
+ *
+ * The returned data must be released with g_free()
+ * when no longer required.
+ *
+ * Returns: a dynamically allocated pathname.
+ */
+char *usb_get_port_path(USBDevice *dev);
 void usb_device_attach(USBDevice *dev, Error **errp);
 int usb_device_detach(USBDevice *dev);
 void usb_check_attach(USBDevice *dev, Error **errp);
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index fad8194bf5..518e5b94ed 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -577,12 +577,10 @@ static void usb_bus_dev_print(Monitor *mon, DeviceState *qdev, int indent)
                    dev->attached ? ", attached" : "");
 }
 
-static char *usb_get_full_dev_path(DeviceState *qdev)
+static char *usb_get_dev_path(USBDevice *dev, bool want_full_path)
 {
-    USBDevice *dev = USB_DEVICE(qdev);
-
-    if (dev->flags & (1 << USB_DEV_FLAG_FULL_PATH)) {
-        DeviceState *hcd = qdev->parent_bus->parent;
+    if (want_full_path && (dev->flags & (1 << USB_DEV_FLAG_FULL_PATH))) {
+        DeviceState *hcd = DEVICE(dev)->parent_bus->parent;
         char *id = qdev_get_dev_path(hcd);
 
         if (id) {
@@ -594,6 +592,16 @@ static char *usb_get_full_dev_path(DeviceState *qdev)
     return g_strdup(dev->port->path);
 }
 
+static char *usb_get_full_dev_path(DeviceState *qdev)
+{
+    return usb_get_dev_path(USB_DEVICE(qdev), true);
+}
+
+char *usb_get_port_path(USBDevice *dev)
+{
+    return usb_get_dev_path(dev, false);
+}
+
 static char *usb_get_fw_dev_path(DeviceState *qdev)
 {
     USBDevice *dev = USB_DEVICE(qdev);
-- 
2.21.3


