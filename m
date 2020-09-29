Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7EBC47420
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 15:35:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A34120773
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 15:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JahyZAP3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A34120773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNHeg-0003xK-Qz
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 11:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kNHbz-00026H-5a
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 11:32:15 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:44574)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kNHbw-00021H-Ec
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 11:32:14 -0400
Received: by mail-ej1-x642.google.com with SMTP id r7so15586496ejs.11
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 08:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ixpcx4AdjxZz+FqFUSFwICmjF8+SXaEN3XZaaSI+3Gk=;
 b=JahyZAP3WzRuSE7AUTK9l7R9ZCY/kBND8c2h5rwjc5yczDDXQ5kBia/2fNT5/oAfsU
 yWjQjKoSQw+fbnHDsqe5Kkbo1FSK9C6wcSKUuJYXdXEvIrSnjGUTlyMsHFdFuQSwyah4
 FDIuApKlThYEJFnj0BYAA8zSYbWYqXbf37Vm+adICB1prTkgK0XEH/efApYZF3UqssUC
 AZuZFcHZqOdWUPCkkOwwInb1p1H4EFf7FNMa1XUt49iF1WgrORh9kydT22Xl73LPECtg
 FZUB/8Augek6SUNMJKW3U5hBitGXvDrqV3TpVHIcU3auzJVLlsjd0JLcdv+lNN10UqHL
 /xSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ixpcx4AdjxZz+FqFUSFwICmjF8+SXaEN3XZaaSI+3Gk=;
 b=nl8wL+eK6vaPWKekyc4O8UH8T7bvi9YcYtNpuKSo/KufGEjEye++mp0qo5IJtLfeSa
 64hyADY9BvkbzDjjZ0LATXIBeJaNj2TJJKWNrLHjRjrTEDY8zJHemHpdnTdlmB7CQd7m
 TXukD7fXHtFM3sdiQkyAwWWzvSxMUj17Q+AzRom5hBJsZdcOgDnABAl4VsPMjLk3n+lI
 oVG9ocPDpryiRdI6R7D7QxiMbSyU1fWUalvKWjAEdF7ioF7rqEWiwYYPwkos+d3gC/IE
 r7pYc32Zs3bewNQk04OcUirQnavnCStf6XM4mlYrAOU2y3Y388oMzHJ5rAdMtpJ5hnH1
 5BEg==
X-Gm-Message-State: AOAM532WH6x4oJUjFSiqGaug+Tl/fxT1iYdMVLeq46R39UmApOOu16JV
 QHMh8mwTTZK97frYhOmNgNyvNM+RqMaeaSOPj54=
X-Google-Smtp-Source: ABdhPJzI5D8Ta5U+UE4eSgdLd5gy1gmXTc162C/3ZUHzc7cXUVtZX29xTjVBEG1mZ/b2wnRWtAp7TPWqujhpinmGFwo=
X-Received: by 2002:a17:906:a88a:: with SMTP id
 ha10mr4738526ejb.532.1601393528040; 
 Tue, 29 Sep 2020 08:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599470071.git.tgolembi@redhat.com>
 <2cd59ce454e0da02eeb75ab7461ef420b30864f5.1599470071.git.tgolembi@redhat.com>
In-Reply-To: <2cd59ce454e0da02eeb75ab7461ef420b30864f5.1599470071.git.tgolembi@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 29 Sep 2020 19:31:54 +0400
Message-ID: <CAJ+F1C+3EfX5N2ASeBy08zt_HianvCS=AtAEehbD3M=nU0OWvg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] qga: add implementation of guest-get-disks for
 Windows
To: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006273ea05b0757c29"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006273ea05b0757c29
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Sep 7, 2020 at 1:15 PM Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@=
redhat.com>
wrote:

> The command lists all the physical disk drives. Unlike for Linux
> partitions and virtual volumes are not listed.
>
> Example output:
>
> {
>   "return": [
>     {
>       "name": "\\\\.\\PhysicalDrive0",
>       "partition": false,
>       "address": {
>         "serial": "QM00001",
>         "bus-type": "sata",
>         ...
>       },
>       "slaves": []
>     }
>   ]
> }
>
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> ---
>  qga/commands-win32.c | 97 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 91 insertions(+), 6 deletions(-)
>
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index e9976a0c46..9ac847a187 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -945,6 +945,91 @@ out:
>      return list;
>  }
>
> +GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
> +{
> +    GuestDiskInfoList *new =3D NULL, *ret =3D NULL;
> +    HDEVINFO dev_info;
> +    SP_DEVICE_INTERFACE_DATA dev_iface_data;
> +    int i;
> +
> +    dev_info =3D SetupDiGetClassDevs(&GUID_DEVINTERFACE_DISK, 0, 0,
> +        DIGCF_PRESENT | DIGCF_DEVICEINTERFACE);
> +    if (dev_info =3D=3D INVALID_HANDLE_VALUE) {
> +        error_setg_win32(errp, GetLastError(), "failed to get device
> tree");
> +        return NULL;
> +    }
> +
> +    g_debug("enumerating devices");
> +    dev_iface_data.cbSize =3D sizeof(SP_DEVICE_INTERFACE_DATA);
> +    for (i =3D 0;
> +        SetupDiEnumDeviceInterfaces(dev_info, NULL,
> &GUID_DEVINTERFACE_DISK,
> +            i, &dev_iface_data);
> +        i++) {
> +        GuestDiskAddress *address =3D NULL;
> +        GuestDiskInfo *disk =3D NULL;
> +        Error *local_err =3D NULL;
> +        g_autofree PSP_DEVICE_INTERFACE_DETAIL_DATA
> +            pdev_iface_detail_data =3D NULL;
> +        STORAGE_DEVICE_NUMBER sdn;
> +        HANDLE dev_file;
> +        DWORD size =3D 0;
> +
> +        g_debug("  getting device path");
> +        while (!SetupDiGetDeviceInterfaceDetail(dev_info, &dev_iface_dat=
a,
> +                pdev_iface_detail_data,
> +                size, &size,
> +                NULL)) {
> +            if (GetLastError() =3D=3D ERROR_INSUFFICIENT_BUFFER) {
> +                pdev_iface_detail_data =3D g_malloc(size);
>

Since this is called in a loop, you should use g_realloc() to avoid
potential leaks.

+                pdev_iface_detail_data->cbSize =3D
> +                    sizeof(*pdev_iface_detail_data);
> +            } else {
> +                g_debug("failed to get device interface details");
> +                continue;
> +            }
> +        }
> +
> +        g_debug("  device: %s", pdev_iface_detail_data->DevicePath);
> +        dev_file =3D CreateFile(pdev_iface_detail_data->DevicePath, 0,
> +            FILE_SHARE_READ, NULL, OPEN_EXISTING, 0, NULL);
> +        if (!DeviceIoControl(dev_file, IOCTL_STORAGE_GET_DEVICE_NUMBER,
> +                NULL, 0, &sdn, sizeof(sdn), &size, NULL)) {
> +            CloseHandle(dev_file);
> +            debug_error("failed to get storage device number");
> +            continue;
> +        }
> +        CloseHandle(dev_file);
> +
> +        disk =3D g_new0(GuestDiskInfo, 1);
> +        disk->name =3D g_strdup_printf("\\\\.\\PhysicalDrive%lu",
> +            sdn.DeviceNumber);
> +
> +        g_debug("  number: %lu", sdn.DeviceNumber);
> +        address =3D g_malloc0(sizeof(GuestDiskAddress));
> +        address->has_dev =3D true;
> +        address->dev =3D g_strdup(disk->name);
> +        get_single_disk_info(sdn.DeviceNumber, address, &local_err);
> +        if (local_err) {
> +            g_debug("failed to get disk info: %s",
> +                error_get_pretty(local_err));
> +            error_free(local_err);
> +            qapi_free_GuestDiskAddress(address);
> +            address =3D NULL;
> +        } else {
> +            disk->address =3D address;
> +            disk->has_address =3D true;
> +        }
> +
> +        new =3D g_malloc0(sizeof(GuestDiskInfoList));
> +        new->value =3D disk;
> +        new->next =3D ret;
> +        ret =3D new;
> +    }
> +
> +    SetupDiDestroyDeviceInfoList(dev_info);
> +    return ret;
> +}
> +
>  #else
>
>  static GuestDiskAddressList *build_guest_disk_info(char *guid, Error
> **errp)
> @@ -952,6 +1037,12 @@ static GuestDiskAddressList
> *build_guest_disk_info(char *guid, Error **errp)
>      return NULL;
>  }
>
> +GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
> +{
> +    error_setg(errp, QERR_UNSUPPORTED);
> +    return NULL;
> +}
> +
>  #endif /* CONFIG_QGA_NTDDSCSI */
>
>  static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **errp)
> @@ -2229,9 +2320,3 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
>
>      return info;
>  }
> -
> -GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -    return NULL;
> -}
> --
> 2.25.0
>
>
>
The rest looks ok to me.

--=20
Marc-Andr=C3=A9 Lureau

--0000000000006273ea05b0757c29
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 7, 2020 at 1:15 PM Tom=
=C3=A1=C5=A1 Golembiovsk=C3=BD &lt;<a href=3D"mailto:tgolembi@redhat.com">t=
golembi@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">The command lists all the physical disk drives. Unlike fo=
r Linux<br>
partitions and virtual volumes are not listed.<br>
<br>
Example output:<br>
<br>
{<br>
=C2=A0 &quot;return&quot;: [<br>
=C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 &quot;name&quot;: &quot;\\\\.\\PhysicalDrive0&quot;,<b=
r>
=C2=A0 =C2=A0 =C2=A0 &quot;partition&quot;: false,<br>
=C2=A0 =C2=A0 =C2=A0 &quot;address&quot;: {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;serial&quot;: &quot;QM00001&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;bus-type&quot;: &quot;sata&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 &quot;slaves&quot;: []<br>
=C2=A0 =C2=A0 }<br>
=C2=A0 ]<br>
}<br>
<br>
Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD &lt;<a href=3D"mailto:tgol=
embi@redhat.com" target=3D"_blank">tgolembi@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-win32.c | 97 +++++++++++++++++++++++++++++++++++++++++--=
-<br>
=C2=A01 file changed, 91 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index e9976a0c46..9ac847a187 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -945,6 +945,91 @@ out:<br>
=C2=A0 =C2=A0 =C2=A0return list;<br>
=C2=A0}<br>
<br>
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 GuestDiskInfoList *new =3D NULL, *ret =3D NULL;<br>
+=C2=A0 =C2=A0 HDEVINFO dev_info;<br>
+=C2=A0 =C2=A0 SP_DEVICE_INTERFACE_DATA dev_iface_data;<br>
+=C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 dev_info =3D SetupDiGetClassDevs(&amp;GUID_DEVINTERFACE_DISK=
, 0, 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DIGCF_PRESENT | DIGCF_DEVICEINTERFACE);<br>
+=C2=A0 =C2=A0 if (dev_info =3D=3D INVALID_HANDLE_VALUE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, GetLastError(), &quot;f=
ailed to get device tree&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 g_debug(&quot;enumerating devices&quot;);<br>
+=C2=A0 =C2=A0 dev_iface_data.cbSize =3D sizeof(SP_DEVICE_INTERFACE_DATA);<=
br>
+=C2=A0 =C2=A0 for (i =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 SetupDiEnumDeviceInterfaces(dev_info, NULL, &a=
mp;GUID_DEVINTERFACE_DISK,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i, &amp;dev_iface_data);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestDiskAddress *address =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestDiskInfo *disk =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree PSP_DEVICE_INTERFACE_DETAIL_DATA<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pdev_iface_detail_data =3D NULL;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 STORAGE_DEVICE_NUMBER sdn;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 HANDLE dev_file;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DWORD size =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=A0 getting device path&quot;=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (!SetupDiGetDeviceInterfaceDetail(dev_in=
fo, &amp;dev_iface_data,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pdev_iface_detail_=
data,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size, &amp;size,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (GetLastError() =3D=3D ERROR_=
INSUFFICIENT_BUFFER) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pdev_iface_detail_=
data =3D g_malloc(size);<br></blockquote><div><br></div><div>Since this is =
called in a loop, you should use g_realloc() to avoid potential leaks.</div=
><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pdev_iface_detail_=
data-&gt;cbSize =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size=
of(*pdev_iface_detail_data);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;fail=
ed to get device interface details&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=A0 device: %s&quot;, pdev_if=
ace_detail_data-&gt;DevicePath);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_file =3D CreateFile(pdev_iface_detail_data=
-&gt;DevicePath, 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FILE_SHARE_READ, NULL, OPEN_EXIS=
TING, 0, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!DeviceIoControl(dev_file, IOCTL_STORAGE_G=
ET_DEVICE_NUMBER,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, 0, &amp;sdn,=
 sizeof(sdn), &amp;size, NULL)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CloseHandle(dev_file);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 debug_error(&quot;failed to get =
storage device number&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 CloseHandle(dev_file);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk =3D g_new0(GuestDiskInfo, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;name =3D g_strdup_printf(&quot;\\\\.\=
\PhysicalDrive%lu&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sdn.DeviceNumber);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=A0 number: %lu&quot;, sdn.De=
viceNumber);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 address =3D g_malloc0(sizeof(GuestDiskAddress)=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 address-&gt;has_dev =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 address-&gt;dev =3D g_strdup(disk-&gt;name);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_single_disk_info(sdn.DeviceNumber, address=
, &amp;local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (local_err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;failed to get disk=
 info: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_get_pretty(l=
ocal_err));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_free(local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qapi_free_GuestDiskAddress(addre=
ss);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 address =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;address =3D address;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;has_address =3D true;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 new =3D g_malloc0(sizeof(GuestDiskInfoList));<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 new-&gt;value =3D disk;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 new-&gt;next =3D ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D new;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 SetupDiDestroyDeviceInfoList(dev_info);<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
=C2=A0#else<br>
<br>
=C2=A0static GuestDiskAddressList *build_guest_disk_info(char *guid, Error =
**errp)<br>
@@ -952,6 +1037,12 @@ static GuestDiskAddressList *build_guest_disk_info(ch=
ar *guid, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0}<br>
<br>
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
+=C2=A0 =C2=A0 return NULL;<br>
+}<br>
+<br>
=C2=A0#endif /* CONFIG_QGA_NTDDSCSI */<br>
<br>
=C2=A0static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **er=
rp)<br>
@@ -2229,9 +2320,3 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0return info;<br>
=C2=A0}<br>
-<br>
-GuestDiskInfoList *qmp_guest_get_disks(Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
-=C2=A0 =C2=A0 return NULL;<br>
-}<br>
-- <br>
2.25.0<br>
<br>
<br>
</blockquote></div><div><br></div><div>The rest looks ok to me.<br></div><b=
r>-- <br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<=
br></div></div>

--0000000000006273ea05b0757c29--

