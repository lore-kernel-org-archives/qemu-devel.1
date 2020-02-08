Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236FFC352A1
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 10:48:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF25221775
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 10:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF25221775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0NfH-0006Lo-7V
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 05:48:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j0NcA-0002uf-O5
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 05:45:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j0Nc9-0005La-Me
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 05:45:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42350
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j0Nc9-0005L5-I2
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 05:45:29 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 018Ahsrc103098
 for <qemu-devel@nongnu.org>; Sat, 8 Feb 2020 05:45:28 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2y1tnb1g96-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 05:45:28 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Sat, 8 Feb 2020 10:45:26 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sat, 8 Feb 2020 10:45:23 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 018AjNRk54526176
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 8 Feb 2020 10:45:23 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F3059A4060;
 Sat,  8 Feb 2020 10:45:22 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E0BB3A405C;
 Sat,  8 Feb 2020 10:45:22 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sat,  8 Feb 2020 10:45:22 +0000 (GMT)
Received: from bahia.ibmuc.com (sig-9-145-71-236.uk.ibm.com [9.145.71.236])
 by smtp.tlslab.ibm.com (Postfix) with ESMTP id 61EA9220137;
 Sat,  8 Feb 2020 11:45:22 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 4/6] hw/9pfs/9p-synth: added directory for readdir test
Date: Sat,  8 Feb 2020 11:45:04 +0100
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200208104506.2727882-1-groug@kaod.org>
References: <20200208104506.2727882-1-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20020810-0016-0000-0000-000002E4F33C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020810-0017-0000-0000-00003347DFDB
Message-Id: <20200208104506.2727882-5-groug@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-07_06:2020-02-07,
 2020-02-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=8 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1034 mlxscore=0
 mlxlogscore=827 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002080089
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Christian Schoenebeck <qemu_oss@crudebyte.com>

This will provide the following virtual files by the 9pfs
synth driver:

  - /ReadDirDir/ReadDirFile99
  - /ReadDirDir/ReadDirFile98
  ...
  - /ReadDirDir/ReadDirFile1
  - /ReadDirDir/ReadDirFile0

This virtual directory and its virtual 100 files will be
used by the upcoming 9pfs readdir tests.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <5408c28c8de25dd575b745cef63bf785305ccef2.1579567020.git.qemu_oss@crudebyte.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-synth.c | 19 +++++++++++++++++++
 hw/9pfs/9p-synth.h |  5 +++++
 2 files changed, 24 insertions(+)

diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index 54239c9bbf32..7eb210ffa89b 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -578,6 +578,25 @@ static int synth_init(FsContext *ctx, Error **errp)
                                        NULL, v9fs_synth_qtest_flush_write,
                                        ctx);
         assert(!ret);
+
+        /* Directory for READDIR test */
+        {
+            V9fsSynthNode *dir = NULL;
+            ret = qemu_v9fs_synth_mkdir(
+                NULL, 0700, QTEST_V9FS_SYNTH_READDIR_DIR, &dir
+            );
+            assert(!ret);
+            for (i = 0; i < QTEST_V9FS_SYNTH_READDIR_NFILES; ++i) {
+                char *name = g_strdup_printf(
+                    QTEST_V9FS_SYNTH_READDIR_FILE, i
+                );
+                ret = qemu_v9fs_synth_add_file(
+                    dir, 0, name, NULL, NULL, ctx
+                );
+                assert(!ret);
+                g_free(name);
+            }
+        }
     }
 
     return 0;
diff --git a/hw/9pfs/9p-synth.h b/hw/9pfs/9p-synth.h
index af7a993a1e8e..036d7e4a5b1c 100644
--- a/hw/9pfs/9p-synth.h
+++ b/hw/9pfs/9p-synth.h
@@ -55,6 +55,11 @@ int qemu_v9fs_synth_add_file(V9fsSynthNode *parent, int mode,
 #define QTEST_V9FS_SYNTH_LOPEN_FILE "LOPEN"
 #define QTEST_V9FS_SYNTH_WRITE_FILE "WRITE"
 
+/* for READDIR test */
+#define QTEST_V9FS_SYNTH_READDIR_DIR "ReadDirDir"
+#define QTEST_V9FS_SYNTH_READDIR_FILE "ReadDirFile%d"
+#define QTEST_V9FS_SYNTH_READDIR_NFILES 100
+
 /* Any write to the "FLUSH" file is handled one byte at a time by the
  * backend. If the byte is zero, the backend returns success (ie, 1),
  * otherwise it forces the server to try again forever. Thus allowing
-- 
2.21.1


