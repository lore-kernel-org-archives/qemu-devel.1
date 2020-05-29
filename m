Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9209EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:53:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DE5A208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE5A208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jelzv-0002dJ-Eu
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 16:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1jelyf-00012L-6o
 for qemu-devel@nongnu.org; Fri, 29 May 2020 16:51:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29680
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1jelye-0001dj-1H
 for qemu-devel@nongnu.org; Fri, 29 May 2020 16:51:40 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04TKY0kT175693
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 16:51:37 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31as1hvpjh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 16:51:37 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04TKYEYO177384
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 16:51:37 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31as1hvpjb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 May 2020 16:51:37 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04TKnBu4009095;
 Fri, 29 May 2020 20:51:36 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma01dal.us.ibm.com with ESMTP id 31b3njmvhs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 May 2020 20:51:36 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04TKpYMY26280444
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 May 2020 20:51:35 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD6DC6A04F;
 Fri, 29 May 2020 20:51:34 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 071716A047;
 Fri, 29 May 2020 20:51:33 +0000 (GMT)
Received: from Buonos-Thinkpad-X1.ibm.com (unknown [9.65.226.57])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 29 May 2020 20:51:33 +0000 (GMT)
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] Add support for SafeStack
Date: Fri, 29 May 2020 16:51:18 -0400
Message-Id: <20200529205122.714-1-dbuono@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-05-29_10:2020-05-28,
 2020-05-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 cotscore=-2147483648 mlxlogscore=999 mlxscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005290148
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 15:28:52
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 dbuono@linux.vnet.ibm.com
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

Changes since v1:
 - CONFIG_SAFESTACK is now set up in configure, and not in the code
 - Added option for a --disable-safe-stack in configure
 - Configure checks if SafeStack is enabled by default in the compiler,
   and set the CONFIG_SAFESTACK accordingly
 - Updated some comments in the code and the commit log

NOTE: I kept configure as Patch #3. 
The reason is that the code changes will not be enabled without the
configure, making the code fully functional if only Patches #1 or #2 are
applied.
On the other hand, the configure patch will produce incorrect code if we
request SafeStack and the other patches are not applied.

Daniele Buono (4):
  coroutine: support SafeStack in ucontext backend
  coroutine: add check for SafeStack in sigaltstack
  configure: add flags to support SafeStack
  check-block: enable iotests with SafeStack

 configure                    | 73 ++++++++++++++++++++++++++++++++++++
 include/qemu/coroutine_int.h |  5 +++
 tests/check-block.sh         | 12 +++++-
 util/coroutine-sigaltstack.c |  4 ++
 util/coroutine-ucontext.c    | 26 +++++++++++++
 5 files changed, 119 insertions(+), 1 deletion(-)

-- 
2.26.2


