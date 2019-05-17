Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9A4C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 18:40:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 905E12053B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 18:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 905E12053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52367 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRhmG-00015z-PE
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 14:40:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hRhfG-0004Ad-CE
	for qemu-devel@nongnu.org; Fri, 17 May 2019 14:33:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hRhfF-0006LW-CF
	for qemu-devel@nongnu.org; Fri, 17 May 2019 14:33:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44966
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hRhfF-0006Kn-5w
	for qemu-devel@nongnu.org; Fri, 17 May 2019 14:33:05 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4HIWEl7008212
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 14:33:03 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2sj2au80wj-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 14:33:03 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 17 May 2019 19:33:01 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
	by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 17 May 2019 19:32:58 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
	[9.149.105.58])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4HIWvE643647100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Fri, 17 May 2019 18:32:57 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DCD34C066;
	Fri, 17 May 2019 18:32:57 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 257D64C058;
	Fri, 17 May 2019 18:32:57 +0000 (GMT)
Received: from smtp.lab.toulouse-stg.fr.ibm.com (unknown [9.101.4.1])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri, 17 May 2019 18:32:57 +0000 (GMT)
Received: from bahia.ibmuc.com (sig-9-145-156-103.de.ibm.com [9.145.156.103])
	by smtp.lab.toulouse-stg.fr.ibm.com (Postfix) with ESMTP id
	A86AD22019A; Fri, 17 May 2019 20:32:56 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 20:32:39 +0200
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190517183240.689188-1-groug@kaod.org>
References: <20190517183240.689188-1-groug@kaod.org>
X-TM-AS-GCONF: 00
x-cbid: 19051718-0016-0000-0000-0000027CD883
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051718-0017-0000-0000-000032D9B6B1
Message-Id: <20190517183240.689188-6-groug@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-17_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905170108
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PULL 5/6] vl: Deprecate -virtfs_synth
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The synth fsdriver never got used for anything else but the QTest
testcase for VirtIO 9P. And even there, QTest uses -fsdev synth and
-device virtio-9p-... directly.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 qemu-deprecated.texi | 5 +++++
 qemu-options.hx      | 3 ++-
 vl.c                 | 4 ++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 842e71b11dcc..1a821b68f435 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -72,6 +72,11 @@ backend settings instead of environment variables.  To ease migration to
 the new format, the ``-audiodev-help'' option can be used to convert
 the current values of the environment variables to ``-audiodev'' options.
 
+@subsection -virtfs_synth (since 4.1)
+
+The ``-virtfs_synth'' argument is now deprecated. Please use ``-fsdev synth''
+and ``-device virtio-9p-...'' instead.
+
 @section QEMU Machine Protocol (QMP) commands
 
 @subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
diff --git a/qemu-options.hx b/qemu-options.hx
index 3faa93592991..e54c56593b25 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1368,7 +1368,8 @@ DEF("virtfs_synth", 0, QEMU_OPTION_virtfs_synth,
 STEXI
 @item -virtfs_synth
 @findex -virtfs_synth
-Create synthetic file system image
+Create synthetic file system image. Note that this option is now deprecated.
+Please use @code{-fsdev synth} and @code{-device virtio-9p-...} instead.
 ETEXI
 
 DEF("iscsi", HAS_ARG, QEMU_OPTION_iscsi,
diff --git a/vl.c b/vl.c
index b6709514c1bb..8456f006edbd 100644
--- a/vl.c
+++ b/vl.c
@@ -3535,6 +3535,10 @@ int main(int argc, char **argv, char **envp)
                 QemuOpts *fsdev;
                 QemuOpts *device;
 
+                warn_report("'-virtfs_synth' is deprecated, please use "
+                             "'-fsdev synth' and '-device virtio-9p-...' "
+                            "instead");
+
                 fsdev = qemu_opts_create(qemu_find_opts("fsdev"), "v_synth",
                                          1, NULL);
                 if (!fsdev) {
-- 
2.17.2


