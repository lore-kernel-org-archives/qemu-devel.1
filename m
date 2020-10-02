Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C85BC47095
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:40:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF18520758
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNOEfMNr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF18520758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOP38-0004Xs-QR
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 13:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kOOyT-0000Ok-DT
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:36:05 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:46201)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kOOyR-0003J9-FP
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:36:05 -0400
Received: by mail-wr1-x42d.google.com with SMTP id o5so2658235wrn.13
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 10:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7jnEPHNQolXrIggvM1boO0VCWcKwcGVqxDfZAb/xQC0=;
 b=MNOEfMNrHRG/VRSQki1fA3bHhSb5YxxMfhWtcTXxUkB0l4Fx+Yg3NOeC+RRNIE3xiC
 +GR4vWeSqdcBaATJFC32/nxuZTtr3MgR1sd4+V3jKULrWAePvSGdivWVYczFOh1ZzeEX
 gpJ/qsvjGSh6Dx8A4buL9ecoXiKZ/4qe71mw1Ku+dwg7cWGiDe+AxOO+WsoaG+d/Zcoa
 YSLowmp8GTGHcXwodM6NMEhiLPW3TZaSuXguwuAzUmI0Vr+MIRKrvut7d13nSeCtYJlm
 HlYU/S+SRUDj5Gdf2a6jHbfIoJ3loWyhNgL+5r4ihDAiuZWCg3fCkxXEperZW7AltsqU
 zKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=7jnEPHNQolXrIggvM1boO0VCWcKwcGVqxDfZAb/xQC0=;
 b=l0SLsWRVefroXUS0QlDl6qHaJDg680gkMZ0RwMRAyLnwVf6XsAvSC6oz2ozCy65Btx
 tKgqREQ8hm75YyFYyG1yuKY2yVVBxAEDiwSlpPOYe2cGRMhHK1xjM1Xr4RrCun8I6N5E
 3DiX59zZI560yGpR1EoIHrfyNiTCzrtreNhxcCWtT4BmYbZumpo4JT4iKTXq1KbDfsTj
 vVP+MpKte3LDt9rUcZWpSkVaBNStBDBMg2TcRUtV+AwfUFVDXilHCFyUOzJhaugYOM3f
 NHc68y4dNQfBfIYO2W2Dhqq4SXpR8DUcxPM03xBDPAKJDo9U/DEHY/yZQPLHxGZ24uMB
 k4BA==
X-Gm-Message-State: AOAM531Cm9bWt0w97l6y+kz75bTciTMIi8+uqu3IjQxMZR75BcAG7XBJ
 Ozhc7m8+UxiBLAHTdF7p2pVsPeqNa2U=
X-Google-Smtp-Source: ABdhPJxlZzkfreGBj0je2cBHtA4UrHf0ggRr2S+ZSEgdxRZ9nKD6V5/w9PTGoXdeO8jNEfTywOS+FA==
X-Received: by 2002:adf:df87:: with SMTP id z7mr4375399wrl.239.1601660161856; 
 Fri, 02 Oct 2020 10:36:01 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:47e0:e742:75ba:b84d])
 by smtp.gmail.com with ESMTPSA id
 l8sm2516454wrx.22.2020.10.02.10.36.00 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 10:36:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 02/10] scsi: switch to bus->check_address
Date: Fri,  2 Oct 2020 19:35:50 +0200
Message-Id: <20201002173558.232960-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201002173558.232960-1-pbonzini@redhat.com>
References: <20201002173558.232960-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-bus.c | 122 ++++++++++++++++++++++++++++-----------------
 1 file changed, 75 insertions(+), 47 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 3284a5d1fb..94921c04b1 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -22,33 +22,6 @@ static void scsi_req_dequeue(SCSIRequest *req);
 static uint8_t *scsi_target_alloc_buf(SCSIRequest *req, size_t len);
 static void scsi_target_free_buf(SCSIRequest *req);
 
-static Property scsi_props[] = {
-    DEFINE_PROP_UINT32("channel", SCSIDevice, channel, 0),
-    DEFINE_PROP_UINT32("scsi-id", SCSIDevice, id, -1),
-    DEFINE_PROP_UINT32("lun", SCSIDevice, lun, -1),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void scsi_bus_class_init(ObjectClass *klass, void *data)
-{
-    BusClass *k = BUS_CLASS(klass);
-    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
-
-    k->get_dev_path = scsibus_get_dev_path;
-    k->get_fw_dev_path = scsibus_get_fw_dev_path;
-    hc->unplug = qdev_simple_device_unplug_cb;
-}
-
-static const TypeInfo scsi_bus_info = {
-    .name = TYPE_SCSI_BUS,
-    .parent = TYPE_BUS,
-    .instance_size = sizeof(SCSIBus),
-    .class_init = scsi_bus_class_init,
-    .interfaces = (InterfaceInfo[]) {
-        { TYPE_HOTPLUG_HANDLER },
-        { }
-    }
-};
 static int next_scsi_bus;
 
 static void scsi_device_realize(SCSIDevice *s, Error **errp)
@@ -160,35 +133,68 @@ static void scsi_dma_restart_cb(void *opaque, int running, RunState state)
     }
 }
 
-static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
+static bool scsi_bus_is_address_free(SCSIBus *bus,
+				     int channel, int target, int lun,
+				     SCSIDevice **p_dev)
+{
+    SCSIDevice *d = scsi_device_find(bus, channel, target, lun);
+    if (d && d->lun == lun) {
+        if (p_dev) {
+            *p_dev = d;
+        }
+        return false;
+    }
+    if (p_dev) {
+        *p_dev = NULL;
+    }
+    return true;
+}
+
+static bool scsi_bus_check_address(BusState *qbus, DeviceState *qdev, Error **errp)
 {
     SCSIDevice *dev = SCSI_DEVICE(qdev);
-    SCSIBus *bus = DO_UPCAST(SCSIBus, qbus, dev->qdev.parent_bus);
-    SCSIDevice *d;
-    Error *local_err = NULL;
+    SCSIBus *bus = SCSI_BUS(qbus);
 
     if (dev->channel > bus->info->max_channel) {
         error_setg(errp, "bad scsi channel id: %d", dev->channel);
-        return;
+        return false;
     }
     if (dev->id != -1 && dev->id > bus->info->max_target) {
         error_setg(errp, "bad scsi device id: %d", dev->id);
-        return;
+        return false;
     }
     if (dev->lun != -1 && dev->lun > bus->info->max_lun) {
         error_setg(errp, "bad scsi device lun: %d", dev->lun);
-        return;
+        return false;
+    }
+
+    if (dev->id != -1 && dev->lun != -1) {
+        SCSIDevice *d;
+        if (!scsi_bus_is_address_free(bus, dev->channel, dev->id, dev->lun, &d)) {
+            error_setg(errp, "lun already used by '%s'", d->qdev.id);
+            return false;
+        }
     }
 
+    return true;
+}
+
+static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
+{
+    SCSIDevice *dev = SCSI_DEVICE(qdev);
+    SCSIBus *bus = DO_UPCAST(SCSIBus, qbus, dev->qdev.parent_bus);
+    bool is_free;
+    Error *local_err = NULL;
+
     if (dev->id == -1) {
         int id = -1;
         if (dev->lun == -1) {
             dev->lun = 0;
         }
         do {
-            d = scsi_device_find(bus, dev->channel, ++id, dev->lun);
-        } while (d && d->lun == dev->lun && id < bus->info->max_target);
-        if (d && d->lun == dev->lun) {
+            is_free = scsi_bus_is_address_free(bus, dev->channel, ++id, dev->lun, NULL);
+        } while (!is_free && id < bus->info->max_target);
+        if (!is_free) {
             error_setg(errp, "no free target");
             return;
         }
@@ -196,20 +202,13 @@ static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
     } else if (dev->lun == -1) {
         int lun = -1;
         do {
-            d = scsi_device_find(bus, dev->channel, dev->id, ++lun);
-        } while (d && d->lun == lun && lun < bus->info->max_lun);
-        if (d && d->lun == lun) {
+            is_free = scsi_bus_is_address_free(bus, dev->channel, dev->id, ++lun, NULL);
+        } while (!is_free && lun < bus->info->max_lun);
+        if (!is_free) {
             error_setg(errp, "no free lun");
             return;
         }
         dev->lun = lun;
-    } else {
-        d = scsi_device_find(bus, dev->channel, dev->id, dev->lun);
-        assert(d);
-        if (d->lun == dev->lun && dev != d) {
-            error_setg(errp, "lun already used by '%s'", d->qdev.id);
-            return;
-        }
     }
 
     QTAILQ_INIT(&dev->requests);
@@ -1709,6 +1708,13 @@ const VMStateDescription vmstate_scsi_device = {
     }
 };
 
+static Property scsi_props[] = {
+    DEFINE_PROP_UINT32("channel", SCSIDevice, channel, 0),
+    DEFINE_PROP_UINT32("scsi-id", SCSIDevice, id, -1),
+    DEFINE_PROP_UINT32("lun", SCSIDevice, lun, -1),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void scsi_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
@@ -1739,6 +1745,28 @@ static const TypeInfo scsi_device_type_info = {
     .instance_init = scsi_dev_instance_init,
 };
 
+static void scsi_bus_class_init(ObjectClass *klass, void *data)
+{
+    BusClass *k = BUS_CLASS(klass);
+    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
+
+    k->get_dev_path = scsibus_get_dev_path;
+    k->get_fw_dev_path = scsibus_get_fw_dev_path;
+    k->check_address = scsi_bus_check_address;
+    hc->unplug = qdev_simple_device_unplug_cb;
+}
+
+static const TypeInfo scsi_bus_info = {
+    .name = TYPE_SCSI_BUS,
+    .parent = TYPE_BUS,
+    .instance_size = sizeof(SCSIBus),
+    .class_init = scsi_bus_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_HOTPLUG_HANDLER },
+        { }
+    }
+};
+
 static void scsi_register_types(void)
 {
     type_register_static(&scsi_bus_info);
-- 
2.26.2



