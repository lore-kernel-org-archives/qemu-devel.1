Received: from eggs.gnu.org ([2001:4830:134:3::10]:47019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dz0LN-0001UL-BD
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:01:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dz0LH-0004KV-MH
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:01:09 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:55731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pradeepkiruvale@gmail.com>)
	id 1dz0LH-0004JZ-Fo
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:01:03 -0400
Received: by mail-wm0-x244.google.com with SMTP id u138so10419544wmu.4
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 06:01:02 -0700 (PDT)
From: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Date: Mon,  2 Oct 2017 09:00:28 -0400
Message-Id: <1506949228-48987-1-git-send-email-pradeep.jagadeesh@huawei.com>
Subject: [Qemu-devel] [PATCH v0] block: replace throttle config strings with
 macros
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, alberto garcia <berto@igalia.com>, eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

This patch set uses the throttle macros to replace throttle 
config strings.

Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
---
 blockdev.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 56a6b24..153bc42 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -383,7 +383,8 @@ static void extract_common_blockdev_options(QemuOpts *opts, int *bdrv_flags,
 
     /* disk I/O throttling */
     if (throttling_group) {
-        *throttling_group = qemu_opt_get(opts, "throttling.group");
+        *throttling_group = qemu_opt_get(opts, THROTTLE_OPT_PREFIX
+                                         QEMU_OPT_THROTTLE_GROUP_NAME);
     }
 
     if (throttle_cfg) {
@@ -802,25 +803,25 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
         const char *from;
         const char *to;
     } opt_renames[] = {
-        { "iops",           "throttling.iops-total" },
-        { "iops_rd",        "throttling.iops-read" },
-        { "iops_wr",        "throttling.iops-write" },
+        { "iops",           THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL },
+        { "iops_rd",        THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ },
+        { "iops_wr",        THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE },
 
-        { "bps",            "throttling.bps-total" },
-        { "bps_rd",         "throttling.bps-read" },
-        { "bps_wr",         "throttling.bps-write" },
+        { "bps",            THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL },
+        { "bps_rd",         THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ },
+        { "bps_wr",         THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE },
 
-        { "iops_max",       "throttling.iops-total-max" },
-        { "iops_rd_max",    "throttling.iops-read-max" },
-        { "iops_wr_max",    "throttling.iops-write-max" },
+        { "iops_max",       THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_TOTAL_MAX },
+        { "iops_rd_max",    THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_READ_MAX },
+        { "iops_wr_max",    THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_WRITE_MAX },
 
-        { "bps_max",        "throttling.bps-total-max" },
-        { "bps_rd_max",     "throttling.bps-read-max" },
-        { "bps_wr_max",     "throttling.bps-write-max" },
+        { "bps_max",        THROTTLE_OPT_PREFIX QEMU_OPT_BPS_TOTAL_MAX },
+        { "bps_rd_max",     THROTTLE_OPT_PREFIX QEMU_OPT_BPS_READ_MAX },
+        { "bps_wr_max",     THROTTLE_OPT_PREFIX QEMU_OPT_BPS_WRITE_MAX },
 
-        { "iops_size",      "throttling.iops-size" },
+        { "iops_size",      THROTTLE_OPT_PREFIX QEMU_OPT_IOPS_SIZE },
 
-        { "group",          "throttling.group" },
+        { "group",          THROTTLE_OPT_PREFIX QEMU_OPT_THROTTLE_GROUP_NAME },
 
         { "readonly",       BDRV_OPT_READ_ONLY },
     };
@@ -4089,7 +4090,7 @@ QemuOptsList qemu_common_drive_opts = {
         THROTTLE_OPTS,
 
         {
-            .name = "throttling.group",
+            .name = THROTTLE_OPT_PREFIX QEMU_OPT_THROTTLE_GROUP_NAME,
             .type = QEMU_OPT_STRING,
             .help = "name of the block throttling group",
         },{
-- 
1.8.3.1
