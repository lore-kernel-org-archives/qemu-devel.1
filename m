Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9B6C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:00:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AC0F2146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC0F2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iClMG-00044g-4G
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 10:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tgolembi@redhat.com>) id 1iCkNi-0005T8-RN
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:57:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tgolembi@redhat.com>) id 1iCkNg-0002Vp-M0
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:57:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38228)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1iCkNg-0002VC-Dl
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:57:24 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 675B961D25
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 12:57:22 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id z205so900112wmb.7
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 05:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/Pu0u9SBVnxpZHrhBpHkP4Ys8a+qTjYYiub8MbGtnbI=;
 b=K67DVGL9WpZJXhKKAz91UWXyxm5h5O6upFM5em9UO7wXmmaOozex7uObioaD4eveun
 5Cf61JPghhF2Xo4Erf8cjtvu/K35H8uhH7p8UZda/3hzPFbA7u5/m+KKSoYUirUXjKkV
 2PHNPWTIcHhHfRVGxSn4hjJglrSRE6Ygvn+IbexFKolTpGIeJjWO7m3JJEtLjAVVHN0O
 RCdTPMJAPVhSVcKB1lwf1jeDtAAevbndkQf3Pm30vqa4M+dUsbmAGD+lIoe+0BJvbIb2
 /HHLjsVSFJ3RpDFrrvj/PKBETLPoHsmyuDQvPfO0uthv4YYzv1yxy5WLRIenAjR3ScUE
 +8Vw==
X-Gm-Message-State: APjAAAWtqrFPGKNdYBHDl9El1zUDr05PDdYi0Pk59rlGCe/a3AoCYBxM
 wpBDZRiixVsnJuEypfqpMlH7lw5SF/fI6K0v5UNZbRmh4l8mUoQ++tcFKtdfkpnAMEqaVxxitEC
 NvLKmnDGTnLVwVT4=
X-Received: by 2002:adf:e849:: with SMTP id d9mr2201977wrn.358.1569329840806; 
 Tue, 24 Sep 2019 05:57:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz+DQrgBfVKIA7q03H5Zu41oKhEGOpQBSxnenx9cZX7aNJtQizh64kDGebiXGcGJBboS07GYg==
X-Received: by 2002:adf:e849:: with SMTP id d9mr2201963wrn.358.1569329840513; 
 Tue, 24 Sep 2019 05:57:20 -0700 (PDT)
Received: from auriga.brq.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id i14sm2421508wra.78.2019.09.24.05.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 05:57:19 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] qga: add command guest-get-devices for reporting VirtIO
 devices
Date: Tue, 24 Sep 2019 14:57:19 +0200
Message-Id: <95b2f9d76104ee09b43159528b35b96eb01bbd8c.1569329826.git.tgolembi@redhat.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add command for reporting devices on Windows guest. The intent is not so
much to report the devices but more importantly the driver (and its
version) that is assigned to the device. This gives caller the
information whether VirtIO drivers are installed and/or whether
inadequate driver is used on a device (e.g. QXL device with base VGA
driver).

Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
---
 qga/commands-posix.c |   9 ++
 qga/commands-win32.c | 209 ++++++++++++++++++++++++++++++++++++++++++-
 qga/qapi-schema.json |  32 +++++++
 3 files changed, 249 insertions(+), 1 deletion(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index dfc05f5b8a..58e93feef9 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -2757,6 +2757,8 @@ GList *ga_command_blacklist_init(GList *blacklist)
     blacklist =3D g_list_append(blacklist, g_strdup("guest-fstrim"));
 #endif
=20
+    blacklist =3D g_list_append(blacklist, g_strdup("guest-get-devices")=
);
+
     return blacklist;
 }
=20
@@ -2977,3 +2979,10 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
=20
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
index 6b67f16faf..14c5607b66 100644
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
@@ -38,6 +39,34 @@
 #include "qemu/host-utils.h"
 #include "qemu/base64.h"
=20
+/*
+ * The following should be in devpkey.h, but it isn't. The key names wer=
e
+ * prefixed to avoid (future) name clashes. Once the definitions get int=
o
+ * mingw the following lines can be removed.
+ */
+DEFINE_DEVPROPKEY(qga_DEVPKEY_NAME, 0xb725f130, 0x47ef, 0x101a, 0xa5, 0x=
f1, 0x02,
+    0x60, 0x8c, 0x9e, 0xeb, 0xac, 10);  /* DEVPROP_TYPE_STRING */
+DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_HardwareIds, 0xa45c254e, 0xdf1c, 0x=
4efd, 0x80,
+    0x20, 0x67, 0xd1, 0x46, 0xa8, 0x50, 0xe0, 3);
+    /* DEVPROP_TYPE_STRING_LIST */
+DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverDate, 0xa8b865dd, 0x2e3d, 0x4=
094, 0xad,
+    0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, 2);  /* DEVPROP_TYPE_FILETI=
ME */
+DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverVersion, 0xa8b865dd, 0x2e3d, =
0x4094,
+    0xad, 0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, 3);
+    /* DEVPROP_TYPE_STRING */
+/* The following shoud be in cfgmgr32.h, but it isn't */
+#ifndef CM_Get_DevNode_Property
+CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(
+    DEVINST          dnDevInst,
+    CONST DEVPROPKEY *PropertyKey,
+    DEVPROPTYPE      *PropertyType,
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
@@ -92,6 +121,8 @@ static OpenFlags guest_file_open_modes[] =3D {
     g_free(suffix); \
 } while (0)
=20
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(GuestDeviceInfo, qapi_free_GuestDeviceInfo=
)
+
 static OpenFlags *find_open_flag(const char *mode_str)
 {
     int mode;
@@ -2234,3 +2265,179 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
=20
     return info;
 }
+
+/*
+ * Safely get device property. Returned strings are using wide character=
s.
+ * Caller is responsible for freeing the buffer.
+ */
+static LPBYTE cm_get_property(DEVINST devInst, const DEVPROPKEY *propNam=
e,
+    PDEVPROPTYPE propType)
+{
+    CONFIGRET cr;
+    g_autofree LPBYTE buffer =3D NULL;
+    ULONG buffer_len =3D 0;
+
+    /* First query for needed space */
+    cr =3D CM_Get_DevNode_PropertyW(devInst, propName, propType,
+        buffer, &buffer_len, 0);
+    if (cr !=3D CR_SUCCESS && cr !=3D CR_BUFFER_SMALL) {
+
+        slog("failed to get property size, error=3D0x%lx", cr);
+        return NULL;
+    }
+    buffer =3D g_malloc(buffer_len+1);
+    cr =3D CM_Get_DevNode_PropertyW(devInst, propName, propType,
+        buffer, &buffer_len, 0);
+    if (cr !=3D CR_SUCCESS) {
+        slog("failed to get device property, error=3D0x%lx", cr);
+        return NULL;
+    }
+    return g_steal_pointer(&buffer);
+}
+
+static GStrv ga_get_hardware_ids(DEVINST devInstance)
+{
+    GStrv hw_ids =3D NULL;
+    g_autoptr(GSList) values =3D NULL;
+    GSList *current =3D NULL;
+    gsize count =3D 0, i =3D 0;
+    DEVPROPTYPE cm_type;
+    LPWSTR id;
+    g_autofree LPWSTR property =3D (LPWSTR)cm_get_property(devInstance,
+        &qga_DEVPKEY_Device_HardwareIds, &cm_type);
+    if (property =3D=3D NULL) {
+        slog("failed to get hardware IDs");
+        return NULL;
+    }
+    if (*property =3D=3D '\0') {
+        /* empty list */
+        return NULL;
+    }
+    for (id =3D property; '\0' !=3D *id; id +=3D lstrlenW(id) + 1) {
+        values =3D g_slist_append(values,
+            g_utf16_to_utf8(id, -1, NULL, NULL, NULL));
+        count++;
+    }
+    hw_ids =3D g_new(char*, count+1);
+    current =3D values;
+    i =3D 0;
+    for (; current !=3D NULL; current =3D g_slist_next(current), i++) {
+        hw_ids[i] =3D g_steal_pointer(&current->data);
+    }
+    hw_ids[i] =3D NULL;
+    return hw_ids;
+}
+
+/*
+ * https://docs.microsoft.com/en-us/windows-hardware/drivers/install/ide=
ntifiers-for-pci-devices
+ */
+#define DEVICE_PCI_RE "PCI\\\\VEN_(1AF4|1B36)&DEV_([0-9A-B]{4})(&|$)"
+
+GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
+{
+    GuestDeviceInfoList *head =3D NULL, *cur_item =3D NULL, *item =3D NU=
LL;
+    HDEVINFO dev_info =3D INVALID_HANDLE_VALUE;
+    SP_DEVINFO_DATA dev_info_data;
+    int i, j;
+    GError *gerr =3D NULL;
+    g_autoptr(GRegex) device_pci_re =3D NULL;
+    DEVPROPTYPE cm_type;
+
+    device_pci_re =3D g_regex_new(DEVICE_PCI_RE,
+        G_REGEX_ANCHORED | G_REGEX_OPTIMIZE, 0,
+        &gerr);
+    g_assert(device_pci_re !=3D NULL);
+
+    dev_info_data.cbSize =3D sizeof(SP_DEVINFO_DATA);
+    dev_info =3D SetupDiGetClassDevs(0, 0, 0, DIGCF_PRESENT | DIGCF_ALLC=
LASSES);
+    if (dev_info =3D=3D INVALID_HANDLE_VALUE) {
+        error_setg(errp, "failed to get device tree");
+        return NULL;
+    }
+
+    slog("enumerating devices");
+    for (i =3D 0; SetupDiEnumDeviceInfo(dev_info, i, &dev_info_data); i+=
+) {
+        bool skip =3D true;
+        SYSTEMTIME utc_date;
+        g_autofree LPWSTR name =3D NULL;
+        g_autofree LPFILETIME date =3D NULL;
+        g_autofree LPWSTR version =3D NULL;
+        g_auto(GStrv) hw_ids =3D NULL;
+        g_autoptr(GuestDeviceInfo) device =3D g_new0(GuestDeviceInfo, 1)=
;
+        g_autofree char* vendor_id =3D NULL;
+        g_autofree char* device_id =3D NULL;
+
+        name =3D (LPWSTR)cm_get_property(dev_info_data.DevInst,
+            &qga_DEVPKEY_NAME, &cm_type);
+        if (name =3D=3D NULL) {
+            slog("failed to get device description");
+            continue;
+        }
+        device->driver_name =3D g_utf16_to_utf8(name, -1, NULL, NULL, NU=
LL);
+        if (device->driver_name =3D=3D NULL) {
+            error_setg(errp, "conversion to utf8 failed (driver name)");
+            goto out;
+        }
+        slog("querying device: %s", device->driver_name);
+        hw_ids =3D ga_get_hardware_ids(dev_info_data.DevInst);
+        if (hw_ids =3D=3D NULL) {
+            continue;
+        }
+        for (j=3D0; hw_ids[j] !=3D NULL; j++) {
+            GMatchInfo *match_info;
+            if (!g_regex_match(device_pci_re, hw_ids[j], 0, &match_info)=
) {
+                continue;
+            }
+            skip =3D false;
+            vendor_id =3D g_match_info_fetch(match_info, 1);
+            device_id =3D g_match_info_fetch(match_info, 2);
+            device->vendor_id =3D g_ascii_strtoull(vendor_id, NULL, 16);
+            device->device_id =3D g_ascii_strtoull(device_id, NULL, 16);
+            g_match_info_free(match_info);
+        }
+        if (skip) {
+            continue;
+        }
+
+        version =3D (LPWSTR)cm_get_property(dev_info_data.DevInst,
+            &qga_DEVPKEY_Device_DriverVersion, &cm_type);
+        if (version =3D=3D NULL) {
+            slog("failed to get driver version");
+            continue;
+        }
+        device->driver_version =3D g_utf16_to_utf8(version, -1, NULL,
+            NULL, NULL);
+        if (device->driver_version =3D=3D NULL) {
+            error_setg(errp, "conversion to utf8 failed (driver version)=
");
+            goto out;
+        }
+
+        date =3D (LPFILETIME)cm_get_property(dev_info_data.DevInst,
+            &qga_DEVPKEY_Device_DriverDate, &cm_type);
+        if (date =3D=3D NULL) {
+            slog("failed to get driver date");
+            continue;
+        }
+        FileTimeToSystemTime(date, &utc_date);
+        device->driver_date =3D g_strdup_printf("%04d-%02d-%02d",
+            utc_date.wYear, utc_date.wMonth, utc_date.wDay);
+
+        slog("driver: %s\ndriver version: %s,%s\n", device->driver_name,
+            device->driver_date, device->driver_version);
+        item =3D g_new0(GuestDeviceInfoList, 1);
+        item->value =3D g_steal_pointer(&device);
+        if (!cur_item) {
+            head =3D cur_item =3D item;
+        } else {
+            cur_item->next =3D item;
+            cur_item =3D item;
+        }
+        continue;
+    }
+
+out:
+    if (dev_info !=3D INVALID_HANDLE_VALUE) {
+        SetupDiDestroyDeviceInfoList(dev_info);
+    }
+    return head;
+}
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index fb4605cc19..fe04ff2f39 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1242,3 +1242,35 @@
 ##
 { 'command': 'guest-get-osinfo',
   'returns': 'GuestOSInfo' }
+
+##
+# @GuestDeviceInfo:
+#
+# @vendor-id: vendor ID
+# @device-id: device ID
+# @driver-name: name of the associated driver
+# @driver-date: driver release date in format YYYY-MM-DD
+# @driver-version: driver version
+#
+# Since: 4.2
+##
+{ 'struct': 'GuestDeviceInfo',
+  'data': {
+      'vendor-id': 'uint16',
+      'device-id': 'uint16',
+      'driver-name': 'str',
+      'driver-date': 'str',
+      'driver-version': 'str'
+      } }
+
+##
+# @guest-get-devices:
+#
+# Retrieve information about device drivers in Windows guest
+#
+# Returns: @GuestDeviceInfo
+#
+# Since: 4.2
+##
+{ 'command': 'guest-get-devices',
+  'returns': ['GuestDeviceInfo'] }
--=20
2.23.0


