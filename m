Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BDDC352A2
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 18:22:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CFEF217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 18:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFEF217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izPJW-0004mi-Cp
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 13:22:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jjherne@linux.ibm.com>) id 1izPIq-0004GW-Oo
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 13:21:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jjherne@linux.ibm.com>) id 1izPIp-0005PZ-MM
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 13:21:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35054)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
 id 1izPIp-0005J8-EO; Wed, 05 Feb 2020 13:21:31 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 015IItvP109544; Wed, 5 Feb 2020 13:21:29 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xyhpy31hn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Feb 2020 13:21:29 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 015IJYXk111091;
 Wed, 5 Feb 2020 13:21:29 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xyhpy31gv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Feb 2020 13:21:29 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 015IA3KO029868;
 Wed, 5 Feb 2020 18:21:28 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma02dal.us.ibm.com with ESMTP id 2xykc9gcmt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Feb 2020 18:21:28 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 015ILR3m45351250
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Feb 2020 18:21:27 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3DA06112062;
 Wed,  5 Feb 2020 18:21:27 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1093F112063;
 Wed,  5 Feb 2020 18:21:27 +0000 (GMT)
Received: from dhcp-9-60-75-200.endicott.ibm.com (unknown [9.60.75.200])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed,  5 Feb 2020 18:21:26 +0000 (GMT)
From: "Jason J. Herne" <jjherne@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 borntraeger@de.ibm.com
Subject: [PATCH] pc-bios/s390x: Pack ResetInfo struct
Date: Wed,  5 Feb 2020 13:21:26 -0500
Message-Id: <20200205182126.13010-1-jjherne@linux.ibm.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-05_05:2020-02-04,
 2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 suspectscore=3 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1011 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002050140
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This fixes vfio-ccw when booting non-Linux operating systems. Without this
struct being packed, a few extra bytes of low core memory get overwritten when
we  assign a value to memory address 0 in jump_to_IPL_2. This is enough to
cause some non-Linux OSes of fail when booting.

The problem was introduced by:
5c6f0d5f46a77d77 "pc-bios/s390x: Fix reset psw mask".

The fix is to pack the struct thereby removing the 4 bytes of padding that get
added at the end, likely to allow an array of these structs to naturally align
on an 8-byte boundary.

Fixes: 5c6f0d5f46a7 ("pc-bios/s390x: Fix reset psw mask")
CC: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 pc-bios/s390-ccw/jump2ipl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
index da13c43cc0..1e9eaa037f 100644
--- a/pc-bios/s390-ccw/jump2ipl.c
+++ b/pc-bios/s390-ccw/jump2ipl.c
@@ -18,7 +18,7 @@
 typedef struct ResetInfo {
     uint64_t ipl_psw;
     uint32_t ipl_continue;
-} ResetInfo;
+} __attribute__((packed)) ResetInfo;
 
 static ResetInfo save;
 
-- 
2.21.1


