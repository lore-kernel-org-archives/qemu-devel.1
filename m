Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B10DC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:15:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A3182067C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQxAp6by"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3182067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFDFk-00035t-ML
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 05:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1kFDEj-0002CO-2g
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:14:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1kFDEh-00029U-5j
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599470090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+osGm5VoqFfp8g5HnBUBNDMbAdQdsswlF1C+9TeRIP0=;
 b=PQxAp6byvys4F4sOG+Gx6N7PeSg0h4hUby8aQ3bjPrFcfatl/gONngevklECLPxdtN6kk7
 xCedlAUo3fya5jNWMIJLqRmGa/B4YYsbXFJll7HoCVLPHc9d9XRkg86EORQEymqRq1phTM
 MVxJ9EHDKvQIKt/15asS4gScPyV4gm8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-vJ9pxOaSNdCVUhqkMVwP7w-1; Mon, 07 Sep 2020 05:14:48 -0400
X-MC-Unique: vJ9pxOaSNdCVUhqkMVwP7w-1
Received: by mail-ej1-f71.google.com with SMTP id md9so5046252ejb.8
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 02:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+osGm5VoqFfp8g5HnBUBNDMbAdQdsswlF1C+9TeRIP0=;
 b=qjOz3PlDgqebPcAdGtBdYajMw2cmvizU4hdiuYljyLzgp+tgbQVvLv8lkwkxgMpiyI
 ZHE0forJN9wixJpnrfEhpHp9kNdqqyJeit/gD2fTZBG1v8V7C5BPgEhvpIexG2yop8fN
 oCl/lmrebyncWubSbUdrAPsQvoySYn2Xex5bCYHdqXHyb39pX3XgquDDZxf9ZbCd6/St
 Ms5xBgEMwRqAf5DbFBXuB2/IRNpm7uJ2SKgVu4ZK0oi+XRZG8juybVOqga6L+b9h+iL8
 PwAl7kw0k/JGsFpoi5RzRhNtElRlceGvfV0Tc9VXlTvar/1JF1PfEoAAnbwo1aah1irx
 wy+g==
X-Gm-Message-State: AOAM532lIcMyZyXwmAsD727uj3QnmjxoKc4SemKJVH0pdPexPem6KKwh
 K32Q5rh9JaShdQDkm8Ja/Yv8uHOjG5LZPAcKLG1KzmwlxGiMwYBLSek7rCqhQB41R7rgJbcEZDn
 JBDk+Dj93DVG67Is=
X-Received: by 2002:a17:906:4cc6:: with SMTP id
 q6mr12809327ejt.201.1599470086881; 
 Mon, 07 Sep 2020 02:14:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysKo3MUs17TWXGHG1hDfFh0K7NB9Ee4T9nbDSWlw3emoDJcn33PsOChEtn026O5kNrUw3ULw==
X-Received: by 2002:a17:906:4cc6:: with SMTP id
 q6mr12809311ejt.201.1599470086693; 
 Mon, 07 Sep 2020 02:14:46 -0700 (PDT)
Received: from auriga.localdomain (ip-89-176-41-222.net.upcbroadband.cz.
 [89.176.41.222])
 by smtp.gmail.com with ESMTPSA id d6sm14394910edm.31.2020.09.07.02.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 02:14:46 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] qga: add implementation of guest-get-disks for Windows
Date: Mon,  7 Sep 2020 11:14:42 +0200
Message-Id: <2cd59ce454e0da02eeb75ab7461ef420b30864f5.1599470071.git.tgolembi@redhat.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1599470071.git.tgolembi@redhat.com>
References: <cover.1599470071.git.tgolembi@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=tgolembi@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=tgolembi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:52:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The command lists all the physical disk drives. Unlike for Linux
partitions and virtual volumes are not listed.

Example output:

{
  "return": [
    {
      "name": "\\\\.\\PhysicalDrive0",
      "partition": false,
      "address": {
        "serial": "QM00001",
        "bus-type": "sata",
        ...
      },
      "slaves": []
    }
  ]
}

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 qga/commands-win32.c | 97 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 91 insertions(+), 6 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index e9976a0c46..9ac847a187 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -945,6 +945,91 @@ out:
     return list;
 }
 
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
+{
+    GuestDiskInfoList *new = NULL, *ret = NULL;
+    HDEVINFO dev_info;
+    SP_DEVICE_INTERFACE_DATA dev_iface_data;
+    int i;
+
+    dev_info = SetupDiGetClassDevs(&GUID_DEVINTERFACE_DISK, 0, 0,
+        DIGCF_PRESENT | DIGCF_DEVICEINTERFACE);
+    if (dev_info == INVALID_HANDLE_VALUE) {
+        error_setg_win32(errp, GetLastError(), "failed to get device tree");
+        return NULL;
+    }
+
+    g_debug("enumerating devices");
+    dev_iface_data.cbSize = sizeof(SP_DEVICE_INTERFACE_DATA);
+    for (i = 0;
+        SetupDiEnumDeviceInterfaces(dev_info, NULL, &GUID_DEVINTERFACE_DISK,
+            i, &dev_iface_data);
+        i++) {
+        GuestDiskAddress *address = NULL;
+        GuestDiskInfo *disk = NULL;
+        Error *local_err = NULL;
+        g_autofree PSP_DEVICE_INTERFACE_DETAIL_DATA
+            pdev_iface_detail_data = NULL;
+        STORAGE_DEVICE_NUMBER sdn;
+        HANDLE dev_file;
+        DWORD size = 0;
+
+        g_debug("  getting device path");
+        while (!SetupDiGetDeviceInterfaceDetail(dev_info, &dev_iface_data,
+                pdev_iface_detail_data,
+                size, &size,
+                NULL)) {
+            if (GetLastError() == ERROR_INSUFFICIENT_BUFFER) {
+                pdev_iface_detail_data = g_malloc(size);
+                pdev_iface_detail_data->cbSize =
+                    sizeof(*pdev_iface_detail_data);
+            } else {
+                g_debug("failed to get device interface details");
+                continue;
+            }
+        }
+
+        g_debug("  device: %s", pdev_iface_detail_data->DevicePath);
+        dev_file = CreateFile(pdev_iface_detail_data->DevicePath, 0,
+            FILE_SHARE_READ, NULL, OPEN_EXISTING, 0, NULL);
+        if (!DeviceIoControl(dev_file, IOCTL_STORAGE_GET_DEVICE_NUMBER,
+                NULL, 0, &sdn, sizeof(sdn), &size, NULL)) {
+            CloseHandle(dev_file);
+            debug_error("failed to get storage device number");
+            continue;
+        }
+        CloseHandle(dev_file);
+
+        disk = g_new0(GuestDiskInfo, 1);
+        disk->name = g_strdup_printf("\\\\.\\PhysicalDrive%lu",
+            sdn.DeviceNumber);
+
+        g_debug("  number: %lu", sdn.DeviceNumber);
+        address = g_malloc0(sizeof(GuestDiskAddress));
+        address->has_dev = true;
+        address->dev = g_strdup(disk->name);
+        get_single_disk_info(sdn.DeviceNumber, address, &local_err);
+        if (local_err) {
+            g_debug("failed to get disk info: %s",
+                error_get_pretty(local_err));
+            error_free(local_err);
+            qapi_free_GuestDiskAddress(address);
+            address = NULL;
+        } else {
+            disk->address = address;
+            disk->has_address = true;
+        }
+
+        new = g_malloc0(sizeof(GuestDiskInfoList));
+        new->value = disk;
+        new->next = ret;
+        ret = new;
+    }
+
+    SetupDiDestroyDeviceInfoList(dev_info);
+    return ret;
+}
+
 #else
 
 static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
@@ -952,6 +1037,12 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
     return NULL;
 }
 
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+    return NULL;
+}
+
 #endif /* CONFIG_QGA_NTDDSCSI */
 
 static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **errp)
@@ -2229,9 +2320,3 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
 
     return info;
 }
-
-GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
-- 
2.25.0


