Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92FEC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 11:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60F7B2073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 11:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bTmKNEwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F7B2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxqhJ-0003bW-NI
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 07:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jxqge-0003AM-IO
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 07:43:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21009
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jxqga-0005Rc-Um
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 07:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595331831;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lqBlBXYSvCV0RRnf+9YT26m23KvdnLxwmpTjxcWCtwM=;
 b=bTmKNEwI3jSKz7tLn2mMIfGX7av1cN9CQfW1ic+pZP6QEX7lUv4aAIb1tWOT6G5+HcsVCF
 KvygWixszwDhmLfc3g7fEnd6vTIorNdTbhK0og0YEZdKhYfiCZXVRdoUK4T85mQFu5c195
 2Sb4mx6fpMtCxpeJ5gumb9YmfckpTzU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-LqnRMU2FPAK2dezMM_b4pQ-1; Tue, 21 Jul 2020 07:43:41 -0400
X-MC-Unique: LqnRMU2FPAK2dezMM_b4pQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91DD2102C7EC;
 Tue, 21 Jul 2020 11:43:40 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 10FF78FA20;
 Tue, 21 Jul 2020 11:43:37 +0000 (UTC)
Date: Tue, 21 Jul 2020 12:43:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH v9] qga: add command guest-get-devices for reporting
 VirtIO devices
Message-ID: <20200721114335.GF843362@redhat.com>
References: <e4f1b62bedb243ec46351a264c4e08f800655daa.1578573547.git.tgolembi@redhat.com>
 <20200721100155.17c26c05@fiorina>
 <CAJ+F1CJgcwLiYWioPayiKXuoUSKAffLWaS_V-TTve2DJeoLu7Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJgcwLiYWioPayiKXuoUSKAffLWaS_V-TTve2DJeoLu7Q@mail.gmail.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 03:39:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: =?utf-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 21, 2020 at 03:31:52PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Jul 21, 2020 at 12:03 PM Tomáš Golembiovský <tgolembi@redhat.com>
> wrote:
> 
> > Ping. Can we get this merged finally?
> >
> 
> We missed the feature deadline by a week:
> https://wiki.qemu.org/Planning/5.1

Note, if a patch series from a contributor is ready, the subsystem
maintainer should queue it in their subsystem tree, so it is ready
for a pull request when the main tree opens up again. ie the subsys
maintainer is the one responsible for dealing with feature freeze
coordination, not the individual contriubutors.

In this case the "Since 5.0" tags need updating to 5.2 now. The
maintainer could handle this, but since this series is over 6 months
old now, it is probably worth rebasing & reposting.

> > Thanks,
> >
> >     Tomas
> >
> > On Thu,  9 Jan 2020 13:39:36 +0100
> > Tomáš Golembiovský <tgolembi@redhat.com> wrote:
> >
> > > Add command for reporting devices on Windows guest. The intent is not so
> > > much to report the devices but more importantly the driver (and its
> > > version) that is assigned to the device. This gives caller the
> > > information whether VirtIO drivers are installed and/or whether
> > > inadequate driver is used on a device (e.g. QXL device with base VGA
> > > driver).
> > >
> > > Example:
> > > [
> > >     {
> > >       "driver-date": "2019-08-12",
> > >       "driver-name": "Red Hat VirtIO SCSI controller",
> > >       "driver-version": "100.80.104.17300",
> > >       "address": {
> > >         "type": "pci",
> > >         "data": {
> > >           "device-id": 4162,
> > >           "vendor-id": 6900
> > >         }
> > >       }
> > >     },
> > >     ...
> > > ]
> > >
> > > Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
> > > ---
> > >
> > > Changes in v9: fixed compilation errors
> > >
> > >  qga/commands-posix.c |   9 ++
> > >  qga/commands-win32.c | 212 ++++++++++++++++++++++++++++++++++++++++++-
> > >  qga/qapi-schema.json |  51 +++++++++++
> > >  3 files changed, 271 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> > > index 93474ff770..bffee8ce48 100644
> > > --- a/qga/commands-posix.c
> > > +++ b/qga/commands-posix.c
> > > @@ -2771,6 +2771,8 @@ GList *ga_command_blacklist_init(GList *blacklist)
> > >      blacklist = g_list_append(blacklist, g_strdup("guest-fstrim"));
> > >  #endif
> > >
> > > +    blacklist = g_list_append(blacklist, g_strdup("guest-get-devices"));
> > > +
> > >      return blacklist;
> > >  }
> > >
> > > @@ -2991,3 +2993,10 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
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
> > > index 2461fd19bf..b18d89d7ad 100644
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
> > > + * The following should be in devpkey.h, but it isn't. The key names
> > were
> > > + * prefixed to avoid (future) name clashes. Once the definitions get
> > into
> > > + * mingw the following lines can be removed.
> > > + */
> > > +DEFINE_DEVPROPKEY(qga_DEVPKEY_NAME, 0xb725f130, 0x47ef, 0x101a, 0xa5,
> > > +    0xf1, 0x02, 0x60, 0x8c, 0x9e, 0xeb, 0xac, 10);
> > > +    /* DEVPROP_TYPE_STRING */
> > > +DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_HardwareIds, 0xa45c254e, 0xdf1c,
> > > +    0x4efd, 0x80, 0x20, 0x67, 0xd1, 0x46, 0xa8, 0x50, 0xe0, 3);
> > > +    /* DEVPROP_TYPE_STRING_LIST */
> > > +DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverDate, 0xa8b865dd, 0x2e3d,
> > > +    0x4094, 0xad, 0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, 2);
> > > +    /* DEVPROP_TYPE_FILETIME */
> > > +DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverVersion, 0xa8b865dd, 0x2e3d,
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
> > > @@ -92,6 +123,8 @@ static OpenFlags guest_file_open_modes[] = {
> > >      g_free(suffix); \
> > >  } while (0)
> > >
> > > +G_DEFINE_AUTOPTR_CLEANUP_FUNC(GuestDeviceInfo,
> > qapi_free_GuestDeviceInfo)
> > > +
> > >  static OpenFlags *find_open_flag(const char *mode_str)
> > >  {
> > >      int mode;
> > > @@ -2234,3 +2267,180 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
> > >
> > >      return info;
> > >  }
> > > +
> > > +/*
> > > + * Safely get device property. Returned strings are using wide
> > characters.
> > > + * Caller is responsible for freeing the buffer.
> > > + */
> > > +static LPBYTE cm_get_property(DEVINST devInst, const DEVPROPKEY
> > *propName,
> > > +    PDEVPROPTYPE propType)
> > > +{
> > > +    CONFIGRET cr;
> > > +    g_autofree LPBYTE buffer = NULL;
> > > +    ULONG buffer_len = 0;
> > > +
> > > +    /* First query for needed space */
> > > +    cr = CM_Get_DevNode_PropertyW(devInst, propName, propType,
> > > +        buffer, &buffer_len, 0);
> > > +    if (cr != CR_SUCCESS && cr != CR_BUFFER_SMALL) {
> > > +
> > > +        slog("failed to get property size, error=0x%lx", cr);
> > > +        return NULL;
> > > +    }
> > > +    buffer = g_new0(BYTE, buffer_len + 1);
> > > +    cr = CM_Get_DevNode_PropertyW(devInst, propName, propType,
> > > +        buffer, &buffer_len, 0);
> > > +    if (cr != CR_SUCCESS) {
> > > +        slog("failed to get device property, error=0x%lx", cr);
> > > +        return NULL;
> > > +    }
> > > +    return g_steal_pointer(&buffer);
> > > +}
> > > +
> > > +static GStrv ga_get_hardware_ids(DEVINST devInstance)
> > > +{
> > > +    GArray *values = NULL;
> > > +    DEVPROPTYPE cm_type;
> > > +    LPWSTR id;
> > > +    g_autofree LPWSTR property = (LPWSTR)cm_get_property(devInstance,
> > > +        &qga_DEVPKEY_Device_HardwareIds, &cm_type);
> > > +    if (property == NULL) {
> > > +        slog("failed to get hardware IDs");
> > > +        return NULL;
> > > +    }
> > > +    if (*property == '\0') {
> > > +        /* empty list */
> > > +        return NULL;
> > > +    }
> > > +    values = g_array_new(TRUE, TRUE, sizeof(gchar *));
> > > +    for (id = property; '\0' != *id; id += lstrlenW(id) + 1) {
> > > +        gchar *id8 = g_utf16_to_utf8(id, -1, NULL, NULL, NULL);
> > > +        g_array_append_val(values, id8);
> > > +    }
> > > +    return (GStrv)g_array_free(values, FALSE);
> > > +}
> > > +
> > > +/*
> > > + *
> > https://docs.microsoft.com/en-us/windows-hardware/drivers/install/identifiers-for-pci-devices
> > > + */
> > > +#define DEVICE_PCI_RE "PCI\\\\VEN_(1AF4|1B36)&DEV_([0-9A-B]{4})(&|$)"
> > > +
> > > +GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
> > > +{
> > > +    GuestDeviceInfoList *head = NULL, *cur_item = NULL, *item = NULL;
> > > +    HDEVINFO dev_info = INVALID_HANDLE_VALUE;
> > > +    SP_DEVINFO_DATA dev_info_data;
> > > +    int i, j;
> > > +    GError *gerr = NULL;
> > > +    g_autoptr(GRegex) device_pci_re = NULL;
> > > +    DEVPROPTYPE cm_type;
> > > +
> > > +    device_pci_re = g_regex_new(DEVICE_PCI_RE,
> > > +        G_REGEX_ANCHORED | G_REGEX_OPTIMIZE, 0,
> > > +        &gerr);
> > > +    g_assert(device_pci_re != NULL);
> > > +
> > > +    dev_info_data.cbSize = sizeof(SP_DEVINFO_DATA);
> > > +    dev_info = SetupDiGetClassDevs(0, 0, 0, DIGCF_PRESENT |
> > DIGCF_ALLCLASSES);
> > > +    if (dev_info == INVALID_HANDLE_VALUE) {
> > > +        error_setg(errp, "failed to get device tree");
> > > +        return NULL;
> > > +    }
> > > +
> > > +    slog("enumerating devices");
> > > +    for (i = 0; SetupDiEnumDeviceInfo(dev_info, i, &dev_info_data);
> > i++) {
> > > +        bool skip = true;
> > > +        SYSTEMTIME utc_date;
> > > +        g_autofree LPWSTR name = NULL;
> > > +        g_autofree LPFILETIME date = NULL;
> > > +        g_autofree LPWSTR version = NULL;
> > > +        g_auto(GStrv) hw_ids = NULL;
> > > +        g_autoptr(GuestDeviceInfo) device = g_new0(GuestDeviceInfo, 1);
> > > +        g_autofree char *vendor_id = NULL;
> > > +        g_autofree char *device_id = NULL;
> > > +
> > > +        name = (LPWSTR)cm_get_property(dev_info_data.DevInst,
> > > +            &qga_DEVPKEY_NAME, &cm_type);
> > > +        if (name == NULL) {
> > > +            slog("failed to get device description");
> > > +            continue;
> > > +        }
> > > +        device->driver_name = g_utf16_to_utf8(name, -1, NULL, NULL,
> > NULL);
> > > +        if (device->driver_name == NULL) {
> > > +            error_setg(errp, "conversion to utf8 failed (driver name)");
> > > +            continue;
> > > +        }
> > > +        slog("querying device: %s", device->driver_name);
> > > +        hw_ids = ga_get_hardware_ids(dev_info_data.DevInst);
> > > +        if (hw_ids == NULL) {
> > > +            continue;
> > > +        }
> > > +        for (j = 0; hw_ids[j] != NULL; j++) {
> > > +            GMatchInfo *match_info;
> > > +            GuestDeviceAddressPCI *address;
> > > +            if (!g_regex_match(device_pci_re, hw_ids[j], 0,
> > &match_info)) {
> > > +                continue;
> > > +            }
> > > +            skip = false;
> > > +
> > > +            address = g_new0(GuestDeviceAddressPCI, 1);
> > > +            vendor_id = g_match_info_fetch(match_info, 1);
> > > +            device_id = g_match_info_fetch(match_info, 2);
> > > +            address->vendor_id = g_ascii_strtoull(vendor_id, NULL, 16);
> > > +            address->device_id = g_ascii_strtoull(device_id, NULL, 16);
> > > +
> > > +            device->address = g_new0(GuestDeviceAddress, 1);
> > > +            device->has_address = true;
> > > +            device->address->type = GUEST_DEVICE_ADDRESS_KIND_PCI;
> > > +            device->address->u.pci.data = address;
> > > +
> > > +            g_match_info_free(match_info);
> > > +            break;
> > > +        }
> > > +        if (skip) {
> > > +            continue;
> > > +        }
> > > +
> > > +        version = (LPWSTR)cm_get_property(dev_info_data.DevInst,
> > > +            &qga_DEVPKEY_Device_DriverVersion, &cm_type);
> > > +        if (version == NULL) {
> > > +            slog("failed to get driver version");
> > > +            continue;
> > > +        }
> > > +        device->driver_version = g_utf16_to_utf8(version, -1, NULL,
> > > +            NULL, NULL);
> > > +        if (device->driver_version == NULL) {
> > > +            error_setg(errp, "conversion to utf8 failed (driver
> > version)");
> > > +            continue;
> > > +        }
> > > +        device->has_driver_version = true;
> > > +
> > > +        date = (LPFILETIME)cm_get_property(dev_info_data.DevInst,
> > > +            &qga_DEVPKEY_Device_DriverDate, &cm_type);
> > > +        if (date == NULL) {
> > > +            slog("failed to get driver date");
> > > +            continue;
> > > +        }
> > > +        FileTimeToSystemTime(date, &utc_date);
> > > +        device->driver_date = g_strdup_printf("%04d-%02d-%02d",
> > > +            utc_date.wYear, utc_date.wMonth, utc_date.wDay);
> > > +        device->has_driver_date = true;
> > > +
> > > +        slog("driver: %s\ndriver version: %s,%s\n", device->driver_name,
> > > +            device->driver_date, device->driver_version);
> > > +        item = g_new0(GuestDeviceInfoList, 1);
> > > +        item->value = g_steal_pointer(&device);
> > > +        if (!cur_item) {
> > > +            head = cur_item = item;
> > > +        } else {
> > > +            cur_item->next = item;
> > > +            cur_item = item;
> > > +        }
> > > +        continue;
> > > +    }
> > > +
> > > +    if (dev_info != INVALID_HANDLE_VALUE) {
> > > +        SetupDiDestroyDeviceInfoList(dev_info);
> > > +    }
> > > +    return head;
> > > +}
> > > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> > > index fb4605cc19..92ed76c419 100644
> > > --- a/qga/qapi-schema.json
> > > +++ b/qga/qapi-schema.json
> > > @@ -1242,3 +1242,54 @@
> > >  ##
> > >  { 'command': 'guest-get-osinfo',
> > >    'returns': 'GuestOSInfo' }
> > > +
> > > +##
> > > +# @GuestDeviceAddressPCI:
> > > +#
> > > +# @vendor-id: vendor ID
> > > +# @device-id: device ID
> > > +#
> > > +# Since: 5.0
> > > +##
> > > +{ 'struct': 'GuestDeviceAddressPCI',
> > > +  'data': { 'vendor-id': 'uint16', 'device-id': 'uint16' } }
> > > +
> > > +##
> > > +# @GuestDeviceAddress:
> > > +#
> > > +# Address of the device
> > > +# - @pci: address of PCI device, since: 5.0
> > > +#
> > > +# Since: 5.0
> > > +##
> > > +{ 'union': 'GuestDeviceAddress',
> > > +  'data': { 'pci': 'GuestDeviceAddressPCI' } }
> > > +
> > > +##
> > > +# @GuestDeviceInfo:
> > > +#
> > > +# @driver-name: name of the associated driver
> > > +# @driver-date: driver release date in format YYYY-MM-DD
> > > +# @driver-version: driver version
> > > +#
> > > +# Since: 5.0
> > > +##
> > > +{ 'struct': 'GuestDeviceInfo',
> > > +  'data': {
> > > +      'driver-name': 'str',
> > > +      '*driver-date': 'str',
> > > +      '*driver-version': 'str',
> > > +      '*address': 'GuestDeviceAddress'
> > > +  } }
> > > +
> > > +##
> > > +# @guest-get-devices:
> > > +#
> > > +# Retrieve information about device drivers in Windows guest
> > > +#
> > > +# Returns: @GuestDeviceInfo
> > > +#
> > > +# Since: 5.0
> > > +##
> > > +{ 'command': 'guest-get-devices',
> > > +  'returns': ['GuestDeviceInfo'] }
> > > --
> > > 2.24.1
> > >
> >
> >
> > --
> > Tomáš Golembiovský <tgolembi@redhat.com>
> >
> >
> >
> 
> -- 
> Marc-André Lureau

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


