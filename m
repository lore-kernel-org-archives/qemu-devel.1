Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428B5C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:08:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1389022314
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1389022314
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itaXo-0006ww-P4
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 12:08:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1itaVv-0005KU-It
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:07:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1itaVr-0001RV-LV
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:06:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55242)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1itaVr-0001Qs-DR
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:06:55 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00KH6mGS100227
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 12:06:53 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xmfyy215t-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 12:06:53 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Mon, 20 Jan 2020 17:06:50 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 20 Jan 2020 17:06:48 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 00KH5vuh27460010
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Jan 2020 17:05:57 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3904AAE04D;
 Mon, 20 Jan 2020 17:06:47 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 268C0AE045;
 Mon, 20 Jan 2020 17:06:47 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 20 Jan 2020 17:06:47 +0000 (GMT)
Received: from bahia.ibmuc.com (sig-9-145-1-176.uk.ibm.com [9.145.1.176])
 by smtp.tlslab.ibm.com (Postfix) with ESMTP id 95AF5220155;
 Mon, 20 Jan 2020 18:06:46 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/5] 9p: local: always return -1 on error in
 local_unlinkat_common
Date: Mon, 20 Jan 2020 18:06:37 +0100
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200120170640.524184-1-groug@kaod.org>
References: <20200120170640.524184-1-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20012017-0016-0000-0000-000002DF226D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012017-0017-0000-0000-00003341C732
Message-Id: <20200120170640.524184-3-groug@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-20_07:2020-01-20,
 2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=2
 mlxlogscore=999 clxscore=1034 mlxscore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001200144
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel Henrique Barboza <danielhb413@gmail.com>

local_unlinkat_common() is supposed to always return -1 on error.
This is being done by jumps to the 'err_out' label, which is
a 'return ret' call, and 'ret' is initialized with -1.

Unfortunately there is a condition in which the function will
return 0 on error: in a case where flags == AT_REMOVEDIR, 'ret'
will be 0 when reaching

map_dirfd = openat_dir(...)

And, if map_dirfd == -1 and errno != ENOENT, the existing 'err_out'
jump will execute 'return ret', when ret is still set to zero
at that point.

This patch fixes it by changing all 'err_out' labels by
'return -1' calls, ensuring that the function will always
return -1 on error conditions. 'ret' can be left unintialized
since it's now being used just to store the result of 'unlinkat'
calls.

CC: Greg Kurz <groug@kaod.org>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
[groug: changed prefix in title to be "9p: local:"]
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index d0592c3b4504..54e012e5b442 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1076,7 +1076,7 @@ out:
 static int local_unlinkat_common(FsContext *ctx, int dirfd, const char *name,
                                  int flags)
 {
-    int ret = -1;
+    int ret;
 
     if (ctx->export_flags & V9FS_SM_MAPPED_FILE) {
         int map_dirfd;
@@ -1094,12 +1094,12 @@ static int local_unlinkat_common(FsContext *ctx, int dirfd, const char *name,
 
             fd = openat_dir(dirfd, name);
             if (fd == -1) {
-                goto err_out;
+                return -1;
             }
             ret = unlinkat(fd, VIRTFS_META_DIR, AT_REMOVEDIR);
             close_preserve_errno(fd);
             if (ret < 0 && errno != ENOENT) {
-                goto err_out;
+                return -1;
             }
         }
         map_dirfd = openat_dir(dirfd, VIRTFS_META_DIR);
@@ -1107,16 +1107,14 @@ static int local_unlinkat_common(FsContext *ctx, int dirfd, const char *name,
             ret = unlinkat(map_dirfd, name, 0);
             close_preserve_errno(map_dirfd);
             if (ret < 0 && errno != ENOENT) {
-                goto err_out;
+                return -1;
             }
         } else if (errno != ENOENT) {
-            goto err_out;
+            return -1;
         }
     }
 
-    ret = unlinkat(dirfd, name, flags);
-err_out:
-    return ret;
+    return unlinkat(dirfd, name, flags);
 }
 
 static int local_remove(FsContext *ctx, const char *path)
-- 
2.21.1


