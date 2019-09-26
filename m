Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BB6C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 10:30:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E719221A4A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 10:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUBwX7Nm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E719221A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDR2d-0001Pg-27
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 06:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tgolembi@redhat.com>) id 1iDQuk-0001vs-E0
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 06:22:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tgolembi@redhat.com>) id 1iDQuh-0003fS-DC
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 06:22:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33989
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1iDQuh-0003eX-7m
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 06:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569493338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iv6k15IDxPjjXNnDbAZ8xL5j1acQVPuMokfWsQsC6cM=;
 b=KUBwX7Nm5Mq+IHe8P6kBYxZg1HEbhzpsWiBJEoleiDsXg3RPYmULpFg7uN+mhnWbUHyuqg
 Iv8KIuV18g4HXp2aq6RLzoMyoc/62ghMgoU9jahrzRfXjDARTZFWNB+fNKGdetiXonFxyC
 G0zI9z8m5vjgUqGXxPsN/f6t/Eitnvo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-ABH-UnUvPdujeG80CzaobQ-1; Thu, 26 Sep 2019 06:22:16 -0400
Received: by mail-wr1-f70.google.com with SMTP id v18so734460wro.16
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 03:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=coSbExWdz7hgtdhwciQql7d2aEA7PXC1ButsXQL3NZE=;
 b=ERP28wZJ6CTgD+/3d3nCGzyQKqxofzz2i8uhM8vDTAM5s0IoXKTSqimX4e6iZRbQ4/
 uNFggc9b4+7gZzVJ7l4yBZtdBQHgXxFBkmpiNADACoUgMi1CLLXCm7j5oXYT239dHuYn
 61uqr36Ix8NvLgFp53RY9+cDtauCmgOOfqoAMNFNLAD/g0tarARS6q5/+hRYtAho/aTa
 xFCpkzFNP7Cy1YJdr4OJTpIXv8g3D6qr7Oe3QAgnk5ro55ZOOgL4CbZORfBdWaftkUYa
 5zjRQSWcAwbI5C2WD437jWcBGWfRnYwYrdCVlxpp45G5cGm8gafFV5hLG9bx2QRWMkdQ
 MQnw==
X-Gm-Message-State: APjAAAWt9YZx2ZuNeO+TMl+nKfzhxvDTTiEUT3amUFjJidNiO4DQdJ7f
 IA6BhIcGW8nOY/LvmoN7aaEw364B/Nq2BuOTMHO3gxowP0z6T888OBqky5s6dejaabcTFsCAnZE
 SKQfEg2npasyDDZo=
X-Received: by 2002:a05:600c:22da:: with SMTP id
 26mr2260607wmg.177.1569493335652; 
 Thu, 26 Sep 2019 03:22:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyujLMX2oavQ9WcXEF1Jqz6OuBB/HwApYPnraQnA4myakZjKv+kxyq5gjlWEaSFtWNUwNzsmg==
X-Received: by 2002:a05:600c:22da:: with SMTP id
 26mr2260534wmg.177.1569493334612; 
 Thu, 26 Sep 2019 03:22:14 -0700 (PDT)
Received: from auriga.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 c8sm2334624wrr.49.2019.09.26.03.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 03:22:14 -0700 (PDT)
Date: Thu, 26 Sep 2019 12:22:13 +0200
From: =?utf-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH v3] qga: add command guest-get-devices for reporting
 VirtIO devices
Message-ID: <20190926102213.2f3fxcofbnbms3ev@auriga.localdomain>
References: <919bbd6e0557d2fe2d9c17de394cc0b4c6fa4426.1569445204.git.tgolembi@redhat.com>
 <CAJ+F1C+Mq2HEqwHAycaZ8MgkQgw2hNW1=JoXGy1wLp7jvsmR4A@mail.gmail.com>
 <20190926101637.bu5d2icchu2ilrya@auriga.localdomain>
MIME-Version: 1.0
In-Reply-To: <20190926101637.bu5d2icchu2ilrya@auriga.localdomain>
User-Agent: NeoMutt/20180716
X-MC-Unique: ABH-UnUvPdujeG80CzaobQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 26, 2019 at 12:16:38PM +0200, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD=
 wrote:
> On Thu, Sep 26, 2019 at 11:13:32AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >=20
> > On Thu, Sep 26, 2019 at 1:01 AM Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgol=
embi@redhat.com> wrote:
> > >
> > > Add command for reporting devices on Windows guest. The intent is not=
 so
> > > much to report the devices but more importantly the driver (and its
> > > version) that is assigned to the device. This gives caller the
> > > information whether VirtIO drivers are installed and/or whether
> > > inadequate driver is used on a device (e.g. QXL device with base VGA
> > > driver).
> > >
> > > Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com=
>
> > > ---
> > >  qga/commands-posix.c |   9 ++
> > >  qga/commands-win32.c | 204 +++++++++++++++++++++++++++++++++++++++++=
+-
> > >  qga/qapi-schema.json |  32 +++++++
> > >  3 files changed, 244 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> > > index dfc05f5b8a..58e93feef9 100644
> > > --- a/qga/commands-posix.c
> > > +++ b/qga/commands-posix.c
> > > @@ -2757,6 +2757,8 @@ GList *ga_command_blacklist_init(GList *blackli=
st)
> > >      blacklist =3D g_list_append(blacklist, g_strdup("guest-fstrim"))=
;
> > >  #endif
> > >
> > > +    blacklist =3D g_list_append(blacklist, g_strdup("guest-get-devic=
es"));
> > > +
> > >      return blacklist;
> > >  }
> > >
> > > @@ -2977,3 +2979,10 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp=
)
> > >
> > >      return info;
> > >  }
> > > +
> > > +GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
> > > +{
> > > +    error_setg(errp, QERR_UNSUPPORTED);
> > > +
> > > +    return NULL;
> > > +}
> > > diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> > > index 6b67f16faf..139dbd7c9a 100644
> > > --- a/qga/commands-win32.c
> > > +++ b/qga/commands-win32.c
> > > @@ -21,10 +21,11 @@
> > >  #ifdef CONFIG_QGA_NTDDSCSI
> > >  #include <winioctl.h>
> > >  #include <ntddscsi.h>
> > > +#endif
> > >  #include <setupapi.h>
> > >  #include <cfgmgr32.h>
> > >  #include <initguid.h>
> > > -#endif
> > > +#include <devpropdef.h>
> > >  #include <lm.h>
> > >  #include <wtsapi32.h>
> > >  #include <wininet.h>
> > > @@ -38,6 +39,36 @@
> > >  #include "qemu/host-utils.h"
> > >  #include "qemu/base64.h"
> > >
> > > +/*
> > > + * The following should be in devpkey.h, but it isn't. The key names=
 were
> > > + * prefixed to avoid (future) name clashes. Once the definitions get=
 into
> > > + * mingw the following lines can be removed.
> > > + */
> > > +DEFINE_DEVPROPKEY(qga_DEVPKEY_NAME, 0xb725f130, 0x47ef, 0x101a, 0xa5=
,
> > > +    0xf1, 0x02, 0x60, 0x8c, 0x9e, 0xeb, 0xac, 10);
> > > +    /* DEVPROP_TYPE_STRING */
> > > +DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_HardwareIds, 0xa45c254e, 0xdf1c=
,
> > > +    0x4efd, 0x80, 0x20, 0x67, 0xd1, 0x46, 0xa8, 0x50, 0xe0, 3);
> > > +    /* DEVPROP_TYPE_STRING_LIST */
> > > +DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverDate, 0xa8b865dd, 0x2e3d,
> > > +    0x4094, 0xad, 0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, 2);
> > > +    /* DEVPROP_TYPE_FILETIME */
> > > +DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverVersion, 0xa8b865dd, 0x2e=
3d,
> > > +    0x4094, 0xad, 0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, 3);
> > > +    /* DEVPROP_TYPE_STRING */
> > > +/* The following shoud be in cfgmgr32.h, but it isn't */
> > > +#ifndef CM_Get_DevNode_Property
> > > +CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(
> > > +    DEVINST          dnDevInst,
> > > +    CONST DEVPROPKEY * PropertyKey,
> > > +    DEVPROPTYPE      * PropertyType,
> > > +    PBYTE            PropertyBuffer,
> > > +    PULONG           PropertyBufferSize,
> > > +    ULONG            ulFlags
> > > +);
> > > +#define CM_Get_DevNode_Property CM_Get_DevNode_PropertyW
> > > +#endif
> > > +
> > >  #ifndef SHTDN_REASON_FLAG_PLANNED
> > >  #define SHTDN_REASON_FLAG_PLANNED 0x80000000
> > >  #endif
> > > @@ -92,6 +123,8 @@ static OpenFlags guest_file_open_modes[] =3D {
> > >      g_free(suffix); \
> > >  } while (0)
> > >
> > > +G_DEFINE_AUTOPTR_CLEANUP_FUNC(GuestDeviceInfo, qapi_free_GuestDevice=
Info)
> > > +
> > >  static OpenFlags *find_open_flag(const char *mode_str)
> > >  {
> > >      int mode;
> > > @@ -2234,3 +2267,172 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **err=
p)
> > >
> > >      return info;
> > >  }
> > > +
> > > +/*
> > > + * Safely get device property. Returned strings are using wide chara=
cters.
> > > + * Caller is responsible for freeing the buffer.
> > > + */
> > > +static LPBYTE cm_get_property(DEVINST devInst, const DEVPROPKEY *pro=
pName,
> > > +    PDEVPROPTYPE propType)
> > > +{
> > > +    CONFIGRET cr;
> > > +    g_autofree LPBYTE buffer =3D NULL;
> > > +    ULONG buffer_len =3D 0;
> > > +
> > > +    /* First query for needed space */
> > > +    cr =3D CM_Get_DevNode_PropertyW(devInst, propName, propType,
> > > +        buffer, &buffer_len, 0);
> > > +    if (cr !=3D CR_SUCCESS && cr !=3D CR_BUFFER_SMALL) {
> > > +
> > > +        slog("failed to get property size, error=3D0x%lx", cr);
> > > +        return NULL;
> > > +    }
> > > +    buffer =3D g_new0(BYTE, buffer_len + 1);
> > > +    cr =3D CM_Get_DevNode_PropertyW(devInst, propName, propType,
> > > +        buffer, &buffer_len, 0);
> > > +    if (cr !=3D CR_SUCCESS) {
> > > +        slog("failed to get device property, error=3D0x%lx", cr);
> > > +        return NULL;
> > > +    }
> > > +    return g_steal_pointer(&buffer);
> > > +}
> > > +
> > > +static GStrv ga_get_hardware_ids(DEVINST devInstance)
> > > +{
> > > +    GStrv hw_ids =3D NULL;
> > > +    GArray *values =3D NULL;
> > > +    DEVPROPTYPE cm_type;
> > > +    LPWSTR id;
> > > +    g_autofree LPWSTR property =3D (LPWSTR)cm_get_property(devInstan=
ce,
> > > +        &qga_DEVPKEY_Device_HardwareIds, &cm_type);
> > > +    if (property =3D=3D NULL) {
> > > +        slog("failed to get hardware IDs");
> > > +        return NULL;
> > > +    }
> > > +    if (*property =3D=3D '\0') {
> > > +        /* empty list */
> > > +        return NULL;
> > > +    }
> > > +    values =3D g_array_new(TRUE, TRUE, sizeof(gchar*));
> > > +    for (id =3D property; '\0' !=3D *id; id +=3D lstrlenW(id) + 1) {
> > > +        gchar* id8 =3D g_utf16_to_utf8(id, -1, NULL, NULL, NULL);
> > > +        g_array_append_val(values, id8);
> > > +    }
> > > +    hw_ids =3D (GStrv)g_array_free(values, FALSE);
> > > +    values =3D NULL;
> > > +    return hw_ids;
> >=20
> > Why not return g_array_free(values, FALSE) directly?
>=20
> Yeah, you're right. This is a relic from before when I used g_autoptr
> for it. Could be more straightforward now as you say.
>=20
>     Tomas

Do you want me to send new version?

>=20
> >=20
> > > +}
> > > +
> > > +/*
> > > + * https://docs.microsoft.com/en-us/windows-hardware/drivers/install=
/identifiers-for-pci-devices
> > > + */
> > > +#define DEVICE_PCI_RE "PCI\\\\VEN_(1AF4|1B36)&DEV_([0-9A-B]{4})(&|$)=
"
> > > +
> > > +GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
> > > +{
> > > +    GuestDeviceInfoList *head =3D NULL, *cur_item =3D NULL, *item =
=3D NULL;
> > > +    HDEVINFO dev_info =3D INVALID_HANDLE_VALUE;
> > > +    SP_DEVINFO_DATA dev_info_data;
> > > +    int i, j;
> > > +    GError *gerr =3D NULL;
> > > +    g_autoptr(GRegex) device_pci_re =3D NULL;
> > > +    DEVPROPTYPE cm_type;
> > > +
> > > +    device_pci_re =3D g_regex_new(DEVICE_PCI_RE,
> > > +        G_REGEX_ANCHORED | G_REGEX_OPTIMIZE, 0,
> > > +        &gerr);
> > > +    g_assert(device_pci_re !=3D NULL);
> > > +
> > > +    dev_info_data.cbSize =3D sizeof(SP_DEVINFO_DATA);
> > > +    dev_info =3D SetupDiGetClassDevs(0, 0, 0, DIGCF_PRESENT | DIGCF_=
ALLCLASSES);
> > > +    if (dev_info =3D=3D INVALID_HANDLE_VALUE) {
> > > +        error_setg(errp, "failed to get device tree");
> > > +        return NULL;
> > > +    }
> > > +
> > > +    slog("enumerating devices");
> > > +    for (i =3D 0; SetupDiEnumDeviceInfo(dev_info, i, &dev_info_data)=
; i++) {
> > > +        bool skip =3D true;
> > > +        SYSTEMTIME utc_date;
> > > +        g_autofree LPWSTR name =3D NULL;
> > > +        g_autofree LPFILETIME date =3D NULL;
> > > +        g_autofree LPWSTR version =3D NULL;
> > > +        g_auto(GStrv) hw_ids =3D NULL;
> > > +        g_autoptr(GuestDeviceInfo) device =3D g_new0(GuestDeviceInfo=
, 1);
> > > +        g_autofree char *vendor_id =3D NULL;
> > > +        g_autofree char *device_id =3D NULL;
> > > +
> > > +        name =3D (LPWSTR)cm_get_property(dev_info_data.DevInst,
> > > +            &qga_DEVPKEY_NAME, &cm_type);
> > > +        if (name =3D=3D NULL) {
> > > +            slog("failed to get device description");
> > > +            continue;
> > > +        }
> > > +        device->driver_name =3D g_utf16_to_utf8(name, -1, NULL, NULL=
, NULL);
> > > +        if (device->driver_name =3D=3D NULL) {
> > > +            error_setg(errp, "conversion to utf8 failed (driver name=
)");
> > > +            goto out;
> > > +        }
> > > +        slog("querying device: %s", device->driver_name);
> > > +        hw_ids =3D ga_get_hardware_ids(dev_info_data.DevInst);
> > > +        if (hw_ids =3D=3D NULL) {
> > > +            continue;
> > > +        }
> > > +        for (j =3D 0; hw_ids[j] !=3D NULL; j++) {
> > > +            GMatchInfo *match_info;
> > > +            if (!g_regex_match(device_pci_re, hw_ids[j], 0, &match_i=
nfo)) {
> > > +                continue;
> > > +            }
> > > +            skip =3D false;
> > > +            vendor_id =3D g_match_info_fetch(match_info, 1);
> > > +            device_id =3D g_match_info_fetch(match_info, 2);
> > > +            device->vendor_id =3D g_ascii_strtoull(vendor_id, NULL, =
16);
> > > +            device->device_id =3D g_ascii_strtoull(device_id, NULL, =
16);
> > > +            g_match_info_free(match_info);
> > > +        }
> > > +        if (skip) {
> > > +            continue;
> > > +        }
> > > +
> > > +        version =3D (LPWSTR)cm_get_property(dev_info_data.DevInst,
> > > +            &qga_DEVPKEY_Device_DriverVersion, &cm_type);
> > > +        if (version =3D=3D NULL) {
> > > +            slog("failed to get driver version");
> > > +            continue;
> > > +        }
> > > +        device->driver_version =3D g_utf16_to_utf8(version, -1, NULL=
,
> > > +            NULL, NULL);
> > > +        if (device->driver_version =3D=3D NULL) {
> > > +            error_setg(errp, "conversion to utf8 failed (driver vers=
ion)");
> > > +            goto out;
> > > +        }
> > > +
> > > +        date =3D (LPFILETIME)cm_get_property(dev_info_data.DevInst,
> > > +            &qga_DEVPKEY_Device_DriverDate, &cm_type);
> > > +        if (date =3D=3D NULL) {
> > > +            slog("failed to get driver date");
> > > +            continue;
> > > +        }
> > > +        FileTimeToSystemTime(date, &utc_date);
> > > +        device->driver_date =3D g_strdup_printf("%04d-%02d-%02d",
> > > +            utc_date.wYear, utc_date.wMonth, utc_date.wDay);
> > > +
> > > +        slog("driver: %s\ndriver version: %s,%s\n", device->driver_n=
ame,
> > > +            device->driver_date, device->driver_version);
> > > +        item =3D g_new0(GuestDeviceInfoList, 1);
> > > +        item->value =3D g_steal_pointer(&device);
> > > +        if (!cur_item) {
> > > +            head =3D cur_item =3D item;
> > > +        } else {
> > > +            cur_item->next =3D item;
> > > +            cur_item =3D item;
> > > +        }
> > > +        continue;
> > > +    }
> > > +
> > > +out:
> > > +    if (dev_info !=3D INVALID_HANDLE_VALUE) {
> > > +        SetupDiDestroyDeviceInfoList(dev_info);
> > > +    }
> > > +    return head;
> > > +}
> > > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> > > index fb4605cc19..fe04ff2f39 100644
> > > --- a/qga/qapi-schema.json
> > > +++ b/qga/qapi-schema.json
> > > @@ -1242,3 +1242,35 @@
> > >  ##
> > >  { 'command': 'guest-get-osinfo',
> > >    'returns': 'GuestOSInfo' }
> > > +
> > > +##
> > > +# @GuestDeviceInfo:
> > > +#
> > > +# @vendor-id: vendor ID
> > > +# @device-id: device ID
> > > +# @driver-name: name of the associated driver
> > > +# @driver-date: driver release date in format YYYY-MM-DD
> > > +# @driver-version: driver version
> > > +#
> > > +# Since: 4.2
> > > +##
> > > +{ 'struct': 'GuestDeviceInfo',
> > > +  'data': {
> > > +      'vendor-id': 'uint16',
> > > +      'device-id': 'uint16',
> > > +      'driver-name': 'str',
> > > +      'driver-date': 'str',
> > > +      'driver-version': 'str'
> > > +      } }
> > > +
> > > +##
> > > +# @guest-get-devices:
> > > +#
> > > +# Retrieve information about device drivers in Windows guest
> > > +#
> > > +# Returns: @GuestDeviceInfo
> > > +#
> > > +# Since: 4.2
> > > +##
> > > +{ 'command': 'guest-get-devices',
> > > +  'returns': ['GuestDeviceInfo'] }
> > > --
> > > 2.23.0
> > >
> > >
> >=20
> >=20
> > other than that,
> >=20
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >=20
> > --=20
> > Marc-Andr=C3=A9 Lureau
>=20
> --=20
> Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>

--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>


