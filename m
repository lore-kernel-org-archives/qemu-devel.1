Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348A3C28CC3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 10:25:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E26A20B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 10:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E26A20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51204 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVvmG-0000ns-9c
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 06:25:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hVvlR-0000Ow-1k
	for qemu-devel@nongnu.org; Wed, 29 May 2019 06:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hVvlQ-0005gw-0M
	for qemu-devel@nongnu.org; Wed, 29 May 2019 06:24:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55392
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hVvlP-0005gS-Sd
	for qemu-devel@nongnu.org; Wed, 29 May 2019 06:24:55 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4TAHaOI058618
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 06:24:51 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ssq4uu1ak-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 06:24:51 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Wed, 29 May 2019 11:24:49 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
	by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Wed, 29 May 2019 11:24:46 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
	(b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4TAOjuf48824524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Wed, 29 May 2019 10:24:45 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36F57A4054;
	Wed, 29 May 2019 10:24:45 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00798A405C;
	Wed, 29 May 2019 10:24:45 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.189.170])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Wed, 29 May 2019 10:24:44 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Date: Wed, 29 May 2019 12:24:44 +0200
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19052910-0020-0000-0000-000003418EC5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052910-0021-0000-0000-000021948F12
Message-Id: <155912548463.2019004.3515830305299809902.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-29_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905290069
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Change maintership of Xen code
 under hw/9pfs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Anthony Perard <anthony.perard@citrix.com>,
	Stefano Stabellini <sstabellini@kernel.org>, Greg Kurz <groug@kaod.org>,
	Paul Durrant <paul.durrant@citrix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Xen folks are the actual maintainers for this.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 MAINTAINERS |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1f5f8b7a2c37..d00380641796 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -411,7 +411,7 @@ M: Paul Durrant <paul.durrant@citrix.com>
 L: xen-devel@lists.xenproject.org
 S: Supported
 F: */xen*
-F: hw/9pfs/xen-9p-backend.c
+F: hw/9pfs/xen-9p*
 F: hw/char/xen_console.c
 F: hw/display/xenfb.c
 F: hw/net/xen_nic.c
@@ -1505,6 +1505,7 @@ virtio-9p
 M: Greg Kurz <groug@kaod.org>
 S: Supported
 F: hw/9pfs/
+X: hw/9pfs/xen-9p*
 F: fsdev/
 F: tests/virtio-9p-test.c
 T: git https://github.com/gkurz/qemu.git 9p-next


