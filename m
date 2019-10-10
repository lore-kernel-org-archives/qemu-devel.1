Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B82EC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:28:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1EFC206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1EFC206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39515 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIYUc-00072L-RH
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 09:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iIYKq-00028A-FV
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iIYKo-0002wh-Ht
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:18:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17898
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iIYKo-0002uN-CK
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:18:26 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9ADHi12042860
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 09:18:19 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vj52y0xx4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 09:18:19 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Thu, 10 Oct 2019 14:18:17 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 10 Oct 2019 14:18:15 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x9ADIEdE36044994
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2019 13:18:14 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8844CAE053;
 Thu, 10 Oct 2019 13:18:14 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6AC61AE04D;
 Thu, 10 Oct 2019 13:18:14 +0000 (GMT)
Received: from smtp.tls.ibm.com (unknown [9.101.4.1])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 10 Oct 2019 13:18:14 +0000 (GMT)
Received: from bahia.tls.ibm.com (bahia.tls.ibm.com [9.101.4.41])
 by smtp.tls.ibm.com (Postfix) with ESMTP id 2D9C5220208;
 Thu, 10 Oct 2019 15:18:14 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 1/8] 9p: unsigned type for type, version, path
Date: Thu, 10 Oct 2019 15:18:02 +0200
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191010131809.1284004-1-groug@kaod.org>
References: <20191010131809.1284004-1-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19101013-0016-0000-0000-000002B6DEC0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101013-0017-0000-0000-00003317EB87
Message-Id: <20191010131809.1284004-2-groug@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-10_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=825 adultscore=0 classifier=spam adjust=0 reason=mlx
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

There is no need for signedness on these QID fields for 9p.

Signed-off-by: Antonios Motakis <antonios.motakis@huawei.com>
[CS: - Also make QID type unsigned.
     - Adjust donttouch_stat() to new types.
     - Adjust trace-events to new types. ]
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 fsdev/9p-marshal.h   |  6 +++---
 hw/9pfs/9p.c         |  6 +++---
 hw/9pfs/trace-events | 14 +++++++-------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fsdev/9p-marshal.h b/fsdev/9p-marshal.h
index c8823d878f98..8f3babb60a05 100644
--- a/fsdev/9p-marshal.h
+++ b/fsdev/9p-marshal.h
@@ -9,9 +9,9 @@ typedef struct V9fsString
 
 typedef struct V9fsQID
 {
-    int8_t type;
-    int32_t version;
-    int64_t path;
+    uint8_t type;
+    uint32_t version;
+    uint64_t path;
 } V9fsQID;
 
 typedef struct V9fsStat
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index cce2366219be..cf317bdd2b92 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -744,9 +744,9 @@ static int donttouch_stat(V9fsStat *stat)
 {
     if (stat->type == -1 &&
         stat->dev == -1 &&
-        stat->qid.type == -1 &&
-        stat->qid.version == -1 &&
-        stat->qid.path == -1 &&
+        stat->qid.type == 0xff &&
+        stat->qid.version == (uint32_t) -1 &&
+        stat->qid.path == (uint64_t) -1 &&
         stat->mode == -1 &&
         stat->atime == -1 &&
         stat->mtime == -1 &&
diff --git a/hw/9pfs/trace-events b/hw/9pfs/trace-events
index c0a0a4ab5de8..10188daf7fa5 100644
--- a/hw/9pfs/trace-events
+++ b/hw/9pfs/trace-events
@@ -6,7 +6,7 @@ v9fs_rerror(uint16_t tag, uint8_t id, int err) "tag %d id %d err %d"
 v9fs_version(uint16_t tag, uint8_t id, int32_t msize, char* version) "tag %d id %d msize %d version %s"
 v9fs_version_return(uint16_t tag, uint8_t id, int32_t msize, char* version) "tag %d id %d msize %d version %s"
 v9fs_attach(uint16_t tag, uint8_t id, int32_t fid, int32_t afid, char* uname, char* aname) "tag %u id %u fid %d afid %d uname %s aname %s"
-v9fs_attach_return(uint16_t tag, uint8_t id, int8_t type, int32_t version, int64_t path) "tag %d id %d type %d version %d path %"PRId64
+v9fs_attach_return(uint16_t tag, uint8_t id, uint8_t type, uint32_t version, uint64_t path) "tag %u id %u type %u version %u path %"PRIu64
 v9fs_stat(uint16_t tag, uint8_t id, int32_t fid) "tag %d id %d fid %d"
 v9fs_stat_return(uint16_t tag, uint8_t id, int32_t mode, int32_t atime, int32_t mtime, int64_t length) "tag %d id %d stat={mode %d atime %d mtime %d length %"PRId64"}"
 v9fs_getattr(uint16_t tag, uint8_t id, int32_t fid, uint64_t request_mask) "tag %d id %d fid %d request_mask %"PRIu64
@@ -14,9 +14,9 @@ v9fs_getattr_return(uint16_t tag, uint8_t id, uint64_t result_mask, uint32_t mod
 v9fs_walk(uint16_t tag, uint8_t id, int32_t fid, int32_t newfid, uint16_t nwnames) "tag %d id %d fid %d newfid %d nwnames %d"
 v9fs_walk_return(uint16_t tag, uint8_t id, uint16_t nwnames, void* qids) "tag %d id %d nwnames %d qids %p"
 v9fs_open(uint16_t tag, uint8_t id, int32_t fid, int32_t mode) "tag %d id %d fid %d mode %d"
-v9fs_open_return(uint16_t tag, uint8_t id, int8_t type, int32_t version, int64_t path, int iounit) "tag %d id %d qid={type %d version %d path %"PRId64"} iounit %d"
+v9fs_open_return(uint16_t tag, uint8_t id, uint8_t type, uint32_t version, uint64_t path, int iounit) "tag %u id %u qid={type %u version %u path %"PRIu64"} iounit %d"
 v9fs_lcreate(uint16_t tag, uint8_t id, int32_t dfid, int32_t flags, int32_t mode, uint32_t gid) "tag %d id %d dfid %d flags %d mode %d gid %u"
-v9fs_lcreate_return(uint16_t tag, uint8_t id, int8_t type, int32_t version, int64_t path, int32_t iounit) "tag %d id %d qid={type %d version %d path %"PRId64"} iounit %d"
+v9fs_lcreate_return(uint16_t tag, uint8_t id, uint8_t type, uint32_t version, uint64_t path, int32_t iounit) "tag %u id %u qid={type %u version %u path %"PRIu64"} iounit %d"
 v9fs_fsync(uint16_t tag, uint8_t id, int32_t fid, int datasync) "tag %d id %d fid %d datasync %d"
 v9fs_clunk(uint16_t tag, uint8_t id, int32_t fid) "tag %d id %d fid %d"
 v9fs_read(uint16_t tag, uint8_t id, int32_t fid, uint64_t off, uint32_t max_count) "tag %d id %d fid %d off %"PRIu64" max_count %u"
@@ -26,21 +26,21 @@ v9fs_readdir_return(uint16_t tag, uint8_t id, uint32_t count, ssize_t retval) "t
 v9fs_write(uint16_t tag, uint8_t id, int32_t fid, uint64_t off, uint32_t count, int cnt) "tag %d id %d fid %d off %"PRIu64" count %u cnt %d"
 v9fs_write_return(uint16_t tag, uint8_t id, int32_t total, ssize_t err) "tag %d id %d total %d err %zd"
 v9fs_create(uint16_t tag, uint8_t id, int32_t fid, char* name, int32_t perm, int8_t mode) "tag %d id %d fid %d name %s perm %d mode %d"
-v9fs_create_return(uint16_t tag, uint8_t id, int8_t type, int32_t version, int64_t path, int iounit) "tag %d id %d qid={type %d version %d path %"PRId64"} iounit %d"
+v9fs_create_return(uint16_t tag, uint8_t id, uint8_t type, uint32_t version, uint64_t path, int iounit) "tag %u id %u qid={type %u version %u path %"PRIu64"} iounit %d"
 v9fs_symlink(uint16_t tag, uint8_t id, int32_t fid,  char* name, char* symname, uint32_t gid) "tag %d id %d fid %d name %s symname %s gid %u"
-v9fs_symlink_return(uint16_t tag, uint8_t id, int8_t type, int32_t version, int64_t path) "tag %d id %d qid={type %d version %d path %"PRId64"}"
+v9fs_symlink_return(uint16_t tag, uint8_t id, uint8_t type, uint32_t version, uint64_t path) "tag %u id %u qid={type %u version %u path %"PRIu64"}"
 v9fs_flush(uint16_t tag, uint8_t id, int16_t flush_tag) "tag %d id %d flush_tag %d"
 v9fs_link(uint16_t tag, uint8_t id, int32_t dfid, int32_t oldfid, char* name) "tag %d id %d dfid %d oldfid %d name %s"
 v9fs_remove(uint16_t tag, uint8_t id, int32_t fid) "tag %d id %d fid %d"
 v9fs_wstat(uint16_t tag, uint8_t id, int32_t fid, int32_t mode, int32_t atime, int32_t mtime) "tag %u id %u fid %d stat={mode %d atime %d mtime %d}"
 v9fs_mknod(uint16_t tag, uint8_t id, int32_t fid, int mode, int major, int minor) "tag %d id %d fid %d mode %d major %d minor %d"
-v9fs_mknod_return(uint16_t tag, uint8_t id, int8_t type, int32_t version, int64_t path) "tag %d id %d qid={type %d version %d path %"PRId64"}"
+v9fs_mknod_return(uint16_t tag, uint8_t id, uint8_t type, uint32_t version, uint64_t path) "tag %u id %u qid={type %u version %u path %"PRIu64"}"
 v9fs_lock(uint16_t tag, uint8_t id, int32_t fid, uint8_t type, uint64_t start, uint64_t length) "tag %d id %d fid %d type %d start %"PRIu64" length %"PRIu64
 v9fs_lock_return(uint16_t tag, uint8_t id, int8_t status) "tag %d id %d status %d"
 v9fs_getlock(uint16_t tag, uint8_t id, int32_t fid, uint8_t type, uint64_t start, uint64_t length)"tag %d id %d fid %d type %d start %"PRIu64" length %"PRIu64
 v9fs_getlock_return(uint16_t tag, uint8_t id, uint8_t type, uint64_t start, uint64_t length, uint32_t proc_id) "tag %d id %d type %d start %"PRIu64" length %"PRIu64" proc_id %u"
 v9fs_mkdir(uint16_t tag, uint8_t id, int32_t fid, char* name, int mode, uint32_t gid) "tag %u id %u fid %d name %s mode %d gid %u"
-v9fs_mkdir_return(uint16_t tag, uint8_t id, int8_t type, int32_t version, int64_t path, int err) "tag %u id %u qid={type %d version %d path %"PRId64"} err %d"
+v9fs_mkdir_return(uint16_t tag, uint8_t id, uint8_t type, uint32_t version, uint64_t path, int err) "tag %u id %u qid={type %u version %u path %"PRIu64"} err %d"
 v9fs_xattrwalk(uint16_t tag, uint8_t id, int32_t fid, int32_t newfid, char* name) "tag %d id %d fid %d newfid %d name %s"
 v9fs_xattrwalk_return(uint16_t tag, uint8_t id, int64_t size) "tag %d id %d size %"PRId64
 v9fs_xattrcreate(uint16_t tag, uint8_t id, int32_t fid, char* name, uint64_t size, int flags) "tag %d id %d fid %d name %s size %"PRIu64" flags %d"
-- 
2.21.0


