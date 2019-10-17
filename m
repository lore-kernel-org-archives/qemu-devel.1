Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48EDFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 21:02:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94BFA21D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 21:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94BFA21D7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLCuv-0001vL-Ed
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 17:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cheloha@linux.vnet.ibm.com>) id 1iLCsM-0000SE-3G
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 17:00:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cheloha@linux.vnet.ibm.com>) id 1iLCsJ-0008M5-UN
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 17:00:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61036
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cheloha@linux.vnet.ibm.com>)
 id 1iLCsJ-0008LJ-4T
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 16:59:59 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9HKcs8s059847
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 16:59:56 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vpv2d8sm4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 16:59:56 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x9HKd6qD060854
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 16:59:55 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vpv2d8sku-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2019 16:59:55 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9HKthSY025984;
 Thu, 17 Oct 2019 20:59:55 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma04wdc.us.ibm.com with ESMTP id 2vk6f7s5v2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2019 20:59:55 +0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x9HKxs3F59048310
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2019 20:59:54 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C1EC13604F;
 Thu, 17 Oct 2019 20:59:54 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 38CB8136059;
 Thu, 17 Oct 2019 20:59:54 +0000 (GMT)
Received: from rascal.austin.ibm.com (unknown [9.41.179.32])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 17 Oct 2019 20:59:54 +0000 (GMT)
From: Scott Cheloha <cheloha@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] migration: faster savevm_state_handler_insert()
Date: Thu, 17 Oct 2019 15:59:51 -0500
Message-Id: <20191017205953.13122-1-cheloha@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-17_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=1 spamscore=0
 clxscore=1015 lowpriorityscore=1 mlxscore=0 impostorscore=0
 mlxlogscore=749 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910170186
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
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The savevm_state.handlers queue of SaveStateEntry objects is a
priority queue with an O(n) insertion cost.  This is makes startup
extremely slow when a VM has many such objects to register.  For
instance, a ppc64 VM with a large (8T+) maxmem needs to register tens
of thousands of SaveStateEntry handlers: startup for these VMs is
glacial.

If we track insertion points within the priority queue we can make
savevm_state_handler_insert() a constant-time operation with little
change to the module's code.  Startup times for VMs with many handlers
are dramatically improved as a result.

Changes since v1:
  * Split patch 1 into 2 patches.

Scott Cheloha (2):
  migration: add savevm_state_handler_remove()
  migration: savevm_state_handler_insert: constant-time element
    insertion

 migration/savevm.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

-- 
2.23.0


