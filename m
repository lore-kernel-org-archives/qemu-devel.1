Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472DAC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 23:00:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496FD20659
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 23:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496FD20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ0MA-0001Mb-96
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 19:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1jZ0JZ-0004gu-2m; Wed, 13 May 2020 18:57:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53940)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1jZ0JY-0007AO-Az; Wed, 13 May 2020 18:57:24 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04DMX8Lo121641; Wed, 13 May 2020 18:57:12 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31016mwhhb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 May 2020 18:57:12 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04DMtWX0031577;
 Wed, 13 May 2020 22:57:10 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma02fra.de.ibm.com with ESMTP id 3100ub90fm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 May 2020 22:57:10 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04DMv7fQ46989550
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 May 2020 22:57:07 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C3909A404D;
 Wed, 13 May 2020 22:57:07 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B76DA4040;
 Wed, 13 May 2020 22:57:07 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.63.64])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 13 May 2020 22:57:07 +0000 (GMT)
Subject: [PATCH v2 4/6] target/ppc: Add missing braces in
 ppc_radix64_partition_scoped_xlate()
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 14 May 2020 00:57:07 +0200
Message-ID: <158941062665.240484.2663106458734800894.stgit@bahia.lan>
In-Reply-To: <158941060199.240484.5620994992064687533.stgit@bahia.lan>
References: <158941060199.240484.5620994992064687533.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-13_09:2020-05-13,
 2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1034
 priorityscore=1501 mlxlogscore=798 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 cotscore=-2147483648 phishscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005130193
Received-SPF: softfail client-ip=148.163.156.1; envelope-from=groug@kaod.org;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 18:45:01
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
Cc: qemu-ppc@nongnu.org, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As per CODING_STYLE.

Fixes: d04ea940c597 "target/ppc: Add support for Radix partition-scoped translation"
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/mmu-radix64.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 07f956c9864f..fb7dfe25ba6f 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -286,8 +286,9 @@ static int ppc_radix64_partition_scoped_xlate(PowerPCCPU *cpu, int rwx,
                               pate.dw0 & PRTBE_R_RPDS, h_raddr, h_page_size,
                               &pte, &fault_cause, &pte_addr) ||
         ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, h_prot, true)) {
-        if (pde_addr) /* address being translated was that of a guest pde */
+        if (pde_addr) { /* address being translated was that of a guest pde */
             fault_cause |= DSISR_PRTABLE_FAULT;
+        }
         if (cause_excp) {
             ppc_radix64_raise_hsi(cpu, rwx, eaddr, g_raddr, fault_cause);
         }


