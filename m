Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F51C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 09:09:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B509C214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 09:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B509C214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9n0Y-0002Jy-O9
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 05:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tgolembi@redhat.com>) id 1i9myu-0001Oz-N8
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tgolembi@redhat.com>) id 1i9mys-00006T-A3
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:07:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34073)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1i9mys-00006E-1n
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:07:34 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 848E04E926
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 09:07:32 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id n3so5540407wmf.3
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 02:07:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=c6dXK6pT5T/pf5AtiTSs1tfrfgwFOBsfVpu5YrBCOUU=;
 b=Hccy/kBEji4lZSSa4iS+qJgTzxPQrZBk0k6wHO8TxLwBrPB8VglVi0d4xwuAuncmKI
 Q4QnRt2F7S2TgB+QzxLJHSSVkigoyLmHaYYDTdJeWaYj4o6ym7UZvsEzRo+U6N9G1jq+
 lkRU3SwCYO+vO8dEcQw4EhfRJ5JLeCIQzBkvLTW2kVcpY8J6tW3NBGFz/0MA7Pbs27I0
 kYOc6poICri9ZySKnut2xXEBPlVlDqKUdRfw/BtI3Ce9iY/Rk7xoBUxnUYRd3jYGEt4T
 gIoFHoPnIrtsEh+6iCQ/xAuUyshWyL50z8BUMBNngUEVBpIesbIh7dz73HHqtsJKW8Oj
 MuGQ==
X-Gm-Message-State: APjAAAXD083PGe7n0pQcdEVzZV4QSLFKzChgTwK5yIBnRMha0J1///pj
 Lw29+h+31NsBx5iIedJxHvwVvclQo0jCJT5IlltbSBLWRhycnn0jnKXjtSQqazWVFsHx00tQ2GE
 k+ooyp4dVpeWgnFk=
X-Received: by 2002:adf:e7c4:: with SMTP id e4mr40238602wrn.62.1568624851275; 
 Mon, 16 Sep 2019 02:07:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzf6jjMXrpgdMUkmMWjCw9FTCJz3Y7nplOdI6/hiQEr03RFnLhL/V8ZgKr0AheUv4/BhbHX/g==
X-Received: by 2002:adf:e7c4:: with SMTP id e4mr40238585wrn.62.1568624850958; 
 Mon, 16 Sep 2019 02:07:30 -0700 (PDT)
Received: from auriga.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 z4sm8892433wrh.93.2019.09.16.02.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 02:07:30 -0700 (PDT)
Date: Mon, 16 Sep 2019 11:07:29 +0200
From: =?utf-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
To: Michael Roth <mdroth@linux.vnet.ibm.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20190916090728.ux6udmc2y5pydchf@auriga.localdomain>
References: <10eeadc9a86a7e3b9fa287c0389f0597f5c6a49b.1567094601.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <10eeadc9a86a7e3b9fa287c0389f0597f5c6a49b.1567094601.git.tgolembi@redhat.com>
User-Agent: NeoMutt/20180716
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] qga: add command guest-get-devices for
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

gentle reminder

On Thu, Aug 29, 2019 at 06:03:21PM +0200, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD=
 wrote:
> Add command for reporting devices on Windows guest. The intent is not s=
o
> much to report the devices but more importantly the driver (and its
> version) that is assigned to the device.
>=20
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> ---
>  qga/commands-posix.c |  11 +++
>  qga/commands-win32.c | 195 ++++++++++++++++++++++++++++++++++++++++++-
>  qga/qapi-schema.json |  32 +++++++
>  3 files changed, 237 insertions(+), 1 deletion(-)
>=20
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index dfc05f5b8a..9adf8bb520 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -2709,6 +2709,7 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
> =20
>      return 0;
>  }
> +
>  #endif /* CONFIG_FSFREEZE */
> =20
>  #if !defined(CONFIG_FSTRIM)
> @@ -2757,6 +2758,8 @@ GList *ga_command_blacklist_init(GList *blacklist=
)
>      blacklist =3D g_list_append(blacklist, g_strdup("guest-fstrim"));
>  #endif
> =20
> +    blacklist =3D g_list_append(blacklist, g_strdup("guest-get-devices=
"));
> +
>      return blacklist;
>  }
> =20
> @@ -2977,3 +2980,11 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
> =20
>      return info;
>  }
> +
> +GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
> +{
> +    error_setg(errp, QERR_UNSUPPORTED);
> +
> +    return NULL;
> +}
> +
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 6b67f16faf..0bb93422c7 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -21,10 +21,11 @@
>  #ifdef CONFIG_QGA_NTDDSCSI
>  #include <winioctl.h>
>  #include <ntddscsi.h>
> +#endif
>  #include <setupapi.h>
>  #include <cfgmgr32.h>
>  #include <initguid.h>
> -#endif
> +#include <devpropdef.h>
>  #include <lm.h>
>  #include <wtsapi32.h>
>  #include <wininet.h>
> @@ -38,6 +39,36 @@
>  #include "qemu/host-utils.h"
>  #include "qemu/base64.h"
> =20
> +
> +/* The following should be in devpkey.h, but it isn't */
> +DEFINE_DEVPROPKEY(DEVPKEY_NAME, 0xb725f130, 0x47ef, 0x101a, 0xa5, 0xf1=
, 0x02,
> +    0x60, 0x8c, 0x9e, 0xeb, 0xac, 10);  /* DEVPROP_TYPE_STRING */
> +DEFINE_DEVPROPKEY(DEVPKEY_Device_HardwareIds, 0xa45c254e, 0xdf1c, 0x4e=
fd, 0x80,
> +    0x20, 0x67, 0xd1, 0x46, 0xa8, 0x50, 0xe0, 3);
> +    /* DEVPROP_TYPE_STRING_LIST */
> +DEFINE_DEVPROPKEY(DEVPKEY_Device_DriverDate, 0xa8b865dd, 0x2e3d, 0x409=
4, 0xad,
> +    0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, 2);  /* DEVPROP_TYPE_FILE=
TIME */
> +DEFINE_DEVPROPKEY(DEVPKEY_Device_DriverVersion, 0xa8b865dd, 0x2e3d, 0x=
4094,
> +    0xad, 0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, 3);
> +    /* DEVPROP_TYPE_STRING */
> +/* The following should be in sal.h, but it isn't */
> +#ifndef _Out_writes_bytes_opt_
> +#define _Out_writes_bytes_opt_(s)
> +#endif
> +/* The following shoud be in cfgmgr32.h, but it isn't */
> +#ifndef CM_Get_DevNode_Property
> +CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(
> +    _In_  DEVINST               dnDevInst,
> +    _In_  CONST DEVPROPKEY    * PropertyKey,
> +    _Out_ DEVPROPTYPE         * PropertyType,
> +    _Out_writes_bytes_opt_(*PropertyBufferSize) PBYTE PropertyBuffer,
> +    _Inout_ PULONG              PropertyBufferSize,
> +    _In_  ULONG                 ulFlags
> +    );
> +#define CM_Get_DevNode_Property                  CM_Get_DevNode_Proper=
tyW
> +#endif
> +
> +
>  #ifndef SHTDN_REASON_FLAG_PLANNED
>  #define SHTDN_REASON_FLAG_PLANNED 0x80000000
>  #endif
> @@ -2234,3 +2265,165 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
> =20
>      return info;
>  }
> +
> +/*
> + * Safely get device property. Returned strings are using wide charact=
ers.
> + * Caller is responsible for freeing the buffer.
> + */
> +static LPBYTE cm_get_property(DEVINST devInst, const DEVPROPKEY *propN=
ame,
> +    PDEVPROPTYPE propType)
> +{
> +    CONFIGRET cr;
> +    LPBYTE buffer =3D NULL;
> +    ULONG bufferLen =3D 0;
> +
> +    /* First query for needed space */
> +    cr =3D CM_Get_DevNode_Property(devInst, propName, propType,
> +        buffer, &bufferLen, 0);
> +    if ((cr !=3D CR_SUCCESS) && (cr !=3D CR_BUFFER_SMALL)) {
> +
> +        g_debug(
> +            "failed to get size of device property, device error code=3D=
%lx",
> +            cr);
> +        return NULL;
> +    }
> +    buffer =3D (LPBYTE)g_malloc(bufferLen);
> +    cr =3D CM_Get_DevNode_Property(devInst, propName, propType,
> +        buffer, &bufferLen, 0);
> +    if (cr !=3D CR_SUCCESS) {
> +        g_free(buffer);
> +        g_debug(
> +            "failed to get device property, device error code=3D%lx", =
cr);
> +        return NULL;
> +    }
> +    return buffer;
> +}
> +
> +/*
> + * https://docs.microsoft.com/en-us/windows-hardware/drivers/install/i=
dentifiers-for-pci-devices
> + */
> +#define DEVICE_PCI_RE "PCI\\\\VEN_(1AF4|1B36)&DEV_([0-9A-B]{4})(&|$)"
> +
> +GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
> +{
> +    GuestDeviceInfoList *head =3D NULL, *cur_item =3D NULL, *item =3D =
NULL;
> +    HDEVINFO dev_info =3D INVALID_HANDLE_VALUE;
> +    SP_DEVINFO_DATA dev_info_data;
> +    int i;
> +    GError *gerr =3D NULL;
> +    GRegex *device_pci_re =3D NULL;
> +
> +    device_pci_re =3D g_regex_new(DEVICE_PCI_RE,
> +        G_REGEX_ANCHORED | G_REGEX_OPTIMIZE, 0,
> +        &gerr);
> +
> +    if (gerr) {
> +        error_setg(errp, QERR_QGA_COMMAND_FAILED, gerr->message);
> +        g_error_free(gerr);
> +        goto out;
> +    }
> +
> +    dev_info_data.cbSize =3D sizeof(SP_DEVINFO_DATA);
> +    dev_info =3D SetupDiGetClassDevs(0, 0, 0, DIGCF_PRESENT | DIGCF_AL=
LCLASSES);
> +    if (dev_info =3D=3D INVALID_HANDLE_VALUE) {
> +        error_setg(errp, "failed to get device tree");
> +        goto out;
> +    }
> +
> +    g_debug("enumerating devices");
> +    for (i =3D 0; SetupDiEnumDeviceInfo(dev_info, i, &dev_info_data); =
i++) {
> +        LPWSTR name =3D NULL, hwIDs =3D NULL, lpValue;
> +        bool skip =3D true;
> +        DEVPROPTYPE cmType;
> +        SYSTEMTIME stUTC;
> +        LPFILETIME pfdDriverDate;
> +        LPWSTR driverVersion;
> +
> +        GuestDeviceInfo *device =3D g_new0(GuestDeviceInfo, 1);
> +
> +        name =3D (LPWSTR)cm_get_property(dev_info_data.DevInst, &DEVPK=
EY_NAME,
> +            &cmType);
> +        if (name =3D=3D NULL) {
> +            g_debug("failed to get device description");
> +            goto next;
> +        }
> +        device->driver_name =3D guest_wctomb_dup(name);
> +        g_free(name);
> +        g_debug("querying device: %s", device->driver_name);
> +
> +        hwIDs =3D (LPWSTR)cm_get_property(dev_info_data.DevInst,
> +            &DEVPKEY_Device_HardwareIds, &cmType);
> +        if (hwIDs =3D=3D NULL) {
> +            g_debug("failed to get hardware IDs");
> +            goto next;
> +        }
> +        for (lpValue =3D hwIDs;
> +            '\0' !=3D *lpValue;
> +            lpValue +=3D lstrlenW(lpValue) + 1) {
> +            GMatchInfo *match_info;
> +            char *hwID =3D guest_wctomb_dup(lpValue);
> +            /* g_debug("hwID: %s", hwID); */
> +            if (!g_regex_match(device_pci_re, hwID, 0, &match_info)) {
> +                continue;
> +            }
> +            skip =3D false;
> +            device->vendor_id =3D g_match_info_fetch(match_info, 1);
> +            device->device_id =3D g_match_info_fetch(match_info, 2);
> +            g_match_info_free(match_info);
> +        }
> +        free(hwIDs);
> +
> +        if (skip) {
> +            goto next;
> +        }
> +
> +        driverVersion =3D (LPWSTR)cm_get_property(dev_info_data.DevIns=
t,
> +            &DEVPKEY_Device_DriverVersion, &cmType);
> +        if (driverVersion =3D=3D NULL) {
> +            g_debug("failed to get driver version");
> +            goto next;
> +        }
> +        device->driver_version =3D guest_wctomb_dup(driverVersion);
> +        free(driverVersion);
> +
> +        pfdDriverDate =3D (LPFILETIME)cm_get_property(dev_info_data.De=
vInst,
> +            &DEVPKEY_Device_DriverDate, &cmType);
> +        if (driverVersion =3D=3D NULL) {
> +            g_debug("failed to get driver date");
> +            goto next;
> +        }
> +        FileTimeToSystemTime(pfdDriverDate, &stUTC);
> +        free(pfdDriverDate);
> +        device->driver_date =3D g_strdup_printf("%02d/%02d/%04d",
> +            stUTC.wMonth, stUTC.wDay, stUTC.wYear);
> +        g_debug("Driver Version: %s,%s\n", device->driver_date,
> +            device->driver_version);
> +
> +        item =3D g_new0(GuestDeviceInfoList, 1);
> +        item->value =3D device;
> +        if (!cur_item) {
> +            head =3D cur_item =3D item;
> +        } else {
> +            cur_item->next =3D item;
> +            cur_item =3D item;
> +        }
> +        continue;
> +
> +next:
> +        g_free(device->vendor_id);
> +        g_free(device->device_id);
> +        g_free(device->driver_date);
> +        g_free(device->driver_name);
> +        g_free(device->driver_version);
> +        g_free(device);
> +    }
> +
> +out:
> +
> +    if (dev_info !=3D INVALID_HANDLE_VALUE) {
> +        SetupDiDestroyDeviceInfoList(dev_info);
> +    }
> +    g_regex_unref(device_pci_re);
> +
> +    return head;
> +}
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index fb4605cc19..ed73b0b1c6 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1242,3 +1242,35 @@
>  ##
>  { 'command': 'guest-get-osinfo',
>    'returns': 'GuestOSInfo' }
> +
> +##
> +# @GuestDeviceInfo:
> +#
> +# @vendor-id: vendor ID as hexadecimal string in uper case without 0x =
prefix
> +# @device-id: device ID as hexadecimal string in uper case without 0x =
prefix
> +# @driver-name: name of the associated driver
> +# @driver-date: driver release date in format MM/DD/YY
> +# @driver-version: driver version
> +#
> +# Since: 4.1.1
> +##
> +{ 'struct': 'GuestDeviceInfo',
> +  'data': {
> +      'vendor-id': 'str',
> +      'device-id': 'str',
> +      'driver-name': 'str',
> +      'driver-date': 'str',
> +      'driver-version': 'str'
> +      } }
> +
> +##
> +# @guest-get-devices:
> +#
> +# Retrieve information about device drivers in Windows guest
> +#
> +# Returns: @GuestOSInfo
> +#
> +# Since: 4.1.1
> +##
> +{ 'command': 'guest-get-devices',
> +  'returns': ['GuestDeviceInfo'] }
> --=20
> 2.22.0
>=20

--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>

