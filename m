Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8647C433E5
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 15:16:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD19B20771
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 15:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD19B20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jycxu-00067U-1d
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 11:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1jycvE-0003vA-43; Thu, 23 Jul 2020 11:14:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21626)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1jycvB-0007UQ-4N; Thu, 23 Jul 2020 11:14:11 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06NF4SBV122100; Thu, 23 Jul 2020 11:14:06 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32fb9b4at0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jul 2020 11:14:05 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06NF4Vxb122407;
 Thu, 23 Jul 2020 11:14:05 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32fb9b4asm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jul 2020 11:14:05 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06NFB9nC014158;
 Thu, 23 Jul 2020 15:14:05 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma02wdc.us.ibm.com with ESMTP id 32brq9n8b7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jul 2020 15:14:04 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06NFDxej25690782
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Jul 2020 15:13:59 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5DC67805F;
 Thu, 23 Jul 2020 15:14:01 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D228078068;
 Thu, 23 Jul 2020 15:14:00 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.211.108.134])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 23 Jul 2020 15:14:00 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: alex.williamson@redhat.com, pmorel@linux.ibm.com, schnelle@linux.ibm.com
Subject: [RFC PATCH] s390x/pci: Enforce PCI_COMMAND_MEMORY for vfio-pci
Date: Thu, 23 Jul 2020 11:13:56 -0400
Message-Id: <1595517236-17823-2-git-send-email-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1595517236-17823-1-git-send-email-mjrosato@linux.ibm.com>
References: <1595517236-17823-1-git-send-email-mjrosato@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-23_06:2020-07-23,
 2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007230109
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 10:22:03
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: david@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After kernel commit abafbc55 'vfio-pci: Invalidate mmaps and
block MMIO access on disabled memory', I'm seeing qemu errors
on s390x as vfio-pci devices attempt to read bar 0 because
PCI_COMMAND_MEMORY is not reliably set.  Ensure the value
stays ON while the device is in-use.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 hw/s390x/s390-pci-inst.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 2f7a7d7..74b8796 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -555,6 +555,16 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
         }
         /* len = 1,2,4 so we do not need to test */
         zpci_endian_swap(&data, len);
+
+        /*
+         * vfio-pci requires PCI_COMMAND_MEMORY.  Ensure that it
+         * stays on for an active device.
+         */
+        if ((pbdev->fh & FH_SHM_VFIO) && (offset == PCI_COMMAND) &&
+            (len == 2) && (data != 0)) {
+            data |= PCI_COMMAND_MEMORY;
+        }
+
         pci_host_config_write_common(pbdev->pdev, offset,
                                      pci_config_size(pbdev->pdev),
                                      data, len);
-- 
1.8.3.1


