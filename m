Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7DAC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 02:00:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D72621655
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 02:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwiPDFRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D72621655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHdmp-0003gZ-5h
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 22:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kHdm3-00024L-Bx
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 21:59:19 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32]:37044)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kHdm1-0008H4-Qp
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 21:59:19 -0400
Received: by mail-oo1-xc32.google.com with SMTP id y25so3652205oog.4
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 18:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5T0JpCmR/oQz9FLTWSv2VuE7e0horR/v6KF7kl9A6EA=;
 b=DwiPDFRSrqERqpwT8iR9bfkpMA7jw4uSoS6S6Y5Ehq7nNDXlUFKZNiU8YGHpuv9ruN
 kmxDC5vpNUaq3za9X9nYvDJkQWW0lfrVsUZ+fxrTgtW0IqmapdTeWoplVPsh3xoauX0H
 Lsq6Jyrj6EWSIrCRUhCwLBvDEUPoSsV57QhStBjH0RdkTyKCljLTKN8KNVAvoY0aIpGn
 9irzgSTcje4WReKWef5tjrpkRhBshG/3JKhA2M3SNbYgM+ativ9ygYpt3RnqiLEuL2Id
 05Vj/E74oYatijdNxyROajUBGIwhvYKKvljCcaEokov+uaGgebCWDBPDLL7IYVwkim2r
 xZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=5T0JpCmR/oQz9FLTWSv2VuE7e0horR/v6KF7kl9A6EA=;
 b=Xp9JTwcXTLCXDqu6AgyVifcWTRuA2QyxiK/1tMWYWwxzsZzLtwnT7fr55Uj64d2F4N
 ZHCw1UhKHNc8AfpJcFkm2t4JH7pNS6VKL18PoNB9Q/vcSfl3gadM+7SZiNcJFDzGFfx4
 8V6SIZ/27ajCM3Hz4nwz5S45mZ4pHyAvFYqte5z1aIeQY5zZtewHHhcG0HfaIyxje/qc
 T78CZ6I7h8SCKq9qkQyADNf/O6vdgVI50TBh8gLRTJI4+OM0BnojNKLLEdNY8UVezkh+
 dahFF6IqwOKtIa11AxVFbMad3E4xgGSHJpQoQdzL6BLMTy/X8wGlCBotfQq9fALUoyuE
 EZuw==
X-Gm-Message-State: AOAM533OL2UBHrNVST5+tawryeWdzGWhlEpFomHurskrH6DzIJLRU6y7
 KB7ZammmXrx8rZqJJGnY8tJzDGVayVY=
X-Google-Smtp-Source: ABdhPJywWLiMaiv2GLoImsnWzFRyVnVqxB5N/b3qpL7NrBntuBkSh8BbLL4XIqMsnT9NljkOQVaOhg==
X-Received: by 2002:a4a:864b:: with SMTP id w11mr7285081ooh.67.1600048756520; 
 Sun, 13 Sep 2020 18:59:16 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id m12sm2369587otq.8.2020.09.13.18.59.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 13 Sep 2020 18:59:16 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/4] qga/commands-posix: Support fsinfo for non-PCI virtio
 devices, too
Date: Sun, 13 Sep 2020 20:59:01 -0500
Message-Id: <20200914015902.25769-4-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914015902.25769-1-mdroth@linux.vnet.ibm.com>
References: <20200914015902.25769-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=flukshun@gmail.com; helo=mail-oo1-xc32.google.com
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

QEMU on s390x uses virtio via channel I/O instead of PCI by default.
Add a function to detect and provide information for virtio-scsi and
virtio-block devices here, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-posix.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index e8467ac567..744c2b5a5d 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -996,6 +996,39 @@ cleanup:
     return ret;
 }
 
+/*
+ * Store disk device info for non-PCI virtio devices (for example s390x
+ * channel I/O devices). Returns true if information has been stored, or
+ * false for failure.
+ */
+static bool build_guest_fsinfo_for_nonpci_virtio(char const *syspath,
+                                                 GuestDiskAddress *disk,
+                                                 Error **errp)
+{
+    unsigned int tgt[3];
+    char *p;
+
+    if (!strstr(syspath, "/virtio") || !strstr(syspath, "/block")) {
+        g_debug("Unsupported virtio device '%s'", syspath);
+        return false;
+    }
+
+    p = strstr(syspath, "/target");
+    if (p && sscanf(p + 7, "%*u:%*u:%*u/%*u:%u:%u:%u",
+                    &tgt[0], &tgt[1], &tgt[2]) == 3) {
+        /* virtio-scsi: target*:0:<target>:<unit> */
+        disk->bus_type = GUEST_DISK_BUS_TYPE_SCSI;
+        disk->bus = tgt[0];
+        disk->target = tgt[1];
+        disk->unit = tgt[2];
+    } else {
+        /* virtio-blk: 1 disk per 1 device */
+        disk->bus_type = GUEST_DISK_BUS_TYPE_VIRTIO;
+    }
+
+    return true;
+}
+
 /* Store disk device info specified by @sysfs into @fs */
 static void build_guest_fsinfo_for_real_device(char const *syspath,
                                                GuestFilesystemInfo *fs,
@@ -1046,7 +1079,14 @@ static void build_guest_fsinfo_for_real_device(char const *syspath,
     udev_device_unref(udevice);
 #endif
 
-    has_hwinf = build_guest_fsinfo_for_pci_dev(syspath, disk, errp);
+    if (strstr(syspath, "/devices/pci")) {
+        has_hwinf = build_guest_fsinfo_for_pci_dev(syspath, disk, errp);
+    } else if (strstr(syspath, "/virtio")) {
+        has_hwinf = build_guest_fsinfo_for_nonpci_virtio(syspath, disk, errp);
+    } else {
+        g_debug("Unsupported device type for '%s'", syspath);
+        has_hwinf = false;
+    }
 
     if (has_hwinf || disk->has_dev || disk->has_serial) {
         list->next = fs->disk;
-- 
2.17.1


