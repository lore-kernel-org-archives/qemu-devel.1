Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E856DC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 09:06:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB83D20675
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 09:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB83D20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ9p5-00060Q-RE
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 05:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jZ9oC-0004RG-4I
 for qemu-devel@nongnu.org; Thu, 14 May 2020 05:05:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6318
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jZ9oA-0000qS-Pt
 for qemu-devel@nongnu.org; Thu, 14 May 2020 05:05:39 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04E8WgXd009859; Thu, 14 May 2020 05:05:27 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 310v8rk255-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 May 2020 05:05:26 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04E8e11g086128;
 Thu, 14 May 2020 05:05:26 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 310v8rk243-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 May 2020 05:05:26 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04E906Ga020036;
 Thu, 14 May 2020 09:05:24 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma04fra.de.ibm.com with ESMTP id 3100uc1bav-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 May 2020 09:05:24 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 04E95LQ153805344
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 May 2020 09:05:22 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D43AC52065;
 Thu, 14 May 2020 09:05:21 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id A455E5205F;
 Thu, 14 May 2020 09:05:21 +0000 (GMT)
Received: from bahia.ibmuc.com (sig-9-145-63-64.uk.ibm.com [9.145.63.64])
 by smtp.tlslab.ibm.com (Postfix) with ESMTP id 0833D220190;
 Thu, 14 May 2020 11:05:20 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/4] qemu-options.hx: 9p: clarify -virtfs vs. -fsdev
Date: Thu, 14 May 2020 11:05:09 +0200
Message-Id: <20200514090511.256550-3-groug@kaod.org>
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
 mlxlogscore=999 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1034 impostorscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 cotscore=-2147483648
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140077
Received-SPF: softfail client-ip=148.163.158.5; envelope-from=groug@kaod.org;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 05:05:36
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
Cc: Cornelia Huck <cohuck@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Christian Schoenebeck <qemu_oss@crudebyte.com>

The docs are ambiguous about the difference (or actually their
equality) between options '-virtfs' vs. '-fsdev'. So clarify that
'-virtfs' is actually just a convenience shortcut for its
generalized form '-fsdev' in conjunction with '-device virtio-9p-pci'.

And as we're at it, also be a bit more descriptive what 9pfs is
actually used for.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <208f1fceffce2feaf7c900b29e326b967dce7762.1585661532.git.qemu=
_oss@crudebyte.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 qemu-options.hx | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 292d4e7c0cef..e2dca8a4e96b 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1542,9 +1542,17 @@ SRST
 ``-virtfs proxy,sock_fd=3Dsock_fd,mount_tag=3Dmount_tag [,writeout=3Dwri=
teout][,readonly]``
   \
 ``-virtfs synth,mount_tag=3Dmount_tag``
-    Define a new filesystem device and expose it to the guest using a
-    virtio-9p-device. The general form of a Virtual File system
-    pass-through options are:
+    Define a new virtual filesystem device and expose it to the guest us=
ing
+    a virtio-9p-device (a.k.a. 9pfs), which essentially means that a cer=
tain
+    directory on host is made directly accessible by guest as a pass-thr=
ough
+    file system by using the 9P network protocol for communication betwe=
en
+    host and guests, if desired even accessible, shared by several guest=
s
+    simultaniously.
+
+    Note that ``-virtfs`` is actually just a convenience shortcut for it=
s
+    generalized form ``-fsdev -device virtio-9p-pci``.
+
+    The general form of pass-through file system options are:
=20
     ``local``
         Accesses to the filesystem are done by QEMU.
--=20
2.21.3


