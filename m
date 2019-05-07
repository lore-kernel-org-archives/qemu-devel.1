Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54455C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:49:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2944820B7C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2944820B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42445 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNvmj-0007AP-Dh
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 04:49:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hNvil-0004LQ-NZ
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hNvik-0006QZ-Ls
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:45:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52816
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hNvik-0006QO-FT
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:45:06 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x478ffgg047187
	for <qemu-devel@nongnu.org>; Tue, 7 May 2019 04:45:06 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2sb6m2rejp-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 04:45:05 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 7 May 2019 09:45:04 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
	by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 7 May 2019 09:45:02 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
	[9.149.105.61])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x478j1kv50856062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Tue, 7 May 2019 08:45:01 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 011D711C05B;
	Tue,  7 May 2019 08:45:01 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C604F11C05E;
	Tue,  7 May 2019 08:45:00 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.26.205])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue,  7 May 2019 08:45:00 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Date: Tue, 07 May 2019 10:45:00 +0200
In-Reply-To: <155721868351.451636.16735088470797960209.stgit@bahia.lan>
References: <155721868351.451636.16735088470797960209.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19050708-0008-0000-0000-000002E41364
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050708-0009-0000-0000-000022508F08
Message-Id: <155721870044.451636.8272207759150286399.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-07_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=951 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905070057
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH 3/6] fsdev: Move some types definition to
 qemu-fsdev.c
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

It would make sense for these types to be defined in a header file if
we had an API for fsdrivers to register themselves. In practice, we
only have three of them and it is very unlikely we add new ones since
the future of file sharing between host and guest is the upcoming
virtio-fs.

Move the types to qemu-fsdev.c instead since they are only used there.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 fsdev/qemu-fsdev.c |   23 +++++++++++++++++++++++
 fsdev/qemu-fsdev.h |   24 ------------------------
 2 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
index 54cb36a2124b..e972bd698cf5 100644
--- a/fsdev/qemu-fsdev.c
+++ b/fsdev/qemu-fsdev.c
@@ -18,6 +18,29 @@
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 
+/*
+ * A table to store the various file systems and their callback operations.
+ * -----------------
+ * fstype | ops
+ * -----------------
+ *  local | local_ops
+ *  .     |
+ *  .     |
+ *  .     |
+ *  .     |
+ * -----------------
+ *  etc
+ */
+typedef struct FsDriverTable {
+    const char *name;
+    FileOperations *ops;
+} FsDriverTable;
+
+typedef struct FsDriverListEntry {
+    FsDriverEntry fse;
+    QTAILQ_ENTRY(FsDriverListEntry) next;
+} FsDriverListEntry;
+
 static QTAILQ_HEAD(, FsDriverListEntry) fsdriver_entries =
     QTAILQ_HEAD_INITIALIZER(fsdriver_entries);
 
diff --git a/fsdev/qemu-fsdev.h b/fsdev/qemu-fsdev.h
index 844159d1e1ff..52a53977701a 100644
--- a/fsdev/qemu-fsdev.h
+++ b/fsdev/qemu-fsdev.h
@@ -14,30 +14,6 @@
 #define QEMU_FSDEV_H
 #include "file-op-9p.h"
 
-
-/*
- * A table to store the various file systems and their callback operations.
- * -----------------
- * fstype | ops
- * -----------------
- *  local | local_ops
- *  .     |
- *  .     |
- *  .     |
- *  .     |
- * -----------------
- *  etc
- */
-typedef struct FsDriverTable {
-    const char *name;
-    FileOperations *ops;
-} FsDriverTable;
-
-typedef struct FsDriverListEntry {
-    FsDriverEntry fse;
-    QTAILQ_ENTRY(FsDriverListEntry) next;
-} FsDriverListEntry;
-
 int qemu_fsdev_add(QemuOpts *opts, Error **errp);
 FsDriverEntry *get_fsdev_fsentry(char *id);
 extern FileOperations local_ops;


