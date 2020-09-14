Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DB3C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 02:01:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8327C21655
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 02:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdwFSN1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8327C21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHdoO-0006Ja-MI
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 22:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kHdm5-00029c-8l
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 21:59:21 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:36297)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kHdm3-0008Hh-2j
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 21:59:20 -0400
Received: by mail-ot1-x32d.google.com with SMTP id 60so13496622otw.3
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 18:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9RoMuOnlNagsssayOjT/cEjQxFzxPt4HphwvxS7xW0s=;
 b=jdwFSN1fzDQne+euwSO3WzKrANuDZIvTnBMY+qhFV+axTTw2aoLQkGetUg8nzC0iP1
 dd2vKb+tHJZBckv8poape3Xq9gzH80DBojd5OPoKFVlPSMDre2K2eiZbmjDYKIvxx7pw
 quB1QbvZSU54DPUmDhncr0+sMSmjJnIK1PbfxNqHHRU0w2U6Lk0+Ev7hU5c1xTsGQp4s
 gCAtrcq3vdfAyiRw8aoFFIGflc1IX27QkVyf+LdP/7zALtxAFfS3UFwmQtoqyug0aOdP
 QRBuTDP2w/N9WCEKMX6ks7HY+LF64eso74MS62cKO8f1MivZTbDK4QZsA3uk4lqf/kqs
 93Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=9RoMuOnlNagsssayOjT/cEjQxFzxPt4HphwvxS7xW0s=;
 b=YCB9JP9W0Qnd+6bu6pTnf6h8zRVSDLrNoPHrs4sz5Tuk+QcLaA0cmoBWz8Z5qrOPWU
 8c04IbOdcNgEqCSeBdhn/IcxJyw9f0L5FuFoDwSftGcg77GxqqTN/Yv/kzFS0JnQh1r/
 wziSnJpiInTg1BguMT+5LJJhkr4ihQX+tO7mPE8s+RWmDyVTECybVumzd0f/IJhURHTj
 KGVSRYEDw8YFNK/KJeFXN6t86AZPpAJtpeeWlMFf6MX8CesRULXRACfRWhHzV1qIWJcC
 NKFXK1AI+fTKM5n1qaQ4G5tWRUTU3ZyBWmoxazhUfwvytvi3zORLdaKgVNjKcrwMWoj8
 UUVA==
X-Gm-Message-State: AOAM530X9tXxCE2HwJTrAkeZr8GlNIM7RxAbnKAkB3m0gX9s3RHgn+Ko
 Xt+tAZ6bgcaJA9jljQGN+pBZ/NJLnXU=
X-Google-Smtp-Source: ABdhPJwdf0rGfZefoEvBAHsnnuIwrKak0mNOqQxavdny69vFkzeVx5QWwoBrKdrW5YvbkUwaDnG93Q==
X-Received: by 2002:a9d:74d8:: with SMTP id a24mr7660450otl.211.1600048757611; 
 Sun, 13 Sep 2020 18:59:17 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id c26sm2371652otr.50.2020.09.13.18.59.16
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 13 Sep 2020 18:59:17 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/4] qga: add command guest-get-devices for reporting VirtIO
 devices
Date: Sun, 13 Sep 2020 20:59:02 -0500
Message-Id: <20200914015902.25769-5-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914015902.25769-1-mdroth@linux.vnet.ibm.com>
References: <20200914015902.25769-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x32d.google.com
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tomáš Golembiovský <tgolembi@redhat.com>

Add command for reporting devices on Windows guest. The intent is not so
much to report the devices but more importantly the driver (and its
version) that is assigned to the device. This gives caller the
information whether VirtIO drivers are installed and/or whether
inadequate driver is used on a device (e.g. QXL device with base VGA
driver).

Example:
[
    {
      "driver-date": "2019-08-12",
      "driver-name": "Red Hat VirtIO SCSI controller",
      "driver-version": "100.80.104.17300",
      "address": {
        "type": "pci",
        "data": {
          "device-id": 4162,
          "vendor-id": 6900
        }
      }
    },
    ...
]

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
*remove redundant glib autoptr declaration for GuestDeviceInfo
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-posix.c |   9 ++
 qga/commands-win32.c | 210 ++++++++++++++++++++++++++++++++++++++++++-
 qga/qapi-schema.json |  51 +++++++++++
 3 files changed, 269 insertions(+), 1 deletion(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 744c2b5a5d..af5a58a9fd 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -2822,6 +2822,8 @@ GList *ga_command_blacklist_init(GList *blacklist)
     blacklist = g_list_append(blacklist, g_strdup("guest-fstrim"));
 #endif
 
+    blacklist = g_list_append(blacklist, g_strdup("guest-get-devices"));
+
     return blacklist;
 }
 
@@ -3042,3 +3044,10 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
 
     return info;
 }
+
+GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+
+    return NULL;
+}
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 15c9d7944b..48d8bbe649 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -21,10 +21,11 @@
 #ifdef CONFIG_QGA_NTDDSCSI
 #include <winioctl.h>
 #include <ntddscsi.h>
+#endif
 #include <setupapi.h>
 #include <cfgmgr32.h>
 #include <initguid.h>
-#endif
+#include <devpropdef.h>
 #include <lm.h>
 #include <wtsapi32.h>
 #include <wininet.h>
@@ -39,6 +40,36 @@
 #include "qemu/base64.h"
 #include "commands-common.h"
 
+/*
+ * The following should be in devpkey.h, but it isn't. The key names were
+ * prefixed to avoid (future) name clashes. Once the definitions get into
+ * mingw the following lines can be removed.
+ */
+DEFINE_DEVPROPKEY(qga_DEVPKEY_NAME, 0xb725f130, 0x47ef, 0x101a, 0xa5,
+    0xf1, 0x02, 0x60, 0x8c, 0x9e, 0xeb, 0xac, 10);
+    /* DEVPROP_TYPE_STRING */
+DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_HardwareIds, 0xa45c254e, 0xdf1c,
+    0x4efd, 0x80, 0x20, 0x67, 0xd1, 0x46, 0xa8, 0x50, 0xe0, 3);
+    /* DEVPROP_TYPE_STRING_LIST */
+DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverDate, 0xa8b865dd, 0x2e3d,
+    0x4094, 0xad, 0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, 2);
+    /* DEVPROP_TYPE_FILETIME */
+DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverVersion, 0xa8b865dd, 0x2e3d,
+    0x4094, 0xad, 0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, 3);
+    /* DEVPROP_TYPE_STRING */
+/* The following shoud be in cfgmgr32.h, but it isn't */
+#ifndef CM_Get_DevNode_Property
+CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(
+    DEVINST          dnDevInst,
+    CONST DEVPROPKEY * PropertyKey,
+    DEVPROPTYPE      * PropertyType,
+    PBYTE            PropertyBuffer,
+    PULONG           PropertyBufferSize,
+    ULONG            ulFlags
+);
+#define CM_Get_DevNode_Property CM_Get_DevNode_PropertyW
+#endif
+
 #ifndef SHTDN_REASON_FLAG_PLANNED
 #define SHTDN_REASON_FLAG_PLANNED 0x80000000
 #endif
@@ -2246,3 +2277,180 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
 
     return info;
 }
+
+/*
+ * Safely get device property. Returned strings are using wide characters.
+ * Caller is responsible for freeing the buffer.
+ */
+static LPBYTE cm_get_property(DEVINST devInst, const DEVPROPKEY *propName,
+    PDEVPROPTYPE propType)
+{
+    CONFIGRET cr;
+    g_autofree LPBYTE buffer = NULL;
+    ULONG buffer_len = 0;
+
+    /* First query for needed space */
+    cr = CM_Get_DevNode_PropertyW(devInst, propName, propType,
+        buffer, &buffer_len, 0);
+    if (cr != CR_SUCCESS && cr != CR_BUFFER_SMALL) {
+
+        slog("failed to get property size, error=0x%lx", cr);
+        return NULL;
+    }
+    buffer = g_new0(BYTE, buffer_len + 1);
+    cr = CM_Get_DevNode_PropertyW(devInst, propName, propType,
+        buffer, &buffer_len, 0);
+    if (cr != CR_SUCCESS) {
+        slog("failed to get device property, error=0x%lx", cr);
+        return NULL;
+    }
+    return g_steal_pointer(&buffer);
+}
+
+static GStrv ga_get_hardware_ids(DEVINST devInstance)
+{
+    GArray *values = NULL;
+    DEVPROPTYPE cm_type;
+    LPWSTR id;
+    g_autofree LPWSTR property = (LPWSTR)cm_get_property(devInstance,
+        &qga_DEVPKEY_Device_HardwareIds, &cm_type);
+    if (property == NULL) {
+        slog("failed to get hardware IDs");
+        return NULL;
+    }
+    if (*property == '\0') {
+        /* empty list */
+        return NULL;
+    }
+    values = g_array_new(TRUE, TRUE, sizeof(gchar *));
+    for (id = property; '\0' != *id; id += lstrlenW(id) + 1) {
+        gchar *id8 = g_utf16_to_utf8(id, -1, NULL, NULL, NULL);
+        g_array_append_val(values, id8);
+    }
+    return (GStrv)g_array_free(values, FALSE);
+}
+
+/*
+ * https://docs.microsoft.com/en-us/windows-hardware/drivers/install/identifiers-for-pci-devices
+ */
+#define DEVICE_PCI_RE "PCI\\\\VEN_(1AF4|1B36)&DEV_([0-9A-B]{4})(&|$)"
+
+GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
+{
+    GuestDeviceInfoList *head = NULL, *cur_item = NULL, *item = NULL;
+    HDEVINFO dev_info = INVALID_HANDLE_VALUE;
+    SP_DEVINFO_DATA dev_info_data;
+    int i, j;
+    GError *gerr = NULL;
+    g_autoptr(GRegex) device_pci_re = NULL;
+    DEVPROPTYPE cm_type;
+
+    device_pci_re = g_regex_new(DEVICE_PCI_RE,
+        G_REGEX_ANCHORED | G_REGEX_OPTIMIZE, 0,
+        &gerr);
+    g_assert(device_pci_re != NULL);
+
+    dev_info_data.cbSize = sizeof(SP_DEVINFO_DATA);
+    dev_info = SetupDiGetClassDevs(0, 0, 0, DIGCF_PRESENT | DIGCF_ALLCLASSES);
+    if (dev_info == INVALID_HANDLE_VALUE) {
+        error_setg(errp, "failed to get device tree");
+        return NULL;
+    }
+
+    slog("enumerating devices");
+    for (i = 0; SetupDiEnumDeviceInfo(dev_info, i, &dev_info_data); i++) {
+        bool skip = true;
+        SYSTEMTIME utc_date;
+        g_autofree LPWSTR name = NULL;
+        g_autofree LPFILETIME date = NULL;
+        g_autofree LPWSTR version = NULL;
+        g_auto(GStrv) hw_ids = NULL;
+        g_autoptr(GuestDeviceInfo) device = g_new0(GuestDeviceInfo, 1);
+        g_autofree char *vendor_id = NULL;
+        g_autofree char *device_id = NULL;
+
+        name = (LPWSTR)cm_get_property(dev_info_data.DevInst,
+            &qga_DEVPKEY_NAME, &cm_type);
+        if (name == NULL) {
+            slog("failed to get device description");
+            continue;
+        }
+        device->driver_name = g_utf16_to_utf8(name, -1, NULL, NULL, NULL);
+        if (device->driver_name == NULL) {
+            error_setg(errp, "conversion to utf8 failed (driver name)");
+            continue;
+        }
+        slog("querying device: %s", device->driver_name);
+        hw_ids = ga_get_hardware_ids(dev_info_data.DevInst);
+        if (hw_ids == NULL) {
+            continue;
+        }
+        for (j = 0; hw_ids[j] != NULL; j++) {
+            GMatchInfo *match_info;
+            GuestDeviceAddressPCI *address;
+            if (!g_regex_match(device_pci_re, hw_ids[j], 0, &match_info)) {
+                continue;
+            }
+            skip = false;
+
+            address = g_new0(GuestDeviceAddressPCI, 1);
+            vendor_id = g_match_info_fetch(match_info, 1);
+            device_id = g_match_info_fetch(match_info, 2);
+            address->vendor_id = g_ascii_strtoull(vendor_id, NULL, 16);
+            address->device_id = g_ascii_strtoull(device_id, NULL, 16);
+
+            device->address = g_new0(GuestDeviceAddress, 1);
+            device->has_address = true;
+            device->address->type = GUEST_DEVICE_ADDRESS_KIND_PCI;
+            device->address->u.pci.data = address;
+
+            g_match_info_free(match_info);
+            break;
+        }
+        if (skip) {
+            continue;
+        }
+
+        version = (LPWSTR)cm_get_property(dev_info_data.DevInst,
+            &qga_DEVPKEY_Device_DriverVersion, &cm_type);
+        if (version == NULL) {
+            slog("failed to get driver version");
+            continue;
+        }
+        device->driver_version = g_utf16_to_utf8(version, -1, NULL,
+            NULL, NULL);
+        if (device->driver_version == NULL) {
+            error_setg(errp, "conversion to utf8 failed (driver version)");
+            continue;
+        }
+        device->has_driver_version = true;
+
+        date = (LPFILETIME)cm_get_property(dev_info_data.DevInst,
+            &qga_DEVPKEY_Device_DriverDate, &cm_type);
+        if (date == NULL) {
+            slog("failed to get driver date");
+            continue;
+        }
+        FileTimeToSystemTime(date, &utc_date);
+        device->driver_date = g_strdup_printf("%04d-%02d-%02d",
+            utc_date.wYear, utc_date.wMonth, utc_date.wDay);
+        device->has_driver_date = true;
+
+        slog("driver: %s\ndriver version: %s,%s\n", device->driver_name,
+            device->driver_date, device->driver_version);
+        item = g_new0(GuestDeviceInfoList, 1);
+        item->value = g_steal_pointer(&device);
+        if (!cur_item) {
+            head = cur_item = item;
+        } else {
+            cur_item->next = item;
+            cur_item = item;
+        }
+        continue;
+    }
+
+    if (dev_info != INVALID_HANDLE_VALUE) {
+        SetupDiDestroyDeviceInfoList(dev_info);
+    }
+    return head;
+}
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index b1e9ed836d..d2ea7446db 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1253,3 +1253,54 @@
 ##
 { 'command': 'guest-get-osinfo',
   'returns': 'GuestOSInfo' }
+
+##
+# @GuestDeviceAddressPCI:
+#
+# @vendor-id: vendor ID
+# @device-id: device ID
+#
+# Since: 5.2
+##
+{ 'struct': 'GuestDeviceAddressPCI',
+  'data': { 'vendor-id': 'uint16', 'device-id': 'uint16' } }
+
+##
+# @GuestDeviceAddress:
+#
+# Address of the device
+# - @pci: address of PCI device, since: 5.2
+#
+# Since: 5.2
+##
+{ 'union': 'GuestDeviceAddress',
+  'data': { 'pci': 'GuestDeviceAddressPCI' } }
+
+##
+# @GuestDeviceInfo:
+#
+# @driver-name: name of the associated driver
+# @driver-date: driver release date in format YYYY-MM-DD
+# @driver-version: driver version
+#
+# Since: 5.2
+##
+{ 'struct': 'GuestDeviceInfo',
+  'data': {
+      'driver-name': 'str',
+      '*driver-date': 'str',
+      '*driver-version': 'str',
+      '*address': 'GuestDeviceAddress'
+  } }
+
+##
+# @guest-get-devices:
+#
+# Retrieve information about device drivers in Windows guest
+#
+# Returns: @GuestDeviceInfo
+#
+# Since: 5.2
+##
+{ 'command': 'guest-get-devices',
+  'returns': ['GuestDeviceInfo'] }
-- 
2.17.1


