Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AB7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 09:06:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5244A206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 09:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5244A206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ9p9-0006A0-ED
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 05:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jZ9oI-0004Tx-IL
 for qemu-devel@nongnu.org; Thu, 14 May 2020 05:05:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jZ9oH-0000up-LF
 for qemu-devel@nongnu.org; Thu, 14 May 2020 05:05:46 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04E926FV166323; Thu, 14 May 2020 05:05:27 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3111wgj8rr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 May 2020 05:05:27 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04E8xiFQ017236;
 Thu, 14 May 2020 09:05:24 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma03ams.nl.ibm.com with ESMTP id 3100ubba78-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 May 2020 09:05:24 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 04E94BXq51183926
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 May 2020 09:04:11 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8477E42052;
 Thu, 14 May 2020 09:05:22 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5410F42059;
 Thu, 14 May 2020 09:05:22 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Thu, 14 May 2020 09:05:22 +0000 (GMT)
Received: from bahia.ibmuc.com (sig-9-145-63-64.uk.ibm.com [9.145.63.64])
 by smtp.tlslab.ibm.com (Postfix) with ESMTP id A18522201A2;
 Thu, 14 May 2020 11:05:21 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 3/4] 9pfs: local: ignore O_NOATIME if we don't have permissions
Date: Thu, 14 May 2020 11:05:10 +0200
Message-Id: <20200514090511.256550-4-groug@kaod.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200514090511.256550-1-groug@kaod.org>
References: <20200514090511.256550-1-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-14_01:2020-05-13,
 2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1034
 cotscore=-2147483648 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005140077
Received-SPF: softfail client-ip=148.163.156.1; envelope-from=groug@kaod.org;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 05:05:42
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_SOFTFAIL=0.665,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Omar Sandoval <osandov@fb.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Omar Sandoval <osandov@fb.com>

QEMU's local 9pfs server passes through O_NOATIME from the client. If
the QEMU process doesn't have permissions to use O_NOATIME (namely, it
does not own the file nor have the CAP_FOWNER capability), the open will
fail. This causes issues when from the client's point of view, it
believes it has permissions to use O_NOATIME (e.g., a process running as
root in the virtual machine). Additionally, overlayfs on Linux opens
files on the lower layer using O_NOATIME, so in this case a 9pfs mount
can't be used as a lower layer for overlayfs (cf.
https://github.com/osandov/drgn/blob/dabfe1971951701da13863dbe6d8a1d172ad=
9650/vmtest/onoatimehack.c
and https://github.com/NixOS/nixpkgs/issues/54509).

Luckily, O_NOATIME is effectively a hint, and is often ignored by, e.g.,
network filesystems. open(2) notes that O_NOATIME "may not be effective
on all filesystems. One example is NFS, where the server maintains the
access time." This means that we can honor it when possible but fall
back to ignoring it.

Acked-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
Message-Id: <e9bee604e8df528584693a4ec474ded6295ce8ad.1587149256.git.osan=
dov@fb.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-util.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
index 79ed6b233e58..546f46dc7dc6 100644
--- a/hw/9pfs/9p-util.h
+++ b/hw/9pfs/9p-util.h
@@ -37,9 +37,22 @@ static inline int openat_file(int dirfd, const char *n=
ame, int flags,
 {
     int fd, serrno, ret;
=20
+again:
     fd =3D openat(dirfd, name, flags | O_NOFOLLOW | O_NOCTTY | O_NONBLOC=
K,
                 mode);
     if (fd =3D=3D -1) {
+        if (errno =3D=3D EPERM && (flags & O_NOATIME)) {
+            /*
+             * The client passed O_NOATIME but we lack permissions to ho=
nor it.
+             * Rather than failing the open, fall back without O_NOATIME=
. This
+             * doesn't break the semantics on the client side, as the Li=
nux
+             * open(2) man page notes that O_NOATIME "may not be effecti=
ve on
+             * all filesystems". In particular, NFS and other network
+             * filesystems ignore it entirely.
+             */
+            flags &=3D ~O_NOATIME;
+            goto again;
+        }
         return -1;
     }
=20
--=20
2.21.3


