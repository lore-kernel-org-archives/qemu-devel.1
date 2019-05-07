Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2501EC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:49:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EECA920B7C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EECA920B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42443 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNvmi-00078v-3h
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 04:49:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hNvj1-0004dL-C4
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hNvj0-0006gc-Bl
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:45:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hNvj0-0006fo-0X
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:45:22 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x478fuaZ028849
	for <qemu-devel@nongnu.org>; Tue, 7 May 2019 04:45:21 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2sb40ef1wb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 04:45:20 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 7 May 2019 09:45:16 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
	by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 7 May 2019 09:45:14 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
	(b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x478jD4X47644684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Tue, 7 May 2019 08:45:13 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C1B6A4054;
	Tue,  7 May 2019 08:45:12 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDB18A4067;
	Tue,  7 May 2019 08:45:11 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.26.205])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue,  7 May 2019 08:45:11 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Date: Tue, 07 May 2019 10:45:11 +0200
In-Reply-To: <155721868351.451636.16735088470797960209.stgit@bahia.lan>
References: <155721868351.451636.16735088470797960209.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19050708-0012-0000-0000-00000319186D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050708-0013-0000-0000-000021519484
Message-Id: <155721871159.451636.6528273080303910901.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-07_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=964 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905070057
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH 5/6] vl: Deprecate -virtfs_synth
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The synth fsdriver never got used for anything else but the
QTest testcase for VirtIO 9P. And even there, QTest directly
uses -fsdev synth and -device virtio-9p-{pci|device}.

Signed-off-by: Greg Kurz <groug@kaod.org>
---

This should be Cc'd to libvir-list@redhat.com according to MAINTAINERS,
but libvirt doesn't know about -virtfs_synth, so I choose to not spam :)
---
 qemu-deprecated.texi |    4 ++++
 qemu-options.hx      |    3 ++-
 vl.c                 |    5 +++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 842e71b11dcc..f0ff065e7dc1 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -72,6 +72,10 @@ backend settings instead of environment variables.  To ease migration to
 the new format, the ``-audiodev-help'' option can be used to convert
 the current values of the environment variables to ``-audiodev'' options.
 
+@subsection -virtfs_synth (since 4.1)
+
+The ``-virtfs_synth'' argument is now deprecated with no replacement.
+
 @section QEMU Machine Protocol (QMP) commands
 
 @subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
diff --git a/qemu-options.hx b/qemu-options.hx
index 51802cbb266a..9c5cc2e6bf70 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1368,7 +1368,8 @@ DEF("virtfs_synth", 0, QEMU_OPTION_virtfs_synth,
 STEXI
 @item -virtfs_synth
 @findex -virtfs_synth
-Create synthetic file system image
+Create synthetic file system image. Note that this option is deprecated with
+no replacement.
 ETEXI
 
 DEF("iscsi", HAS_ARG, QEMU_OPTION_iscsi,
diff --git a/vl.c b/vl.c
index d9fea0a11966..c010cb3e98df 100644
--- a/vl.c
+++ b/vl.c
@@ -3507,6 +3507,11 @@ int main(int argc, char **argv, char **envp)
                 QemuOpts *fsdev;
                 QemuOpts *device;
 
+                warn_report("The -virtfs_synth option is deprecated and will "
+                            "be removed soon. If the -virtfs_synth option is "
+                            "still useful for you, please send a mail to "
+                            "qemu-devel@nongnu.org with your usecase.");
+
                 fsdev = qemu_opts_create(qemu_find_opts("fsdev"), "v_synth",
                                          1, NULL);
                 if (!fsdev) {


