Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81F9C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:18:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 388F52078E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hEb5YBie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388F52078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFDHk-0005MI-5j
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 05:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1kFDEi-0002C0-PT
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:14:52 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26898
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1kFDEg-00029P-Jj
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599470089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=79VWxHD2uYxnE8yhccOqd+75IUhDJGIdUzonpS82lS8=;
 b=hEb5YBie6VbUiwQjhMme2bxE2x+45EAVrDc8Z6rL7gmlJxStL9YzkV0eCdrV6Y/1hJPZwE
 kwKMxaCG++uBQmrN0nAQTPemb38c/7VpRts7b5xf1ULbAcx9+m3Rs34fslU1QVX30Qzx9S
 vsTmVaebNyNxRl7USC6eiD3c+R4fEFM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-9-lc0oOfPge1xciYH7D34w-1; Mon, 07 Sep 2020 05:14:47 -0400
X-MC-Unique: 9-lc0oOfPge1xciYH7D34w-1
Received: by mail-ed1-f70.google.com with SMTP id n4so4667765edo.20
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 02:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=79VWxHD2uYxnE8yhccOqd+75IUhDJGIdUzonpS82lS8=;
 b=JPohjt+B/0y22wW+mRHCCuzPe/u0cYg60X/XSzFz2+8fGGY6b9c9HEhpTC4YIY1cxI
 Uu77ELsGhVVsh9Ir+fvXCK3v4mXQgF/tVMLN32cLQjugDSpH/3fUHcTTx9S36Xz/E2bl
 xPtK7WHKX0gk0NVcy41mtKpQwJgMrG7fxXr1Nd9Ej+w4cx+cavfKUabqpIgFNuT1i3IL
 Dlq4qGiYcoByMui4FzAnmkbR2fSrEmmTeen2ivTEGtfKLFdaRB9CbbyGcPPD9KOTsL33
 PSWjr9iHQEd0PxlL3TJQpldahTS1uFVqkUM87HqXoYAJ5w0+RnufQDIid8oewKCiLJZF
 up3A==
X-Gm-Message-State: AOAM530ievht7yksZJPSVshaL/jRobfVxgxsz77hPiddxAngUzcnkj9t
 sax5gi+AEudwOoqYc5ccKlFT85MYPm+35IlvjWM+VXeJX+wvaxMQCuQcHYc6Q3NlMQWOObhAQhk
 b7jOT8jvCpAlbET0=
X-Received: by 2002:a17:906:5205:: with SMTP id
 g5mr19570267ejm.488.1599470086227; 
 Mon, 07 Sep 2020 02:14:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/dBszOMrEFWX44fPX4kBZNd3HoEE5LfaPNTKGBECNEWk5h+BphrAQQNsZ93XHh0FK7oC66A==
X-Received: by 2002:a17:906:5205:: with SMTP id
 g5mr19570248ejm.488.1599470085998; 
 Mon, 07 Sep 2020 02:14:45 -0700 (PDT)
Received: from auriga.localdomain (ip-89-176-41-222.net.upcbroadband.cz.
 [89.176.41.222])
 by smtp.gmail.com with ESMTPSA id d6sm14394910edm.31.2020.09.07.02.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 02:14:45 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] qga: add implementation of guest-get-disks for Linux
Date: Mon,  7 Sep 2020 11:14:41 +0200
Message-Id: <1bf9ede3b9273613319ff8ff99b40c385439cfa8.1599470071.git.tgolembi@redhat.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1599470071.git.tgolembi@redhat.com>
References: <cover.1599470071.git.tgolembi@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=tgolembi@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=tgolembi@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/06 22:29:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The command lists all disks (real and virtual) as well as disk
partitions. For each disk the list of slave disks is also listed and
/dev path is used as a handle so it can be matched with "name" filed of
other returned disk entries. For disk partitions the "slave" list is
populated with the the parent device for easier tracking of hierarchy.

Example output:
{
  "return": [
    ...
    {
      "name": "/dev/dm-0",
      "partition": false,
      "slaves": [
        "/dev/sda2"
      ],
      "alias": "luks-7062202e-5b9b-433e-81e8-6628c40da9f7"
    },
    {
      "name": "/dev/sda2",
      "partition": true,
      "slaves": [
        "/dev/sda"
      ]
    },
    {
      "name": "/dev/sda",
      "partition": false,
      "address": {
        "serial": "SAMSUNG_MZ7LN512HCHP-000L1_S1ZKNXAG822493",
        "bus-type": "sata",
        ...
        "dev": "/dev/sda",
        "target": 0
      },
      "slaves": []
    },
    ...
  ]
}

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 qga/commands-posix.c | 247 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 240 insertions(+), 7 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index f99731af51..3babc25c09 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -62,6 +62,9 @@ extern char **environ;
 #endif
 #endif
 
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(GuestFilesystemInfo,
+    qapi_free_GuestFilesystemInfo)
+
 static void ga_wait_child(pid_t pid, int *status, Error **errp)
 {
     pid_t rpid;
@@ -1150,6 +1153,21 @@ static void build_guest_fsinfo_for_virtual_device(char const *syspath,
     closedir(dir);
 }
 
+static bool is_disk_virtual(const char *devpath, Error **errp)
+{
+    g_autofree char *syspath = realpath(devpath, NULL);
+
+    if (!syspath) {
+        error_setg_errno(errp, errno, "realpath(\"%s\")", devpath);
+        return false;
+    }
+    if (strstr(syspath, "/devices/virtual/block/")) {
+        return true;
+    } else {
+        return false;
+    }
+}
+
 /* Dispatch to functions for virtual/real device */
 static void build_guest_fsinfo_for_device(char const *devpath,
                                           GuestFilesystemInfo *fs,
@@ -1168,6 +1186,7 @@ static void build_guest_fsinfo_for_device(char const *devpath,
 
     g_debug("  parse sysfs path '%s'", syspath);
 
+    /* TODO: use is_disk_virtual() */
     if (strstr(syspath, "/devices/virtual/block/")) {
         build_guest_fsinfo_for_virtual_device(syspath, fs, errp);
     } else {
@@ -1177,6 +1196,225 @@ static void build_guest_fsinfo_for_device(char const *devpath,
     free(syspath);
 }
 
+#ifdef CONFIG_LIBUDEV
+
+/*
+ * Wrapper around build_guest_fsinfo_for_device() for getting just
+ * the disk address.
+ */
+static GuestDiskAddress *get_disk_address(const char *syspath, Error **errp)
+{
+    g_autoptr(GuestFilesystemInfo) fs = NULL;
+
+    fs = g_new0(GuestFilesystemInfo, 1);
+    build_guest_fsinfo_for_device(syspath, fs, errp);
+    if (fs->disk != NULL) {
+        return g_steal_pointer(&fs->disk->value);
+    }
+    return NULL;
+}
+
+static char *get_alias_for_syspath(const char *syspath)
+{
+    struct udev *udev = NULL;
+    struct udev_device *udevice = NULL;
+    char *ret = NULL;
+
+    udev = udev_new();
+    udevice = udev_device_new_from_syspath(udev, syspath);
+    if (udev == NULL || udevice == NULL) {
+        g_debug("failed to query udev");
+    } else {
+        const char *alias = udev_device_get_property_value(
+            udevice, "DM_NAME");
+        if (alias != NULL && *alias != 0) {
+            ret = g_strdup(alias);
+        }
+    }
+
+    udev_unref(udev);
+    udev_device_unref(udevice);
+    return ret;
+}
+
+static char *get_device_for_syspath(const char *syspath)
+{
+    struct udev *udev = NULL;
+    struct udev_device *udevice = NULL;
+    char *ret = NULL;
+
+    udev = udev_new();
+    udevice = udev_device_new_from_syspath(udev, syspath);
+    if (udev == NULL || udevice == NULL) {
+        g_debug("failed to query udev");
+    } else {
+        ret = g_strdup(udev_device_get_devnode(udevice));
+    }
+    udev_unref(udev);
+    udev_device_unref(udevice);
+    return ret;
+}
+
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
+{
+    GuestDiskInfoList *item, *ret = NULL;
+    GuestDiskInfo *disk, *partition;
+    DIR *dp = NULL;
+    struct dirent *de = NULL;
+
+    g_debug("listing /sys/block directory");
+    dp = opendir("/sys/block");
+    if (dp == NULL) {
+        error_setg_errno(errp, errno, "Can't open directory \"/sys/block\"");
+        return NULL;
+    }
+    while ((de = readdir(dp)) != NULL) {
+        g_autofree char *disk_dir = NULL, *line = NULL,
+            *size_dir = NULL, *slaves_dir = NULL;
+        struct dirent *de_disk, *de_slaves;
+        DIR *dp_disk = NULL, *dp_slaves = NULL;
+        FILE *fp = NULL;
+        size_t n = 0;
+        Error *local_err = NULL;
+        if (de->d_type != DT_LNK) {
+            g_debug("  skipping entry: %s", de->d_name);
+            continue;
+        }
+
+        /* Check size and skip zero-sized disks */
+        g_debug("  checking disk size");
+        size_dir = g_strdup_printf("/sys/block/%s/size", de->d_name);
+        fp = fopen(size_dir, "r");
+        if (!fp) {
+            g_debug("  failed to read disk size");
+            continue;
+        }
+        if (getline(&line, &n, fp) == -1) {
+            g_debug("  failed to read disk size");
+            fclose(fp);
+            continue;
+        }
+        fclose(fp);
+        if (strcmp(line, "0\n") == 0) {
+            g_debug("  skipping zero-sized disk");
+            continue;
+        }
+
+        g_debug("  adding %s", de->d_name);
+        disk_dir = g_strdup_printf("/sys/block/%s", de->d_name);
+        disk = g_new0(GuestDiskInfo, 1);
+        disk->name = get_device_for_syspath(disk_dir);
+        disk->partition = false;
+        disk->alias = get_alias_for_syspath(disk_dir);
+        if (disk->alias != NULL) {
+            disk->has_alias = true;
+        }
+        item = g_new0(GuestDiskInfoList, 1);
+        item->value = disk;
+        item->next = ret;
+        ret = item;
+
+        /* Get address for non-virtual devices */
+        bool is_virtual = is_disk_virtual(disk_dir, &local_err);
+        if (local_err != NULL) {
+            g_debug("  failed to check disk path, ignoring error: %s",
+                error_get_pretty(local_err));
+            error_free(local_err);
+            local_err = NULL;
+            /* Don't try to get the address */
+            is_virtual = true;
+        }
+        if (!is_virtual) {
+            disk->address = get_disk_address(disk_dir, &local_err);
+            if (local_err != NULL) {
+                g_debug("  failed to get device info, ignoring error: %s",
+                    error_get_pretty(local_err));
+                error_free(local_err);
+                local_err = NULL;
+            } else if (disk->address != NULL) {
+                disk->has_address = true;
+            }
+        }
+
+        /* List slave disks */
+        slaves_dir = g_strdup_printf("%s/slaves", disk_dir);
+        g_debug("  listing entries in: %s", slaves_dir);
+        dp_slaves = opendir(slaves_dir);
+        while ((de_slaves = readdir(dp_slaves)) != NULL) {
+            g_autofree char *slave_dir = NULL;
+            char *slave_dev;
+            strList *slave_item = NULL;
+
+            if ((strcmp(".", de_slaves->d_name) == 0) ||
+                (strcmp("..", de_slaves->d_name) == 0)) {
+                continue;
+            }
+
+            /* Add slave disks */
+            slave_dir = g_strdup_printf("%s/%s",
+                slaves_dir, de_slaves->d_name);
+            slave_dev = get_device_for_syspath(slave_dir);
+            if (slave_dev != NULL) {
+                g_debug("  adding slave device: %s", slave_dev);
+                slave_item = g_new0(strList, 1);
+                slave_item->value = slave_dev;
+                slave_item->next = disk->slaves;
+                disk->slaves = slave_item;
+            }
+        }
+        closedir(dp_slaves);
+
+        /*
+         * Detect partitions subdirectory name is "<parent><number>" or
+         * "<parent>p<number>"
+         */
+        dp_disk = opendir(disk_dir);
+        while ((de_disk = readdir(dp_disk)) != NULL) {
+            size_t len;
+            g_autofree char *partition_dir = NULL;
+
+            if (!(de_disk->d_type & DT_DIR)) {
+                continue;
+            }
+
+            len = strlen(de->d_name);
+            if (!(strncmp(de->d_name, de_disk->d_name, len) == 0 &&
+                ((*(de_disk->d_name + len) == 'p' &&
+                isdigit(*(de_disk->d_name + len + 1))) ||
+                    isdigit(*(de_disk->d_name + len))))) {
+                continue;
+            }
+
+            partition_dir = g_strdup_printf("%s/%s",
+                disk_dir, de_disk->d_name);
+            partition = g_new0(GuestDiskInfo, 1);
+            partition->name = get_device_for_syspath(partition_dir);
+            partition->partition = true;
+            /* Add parent disk as slave for easier tracking of hierarchy */
+            partition->slaves = g_new0(strList, 1);
+            partition->slaves->value = g_strdup(disk->name);
+
+            item = g_new0(GuestDiskInfoList, 1);
+            item->value = partition;
+            item->next = ret;
+            ret = item;
+
+        }
+        closedir(dp_disk);
+    }
+    return ret;
+}
+
+#else
+
+GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+    return NULL;
+}
+
+#endif
+
 /* Return a list of the disk device(s)' info which @mount lies on */
 static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
                                                Error **errp)
@@ -2809,7 +3047,8 @@ GList *ga_command_blacklist_init(GList *blacklist)
         const char *list[] = {
             "guest-get-fsinfo", "guest-fsfreeze-status",
             "guest-fsfreeze-freeze", "guest-fsfreeze-freeze-list",
-            "guest-fsfreeze-thaw", "guest-get-fsinfo", NULL};
+            "guest-fsfreeze-thaw", "guest-get-fsinfo",
+            "guest-get-disks", NULL};
         char **p = (char **)list;
 
         while (*p) {
@@ -3042,9 +3281,3 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
 
     return info;
 }
-
-GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
-- 
2.25.0


