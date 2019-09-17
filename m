Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376CFC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:23:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDD42214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD42214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAAdj-0008Ig-Ij
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 06:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iAAbS-0006RZ-KF
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:21:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iAAbQ-0003bm-Oc
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:20:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5540
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iAAbQ-0003bX-JL
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:20:56 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8HAHIgK083442
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 06:20:55 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2v2tkpqnen-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 06:20:55 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Tue, 17 Sep 2019 11:20:52 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 17 Sep 2019 11:20:46 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8HAKini49807392
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Sep 2019 10:20:44 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A60F04C062;
 Tue, 17 Sep 2019 10:20:44 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A2B2F4C046;
 Tue, 17 Sep 2019 10:20:43 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.22.84])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 17 Sep 2019 10:20:43 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Date: Tue, 17 Sep 2019 12:20:43 +0200
In-Reply-To: <156871562997.196432.17776290406203122029.stgit@bahia.lan>
References: <156871562997.196432.17776290406203122029.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19091710-0020-0000-0000-0000036E12AC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091710-0021-0000-0000-000021C3B657
Message-Id: <156871564329.196432.5930574495661947805.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-17_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909170106
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH 02/17] block: Pass local error object pointer
 to error_append_hint()
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Eric Farman <farman@linux.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Yuval Shaia <yuval.shaia@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Daniel P. =?utf-8?q?Berrang=C3=A9=22?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org"@d06av22.portsmouth.uk.ibm.com,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ensure that hints are added even if errp is &error_fatal or &error_abort.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 block/backup.c       |    7 +++++--
 block/dirty-bitmap.c |    7 +++++--
 block/file-posix.c   |   20 +++++++++++++-------
 block/gluster.c      |   23 +++++++++++++++--------
 block/qcow.c         |   10 ++++++----
 block/qcow2.c        |    7 +++++--
 block/vhdx-log.c     |    7 +++++--
 block/vpc.c          |    7 +++++--
 8 files changed, 59 insertions(+), 29 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 763f0d7ff6db..d8c422a0e3bc 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -602,11 +602,14 @@ static int64_t backup_calculate_cluster_size(BlockDriverState *target,
                     BACKUP_CLUSTER_SIZE_DEFAULT);
         return BACKUP_CLUSTER_SIZE_DEFAULT;
     } else if (ret < 0 && !target->backing) {
-        error_setg_errno(errp, -ret,
+        Error *local_err = NULL;
+
+        error_setg_errno(&local_err, -ret,
             "Couldn't determine the cluster size of the target image, "
             "which has no backing file");
-        error_append_hint(errp,
+        error_append_hint(&local_err,
             "Aborting, since this may create an unusable destination image\n");
+        error_propagate(errp, local_err);
         return ret;
     } else if (ret < 0 && target->backing) {
         /* Not fatal; just trudge on ahead. */
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 134e0c9a0c8f..b31017a77d51 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -251,10 +251,13 @@ int bdrv_dirty_bitmap_check(const BdrvDirtyBitmap *bitmap, uint32_t flags,
 
     if ((flags & BDRV_BITMAP_INCONSISTENT) &&
         bdrv_dirty_bitmap_inconsistent(bitmap)) {
-        error_setg(errp, "Bitmap '%s' is inconsistent and cannot be used",
+        Error *local_err = NULL;
+
+        error_setg(&local_err, "Bitmap '%s' is inconsistent and cannot be used",
                    bitmap->name);
-        error_append_hint(errp, "Try block-dirty-bitmap-remove to delete"
+        error_append_hint(&local_err, "Try block-dirty-bitmap-remove to delete"
                           " this bitmap from disk");
+        error_propagate(errp, local_err);
         return -1;
     }
 
diff --git a/block/file-posix.c b/block/file-posix.c
index f12c06de2df5..9a95f7e94123 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -389,8 +389,11 @@ static void raw_probe_alignment(BlockDriverState *bs, int fd, Error **errp)
     }
 
     if (!s->buf_align || !bs->bl.request_alignment) {
-        error_setg(errp, "Could not find working O_DIRECT alignment");
-        error_append_hint(errp, "Try cache.direct=off\n");
+        Error *local_err = NULL;
+
+        error_setg(&local_err, "Could not find working O_DIRECT alignment");
+        error_append_hint(&local_err, "Try cache.direct=off\n");
+        error_propagate(errp, local_err);
     }
 }
 
@@ -845,16 +848,18 @@ static int raw_handle_perm_lock(BlockDriverState *bs,
         }
         ret = raw_apply_lock_bytes(s, s->fd, s->perm | new_perm,
                                    ~s->shared_perm | ~new_shared,
-                                   false, errp);
+                                   false, &local_err);
         if (!ret) {
-            ret = raw_check_lock_bytes(s->fd, new_perm, new_shared, errp);
+            ret = raw_check_lock_bytes(s->fd, new_perm, new_shared, &local_err);
             if (!ret) {
                 return 0;
             }
-            error_append_hint(errp,
+            error_append_hint(&local_err,
                               "Is another process using the image [%s]?\n",
                               bs->filename);
         }
+        error_propagate(errp, local_err);
+        local_err = NULL; /* for fall through */
         op = RAW_PL_ABORT;
         /* fall through to unlock bytes. */
     case RAW_PL_ABORT:
@@ -2277,11 +2282,12 @@ raw_co_create(BlockdevCreateOptions *options, Error **errp)
     }
 
     /* Step two: Check that nobody else has taken conflicting locks */
-    result = raw_check_lock_bytes(fd, perm, shared, errp);
+    result = raw_check_lock_bytes(fd, perm, shared, &local_err);
     if (result < 0) {
-        error_append_hint(errp,
+        error_append_hint(&local_err,
                           "Is another process using the image [%s]?\n",
                           file_opts->filename);
+        error_propagate(errp, local_err);
         goto out_unlock;
     }
 
diff --git a/block/gluster.c b/block/gluster.c
index 64028b2cba30..dce42884f97c 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -473,26 +473,29 @@ static struct glfs *qemu_gluster_glfs_init(BlockdevOptionsGluster *gconf,
 
     ret = glfs_init(glfs);
     if (ret) {
-        error_setg(errp, "Gluster connection for volume %s, path %s failed"
+        Error *local_err = NULL;
+
+        error_setg(&local_err, "Gluster connection for volume %s, path %s failed"
                          " to connect", gconf->volume, gconf->path);
         for (server = gconf->server; server; server = server->next) {
             if (server->value->type  == SOCKET_ADDRESS_TYPE_UNIX) {
-                error_append_hint(errp, "hint: failed on socket %s ",
+                error_append_hint(&local_err, "hint: failed on socket %s ",
                                   server->value->u.q_unix.path);
             } else {
-                error_append_hint(errp, "hint: failed on host %s and port %s ",
+                error_append_hint(&local_err, "hint: failed on host %s and port %s ",
                                   server->value->u.inet.host,
                                   server->value->u.inet.port);
             }
         }
 
-        error_append_hint(errp, "Please refer to gluster logs for more info\n");
+        error_append_hint(&local_err, "Please refer to gluster logs for more info\n");
 
         /* glfs_init sometimes doesn't set errno although docs suggest that */
         if (errno == 0) {
             errno = EINVAL;
         }
 
+        error_propagate(errp, local_err);
         goto out;
     }
     return glfs;
@@ -695,20 +698,23 @@ static int qemu_gluster_parse(BlockdevOptionsGluster *gconf,
                               QDict *options, Error **errp)
 {
     int ret;
+    Error *local_err = NULL;
+
     if (filename) {
         ret = qemu_gluster_parse_uri(gconf, filename);
         if (ret < 0) {
-            error_setg(errp, "invalid URI %s", filename);
-            error_append_hint(errp, "Usage: file=gluster[+transport]://"
+            error_setg(&local_err, "invalid URI %s", filename);
+            error_append_hint(&local_err, "Usage: file=gluster[+transport]://"
                                     "[host[:port]]volume/path[?socket=...]"
                                     "[,file.debug=N]"
                                     "[,file.logfile=/path/filename.log]\n");
+            error_propagate(errp, local_err);
             return ret;
         }
     } else {
-        ret = qemu_gluster_parse_json(gconf, options, errp);
+        ret = qemu_gluster_parse_json(gconf, options, &local_err);
         if (ret < 0) {
-            error_append_hint(errp, "Usage: "
+            error_append_hint(&local_err, "Usage: "
                              "-drive driver=qcow2,file.driver=gluster,"
                              "file.volume=testvol,file.path=/path/a.qcow2"
                              "[,file.debug=9]"
@@ -719,6 +725,7 @@ static int qemu_gluster_parse(BlockdevOptionsGluster *gconf,
                              "file.server.1.transport=unix,"
                              "file.server.1.path=/var/run/glusterd.socket ..."
                              "\n");
+            error_propagate(errp, local_err);
             return ret;
         }
     }
diff --git a/block/qcow.c b/block/qcow.c
index 5bdf72ba33ce..9049573b52b2 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -156,11 +156,12 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
     if (header.version != QCOW_VERSION) {
-        error_setg(errp, "qcow (v%d) does not support qcow version %" PRIu32,
+        error_setg(&local_err, "qcow (v%d) does not support qcow version %" PRIu32,
                    QCOW_VERSION, header.version);
         if (header.version == 2 || header.version == 3) {
-            error_append_hint(errp, "Try the 'qcow2' driver instead.\n");
+            error_append_hint(&local_err, "Try the 'qcow2' driver instead.\n");
         }
+        error_propagate(errp, local_err);
 
         ret = -ENOTSUP;
         goto fail;
@@ -189,14 +190,15 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
     if (s->crypt_method_header) {
         if (bdrv_uses_whitelist() &&
             s->crypt_method_header == QCOW_CRYPT_AES) {
-            error_setg(errp,
+            error_setg(&local_err,
                        "Use of AES-CBC encrypted qcow images is no longer "
                        "supported in system emulators");
-            error_append_hint(errp,
+            error_append_hint(&local_err,
                               "You can use 'qemu-img convert' to convert your "
                               "image to an alternative supported format, such "
                               "as unencrypted qcow, or raw with the LUKS "
                               "format instead.\n");
+            error_propagate(errp, local_err);
             ret = -ENOSYS;
             goto fail;
         }
diff --git a/block/qcow2.c b/block/qcow2.c
index 57734f20cf8d..2c52139b7385 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1357,14 +1357,17 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
     if (s->crypt_method_header) {
         if (bdrv_uses_whitelist() &&
             s->crypt_method_header == QCOW_CRYPT_AES) {
-            error_setg(errp,
+            Error *local_err = NULL;
+
+            error_setg(&local_err,
                        "Use of AES-CBC encrypted qcow2 images is no longer "
                        "supported in system emulators");
-            error_append_hint(errp,
+            error_append_hint(&local_err,
                               "You can use 'qemu-img convert' to convert your "
                               "image to an alternative supported format, such "
                               "as unencrypted qcow2, or raw with the LUKS "
                               "format instead.\n");
+            error_propagate(errp, local_err);
             ret = -ENOSYS;
             goto fail;
         }
diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index fdd3a7adc378..9f4de9cbcdb6 100644
--- a/block/vhdx-log.c
+++ b/block/vhdx-log.c
@@ -802,15 +802,18 @@ int vhdx_parse_log(BlockDriverState *bs, BDRVVHDXState *s, bool *flushed,
 
     if (logs.valid) {
         if (bs->read_only) {
+            Error *local_err = NULL;
+
             bdrv_refresh_filename(bs);
             ret = -EPERM;
-            error_setg(errp,
+            error_setg(&local_err,
                        "VHDX image file '%s' opened read-only, but "
                        "contains a log that needs to be replayed",
                        bs->filename);
-            error_append_hint(errp,  "To replay the log, run:\n"
+            error_append_hint(&local_err,  "To replay the log, run:\n"
                               "qemu-img check -r all '%s'\n",
                               bs->filename);
+            error_propagate(errp, local_err);
             goto exit;
         }
         /* now flush the log */
diff --git a/block/vpc.c b/block/vpc.c
index 5cd38907808b..facd7cdb2c98 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -1028,12 +1028,15 @@ static int coroutine_fn vpc_co_create(BlockdevCreateOptions *opts,
     }
 
     if (total_size != total_sectors * BDRV_SECTOR_SIZE) {
-        error_setg(errp, "The requested image size cannot be represented in "
+        Error *local_err = NULL;
+
+        error_setg(&local_err, "The requested image size cannot be represented in "
                          "CHS geometry");
-        error_append_hint(errp, "Try size=%llu or force-size=on (the "
+        error_append_hint(&local_err, "Try size=%llu or force-size=on (the "
                                 "latter makes the image incompatible with "
                                 "Virtual PC)",
                           total_sectors * BDRV_SECTOR_SIZE);
+        error_propagate(errp, local_err);
         ret = -EINVAL;
         goto out;
     }


