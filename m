Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE553C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 11:32:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98E12206F2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 11:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZc7Zv6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E12206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxqW0-0000jz-SK
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 07:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jxqVI-0008Rw-Tu
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 07:32:12 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:53411)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jxqVF-0003s1-EP
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 07:32:12 -0400
Received: by mail-wm1-x331.google.com with SMTP id j18so2471192wmi.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 04:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JQG0hBsvagWyKHhFZhDPE0sYF8lJ1Wwne1bPnuUsYNc=;
 b=RZc7Zv6A36yZBZDDximE6HDvEgiQvZjG3bhfzYwEqkwGLraOto0ykL0enIzL2kPQmc
 UcjVvqnPVwaUg0s3DW9CSxdX6dHiVv7B57aNpcJqzprmxxt2IdUrTS2Af1zatd0OK2ti
 +J3x1uxno8e0EW5LNqCRLJ6IDFMrmqFOaC5GM8cwy3bW21zsKXOBA9aqM4+SsBnBPsnZ
 99ug2gNZh+4CRhQRjlEq6HRLPl998TticqRFQzIzrAmaGkTw/6k2mpxuA9fkMk3dKz7z
 UZinvJh8pF6uXH23zBtGVtWm1drxNwHCrcKuJTqnK5LFW+e+gMZnWDh0lfZSk+aSvqA9
 tnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JQG0hBsvagWyKHhFZhDPE0sYF8lJ1Wwne1bPnuUsYNc=;
 b=JQQUzhAcUb2dIFf7TF+ClPKWAVUhhL9PlXUuJFrpg9ytDIPbKmuAoi8gymuCiIIYbX
 Ffnx/aZfeB7kJsmArTO7gaZq7PzKENF8en0hGtNQgsPTNrLhx4hvje/CaNrZI4Hg+2ha
 ksckIVm1gn/wKQpMNo/ahisoBSd2b82PxEbEGci5MCGLMAq8XWx74CZEkf8deSNI5qdM
 RoRMqboAjAFptnpz6JpEyAnTDWTZHMIDz3ujUlTJOhDixtPplVM+Al6wySmIzXKrrJZj
 ne1eOBChTJT0vEg1WaSgpPQCssruvykGas8lLvgqc4GYum250auHbIIH3F4n9YtVMr3u
 wHvQ==
X-Gm-Message-State: AOAM533vDu3wHcD2OhaXLUX3XuMF4ulZ9axRQePN3B7zVCD9FCPoirKQ
 f2XYt+jqVAZdOo0UG8L7KZd9dwywQseivJgbx2w=
X-Google-Smtp-Source: ABdhPJx5W2hOVWRXj3wrnZjO1hqBqjob7IFJjHF8JwAZR/lv0iph/GxyffTlQggcYD5YDxlq7NLmPJosLCUggtph0rc=
X-Received: by 2002:a1c:2dc6:: with SMTP id t189mr3858637wmt.26.1595331127364; 
 Tue, 21 Jul 2020 04:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <e4f1b62bedb243ec46351a264c4e08f800655daa.1578573547.git.tgolembi@redhat.com>
 <20200721100155.17c26c05@fiorina>
In-Reply-To: <20200721100155.17c26c05@fiorina>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 Jul 2020 15:31:52 +0400
Message-ID: <CAJ+F1CJgcwLiYWioPayiKXuoUSKAffLWaS_V-TTve2DJeoLu7Q@mail.gmail.com>
Subject: Re: [PATCH v9] qga: add command guest-get-devices for reporting
 VirtIO devices
To: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000025531805aaf1f974"
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wm1-x331.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000025531805aaf1f974
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Jul 21, 2020 at 12:03 PM Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolemb=
i@redhat.com>
wrote:

> Ping. Can we get this merged finally?
>

We missed the feature deadline by a week:
https://wiki.qemu.org/Planning/5.1


> Thanks,
>
>     Tomas
>
> On Thu,  9 Jan 2020 13:39:36 +0100
> Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com> wrote:
>
> > Add command for reporting devices on Windows guest. The intent is not s=
o
> > much to report the devices but more importantly the driver (and its
> > version) that is assigned to the device. This gives caller the
> > information whether VirtIO drivers are installed and/or whether
> > inadequate driver is used on a device (e.g. QXL device with base VGA
> > driver).
> >
> > Example:
> > [
> >     {
> >       "driver-date": "2019-08-12",
> >       "driver-name": "Red Hat VirtIO SCSI controller",
> >       "driver-version": "100.80.104.17300",
> >       "address": {
> >         "type": "pci",
> >         "data": {
> >           "device-id": 4162,
> >           "vendor-id": 6900
> >         }
> >       }
> >     },
> >     ...
> > ]
> >
> > Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> > ---
> >
> > Changes in v9: fixed compilation errors
> >
> >  qga/commands-posix.c |   9 ++
> >  qga/commands-win32.c | 212 ++++++++++++++++++++++++++++++++++++++++++-
> >  qga/qapi-schema.json |  51 +++++++++++
> >  3 files changed, 271 insertions(+), 1 deletion(-)
> >
> > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> > index 93474ff770..bffee8ce48 100644
> > --- a/qga/commands-posix.c
> > +++ b/qga/commands-posix.c
> > @@ -2771,6 +2771,8 @@ GList *ga_command_blacklist_init(GList *blacklist=
)
> >      blacklist =3D g_list_append(blacklist, g_strdup("guest-fstrim"));
> >  #endif
> >
> > +    blacklist =3D g_list_append(blacklist, g_strdup("guest-get-devices=
"));
> > +
> >      return blacklist;
> >  }
> >
> > @@ -2991,3 +2993,10 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
> >
> >      return info;
> >  }
> > +
> > +GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
> > +{
> > +    error_setg(errp, QERR_UNSUPPORTED);
> > +
> > +    return NULL;
> > +}
> > diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> > index 2461fd19bf..b18d89d7ad 100644
> > --- a/qga/commands-win32.c
> > +++ b/qga/commands-win32.c
> > @@ -21,10 +21,11 @@
> >  #ifdef CONFIG_QGA_NTDDSCSI
> >  #include <winioctl.h>
> >  #include <ntddscsi.h>
> > +#endif
> >  #include <setupapi.h>
> >  #include <cfgmgr32.h>
> >  #include <initguid.h>
> > -#endif
> > +#include <devpropdef.h>
> >  #include <lm.h>
> >  #include <wtsapi32.h>
> >  #include <wininet.h>
> > @@ -38,6 +39,36 @@
> >  #include "qemu/host-utils.h"
> >  #include "qemu/base64.h"
> >
> > +/*
> > + * The following should be in devpkey.h, but it isn't. The key names
> were
> > + * prefixed to avoid (future) name clashes. Once the definitions get
> into
> > + * mingw the following lines can be removed.
> > + */
> > +DEFINE_DEVPROPKEY(qga_DEVPKEY_NAME, 0xb725f130, 0x47ef, 0x101a, 0xa5,
> > +    0xf1, 0x02, 0x60, 0x8c, 0x9e, 0xeb, 0xac, 10);
> > +    /* DEVPROP_TYPE_STRING */
> > +DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_HardwareIds, 0xa45c254e, 0xdf1c,
> > +    0x4efd, 0x80, 0x20, 0x67, 0xd1, 0x46, 0xa8, 0x50, 0xe0, 3);
> > +    /* DEVPROP_TYPE_STRING_LIST */
> > +DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverDate, 0xa8b865dd, 0x2e3d,
> > +    0x4094, 0xad, 0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, 2);
> > +    /* DEVPROP_TYPE_FILETIME */
> > +DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverVersion, 0xa8b865dd, 0x2e3d=
,
> > +    0x4094, 0xad, 0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, 3);
> > +    /* DEVPROP_TYPE_STRING */
> > +/* The following shoud be in cfgmgr32.h, but it isn't */
> > +#ifndef CM_Get_DevNode_Property
> > +CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(
> > +    DEVINST          dnDevInst,
> > +    CONST DEVPROPKEY * PropertyKey,
> > +    DEVPROPTYPE      * PropertyType,
> > +    PBYTE            PropertyBuffer,
> > +    PULONG           PropertyBufferSize,
> > +    ULONG            ulFlags
> > +);
> > +#define CM_Get_DevNode_Property CM_Get_DevNode_PropertyW
> > +#endif
> > +
> >  #ifndef SHTDN_REASON_FLAG_PLANNED
> >  #define SHTDN_REASON_FLAG_PLANNED 0x80000000
> >  #endif
> > @@ -92,6 +123,8 @@ static OpenFlags guest_file_open_modes[] =3D {
> >      g_free(suffix); \
> >  } while (0)
> >
> > +G_DEFINE_AUTOPTR_CLEANUP_FUNC(GuestDeviceInfo,
> qapi_free_GuestDeviceInfo)
> > +
> >  static OpenFlags *find_open_flag(const char *mode_str)
> >  {
> >      int mode;
> > @@ -2234,3 +2267,180 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
> >
> >      return info;
> >  }
> > +
> > +/*
> > + * Safely get device property. Returned strings are using wide
> characters.
> > + * Caller is responsible for freeing the buffer.
> > + */
> > +static LPBYTE cm_get_property(DEVINST devInst, const DEVPROPKEY
> *propName,
> > +    PDEVPROPTYPE propType)
> > +{
> > +    CONFIGRET cr;
> > +    g_autofree LPBYTE buffer =3D NULL;
> > +    ULONG buffer_len =3D 0;
> > +
> > +    /* First query for needed space */
> > +    cr =3D CM_Get_DevNode_PropertyW(devInst, propName, propType,
> > +        buffer, &buffer_len, 0);
> > +    if (cr !=3D CR_SUCCESS && cr !=3D CR_BUFFER_SMALL) {
> > +
> > +        slog("failed to get property size, error=3D0x%lx", cr);
> > +        return NULL;
> > +    }
> > +    buffer =3D g_new0(BYTE, buffer_len + 1);
> > +    cr =3D CM_Get_DevNode_PropertyW(devInst, propName, propType,
> > +        buffer, &buffer_len, 0);
> > +    if (cr !=3D CR_SUCCESS) {
> > +        slog("failed to get device property, error=3D0x%lx", cr);
> > +        return NULL;
> > +    }
> > +    return g_steal_pointer(&buffer);
> > +}
> > +
> > +static GStrv ga_get_hardware_ids(DEVINST devInstance)
> > +{
> > +    GArray *values =3D NULL;
> > +    DEVPROPTYPE cm_type;
> > +    LPWSTR id;
> > +    g_autofree LPWSTR property =3D (LPWSTR)cm_get_property(devInstance=
,
> > +        &qga_DEVPKEY_Device_HardwareIds, &cm_type);
> > +    if (property =3D=3D NULL) {
> > +        slog("failed to get hardware IDs");
> > +        return NULL;
> > +    }
> > +    if (*property =3D=3D '\0') {
> > +        /* empty list */
> > +        return NULL;
> > +    }
> > +    values =3D g_array_new(TRUE, TRUE, sizeof(gchar *));
> > +    for (id =3D property; '\0' !=3D *id; id +=3D lstrlenW(id) + 1) {
> > +        gchar *id8 =3D g_utf16_to_utf8(id, -1, NULL, NULL, NULL);
> > +        g_array_append_val(values, id8);
> > +    }
> > +    return (GStrv)g_array_free(values, FALSE);
> > +}
> > +
> > +/*
> > + *
> https://docs.microsoft.com/en-us/windows-hardware/drivers/install/identif=
iers-for-pci-devices
> > + */
> > +#define DEVICE_PCI_RE "PCI\\\\VEN_(1AF4|1B36)&DEV_([0-9A-B]{4})(&|$)"
> > +
> > +GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
> > +{
> > +    GuestDeviceInfoList *head =3D NULL, *cur_item =3D NULL, *item =3D =
NULL;
> > +    HDEVINFO dev_info =3D INVALID_HANDLE_VALUE;
> > +    SP_DEVINFO_DATA dev_info_data;
> > +    int i, j;
> > +    GError *gerr =3D NULL;
> > +    g_autoptr(GRegex) device_pci_re =3D NULL;
> > +    DEVPROPTYPE cm_type;
> > +
> > +    device_pci_re =3D g_regex_new(DEVICE_PCI_RE,
> > +        G_REGEX_ANCHORED | G_REGEX_OPTIMIZE, 0,
> > +        &gerr);
> > +    g_assert(device_pci_re !=3D NULL);
> > +
> > +    dev_info_data.cbSize =3D sizeof(SP_DEVINFO_DATA);
> > +    dev_info =3D SetupDiGetClassDevs(0, 0, 0, DIGCF_PRESENT |
> DIGCF_ALLCLASSES);
> > +    if (dev_info =3D=3D INVALID_HANDLE_VALUE) {
> > +        error_setg(errp, "failed to get device tree");
> > +        return NULL;
> > +    }
> > +
> > +    slog("enumerating devices");
> > +    for (i =3D 0; SetupDiEnumDeviceInfo(dev_info, i, &dev_info_data);
> i++) {
> > +        bool skip =3D true;
> > +        SYSTEMTIME utc_date;
> > +        g_autofree LPWSTR name =3D NULL;
> > +        g_autofree LPFILETIME date =3D NULL;
> > +        g_autofree LPWSTR version =3D NULL;
> > +        g_auto(GStrv) hw_ids =3D NULL;
> > +        g_autoptr(GuestDeviceInfo) device =3D g_new0(GuestDeviceInfo, =
1);
> > +        g_autofree char *vendor_id =3D NULL;
> > +        g_autofree char *device_id =3D NULL;
> > +
> > +        name =3D (LPWSTR)cm_get_property(dev_info_data.DevInst,
> > +            &qga_DEVPKEY_NAME, &cm_type);
> > +        if (name =3D=3D NULL) {
> > +            slog("failed to get device description");
> > +            continue;
> > +        }
> > +        device->driver_name =3D g_utf16_to_utf8(name, -1, NULL, NULL,
> NULL);
> > +        if (device->driver_name =3D=3D NULL) {
> > +            error_setg(errp, "conversion to utf8 failed (driver name)"=
);
> > +            continue;
> > +        }
> > +        slog("querying device: %s", device->driver_name);
> > +        hw_ids =3D ga_get_hardware_ids(dev_info_data.DevInst);
> > +        if (hw_ids =3D=3D NULL) {
> > +            continue;
> > +        }
> > +        for (j =3D 0; hw_ids[j] !=3D NULL; j++) {
> > +            GMatchInfo *match_info;
> > +            GuestDeviceAddressPCI *address;
> > +            if (!g_regex_match(device_pci_re, hw_ids[j], 0,
> &match_info)) {
> > +                continue;
> > +            }
> > +            skip =3D false;
> > +
> > +            address =3D g_new0(GuestDeviceAddressPCI, 1);
> > +            vendor_id =3D g_match_info_fetch(match_info, 1);
> > +            device_id =3D g_match_info_fetch(match_info, 2);
> > +            address->vendor_id =3D g_ascii_strtoull(vendor_id, NULL, 1=
6);
> > +            address->device_id =3D g_ascii_strtoull(device_id, NULL, 1=
6);
> > +
> > +            device->address =3D g_new0(GuestDeviceAddress, 1);
> > +            device->has_address =3D true;
> > +            device->address->type =3D GUEST_DEVICE_ADDRESS_KIND_PCI;
> > +            device->address->u.pci.data =3D address;
> > +
> > +            g_match_info_free(match_info);
> > +            break;
> > +        }
> > +        if (skip) {
> > +            continue;
> > +        }
> > +
> > +        version =3D (LPWSTR)cm_get_property(dev_info_data.DevInst,
> > +            &qga_DEVPKEY_Device_DriverVersion, &cm_type);
> > +        if (version =3D=3D NULL) {
> > +            slog("failed to get driver version");
> > +            continue;
> > +        }
> > +        device->driver_version =3D g_utf16_to_utf8(version, -1, NULL,
> > +            NULL, NULL);
> > +        if (device->driver_version =3D=3D NULL) {
> > +            error_setg(errp, "conversion to utf8 failed (driver
> version)");
> > +            continue;
> > +        }
> > +        device->has_driver_version =3D true;
> > +
> > +        date =3D (LPFILETIME)cm_get_property(dev_info_data.DevInst,
> > +            &qga_DEVPKEY_Device_DriverDate, &cm_type);
> > +        if (date =3D=3D NULL) {
> > +            slog("failed to get driver date");
> > +            continue;
> > +        }
> > +        FileTimeToSystemTime(date, &utc_date);
> > +        device->driver_date =3D g_strdup_printf("%04d-%02d-%02d",
> > +            utc_date.wYear, utc_date.wMonth, utc_date.wDay);
> > +        device->has_driver_date =3D true;
> > +
> > +        slog("driver: %s\ndriver version: %s,%s\n", device->driver_nam=
e,
> > +            device->driver_date, device->driver_version);
> > +        item =3D g_new0(GuestDeviceInfoList, 1);
> > +        item->value =3D g_steal_pointer(&device);
> > +        if (!cur_item) {
> > +            head =3D cur_item =3D item;
> > +        } else {
> > +            cur_item->next =3D item;
> > +            cur_item =3D item;
> > +        }
> > +        continue;
> > +    }
> > +
> > +    if (dev_info !=3D INVALID_HANDLE_VALUE) {
> > +        SetupDiDestroyDeviceInfoList(dev_info);
> > +    }
> > +    return head;
> > +}
> > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> > index fb4605cc19..92ed76c419 100644
> > --- a/qga/qapi-schema.json
> > +++ b/qga/qapi-schema.json
> > @@ -1242,3 +1242,54 @@
> >  ##
> >  { 'command': 'guest-get-osinfo',
> >    'returns': 'GuestOSInfo' }
> > +
> > +##
> > +# @GuestDeviceAddressPCI:
> > +#
> > +# @vendor-id: vendor ID
> > +# @device-id: device ID
> > +#
> > +# Since: 5.0
> > +##
> > +{ 'struct': 'GuestDeviceAddressPCI',
> > +  'data': { 'vendor-id': 'uint16', 'device-id': 'uint16' } }
> > +
> > +##
> > +# @GuestDeviceAddress:
> > +#
> > +# Address of the device
> > +# - @pci: address of PCI device, since: 5.0
> > +#
> > +# Since: 5.0
> > +##
> > +{ 'union': 'GuestDeviceAddress',
> > +  'data': { 'pci': 'GuestDeviceAddressPCI' } }
> > +
> > +##
> > +# @GuestDeviceInfo:
> > +#
> > +# @driver-name: name of the associated driver
> > +# @driver-date: driver release date in format YYYY-MM-DD
> > +# @driver-version: driver version
> > +#
> > +# Since: 5.0
> > +##
> > +{ 'struct': 'GuestDeviceInfo',
> > +  'data': {
> > +      'driver-name': 'str',
> > +      '*driver-date': 'str',
> > +      '*driver-version': 'str',
> > +      '*address': 'GuestDeviceAddress'
> > +  } }
> > +
> > +##
> > +# @guest-get-devices:
> > +#
> > +# Retrieve information about device drivers in Windows guest
> > +#
> > +# Returns: @GuestDeviceInfo
> > +#
> > +# Since: 5.0
> > +##
> > +{ 'command': 'guest-get-devices',
> > +  'returns': ['GuestDeviceInfo'] }
> > --
> > 2.24.1
> >
>
>
> --
> Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000025531805aaf1f974
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 21, 2020 at 12:03 PM To=
m=C3=A1=C5=A1 Golembiovsk=C3=BD &lt;<a href=3D"mailto:tgolembi@redhat.com">=
tgolembi@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Ping. Can we get this merged finally?<br></blockquote><d=
iv><br></div><div>We missed the feature deadline by a week:<br></div><div><=
a href=3D"https://wiki.qemu.org/Planning/5.1">https://wiki.qemu.org/Plannin=
g/5.1</a></div><div> <br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
<br>
Thanks,<br>
<br>
=C2=A0 =C2=A0 Tomas<br>
<br>
On Thu,=C2=A0 9 Jan 2020 13:39:36 +0100<br>
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD &lt;<a href=3D"mailto:tgolembi@redhat.com=
" target=3D"_blank">tgolembi@redhat.com</a>&gt; wrote:<br>
<br>
&gt; Add command for reporting devices on Windows guest. The intent is not =
so<br>
&gt; much to report the devices but more importantly the driver (and its<br=
>
&gt; version) that is assigned to the device. This gives caller the<br>
&gt; information whether VirtIO drivers are installed and/or whether<br>
&gt; inadequate driver is used on a device (e.g. QXL device with base VGA<b=
r>
&gt; driver).<br>
&gt; <br>
&gt; Example:<br>
&gt; [<br>
&gt;=C2=A0 =C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;driver-date&quot;: &quot;2019-08-12&qu=
ot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;driver-name&quot;: &quot;Red Hat VirtI=
O SCSI controller&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;driver-version&quot;: &quot;100.80.104=
.17300&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;address&quot;: {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;type&quot;: &quot;pci&quot;,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;data&quot;: {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;device-id&quot;: 4162,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;vendor-id&quot;: 6900<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0},<br>
&gt;=C2=A0 =C2=A0 =C2=A0...<br>
&gt; ]<br>
&gt; <br>
&gt; Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD &lt;<a href=3D"mailto=
:tgolembi@redhat.com" target=3D"_blank">tgolembi@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt; <br>
&gt; Changes in v9: fixed compilation errors<br>
&gt; <br>
&gt;=C2=A0 qga/commands-posix.c |=C2=A0 =C2=A09 ++<br>
&gt;=C2=A0 qga/commands-win32.c | 212 +++++++++++++++++++++++++++++++++++++=
+++++-<br>
&gt;=C2=A0 qga/qapi-schema.json |=C2=A0 51 +++++++++++<br>
&gt;=C2=A0 3 files changed, 271 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
&gt; index 93474ff770..bffee8ce48 100644<br>
&gt; --- a/qga/commands-posix.c<br>
&gt; +++ b/qga/commands-posix.c<br>
&gt; @@ -2771,6 +2771,8 @@ GList *ga_command_blacklist_init(GList *blacklis=
t)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 blacklist =3D g_list_append(blacklist, g_strdup(&q=
uot;guest-fstrim&quot;));<br>
&gt;=C2=A0 #endif<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 blacklist =3D g_list_append(blacklist, g_strdup(&quot;g=
uest-get-devices&quot;));<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return blacklist;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; @@ -2991,3 +2993,10 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)=
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 return info;<br>
&gt;=C2=A0 }<br>
&gt; +<br>
&gt; +GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return NULL;<br>
&gt; +}<br>
&gt; diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
&gt; index 2461fd19bf..b18d89d7ad 100644<br>
&gt; --- a/qga/commands-win32.c<br>
&gt; +++ b/qga/commands-win32.c<br>
&gt; @@ -21,10 +21,11 @@<br>
&gt;=C2=A0 #ifdef CONFIG_QGA_NTDDSCSI<br>
&gt;=C2=A0 #include &lt;winioctl.h&gt;<br>
&gt;=C2=A0 #include &lt;ntddscsi.h&gt;<br>
&gt; +#endif<br>
&gt;=C2=A0 #include &lt;setupapi.h&gt;<br>
&gt;=C2=A0 #include &lt;cfgmgr32.h&gt;<br>
&gt;=C2=A0 #include &lt;initguid.h&gt;<br>
&gt; -#endif<br>
&gt; +#include &lt;devpropdef.h&gt;<br>
&gt;=C2=A0 #include &lt;lm.h&gt;<br>
&gt;=C2=A0 #include &lt;wtsapi32.h&gt;<br>
&gt;=C2=A0 #include &lt;wininet.h&gt;<br>
&gt; @@ -38,6 +39,36 @@<br>
&gt;=C2=A0 #include &quot;qemu/host-utils.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/base64.h&quot;<br>
&gt;=C2=A0 <br>
&gt; +/*<br>
&gt; + * The following should be in devpkey.h, but it isn&#39;t. The key na=
mes were<br>
&gt; + * prefixed to avoid (future) name clashes. Once the definitions get =
into<br>
&gt; + * mingw the following lines can be removed.<br>
&gt; + */<br>
&gt; +DEFINE_DEVPROPKEY(qga_DEVPKEY_NAME, 0xb725f130, 0x47ef, 0x101a, 0xa5,=
<br>
&gt; +=C2=A0 =C2=A0 0xf1, 0x02, 0x60, 0x8c, 0x9e, 0xeb, 0xac, 10);<br>
&gt; +=C2=A0 =C2=A0 /* DEVPROP_TYPE_STRING */<br>
&gt; +DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_HardwareIds, 0xa45c254e, 0xdf1c,=
<br>
&gt; +=C2=A0 =C2=A0 0x4efd, 0x80, 0x20, 0x67, 0xd1, 0x46, 0xa8, 0x50, 0xe0,=
 3);<br>
&gt; +=C2=A0 =C2=A0 /* DEVPROP_TYPE_STRING_LIST */<br>
&gt; +DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverDate, 0xa8b865dd, 0x2e3d,<=
br>
&gt; +=C2=A0 =C2=A0 0x4094, 0xad, 0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, =
2);<br>
&gt; +=C2=A0 =C2=A0 /* DEVPROP_TYPE_FILETIME */<br>
&gt; +DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverVersion, 0xa8b865dd, 0x2e3=
d,<br>
&gt; +=C2=A0 =C2=A0 0x4094, 0xad, 0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, =
3);<br>
&gt; +=C2=A0 =C2=A0 /* DEVPROP_TYPE_STRING */<br>
&gt; +/* The following shoud be in cfgmgr32.h, but it isn&#39;t */<br>
&gt; +#ifndef CM_Get_DevNode_Property<br>
&gt; +CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(<br>
&gt; +=C2=A0 =C2=A0 DEVINST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dnDevInst,<br=
>
&gt; +=C2=A0 =C2=A0 CONST DEVPROPKEY * PropertyKey,<br>
&gt; +=C2=A0 =C2=A0 DEVPROPTYPE=C2=A0 =C2=A0 =C2=A0 * PropertyType,<br>
&gt; +=C2=A0 =C2=A0 PBYTE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Property=
Buffer,<br>
&gt; +=C2=A0 =C2=A0 PULONG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Property=
BufferSize,<br>
&gt; +=C2=A0 =C2=A0 ULONG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ulFlags<=
br>
&gt; +);<br>
&gt; +#define CM_Get_DevNode_Property CM_Get_DevNode_PropertyW<br>
&gt; +#endif<br>
&gt; +<br>
&gt;=C2=A0 #ifndef SHTDN_REASON_FLAG_PLANNED<br>
&gt;=C2=A0 #define SHTDN_REASON_FLAG_PLANNED 0x80000000<br>
&gt;=C2=A0 #endif<br>
&gt; @@ -92,6 +123,8 @@ static OpenFlags guest_file_open_modes[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_free(suffix); \<br>
&gt;=C2=A0 } while (0)<br>
&gt;=C2=A0 <br>
&gt; +G_DEFINE_AUTOPTR_CLEANUP_FUNC(GuestDeviceInfo, qapi_free_GuestDeviceI=
nfo)<br>
&gt; +<br>
&gt;=C2=A0 static OpenFlags *find_open_flag(const char *mode_str)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int mode;<br>
&gt; @@ -2234,3 +2267,180 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp=
)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 return info;<br>
&gt;=C2=A0 }<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Safely get device property. Returned strings are using wide charac=
ters.<br>
&gt; + * Caller is responsible for freeing the buffer.<br>
&gt; + */<br>
&gt; +static LPBYTE cm_get_property(DEVINST devInst, const DEVPROPKEY *prop=
Name,<br>
&gt; +=C2=A0 =C2=A0 PDEVPROPTYPE propType)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 CONFIGRET cr;<br>
&gt; +=C2=A0 =C2=A0 g_autofree LPBYTE buffer =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 ULONG buffer_len =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* First query for needed space */<br>
&gt; +=C2=A0 =C2=A0 cr =3D CM_Get_DevNode_PropertyW(devInst, propName, prop=
Type,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer, &amp;buffer_len, 0);<br>
&gt; +=C2=A0 =C2=A0 if (cr !=3D CR_SUCCESS &amp;&amp; cr !=3D CR_BUFFER_SMA=
LL) {<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 slog(&quot;failed to get property size, e=
rror=3D0x%lx&quot;, cr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 buffer =3D g_new0(BYTE, buffer_len + 1);<br>
&gt; +=C2=A0 =C2=A0 cr =3D CM_Get_DevNode_PropertyW(devInst, propName, prop=
Type,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer, &amp;buffer_len, 0);<br>
&gt; +=C2=A0 =C2=A0 if (cr !=3D CR_SUCCESS) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 slog(&quot;failed to get device property,=
 error=3D0x%lx&quot;, cr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return g_steal_pointer(&amp;buffer);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static GStrv ga_get_hardware_ids(DEVINST devInstance)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 GArray *values =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 DEVPROPTYPE cm_type;<br>
&gt; +=C2=A0 =C2=A0 LPWSTR id;<br>
&gt; +=C2=A0 =C2=A0 g_autofree LPWSTR property =3D (LPWSTR)cm_get_property(=
devInstance,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;qga_DEVPKEY_Device_HardwareIds, &amp=
;cm_type);<br>
&gt; +=C2=A0 =C2=A0 if (property =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 slog(&quot;failed to get hardware IDs&quo=
t;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (*property =3D=3D &#39;\0&#39;) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* empty list */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 values =3D g_array_new(TRUE, TRUE, sizeof(gchar *));<br=
>
&gt; +=C2=A0 =C2=A0 for (id =3D property; &#39;\0&#39; !=3D *id; id +=3D ls=
trlenW(id) + 1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 gchar *id8 =3D g_utf16_to_utf8(id, -1, NU=
LL, NULL, NULL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_array_append_val(values, id8);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return (GStrv)g_array_free(values, FALSE);<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * <a href=3D"https://docs.microsoft.com/en-us/windows-hardware/drive=
rs/install/identifiers-for-pci-devices" rel=3D"noreferrer" target=3D"_blank=
">https://docs.microsoft.com/en-us/windows-hardware/drivers/install/identif=
iers-for-pci-devices</a><br>
&gt; + */<br>
&gt; +#define DEVICE_PCI_RE &quot;PCI\\\\VEN_(1AF4|1B36)&amp;DEV_([0-9A-B]{=
4})(&amp;|$)&quot;<br>
&gt; +<br>
&gt; +GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 GuestDeviceInfoList *head =3D NULL, *cur_item =3D NULL,=
 *item =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 HDEVINFO dev_info =3D INVALID_HANDLE_VALUE;<br>
&gt; +=C2=A0 =C2=A0 SP_DEVINFO_DATA dev_info_data;<br>
&gt; +=C2=A0 =C2=A0 int i, j;<br>
&gt; +=C2=A0 =C2=A0 GError *gerr =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 g_autoptr(GRegex) device_pci_re =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 DEVPROPTYPE cm_type;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 device_pci_re =3D g_regex_new(DEVICE_PCI_RE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 G_REGEX_ANCHORED | G_REGEX_OPTIMIZE, 0,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;gerr);<br>
&gt; +=C2=A0 =C2=A0 g_assert(device_pci_re !=3D NULL);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dev_info_data.cbSize =3D sizeof(SP_DEVINFO_DATA);<br>
&gt; +=C2=A0 =C2=A0 dev_info =3D SetupDiGetClassDevs(0, 0, 0, DIGCF_PRESENT=
 | DIGCF_ALLCLASSES);<br>
&gt; +=C2=A0 =C2=A0 if (dev_info =3D=3D INVALID_HANDLE_VALUE) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;failed to get devi=
ce tree&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 slog(&quot;enumerating devices&quot;);<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; SetupDiEnumDeviceInfo(dev_info, i, &amp;d=
ev_info_data); i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool skip =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 SYSTEMTIME utc_date;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree LPWSTR name =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree LPFILETIME date =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree LPWSTR version =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_auto(GStrv) hw_ids =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autoptr(GuestDeviceInfo) device =3D g_n=
ew0(GuestDeviceInfo, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *vendor_id =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *device_id =3D NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 name =3D (LPWSTR)cm_get_property(dev_info=
_data.DevInst,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;qga_DEVPKEY_NAME, &amp=
;cm_type);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (name =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slog(&quot;failed to get de=
vice description&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 device-&gt;driver_name =3D g_utf16_to_utf=
8(name, -1, NULL, NULL, NULL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (device-&gt;driver_name =3D=3D NULL) {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;conv=
ersion to utf8 failed (driver name)&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 slog(&quot;querying device: %s&quot;, dev=
ice-&gt;driver_name);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw_ids =3D ga_get_hardware_ids(dev_info_d=
ata.DevInst);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (hw_ids =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (j =3D 0; hw_ids[j] !=3D NULL; j++) {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GMatchInfo *match_info;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestDeviceAddressPCI *addr=
ess;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!g_regex_match(device_p=
ci_re, hw_ids[j], 0, &amp;match_info)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skip =3D false;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 address =3D g_new0(GuestDev=
iceAddressPCI, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vendor_id =3D g_match_info_=
fetch(match_info, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 device_id =3D g_match_info_=
fetch(match_info, 2);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 address-&gt;vendor_id =3D g=
_ascii_strtoull(vendor_id, NULL, 16);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 address-&gt;device_id =3D g=
_ascii_strtoull(device_id, NULL, 16);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 device-&gt;address =3D g_ne=
w0(GuestDeviceAddress, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 device-&gt;has_address =3D =
true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 device-&gt;address-&gt;type=
 =3D GUEST_DEVICE_ADDRESS_KIND_PCI;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 device-&gt;address-&gt;u.pc=
i.data =3D address;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_match_info_free(match_inf=
o);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (skip) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 version =3D (LPWSTR)cm_get_property(dev_i=
nfo_data.DevInst,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;qga_DEVPKEY_Device_Dri=
verVersion, &amp;cm_type);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (version =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slog(&quot;failed to get dr=
iver version&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 device-&gt;driver_version =3D g_utf16_to_=
utf8(version, -1, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, NULL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (device-&gt;driver_version =3D=3D NULL=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;conv=
ersion to utf8 failed (driver version)&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 device-&gt;has_driver_version =3D true;<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 date =3D (LPFILETIME)cm_get_property(dev_=
info_data.DevInst,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;qga_DEVPKEY_Device_Dri=
verDate, &amp;cm_type);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (date =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slog(&quot;failed to get dr=
iver date&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 FileTimeToSystemTime(date, &amp;utc_date)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 device-&gt;driver_date =3D g_strdup_print=
f(&quot;%04d-%02d-%02d&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 utc_date.wYear, utc_date.wM=
onth, utc_date.wDay);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 device-&gt;has_driver_date =3D true;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 slog(&quot;driver: %s\ndriver version: %s=
,%s\n&quot;, device-&gt;driver_name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 device-&gt;driver_date, dev=
ice-&gt;driver_version);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 item =3D g_new0(GuestDeviceInfoList, 1);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 item-&gt;value =3D g_steal_pointer(&amp;d=
evice);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cur_item) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 head =3D cur_item =3D item;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cur_item-&gt;next =3D item;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cur_item =3D item;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (dev_info !=3D INVALID_HANDLE_VALUE) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 SetupDiDestroyDeviceInfoList(dev_info);<b=
r>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return head;<br>
&gt; +}<br>
&gt; diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
&gt; index fb4605cc19..92ed76c419 100644<br>
&gt; --- a/qga/qapi-schema.json<br>
&gt; +++ b/qga/qapi-schema.json<br>
&gt; @@ -1242,3 +1242,54 @@<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 { &#39;command&#39;: &#39;guest-get-osinfo&#39;,<br>
&gt;=C2=A0 =C2=A0 &#39;returns&#39;: &#39;GuestOSInfo&#39; }<br>
&gt; +<br>
&gt; +##<br>
&gt; +# @GuestDeviceAddressPCI:<br>
&gt; +#<br>
&gt; +# @vendor-id: vendor ID<br>
&gt; +# @device-id: device ID<br>
&gt; +#<br>
&gt; +# Since: 5.0<br>
&gt; +##<br>
&gt; +{ &#39;struct&#39;: &#39;GuestDeviceAddressPCI&#39;,<br>
&gt; +=C2=A0 &#39;data&#39;: { &#39;vendor-id&#39;: &#39;uint16&#39;, &#39;=
device-id&#39;: &#39;uint16&#39; } }<br>
&gt; +<br>
&gt; +##<br>
&gt; +# @GuestDeviceAddress:<br>
&gt; +#<br>
&gt; +# Address of the device<br>
&gt; +# - @pci: address of PCI device, since: 5.0<br>
&gt; +#<br>
&gt; +# Since: 5.0<br>
&gt; +##<br>
&gt; +{ &#39;union&#39;: &#39;GuestDeviceAddress&#39;,<br>
&gt; +=C2=A0 &#39;data&#39;: { &#39;pci&#39;: &#39;GuestDeviceAddressPCI&#3=
9; } }<br>
&gt; +<br>
&gt; +##<br>
&gt; +# @GuestDeviceInfo:<br>
&gt; +#<br>
&gt; +# @driver-name: name of the associated driver<br>
&gt; +# @driver-date: driver release date in format YYYY-MM-DD<br>
&gt; +# @driver-version: driver version<br>
&gt; +#<br>
&gt; +# Since: 5.0<br>
&gt; +##<br>
&gt; +{ &#39;struct&#39;: &#39;GuestDeviceInfo&#39;,<br>
&gt; +=C2=A0 &#39;data&#39;: {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;driver-name&#39;: &#39;str&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*driver-date&#39;: &#39;str&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*driver-version&#39;: &#39;str&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*address&#39;: &#39;GuestDeviceAddress&#39;=
<br>
&gt; +=C2=A0 } }<br>
&gt; +<br>
&gt; +##<br>
&gt; +# @guest-get-devices:<br>
&gt; +#<br>
&gt; +# Retrieve information about device drivers in Windows guest<br>
&gt; +#<br>
&gt; +# Returns: @GuestDeviceInfo<br>
&gt; +#<br>
&gt; +# Since: 5.0<br>
&gt; +##<br>
&gt; +{ &#39;command&#39;: &#39;guest-get-devices&#39;,<br>
&gt; +=C2=A0 &#39;returns&#39;: [&#39;GuestDeviceInfo&#39;] }<br>
&gt; -- <br>
&gt; 2.24.1<br>
&gt; <br>
<br>
<br>
-- <br>
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD &lt;<a href=3D"mailto:tgolembi@redhat.com=
" target=3D"_blank">tgolembi@redhat.com</a>&gt;<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--00000000000025531805aaf1f974--

