Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB84C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:58:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79DD620771
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79DD620771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhZV-0002Sb-AT
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1jnhIs-0006Fz-6o
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:41:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22128)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1jnhIp-0004i9-O7
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:41:25 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05NBZDh7049386; Tue, 23 Jun 2020 07:41:22 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31ud79fryu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2020 07:41:21 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05NBZEdE049536;
 Tue, 23 Jun 2020 07:41:21 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31ud79fryc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2020 07:41:21 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05NBPM7C031231;
 Tue, 23 Jun 2020 11:41:20 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma04dal.us.ibm.com with ESMTP id 31sa38vmak-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2020 11:41:20 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05NBfHdr11272476
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2020 11:41:17 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F1D94C6055;
 Tue, 23 Jun 2020 11:41:18 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 77A06C6057;
 Tue, 23 Jun 2020 11:41:18 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2020 11:41:18 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 02/12] backends: Add TPM files into their own directory
Date: Tue, 23 Jun 2020 07:41:04 -0400
Message-Id: <20200623114114.1375104-3-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200623114114.1375104-1-stefanb@linux.vnet.ibm.com>
References: <20200623114114.1375104-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-23_06:2020-06-23,
 2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 cotscore=-2147483648 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=953 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006230092
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=stefanb@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 07:29:31
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

As we will have various TPM backend files, it is cleaner
to use a single directory.

Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Message-id: 20200612085444.8362-3-philmd@redhat.com
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 MAINTAINERS                           | 2 +-
 backends/Makefile.objs                | 2 +-
 backends/tpm/Makefile.objs            | 1 +
 backends/{tpm.c => tpm/tpm_backend.c} | 0
 4 files changed, 3 insertions(+), 2 deletions(-)
 create mode 100644 backends/tpm/Makefile.objs
 rename backends/{tpm.c => tpm/tpm_backend.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 955cc8dd5c..60a183c117 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2395,7 +2395,7 @@ F: hw/tpm/*
 F: include/hw/acpi/tpm.h
 F: include/sysemu/tpm*
 F: qapi/tpm.json
-F: backends/tpm.c
+F: backends/tpm/
 F: tests/qtest/*tpm*
 T: git https://github.com/stefanberger/qemu-tpm.git tpm-next
 
diff --git a/backends/Makefile.objs b/backends/Makefile.objs
index 28a847cd57..22d204cb48 100644
--- a/backends/Makefile.objs
+++ b/backends/Makefile.objs
@@ -1,7 +1,7 @@
 common-obj-y += rng.o rng-egd.o rng-builtin.o
 common-obj-$(CONFIG_POSIX) += rng-random.o
 
-common-obj-$(CONFIG_TPM) += tpm.o
+common-obj-$(CONFIG_TPM) += tpm/
 
 common-obj-y += hostmem.o hostmem-ram.o
 common-obj-$(CONFIG_POSIX) += hostmem-file.o
diff --git a/backends/tpm/Makefile.objs b/backends/tpm/Makefile.objs
new file mode 100644
index 0000000000..8cf5772824
--- /dev/null
+++ b/backends/tpm/Makefile.objs
@@ -0,0 +1 @@
+common-obj-y += tpm_backend.o
diff --git a/backends/tpm.c b/backends/tpm/tpm_backend.c
similarity index 100%
rename from backends/tpm.c
rename to backends/tpm/tpm_backend.c
-- 
2.24.1


