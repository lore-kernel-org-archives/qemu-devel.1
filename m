Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57A5C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:11:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB0D722314
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0D722314
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itaaj-0002Le-Ks
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 12:11:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1itaVy-0005Mz-LK
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:07:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1itaVu-0001TB-Ly
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:07:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51464)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1itaVu-0001T2-HA
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:06:58 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00KH6Xo8153275
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 12:06:58 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xkwq6wy2v-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 12:06:57 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Mon, 20 Jan 2020 17:06:51 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 20 Jan 2020 17:06:49 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 00KH6mJo67043516
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Jan 2020 17:06:48 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 68662AE055;
 Mon, 20 Jan 2020 17:06:48 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5544AAE045;
 Mon, 20 Jan 2020 17:06:48 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 20 Jan 2020 17:06:48 +0000 (GMT)
Received: from bahia.ibmuc.com (sig-9-145-1-176.uk.ibm.com [9.145.1.176])
 by smtp.tlslab.ibm.com (Postfix) with ESMTP id BEC39220155;
 Mon, 20 Jan 2020 18:06:47 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 4/5] virtfs-proxy-helper.c: remove 'err_out' label in setugid()
Date: Mon, 20 Jan 2020 18:06:39 +0100
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200120170640.524184-1-groug@kaod.org>
References: <20200120170640.524184-1-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20012017-0016-0000-0000-000002DF226E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012017-0017-0000-0000-00003341C734
Message-Id: <20200120170640.524184-5-groug@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-20_07:2020-01-20,
 2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0
 suspectscore=2 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 mlxlogscore=816 impostorscore=0 spamscore=0
 clxscore=1034 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001200144
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

'err_out' can be removed and be replaced by 'return -errno'
in its only instance in the function.

CC: Greg Kurz <groug@kaod.org>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Acked-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 fsdev/virtfs-proxy-helper.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fsdev/virtfs-proxy-helper.c b/fsdev/virtfs-proxy-helper.c
index 0d4de49dcf75..aa1ab2590d42 100644
--- a/fsdev/virtfs-proxy-helper.c
+++ b/fsdev/virtfs-proxy-helper.c
@@ -287,8 +287,7 @@ static int setugid(int uid, int gid, int *suid, int *sgid)
     *sgid = getegid();
 
     if (setresgid(-1, gid, *sgid) == -1) {
-        retval = -errno;
-        goto err_out;
+        return -errno;
     }
 
     if (setresuid(-1, uid, *suid) == -1) {
@@ -322,7 +321,6 @@ err_sgid:
     if (setresgid(-1, *sgid, *sgid) == -1) {
         abort();
     }
-err_out:
     return retval;
 }
 
-- 
2.21.1


