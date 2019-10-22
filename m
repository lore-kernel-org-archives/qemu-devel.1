Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB4ACA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:11:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0561E20663
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0561E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMqCH-0006LM-5j
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 05:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tgolembi@redhat.com>) id 1iMqBX-0005vj-Tc
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:10:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tgolembi@redhat.com>) id 1iMqBV-0005dE-UA
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:10:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42960)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1iMqBV-0005co-Kl
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:10:33 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 67F8A7BDA1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 09:10:31 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id z5so4127273wma.5
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 02:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=UWbqWRkDLI/5gS2WIFOiL9e11J8H2WBBIWCNwKLTnxM=;
 b=PeqwhUgEdkZy15RKs9Duni7IwaNbKnUiit2WHI33URTQ4oJBiBFah1bfgmgpOYUWcQ
 nn3YC3+sJnITe9zZ0esaowfghcSOJ4vw5aw28+dA0Pb850DlCES1jgvxm+3AP9eSM8Qm
 /BWiagZq5eXkL6E6buwXtBekf0osTT5u4EDK+KcSxy4CXxNSsV05JrXhvqd9zkggKMTP
 7jGf6fjZ1rRHV2l9oYB6/1iwG7OQkxbBcdkvPoVkrjafQLZgOw9+BZv5Z4GE0jX/p+76
 xDnORfS5C/oPTgWNh4YxNyO8mwqkDDX1oZbA4Rl4ki7+inJQPOWwPV/rtLsYsILbnycp
 RQrQ==
X-Gm-Message-State: APjAAAUHUT53Rx+qtojEoesQdsE/sQ6nGpZtPCb7HwgN57Biwk+bhEvC
 h5wfQlitwcmOhkHA/pZ5b80VPL1bTPXwgh3HaVJKgvPWc9sov/PZT0VQuADhuRHQBAMsUYydDZs
 eOGlZ3df9crbE2cw=
X-Received: by 2002:adf:9044:: with SMTP id h62mr2539001wrh.91.1571735429994; 
 Tue, 22 Oct 2019 02:10:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw/4RkMwEVkHIo2gf0O2cffJDa4A91h0sqeJcnLykq8iIRZYVF8MTzcToHiXx9+qEVZl7iRrQ==
X-Received: by 2002:adf:9044:: with SMTP id h62mr2538968wrh.91.1571735429608; 
 Tue, 22 Oct 2019 02:10:29 -0700 (PDT)
Received: from auriga.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 q25sm558621wra.3.2019.10.22.02.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 02:10:28 -0700 (PDT)
Date: Tue, 22 Oct 2019 11:10:28 +0200
From: =?utf-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Subject: Re: [PATCH v4] qga: add command guest-get-devices for reporting
 VirtIO devices
Message-ID: <20191022091027.lqbeg5nllpmdp3ad@auriga.localdomain>
References: <76c63f3fd5e36dcfdd8fff5158a12c8955130103.1569445431.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <76c63f3fd5e36dcfdd8fff5158a12c8955130103.1569445431.git.tgolembi@redhat.com>
User-Agent: NeoMutt/20180716
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping, Michael, would be nice if we could get this in 4.2.

    Tomas

On Wed, Sep 25, 2019 at 11:03:58PM +0200, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD=
 wrote:
> Add command for reporting devices on Windows guest. The intent is not s=
o
> much to report the devices but more importantly the driver (and its
> version) that is assigned to the device. This gives caller the
> information whether VirtIO drivers are installed and/or whether
> inadequate driver is used on a device (e.g. QXL device with base VGA
> driver).
>=20
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> ---
>  qga/commands-posix.c |   9 ++
>  qga/commands-win32.c | 204 ++++++++++++++++++++++++++++++++++++++++++-
>  qga/qapi-schema.json |  32 +++++++
>  3 files changed, 244 insertions(+), 1 deletion(-)
>=20
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index dfc05f5b8a..58e93feef9 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -2757,6 +2757,8 @@ GList *ga_command_blacklist_init(GList *blacklist=
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
> @@ -2977,3 +2979,10 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
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
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 6b67f16faf..ec07a5b3ef 100644
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
> +/*
> + * The following should be in devpkey.h, but it isn't. The key names w=
ere
> + * prefixed to avoid (future) name clashes. Once the definitions get i=
nto
> + * mingw the following lines can be removed.
> + */
> +DEFINE_DEVPROPKEY(qga_DEVPKEY_NAME, 0xb725f130, 0x47ef, 0x101a, 0xa5,
> +    0xf1, 0x02, 0x60, 0x8c, 0x9e, 0xeb, 0xac, 10);
> +    /* DEVPROP_TYPE_STRING */
> +DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_HardwareIds, 0xa45c254e, 0xdf1c,
> +    0x4efd, 0x80, 0x20, 0x67, 0xd1, 0x46, 0xa8, 0x50, 0xe0, 3);
> +    /* DEVPROP_TYPE_STRING_LIST */
> +DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverDate, 0xa8b865dd, 0x2e3d,
> +    0x4094, 0xad, 0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, 2);
> +    /* DEVPROP_TYPE_FILETIME */
> +DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverVersion, 0xa8b865dd, 0x2e3d=
,
> +    0x4094, 0xad, 0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, 3);
> +    /* DEVPROP_TYPE_STRING */
> +/* The following shoud be in cfgmgr32.h, but it isn't */
> +#ifndef CM_Get_DevNode_Property
> +CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(
> +    DEVINST          dnDevInst,
> +    CONST DEVPROPKEY * PropertyKey,
> +    DEVPROPTYPE      * PropertyType,
> +    PBYTE            PropertyBuffer,
> +    PULONG           PropertyBufferSize,
> +    ULONG            ulFlags
> +);
> +#define CM_Get_DevNode_Property CM_Get_DevNode_PropertyW
> +#endif
> +
>  #ifndef SHTDN_REASON_FLAG_PLANNED
>  #define SHTDN_REASON_FLAG_PLANNED 0x80000000
>  #endif
> @@ -92,6 +123,8 @@ static OpenFlags guest_file_open_modes[] =3D {
>      g_free(suffix); \
>  } while (0)
> =20
> +G_DEFINE_AUTOPTR_CLEANUP_FUNC(GuestDeviceInfo, qapi_free_GuestDeviceIn=
fo)
> +
>  static OpenFlags *find_open_flag(const char *mode_str)
>  {
>      int mode;
> @@ -2234,3 +2267,172 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
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
> +    g_autofree LPBYTE buffer =3D NULL;
> +    ULONG buffer_len =3D 0;
> +
> +    /* First query for needed space */
> +    cr =3D CM_Get_DevNode_PropertyW(devInst, propName, propType,
> +        buffer, &buffer_len, 0);
> +    if (cr !=3D CR_SUCCESS && cr !=3D CR_BUFFER_SMALL) {
> +
> +        slog("failed to get property size, error=3D0x%lx", cr);
> +        return NULL;
> +    }
> +    buffer =3D g_new0(BYTE, buffer_len + 1);
> +    cr =3D CM_Get_DevNode_PropertyW(devInst, propName, propType,
> +        buffer, &buffer_len, 0);
> +    if (cr !=3D CR_SUCCESS) {
> +        slog("failed to get device property, error=3D0x%lx", cr);
> +        return NULL;
> +    }
> +    return g_steal_pointer(&buffer);
> +}
> +
> +static GStrv ga_get_hardware_ids(DEVINST devInstance)
> +{
> +    GStrv hw_ids =3D NULL;
> +    GArray *values =3D NULL;
> +    DEVPROPTYPE cm_type;
> +    LPWSTR id;
> +    g_autofree LPWSTR property =3D (LPWSTR)cm_get_property(devInstance=
,
> +        &qga_DEVPKEY_Device_HardwareIds, &cm_type);
> +    if (property =3D=3D NULL) {
> +        slog("failed to get hardware IDs");
> +        return NULL;
> +    }
> +    if (*property =3D=3D '\0') {
> +        /* empty list */
> +        return NULL;
> +    }
> +    values =3D g_array_new(TRUE, TRUE, sizeof(gchar *));
> +    for (id =3D property; '\0' !=3D *id; id +=3D lstrlenW(id) + 1) {
> +        gchar *id8 =3D g_utf16_to_utf8(id, -1, NULL, NULL, NULL);
> +        g_array_append_val(values, id8);
> +    }
> +    hw_ids =3D (GStrv)g_array_free(values, FALSE);
> +    values =3D NULL;
> +    return hw_ids;
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
> +    int i, j;
> +    GError *gerr =3D NULL;
> +    g_autoptr(GRegex) device_pci_re =3D NULL;
> +    DEVPROPTYPE cm_type;
> +
> +    device_pci_re =3D g_regex_new(DEVICE_PCI_RE,
> +        G_REGEX_ANCHORED | G_REGEX_OPTIMIZE, 0,
> +        &gerr);
> +    g_assert(device_pci_re !=3D NULL);
> +
> +    dev_info_data.cbSize =3D sizeof(SP_DEVINFO_DATA);
> +    dev_info =3D SetupDiGetClassDevs(0, 0, 0, DIGCF_PRESENT | DIGCF_AL=
LCLASSES);
> +    if (dev_info =3D=3D INVALID_HANDLE_VALUE) {
> +        error_setg(errp, "failed to get device tree");
> +        return NULL;
> +    }
> +
> +    slog("enumerating devices");
> +    for (i =3D 0; SetupDiEnumDeviceInfo(dev_info, i, &dev_info_data); =
i++) {
> +        bool skip =3D true;
> +        SYSTEMTIME utc_date;
> +        g_autofree LPWSTR name =3D NULL;
> +        g_autofree LPFILETIME date =3D NULL;
> +        g_autofree LPWSTR version =3D NULL;
> +        g_auto(GStrv) hw_ids =3D NULL;
> +        g_autoptr(GuestDeviceInfo) device =3D g_new0(GuestDeviceInfo, =
1);
> +        g_autofree char *vendor_id =3D NULL;
> +        g_autofree char *device_id =3D NULL;
> +
> +        name =3D (LPWSTR)cm_get_property(dev_info_data.DevInst,
> +            &qga_DEVPKEY_NAME, &cm_type);
> +        if (name =3D=3D NULL) {
> +            slog("failed to get device description");
> +            continue;
> +        }
> +        device->driver_name =3D g_utf16_to_utf8(name, -1, NULL, NULL, =
NULL);
> +        if (device->driver_name =3D=3D NULL) {
> +            error_setg(errp, "conversion to utf8 failed (driver name)"=
);
> +            goto out;
> +        }
> +        slog("querying device: %s", device->driver_name);
> +        hw_ids =3D ga_get_hardware_ids(dev_info_data.DevInst);
> +        if (hw_ids =3D=3D NULL) {
> +            continue;
> +        }
> +        for (j =3D 0; hw_ids[j] !=3D NULL; j++) {
> +            GMatchInfo *match_info;
> +            if (!g_regex_match(device_pci_re, hw_ids[j], 0, &match_inf=
o)) {
> +                continue;
> +            }
> +            skip =3D false;
> +            vendor_id =3D g_match_info_fetch(match_info, 1);
> +            device_id =3D g_match_info_fetch(match_info, 2);
> +            device->vendor_id =3D g_ascii_strtoull(vendor_id, NULL, 16=
);
> +            device->device_id =3D g_ascii_strtoull(device_id, NULL, 16=
);
> +            g_match_info_free(match_info);
> +        }
> +        if (skip) {
> +            continue;
> +        }
> +
> +        version =3D (LPWSTR)cm_get_property(dev_info_data.DevInst,
> +            &qga_DEVPKEY_Device_DriverVersion, &cm_type);
> +        if (version =3D=3D NULL) {
> +            slog("failed to get driver version");
> +            continue;
> +        }
> +        device->driver_version =3D g_utf16_to_utf8(version, -1, NULL,
> +            NULL, NULL);
> +        if (device->driver_version =3D=3D NULL) {
> +            error_setg(errp, "conversion to utf8 failed (driver versio=
n)");
> +            goto out;
> +        }
> +
> +        date =3D (LPFILETIME)cm_get_property(dev_info_data.DevInst,
> +            &qga_DEVPKEY_Device_DriverDate, &cm_type);
> +        if (date =3D=3D NULL) {
> +            slog("failed to get driver date");
> +            continue;
> +        }
> +        FileTimeToSystemTime(date, &utc_date);
> +        device->driver_date =3D g_strdup_printf("%04d-%02d-%02d",
> +            utc_date.wYear, utc_date.wMonth, utc_date.wDay);
> +
> +        slog("driver: %s\ndriver version: %s,%s\n", device->driver_nam=
e,
> +            device->driver_date, device->driver_version);
> +        item =3D g_new0(GuestDeviceInfoList, 1);
> +        item->value =3D g_steal_pointer(&device);
> +        if (!cur_item) {
> +            head =3D cur_item =3D item;
> +        } else {
> +            cur_item->next =3D item;
> +            cur_item =3D item;
> +        }
> +        continue;
> +    }
> +
> +out:
> +    if (dev_info !=3D INVALID_HANDLE_VALUE) {
> +        SetupDiDestroyDeviceInfoList(dev_info);
> +    }
> +    return head;
> +}
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index fb4605cc19..fe04ff2f39 100644
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
> +# @vendor-id: vendor ID
> +# @device-id: device ID
> +# @driver-name: name of the associated driver
> +# @driver-date: driver release date in format YYYY-MM-DD
> +# @driver-version: driver version
> +#
> +# Since: 4.2
> +##
> +{ 'struct': 'GuestDeviceInfo',
> +  'data': {
> +      'vendor-id': 'uint16',
> +      'device-id': 'uint16',
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
> +# Returns: @GuestDeviceInfo
> +#
> +# Since: 4.2
> +##
> +{ 'command': 'guest-get-devices',
> +  'returns': ['GuestDeviceInfo'] }
> --=20
> 2.23.0
>=20

--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>

