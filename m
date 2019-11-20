Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A249C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:46:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1035A22304
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1035A22304
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXORA-0004sp-Pi
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 06:46:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iXOOu-00036F-13
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:44:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iXOOs-00035o-0k
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:43:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59490)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iXOOq-0002yI-1z
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:43:57 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAKBgEbV094689
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 06:43:53 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wcf57cwqs-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 06:43:52 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Wed, 20 Nov 2019 11:43:50 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 20 Nov 2019 11:43:48 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAKBhkeg16318646
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Nov 2019 11:43:46 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D19C4C04E;
 Wed, 20 Nov 2019 11:43:46 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C4664C050;
 Wed, 20 Nov 2019 11:43:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.152.224.205])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 20 Nov 2019 11:43:45 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/15] s390x: Protected Virtualization support
Date: Wed, 20 Nov 2019 06:43:19 -0500
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112011-4275-0000-0000-00000383E080
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112011-4276-0000-0000-000038975980
Message-Id: <20191120114334.2287-1-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-20_03:2019-11-15,2019-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=751
 priorityscore=1501 suspectscore=1 spamscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911200107
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Most of the QEMU changes for PV are related to the new IPL type with
subcodes 8 - 10 and the execution of the necessary Ultravisor calls to
IPL secure guests. Note that we can only boot into secure mode from
normal mode, i.e. stfle 161 is not active in secure mode.

The other changes related to data gathering for emulation and
disabling addressing checks in secure mode, as well as CPU resets.

While working on this I sprinkled in some cleanups, as we sometimes
significantly increase line count of some functions and they got
unreadable.

Janosch Frank (15):
  s390x: Cleanup cpu resets
  s390x: Beautify diag308 handling
  s390x: protvirt: Add diag308 subcodes 8 - 10
  Header sync protvirt
  s390x: protvirt: Sync PV state
  s390x: protvirt: Support unpack facility
  s390x: protvirt: Handle diag 308 subcodes 0,1,3,4
  s390x: protvirt: KVM intercept changes
  s390x: protvirt: SCLP interpretation
  s390x: protvirt: Add new VCPU reset functions
  RFC: s390x: Exit on vcpu reset error
  s390x: protvirt: Set guest IPL PSW
  s390x: protvirt: Move diag 308 data over SIDAD
  s390x: protvirt: Disable address checks for PV guest IO emulation
  s390x: protvirt: Handle SIGP store status correctly

 hw/s390x/Makefile.objs              |   1 +
 hw/s390x/ipl.c                      |  81 +++++++++++++++++-
 hw/s390x/ipl.h                      |  35 ++++++++
 hw/s390x/pv.c                       | 123 +++++++++++++++++++++++++++
 hw/s390x/pv.h                       |  27 ++++++
 hw/s390x/s390-virtio-ccw.c          |  79 ++++++++++++++---
 hw/s390x/sclp.c                     |  16 ++++
 include/hw/s390x/sclp.h             |   2 +
 linux-headers/asm-s390/kvm.h        |   4 +-
 linux-headers/linux/kvm.h           |  43 ++++++++++
 target/s390x/cpu.c                  | 127 ++++++++++++++--------------
 target/s390x/cpu.h                  |   1 +
 target/s390x/cpu_features_def.inc.h |   1 +
 target/s390x/diag.c                 | 108 +++++++++++++++++------
 target/s390x/ioinst.c               |  46 ++++++----
 target/s390x/kvm-stub.c             |  10 ++-
 target/s390x/kvm.c                  |  58 +++++++++++--
 target/s390x/kvm_s390x.h            |   4 +-
 target/s390x/sigp.c                 |   7 +-
 19 files changed, 640 insertions(+), 133 deletions(-)
 create mode 100644 hw/s390x/pv.c
 create mode 100644 hw/s390x/pv.h

-- 
2.20.1


