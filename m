Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AB9C35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 10:47:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8170B21775
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 10:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8170B21775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0Ndh-000473-Ja
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 05:47:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j0NcA-0002ud-92
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 05:45:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j0Nc7-0005Kh-E1
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 05:45:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49790)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j0Nc7-0005KA-6J
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 05:45:27 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 018AeHsi137739
 for <qemu-devel@nongnu.org>; Sat, 8 Feb 2020 05:45:25 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y1tn0sf5y-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 05:45:25 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Sat, 8 Feb 2020 10:45:23 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sat, 8 Feb 2020 10:45:19 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 018AiPvo50659742
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 8 Feb 2020 10:44:25 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BBDC1A4066;
 Sat,  8 Feb 2020 10:45:18 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A9526A4060;
 Sat,  8 Feb 2020 10:45:18 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sat,  8 Feb 2020 10:45:18 +0000 (GMT)
Received: from bahia.ibmuc.com (sig-9-145-71-236.uk.ibm.com [9.145.71.236])
 by smtp.tlslab.ibm.com (Postfix) with ESMTP id 2955A220137;
 Sat,  8 Feb 2020 11:45:18 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/6] 9pfs: require msize >= 4096
Date: Sat,  8 Feb 2020 11:45:02 +0100
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200208104506.2727882-1-groug@kaod.org>
References: <20200208104506.2727882-1-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20020810-0020-0000-0000-000003A84448
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020810-0021-0000-0000-000022001A0F
Message-Id: <20200208104506.2727882-3-groug@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-07_06:2020-02-07,
 2020-02-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 suspectscore=2 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 clxscore=1034 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002080088
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

A client establishes a session by sending a Tversion request along with a
'msize' parameter which client uses to suggest server a maximum message
size ever to be used for communication (for both requests and replies)
between client and server during that session. If client suggests a 'msize'
smaller than 4096 then deny session by server immediately with an error
response (Rlerror for "9P2000.L" clients or Rerror for "9P2000.u" clients)
instead of replying with Rversion.

So far any msize submitted by client with Tversion was simply accepted by
server without any check. Introduction of some minimum msize makes sense,
because e.g. a msize < 7 would not allow any subsequent 9p operation at
all, because 7 is the size of the header section common by all 9p message
types.

A substantial higher value of 4096 was chosen though to prevent potential
issues with some message types. E.g. Rreadlink may yield up to a size of
PATH_MAX which is usually 4096, and like almost all 9p message types,
Rreadlink is not allowed to be truncated by the 9p protocol. This chosen
size also prevents a similar issue with Rreaddir responses (provided client
always sends adequate 'count' parameter with Treaddir), because even though
directory entries retrieval may be split up over several T/Rreaddir
messages; a Rreaddir response must not truncate individual directory entries
though. So msize should be large enough to return at least one directory
entry with the longest possible file name supported by host. Most file
systems support a max. file name length of 255. Largest known file name
lenght limit would be currently ReiserFS with max. 4032 bytes, which is
also covered by this min. msize value because 4032 + 35 < 4096.

Furthermore 4096 is already the minimum msize of the Linux kernel's 9pfs
client.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <8ceecb7fb9fdbeabbe55c04339349a36929fb8e3.1579567019.git.qemu_oss@crudebyte.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c | 12 ++++++++++++
 hw/9pfs/9p.h | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index b0e445d6bd5a..c63f549f39b2 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1363,8 +1363,20 @@ static void coroutine_fn v9fs_version(void *opaque)
         s->proto_version = V9FS_PROTO_2000L;
     } else {
         v9fs_string_sprintf(&version, "unknown");
+        /* skip min. msize check, reporting invalid version has priority */
+        goto marshal;
     }
 
+    if (s->msize < P9_MIN_MSIZE) {
+        err = -EMSGSIZE;
+        error_report(
+            "9pfs: Client requested msize < minimum msize ("
+            stringify(P9_MIN_MSIZE) ") supported by this server."
+        );
+        goto out;
+    }
+
+marshal:
     err = pdu_marshal(pdu, offset, "ds", s->msize, &version);
     if (err < 0) {
         goto out;
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 8d07a0b301e2..b8f72a3bd990 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -100,6 +100,17 @@ typedef enum P9ProtoVersion {
     V9FS_PROTO_2000L = 0x02,
 } P9ProtoVersion;
 
+/**
+ * @brief Minimum message size supported by this 9pfs server.
+ *
+ * A client establishes a session by sending a Tversion request along with a
+ * 'msize' parameter which suggests the server a maximum message size ever to be
+ * used for communication (for both requests and replies) between client and
+ * server during that session. If client suggests a 'msize' smaller than this
+ * value then session is denied by server with an error response.
+ */
+#define P9_MIN_MSIZE    4096
+
 #define P9_NOTAG    UINT16_MAX
 #define P9_NOFID    UINT32_MAX
 #define P9_MAXWELEM 16
-- 
2.21.1


