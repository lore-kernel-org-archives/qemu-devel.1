Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D2DC76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:09:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B72A2184E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B72A2184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpyIL-00016d-WA
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 13:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43221)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hpyBE-0007Tb-Aj
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:02:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hpyBC-00063B-8r
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:02:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63086
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1hpyBA-0005lJ-7P
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:02:22 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6NH24Ef077587
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 13:02:07 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2tx60r8n1p-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 13:02:02 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
 Tue, 23 Jul 2019 18:01:31 +0100
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
 by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 23 Jul 2019 18:01:29 +0100
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6NH1SNH26149202
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2019 17:01:28 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BDC48BE051;
 Tue, 23 Jul 2019 17:01:28 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B1ACEBE05B;
 Tue, 23 Jul 2019 17:01:28 +0000 (GMT)
Received: from localhost (unknown [9.53.179.212])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jul 2019 17:01:28 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Date: Tue, 23 Jul 2019 12:00:35 -0500
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
References: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
x-cbid: 19072317-0004-0000-0000-0000152DB9B4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011482; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01236375; UDB=6.00651638; IPR=6.01017731; 
 MB=3.00027856; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-23 17:01:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072317-0005-0000-0000-00008C9463D1
Message-Id: <20190723170104.4327-8-mdroth@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-23_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907230170
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id x6NH24Ef077587
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH 07/36] linux-user: make pwrite64/pread64(fd,
 NULL, 0, offset) return 0
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

Linux returns success if pwrite64() or pread64() are called with a
zero length NULL buffer, but QEMU was returning -TARGET_EFAULT.

This is the same bug that we fixed in commit 58cfa6c2e6eb51b23cc9
for the write syscall, and long before that in 38d840e6790c29f59
for the read syscall.

Fixes: https://bugs.launchpad.net/qemu/+bug/1810433

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190108184900.9654-1-peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
(cherry picked from commit 2bd3f8998e1e7dcd9afc29fab252fb9936f9e956)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 linux-user/syscall.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 280137da8c..b13a170e52 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9677,8 +9677,15 @@ static abi_long do_syscall1(void *cpu_env, int num=
, abi_long arg1,
             arg4 =3D arg5;
             arg5 =3D arg6;
         }
-        if (!(p =3D lock_user(VERIFY_WRITE, arg2, arg3, 0)))
-            return -TARGET_EFAULT;
+        if (arg2 =3D=3D 0 && arg3 =3D=3D 0) {
+            /* Special-case NULL buffer and zero length, which should su=
cceed */
+            p =3D 0;
+        } else {
+            p =3D lock_user(VERIFY_WRITE, arg2, arg3, 0);
+            if (!p) {
+                return -TARGET_EFAULT;
+            }
+        }
         ret =3D get_errno(pread64(arg1, p, arg3, target_offset64(arg4, a=
rg5)));
         unlock_user(p, arg2, ret);
         return ret;
@@ -9687,8 +9694,15 @@ static abi_long do_syscall1(void *cpu_env, int num=
, abi_long arg1,
             arg4 =3D arg5;
             arg5 =3D arg6;
         }
-        if (!(p =3D lock_user(VERIFY_READ, arg2, arg3, 1)))
-            return -TARGET_EFAULT;
+        if (arg2 =3D=3D 0 && arg3 =3D=3D 0) {
+            /* Special-case NULL buffer and zero length, which should su=
cceed */
+            p =3D 0;
+        } else {
+            p =3D lock_user(VERIFY_READ, arg2, arg3, 1);
+            if (!p) {
+                return -TARGET_EFAULT;
+            }
+        }
         ret =3D get_errno(pwrite64(arg1, p, arg3, target_offset64(arg4, =
arg5)));
         unlock_user(p, arg2, 0);
         return ret;
--=20
2.17.1


