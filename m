Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167BDC35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 10:50:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E41172051A
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 10:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E41172051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0NhQ-0000HA-4w
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 05:50:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j0NcD-0002vN-Tv
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 05:45:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j0NcC-0005P8-HD
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 05:45:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18360)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j0NcC-0005OI-8Y
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 05:45:32 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 018AhmT0040793
 for <qemu-devel@nongnu.org>; Sat, 8 Feb 2020 05:45:31 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y1u540kxx-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 05:45:31 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Sat, 8 Feb 2020 10:45:29 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sat, 8 Feb 2020 10:45:26 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 018AjPrb50135240
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 8 Feb 2020 10:45:25 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E7FC52051;
 Sat,  8 Feb 2020 10:45:25 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3A9E85204F;
 Sat,  8 Feb 2020 10:45:25 +0000 (GMT)
Received: from bahia.ibmuc.com (sig-9-145-71-236.uk.ibm.com [9.145.71.236])
 by smtp.tlslab.ibm.com (Postfix) with ESMTP id B9CF5220137;
 Sat,  8 Feb 2020 11:45:24 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 5/6] tests/virtio-9p: added readdir test
Date: Sat,  8 Feb 2020 11:45:05 +0100
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200208104506.2727882-1-groug@kaod.org>
References: <20200208104506.2727882-1-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20020810-0016-0000-0000-000002E4F33D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020810-0017-0000-0000-00003347DFDC
Message-Id: <20200208104506.2727882-6-groug@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-07_06:2020-02-07,
 2020-02-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 mlxlogscore=980 impostorscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1034 suspectscore=8
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002080089
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Christian Schoenebeck <qemu_oss@crudebyte.com>

The first readdir test simply checks the amount of directory
entries returned by 9pfs server, according to the created amount
of virtual files on 9pfs synth driver side. Then the subsequent
readdir test also checks whether all directory entries have the
expected file names (as created on 9pfs synth driver side),
ignoring their precise order in result list though.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-Id: <e0b4402722a877178f8fb6a8ad7b64bb20150613.1579567020.git.qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 tests/qtest/virtio-9p-test.c | 152 +++++++++++++++++++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 06263edb53f9..2167322985ec 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -68,6 +68,11 @@ static void v9fs_memread(P9Req *req, void *addr, size_t len)
     req->r_off += len;
 }
 
+static void v9fs_uint8_read(P9Req *req, uint8_t *val)
+{
+    v9fs_memread(req, val, 1);
+}
+
 static void v9fs_uint16_write(P9Req *req, uint16_t val)
 {
     uint16_t le_val = cpu_to_le16(val);
@@ -101,6 +106,12 @@ static void v9fs_uint32_read(P9Req *req, uint32_t *val)
     le32_to_cpus(val);
 }
 
+static void v9fs_uint64_read(P9Req *req, uint64_t *val)
+{
+    v9fs_memread(req, val, 8);
+    le64_to_cpus(val);
+}
+
 /* len[2] string[len] */
 static uint16_t v9fs_string_size(const char *string)
 {
@@ -191,6 +202,7 @@ static const char *rmessage_name(uint8_t id)
         id == P9_RLOPEN ? "RLOPEN" :
         id == P9_RWRITE ? "RWRITE" :
         id == P9_RFLUSH ? "RFLUSH" :
+        id == P9_RREADDIR ? "READDIR" :
         "<unknown>";
 }
 
@@ -348,6 +360,82 @@ static void v9fs_rwalk(P9Req *req, uint16_t *nwqid, v9fs_qid **wqid)
     v9fs_req_free(req);
 }
 
+/* size[4] Treaddir tag[2] fid[4] offset[8] count[4] */
+static P9Req *v9fs_treaddir(QVirtio9P *v9p, uint32_t fid, uint64_t offset,
+                            uint32_t count, uint16_t tag)
+{
+    P9Req *req;
+
+    req = v9fs_req_init(v9p, 4 + 8 + 4, P9_TREADDIR, tag);
+    v9fs_uint32_write(req, fid);
+    v9fs_uint64_write(req, offset);
+    v9fs_uint32_write(req, count);
+    v9fs_req_send(req);
+    return req;
+}
+
+struct V9fsDirent {
+    v9fs_qid qid;
+    uint64_t offset;
+    uint8_t type;
+    char *name;
+    struct V9fsDirent *next;
+};
+
+/* size[4] Rreaddir tag[2] count[4] data[count] */
+static void v9fs_rreaddir(P9Req *req, uint32_t *count, uint32_t *nentries,
+                          struct V9fsDirent **entries)
+{
+    uint32_t local_count;
+    struct V9fsDirent *e = NULL;
+    uint16_t slen;
+    uint32_t n = 0;
+
+    v9fs_req_recv(req, P9_RREADDIR);
+    v9fs_uint32_read(req, &local_count);
+
+    if (count) {
+        *count = local_count;
+    }
+
+    for (int32_t togo = (int32_t)local_count;
+         togo >= 13 + 8 + 1 + 2;
+         togo -= 13 + 8 + 1 + 2 + slen, ++n)
+    {
+        if (!e) {
+            e = g_malloc(sizeof(struct V9fsDirent));
+            if (entries) {
+                *entries = e;
+            }
+        } else {
+            e = e->next = g_malloc(sizeof(struct V9fsDirent));
+        }
+        e->next = NULL;
+        /* qid[13] offset[8] type[1] name[s] */
+        v9fs_memread(req, &e->qid, 13);
+        v9fs_uint64_read(req, &e->offset);
+        v9fs_uint8_read(req, &e->type);
+        v9fs_string_read(req, &slen, &e->name);
+    }
+
+    if (nentries) {
+        *nentries = n;
+    }
+
+    v9fs_req_free(req);
+}
+
+static void v9fs_free_dirents(struct V9fsDirent *e)
+{
+    struct V9fsDirent *next = NULL;
+
+    for (; e; e = next) {
+        next = e->next;
+        g_free(e->name);
+        g_free(e);
+    }
+}
+
 /* size[4] Tlopen tag[2] fid[4] flags[4] */
 static P9Req *v9fs_tlopen(QVirtio9P *v9p, uint32_t fid, uint32_t flags,
                           uint16_t tag)
@@ -480,6 +568,69 @@ static void fs_walk(void *obj, void *data, QGuestAllocator *t_alloc)
     g_free(wqid);
 }
 
+static bool fs_dirents_contain_name(struct V9fsDirent *e, const char* name)
+{
+    for (; e; e = e->next) {
+        if (!strcmp(e->name, name)) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static void fs_readdir(void *obj, void *data, QGuestAllocator *t_alloc)
+{
+    QVirtio9P *v9p = obj;
+    alloc = t_alloc;
+    char *const wnames[] = { g_strdup(QTEST_V9FS_SYNTH_READDIR_DIR) };
+    uint16_t nqid;
+    v9fs_qid qid;
+    uint32_t count, nentries;
+    struct V9fsDirent *entries = NULL;
+    P9Req *req;
+
+    fs_attach(v9p, NULL, t_alloc);
+    req = v9fs_twalk(v9p, 0, 1, 1, wnames, 0);
+    v9fs_req_wait_for_reply(req, NULL);
+    v9fs_rwalk(req, &nqid, NULL);
+    g_assert_cmpint(nqid, ==, 1);
+
+    req = v9fs_tlopen(v9p, 1, O_DIRECTORY, 0);
+    v9fs_req_wait_for_reply(req, NULL);
+    v9fs_rlopen(req, &qid, NULL);
+
+    /*
+     * submit count = msize - 11, because 11 is the header size of Rreaddir
+     */
+    req = v9fs_treaddir(v9p, 1, 0, P9_MAX_SIZE - 11, 0);
+    v9fs_req_wait_for_reply(req, NULL);
+    v9fs_rreaddir(req, &count, &nentries, &entries);
+
+    /*
+     * Assuming msize (P9_MAX_SIZE) is large enough so we can retrieve all
+     * dir entries with only one readdir request.
+     */
+    g_assert_cmpint(
+        nentries, ==,
+        QTEST_V9FS_SYNTH_READDIR_NFILES + 2 /* "." and ".." */
+    );
+
+    /*
+     * Check all file names exist in returned entries, ignore their order
+     * though.
+     */
+    g_assert_cmpint(fs_dirents_contain_name(entries, "."), ==, true);
+    g_assert_cmpint(fs_dirents_contain_name(entries, ".."), ==, true);
+    for (int i = 0; i < QTEST_V9FS_SYNTH_READDIR_NFILES; ++i) {
+        char *name = g_strdup_printf(QTEST_V9FS_SYNTH_READDIR_FILE, i);
+        g_assert_cmpint(fs_dirents_contain_name(entries, name), ==, true);
+        g_free(name);
+    }
+
+    v9fs_free_dirents(entries);
+    g_free(wnames[0]);
+}
+
 static void fs_walk_no_slash(void *obj, void *data, QGuestAllocator *t_alloc)
 {
     QVirtio9P *v9p = obj;
@@ -658,6 +809,7 @@ static void register_virtio_9p_test(void)
                  NULL);
     qos_add_test("fs/flush/ignored", "virtio-9p", fs_flush_ignored,
                  NULL);
+    qos_add_test("fs/readdir/basic", "virtio-9p", fs_readdir, NULL);
 }
 
 libqos_init(register_virtio_9p_test);
-- 
2.21.1


