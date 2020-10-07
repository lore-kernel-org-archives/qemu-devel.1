Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF428C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:14:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAD782076C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlbHIrij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD782076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ4ax-0007c3-O1
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 04:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kQ4a3-00075W-Ju
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 04:13:47 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:38018)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kQ4Zy-0007MF-C0
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 04:13:47 -0400
Received: by mail-ed1-x541.google.com with SMTP id i5so1218631edr.5
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 01:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7f3KgsU0Q4crHxK8C7HRyxr/K2pqUeauIPZUkoagKtc=;
 b=rlbHIrijoQpsxGaHW5nyvdwEnrs4vww1eE7ZEXih5wrjh2BRNWleh24VaBKCdkmIJn
 cE6nF39CAr/y3fEFxPQ9rmsDKyl3Ah6pdMlIOfHwpBjbRdQzyn8cgGot/WYDFddDMnAJ
 87nwgQF5OkEd9RuJCw8z1uVQPMpntI77BWnS8xyaBdYdVDOdc4svXJhl1kLZVOl3DGiD
 BXqTsdHbs3y8puihXxwkJ/1wShA03LxDvf/nYq2w9l0biiWaG2G3dEU0a9WakbvtI283
 tzsLCotUGm4ETH3rGuQGuZcPWw4eFOh3ZqffxrD8/TjP8KJR2Ai1FVxauEn00YpxXiR6
 GM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7f3KgsU0Q4crHxK8C7HRyxr/K2pqUeauIPZUkoagKtc=;
 b=rHFZvVrDtNZ6br3oCk2PmVZfHFucz9YPrPzvyi1mP+3X/GgMRBfMC09hdpoU7bQ12w
 jmpPNUFDOAdknE8HjYUCE11/Fqa5xqv8orylrRgYN1negOBmHbL5YQYnd/Gg31Q0j8jB
 M+mWZjk7ddOoeNKkPcwBcjwF/RwsUfggSE+8naKlhuUd+3vr276cydidPtkiCyuttM0M
 d9tpojUnnKSneaHrK+pra8QEvqHxpHl9v2THxgZQJ9yX7ekkXAKx7t8Yt5MubM8AXGDt
 +DwerzBMuRpDYWZU38IT/WheZWN7SCStKRAJW4H6hEuLpCygJiN6H4QrYSYFQv0bxz14
 LXWg==
X-Gm-Message-State: AOAM532vxksZ4jA2snRYHmHx8xzSHKE/85vHRhZ3jtLH8VREb7y93Jjs
 OEDGc+CK0lBzhwMiEzY8xMWPoFeuWWPI7NM7pSI=
X-Google-Smtp-Source: ABdhPJxu3iXhBuzj54lyrOyYeLUxY/HtjIg51ssjnP6khCshbyBD6+PhraO6w6qQ+4D6Nc21dbS9sa9TCrYZrNdT4yc=
X-Received: by 2002:a05:6402:d6:: with SMTP id
 i22mr2267235edu.53.1602058418002; 
 Wed, 07 Oct 2020 01:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602056784.git.tgolembi@redhat.com>
 <2d80f5dc64cadd1ba87af9d8ec7a8161bd8a5e74.1602056784.git.tgolembi@redhat.com>
In-Reply-To: <2d80f5dc64cadd1ba87af9d8ec7a8161bd8a5e74.1602056784.git.tgolembi@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 7 Oct 2020 12:13:26 +0400
Message-ID: <CAJ+F1CKZf2jEKSZX+Kd=SfKm3JmxX0EUof3GyZ-fQNYsHN5eww@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] qga: add implementation of guest-get-disks for
 Linux
To: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ea22e905b1104a0e"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x541.google.com
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ea22e905b1104a0e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2020 at 11:46 AM Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi=
@redhat.com>
wrote:

> The command lists all disks (real and virtual) as well as disk
> partitions. For each disk the list of dependent disks is also listed and
> /dev path is used as a handle so it can be matched with "name" field of
> other returned disk entries. For disk partitions the "dependents" list
> is populated with the the parent device for easier tracking of
> hierarchy.
>
> Example output:
> {
>   "return": [
>     ...
>     {
>       "name": "/dev/dm-0",
>       "partition": false,
>       "dependents": [
>         "/dev/sda2"
>       ],
>       "alias": "luks-7062202e-5b9b-433e-81e8-6628c40da9f7"
>     },
>     {
>       "name": "/dev/sda2",
>       "partition": true,
>       "dependents": [
>         "/dev/sda"
>       ]
>     },
>     {
>       "name": "/dev/sda",
>       "partition": false,
>       "address": {
>         "serial": "SAMSUNG_MZ7LN512HCHP-000L1_S1ZKNXAG822493",
>         "bus-type": "sata",
>         ...
>         "dev": "/dev/sda",
>         "target": 0
>       },
>       "dependents": []
>     },
>     ...
>   ]
> }
>
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> ---
>  qga/commands-posix.c | 293 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 284 insertions(+), 9 deletions(-)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 422144bcff..b0ec1223c9 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -1150,12 +1150,25 @@ static void
> build_guest_fsinfo_for_virtual_device(char const *syspath,
>      closedir(dir);
>  }
>
> +static bool is_disk_virtual(const char *devpath, Error **errp)
> +{
> +    g_autofree char *syspath =3D realpath(devpath, NULL);
> +
> +    if (!syspath) {
> +        error_setg_errno(errp, errno, "realpath(\"%s\")", devpath);
> +        return false;
> +    }
> +    return strstr(syspath, "/devices/virtual/block/") !=3D NULL;
> +}
> +
>  /* Dispatch to functions for virtual/real device */
>  static void build_guest_fsinfo_for_device(char const *devpath,
>                                            GuestFilesystemInfo *fs,
>                                            Error **errp)
>  {
> +    ERRP_GUARD();
>      char *syspath =3D realpath(devpath, NULL);
> +    bool is_virtual =3D false;
>
>      if (!syspath) {
>          error_setg_errno(errp, errno, "realpath(\"%s\")", devpath);
> @@ -1167,8 +1180,11 @@ static void build_guest_fsinfo_for_device(char
> const *devpath,
>      }
>
>      g_debug("  parse sysfs path '%s'", syspath);
> -
> -    if (strstr(syspath, "/devices/virtual/block/")) {
> +    is_virtual =3D is_disk_virtual(syspath, errp);
> +    if (*errp !=3D NULL) {
>

I think it's leaking syspath.

+        return;
> +    }
> +    if (is_virtual) {
>          build_guest_fsinfo_for_virtual_device(syspath, fs, errp);
>      } else {
>          build_guest_fsinfo_for_real_device(syspath, fs, errp);
> @@ -1177,6 +1193,270 @@ static void build_guest_fsinfo_for_device(char
> const *devpath,
>      free(syspath);
>  }
>
> +#ifdef CONFIG_LIBUDEV
> +
> +/*
> + * Wrapper around build_guest_fsinfo_for_device() for getting just
> + * the disk address.
> + */
> +static GuestDiskAddress *get_disk_address(const char *syspath, Error
> **errp)
> +{
> +    g_autoptr(GuestFilesystemInfo) fs =3D NULL;
> +
> +    fs =3D g_new0(GuestFilesystemInfo, 1);
> +    build_guest_fsinfo_for_device(syspath, fs, errp);
> +    if (fs->disk !=3D NULL) {
> +        return g_steal_pointer(&fs->disk->value);
> +    }
> +    return NULL;
> +}
> +
> +static char *get_alias_for_syspath(const char *syspath)
> +{
> +    struct udev *udev =3D NULL;
> +    struct udev_device *udevice =3D NULL;
> +    char *ret =3D NULL;
> +
> +    udev =3D udev_new();
> +    if (udev =3D=3D NULL) {
> +        g_debug("failed to query udev");
> +        goto out;
> +    }
> +    udevice =3D udev_device_new_from_syspath(udev, syspath);
> +    if (udevice =3D=3D NULL) {
> +        g_debug("failed to query udev for path: %s", syspath);
> +        goto out;
> +    } else {
> +        const char *alias =3D udev_device_get_property_value(
> +            udevice, "DM_NAME");
> +        /*
> +         * NULL means there was an error and empty string means there is
> no
> +         * alias. In case of no alias we return NULL instead of empty
> string.
> +         */
> +        if (alias =3D=3D NULL) {
> +            g_debug("failed to query udev for device alias for: %s",
> +                syspath);
> +        } else if (*alias !=3D 0) {
> +            ret =3D g_strdup(alias);
> +        }
> +    }
> +
> +out:
> +    udev_unref(udev);
> +    udev_device_unref(udevice);
> +    return ret;
> +}
> +
> +static char *get_device_for_syspath(const char *syspath)
> +{
> +    struct udev *udev =3D NULL;
> +    struct udev_device *udevice =3D NULL;
> +    char *ret =3D NULL;
> +
> +    udev =3D udev_new();
> +    if (udev =3D=3D NULL) {
> +        g_debug("failed to query udev");
> +        goto out;
> +    }
> +    udevice =3D udev_device_new_from_syspath(udev, syspath);
> +    if (udevice =3D=3D NULL) {
> +        g_debug("failed to query udev for path: %s", syspath);
> +        goto out;
> +    } else {
> +        ret =3D g_strdup(udev_device_get_devnode(udevice));
> +    }
> +
> +out:
> +    udev_unref(udev);
> +    udev_device_unref(udevice);
> +    return ret;
> +}
> +
> +static void get_disk_deps(const char *disk_dir, GuestDiskInfo *disk)
> +{
> +    g_autofree char *deps_dir =3D NULL;
> +    const gchar *dep;
> +    GDir *dp_deps =3D NULL;
> +
> +    /* List dependent disks */
> +    deps_dir =3D g_strdup_printf("%s/slaves", disk_dir);
> +    g_debug("  listing entries in: %s", deps_dir);
> +    dp_deps =3D g_dir_open(deps_dir, 0, NULL);
> +    if (dp_deps =3D=3D NULL) {
> +        g_debug("failed to list entries in %s", deps_dir);
> +        return;
> +    }
> +    while ((dep =3D g_dir_read_name(dp_deps)) !=3D NULL) {
> +        g_autofree char *dep_dir =3D NULL;
> +        strList *dep_item =3D NULL;
> +        char *dev_name;
> +
> +        /* Add dependent disks */
> +        dep_dir =3D g_strdup_printf("%s/%s", deps_dir, dep);
> +        dev_name =3D get_device_for_syspath(dep_dir);
> +        if (dev_name !=3D NULL) {
> +            g_debug("  adding dependent device: %s", dev_name);
> +            dep_item =3D g_new0(strList, 1);
> +            dep_item->value =3D dev_name;
> +            dep_item->next =3D disk->dependents;
> +            disk->dependents =3D dep_item;
> +        }
> +    }
> +    g_dir_close(dp_deps);
> +}
> +
> +/*
> + * Detect partitions subdirectory, name is "<disk_name><number>" or
> + * "<disk_name>p<number>"
> + *
> + * @disk_name -- last component of /sys path (e.g. sda)
> + * @disk_dir -- sys path of the disk (e.g. /sys/block/sda)
> + * @disk_dev -- device node of the disk (e.g. /dev/sda)
> + */
> +static GuestDiskInfoList *get_disk_partitions(
> +    GuestDiskInfoList *list,
> +    const char *disk_name, const char *disk_dir,
> +    const char *disk_dev)
> +{
> +    GuestDiskInfoList *item, *ret =3D list;
> +    struct dirent *de_disk;
> +    DIR *dp_disk =3D NULL;
> +    size_t len =3D strlen(disk_name);
> +
> +    dp_disk =3D opendir(disk_dir);
> +    while ((de_disk =3D readdir(dp_disk)) !=3D NULL) {
> +        g_autofree char *partition_dir =3D NULL;
> +        char *dev_name;
> +        GuestDiskInfo *partition;
> +
> +        if (!(de_disk->d_type & DT_DIR)) {
> +            continue;
> +        }
> +
> +        if (!(strncmp(disk_name, de_disk->d_name, len) =3D=3D 0 &&
> +            ((*(de_disk->d_name + len) =3D=3D 'p' &&
> +            isdigit(*(de_disk->d_name + len + 1))) ||
> +                isdigit(*(de_disk->d_name + len))))) {
> +            continue;
> +        }
> +
> +        partition_dir =3D g_strdup_printf("%s/%s",
> +            disk_dir, de_disk->d_name);
> +        dev_name =3D get_device_for_syspath(partition_dir);
> +        if (dev_name =3D=3D NULL) {
> +            g_debug("Failed to get device name for syspath: %s",
> +                disk_dir);
> +            continue;
> +        }
> +        partition =3D g_new0(GuestDiskInfo, 1);
> +        partition->name =3D dev_name;
> +        partition->partition =3D true;
> +        /* Add parent disk as dependent for easier tracking of hierarchy
> */
> +        partition->dependents =3D g_new0(strList, 1);
> +        partition->dependents->value =3D g_strdup(disk_dev);
> +
> +        item =3D g_new0(GuestDiskInfoList, 1);
> +        item->value =3D partition;
> +        item->next =3D ret;
> +        ret =3D item;
> +
> +    }
> +    closedir(dp_disk);
> +
> +    return ret;
> +}
> +
> +GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
> +{
> +    GuestDiskInfoList *item, *ret =3D NULL;
> +    GuestDiskInfo *disk;
> +    DIR *dp =3D NULL;
> +    struct dirent *de =3D NULL;
> +
> +    g_debug("listing /sys/block directory");
> +    dp =3D opendir("/sys/block");
> +    if (dp =3D=3D NULL) {
> +        error_setg_errno(errp, errno, "Can't open directory
> \"/sys/block\"");
> +        return NULL;
> +    }
> +    while ((de =3D readdir(dp)) !=3D NULL) {
> +        g_autofree char *disk_dir =3D NULL, *line =3D NULL,
> +            *size_path =3D NULL, *deps_dir =3D NULL;
> +        char *dev_name;
> +        Error *local_err =3D NULL;
> +        if (de->d_type !=3D DT_LNK) {
> +            g_debug("  skipping entry: %s", de->d_name);
> +            continue;
> +        }
> +
> +        /* Check size and skip zero-sized disks */
> +        g_debug("  checking disk size");
> +        size_path =3D g_strdup_printf("/sys/block/%s/size", de->d_name);
> +        if (!g_file_get_contents(size_path, &line, NULL, NULL)) {
> +            g_debug("  failed to read disk size");
> +            continue;
> +        }
> +        if (g_strcmp0(line, "0\n") =3D=3D 0) {
> +            g_debug("  skipping zero-sized disk");
> +            continue;
> +        }
> +
> +        g_debug("  adding %s", de->d_name);
> +        disk_dir =3D g_strdup_printf("/sys/block/%s", de->d_name);
> +        dev_name =3D get_device_for_syspath(disk_dir);
> +        if (dev_name =3D=3D NULL) {
> +            g_debug("Failed to get device name for syspath: %s",
> +                disk_dir);
> +            continue;
> +        }
> +        disk =3D g_new0(GuestDiskInfo, 1);
> +        disk->name =3D dev_name;
> +        disk->partition =3D false;
> +        disk->alias =3D get_alias_for_syspath(disk_dir);
> +        disk->has_alias =3D (disk->alias !=3D NULL);
> +        item =3D g_new0(GuestDiskInfoList, 1);
> +        item->value =3D disk;
> +        item->next =3D ret;
> +        ret =3D item;
> +
> +        /* Get address for non-virtual devices */
> +        bool is_virtual =3D is_disk_virtual(disk_dir, &local_err);
> +        if (local_err !=3D NULL) {
> +            g_debug("  failed to check disk path, ignoring error: %s",
> +                error_get_pretty(local_err));
> +            error_free(local_err);
> +            local_err =3D NULL;
> +            /* Don't try to get the address */
> +            is_virtual =3D true;
> +        }
> +        if (!is_virtual) {
> +            disk->address =3D get_disk_address(disk_dir, &local_err);
> +            if (local_err !=3D NULL) {
> +                g_debug("  failed to get device info, ignoring error: %s=
",
> +                    error_get_pretty(local_err));
> +                error_free(local_err);
> +                local_err =3D NULL;
> +            } else if (disk->address !=3D NULL) {
> +                disk->has_address =3D true;
> +            }
> +        }
> +
> +        get_disk_deps(disk_dir, disk);
> +        ret =3D get_disk_partitions(ret, de->d_name, disk_dir, dev_name)=
;
> +    }
> +    return ret;
> +}
> +
> +#else
> +
> +GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
> +{
> +    error_setg(errp, QERR_UNSUPPORTED);
> +    return NULL;
> +}
> +
> +#endif
> +
>  /* Return a list of the disk device(s)' info which @mount lies on */
>  static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
>                                                 Error **errp)
> @@ -2809,7 +3089,8 @@ GList *ga_command_blacklist_init(GList *blacklist)
>          const char *list[] =3D {
>              "guest-get-fsinfo", "guest-fsfreeze-status",
>              "guest-fsfreeze-freeze", "guest-fsfreeze-freeze-list",
> -            "guest-fsfreeze-thaw", "guest-get-fsinfo", NULL};
> +            "guest-fsfreeze-thaw", "guest-get-fsinfo",
> +            "guest-get-disks", NULL};
>          char **p =3D (char **)list;
>
>          while (*p) {
> @@ -3051,9 +3332,3 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error
> **errp)
>
>      return NULL;
>  }
> -
> -GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
> -{
> -    error_setg(errp, QERR_UNSUPPORTED);
> -    return NULL;
> -}
> --
> 2.28.0
>
>
lgtm otherwise

--=20
Marc-Andr=C3=A9 Lureau

--000000000000ea22e905b1104a0e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 7, 2020 at 11:46 AM Tom=
=C3=A1=C5=A1 Golembiovsk=C3=BD &lt;<a href=3D"mailto:tgolembi@redhat.com">t=
golembi@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">The command lists all disks (real and virtual) as well as=
 disk<br>
partitions. For each disk the list of dependent disks is also listed and<br=
>
/dev path is used as a handle so it can be matched with &quot;name&quot; fi=
eld of<br>
other returned disk entries. For disk partitions the &quot;dependents&quot;=
 list<br>
is populated with the the parent device for easier tracking of<br>
hierarchy.<br>
<br>
Example output:<br>
{<br>
=C2=A0 &quot;return&quot;: [<br>
=C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 &quot;name&quot;: &quot;/dev/dm-0&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 &quot;partition&quot;: false,<br>
=C2=A0 =C2=A0 =C2=A0 &quot;dependents&quot;: [<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;/dev/sda2&quot;<br>
=C2=A0 =C2=A0 =C2=A0 ],<br>
=C2=A0 =C2=A0 =C2=A0 &quot;alias&quot;: &quot;luks-7062202e-5b9b-433e-81e8-=
6628c40da9f7&quot;<br>
=C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 &quot;name&quot;: &quot;/dev/sda2&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 &quot;partition&quot;: true,<br>
=C2=A0 =C2=A0 =C2=A0 &quot;dependents&quot;: [<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;/dev/sda&quot;<br>
=C2=A0 =C2=A0 =C2=A0 ]<br>
=C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 &quot;name&quot;: &quot;/dev/sda&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 &quot;partition&quot;: false,<br>
=C2=A0 =C2=A0 =C2=A0 &quot;address&quot;: {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;serial&quot;: &quot;SAMSUNG_MZ7LN512HCHP-=
000L1_S1ZKNXAG822493&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;bus-type&quot;: &quot;sata&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;dev&quot;: &quot;/dev/sda&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;target&quot;: 0<br>
=C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 &quot;dependents&quot;: []<br>
=C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 ...<br>
=C2=A0 ]<br>
}<br>
<br>
Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD &lt;<a href=3D"mailto:tgol=
embi@redhat.com" target=3D"_blank">tgolembi@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-posix.c | 293 +++++++++++++++++++++++++++++++++++++++++-=
-<br>
=C2=A01 file changed, 284 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index 422144bcff..b0ec1223c9 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -1150,12 +1150,25 @@ static void build_guest_fsinfo_for_virtual_device(c=
har const *syspath,<br>
=C2=A0 =C2=A0 =C2=A0closedir(dir);<br>
=C2=A0}<br>
<br>
+static bool is_disk_virtual(const char *devpath, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 g_autofree char *syspath =3D realpath(devpath, NULL);<br>
+<br>
+=C2=A0 =C2=A0 if (!syspath) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;realpath(\=
&quot;%s\&quot;)&quot;, devpath);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return strstr(syspath, &quot;/devices/virtual/block/&quot;) =
!=3D NULL;<br>
+}<br>
+<br>
=C2=A0/* Dispatch to functions for virtual/real device */<br>
=C2=A0static void build_guest_fsinfo_for_device(char const *devpath,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0GuestFilesystemInfo *fs,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0Error **errp)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 ERRP_GUARD();<br>
=C2=A0 =C2=A0 =C2=A0char *syspath =3D realpath(devpath, NULL);<br>
+=C2=A0 =C2=A0 bool is_virtual =3D false;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!syspath) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg_errno(errp, errno, &quot;realp=
ath(\&quot;%s\&quot;)&quot;, devpath);<br>
@@ -1167,8 +1180,11 @@ static void build_guest_fsinfo_for_device(char const=
 *devpath,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_debug(&quot;=C2=A0 parse sysfs path &#39;%s&#39;&quot=
;, syspath);<br>
-<br>
-=C2=A0 =C2=A0 if (strstr(syspath, &quot;/devices/virtual/block/&quot;)) {<=
br>
+=C2=A0 =C2=A0 is_virtual =3D is_disk_virtual(syspath, errp);<br>
+=C2=A0 =C2=A0 if (*errp !=3D NULL) {<br></blockquote><div><br></div><div>I=
 think it&#39;s leaking syspath.</div><div><br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (is_virtual) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0build_guest_fsinfo_for_virtual_device(sys=
path, fs, errp);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0build_guest_fsinfo_for_real_device(syspat=
h, fs, errp);<br>
@@ -1177,6 +1193,270 @@ static void build_guest_fsinfo_for_device(char cons=
t *devpath,<br>
=C2=A0 =C2=A0 =C2=A0free(syspath);<br>
=C2=A0}<br>
<br>
+#ifdef CONFIG_LIBUDEV<br>
+<br>
+/*<br>
+ * Wrapper around build_guest_fsinfo_for_device() for getting just<br>
+ * the disk address.<br>
+ */<br>
+static GuestDiskAddress *get_disk_address(const char *syspath, Error **err=
p)<br>
+{<br>
+=C2=A0 =C2=A0 g_autoptr(GuestFilesystemInfo) fs =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 fs =3D g_new0(GuestFilesystemInfo, 1);<br>
+=C2=A0 =C2=A0 build_guest_fsinfo_for_device(syspath, fs, errp);<br>
+=C2=A0 =C2=A0 if (fs-&gt;disk !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return g_steal_pointer(&amp;fs-&gt;disk-&gt;va=
lue);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return NULL;<br>
+}<br>
+<br>
+static char *get_alias_for_syspath(const char *syspath)<br>
+{<br>
+=C2=A0 =C2=A0 struct udev *udev =3D NULL;<br>
+=C2=A0 =C2=A0 struct udev_device *udevice =3D NULL;<br>
+=C2=A0 =C2=A0 char *ret =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 udev =3D udev_new();<br>
+=C2=A0 =C2=A0 if (udev =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;failed to query udev&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 udevice =3D udev_device_new_from_syspath(udev, syspath);<br>
+=C2=A0 =C2=A0 if (udevice =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;failed to query udev for path: %=
s&quot;, syspath);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *alias =3D udev_device_get_property=
_value(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 udevice, &quot;DM_NAME&quot;);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* NULL means there was an error and empt=
y string means there is no<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* alias. In case of no alias we return N=
ULL instead of empty string.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (alias =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;failed to query ud=
ev for device alias for: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 syspath);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (*alias !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D g_strdup(alias);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+out:<br>
+=C2=A0 =C2=A0 udev_unref(udev);<br>
+=C2=A0 =C2=A0 udev_device_unref(udevice);<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+static char *get_device_for_syspath(const char *syspath)<br>
+{<br>
+=C2=A0 =C2=A0 struct udev *udev =3D NULL;<br>
+=C2=A0 =C2=A0 struct udev_device *udevice =3D NULL;<br>
+=C2=A0 =C2=A0 char *ret =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 udev =3D udev_new();<br>
+=C2=A0 =C2=A0 if (udev =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;failed to query udev&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 udevice =3D udev_device_new_from_syspath(udev, syspath);<br>
+=C2=A0 =C2=A0 if (udevice =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;failed to query udev for path: %=
s&quot;, syspath);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D g_strdup(udev_device_get_devnode(udevi=
ce));<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+out:<br>
+=C2=A0 =C2=A0 udev_unref(udev);<br>
+=C2=A0 =C2=A0 udev_device_unref(udevice);<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+static void get_disk_deps(const char *disk_dir, GuestDiskInfo *disk)<br>
+{<br>
+=C2=A0 =C2=A0 g_autofree char *deps_dir =3D NULL;<br>
+=C2=A0 =C2=A0 const gchar *dep;<br>
+=C2=A0 =C2=A0 GDir *dp_deps =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 /* List dependent disks */<br>
+=C2=A0 =C2=A0 deps_dir =3D g_strdup_printf(&quot;%s/slaves&quot;, disk_dir=
);<br>
+=C2=A0 =C2=A0 g_debug(&quot;=C2=A0 listing entries in: %s&quot;, deps_dir)=
;<br>
+=C2=A0 =C2=A0 dp_deps =3D g_dir_open(deps_dir, 0, NULL);<br>
+=C2=A0 =C2=A0 if (dp_deps =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;failed to list entries in %s&quo=
t;, deps_dir);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 while ((dep =3D g_dir_read_name(dp_deps)) !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *dep_dir =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 strList *dep_item =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *dev_name;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Add dependent disks */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dep_dir =3D g_strdup_printf(&quot;%s/%s&quot;,=
 deps_dir, dep);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_name =3D get_device_for_syspath(dep_dir);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dev_name !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=A0 adding depe=
ndent device: %s&quot;, dev_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dep_item =3D g_new0(strList, 1);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dep_item-&gt;value =3D dev_name;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dep_item-&gt;next =3D disk-&gt;d=
ependents;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;dependents =3D dep_item=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 g_dir_close(dp_deps);<br>
+}<br>
+<br>
+/*<br>
+ * Detect partitions subdirectory, name is &quot;&lt;disk_name&gt;&lt;numb=
er&gt;&quot; or<br>
+ * &quot;&lt;disk_name&gt;p&lt;number&gt;&quot;<br>
+ *<br>
+ * @disk_name -- last component of /sys path (e.g. sda)<br>
+ * @disk_dir -- sys path of the disk (e.g. /sys/block/sda)<br>
+ * @disk_dev -- device node of the disk (e.g. /dev/sda)<br>
+ */<br>
+static GuestDiskInfoList *get_disk_partitions(<br>
+=C2=A0 =C2=A0 GuestDiskInfoList *list,<br>
+=C2=A0 =C2=A0 const char *disk_name, const char *disk_dir,<br>
+=C2=A0 =C2=A0 const char *disk_dev)<br>
+{<br>
+=C2=A0 =C2=A0 GuestDiskInfoList *item, *ret =3D list;<br>
+=C2=A0 =C2=A0 struct dirent *de_disk;<br>
+=C2=A0 =C2=A0 DIR *dp_disk =3D NULL;<br>
+=C2=A0 =C2=A0 size_t len =3D strlen(disk_name);<br>
+<br>
+=C2=A0 =C2=A0 dp_disk =3D opendir(disk_dir);<br>
+=C2=A0 =C2=A0 while ((de_disk =3D readdir(dp_disk)) !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *partition_dir =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *dev_name;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestDiskInfo *partition;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(de_disk-&gt;d_type &amp; DT_DIR)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(strncmp(disk_name, de_disk-&gt;d_name, l=
en) =3D=3D 0 &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((*(de_disk-&gt;d_name + len) =
=3D=3D &#39;p&#39; &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 isdigit(*(de_disk-&gt;d_name + l=
en + 1))) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 isdigit(*(de_disk-=
&gt;d_name + len))))) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 partition_dir =3D g_strdup_printf(&quot;%s/%s&=
quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk_dir, de_disk-&gt;d_name);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_name =3D get_device_for_syspath(partition_=
dir);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dev_name =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;Failed to get devi=
ce name for syspath: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk_dir);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 partition =3D g_new0(GuestDiskInfo, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 partition-&gt;name =3D dev_name;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 partition-&gt;partition =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Add parent disk as dependent for easier tra=
cking of hierarchy */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 partition-&gt;dependents =3D g_new0(strList, 1=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 partition-&gt;dependents-&gt;value =3D g_strdu=
p(disk_dev);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 item =3D g_new0(GuestDiskInfoList, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 item-&gt;value =3D partition;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 item-&gt;next =3D ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D item;<br>
+<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 closedir(dp_disk);<br>
+<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 GuestDiskInfoList *item, *ret =3D NULL;<br>
+=C2=A0 =C2=A0 GuestDiskInfo *disk;<br>
+=C2=A0 =C2=A0 DIR *dp =3D NULL;<br>
+=C2=A0 =C2=A0 struct dirent *de =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 g_debug(&quot;listing /sys/block directory&quot;);<br>
+=C2=A0 =C2=A0 dp =3D opendir(&quot;/sys/block&quot;);<br>
+=C2=A0 =C2=A0 if (dp =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;Can&#39;t =
open directory \&quot;/sys/block\&quot;&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 while ((de =3D readdir(dp)) !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *disk_dir =3D NULL, *line =3D =
NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *size_path =3D NULL, *deps_dir =
=3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *dev_name;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (de-&gt;d_type !=3D DT_LNK) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=A0 skipping en=
try: %s&quot;, de-&gt;d_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check size and skip zero-sized disks */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=A0 checking disk size&quot;)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_path =3D g_strdup_printf(&quot;/sys/block=
/%s/size&quot;, de-&gt;d_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!g_file_get_contents(size_path, &amp;line,=
 NULL, NULL)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=A0 failed to r=
ead disk size&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_strcmp0(line, &quot;0\n&quot;) =3D=3D 0)=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=A0 skipping ze=
ro-sized disk&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=A0 adding %s&quot;, de-&gt;d=
_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk_dir =3D g_strdup_printf(&quot;/sys/block/=
%s&quot;, de-&gt;d_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_name =3D get_device_for_syspath(disk_dir);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dev_name =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;Failed to get devi=
ce name for syspath: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk_dir);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk =3D g_new0(GuestDiskInfo, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;name =3D dev_name;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;partition =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;alias =3D get_alias_for_syspath(disk_=
dir);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;has_alias =3D (disk-&gt;alias !=3D NU=
LL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 item =3D g_new0(GuestDiskInfoList, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 item-&gt;value =3D disk;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 item-&gt;next =3D ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D item;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Get address for non-virtual devices */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool is_virtual =3D is_disk_virtual(disk_dir, =
&amp;local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (local_err !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=A0 failed to c=
heck disk path, ignoring error: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_get_pretty(l=
ocal_err));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_free(local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 local_err =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Don&#39;t try to get the addr=
ess */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_virtual =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!is_virtual) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;address =3D get_disk_ad=
dress(disk_dir, &amp;local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (local_err !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=
=A0 failed to get device info, ignoring error: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 erro=
r_get_pretty(local_err));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_free(local_e=
rr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 local_err =3D NULL=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (disk-&gt;address !=3D=
 NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;has_addre=
ss =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_disk_deps(disk_dir, disk);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_disk_partitions(ret, de-&gt;d_name=
, disk_dir, dev_name);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+#else<br>
+<br>
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
+=C2=A0 =C2=A0 return NULL;<br>
+}<br>
+<br>
+#endif<br>
+<br>
=C2=A0/* Return a list of the disk device(s)&#39; info which @mount lies on=
 */<br>
=C2=A0static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
@@ -2809,7 +3089,8 @@ GList *ga_command_blacklist_init(GList *blacklist)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *list[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;guest-get-fsinfo&quot=
;, &quot;guest-fsfreeze-status&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;guest-fsfreeze-freeze=
&quot;, &quot;guest-fsfreeze-freeze-list&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-fsfreeze-thaw&quot;,=
 &quot;guest-get-fsinfo&quot;, NULL};<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-fsfreeze-thaw&quot;,=
 &quot;guest-get-fsinfo&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;guest-get-disks&quot;, NUL=
L};<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char **p =3D (char **)list;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (*p) {<br>
@@ -3051,9 +3332,3 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **er=
rp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0}<br>
-<br>
-GuestDiskInfoList *qmp_guest_get_disks(Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
-=C2=A0 =C2=A0 return NULL;<br>
-}<br>
-- <br>
2.28.0<br>
<br>
</blockquote></div><div><br></div><div>lgtm otherwise<br></div><br>-- <br><=
div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br></div><=
/div>

--000000000000ea22e905b1104a0e--

