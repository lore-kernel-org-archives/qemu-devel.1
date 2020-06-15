Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3B2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 14:26:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85250206E2
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 14:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85250206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkq3y-0002bp-Uq
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 10:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1jkq1U-0007OJ-W3
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 10:23:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48874
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1jkq1T-0005Jh-BG
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 10:23:40 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05FE2V7r071063
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 10:23:38 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31np7bkrru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 10:23:38 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05FE2vZb073824
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 10:23:38 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31np7bkrrj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2020 10:23:38 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05FEKlbm010166;
 Mon, 15 Jun 2020 14:23:37 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma04dal.us.ibm.com with ESMTP id 31mpe8wt0j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2020 14:23:37 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05FENad559441594
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Jun 2020 14:23:36 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 035E8C6059;
 Mon, 15 Jun 2020 14:23:36 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5BCF1C6055;
 Mon, 15 Jun 2020 14:23:35 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 15 Jun 2020 14:23:35 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/5] tests: Add updated DSDT
Date: Mon, 15 Jun 2020 10:23:27 -0400
Message-Id: <20200615142327.671546-6-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200615142327.671546-1-stefanb@linux.vnet.ibm.com>
References: <20200615142327.671546-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-15_03:2020-06-15,
 2020-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 mlxlogscore=857 priorityscore=1501 impostorscore=0 clxscore=1015
 cotscore=-2147483648 mlxscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=1 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006150111
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=stefanb@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 08:37:04
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, eric.auger@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, philmd@redhat.com,
 mkedzier@redhat.com, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the updated DSDT following the interrupt enablement.

@@ -5,13 +5,13 @@
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/q35/DSDT.tis, Mon Jun 15 09:57:05 2020
+ * Disassembly of /tmp/aml-Y77YL0, Mon Jun 15 09:57:05 2020
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x000020A5 (8357)
+ *     Length           0x000020A8 (8360)
  *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
- *     Checksum         0xAD
+ *     Checksum         0x77
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPCDSDT"
  *     OEM Revision     0x00000001 (1)
@@ -3162,6 +3162,8 @@
                         0xFED40000,         // Address Base
                         0x00005000,         // Address Length
                         )
+                    IRQNoFlags ()
+                        {13}
                 })
                 OperationRegion (TPP2, SystemMemory, 0xFED45100, 0x5A)
                 Field (TPP2, AnyAcc, NoLock, Preserve)
**

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
CC: Michael S. Tsirkin <mst@redhat.com>
---
 tests/data/acpi/q35/DSDT.tis                | Bin 8357 -> 8360 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 2 files changed, 1 deletion(-)

diff --git a/tests/data/acpi/q35/DSDT.tis b/tests/data/acpi/q35/DSDT.tis
index 56b6fb0c3298517d080e38fea05a748b9f1dba54..3f9db960aa05d399fa7f8449e6db688788211832 100644
GIT binary patch
delta 64
zcmZ4LxWbXkCD<iog#rTuWBEp|KeC)oS~2m#PVoX>llkS`nVeK7N60A%iEs(FaWXJ6
UFkJb^5Wv8o#GtUbT~3Y(068!Z;Q#;t

delta 61
zcmZ4CxYUu$CD<iosR9E7<Jyf}e`GoRHDls~o#F-DC-cj>Gx@7bj*wH}7v$n=<78lD
RV7T&+A%KBlbC;YP695=#58(g+

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index bb4ce8967b..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/q35/DSDT.tis",
-- 
2.24.1


