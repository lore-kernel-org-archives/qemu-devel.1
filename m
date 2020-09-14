Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD491C2D0F6
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 02:00:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64D8C2168B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 02:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoHgpdM2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D8C2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHdmp-0003ei-8g
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 22:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kHdm2-00023G-GL
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 21:59:18 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:40954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kHdm0-0008G9-TH
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 21:59:18 -0400
Received: by mail-oi1-x236.google.com with SMTP id t76so16176652oif.7
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 18:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qPIPNTwPz2JPOtlyZclHBQ77xy7GpRmo9vH1WLt6diQ=;
 b=OoHgpdM2wGam0s5v6n1OQjNP1xmXCRHaj+Yj2PJkBNDFWaJUiOO5OkQlVX8/8HX8qK
 rXXLAaMmUMtWb95nweoPKcn85zDh/lcjoqckwke5s1Czjnsy5jot4B1tOZDyptf+/VoZ
 aOgWwbJq5bh2RLzjjc6xnm7hmgYtE3DJvpNU5UZ4ZFB/KAAb20Q9MXAcws31JOusSiAx
 rbe/wy3v6z1V41rgJT9zqUXsd/g7y9pUKETCwzxIeDpS+CPg+Inc7vwSsKzcofC+XoJu
 V5LyF2qcX4nGkj9wdT40hBhcTwa7VT9+JKWYbnHvuwYBAhyLH6/RT1maLHblQR4kBgzT
 uXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=qPIPNTwPz2JPOtlyZclHBQ77xy7GpRmo9vH1WLt6diQ=;
 b=EckHNnxS17XYb/O9qf5uprfpEOIWQr09tQWwF9cWeokqIItfEp5nuF+VFl8L8ypMYj
 MVpogSW2WIYD6MaqaOeCtbfVJlhVX/N3lHujx5cN0gavQxuDhLPLUgxmmUQdpJCaaJo4
 lHU++Cl8050FjStVdtcaGRFPWE3ECGwperwooAyPYl34HYRQb65CnDyliEw4dQtPV8aM
 qX92bwAdGWV8XQJUUDShad+1nYfqQeumETFr0p5zXVrwFkJ5M+qB0rj7AMw4X2hv81BO
 XdKcsN4MBPBxymlcg5YMdQr3f0IacrG32wc14N5ks3kZuioCGDxHY+iVRItUtYk9uUID
 qwZQ==
X-Gm-Message-State: AOAM532xuX9Tjc/RHY8Sldz5b+OL+drTpxHHHk9xz6YgOhHVzwLtSuOI
 xbbBVUnSyDkhcG7gC3y2TAjJP76kfjQ=
X-Google-Smtp-Source: ABdhPJxspV9JUIYTXbdx5sMCbRnTzOlhVsF1cudcSubC0NSdsidui3FXAXRO6HB7LAczkG7LAU13nA==
X-Received: by 2002:aca:1312:: with SMTP id e18mr7467435oii.19.1600048755235; 
 Sun, 13 Sep 2020 18:59:15 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id i7sm2390668oto.62.2020.09.13.18.59.14
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 13 Sep 2020 18:59:14 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/4] qga/commands-posix: Move the udev code from the pci to the
 generic function
Date: Sun, 13 Sep 2020 20:59:00 -0500
Message-Id: <20200914015902.25769-3-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914015902.25769-1-mdroth@linux.vnet.ibm.com>
References: <20200914015902.25769-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x236.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

The libudev-related code is independent from the other pci-related code
and can be re-used for non-pci devices (like ccw devices on s390x). Thus
move this part to the generic function.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1755075
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-posix.c | 62 +++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 1a42ec8171..e8467ac567 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -874,10 +874,6 @@ static bool build_guest_fsinfo_for_pci_dev(char const *syspath,
     GuestPCIAddress *pciaddr = disk->pci_controller;
     bool has_ata = false, has_host = false, has_tgt = false;
     char *p, *q, *driver = NULL;
-#ifdef CONFIG_LIBUDEV
-    struct udev *udev = NULL;
-    struct udev_device *udevice = NULL;
-#endif
     bool ret = false;
 
     p = strstr(syspath, "/devices/pci");
@@ -936,26 +932,6 @@ static bool build_guest_fsinfo_for_pci_dev(char const *syspath,
     pciaddr->slot = pci[2];
     pciaddr->function = pci[3];
 
-#ifdef CONFIG_LIBUDEV
-    udev = udev_new();
-    udevice = udev_device_new_from_syspath(udev, syspath);
-    if (udev == NULL || udevice == NULL) {
-        g_debug("failed to query udev");
-    } else {
-        const char *devnode, *serial;
-        devnode = udev_device_get_devnode(udevice);
-        if (devnode != NULL) {
-            disk->dev = g_strdup(devnode);
-            disk->has_dev = true;
-        }
-        serial = udev_device_get_property_value(udevice, "ID_SERIAL");
-        if (serial != NULL && *serial != 0) {
-            disk->serial = g_strdup(serial);
-            disk->has_serial = true;
-        }
-    }
-#endif
-
     if (strcmp(driver, "ata_piix") == 0) {
         /* a host per ide bus, target*:0:<unit>:0 */
         if (!has_host || !has_tgt) {
@@ -1017,10 +993,6 @@ static bool build_guest_fsinfo_for_pci_dev(char const *syspath,
 
 cleanup:
     g_free(driver);
-#ifdef CONFIG_LIBUDEV
-    udev_unref(udev);
-    udev_device_unref(udevice);
-#endif
     return ret;
 }
 
@@ -1033,18 +1005,50 @@ static void build_guest_fsinfo_for_real_device(char const *syspath,
     GuestPCIAddress *pciaddr;
     GuestDiskAddressList *list = NULL;
     bool has_hwinf;
+#ifdef CONFIG_LIBUDEV
+    struct udev *udev = NULL;
+    struct udev_device *udevice = NULL;
+#endif
 
     pciaddr = g_new0(GuestPCIAddress, 1);
+    pciaddr->domain = -1;                       /* -1 means field is invalid */
+    pciaddr->bus = -1;
+    pciaddr->slot = -1;
+    pciaddr->function = -1;
 
     disk = g_new0(GuestDiskAddress, 1);
     disk->pci_controller = pciaddr;
+    disk->bus_type = GUEST_DISK_BUS_TYPE_UNKNOWN;
 
     list = g_new0(GuestDiskAddressList, 1);
     list->value = disk;
 
+#ifdef CONFIG_LIBUDEV
+    udev = udev_new();
+    udevice = udev_device_new_from_syspath(udev, syspath);
+    if (udev == NULL || udevice == NULL) {
+        g_debug("failed to query udev");
+    } else {
+        const char *devnode, *serial;
+        devnode = udev_device_get_devnode(udevice);
+        if (devnode != NULL) {
+            disk->dev = g_strdup(devnode);
+            disk->has_dev = true;
+        }
+        serial = udev_device_get_property_value(udevice, "ID_SERIAL");
+        if (serial != NULL && *serial != 0) {
+            disk->serial = g_strdup(serial);
+            disk->has_serial = true;
+        }
+    }
+
+    udev_unref(udev);
+    udev_device_unref(udevice);
+#endif
+
     has_hwinf = build_guest_fsinfo_for_pci_dev(syspath, disk, errp);
 
-    if (has_hwinf) {
+    if (has_hwinf || disk->has_dev || disk->has_serial) {
         list->next = fs->disk;
         fs->disk = list;
     } else {
-- 
2.17.1


