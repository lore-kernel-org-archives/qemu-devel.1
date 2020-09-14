Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AA0C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 02:00:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27FE221655
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 02:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VA6Ud4Sa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27FE221655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHdmo-0003di-7C
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 22:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kHdm1-000232-4D
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 21:59:17 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:36293)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kHdlz-0008EW-IY
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 21:59:16 -0400
Received: by mail-ot1-x329.google.com with SMTP id 60so13496545otw.3
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 18:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o4mSoG5q+aRN/4U3JPRKEBXuvYdbubdRIlCE9XVbaLk=;
 b=VA6Ud4SaMDV1lBkSxrzPmPWbrsbcDlwqZT3KDx+PF1IooRSJjQqiQBQEVT/VkZTmWn
 OlEXsoF+85PI1PWedWqV8rrp99Q3Ki4zvvulTblbbP/EvJtqmp0vTbznHbV186zwwQNO
 lRs+BzWJSG1w7LBRaY6K+i0l777YrF8Wq+YB6AXb9xAgVZgS8EBSCigXdcL0QVHm51Pb
 uo8Wbe6ETC4WyWhrM4C3gXUocpIplR5AmFmOIDWEXsntIL8kA87v/PSVB8h2E0ZkK8lE
 GuyIRRwgTzpze9HSXZF3Rd1KYukXuymOxdwaumSOkwBqYpoIrawk8ZZTzgdaHCUsSlaa
 okNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=o4mSoG5q+aRN/4U3JPRKEBXuvYdbubdRIlCE9XVbaLk=;
 b=tTv/4vQAI0YSdOuSnqc0EjPSxFSp6LzMYpLGicF8bNd54ke2QmHcRJi3keQqmLEo7q
 nblZ2C4yBrukIC4vUNrQtXUeknpgCoN7PaIGr1ebMN+AlPjIvHWv3mOaHCE4R5bj57Xs
 ZcS6vxIq8BYrJ07yLcXKkwbRDNVFhAkQgDd+9xmAQpgWnW0Wv9frDNUc0zUypdCSKMVF
 emxhsSwL1xN1vQx9/BGp3kObwZqIBKM1kllJRZe4etKP43VonAMRnHz4NmtqogeZ8D1K
 EtWMziF+DLQeToAgePAlHVFaUsfr5pNkOl4nc6rZN4M4JUxxNi9mOYz0KOwcVW8+yx+F
 yYYQ==
X-Gm-Message-State: AOAM531w9u95q2Wp1ZRlYhgscgmlVBo6n1l5jxNPLaUC9Dmn8AfzKlTg
 ujqK/PbsppHZeiFTgH09SROAdMCdDUE=
X-Google-Smtp-Source: ABdhPJymBiD6IqHFFXYXNpQLtjcofYEdrO/73Y/z3a1+1wxexnaAW2LMEjuhhhI6HWUitdvXPE14og==
X-Received: by 2002:a9d:10d:: with SMTP id 13mr8364355otu.130.1600048753964;
 Sun, 13 Sep 2020 18:59:13 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id b17sm2752717oog.25.2020.09.13.18.59.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 13 Sep 2020 18:59:13 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/4] qga/commands-posix: Rework
 build_guest_fsinfo_for_real_device() function
Date: Sun, 13 Sep 2020 20:58:59 -0500
Message-Id: <20200914015902.25769-2-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914015902.25769-1-mdroth@linux.vnet.ibm.com>
References: <20200914015902.25769-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x329.google.com
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

We are going to support non-PCI devices soon. For this we need to split
the generic GuestDiskAddress and GuestDiskAddressList memory allocation
and list chaining into a separate function first.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-posix.c | 65 ++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 24 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 1a62a3a70d..1a42ec8171 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -861,28 +861,30 @@ static int build_hosts(char const *syspath, char const *host, bool ata,
     return i;
 }
 
-/* Store disk device info specified by @sysfs into @fs */
-static void build_guest_fsinfo_for_real_device(char const *syspath,
-                                               GuestFilesystemInfo *fs,
-                                               Error **errp)
+/*
+ * Store disk device info for devices on the PCI bus.
+ * Returns true if information has been stored, or false for failure.
+ */
+static bool build_guest_fsinfo_for_pci_dev(char const *syspath,
+                                           GuestDiskAddress *disk,
+                                           Error **errp)
 {
     unsigned int pci[4], host, hosts[8], tgt[3];
     int i, nhosts = 0, pcilen;
-    GuestDiskAddress *disk;
-    GuestPCIAddress *pciaddr;
-    GuestDiskAddressList *list = NULL;
+    GuestPCIAddress *pciaddr = disk->pci_controller;
     bool has_ata = false, has_host = false, has_tgt = false;
     char *p, *q, *driver = NULL;
 #ifdef CONFIG_LIBUDEV
     struct udev *udev = NULL;
     struct udev_device *udevice = NULL;
 #endif
+    bool ret = false;
 
     p = strstr(syspath, "/devices/pci");
     if (!p || sscanf(p + 12, "%*x:%*x/%x:%x:%x.%x%n",
                      pci, pci + 1, pci + 2, pci + 3, &pcilen) < 4) {
         g_debug("only pci device is supported: sysfs path '%s'", syspath);
-        return;
+        return false;
     }
 
     p += 12 + pcilen;
@@ -903,7 +905,7 @@ static void build_guest_fsinfo_for_real_device(char const *syspath,
         }
 
         g_debug("unsupported driver or sysfs path '%s'", syspath);
-        return;
+        return false;
     }
 
     p = strstr(syspath, "/target");
@@ -929,18 +931,11 @@ static void build_guest_fsinfo_for_real_device(char const *syspath,
         }
     }
 
-    pciaddr = g_malloc0(sizeof(*pciaddr));
     pciaddr->domain = pci[0];
     pciaddr->bus = pci[1];
     pciaddr->slot = pci[2];
     pciaddr->function = pci[3];
 
-    disk = g_malloc0(sizeof(*disk));
-    disk->pci_controller = pciaddr;
-
-    list = g_malloc0(sizeof(*list));
-    list->value = disk;
-
 #ifdef CONFIG_LIBUDEV
     udev = udev_new();
     udevice = udev_device_new_from_syspath(udev, syspath);
@@ -1018,21 +1013,43 @@ static void build_guest_fsinfo_for_real_device(char const *syspath,
         goto cleanup;
     }
 
-    list->next = fs->disk;
-    fs->disk = list;
-    goto out;
+    ret = true;
 
 cleanup:
-    if (list) {
-        qapi_free_GuestDiskAddressList(list);
-    }
-out:
     g_free(driver);
 #ifdef CONFIG_LIBUDEV
     udev_unref(udev);
     udev_device_unref(udevice);
 #endif
-    return;
+    return ret;
+}
+
+/* Store disk device info specified by @sysfs into @fs */
+static void build_guest_fsinfo_for_real_device(char const *syspath,
+                                               GuestFilesystemInfo *fs,
+                                               Error **errp)
+{
+    GuestDiskAddress *disk;
+    GuestPCIAddress *pciaddr;
+    GuestDiskAddressList *list = NULL;
+    bool has_hwinf;
+
+    pciaddr = g_new0(GuestPCIAddress, 1);
+
+    disk = g_new0(GuestDiskAddress, 1);
+    disk->pci_controller = pciaddr;
+
+    list = g_new0(GuestDiskAddressList, 1);
+    list->value = disk;
+
+    has_hwinf = build_guest_fsinfo_for_pci_dev(syspath, disk, errp);
+
+    if (has_hwinf) {
+        list->next = fs->disk;
+        fs->disk = list;
+    } else {
+        qapi_free_GuestDiskAddressList(list);
+    }
 }
 
 static void build_guest_fsinfo_for_device(char const *devpath,
-- 
2.17.1


