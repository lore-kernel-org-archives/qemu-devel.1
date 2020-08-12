Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EC2C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 21:31:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD11B20781
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 21:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Maxn4Xb7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD11B20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5yLP-0003lW-Qc
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 17:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1k5yJy-0002vE-TD
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 17:30:06 -0400
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42]:36692)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1k5yJw-0005mz-7s
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 17:30:06 -0400
Received: by mail-oo1-xc42.google.com with SMTP id y30so797670ooj.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 14:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:to:from:in-reply-to
 :cc:references:message-id:user-agent:subject:date;
 bh=f+Hq6gMTQTJg8hM6/0IWrmX0MD/7oabWptdeSpG5zgQ=;
 b=Maxn4Xb7i6yRXfutUx5Nhq0SdqARiPIeKBpZbZLxiN48P494lo1U5wD4r7ISBjOWPI
 e9vl5FewKy/EZ50JOyABoBR5Mb2R0YJipIi9adt0F2AtZjzYIEbWtQjXqNHE95ThxhJv
 C1lhS7qdlV1mQpPru1N63c6ozP8FjS0UA1JSKGspvsqx5uOc3/oMbkieuF2lKYg50+MJ
 BnXpg082+chrp2cmuU6rN4ibNq0EjQQa16NMDj02xO+5qjl3ZtJcct+yPGEBubaE3v3E
 0dqSEcpA5iuV/etOSpPbbm5YvN17m+ei2f0Bc66kbFJg8A4pd6huiI4CVlNL5OcYEXJS
 /2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding:to
 :from:in-reply-to:cc:references:message-id:user-agent:subject:date;
 bh=f+Hq6gMTQTJg8hM6/0IWrmX0MD/7oabWptdeSpG5zgQ=;
 b=aXijLU/m4cFdY/p0CkrwxI67qHKEUHVDF18nvDhDWCvfDEgC2jd0nfY70eJCB1wuvS
 ybgUobwfGj2/hcylYdHm0/hxC/n+tjqX3f1vzy2x6QPk0/35o4l9VUSlV2UArYUZenEa
 EfyyJ//fq9RecQ5jyvlPpiQYUIspnMQgiBaUZ344FlTuSHGXbKKvoT8O0wxukZOd0mfo
 D54GFdvJKJR2Xh5nGgfB7mbjggCxdc1Rnc0pdumGlqiF3vwoOiFC6aBEGmBt3blq/zVT
 MkcfbkqFYl9nuYpgRuDXfknI6Zg+tqkGQioRD0+lnt0L9KArLldBxUBxAEkELPZrhXqZ
 rfYQ==
X-Gm-Message-State: AOAM531azQ41Y/5Ve+E93PEQgC3KL1ynlP+Y2flAiLA8SzME18OfYJeP
 pJYK8JPJjgZn8Q48AA+eTf8=
X-Google-Smtp-Source: ABdhPJz5jspzX3VVXCvDcI8U07pTDoEBHQDQTyfKzpYpaMbVYKrjAWRl8TBr0B3dUaGbRCiQhye5MQ==
X-Received: by 2002:a4a:a80d:: with SMTP id o13mr1914509oom.12.1597267802629; 
 Wed, 12 Aug 2020 14:30:02 -0700 (PDT)
Received: from localhost ([2600:1700:70:e488:c561:7cf1:bb25:1bb5])
 by smtp.gmail.com with ESMTPSA id n74sm753869oig.54.2020.08.12.14.30.01
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Aug 2020 14:30:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: =?utf-8?b?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <c6994b4db0f59b487f235aca692ca3430317ea2b.1596704579.git.tgolembi@redhat.com>
References: <cover.1596704579.git.tgolembi@redhat.com>
 <c6994b4db0f59b487f235aca692ca3430317ea2b.1596704579.git.tgolembi@redhat.com>
Message-ID: <159726777861.7191.12429466315820157245@sif>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/1] qga: add command guest-get-disks
Date: Wed, 12 Aug 2020 16:29:38 -0500
Received-SPF: pass client-ip=2607:f8b0:4864:20::c42;
 envelope-from=flukshun@gmail.com; helo=mail-oo1-xc42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?utf-8?b?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quoting Tom=C3=A1=C5=A1 Golembiovsk=C3=BD (2020-08-06 04:03:06)
> The command guest-get-fsinfo can be used to list information about disks =
and
> partitions but it is limited only to mounted disks with filesystem. This =
new
> command allows listing information about attached root disks of the VM. T=
his is
> usefull for management applications for mapping virtualized devices or
> pass-through devices to device names in the guest OS.
> =

> Output is similar to the list of partitions of guest-get-fsinfo, except t=
hat
> the disks are mapped instead of partitions.
> =

> Example output:
> =

> {
>   "return": [
>     {
>       "serial": "SAMSUNG_123456789",
>       "bus-type": "sata",
>       "bus": 0,
>       "unit": 0,
>       "pci-controller": {
>         "bus": 0,
>         "slot": 31,
>         "domain": 0,
>         "function": 2
>       },
>       "dev": "/dev/sda",
>       "target": 0
>     },
>     ...
>   ]
> }
> =

> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> ---
>  qga/commands-posix.c | 91 +++++++++++++++++++++++++++++++++++++++++++-
>  qga/commands-win32.c | 83 ++++++++++++++++++++++++++++++++++++++++
>  qga/qapi-schema.json | 13 +++++++
>  3 files changed, 186 insertions(+), 1 deletion(-)
> =

> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 744c2b5a5d..4cebec96a6 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -62,6 +62,8 @@ extern char **environ;
>  #endif
>  #endif
> =

> +G_DEFINE_AUTOPTR_CLEANUP_FUNC(GuestFilesystemInfo, qapi_free_GuestFilesy=
stemInfo)
> +
>  static void ga_wait_child(pid_t pid, int *status, Error **errp)
>  {
>      pid_t rpid;
> @@ -1177,6 +1179,92 @@ static void build_guest_fsinfo_for_device(char con=
st *devpath,
>      free(syspath);
>  }
> =

> +GuestDiskAddressList *qmp_guest_get_disks(Error **errp)
> +{
> +    GuestDiskAddressList *item, *ret =3D NULL;
> +    DIR *dp =3D NULL;
> +    struct dirent *de =3D NULL;
> +
> +    g_debug("listing /sys/block directory");
> +    dp =3D opendir("/sys/block");
> +    if (dp =3D=3D NULL) {
> +        error_setg_errno(errp, errno, "Can't open directory \"/sys/block=
\"");
> +        return NULL;
> +    }
> +    while ((de =3D readdir(dp)) !=3D NULL) {
> +        g_autofree char *disk_dir =3D NULL, *line =3D NULL,
> +            *size_path =3D NULL, *slaves_dir =3D NULL;
> +        g_autoptr(GuestFilesystemInfo) fs =3D NULL;
> +        uint64_t slaves =3D 0;
> +        struct dirent *de_slaves;
> +        DIR *dp_slaves =3D NULL;
> +        FILE *fp =3D NULL;
> +        size_t n;
> +        Error *local_err =3D NULL;
> +        if (de->d_type !=3D DT_LNK) {
> +            g_debug("  skipping entry: %s", de->d_name);
> +            continue;
> +        }
> +
> +        slaves_dir =3D g_strdup_printf("/sys/block/%s/slaves", de->d_nam=
e);
> +        if (slaves_dir =3D=3D NULL) {
> +            g_debug("  failed to open directory %s", slaves_dir);
> +            continue;
> +        }
> +        g_debug("  counting entries in: %s", slaves_dir);
> +        dp_slaves =3D opendir(slaves_dir);
> +        while ((de_slaves =3D readdir(dp_slaves)) !=3D NULL) {
> +            if ((strcmp(".", de_slaves->d_name) =3D=3D 0) ||
> +                (strcmp("..", de_slaves->d_name) =3D=3D 0)) {
> +                continue;
> +            }
> +            slaves++;
> +        }
> +        closedir(dp_slaves);
> +        g_debug("    counted %lu items", slaves);
> +        if (slaves !=3D 0) {
> +            continue;
> +        }

For guest-get-fsinfo we skip returning any data about virtual devices
(dm/md/etc.) and just return the physical disks underlying whatever
hierarchy the filesystem is built on, which sort of makes sense as far
as making sure we know what devices are currently in use.

But for guest-get-disks we seem to care about usage beyond just mounted
filesystems, which to me would suggest things like whether a disk is
part of an LVM/RAID/multipath volume. But by skipping virtual devices
with "/sys/block/*/slaves" entries we lose that information...

So I guess I'm not sure I understand the use-cases you have in mind here.
Can you provide some examples? And do you anticipate we would need to add
an interface to report this hierarchy at some point?

> +
> +        g_debug("  checking disk size");
> +        size_path =3D g_strdup_printf("/sys/block/%s/size", de->d_name);
> +        fp =3D fopen(size_path, "r");
> +        if (!fp) {
> +            g_debug("  failed to read disk size");
> +            continue;
> +        }
> +        if (getline(&line, &n, fp) =3D=3D -1) {

We need to set n=3D0, otherwise an uninitialized value might be interpreted=
 as
the size of line's pre-allocated buffer

> +            g_debug("  failed to read disk size");
> +            fclose(fp);
> +            continue;
> +        }
> +        fclose(fp);
> +        if (strcmp(line, "0\n") =3D=3D 0) {
> +            g_debug("  skipping zero-sized disk");
> +            continue;
> +        }
> +
> +        fs =3D g_malloc0(sizeof(*fs));
> +        g_debug("  adding %s", de->d_name);
> +        disk_dir =3D g_strdup_printf("/sys/block/%s", de->d_name);
> +        build_guest_fsinfo_for_device(disk_dir, fs, &local_err);
> +        if (local_err !=3D NULL) {
> +            g_debug("  failed to get device info, ignoring error: %s",
> +                error_get_pretty(local_err));
> +            error_free(local_err);
> +            continue;
> +        } else if (fs->disk =3D=3D NULL) {
> +            g_debug("  skipping unknown disk");
> +            continue;
> +        }
> +        item =3D g_steal_pointer(&fs->disk);

Does this ensure that fs itself doesn't still get auto-free'd? In any
case, it seems awkward to allocate a GuestFilesystemInfo just so we can
re-use build_guest_fsinfo_for_device(). Can code be refactored into a
separate build_guest_disk_info_for_device() or something that just takes
a GuestDiskAddressList* directly?

> +        g_assert(item->next =3D=3D NULL); /* expecting just a single dis=
k */
> +        item->next =3D ret;
> +        ret =3D item;
> +    }
> +    return ret;
> +}
> +
>  /* Return a list of the disk device(s)' info which @mount lies on */
>  static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
>                                                 Error **errp)
> @@ -2809,7 +2897,8 @@ GList *ga_command_blacklist_init(GList *blacklist)
>          const char *list[] =3D {
>              "guest-get-fsinfo", "guest-fsfreeze-status",
>              "guest-fsfreeze-freeze", "guest-fsfreeze-freeze-list",
> -            "guest-fsfreeze-thaw", "guest-get-fsinfo", NULL};
> +            "guest-fsfreeze-thaw", "guest-get-fsinfo",
> +            "guest-get-disks", NULL};
>          char **p =3D (char **)list;
> =

>          while (*p) {
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index aaa71f147b..0bafa2dc4c 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -945,6 +945,83 @@ out:
>      return list;
>  }
> =

> +GuestDiskAddressList *qmp_guest_get_disks(Error **errp)
> +{
> +    GuestDiskAddressList *new =3D NULL, *ret =3D NULL;
> +    HDEVINFO dev_info;
> +    SP_DEVICE_INTERFACE_DATA dev_iface_data;
> +    int i;
> +
> +    dev_info =3D SetupDiGetClassDevs(&GUID_DEVINTERFACE_DISK, 0, 0,
> +        DIGCF_PRESENT | DIGCF_DEVICEINTERFACE);
> +    if (dev_info =3D=3D INVALID_HANDLE_VALUE) {
> +        error_setg_win32(errp, GetLastError(), "failed to get device tre=
e");
> +        return NULL;
> +    }
> +
> +    g_debug("enumerating devices");
> +    dev_iface_data.cbSize =3D sizeof(SP_DEVICE_INTERFACE_DATA);
> +    for (i =3D 0;
> +        SetupDiEnumDeviceInterfaces(dev_info, NULL, &GUID_DEVINTERFACE_D=
ISK,
> +            i, &dev_iface_data);
> +        i++) {
> +        GuestDiskAddress *disk =3D NULL;
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
> +                pdev_iface_detail_data->cbSize =3D
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
> +        g_debug("  number: %lu", sdn.DeviceNumber);
> +        disk =3D g_malloc0(sizeof(GuestDiskAddress));
> +        disk->has_dev =3D true;
> +        disk->dev =3D g_strdup_printf("\\\\.\\PhysicalDrive%lu",
> +            sdn.DeviceNumber);
> +        get_single_disk_info(sdn.DeviceNumber, disk, &local_err);
> +        if (local_err) {
> +            g_debug("failed to get disk info: %s",
> +                error_get_pretty(local_err));
> +            error_free(local_err);
> +            g_free(disk);
> +            continue;
> +        }
> +        new =3D g_malloc0(sizeof(GuestDiskAddressList));
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
> =

>  static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **e=
rrp)
> @@ -952,6 +1029,12 @@ static GuestDiskAddressList *build_guest_disk_info(=
char *guid, Error **errp)
>      return NULL;
>  }
> =

> +GuestDiskAddressList *qmp_guest_get_disks(Error **errp)
> +{
> +    error_setg(errp, QERR_UNSUPPORTED);
> +    return NULL;
> +}
> +
>  #endif /* CONFIG_QGA_NTDDSCSI */
> =

>  static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **errp)
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 408a662ea5..5d8fa1c283 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -862,6 +862,19 @@
>             'bus': 'int', 'target': 'int', 'unit': 'int',
>             '*serial': 'str', '*dev': 'str'} }
> =

> +##
> +# @guest-get-disks:
> +#
> +# Returns: The list of disks in the guest. For Windows these are only the
> +#          physical disks. On Linux these are all root block devices of
> +#          non-zero size including e.g. removable devices, loop devices,
> +#          NBD, etc.
> +#
> +# Since: 5.2
> +##
> +{ 'command': 'guest-get-disks',
> +  'returns': ['GuestDiskAddress'] }
> +
>  ##
>  # @GuestFilesystemInfo:
>  #
> -- =

> 2.25.0
>=20

