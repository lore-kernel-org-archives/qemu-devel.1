Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4717C04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 05:46:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7F6F205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 05:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F6F205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47678 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVrQ8-00020I-Uh
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 01:46:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hVrKD-00060f-H0
	for qemu-devel@nongnu.org; Wed, 29 May 2019 01:40:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hVrKC-00057y-HO
	for qemu-devel@nongnu.org; Wed, 29 May 2019 01:40:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1hVrKC-00055Q-6b
	for qemu-devel@nongnu.org; Wed, 29 May 2019 01:40:32 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4T5XOKJ042559
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 01:40:31 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ssk4s9w5r-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 01:40:30 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Wed, 29 May 2019 06:40:30 +0100
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
	by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Wed, 29 May 2019 06:40:27 +0100
Received: from b03ledav005.gho.boulder.ibm.com
	(b03ledav005.gho.boulder.ibm.com [9.17.130.236])
	by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4T5eQiC12648894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Wed, 29 May 2019 05:40:26 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B185DBE051;
	Wed, 29 May 2019 05:40:26 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FD0DBE04F;
	Wed, 29 May 2019 05:40:24 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.124.31.56])
	by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
	Wed, 29 May 2019 05:40:24 +0000 (GMT)
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
To: aik@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
	david@gibson.dropbear.id.au
Date: Wed, 29 May 2019 11:10:23 +0530
In-Reply-To: <155910829070.13149.5215948335633966328.stgit@aravinda>
References: <155910829070.13149.5215948335633966328.stgit@aravinda>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19052905-8235-0000-0000-00000E9FBB27
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011177; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000286; SDB=6.01210123; UDB=6.00635758;
	IPR=6.00991155; 
	MB=3.00027096; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-29 05:40:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052905-8236-0000-0000-000045C34D72
Message-Id: <155910842340.13149.1753970249353896871.stgit@aravinda>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-29_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=908 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905290037
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH v9 2/6] Wrapper function to wait on condition
 for the main loop mutex
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
Cc: paulus@ozlabs.org, aravinda@linux.vnet.ibm.com, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce a wrapper function to wait on condition for
the main loop mutex. This function atomically releases
the main loop mutex and causes the calling thread to
block on the condition. This wrapper is required because
qemu_global_mutex is a static variable.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 cpus.c                   |    5 +++++
 include/qemu/main-loop.h |    8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/cpus.c b/cpus.c
index ffc5711..14cb24b 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1867,6 +1867,11 @@ void qemu_mutex_unlock_iothread(void)
     qemu_mutex_unlock(&qemu_global_mutex);
 }
 
+void qemu_cond_wait_iothread(QemuCond *cond)
+{
+    qemu_cond_wait(cond, &qemu_global_mutex);
+}
+
 static bool all_vcpus_paused(void)
 {
     CPUState *cpu;
diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index f6ba78e..a6d20b0 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -295,6 +295,14 @@ void qemu_mutex_lock_iothread_impl(const char *file, int line);
  */
 void qemu_mutex_unlock_iothread(void);
 
+/*
+ * qemu_cond_wait_iothread: Wait on condition for the main loop mutex
+ *
+ * This function atomically releases the main loop mutex and causes
+ * the calling thread to block on the condition.
+ */
+void qemu_cond_wait_iothread(QemuCond *cond);
+
 /* internal interfaces */
 
 void qemu_fd_register(int fd);


