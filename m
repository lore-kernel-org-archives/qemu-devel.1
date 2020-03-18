Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CD9C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:32:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56F512076C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F512076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEZkS-0003xU-Fn
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 10:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58183)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jEZj0-0002cd-5f
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jEZiy-0001Dx-JR
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:31:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59848
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jEZiy-0001Cq-Cc
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:31:12 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02IE79KB136086
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 10:31:11 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yukx5kja5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 10:31:11 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Wed, 18 Mar 2020 14:31:09 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 18 Mar 2020 14:31:06 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02IEV57s58458352
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Mar 2020 14:31:05 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C5FE942042;
 Wed, 18 Mar 2020 14:31:05 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A63D54203F;
 Wed, 18 Mar 2020 14:31:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.78.199])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 18 Mar 2020 14:31:04 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 00/16] s390x: Protected Virtualization support
Date: Wed, 18 Mar 2020 10:30:31 -0400
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031814-0020-0000-0000-000003B689FC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031814-0021-0000-0000-0000220EF3E6
Message-Id: <20200318143047.2335-1-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-18_06:2020-03-18,
 2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=1 mlxlogscore=999 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003180067
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Most of the QEMU changes for PV are related to the new IPL type with
subcodes 8 - 10 and the execution of the necessary Ultravisor calls to
IPL secure guests. Note that we can only boot into secure mode from
normal mode, i.e. stfle 161 is not active in secure mode.

The other changes related to data gathering for emulation and
disabling addressing checks in secure mode, as well as CPU resets.

v10:
	* Moved documentation into subfolder
	* Added huge page fencing
	* Cleared up IO questions that were remaining
	* Added exits/abbort/assert for conditions where we can't recover

v9:
	* Moved pv.h into include/hw/s390x/
	* Replaced cmd strings with macro
	* Moved s390_is_pv() to pv.h
	* Added new copyright dates and authors
v8:
	* Removed the iplb_valid changes as they are picked
	* Checkpatch fixes
	* Review fixes
	* Replaced env/ms->pv with s390_is_pv()
v7:
	* Merged the diag 308 subcode patches and the unpack
	* Moved the SIDA memops into the sync patch
	* Bailout for the none machien and fencing of CONFIG_USER_ONLY
	* Changes due to review

v6:
	* diag308 rc numbers were changed by architecture
	* IPL pv block received one more reserved field by architecture
	* Officially added the bios patch to the series
	* Dropped picked constant rename patch

v5:
	* Moved docs into docs/system
	* Some more enable/disable changes
	* Moved enablement/disablement of pv in separate functions
	* Some review fixes

v4:
	* Sync with KVM changes
	* Review changes

V3:
	* Use dedicated functions to access SIDA
	* Smaller cleanups and segfault fixes
	* Error reporting for Ultravisor calls
	* Inject of RC of diag308 subcode 10 fails

V2:
	* Split out cleanups
	* Internal PV state tracking
	* Review feedback


Christian Borntraeger (1):
  s390x: Add unpack facility feature to GA1

Janosch Frank (15):
  s390x: Move diagnose 308 subcodes and rcs into ipl.h
  Sync pv
  s390x: protvirt: Support unpack facility
  s390x: protvirt: Add migration blocker
  s390x: protvirt: Inhibit balloon when switching to protected mode
  s390x: protvirt: KVM intercept changes
  s390x: Add SIDA memory ops
  s390x: protvirt: Move STSI data over SIDAD
  s390x: protvirt: SCLP interpretation
  s390x: protvirt: Set guest IPL PSW
  s390x: protvirt: Move diag 308 data over SIDA
  s390x: protvirt: Disable address checks for PV guest IO emulation
  s390x: protvirt: Move IO control structures over SIDA
  s390x: protvirt: Handle SIGP store status correctly
  docs: system: Add protvirt docs

 docs/system/s390x/protvirt.rst      |  59 +++++++++++
 docs/system/target-s390x.rst        |   5 +
 hw/s390x/Makefile.objs              |   1 +
 hw/s390x/ipl.c                      |  59 ++++++++++-
 hw/s390x/ipl.h                      | 102 ++++++++++++++++++-
 hw/s390x/pv.c                       |  98 ++++++++++++++++++
 hw/s390x/s390-virtio-ccw.c          | 148 +++++++++++++++++++++++++++-
 hw/s390x/sclp.c                     |  65 +++++++++---
 include/hw/s390x/pv.h               |  55 +++++++++++
 include/hw/s390x/s390-virtio-ccw.h  |   1 +
 include/hw/s390x/sclp.h             |   2 +
 linux-headers/linux/kvm.h           |  45 ++++++++-
 target/s390x/cpu.c                  |  28 ++++--
 target/s390x/cpu.h                  |   7 +-
 target/s390x/cpu_features_def.inc.h |   1 +
 target/s390x/diag.c                 |  77 +++++++++++----
 target/s390x/gen-features.c         |   1 +
 target/s390x/helper.c               |   6 ++
 target/s390x/ioinst.c               |  96 +++++++++++++-----
 target/s390x/kvm-stub.c             |   5 +
 target/s390x/kvm.c                  |  79 +++++++++++++--
 target/s390x/kvm_s390x.h            |   3 +
 target/s390x/mmu_helper.c           |  14 +++
 23 files changed, 877 insertions(+), 80 deletions(-)
 create mode 100644 docs/system/s390x/protvirt.rst
 create mode 100644 hw/s390x/pv.c
 create mode 100644 include/hw/s390x/pv.h

-- 
2.25.1


