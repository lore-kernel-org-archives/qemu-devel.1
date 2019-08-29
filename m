Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47D8C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:07:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7660F2073F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7660F2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3MxI-0001tM-JY
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 12:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tgolembi@redhat.com>) id 1i3Mty-0007Vy-GD
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:04:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tgolembi@redhat.com>) id 1i3Mtu-0000sT-UX
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:03:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52210)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1i3Mtu-0000qT-Md
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:03:54 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EE4512A09D8
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 16:03:51 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id r21so1916933wme.5
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 09:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ta8RJpqczMatF8I0DMXs+8FPNIyFU1t5IVt4qD+hspA=;
 b=bLmFmVPCV7ohKXvNuKyCJY+HgLcHDqWOUC9nPX/3neEjNU4YS/dS4OniFvSqFc5/ec
 14oShUMhpVNQoTc2fv5ZYk0w3uRHlWWsTGCS4l4yWfXS1Aw3vMpO2nA6GSOQ3UfmTuWg
 x14spsbA/5oE4Q8ZAkCBaupNO06/vFXOrGmXZ8G+iQji9PvdRu6fUrAKGcvHTmKnlaRx
 +vzNIB6YGMkQFt0Q6bb8cs9uiQ///LnhKa89DoI4ppRFXuFMFDcpRsDSN0WIbUyQ+kwE
 JfUQS2s72leEAMRZNBgSQxxd/0HvXDnQjv8Cai8sKkFeyfXA89sVj8t9TsLDRgN/r0yc
 0FIg==
X-Gm-Message-State: APjAAAVwfVKkyxVxl3QaLVHCqWUuIO+jjAv0drQUzPsI7jLlyFv2AOw7
 0YZ3a7ch/Vfwhz2wD3LpdOU/uesX0jHXeqYpKUVoRDFlVr6yEkJx7mNmp7qFnpq3yMfRe+/0IJz
 bx6nfWS1s1alKRkQ=
X-Received: by 2002:adf:9b9d:: with SMTP id d29mr12533678wrc.132.1567094630659; 
 Thu, 29 Aug 2019 09:03:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxXrpnPcJ+XRxktPX9E93sJOkyJUb7cJgjmabzKsh7N0qra8BHRkwVZVUiP1KRZs9qPUA4RHg==
X-Received: by 2002:adf:9b9d:: with SMTP id d29mr12533638wrc.132.1567094630346; 
 Thu, 29 Aug 2019 09:03:50 -0700 (PDT)
Received: from auriga.brq.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id w13sm6621377wre.44.2019.08.29.09.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2019 09:03:49 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
To: Michael Roth <mdroth@linux.vnet.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 29 Aug 2019 18:03:21 +0200
Message-Id: <10eeadc9a86a7e3b9fa287c0389f0597f5c6a49b.1567094601.git.tgolembi@redhat.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] qga: add command guest-get-devices for
 reporting VirtIO devices
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
Cc: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add command for reporting devices on Windows guest. The intent is not so
much to report the devices but more importantly the driver (and its
version) that is assigned to the device.

Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
---
 qga/commands-posix.c |  11 +++
 qga/commands-win32.c | 195 ++++++++++++++++++++++++++++++++++++++++++-
 qga/qapi-schema.json |  32 +++++++
 3 files changed, 237 insertions(+), 1 deletion(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index dfc05f5b8a..9adf8bb520 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -2709,6 +2709,7 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
=20
     return 0;
 }
+
 #endif /* CONFIG_FSFREEZE */
=20
 #if !defined(CONFIG_FSTRIM)
@@ -2757,6 +2758,8 @@ GList *ga_command_blacklist_init(GList *blacklist)
     blacklist =3D g_list_append(blacklist, g_strdup("guest-fstrim"));
 #endif
=20
+    blacklist =3D g_list_append(blacklist, g_strdup("guest-get-devices")=
);
+
     return blacklist;
 }
=20
@@ -2977,3 +2980,11 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
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
+
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 6b67f16faf..0bb93422c7 100644
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
@@ -38,6 +39,36 @@
 #include "qemu/host-utils.h"
 #include "qemu/base64.h"
=20
+
+/* The following should be in devpkey.h, but it isn't */
+DEFINE_DEVPROPKEY(DEVPKEY_NAME, 0xb725f130, 0x47ef, 0x101a, 0xa5, 0xf1, =
0x02,
+    0x60, 0x8c, 0x9e, 0xeb, 0xac, 10);  /* DEVPROP_TYPE_STRING */
+DEFINE_DEVPROPKEY(DEVPKEY_Device_HardwareIds, 0xa45c254e, 0xdf1c, 0x4efd=
, 0x80,
+    0x20, 0x67, 0xd1, 0x46, 0xa8, 0x50, 0xe0, 3);
+    /* DEVPROP_TYPE_STRING_LIST */
+DEFINE_DEVPROPKEY(DEVPKEY_Device_DriverDate, 0xa8b865dd, 0x2e3d, 0x4094,=
 0xad,
+    0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, 2);  /* DEVPROP_TYPE_FILETI=
ME */
+DEFINE_DEVPROPKEY(DEVPKEY_Device_DriverVersion, 0xa8b865dd, 0x2e3d, 0x40=
94,
+    0xad, 0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, 3);
+    /* DEVPROP_TYPE_STRING */
+/* The following should be in sal.h, but it isn't */
+#ifndef _Out_writes_bytes_opt_
+#define _Out_writes_bytes_opt_(s)
+#endif
+/* The following shoud be in cfgmgr32.h, but it isn't */
+#ifndef CM_Get_DevNode_Property
+CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(
+    _In_  DEVINST               dnDevInst,
+    _In_  CONST DEVPROPKEY    * PropertyKey,
+    _Out_ DEVPROPTYPE         * PropertyType,
+    _Out_writes_bytes_opt_(*PropertyBufferSize) PBYTE PropertyBuffer,
+    _Inout_ PULONG              PropertyBufferSize,
+    _In_  ULONG                 ulFlags
+    );
+#define CM_Get_DevNode_Property                  CM_Get_DevNode_Property=
W
+#endif
+
+
 #ifndef SHTDN_REASON_FLAG_PLANNED
 #define SHTDN_REASON_FLAG_PLANNED 0x80000000
 #endif
@@ -2234,3 +2265,165 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
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
+    LPBYTE buffer =3D NULL;
+    ULONG bufferLen =3D 0;
+
+    /* First query for needed space */
+    cr =3D CM_Get_DevNode_Property(devInst, propName, propType,
+        buffer, &bufferLen, 0);
+    if ((cr !=3D CR_SUCCESS) && (cr !=3D CR_BUFFER_SMALL)) {
+
+        g_debug(
+            "failed to get size of device property, device error code=3D=
%lx",
+            cr);
+        return NULL;
+    }
+    buffer =3D (LPBYTE)g_malloc(bufferLen);
+    cr =3D CM_Get_DevNode_Property(devInst, propName, propType,
+        buffer, &bufferLen, 0);
+    if (cr !=3D CR_SUCCESS) {
+        g_free(buffer);
+        g_debug(
+            "failed to get device property, device error code=3D%lx", cr=
);
+        return NULL;
+    }
+    return buffer;
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
+    int i;
+    GError *gerr =3D NULL;
+    GRegex *device_pci_re =3D NULL;
+
+    device_pci_re =3D g_regex_new(DEVICE_PCI_RE,
+        G_REGEX_ANCHORED | G_REGEX_OPTIMIZE, 0,
+        &gerr);
+
+    if (gerr) {
+        error_setg(errp, QERR_QGA_COMMAND_FAILED, gerr->message);
+        g_error_free(gerr);
+        goto out;
+    }
+
+    dev_info_data.cbSize =3D sizeof(SP_DEVINFO_DATA);
+    dev_info =3D SetupDiGetClassDevs(0, 0, 0, DIGCF_PRESENT | DIGCF_ALLC=
LASSES);
+    if (dev_info =3D=3D INVALID_HANDLE_VALUE) {
+        error_setg(errp, "failed to get device tree");
+        goto out;
+    }
+
+    g_debug("enumerating devices");
+    for (i =3D 0; SetupDiEnumDeviceInfo(dev_info, i, &dev_info_data); i+=
+) {
+        LPWSTR name =3D NULL, hwIDs =3D NULL, lpValue;
+        bool skip =3D true;
+        DEVPROPTYPE cmType;
+        SYSTEMTIME stUTC;
+        LPFILETIME pfdDriverDate;
+        LPWSTR driverVersion;
+
+        GuestDeviceInfo *device =3D g_new0(GuestDeviceInfo, 1);
+
+        name =3D (LPWSTR)cm_get_property(dev_info_data.DevInst, &DEVPKEY=
_NAME,
+            &cmType);
+        if (name =3D=3D NULL) {
+            g_debug("failed to get device description");
+            goto next;
+        }
+        device->driver_name =3D guest_wctomb_dup(name);
+        g_free(name);
+        g_debug("querying device: %s", device->driver_name);
+
+        hwIDs =3D (LPWSTR)cm_get_property(dev_info_data.DevInst,
+            &DEVPKEY_Device_HardwareIds, &cmType);
+        if (hwIDs =3D=3D NULL) {
+            g_debug("failed to get hardware IDs");
+            goto next;
+        }
+        for (lpValue =3D hwIDs;
+            '\0' !=3D *lpValue;
+            lpValue +=3D lstrlenW(lpValue) + 1) {
+            GMatchInfo *match_info;
+            char *hwID =3D guest_wctomb_dup(lpValue);
+            /* g_debug("hwID: %s", hwID); */
+            if (!g_regex_match(device_pci_re, hwID, 0, &match_info)) {
+                continue;
+            }
+            skip =3D false;
+            device->vendor_id =3D g_match_info_fetch(match_info, 1);
+            device->device_id =3D g_match_info_fetch(match_info, 2);
+            g_match_info_free(match_info);
+        }
+        free(hwIDs);
+
+        if (skip) {
+            goto next;
+        }
+
+        driverVersion =3D (LPWSTR)cm_get_property(dev_info_data.DevInst,
+            &DEVPKEY_Device_DriverVersion, &cmType);
+        if (driverVersion =3D=3D NULL) {
+            g_debug("failed to get driver version");
+            goto next;
+        }
+        device->driver_version =3D guest_wctomb_dup(driverVersion);
+        free(driverVersion);
+
+        pfdDriverDate =3D (LPFILETIME)cm_get_property(dev_info_data.DevI=
nst,
+            &DEVPKEY_Device_DriverDate, &cmType);
+        if (driverVersion =3D=3D NULL) {
+            g_debug("failed to get driver date");
+            goto next;
+        }
+        FileTimeToSystemTime(pfdDriverDate, &stUTC);
+        free(pfdDriverDate);
+        device->driver_date =3D g_strdup_printf("%02d/%02d/%04d",
+            stUTC.wMonth, stUTC.wDay, stUTC.wYear);
+        g_debug("Driver Version: %s,%s\n", device->driver_date,
+            device->driver_version);
+
+        item =3D g_new0(GuestDeviceInfoList, 1);
+        item->value =3D device;
+        if (!cur_item) {
+            head =3D cur_item =3D item;
+        } else {
+            cur_item->next =3D item;
+            cur_item =3D item;
+        }
+        continue;
+
+next:
+        g_free(device->vendor_id);
+        g_free(device->device_id);
+        g_free(device->driver_date);
+        g_free(device->driver_name);
+        g_free(device->driver_version);
+        g_free(device);
+    }
+
+out:
+
+    if (dev_info !=3D INVALID_HANDLE_VALUE) {
+        SetupDiDestroyDeviceInfoList(dev_info);
+    }
+    g_regex_unref(device_pci_re);
+
+    return head;
+}
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index fb4605cc19..ed73b0b1c6 100644
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
+# @vendor-id: vendor ID as hexadecimal string in uper case without 0x pr=
efix
+# @device-id: device ID as hexadecimal string in uper case without 0x pr=
efix
+# @driver-name: name of the associated driver
+# @driver-date: driver release date in format MM/DD/YY
+# @driver-version: driver version
+#
+# Since: 4.1.1
+##
+{ 'struct': 'GuestDeviceInfo',
+  'data': {
+      'vendor-id': 'str',
+      'device-id': 'str',
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
+# Returns: @GuestOSInfo
+#
+# Since: 4.1.1
+##
+{ 'command': 'guest-get-devices',
+  'returns': ['GuestDeviceInfo'] }
--=20
2.22.0


