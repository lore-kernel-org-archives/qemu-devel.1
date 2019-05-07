Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B91C04AAB
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:49:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB03C20B7C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB03C20B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42447 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNvmk-0007Ai-6L
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 04:49:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hNviu-0004Y1-9y
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:45:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hNvit-0006Xk-8e
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:45:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hNvit-0006XH-0k
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:45:15 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x478ffSV020155
	for <qemu-devel@nongnu.org>; Tue, 7 May 2019 04:45:14 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2sb4776xq1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 04:45:11 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 7 May 2019 09:45:09 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
	by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 7 May 2019 09:45:07 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
	[9.149.105.62])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x478j63652953254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Tue, 7 May 2019 08:45:06 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 877F1AE04D;
	Tue,  7 May 2019 08:45:06 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59E2FAE057;
	Tue,  7 May 2019 08:45:06 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.26.205])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue,  7 May 2019 08:45:06 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Date: Tue, 07 May 2019 10:45:06 +0200
In-Reply-To: <155721868351.451636.16735088470797960209.stgit@bahia.lan>
References: <155721868351.451636.16735088470797960209.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19050708-0028-0000-0000-0000036B1A77
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050708-0029-0000-0000-0000242A9284
Message-Id: <155721870600.451636.3427944860976861371.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-07_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905070057
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH 4/6] fsdev: Error out when unsupported option
 is passed
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Each fsdriver only supports a subset of the options that can be passed
to -fsdev. Unsupported options are simply ignored. This could cause the
user to erroneously think QEMU has a bug.

Enforce strict checking of supported options for all fsdrivers. This
shouldn't impact libvirt, since it doesn't know about he synth and
proxy fsdrivers.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 fsdev/qemu-fsdev.c |   74 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 3 deletions(-)

diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
index e972bd698cf5..077a8c4e2bca 100644
--- a/fsdev/qemu-fsdev.c
+++ b/fsdev/qemu-fsdev.c
@@ -34,6 +34,7 @@
 typedef struct FsDriverTable {
     const char *name;
     FileOperations *ops;
+    const char **opts;
 } FsDriverTable;
 
 typedef struct FsDriverListEntry {
@@ -44,12 +45,75 @@ typedef struct FsDriverListEntry {
 static QTAILQ_HEAD(, FsDriverListEntry) fsdriver_entries =
     QTAILQ_HEAD_INITIALIZER(fsdriver_entries);
 
+#define COMMON_FS_DRIVER_OPTIONS "id", "fsdriver", "readonly"
+
 static FsDriverTable FsDrivers[] = {
-    { .name = "local", .ops = &local_ops},
-    { .name = "synth", .ops = &synth_ops},
-    { .name = "proxy", .ops = &proxy_ops},
+    {
+        .name = "local",
+        .ops = &local_ops,
+        .opts = (const char * []) {
+            COMMON_FS_DRIVER_OPTIONS,
+            "security_model",
+            "path",
+            "writeout",
+            "fmode",
+            "dmode",
+            "throttling.bps-total",
+            "throttling.bps-read",
+            "throttling.bps-write",
+            "throttling.iops-total",
+            "throttling.iops-read",
+            "throttling.iops-write",
+            "throttling.bps-total-max",
+            "throttling.bps-read-max",
+            "throttling.bps-write-max",
+            "throttling.iops-total-max",
+            "throttling.iops-read-max",
+            "throttling.iops-write-max",
+            "throttling.bps-total-max-length",
+            "throttling.bps-read-max-length",
+            "throttling.bps-write-max-length",
+            "throttling.iops-total-max-length",
+            "throttling.iops-read-max-length",
+            "throttling.iops-write-max-length",
+            "throttling.iops-size",
+        },
+    },
+    {
+        .name = "synth",
+        .ops = &synth_ops,
+        .opts = (const char * []) {
+            COMMON_FS_DRIVER_OPTIONS,
+        },
+    },
+    {
+        .name = "proxy",
+        .ops = &proxy_ops,
+        .opts = (const char * []) {
+            COMMON_FS_DRIVER_OPTIONS,
+            "socket",
+            "sock_fd",
+            "writeout",
+        },
+    },
 };
 
+static int validate_opt(void *opaque, const char *name, const char *value,
+                        Error **errp)
+{
+    FsDriverTable *drv = opaque;
+    const char **opt;
+
+    for (opt = drv->opts; *opt; opt++) {
+        if (!strcmp(*opt, name)) {
+            return 0;
+        }
+    }
+
+    error_setg(errp, "'%s' is invalid for fsdriver '%s'", name, drv->name);
+    return -1;
+}
+
 int qemu_fsdev_add(QemuOpts *opts, Error **errp)
 {
     int i;
@@ -80,6 +144,10 @@ int qemu_fsdev_add(QemuOpts *opts, Error **errp)
         return -1;
     }
 
+    if (qemu_opt_foreach(opts, validate_opt, &FsDrivers[i], errp)) {
+        return -1;
+    }
+
     fsle = g_malloc0(sizeof(*fsle));
     fsle->fse.fsdev_id = g_strdup(fsdev_id);
     fsle->fse.ops = FsDrivers[i].ops;


