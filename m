Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35746C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 22:41:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 076A5214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 22:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 076A5214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifX8m-0005ln-86
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 17:41:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ifX4n-0000xS-VE
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:36:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ifX4m-0000hP-IZ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:36:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41194)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ifX4m-0000fU-9j
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:36:52 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBCMWR4L079832
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 17:36:51 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wugd2wmgd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 17:36:51 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Thu, 12 Dec 2019 22:36:49 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 12 Dec 2019 22:36:46 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBCMajrr52887572
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Dec 2019 22:36:45 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 902B711C066;
 Thu, 12 Dec 2019 22:36:45 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7BF2811C052;
 Thu, 12 Dec 2019 22:36:45 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 12 Dec 2019 22:36:45 +0000 (GMT)
Received: from bahia.ibmuc.com (sig-9-145-185-241.de.ibm.com [9.145.185.241])
 by smtp.tlslab.ibm.com (Postfix) with ESMTP id EFDD4220110;
 Thu, 12 Dec 2019 23:36:44 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 5/5] virtfs: Remove the deprecated "-virtfs_synth" option
Date: Thu, 12 Dec 2019 23:36:00 +0100
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191212223601.309245-1-groug@kaod.org>
References: <20191212223601.309245-1-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19121222-0016-0000-0000-000002D441B9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121222-0017-0000-0000-000033366A4A
Message-Id: <20191212223601.309245-6-groug@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_07:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=2
 mlxlogscore=999 clxscore=1034 adultscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120172
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

It's been marked as deprecated since QEMU v4.1, time to remove it now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 qemu-deprecated.texi |  5 -----
 qemu-options.hx      | 10 ----------
 vl.c                 | 23 -----------------------
 3 files changed, 38 deletions(-)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 4b4b7425ac1e..8471eef9c22d 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -89,11 +89,6 @@ error in the future.
 The @code{-realtime mlock=on|off} argument has been replaced by the
 @code{-overcommit mem-lock=on|off} argument.
 
-@subsection -virtfs_synth (since 4.1)
-
-The ``-virtfs_synth'' argument is now deprecated. Please use ``-fsdev synth''
-and ``-device virtio-9p-...'' instead.
-
 @subsection -numa node,mem=@var{size} (since 4.1)
 
 The parameter @option{mem} of @option{-numa node} is used to assign a part of
diff --git a/qemu-options.hx b/qemu-options.hx
index 65c9473b7325..4cf7751adeba 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1468,16 +1468,6 @@ would still return entries from other devices).
 @end table
 ETEXI
 
-DEF("virtfs_synth", 0, QEMU_OPTION_virtfs_synth,
-    "-virtfs_synth Create synthetic file system image\n",
-    QEMU_ARCH_ALL)
-STEXI
-@item -virtfs_synth
-@findex -virtfs_synth
-Create synthetic file system image. Note that this option is now deprecated.
-Please use @code{-fsdev synth} and @code{-device virtio-9p-...} instead.
-ETEXI
-
 DEF("iscsi", HAS_ARG, QEMU_OPTION_iscsi,
     "-iscsi [user=user][,password=password]\n"
     "       [,header-digest=CRC32C|CR32C-NONE|NONE-CRC32C|NONE\n"
diff --git a/vl.c b/vl.c
index 6a65a64bfd64..c0904b365b55 100644
--- a/vl.c
+++ b/vl.c
@@ -3374,29 +3374,6 @@ int main(int argc, char **argv, char **envp)
                              qemu_opt_get(opts, "mount_tag"), &error_abort);
                 break;
             }
-            case QEMU_OPTION_virtfs_synth: {
-                QemuOpts *fsdev;
-                QemuOpts *device;
-
-                warn_report("'-virtfs_synth' is deprecated, please use "
-                             "'-fsdev synth' and '-device virtio-9p-...' "
-                            "instead");
-
-                fsdev = qemu_opts_create(qemu_find_opts("fsdev"), "v_synth",
-                                         1, NULL);
-                if (!fsdev) {
-                    error_report("duplicate option: %s", "virtfs_synth");
-                    exit(1);
-                }
-                qemu_opt_set(fsdev, "fsdriver", "synth", &error_abort);
-
-                device = qemu_opts_create(qemu_find_opts("device"), NULL, 0,
-                                          &error_abort);
-                qemu_opt_set(device, "driver", "virtio-9p-pci", &error_abort);
-                qemu_opt_set(device, "fsdev", "v_synth", &error_abort);
-                qemu_opt_set(device, "mount_tag", "v_synth", &error_abort);
-                break;
-            }
             case QEMU_OPTION_serial:
                 add_device_config(DEV_SERIAL, optarg);
                 default_serial = 0;
-- 
2.21.0


