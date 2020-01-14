Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD6FC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 16:08:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 846D924655
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 16:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 846D924655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irOkR-0003Nu-JL
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 11:08:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1irOgK-00076F-Q6
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 11:04:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1irOgF-00076X-Po
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 11:04:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28814
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1irOgF-00075x-Jc
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 11:04:35 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00EFmPxf126402
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 11:04:35 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2xh87cv3d2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 11:04:34 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Tue, 14 Jan 2020 16:02:48 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 14 Jan 2020 16:02:45 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 00EG2iOR36503970
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2020 16:02:44 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8AB9311C052;
 Tue, 14 Jan 2020 16:02:44 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 77E6211C04C;
 Tue, 14 Jan 2020 16:02:44 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jan 2020 16:02:44 +0000 (GMT)
Received: from bahia.ibmuc.com (sig-9-145-1-176.uk.ibm.com [9.145.1.176])
 by smtp.tlslab.ibm.com (Postfix) with ESMTP id ECB3E2200E1;
 Tue, 14 Jan 2020 17:02:43 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 5/5] 9pfs/9p.c: remove unneeded labels
Date: Tue, 14 Jan 2020 17:02:35 +0100
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200114160235.308040-1-groug@kaod.org>
References: <20200114160235.308040-1-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20011416-0020-0000-0000-000003A09D0C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011416-0021-0000-0000-000021F8127D
Message-Id: <20200114160235.308040-6-groug@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-14_04:2020-01-14,
 2020-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=8
 clxscore=1034 priorityscore=1501 mlxlogscore=730 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001140136
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel Henrique Barboza <danielhb413@gmail.com>

'out' label in v9fs_xattr_write() and 'out_nofid' label in
v9fs_complete_rename() can be replaced by appropriate return
calls.

CC: Greg Kurz <groug@kaod.org>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Acked-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 2efed37753ed..869379ddd87c 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2473,8 +2473,7 @@ static int v9fs_xattr_write(V9fsState *s, V9fsPDU *pdu, V9fsFidState *fidp,
 
 
     if (fidp->fs.xattr.len < off) {
-        err = -ENOSPC;
-        goto out;
+        return -ENOSPC;
     }
     write_count = fidp->fs.xattr.len - off;
     if (write_count > count) {
@@ -2500,7 +2499,7 @@ static int v9fs_xattr_write(V9fsState *s, V9fsPDU *pdu, V9fsFidState *fidp,
         off += to_copy;
         write_count -= to_copy;
     }
-out:
+
     return err;
 }
 
@@ -3068,8 +3067,7 @@ static int coroutine_fn v9fs_complete_rename(V9fsPDU *pdu, V9fsFidState *fidp,
     if (newdirfid != -1) {
         dirfidp = get_fid(pdu, newdirfid);
         if (dirfidp == NULL) {
-            err = -ENOENT;
-            goto out_nofid;
+            return -ENOENT;
         }
         if (fidp->fid_type != P9_FID_NONE) {
             err = -EINVAL;
@@ -3112,7 +3110,6 @@ out:
         put_fid(pdu, dirfidp);
     }
     v9fs_path_free(&new_path);
-out_nofid:
     return err;
 }
 
-- 
2.21.1


