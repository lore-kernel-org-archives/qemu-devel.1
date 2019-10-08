Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094F2C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:21:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D224B206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D224B206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHrIM-000818-Oy
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 11:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iHrH9-00072N-0R
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:19:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iHrH6-0000W6-UO
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:19:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22870)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iHrH4-0000SL-Vu
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:19:44 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x98FDQja009108
 for <qemu-devel@nongnu.org>; Tue, 8 Oct 2019 11:19:41 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vf98hp8qa-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 11:19:40 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Tue, 8 Oct 2019 16:19:37 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 8 Oct 2019 16:19:35 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x98FJYwk44892324
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Oct 2019 15:19:34 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6172A4057;
 Tue,  8 Oct 2019 15:19:34 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9313BA4051;
 Tue,  8 Oct 2019 15:19:34 +0000 (GMT)
Received: from smtp.tls.ibm.com (unknown [9.101.4.1])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue,  8 Oct 2019 15:19:34 +0000 (GMT)
Received: from bahia.tls.ibm.com (bahia.tls.ibm.com [9.101.4.41])
 by smtp.tls.ibm.com (Postfix) with ESMTP id 5F7472201ED;
 Tue,  8 Oct 2019 17:19:34 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/4] 9p: Simplify error path of v9fs_device_realize_common()
Date: Tue,  8 Oct 2019 17:19:23 +0200
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191008151925.1021706-1-groug@kaod.org>
References: <20191008151925.1021706-1-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19100815-0020-0000-0000-00000377205A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100815-0021-0000-0000-000021CD22CE
Message-Id: <20191008151925.1021706-3-groug@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-08_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=509 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910080135
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make v9fs_device_unrealize_common() idempotent and use it for rollback,
in order to reduce code duplication.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |  4 ++++
 hw/9pfs/9p-proxy.c |  4 ++++
 hw/9pfs/9p.c       | 16 ++++++----------
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 08e673a79c22..6f7309f4e691 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1465,6 +1465,10 @@ static void local_cleanup(FsContext *ctx)
 {
     LocalData *data = ctx->private;
 
+    if (!data) {
+        return;
+    }
+
     close(data->mountfd);
     g_free(data);
 }
diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
index 57a8c1c80886..97ab9c58a573 100644
--- a/hw/9pfs/9p-proxy.c
+++ b/hw/9pfs/9p-proxy.c
@@ -1185,6 +1185,10 @@ static void proxy_cleanup(FsContext *ctx)
 {
     V9fsProxy *proxy = ctx->private;
 
+    if (!proxy) {
+        return;
+    }
+
     g_free(proxy->out_iovec.iov_base);
     g_free(proxy->in_iovec.iov_base);
     if (ctx->export_flags & V9FS_PROXY_SOCK_NAME) {
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index cf317bdd2b92..ba1ab920f1eb 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3637,27 +3637,23 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
     s->ctx.fst = &fse->fst;
     fsdev_throttle_init(s->ctx.fst);
 
-    v9fs_path_free(&path);
-
     rc = 0;
 out:
     if (rc) {
-        if (s->ops && s->ops->cleanup && s->ctx.private) {
-            s->ops->cleanup(&s->ctx);
-        }
-        g_free(s->tag);
-        g_free(s->ctx.fs_root);
-        v9fs_path_free(&path);
+        v9fs_device_unrealize_common(s, NULL);
     }
+    v9fs_path_free(&path);
     return rc;
 }
 
 void v9fs_device_unrealize_common(V9fsState *s, Error **errp)
 {
-    if (s->ops->cleanup) {
+    if (s->ops && s->ops->cleanup) {
         s->ops->cleanup(&s->ctx);
     }
-    fsdev_throttle_cleanup(s->ctx.fst);
+    if (s->ctx.fst) {
+        fsdev_throttle_cleanup(s->ctx.fst);
+    }
     g_free(s->tag);
     g_free(s->ctx.fs_root);
 }
-- 
2.21.0


