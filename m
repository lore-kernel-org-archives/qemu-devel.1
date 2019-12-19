Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2B8C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2036224672
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2036224672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwl8-0005XJ-3B
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:26:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1ihwSh-0001z6-3g
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:07:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1ihwSc-00077r-7w
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:07:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28270
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1ihwSc-00075I-23; Thu, 19 Dec 2019 09:07:26 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBJE2QNs129001; Thu, 19 Dec 2019 09:07:22 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2x089gp7nw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Dec 2019 09:07:21 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBJE2wI9131631;
 Thu, 19 Dec 2019 09:07:10 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2x089gp79y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Dec 2019 09:07:10 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBJE63WZ007428;
 Thu, 19 Dec 2019 14:07:01 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma01wdc.us.ibm.com with ESMTP id 2wvqc6pv6y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Dec 2019 14:07:01 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBJE6t3Z35520802
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Dec 2019 14:06:55 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C9EAAC05E;
 Thu, 19 Dec 2019 14:06:55 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F1BBAC062;
 Thu, 19 Dec 2019 14:06:55 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 19 Dec 2019 14:06:55 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH v7 5/6] hw/ppc/Kconfig: Enable TPM_SPAPR as part of PSERIES
 config
Date: Thu, 19 Dec 2019 09:06:04 -0500
Message-Id: <20191219140605.3243321-6-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191219140605.3243321-1-stefanb@linux.vnet.ibm.com>
References: <20191219140605.3243321-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_01:2019-12-17,2019-12-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=1
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 mlxlogscore=999 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912190119
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.ibm.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/ppc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index f927ec9c74..b5b3519158 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -10,6 +10,7 @@ config PSERIES
     select XICS_SPAPR
     select XIVE_SPAPR
     select MSI_NONBROKEN
+    select TPM_SPAPR
 
 config SPAPR_RNG
     bool
-- 
2.21.0


