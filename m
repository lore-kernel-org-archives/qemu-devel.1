Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA07C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:22:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 016CA20873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016CA20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2FOJ-0005tF-1a
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:22:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <borntraeger@de.ibm.com>) id 1j2FNQ-00052U-VZ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:22:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1j2FNO-0005xK-Ol
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:22:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23850)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1j2FNO-0005oo-Gc
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:21:58 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01DEJ8KA104754
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 09:21:55 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y57as9ysp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 09:21:54 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
 Thu, 13 Feb 2020 14:21:52 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 13 Feb 2020 14:21:49 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 01DEKsB640173906
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Feb 2020 14:20:54 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B306DAE055;
 Thu, 13 Feb 2020 14:21:48 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E73AAE05A;
 Thu, 13 Feb 2020 14:21:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu, 13 Feb 2020 14:21:48 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
 id 2AF32E03C5; Thu, 13 Feb 2020 15:21:48 +0100 (CET)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] uapi: fix userspace breakage, use __BITS_PER_LONG for swap
Date: Thu, 13 Feb 2020 15:21:47 +0100
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
x-cbid: 20021314-0012-0000-0000-000003868148
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021314-0013-0000-0000-000021C304CC
Message-Id: <20200213142147.17604-1-borntraeger@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-13_04:2020-02-12,
 2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=975 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130114
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id 01DEJ8KA104754
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
Cc: Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-devel <qemu-devel@nongnu.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 William Breathitt Gray <vilhelm.gray@gmail.com>, Joe Perches <joe@perches.com>,
 Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU has a funny new build error message when I use the upstream kernel h=
eaders:

  CC      block/file-posix.o
In file included from /home/cborntra/REPOS/qemu/include/qemu/timer.h:4,
                 from /home/cborntra/REPOS/qemu/include/qemu/timed-averag=
e.h:29,
                 from /home/cborntra/REPOS/qemu/include/block/accounting.=
h:28,
                 from /home/cborntra/REPOS/qemu/include/block/block_int.h=
:27,
                 from /home/cborntra/REPOS/qemu/block/file-posix.c:30:
/usr/include/linux/swab.h: In function =E2=80=98__swab=E2=80=99:
/home/cborntra/REPOS/qemu/include/qemu/bitops.h:20:34: error: "sizeof" is=
 not defined, evaluates to 0 [-Werror=3Dundef]
   20 | #define BITS_PER_LONG           (sizeof (unsigned long) * BITS_PE=
R_BYTE)
      |                                  ^~~~~~
/home/cborntra/REPOS/qemu/include/qemu/bitops.h:20:41: error: missing bin=
ary operator before token "("
   20 | #define BITS_PER_LONG           (sizeof (unsigned long) * BITS_PE=
R_BYTE)
      |                                         ^
cc1: all warnings being treated as errors
make: *** [/home/cborntra/REPOS/qemu/rules.mak:69: block/file-posix.o] Er=
ror 1
rm tests/qemu-iotests/socket_scm_helper.o

This was triggered by commit d5767057c9a ("uapi: rename ext2_swab() to sw=
ab() and share globally in swab.h")
This patch is doing
+#include <asm/bitsperlong.h>
but it uses BITS_PER_LONG.

The kernel file asm/bitsperlong.h provide only __BITS_PER_LONG.

Let us use the __ variant in swap.h
Fixes: d5767057c9a ("uapi: rename ext2_swab() to swab() and share globall=
y in swab.h")
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Allison Randal <allison@lohutok.net>
Cc: Joe Perches <joe@perches.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 include/uapi/linux/swab.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/swab.h b/include/uapi/linux/swab.h
index fa7f97da5b76..7272f85d6d6a 100644
--- a/include/uapi/linux/swab.h
+++ b/include/uapi/linux/swab.h
@@ -135,9 +135,9 @@ static inline __attribute_const__ __u32 __fswahb32(__=
u32 val)
=20
 static __always_inline unsigned long __swab(const unsigned long y)
 {
-#if BITS_PER_LONG =3D=3D 64
+#if __BITS_PER_LONG =3D=3D 64
 	return __swab64(y);
-#else /* BITS_PER_LONG =3D=3D 32 */
+#else /* __BITS_PER_LONG =3D=3D 32 */
 	return __swab32(y);
 #endif
 }
--=20
2.24.1


