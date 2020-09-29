Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4959C4741F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 15:23:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B76BD208B8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 15:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fj2Hg4p3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B76BD208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNHTk-0003sO-89
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 11:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kNHSL-000300-90
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 11:22:17 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:44413)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kNHSI-0000aG-Do
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 11:22:17 -0400
Received: by mail-ej1-x643.google.com with SMTP id r7so15538370ejs.11
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 08:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2nHWsn1Cq/pSshaFgJxhxBHFHUI1lYyFukaKQWr8U6A=;
 b=Fj2Hg4p3yCO7y6YOIQ9RXLCd615sl/3Wthz2ogiy0XnU3OOjK1HatQqiPQUWvewdkY
 GUR73wTeb/nFZ9IN+lcY59ErWJE9teQC2K+qBpy9aAyCHn/hHJ0VVpbBdDyt18iCYdPl
 jLECNIg40Es8BOEu9MxWtSaltWWgi/NUFKcxPzuGbDJ8/Xb4e2JyQ2vdVDhYJvZ/CWoY
 fRjObDg04Yq0OZ8hyk4Zl3/E8kaqExtZQsdb/IFKsyF+bxF3wJ0b7LfeNYn2XbNijvCj
 Z24XpStaHPuFOVVKk3NQ2j0qCYSyD+dkluTbQKAudLHXRs9akGbESdkrg1ah+xRE8HP8
 zi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2nHWsn1Cq/pSshaFgJxhxBHFHUI1lYyFukaKQWr8U6A=;
 b=h7OTNkQnrLQfqeXQTQ+MZaMSC/COjnPr8FgJly5Kg41G2JhC4VqFWmn6wQebpblk76
 inLP0w6hq6i+NtfK/mKcOhL6g5eJ6Jee/rw8vIGMUrWn2m+AB9baq9Wtud0aQZyDFMt+
 T2Itjj/TleQEe7EdAknHYsc+WWjjp+qpePanGBo14Vt1wAWkyzdtesyY8+Ih/qA6I+Po
 hcKkkA0TidWpKjKEyk/57rKdUL70XYN2523b7aZ2reolfydMOqudfjT+IBa8JGkpulAk
 k8qXL4H3YOyGAs49PXOXoMTgMHiwPFfq3kUbyUJa44BoXgE4uITqOW/3hmgZg2lz4plt
 YfbA==
X-Gm-Message-State: AOAM531zuFCjDCSFM7BpRU/T/imtVdKK1xuramYxAArI8c/fpaxeTvYY
 TX3C9yBcEMpK4wPsPFhDqxc50mGh5Iaq0tljYQ8=
X-Google-Smtp-Source: ABdhPJwRC8UpT36f1XpGJKbS3XNrNOjoKzbeesU5QWUfoRiUd1n2sOBc0hgA8FSk/270ShRchWpT9s+/ZS05GFDPtGM=
X-Received: by 2002:a17:906:249b:: with SMTP id
 e27mr4334970ejb.105.1601392932541; 
 Tue, 29 Sep 2020 08:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599470071.git.tgolembi@redhat.com>
 <1bf9ede3b9273613319ff8ff99b40c385439cfa8.1599470071.git.tgolembi@redhat.com>
In-Reply-To: <1bf9ede3b9273613319ff8ff99b40c385439cfa8.1599470071.git.tgolembi@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 29 Sep 2020 19:22:00 +0400
Message-ID: <CAJ+F1C+FPkg-fznQdfqnioJ9CD3fi7apW34ad=cQMgzRsphqCQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] qga: add implementation of guest-get-disks for
 Linux
To: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e3da4405b0755846"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x643.google.com
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

--000000000000e3da4405b0755846
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Sep 7, 2020 at 1:17 PM Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@=
redhat.com>
wrote:

> The command lists all disks (real and virtual) as well as disk
> partitions. For each disk the list of slave disks is also listed and
> /dev path is used as a handle so it can be matched with "name" filed of
>

field

other returned disk entries. For disk partitions the "slave" list is
> populated with the the parent device for easier tracking of hierarchy.
>
> Example output:
> {
>   "return": [
>     ...
>     {
>       "name": "/dev/dm-0",
>       "partition": false,
>       "slaves": [
>         "/dev/sda2"
>       ],
>       "alias": "luks-7062202e-5b9b-433e-81e8-6628c40da9f7"
>     },
>     {
>       "name": "/dev/sda2",
>       "partition": true,
>       "slaves": [
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
>       "slaves": []
>     },
>     ...
>   ]
> }
>
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> ---
>  qga/commands-posix.c | 247 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 240 insertions(+), 7 deletions(-)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index f99731af51..3babc25c09 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -62,6 +62,9 @@ extern char **environ;
>  #endif
>  #endif
>
> +G_DEFINE_AUTOPTR_CLEANUP_FUNC(GuestFilesystemInfo,
> +    qapi_free_GuestFilesystemInfo)
> +
>

This will now conflict with qapi-gen generated headers.

 static void ga_wait_child(pid_t pid, int *status, Error **errp)
>  {
>      pid_t rpid;
> @@ -1150,6 +1153,21 @@ static void
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
>
+        return false;
> +    }
> +    if (strstr(syspath, "/devices/virtual/block/")) {
> +        return true;
> +    } else {
> +        return false;
> +    }
>

 simply to "return strstr(syspath, "/devices/virtual/block/") !=3D NULL;" ?
(Or strstr(syspath, "/devices/virtual/block/") ? true : false )

+}
> +
>  /* Dispatch to functions for virtual/real device */
>  static void build_guest_fsinfo_for_device(char const *devpath,
>                                            GuestFilesystemInfo *fs,
> @@ -1168,6 +1186,7 @@ static void build_guest_fsinfo_for_device(char cons=
t
> *devpath,
>
>      g_debug("  parse sysfs path '%s'", syspath);
>
> +    /* TODO: use is_disk_virtual() */
>

just do it, no?

     if (strstr(syspath, "/devices/virtual/block/")) {
>          build_guest_fsinfo_for_virtual_device(syspath, fs, errp);
>      } else {
> @@ -1177,6 +1196,225 @@ static void build_guest_fsinfo_for_device(char
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
>

Heap allocation / auto wasn't really necessary here, but ok.


> +    build_guest_fsinfo_for_device(syspath, fs, errp);
> +    if (fs->disk !=3D NULL) {
> +        return g_steal_pointer(&fs->disk->value);
> +    }
> +    return NULL;
>

Could also be a onliner, but perhaps less readable.

+}
> +
> +static char *get_alias_for_syspath(const char *syspath)
> +{
> +    struct udev *udev =3D NULL;
> +    struct udev_device *udevice =3D NULL;
> +    char *ret =3D NULL;
> +
> +    udev =3D udev_new();
>

I would have g_return_val_if_fail(udev !=3D NULL, NULL); here as,

+    udevice =3D udev_device_new_from_syspath(udev, syspath);
>

udev_device_new_from_syspath() might crash otherwise.


> +    if (udev =3D=3D NULL || udevice =3D=3D NULL) {
> +        g_debug("failed to query udev");
> +    } else {
> +        const char *alias =3D udev_device_get_property_value(
> +            udevice, "DM_NAME");
> +        if (alias !=3D NULL && *alias !=3D 0) {
> +            ret =3D g_strdup(alias);
>

g_strdup() works fine with NULL. Is there "" empty aliases? Why not report
them too?

+        }
> +    }
> +
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
> +    udevice =3D udev_device_new_from_syspath(udev, syspath);
> +    if (udev =3D=3D NULL || udevice =3D=3D NULL) {
>

Same as above

+        g_debug("failed to query udev");
> +    } else {
> +        ret =3D g_strdup(udev_device_get_devnode(udevice));
> +    }
> +    udev_unref(udev);
> +    udev_device_unref(udevice);
> +    return ret;
> +}
> +
>
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
> +{
> +    GuestDiskInfoList *item, *ret =3D NULL;
> +    GuestDiskInfo *disk, *partition;
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
> +            *size_dir =3D NULL, *slaves_dir =3D NULL;
> +        struct dirent *de_disk, *de_slaves;
> +        DIR *dp_disk =3D NULL, *dp_slaves =3D NULL;
> +        FILE *fp =3D NULL;
> +        size_t n =3D 0;
> +        Error *local_err =3D NULL;
> +        if (de->d_type !=3D DT_LNK) {
> +            g_debug("  skipping entry: %s", de->d_name);
> +            continue;
> +        }
> +
> +        /* Check size and skip zero-sized disks */
> +        g_debug("  checking disk size");
> +        size_dir =3D g_strdup_printf("/sys/block/%s/size", de->d_name);
> +        fp =3D fopen(size_dir, "r");
> +        if (!fp) {
> +            g_debug("  failed to read disk size");
> +            continue;
> +        }
> +        if (getline(&line, &n, fp) =3D=3D -1) {
> +            g_debug("  failed to read disk size");
>

line: getline(3) "This buffer should be freed by the user program even if
getline() failed."

+            fclose(fp);
> +            continue;
> +        }
> +        fclose(fp);
> +        if (strcmp(line, "0\n") =3D=3D 0) {
>

It would be slightly better to  defend against NULL crash here, with
g_strcmp0()

+            g_debug("  skipping zero-sized disk");
> +            continue;
> +        }
> +
>

line is never freed?

+        g_debug("  adding %s", de->d_name);
> +        disk_dir =3D g_strdup_printf("/sys/block/%s", de->d_name);
> +        disk =3D g_new0(GuestDiskInfo, 1);
> +        disk->name =3D get_device_for_syspath(disk_dir);
> +        disk->partition =3D false;
> +        disk->alias =3D get_alias_for_syspath(disk_dir);
> +        if (disk->alias !=3D NULL) {
> +            disk->has_alias =3D true;
> +        }
>

Could be a single line too

+        item =3D g_new0(GuestDiskInfoList, 1);
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
>
+            /* Don't try to get the address */
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
> +        /* List slave disks */
> +        slaves_dir =3D g_strdup_printf("%s/slaves", disk_dir);
> +        g_debug("  listing entries in: %s", slaves_dir);
> +        dp_slaves =3D opendir(slaves_dir);
> +        while ((de_slaves =3D readdir(dp_slaves)) !=3D NULL) {
> +            g_autofree char *slave_dir =3D NULL;
> +            char *slave_dev;
> +            strList *slave_item =3D NULL;
> +
> +            if ((strcmp(".", de_slaves->d_name) =3D=3D 0) ||
> +                (strcmp("..", de_slaves->d_name) =3D=3D 0)) {
>
+                continue;
> +            }
> +
> +            /* Add slave disks */
> +            slave_dir =3D g_strdup_printf("%s/%s",
> +                slaves_dir, de_slaves->d_name);
> +            slave_dev =3D get_device_for_syspath(slave_dir);
> +            if (slave_dev !=3D NULL) {
> +                g_debug("  adding slave device: %s", slave_dev);
> +                slave_item =3D g_new0(strList, 1);
> +                slave_item->value =3D slave_dev;
> +                slave_item->next =3D disk->slaves;
> +                disk->slaves =3D slave_item;
> +            }
> +        }
> +        closedir(dp_slaves);
> +
> +        /*
> +         * Detect partitions subdirectory name is "<parent><number>" or
> +         * "<parent>p<number>"
> +         */
> +        dp_disk =3D opendir(disk_dir);
> +        while ((de_disk =3D readdir(dp_disk)) !=3D NULL) {
> +            size_t len;
> +            g_autofree char *partition_dir =3D NULL;
> +
> +            if (!(de_disk->d_type & DT_DIR)) {
> +                continue;
> +            }
> +
> +            len =3D strlen(de->d_name);
> +            if (!(strncmp(de->d_name, de_disk->d_name, len) =3D=3D 0 &&
> +                ((*(de_disk->d_name + len) =3D=3D 'p' &&
> +                isdigit(*(de_disk->d_name + len + 1))) ||
> +                    isdigit(*(de_disk->d_name + len))))) {
> +                continue;
> +            }
> +
> +            partition_dir =3D g_strdup_printf("%s/%s",
> +                disk_dir, de_disk->d_name);
> +            partition =3D g_new0(GuestDiskInfo, 1);
> +            partition->name =3D get_device_for_syspath(partition_dir);
> +            partition->partition =3D true;
> +            /* Add parent disk as slave for easier tracking of hierarchy
> */
> +            partition->slaves =3D g_new0(strList, 1);
> +            partition->slaves->value =3D g_strdup(disk->name);
> +
> +            item =3D g_new0(GuestDiskInfoList, 1);
> +            item->value =3D partition;
> +            item->next =3D ret;
> +            ret =3D item;
> +
> +        }
> +        closedir(dp_disk);
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
> @@ -2809,7 +3047,8 @@ GList *ga_command_blacklist_init(GList *blacklist)
>          const char *list[] =3D {
>              "guest-get-fsinfo", "guest-fsfreeze-status",
>              "guest-fsfreeze-freeze", "guest-fsfreeze-freeze-list",
> -            "guest-fsfreeze-thaw", "guest-get-fsinfo", NULL};
> +            "guest-fsfreeze-thaw", "guest-get-fsinfo",
> +            "guest-get-disks", NULL};
>          char **p =3D (char **)list;
>
>          while (*p) {
> @@ -3042,9 +3281,3 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
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

--=20
Marc-Andr=C3=A9 Lureau

--000000000000e3da4405b0755846
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 7, 2020 at 1:17 PM Tom=
=C3=A1=C5=A1 Golembiovsk=C3=BD &lt;<a href=3D"mailto:tgolembi@redhat.com">t=
golembi@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">The command lists all disks (real and virtual) as well as=
 disk<br>
partitions. For each disk the list of slave disks is also listed and<br>
/dev path is used as a handle so it can be matched with &quot;name&quot; fi=
led of<br></blockquote><div><br></div><div>field <br></div><div><br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
other returned disk entries. For disk partitions the &quot;slave&quot; list=
 is<br>
populated with the the parent device for easier tracking of hierarchy.<br>
<br>
Example output:<br>
{<br>
=C2=A0 &quot;return&quot;: [<br>
=C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 &quot;name&quot;: &quot;/dev/dm-0&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 &quot;partition&quot;: false,<br>
=C2=A0 =C2=A0 =C2=A0 &quot;slaves&quot;: [<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;/dev/sda2&quot;<br>
=C2=A0 =C2=A0 =C2=A0 ],<br>
=C2=A0 =C2=A0 =C2=A0 &quot;alias&quot;: &quot;luks-7062202e-5b9b-433e-81e8-=
6628c40da9f7&quot;<br>
=C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 &quot;name&quot;: &quot;/dev/sda2&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 &quot;partition&quot;: true,<br>
=C2=A0 =C2=A0 =C2=A0 &quot;slaves&quot;: [<br>
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
=C2=A0 =C2=A0 =C2=A0 &quot;slaves&quot;: []<br>
=C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 ...<br>
=C2=A0 ]<br>
}<br>
<br>
Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD &lt;<a href=3D"mailto:tgol=
embi@redhat.com" target=3D"_blank">tgolembi@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-posix.c | 247 +++++++++++++++++++++++++++++++++++++++++-=
-<br>
=C2=A01 file changed, 240 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index f99731af51..3babc25c09 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -62,6 +62,9 @@ extern char **environ;<br>
=C2=A0#endif<br>
=C2=A0#endif<br>
<br>
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(GuestFilesystemInfo,<br>
+=C2=A0 =C2=A0 qapi_free_GuestFilesystemInfo)<br>
+<br></blockquote><div><br></div><div>This will now conflict with qapi-gen =
generated headers.<br></div><div> <br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
=C2=A0static void ga_wait_child(pid_t pid, int *status, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0pid_t rpid;<br>
@@ -1150,6 +1153,21 @@ static void build_guest_fsinfo_for_virtual_device(ch=
ar const *syspath,<br>
=C2=A0 =C2=A0 =C2=A0closedir(dir);<br>
=C2=A0}<br>
<br>
+static bool is_disk_virtual(const char *devpath, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 g_autofree char *syspath =3D realpath(devpath, NULL);<br>
+<br>
+=C2=A0 =C2=A0 if (!syspath) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;realpath(\=
&quot;%s\&quot;)&quot;, devpath);<br></blockquote><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (strstr(syspath, &quot;/devices/virtual/block/&quot;)) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br></blockquote><div><br></div><div>=C2=A0simply to &quot;=
return strstr(syspath, &quot;/devices/virtual/block/&quot;) !=3D NULL;&quot=
; ? (Or strstr(syspath, &quot;/devices/virtual/block/&quot;) ? true : false=
 )<br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
+}<br>
+<br>
=C2=A0/* Dispatch to functions for virtual/real device */<br>
=C2=A0static void build_guest_fsinfo_for_device(char const *devpath,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0GuestFilesystemInfo *fs,<br>
@@ -1168,6 +1186,7 @@ static void build_guest_fsinfo_for_device(char const =
*devpath,<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_debug(&quot;=C2=A0 parse sysfs path &#39;%s&#39;&quot=
;, syspath);<br>
<br>
+=C2=A0 =C2=A0 /* TODO: use is_disk_virtual() */<br></blockquote><div><br><=
/div><div>just do it, no?</div><div> <br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0if (strstr(syspath, &quot;/devices/virtual/block/&quot;=
)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0build_guest_fsinfo_for_virtual_device(sys=
path, fs, errp);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
@@ -1177,6 +1196,225 @@ static void build_guest_fsinfo_for_device(char cons=
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
+=C2=A0 =C2=A0 fs =3D g_new0(GuestFilesystemInfo, 1);<br></blockquote><div>=
<br></div><div>Heap allocation / auto wasn&#39;t really necessary here, but=
 ok.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
+=C2=A0 =C2=A0 build_guest_fsinfo_for_device(syspath, fs, errp);<br>
+=C2=A0 =C2=A0 if (fs-&gt;disk !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return g_steal_pointer(&amp;fs-&gt;disk-&gt;va=
lue);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return NULL;<br></blockquote><div><br></div><div>Could also =
be a onliner, but perhaps less readable.</div><div> <br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
+}<br>
+<br>
+static char *get_alias_for_syspath(const char *syspath)<br>
+{<br>
+=C2=A0 =C2=A0 struct udev *udev =3D NULL;<br>
+=C2=A0 =C2=A0 struct udev_device *udevice =3D NULL;<br>
+=C2=A0 =C2=A0 char *ret =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 udev =3D udev_new();<br></blockquote><div><br></div><div>I w=
ould have g_return_val_if_fail(udev !=3D NULL, NULL); here as, <br></div><d=
iv><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 udevice =3D udev_device_new_from_syspath(udev, syspath);<br>=
</blockquote><div><br></div><div>udev_device_new_from_syspath() might crash=
 otherwise.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
+=C2=A0 =C2=A0 if (udev =3D=3D NULL || udevice =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;failed to query udev&quot;);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *alias =3D udev_device_get_property=
_value(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 udevice, &quot;DM_NAME&quot;);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (alias !=3D NULL &amp;&amp; *alias !=3D 0) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D g_strdup(alias);<br></bl=
ockquote><div><br></div><div>g_strdup() works fine with NULL. Is there &quo=
t;&quot; empty aliases? Why not report them too?</div><div> <br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
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
+=C2=A0 =C2=A0 udevice =3D udev_device_new_from_syspath(udev, syspath);<br>
+=C2=A0 =C2=A0 if (udev =3D=3D NULL || udevice =3D=3D NULL) {<br></blockquo=
te><div><br></div><div>Same as above</div><div> <br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;failed to query udev&quot;);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D g_strdup(udev_device_get_devnode(udevi=
ce));<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 udev_unref(udev);<br>
+=C2=A0 =C2=A0 udev_device_unref(udevice);<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 GuestDiskInfoList *item, *ret =3D NULL;<br>
+=C2=A0 =C2=A0 GuestDiskInfo *disk, *partition;<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *size_dir =3D NULL, *slaves_dir =
=3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dirent *de_disk, *de_slaves;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DIR *dp_disk =3D NULL, *dp_slaves =3D NULL;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 FILE *fp =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t n =3D 0;<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_dir =3D g_strdup_printf(&quot;/sys/block/=
%s/size&quot;, de-&gt;d_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fp =3D fopen(size_dir, &quot;r&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!fp) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=A0 failed to r=
ead disk size&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (getline(&amp;line, &amp;n, fp) =3D=3D -1) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=A0 failed to r=
ead disk size&quot;);<br></blockquote><div><br></div><div>line: getline(3) =
&quot;This buffer should be freed by the user program even if getline() fai=
led.&quot;</div><div><br> </div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fclose(fp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fclose(fp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (strcmp(line, &quot;0\n&quot;) =3D=3D 0) {<=
br></blockquote><div><br></div><div>It would be slightly better to=C2=A0 de=
fend against NULL crash here, with g_strcmp0()<br></div><div><br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=A0 skipping ze=
ro-sized disk&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br></blockquote><div><br></div><div>line is never freed?</div><div> <br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=A0 adding %s&quot;, de-&gt;d=
_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk_dir =3D g_strdup_printf(&quot;/sys/block/=
%s&quot;, de-&gt;d_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk =3D g_new0(GuestDiskInfo, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;name =3D get_device_for_syspath(disk_=
dir);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;partition =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;alias =3D get_alias_for_syspath(disk_=
dir);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (disk-&gt;alias !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;has_alias =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br></blockquote><div><br></div><div>Could be=
 a single line too</div><div> <br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 local_err =3D NULL;<br></blockqu=
ote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* List slave disks */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 slaves_dir =3D g_strdup_printf(&quot;%s/slaves=
&quot;, disk_dir);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=A0 listing entries in: %s&qu=
ot;, slaves_dir);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dp_slaves =3D opendir(slaves_dir);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 while ((de_slaves =3D readdir(dp_slaves)) !=3D=
 NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *slave_dir =3D N=
ULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *slave_dev;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strList *slave_item =3D NULL;<br=
>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((strcmp(&quot;.&quot;, de_sl=
aves-&gt;d_name) =3D=3D 0) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (strcmp(&quot;..&q=
uot;, de_slaves-&gt;d_name) =3D=3D 0)) {<br></blockquote><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Add slave disks */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slave_dir =3D g_strdup_printf(&q=
uot;%s/%s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slaves_dir, de_sla=
ves-&gt;d_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slave_dev =3D get_device_for_sys=
path(slave_dir);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (slave_dev !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;=C2=
=A0 adding slave device: %s&quot;, slave_dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slave_item =3D g_n=
ew0(strList, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slave_item-&gt;val=
ue =3D slave_dev;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slave_item-&gt;nex=
t =3D disk-&gt;slaves;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk-&gt;slaves =
=3D slave_item;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 closedir(dp_slaves);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Detect partitions subdirectory name is=
 &quot;&lt;parent&gt;&lt;number&gt;&quot; or<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* &quot;&lt;parent&gt;p&lt;number&gt;&qu=
ot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dp_disk =3D opendir(disk_dir);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 while ((de_disk =3D readdir(dp_disk)) !=3D NUL=
L) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t len;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *partition_dir =
=3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(de_disk-&gt;d_type &amp; D=
T_DIR)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D strlen(de-&gt;d_name);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(strncmp(de-&gt;d_name, de_=
disk-&gt;d_name, len) =3D=3D 0 &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((*(de_disk-&gt;d_=
name + len) =3D=3D &#39;p&#39; &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 isdigit(*(de_disk-=
&gt;d_name + len + 1))) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 isdi=
git(*(de_disk-&gt;d_name + len))))) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 partition_dir =3D g_strdup_print=
f(&quot;%s/%s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disk_dir, de_disk-=
&gt;d_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 partition =3D g_new0(GuestDiskIn=
fo, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 partition-&gt;name =3D get_devic=
e_for_syspath(partition_dir);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 partition-&gt;partition =3D true=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Add parent disk as slave for =
easier tracking of hierarchy */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 partition-&gt;slaves =3D g_new0(=
strList, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 partition-&gt;slaves-&gt;value =
=3D g_strdup(disk-&gt;name);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 item =3D g_new0(GuestDiskInfoLis=
t, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 item-&gt;value =3D partition;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 item-&gt;next =3D ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D item;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 closedir(dp_disk);<br>
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
@@ -2809,7 +3047,8 @@ GList *ga_command_blacklist_init(GList *blacklist)<br=
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
@@ -3042,9 +3281,3 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)<br>
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
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000e3da4405b0755846--

