Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEA6C83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 19:48:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3B76221F4
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 19:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B76221F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTsh3-0000jm-TH
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 15:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dbuono@linux.vnet.ibm.com>) id 1jTsfp-0006og-9u
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 15:47:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dbuono@linux.vnet.ibm.com>) id 1jTsdW-0000kY-S1
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 15:47:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51554
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1jTsdW-0000kM-Ds
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 15:44:50 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03TJWqYT166524
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 15:44:47 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 30qe1hus83-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 15:44:47 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03TJY16a169042
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 15:44:47 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0b-001b2d01.pphosted.com with ESMTP id 30qe1hus7t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2020 15:44:47 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03TJVLWL007700;
 Wed, 29 Apr 2020 19:44:46 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma01wdc.us.ibm.com with ESMTP id 30mcu6qbw7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2020 19:44:46 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 03TJijxV26870066
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Apr 2020 19:44:45 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 74B156A054;
 Wed, 29 Apr 2020 19:44:45 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B1A916A04D;
 Wed, 29 Apr 2020 19:44:44 +0000 (GMT)
Received: from Buonos-Thinkpad-X1.ibm.com (unknown [9.160.84.167])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 29 Apr 2020 19:44:44 +0000 (GMT)
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] Add support for SafeStack
Date: Wed, 29 Apr 2020 15:44:16 -0400
Message-Id: <20200429194420.21147-1-dbuono@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-29_09:2020-04-29,
 2020-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 spamscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290143
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 15:44:47
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Tobin Feldman-Fitzthum <tobin@ibm.com>,
 Daniele Buono <dbuono@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

LLVM supports SafeStack instrumentation to protect against stack buffer
overflows, since version 3.7

From https://clang.llvm.org/docs/SafeStack.html:
"It works by separating the program stack into two distinct regions: the
safe stack and the unsafe stack. The safe stack stores return addresses,
register spills, and local variables that are always accessed in a safe
way, while the unsafe stack stores everything else. This separation
ensures that buffer overflows on the unsafe stack cannot be used to
overwrite anything on the safe stack."

Unfortunately, the use of two stack regions does not cope well with
QEMU's coroutines. The second stack region is not properly set up with
both ucontext and sigaltstack, so multiple coroutines end up sharing the
same memory area for the unsafe stack, causing undefined behaviors at
runtime (and most iochecks to fail).

This patch series fixes the implementation of the ucontext backend and
make sure that sigaltstack is never used if the compiler is applying
the SafeStack instrumentation. It also adds a configure flag to enable
SafeStack, and enables iotests when SafeStack is used.

This is an RFC mainly because of the low-level use of the SafeStack
runtime.
When running swapcontext(), we have to manually set the unsafe stack
pointer to the new area allocated for the coroutine. LLVM does not allow
this by using builtin, so we have to use implementation details that may
change in the future.
This patch has been tested briefly ( make check on an x86 system ) with
clang v3.9, v4.0, v5.0, v6.0
Heavier testing, with make check-acceptance has been performed with
clang v7.0

Daniele Buono (4):
  coroutine: support SafeStack in ucontext backend
  coroutine: Add check for SafeStack in sigalstack
  configure: add flag to enable SafeStack
  check-block: Enable iotests with SafeStack

 configure                    | 29 +++++++++++++++++++++++++++++
 include/qemu/coroutine_int.h |  6 ++++++
 tests/check-block.sh         | 12 +++++++++++-
 util/coroutine-sigaltstack.c |  4 ++++
 util/coroutine-ucontext.c    | 25 +++++++++++++++++++++++++
 5 files changed, 75 insertions(+), 1 deletion(-)

-- 
2.26.2


