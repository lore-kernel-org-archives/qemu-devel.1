Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2679DC76192
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 21:00:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEBC52173E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 21:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEBC52173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnr2f-0006Fc-6c
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 17:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42644)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hnr1x-0003op-D5
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 17:00:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hnr1w-0006sD-3H
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 17:00:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54230
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1hnr1t-0006lx-Gf; Wed, 17 Jul 2019 17:00:01 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6HKvEGx069313; Wed, 17 Jul 2019 16:59:56 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tt9nrbukm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jul 2019 16:59:56 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6HKtEMb007489;
 Wed, 17 Jul 2019 20:59:55 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma03dal.us.ibm.com with ESMTP id 2tq6x7jbut-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jul 2019 20:59:55 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6HKxsVl49021308
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2019 20:59:54 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A68C12805A;
 Wed, 17 Jul 2019 20:59:54 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 74F5028058;
 Wed, 17 Jul 2019 20:59:54 +0000 (GMT)
Received: from localhost (unknown [9.80.82.153])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jul 2019 20:59:54 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 15:58:40 -0500
Message-Id: <20190717205842.17827-1-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-17_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907170237
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH for-4.2 v2 0/2] spapr: Implement H_TPM_COMM for
 accessing host TPM device
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
Cc: linuxram@us.ibm.com, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These patches are based on ppc-for-4.2 and are also available at:

  https://github.com/mdroth/qemu/commits/spapr-tpm-hcall-v2

This patchset implements the H_TPM_COMM hypercall, which provides a way
for an Ultravisor to pass raw TPM commands on to a host's TPM device,
either directly or through a TPM Resource Manager (needed to support
multiple guests).

Secure VMs running on an Ultravisor have a symmetric key that is
encrypted using a public key that is bound to a trusted host's TPM
hardware. This hypercall provides a means to decrypt the symmetric
key on behalf of a Secure VMs using the host's TPM hardware.

More details are provided in the spec summary introduced in patch 1.

Changes since v1:
 - use separate hcall table for SVM hcall range (David)
 - document reserved hcall range in ppc-spapr-uv-hcalls.txt

Changes since RFC/v0:
 - configure TPM path via -device spapr-tpm-proxy instead of -machine (David)
 - return H_FUNCTION (not H_RESOURCE) if TPM has not been configured (David)
 - drop use of global for storing TPM FD (David)
 - fix checkpatch errors relating to case statement indents, newlines in
   error_report(), and lines over 80.
 - fix some minor typos in documentation
 - rebased on ppc-for-4.2

 docs/specs/ppc-spapr-uv-hcalls.txt |  76 +++++++++++++++++++++++++++
 hw/ppc/Makefile.objs               |   1 +
 hw/ppc/spapr.c                     |  33 +++++++++++-
 hw/ppc/spapr_hcall.c               |  13 +++++
 hw/ppc/spapr_tpm_proxy.c           | 176 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/trace-events                |   4 ++
 include/hw/ppc/spapr.h             |  11 ++++
 include/hw/ppc/spapr_tpm_proxy.h   |  31 +++++++++++
 8 files changed, 344 insertions(+), 1 deletion(-)



