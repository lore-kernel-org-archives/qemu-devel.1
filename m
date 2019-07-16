Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F750C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 23:53:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 323B12184C
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 23:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 323B12184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnXGb-0007TI-Cx
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 19:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38853)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hnXGO-0006qB-32
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 19:53:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hnXGN-0001oy-1r
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 19:53:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34284
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1hnXGM-0001og-SD
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 19:53:38 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6GMcQru070992
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 19:53:36 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2tsnp8p2ub-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 19:53:36 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
 Wed, 17 Jul 2019 00:53:35 +0100
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
 by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 17 Jul 2019 00:53:33 +0100
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6GNrWV855443888
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2019 23:53:32 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F774136055;
 Tue, 16 Jul 2019 23:53:32 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 766E913604F;
 Tue, 16 Jul 2019 23:53:32 +0000 (GMT)
Received: from localhost (unknown [9.53.179.212])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jul 2019 23:53:32 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 18:53:11 -0500
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19071623-0016-0000-0000-000009CE64A6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011441; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01233212; UDB=6.00649782; IPR=6.01014523; 
 MB=3.00027750; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-16 23:53:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071623-0017-0000-0000-0000440AA30A
Message-Id: <20190716235313.29806-1-mdroth@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-16_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907160261
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH for-4.2 0/2] spapr: Implement H_TPM_COMM for
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

  https://github.com/mdroth/qemu/commits/spapr-tpm-hcall-v1

This patchset implements the H_TPM_COMM hypercall, which provides a way
for an Ultravisor to pass raw TPM commands on to a host's TPM device,
either directly or through a TPM Resource Manager (needed to support
multiple guests).

Secure Guests running on an Ultravisor have a symmetric key that is
encrypted using a public key that is bound to a trusted host's TPM
hardware. This hypercall provides a means to decrypt the symmetric
key on behalf of a Secure Guest using the host's TPM hardware.

More details are provided in the spec summary introduced in patch 1.

Changes since RFC/v0:
 - configure TPM path via -device spapr-tpm-proxy instead of -machine (David)
 - return H_FUNCTION (not H_RESOURCE) if TPM has not been configured (David)
 - drop use of global for storing TPM FD (David)
 - fix checkpatch errors relating to case statement indents, newlines in
   error_report(), and lines over 80.
 - fix some minor typos in documentation
 - rebased on ppc-for-4.2

 docs/specs/ppc-spapr-uv-hcalls.txt |  75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/Makefile.objs               |   1 +
 hw/ppc/spapr.c                     |  33 +++++++++++++++++++++++++++++++-
 hw/ppc/spapr_tpm_proxy.c           | 176 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/trace-events                |   4 ++++
 include/hw/ppc/spapr.h             |   5 ++++-
 include/hw/ppc/spapr_tpm_proxy.h   |  31 ++++++++++++++++++++++++++++++
 7 files changed, 323 insertions(+), 2 deletions(-)



