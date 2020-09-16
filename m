Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BEEC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:52:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34AAA2074B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZcOMTsqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34AAA2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIU72-00065C-0Q
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 05:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIU2C-0006Z9-Ij
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:47:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40395)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIU28-0008M7-KN
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600249643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rqMrcRYY7vZu7K/XVF3Zm7hdVdgT7JL/9mm71/ZtzAg=;
 b=ZcOMTsqCgBj23b99pBcadTqeWBMf6Xi4AZF4onJ+O9jSwuLcyk29sLrouIYXJIUxJUjr3Q
 5rGxnhNGuiLZH4nqmf82F4us9qJCVvt7L0D5sgfOwceSJAcUGrvOHqTV30EdVN+sKfzvkn
 fFsQYKe8xRTEuTegU4IVoL+msd6QFZ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-R8lCPnhrNgeLkwOce_vJ6g-1; Wed, 16 Sep 2020 05:47:18 -0400
X-MC-Unique: R8lCPnhrNgeLkwOce_vJ6g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8C83425CE;
 Wed, 16 Sep 2020 09:47:17 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 96FA475123;
 Wed, 16 Sep 2020 09:47:14 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/8] util: rename qemu_open() to qemu_open_old()
Date: Wed, 16 Sep 2020 10:47:00 +0100
Message-Id: <20200916094705.2625331-4-berrange@redhat.com>
In-Reply-To: <20200916094705.2625331-1-berrange@redhat.com>
References: <20200916094705.2625331-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want to introduce a new version of qemu_open() that uses an Error
object for reporting problems and make this it the preferred interface.
Rename the existing method to release the namespace for the new impl.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 accel/kvm/kvm-all.c            |  2 +-
 backends/rng-random.c          |  2 +-
 backends/tpm/tpm_passthrough.c |  8 ++++----
 block/file-posix.c             | 14 +++++++-------
 block/file-win32.c             |  5 +++--
 block/vvfat.c                  |  5 +++--
 chardev/char-fd.c              |  2 +-
 chardev/char-pipe.c            |  6 +++---
 chardev/char.c                 |  2 +-
 dump/dump.c                    |  2 +-
 hw/s390x/s390-skeys.c          |  2 +-
 hw/usb/host-libusb.c           |  2 +-
 hw/usb/u2f-passthru.c          |  4 ++--
 hw/vfio/common.c               |  4 ++--
 include/qemu/osdep.h           |  2 +-
 io/channel-file.c              |  2 +-
 net/vhost-vdpa.c               |  2 +-
 os-posix.c                     |  2 +-
 qga/channel-posix.c            |  4 ++--
 qga/commands-posix.c           |  6 +++---
 target/arm/kvm.c               |  2 +-
 ui/console.c                   |  2 +-
 util/osdep.c                   |  2 +-
 util/oslib-posix.c             |  2 +-
 24 files changed, 44 insertions(+), 42 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 63ef6af9a1..ad8b315b35 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2013,7 +2013,7 @@ static int kvm_init(MachineState *ms)
 #endif
     QLIST_INIT(&s->kvm_parked_vcpus);
     s->vmfd = -1;
-    s->fd = qemu_open("/dev/kvm", O_RDWR);
+    s->fd = qemu_open_old("/dev/kvm", O_RDWR);
     if (s->fd == -1) {
         fprintf(stderr, "Could not access KVM kernel module: %m\n");
         ret = -errno;
diff --git a/backends/rng-random.c b/backends/rng-random.c
index 32998d8ee7..245b12ab24 100644
--- a/backends/rng-random.c
+++ b/backends/rng-random.c
@@ -75,7 +75,7 @@ static void rng_random_opened(RngBackend *b, Error **errp)
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "filename", "a valid filename");
     } else {
-        s->fd = qemu_open(s->filename, O_RDONLY | O_NONBLOCK);
+        s->fd = qemu_open_old(s->filename, O_RDONLY | O_NONBLOCK);
         if (s->fd == -1) {
             error_setg_file_open(errp, errno, s->filename);
         }
diff --git a/backends/tpm/tpm_passthrough.c b/backends/tpm/tpm_passthrough.c
index 10722e0a41..6d6294ef0a 100644
--- a/backends/tpm/tpm_passthrough.c
+++ b/backends/tpm/tpm_passthrough.c
@@ -218,7 +218,7 @@ static int tpm_passthrough_open_sysfs_cancel(TPMPassthruState *tpm_pt)
     char path[PATH_MAX];
 
     if (tpm_pt->options->cancel_path) {
-        fd = qemu_open(tpm_pt->options->cancel_path, O_WRONLY);
+        fd = qemu_open_old(tpm_pt->options->cancel_path, O_WRONLY);
         if (fd < 0) {
             error_report("tpm_passthrough: Could not open TPM cancel path: %s",
                          strerror(errno));
@@ -236,11 +236,11 @@ static int tpm_passthrough_open_sysfs_cancel(TPMPassthruState *tpm_pt)
     dev++;
     if (snprintf(path, sizeof(path), "/sys/class/tpm/%s/device/cancel",
                  dev) < sizeof(path)) {
-        fd = qemu_open(path, O_WRONLY);
+        fd = qemu_open_old(path, O_WRONLY);
         if (fd < 0) {
             if (snprintf(path, sizeof(path), "/sys/class/misc/%s/device/cancel",
                          dev) < sizeof(path)) {
-                fd = qemu_open(path, O_WRONLY);
+                fd = qemu_open_old(path, O_WRONLY);
             }
         }
     }
@@ -272,7 +272,7 @@ tpm_passthrough_handle_device_opts(TPMPassthruState *tpm_pt, QemuOpts *opts)
     }
 
     tpm_pt->tpm_dev = value ? value : TPM_PASSTHROUGH_DEFAULT_DEVICE;
-    tpm_pt->tpm_fd = qemu_open(tpm_pt->tpm_dev, O_RDWR);
+    tpm_pt->tpm_fd = qemu_open_old(tpm_pt->tpm_dev, O_RDWR);
     if (tpm_pt->tpm_fd < 0) {
         error_report("Cannot access TPM device using '%s': %s",
                      tpm_pt->tpm_dev, strerror(errno));
diff --git a/block/file-posix.c b/block/file-posix.c
index 9a00d4190a..bac2566f10 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -630,7 +630,7 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     raw_parse_flags(bdrv_flags, &s->open_flags, false);
 
     s->fd = -1;
-    fd = qemu_open(filename, s->open_flags, 0644);
+    fd = qemu_open_old(filename, s->open_flags, 0644);
     ret = fd < 0 ? -errno : 0;
 
     if (ret < 0) {
@@ -1032,13 +1032,13 @@ static int raw_reconfigure_getfd(BlockDriverState *bs, int flags,
         }
     }
 
-    /* If we cannot use fcntl, or fcntl failed, fall back to qemu_open() */
+    /* If we cannot use fcntl, or fcntl failed, fall back to qemu_open_old() */
     if (fd == -1) {
         const char *normalized_filename = bs->filename;
         ret = raw_normalize_devicepath(&normalized_filename, errp);
         if (ret >= 0) {
             assert(!(*open_flags & O_CREAT));
-            fd = qemu_open(normalized_filename, *open_flags);
+            fd = qemu_open_old(normalized_filename, *open_flags);
             if (fd == -1) {
                 error_setg_errno(errp, errno, "Could not reopen file");
                 return -1;
@@ -2411,7 +2411,7 @@ raw_co_create(BlockdevCreateOptions *options, Error **errp)
     }
 
     /* Create file */
-    fd = qemu_open(file_opts->filename, O_RDWR | O_CREAT | O_BINARY, 0644);
+    fd = qemu_open_old(file_opts->filename, O_RDWR | O_CREAT | O_BINARY, 0644);
     if (fd < 0) {
         result = -errno;
         error_setg_errno(errp, -result, "Could not create file");
@@ -3335,7 +3335,7 @@ static bool setup_cdrom(char *bsd_path, Error **errp)
     for (index = 0; index < num_of_test_partitions; index++) {
         snprintf(test_partition, sizeof(test_partition), "%ss%d", bsd_path,
                  index);
-        fd = qemu_open(test_partition, O_RDONLY | O_BINARY | O_LARGEFILE);
+        fd = qemu_open_old(test_partition, O_RDONLY | O_BINARY | O_LARGEFILE);
         if (fd >= 0) {
             partition_found = true;
             qemu_close(fd);
@@ -3653,7 +3653,7 @@ static int cdrom_probe_device(const char *filename)
     int prio = 0;
     struct stat st;
 
-    fd = qemu_open(filename, O_RDONLY | O_NONBLOCK);
+    fd = qemu_open_old(filename, O_RDONLY | O_NONBLOCK);
     if (fd < 0) {
         goto out;
     }
@@ -3787,7 +3787,7 @@ static int cdrom_reopen(BlockDriverState *bs)
      */
     if (s->fd >= 0)
         qemu_close(s->fd);
-    fd = qemu_open(bs->filename, s->open_flags, 0644);
+    fd = qemu_open_old(bs->filename, s->open_flags, 0644);
     if (fd < 0) {
         s->fd = -1;
         return -EIO;
diff --git a/block/file-win32.c b/block/file-win32.c
index e2900c3a51..b28603c7d5 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -596,8 +596,9 @@ static int raw_co_create(BlockdevCreateOptions *options, Error **errp)
         return -EINVAL;
     }
 
-    fd = qemu_open(file_opts->filename, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY,
-                   0644);
+    fd = qemu_open_old(file_opts->filename,
+                       O_WRONLY | O_CREAT | O_TRUNC | O_BINARY,
+                       0644);
     if (fd < 0) {
         error_setg_errno(errp, errno, "Could not create file");
         return -EIO;
diff --git a/block/vvfat.c b/block/vvfat.c
index 36b53c8757..5abb90e7c7 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1352,7 +1352,8 @@ static int open_file(BDRVVVFATState* s,mapping_t* mapping)
     if(!s->current_mapping ||
             strcmp(s->current_mapping->path,mapping->path)) {
         /* open file */
-        int fd = qemu_open(mapping->path, O_RDONLY | O_BINARY | O_LARGEFILE);
+        int fd = qemu_open_old(mapping->path,
+                               O_RDONLY | O_BINARY | O_LARGEFILE);
         if(fd<0)
             return -1;
         vvfat_close_current_file(s);
@@ -2513,7 +2514,7 @@ static int commit_one_file(BDRVVVFATState* s,
     for (i = s->cluster_size; i < offset; i += s->cluster_size)
         c = modified_fat_get(s, c);
 
-    fd = qemu_open(mapping->path, O_RDWR | O_CREAT | O_BINARY, 0666);
+    fd = qemu_open_old(mapping->path, O_RDWR | O_CREAT | O_BINARY, 0666);
     if (fd < 0) {
         fprintf(stderr, "Could not open %s... (%s, %d)\n", mapping->path,
                 strerror(errno), errno);
diff --git a/chardev/char-fd.c b/chardev/char-fd.c
index c2d8101106..1cd62f2779 100644
--- a/chardev/char-fd.c
+++ b/chardev/char-fd.c
@@ -119,7 +119,7 @@ int qmp_chardev_open_file_source(char *src, int flags, Error **errp)
 {
     int fd = -1;
 
-    TFR(fd = qemu_open(src, flags, 0666));
+    TFR(fd = qemu_open_old(src, flags, 0666));
     if (fd == -1) {
         error_setg_file_open(errp, errno, src);
     }
diff --git a/chardev/char-pipe.c b/chardev/char-pipe.c
index fd12c9e63b..7eca5d9a56 100644
--- a/chardev/char-pipe.c
+++ b/chardev/char-pipe.c
@@ -132,8 +132,8 @@ static void qemu_chr_open_pipe(Chardev *chr,
 
     filename_in = g_strdup_printf("%s.in", filename);
     filename_out = g_strdup_printf("%s.out", filename);
-    TFR(fd_in = qemu_open(filename_in, O_RDWR | O_BINARY));
-    TFR(fd_out = qemu_open(filename_out, O_RDWR | O_BINARY));
+    TFR(fd_in = qemu_open_old(filename_in, O_RDWR | O_BINARY));
+    TFR(fd_out = qemu_open_old(filename_out, O_RDWR | O_BINARY));
     g_free(filename_in);
     g_free(filename_out);
     if (fd_in < 0 || fd_out < 0) {
@@ -143,7 +143,7 @@ static void qemu_chr_open_pipe(Chardev *chr,
         if (fd_out >= 0) {
             close(fd_out);
         }
-        TFR(fd_in = fd_out = qemu_open(filename, O_RDWR | O_BINARY));
+        TFR(fd_in = fd_out = qemu_open_old(filename, O_RDWR | O_BINARY));
         if (fd_in < 0) {
             error_setg_file_open(errp, errno, filename);
             return;
diff --git a/chardev/char.c b/chardev/char.c
index 77e7ec814f..6b85099c03 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -235,7 +235,7 @@ static void qemu_char_open(Chardev *chr, ChardevBackend *backend,
         } else {
             flags |= O_TRUNC;
         }
-        chr->logfd = qemu_open(common->logfile, flags, 0666);
+        chr->logfd = qemu_open_old(common->logfile, flags, 0666);
         if (chr->logfd < 0) {
             error_setg_errno(errp, errno,
                              "Unable to open logfile %s",
diff --git a/dump/dump.c b/dump/dump.c
index 383bc7876b..13fda440a4 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1994,7 +1994,7 @@ void qmp_dump_guest_memory(bool paging, const char *file,
 #endif
 
     if  (strstart(file, "file:", &p)) {
-        fd = qemu_open(p, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, S_IRUSR);
+        fd = qemu_open_old(p, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, S_IRUSR);
         if (fd < 0) {
             error_setg_file_open(errp, errno, p);
             return;
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index db2f49cb27..5cc559fe4c 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -125,7 +125,7 @@ void qmp_dump_skeys(const char *filename, Error **errp)
         return;
     }
 
-    fd = qemu_open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0600);
+    fd = qemu_open_old(filename, O_WRONLY | O_CREAT | O_TRUNC, 0600);
     if (fd < 0) {
         error_setg_file_open(errp, errno, filename);
         return;
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 43c93504a2..8b02bee547 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -1147,7 +1147,7 @@ static void usb_host_realize(USBDevice *udev, Error **errp)
     if (s->hostdevice) {
         int fd;
         s->needs_autoscan = false;
-        fd = qemu_open(s->hostdevice, O_RDWR);
+        fd = qemu_open_old(s->hostdevice, O_RDWR);
         if (fd < 0) {
             error_setg_errno(errp, errno, "failed to open %s", s->hostdevice);
             return;
diff --git a/hw/usb/u2f-passthru.c b/hw/usb/u2f-passthru.c
index e9c8aa4595..ae00e93f35 100644
--- a/hw/usb/u2f-passthru.c
+++ b/hw/usb/u2f-passthru.c
@@ -383,7 +383,7 @@ static int u2f_passthru_open_from_device(struct udev_device *device)
 {
     const char *devnode = udev_device_get_devnode(device);
 
-    int fd = qemu_open(devnode, O_RDWR);
+    int fd = qemu_open_old(devnode, O_RDWR);
     if (fd < 0) {
         return -1;
     } else if (!u2f_passthru_is_u2f_device(fd)) {
@@ -482,7 +482,7 @@ static void u2f_passthru_realize(U2FKeyState *base, Error **errp)
         return;
 #endif
     } else {
-        fd = qemu_open(key->hidraw, O_RDWR);
+        fd = qemu_open_old(key->hidraw, O_RDWR);
         if (fd < 0) {
             error_setg(errp, "%s: Failed to open %s", TYPE_U2F_PASSTHRU,
                        key->hidraw);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 33357140b8..13471ae294 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1254,7 +1254,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         }
     }
 
-    fd = qemu_open("/dev/vfio/vfio", O_RDWR);
+    fd = qemu_open_old("/dev/vfio/vfio", O_RDWR);
     if (fd < 0) {
         error_setg_errno(errp, errno, "failed to open /dev/vfio/vfio");
         ret = -errno;
@@ -1479,7 +1479,7 @@ VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
     group = g_malloc0(sizeof(*group));
 
     snprintf(path, sizeof(path), "/dev/vfio/%d", groupid);
-    group->fd = qemu_open(path, O_RDWR);
+    group->fd = qemu_open_old(path, O_RDWR);
     if (group->fd < 0) {
         error_setg_errno(errp, errno, "failed to open %s", path);
         goto free_group_exit;
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 66ee5bc45d..ae1234104c 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -497,7 +497,7 @@ int qemu_madvise(void *addr, size_t len, int advice);
 int qemu_mprotect_rwx(void *addr, size_t size);
 int qemu_mprotect_none(void *addr, size_t size);
 
-int qemu_open(const char *name, int flags, ...);
+int qemu_open_old(const char *name, int flags, ...);
 int qemu_close(int fd);
 int qemu_unlink(const char *name);
 #ifndef _WIN32
diff --git a/io/channel-file.c b/io/channel-file.c
index dac21f6012..2ed3b75e8b 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -51,7 +51,7 @@ qio_channel_file_new_path(const char *path,
 
     ioc = QIO_CHANNEL_FILE(object_new(TYPE_QIO_CHANNEL_FILE));
 
-    ioc->fd = qemu_open(path, flags, mode);
+    ioc->fd = qemu_open_old(path, flags, mode);
     if (ioc->fd < 0) {
         object_unref(OBJECT(ioc));
         error_setg_errno(errp, errno,
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index bc0e0d2d35..e2b3ba85bf 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -184,7 +184,7 @@ static int net_vhost_vdpa_init(NetClientState *peer, const char *device,
     snprintf(nc->info_str, sizeof(nc->info_str), TYPE_VHOST_VDPA);
     nc->queue_index = 0;
     s = DO_UPCAST(VhostVDPAState, nc, nc);
-    vdpa_device_fd = qemu_open(vhostdev, O_RDWR);
+    vdpa_device_fd = qemu_open_old(vhostdev, O_RDWR);
     if (vdpa_device_fd == -1) {
         return -errno;
     }
diff --git a/os-posix.c b/os-posix.c
index bf98508b6d..0bfd8e2d3c 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -297,7 +297,7 @@ void os_setup_post(void)
             error_report("not able to chdir to /: %s", strerror(errno));
             exit(1);
         }
-        TFR(fd = qemu_open("/dev/null", O_RDWR));
+        TFR(fd = qemu_open_old("/dev/null", O_RDWR));
         if (fd == -1) {
             exit(1);
         }
diff --git a/qga/channel-posix.c b/qga/channel-posix.c
index 8fc205ad21..0373975360 100644
--- a/qga/channel-posix.c
+++ b/qga/channel-posix.c
@@ -127,7 +127,7 @@ static gboolean ga_channel_open(GAChannel *c, const gchar *path,
     switch (c->method) {
     case GA_CHANNEL_VIRTIO_SERIAL: {
         assert(fd < 0);
-        fd = qemu_open(path, O_RDWR | O_NONBLOCK
+        fd = qemu_open_old(path, O_RDWR | O_NONBLOCK
 #ifndef CONFIG_SOLARIS
                            | O_ASYNC
 #endif
@@ -157,7 +157,7 @@ static gboolean ga_channel_open(GAChannel *c, const gchar *path,
         struct termios tio;
 
         assert(fd < 0);
-        fd = qemu_open(path, O_RDWR | O_NOCTTY | O_NONBLOCK);
+        fd = qemu_open_old(path, O_RDWR | O_NOCTTY | O_NONBLOCK);
         if (fd == -1) {
             g_critical("error opening channel: %s", strerror(errno));
             return false;
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index af5a58a9fd..3bffee99d4 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1365,7 +1365,7 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
             }
         }
 
-        fd = qemu_open(mount->dirname, O_RDONLY);
+        fd = qemu_open_old(mount->dirname, O_RDONLY);
         if (fd == -1) {
             error_setg_errno(errp, errno, "failed to open %s", mount->dirname);
             goto error;
@@ -1432,7 +1432,7 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
 
     QTAILQ_FOREACH(mount, &mounts, next) {
         logged = false;
-        fd = qemu_open(mount->dirname, O_RDONLY);
+        fd = qemu_open_old(mount->dirname, O_RDONLY);
         if (fd == -1) {
             continue;
         }
@@ -1522,7 +1522,7 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
         list->next = response->paths;
         response->paths = list;
 
-        fd = qemu_open(mount->dirname, O_RDONLY);
+        fd = qemu_open_old(mount->dirname, O_RDONLY);
         if (fd == -1) {
             result->error = g_strdup_printf("failed to open: %s",
                                             strerror(errno));
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 2eae73315d..0dcb9bfe13 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -71,7 +71,7 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
 {
     int ret = 0, kvmfd = -1, vmfd = -1, cpufd = -1;
 
-    kvmfd = qemu_open("/dev/kvm", O_RDWR);
+    kvmfd = qemu_open_old("/dev/kvm", O_RDWR);
     if (kvmfd < 0) {
         goto err;
     }
diff --git a/ui/console.c b/ui/console.c
index f8d7643fe4..7592c3c324 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -373,7 +373,7 @@ void qmp_screendump(const char *filename, bool has_device, const char *device,
         return;
     }
 
-    fd = qemu_open(filename, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, 0666);
+    fd = qemu_open_old(filename, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, 0666);
     if (fd == -1) {
         error_setg(errp, "failed to open file '%s': %s", filename,
                    strerror(errno));
diff --git a/util/osdep.c b/util/osdep.c
index 0d8fa9f016..7504c156e8 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -296,7 +296,7 @@ static int qemu_open_cloexec(const char *name, int flags, mode_t mode)
 /*
  * Opens a file with FD_CLOEXEC set
  */
-int qemu_open(const char *name, int flags, ...)
+int qemu_open_old(const char *name, int flags, ...)
 {
     int ret;
     int mode = 0;
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index ad8001a4ad..f5f676f079 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -125,7 +125,7 @@ bool qemu_write_pidfile(const char *path, Error **errp)
             .l_len = 0,
         };
 
-        fd = qemu_open(path, O_CREAT | O_WRONLY, S_IRUSR | S_IWUSR);
+        fd = qemu_open_old(path, O_CREAT | O_WRONLY, S_IRUSR | S_IWUSR);
         if (fd == -1) {
             error_setg_errno(errp, errno, "Cannot open pid file");
             return false;
-- 
2.26.2


