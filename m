Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD84C35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 10:47:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5772D21775
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 10:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5772D21775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0Ndw-0004Fr-IW
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 05:47:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j0NcG-0002zK-IX
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 05:45:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j0NcF-0005Q1-Ij
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 05:45:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31228
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j0NcF-0005KR-DX
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 05:45:35 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 018AgGle095670
 for <qemu-devel@nongnu.org>; Sat, 8 Feb 2020 05:45:26 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2y1ufhg25j-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 05:45:26 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Sat, 8 Feb 2020 10:45:24 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sat, 8 Feb 2020 10:45:22 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 018AiRXn47645058
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 8 Feb 2020 10:44:27 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 28F7D11C05B;
 Sat,  8 Feb 2020 10:45:21 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B8C811C058;
 Sat,  8 Feb 2020 10:45:21 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sat,  8 Feb 2020 10:45:21 +0000 (GMT)
Received: from bahia.ibmuc.com (sig-9-145-71-236.uk.ibm.com [9.145.71.236])
 by smtp.tlslab.ibm.com (Postfix) with ESMTP id 7D339220137;
 Sat,  8 Feb 2020 11:45:20 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 3/6] 9pfs: validate count sent by client with T_readdir
Date: Sat,  8 Feb 2020 11:45:03 +0100
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200208104506.2727882-1-groug@kaod.org>
References: <20200208104506.2727882-1-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20020810-0016-0000-0000-000002E4F33B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020810-0017-0000-0000-00003347DFDA
Message-Id: <20200208104506.2727882-4-groug@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-07_06:2020-02-07,
 2020-02-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 adultscore=0 clxscore=1034
 mlxlogscore=900 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=2
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002080086
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

A good 9p client sends T_readdir with "count" parameter that's sufficiently
smaller than client's initially negotiated msize (maximum message size).
We perform a check for that though to avoid the server to be interrupted
with a "Failed to encode VirtFS reply type 41" transport error message by
bad clients. This count value constraint uses msize - 11, because 11 is the
header size of R_readdir.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <3990d3891e8ae2074709b56449e96ab4b4b93b7d.1579567020.git.qemu_oss@crudebyte.com>
[groug: added comment ]
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index c63f549f39b2..9e046f7acb51 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2434,6 +2434,7 @@ static void coroutine_fn v9fs_readdir(void *opaque)
     int32_t count;
     uint32_t max_count;
     V9fsPDU *pdu = opaque;
+    V9fsState *s = pdu->s;
 
     retval = pdu_unmarshal(pdu, offset, "dqd", &fid,
                            &initial_offset, &max_count);
@@ -2442,6 +2443,14 @@ static void coroutine_fn v9fs_readdir(void *opaque)
     }
     trace_v9fs_readdir(pdu->tag, pdu->id, fid, initial_offset, max_count);
 
+    /* Enough space for a R_readdir header: size[4] Rreaddir tag[2] count[4] */
+    if (max_count > s->msize - 11) {
+        max_count = s->msize - 11;
+        warn_report_once(
+            "9p: bad client: T_readdir with count > msize - 11"
+        );
+    }
+
     fidp = get_fid(pdu, fid);
     if (fidp == NULL) {
         retval = -EINVAL;
-- 
2.21.1


