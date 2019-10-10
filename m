Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422A0C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:32:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 156642067B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 156642067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIYYg-0002Pp-TY
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 09:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iIYM9-0003TT-Gc
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:19:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iIYM7-0003YR-Pp
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:19:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48296
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iIYM7-0003Xt-L0
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:19:47 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9ADJa5g178991
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 09:19:46 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vj38ym62h-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 09:19:44 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Thu, 10 Oct 2019 14:18:18 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 10 Oct 2019 14:18:15 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x9ADIEJL62128378
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2019 13:18:14 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B20DC42047;
 Thu, 10 Oct 2019 13:18:14 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DB2342042;
 Thu, 10 Oct 2019 13:18:14 +0000 (GMT)
Received: from smtp.tls.ibm.com (unknown [9.101.4.1])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 10 Oct 2019 13:18:14 +0000 (GMT)
Received: from bahia.tls.ibm.com (bahia.tls.ibm.com [9.101.4.41])
 by smtp.tls.ibm.com (Postfix) with ESMTP id 60B8D22031C;
 Thu, 10 Oct 2019 15:18:14 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 4/8] 9p: Treat multiple devices on one export as an error
Date: Thu, 10 Oct 2019 15:18:05 +0200
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191010131809.1284004-1-groug@kaod.org>
References: <20191010131809.1284004-1-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19101013-0008-0000-0000-00000320DF1A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101013-0009-0000-0000-00004A3FE844
Message-Id: <20191010131809.1284004-5-groug@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-10_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910100125
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Antonios Motakis <antonios.motakis@huawei.com>

The QID path should uniquely identify a file. However, the
inode of a file is currently used as the QID path, which
on its own only uniquely identifies files within a device.
Here we track the device hosting the 9pfs share, in order
to prevent security issues with QID path collisions from
other devices.

We only print a warning for now but a subsequent patch will
allow users to have finer control over the desired behaviour.
Failing the I/O will be one the proposed behaviour, so we
also change stat_to_qid() to return an error here in order to
keep other patches simpler.

Signed-off-by: Antonios Motakis <antonios.motakis@huawei.com>
[CS: - Assign dev_id to export root's device already in
       v9fs_device_realize_common(), not postponed in
       stat_to_qid().
     - error_report_once() if more than one device was
       shared by export.
     - Return -ENODEV instead of -ENOSYS in stat_to_qid().
     - Fixed typo in log comment. ]
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
[groug, changed to warning, updated message and changelog]
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c | 70 +++++++++++++++++++++++++++++++++++++++++-----------
 hw/9pfs/9p.h |  1 +
 2 files changed, 57 insertions(+), 14 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index ba1ab920f1eb..5a895ae0bbfe 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -573,10 +573,19 @@ static void coroutine_fn virtfs_reset(V9fsPDU *pdu)
                                 P9_STAT_MODE_SOCKET)
 
 /* This is the algorithm from ufs in spfs */
-static void stat_to_qid(const struct stat *stbuf, V9fsQID *qidp)
+static int stat_to_qid(V9fsPDU *pdu, const struct stat *stbuf, V9fsQID *qidp)
 {
     size_t size;
 
+    if (pdu->s->dev_id != stbuf->st_dev) {
+        warn_report_once(
+            "9p: Multiple devices detected in same VirtFS export, "
+            "which might lead to file ID collisions and severe "
+            "misbehaviours on guest! You should use a separate "
+            "export for each device shared from host."
+        );
+    }
+
     memset(&qidp->path, 0, sizeof(qidp->path));
     size = MIN(sizeof(stbuf->st_ino), sizeof(qidp->path));
     memcpy(&qidp->path, &stbuf->st_ino, size);
@@ -588,6 +597,8 @@ static void stat_to_qid(const struct stat *stbuf, V9fsQID *qidp)
     if (S_ISLNK(stbuf->st_mode)) {
         qidp->type |= P9_QID_TYPE_SYMLINK;
     }
+
+    return 0;
 }
 
 static int coroutine_fn fid_to_qid(V9fsPDU *pdu, V9fsFidState *fidp,
@@ -600,7 +611,10 @@ static int coroutine_fn fid_to_qid(V9fsPDU *pdu, V9fsFidState *fidp,
     if (err < 0) {
         return err;
     }
-    stat_to_qid(&stbuf, qidp);
+    err = stat_to_qid(pdu, &stbuf, qidp);
+    if (err < 0) {
+        return err;
+    }
     return 0;
 }
 
@@ -831,7 +845,10 @@ static int coroutine_fn stat_to_v9stat(V9fsPDU *pdu, V9fsPath *path,
 
     memset(v9stat, 0, sizeof(*v9stat));
 
-    stat_to_qid(stbuf, &v9stat->qid);
+    err = stat_to_qid(pdu, stbuf, &v9stat->qid);
+    if (err < 0) {
+        return err;
+    }
     v9stat->mode = stat_to_v9mode(stbuf);
     v9stat->atime = stbuf->st_atime;
     v9stat->mtime = stbuf->st_mtime;
@@ -892,7 +909,7 @@ static int coroutine_fn stat_to_v9stat(V9fsPDU *pdu, V9fsPath *path,
 #define P9_STATS_ALL           0x00003fffULL /* Mask for All fields above */
 
 
-static void stat_to_v9stat_dotl(V9fsState *s, const struct stat *stbuf,
+static int stat_to_v9stat_dotl(V9fsPDU *pdu, const struct stat *stbuf,
                                 V9fsStatDotl *v9lstat)
 {
     memset(v9lstat, 0, sizeof(*v9lstat));
@@ -914,7 +931,7 @@ static void stat_to_v9stat_dotl(V9fsState *s, const struct stat *stbuf,
     /* Currently we only support BASIC fields in stat */
     v9lstat->st_result_mask = P9_STATS_BASIC;
 
-    stat_to_qid(stbuf, &v9lstat->qid);
+    return stat_to_qid(pdu, stbuf, &v9lstat->qid);
 }
 
 static void print_sg(struct iovec *sg, int cnt)
@@ -1116,7 +1133,6 @@ static void coroutine_fn v9fs_getattr(void *opaque)
     uint64_t request_mask;
     V9fsStatDotl v9stat_dotl;
     V9fsPDU *pdu = opaque;
-    V9fsState *s = pdu->s;
 
     retval = pdu_unmarshal(pdu, offset, "dq", &fid, &request_mask);
     if (retval < 0) {
@@ -1137,7 +1153,10 @@ static void coroutine_fn v9fs_getattr(void *opaque)
     if (retval < 0) {
         goto out;
     }
-    stat_to_v9stat_dotl(s, &stbuf, &v9stat_dotl);
+    retval = stat_to_v9stat_dotl(pdu, &stbuf, &v9stat_dotl);
+    if (retval < 0) {
+        goto out;
+    }
 
     /*  fill st_gen if requested and supported by underlying fs */
     if (request_mask & P9_STATS_GEN) {
@@ -1382,7 +1401,10 @@ static void coroutine_fn v9fs_walk(void *opaque)
             if (err < 0) {
                 goto out;
             }
-            stat_to_qid(&stbuf, &qid);
+            err = stat_to_qid(pdu, &stbuf, &qid);
+            if (err < 0) {
+                goto out;
+            }
             v9fs_path_copy(&dpath, &path);
         }
         memcpy(&qids[name_idx], &qid, sizeof(qid));
@@ -1484,7 +1506,10 @@ static void coroutine_fn v9fs_open(void *opaque)
     if (err < 0) {
         goto out;
     }
-    stat_to_qid(&stbuf, &qid);
+    err = stat_to_qid(pdu, &stbuf, &qid);
+    if (err < 0) {
+        goto out;
+    }
     if (S_ISDIR(stbuf.st_mode)) {
         err = v9fs_co_opendir(pdu, fidp);
         if (err < 0) {
@@ -1594,7 +1619,10 @@ static void coroutine_fn v9fs_lcreate(void *opaque)
         fidp->flags |= FID_NON_RECLAIMABLE;
     }
     iounit =  get_iounit(pdu, &fidp->path);
-    stat_to_qid(&stbuf, &qid);
+    err = stat_to_qid(pdu, &stbuf, &qid);
+    if (err < 0) {
+        goto out;
+    }
     err = pdu_marshal(pdu, offset, "Qd", &qid, iounit);
     if (err < 0) {
         goto out;
@@ -2328,7 +2356,10 @@ static void coroutine_fn v9fs_create(void *opaque)
         }
     }
     iounit = get_iounit(pdu, &fidp->path);
-    stat_to_qid(&stbuf, &qid);
+    err = stat_to_qid(pdu, &stbuf, &qid);
+    if (err < 0) {
+        goto out;
+    }
     err = pdu_marshal(pdu, offset, "Qd", &qid, iounit);
     if (err < 0) {
         goto out;
@@ -2385,7 +2416,10 @@ static void coroutine_fn v9fs_symlink(void *opaque)
     if (err < 0) {
         goto out;
     }
-    stat_to_qid(&stbuf, &qid);
+    err = stat_to_qid(pdu, &stbuf, &qid);
+    if (err < 0) {
+        goto out;
+    }
     err =  pdu_marshal(pdu, offset, "Q", &qid);
     if (err < 0) {
         goto out;
@@ -3065,7 +3099,10 @@ static void coroutine_fn v9fs_mknod(void *opaque)
     if (err < 0) {
         goto out;
     }
-    stat_to_qid(&stbuf, &qid);
+    err = stat_to_qid(pdu, &stbuf, &qid);
+    if (err < 0) {
+        goto out;
+    }
     err = pdu_marshal(pdu, offset, "Q", &qid);
     if (err < 0) {
         goto out;
@@ -3223,7 +3260,10 @@ static void coroutine_fn v9fs_mkdir(void *opaque)
     if (err < 0) {
         goto out;
     }
-    stat_to_qid(&stbuf, &qid);
+    err = stat_to_qid(pdu, &stbuf, &qid);
+    if (err < 0) {
+        goto out;
+    }
     err = pdu_marshal(pdu, offset, "Q", &qid);
     if (err < 0) {
         goto out;
@@ -3634,6 +3674,8 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
         goto out;
     }
 
+    s->dev_id = stat.st_dev;
+
     s->ctx.fst = &fse->fst;
     fsdev_throttle_init(s->ctx.fst);
 
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 8883761b2c1d..5e316178d579 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -256,6 +256,7 @@ struct V9fsState
     Error *migration_blocker;
     V9fsConf fsconf;
     V9fsQID root_qid;
+    dev_t dev_id;
 };
 
 /* 9p2000.L open flags */
-- 
2.21.0


