Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AD6C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:18:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0696F2168B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0696F2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2cjL-000889-5e
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 10:18:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j2ciI-0006cQ-Uz
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:17:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j2ciH-0005wm-GJ
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:17:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4976
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j2ciH-0005i0-Bz
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:17:05 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01EFFsB4026434
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:16:58 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2y5ww9875u-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:16:57 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Fri, 14 Feb 2020 15:16:55 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 14 Feb 2020 15:16:53 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01EFGqFS59113676
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2020 15:16:52 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 14865A4040;
 Fri, 14 Feb 2020 15:16:52 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 986CAA4053;
 Fri, 14 Feb 2020 15:16:50 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.191.187])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 14 Feb 2020 15:16:50 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/17] s390x: Protected Virtualization support
Date: Fri, 14 Feb 2020 10:16:19 -0500
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20021415-0028-0000-0000-000003DA8A42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021415-0029-0000-0000-0000249F0538
Message-Id: <20200214151636.8764-1-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-14_04:2020-02-12,
 2020-02-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 adultscore=0 suspectscore=1 impostorscore=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 spamscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002140121
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
Cc: mihajlov@linux.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
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

V3:
	* Use dedicated functions to access SIDA
	* Smaller cleanups and segfault fixes
	* Error reporting for Ultravisor calls
	* Inject of RC of diag308 subcode 10 fails

V2:
	* Split out cleanups
	* Internal PV state tracking
	* Review feedback

Janosch Frank (17):
  Header sync
  s390x: Add missing vcpu reset functions
  Sync pv
  s390x: protvirt: Add diag308 subcodes 8 - 10
  s390x: protvirt: Support unpack facility
  s390x: protvirt: Add migration blocker
  s390x: protvirt: Handle diag 308 subcodes 0,1,3,4
  s390x: protvirt: KVM intercept changes
  s390: protvirt: Move STSI data over SIDAD
  s390x: Add SIDA memory ops
  s390x: protvirt: SCLP interpretation
  s390x: protvirt: Set guest IPL PSW
  s390x: protvirt: Move diag 308 data over SIDAD
  s390x: protvirt: Disable address checks for PV guest IO emulation
  s390x: protvirt: Move IO control structures over SIDA
  s390x: protvirt: Handle SIGP store status correctly
  s390x: For now add unpack feature to GA1

 hw/s390x/Makefile.objs              |   1 +
 hw/s390x/ipl.c                      |  80 +++++++++++++-
 hw/s390x/ipl.h                      |  33 ++++++
 hw/s390x/pv.c                       | 160 ++++++++++++++++++++++++++++
 hw/s390x/pv.h                       |  40 +++++++
 hw/s390x/s390-virtio-ccw.c          | 136 ++++++++++++++++++++++-
 hw/s390x/sclp.c                     |  17 +++
 include/hw/s390x/s390-virtio-ccw.h  |   1 +
 include/hw/s390x/sclp.h             |   2 +
 linux-headers/linux/kvm.h           |  48 ++++++++-
 target/s390x/cpu.c                  |  41 +++++--
 target/s390x/cpu.h                  |   8 +-
 target/s390x/cpu_features_def.inc.h |   1 +
 target/s390x/diag.c                 |  63 +++++++++--
 target/s390x/gen-features.c         |   1 +
 target/s390x/helper.c               |   4 +
 target/s390x/ioinst.c               | 113 ++++++++++++++------
 target/s390x/kvm-stub.c             |  10 +-
 target/s390x/kvm.c                  |  89 ++++++++++++++--
 target/s390x/kvm_s390x.h            |   6 +-
 target/s390x/mmu_helper.c           |   9 ++
 target/s390x/sigp.c                 |   1 +
 22 files changed, 789 insertions(+), 75 deletions(-)
 create mode 100644 hw/s390x/pv.c
 create mode 100644 hw/s390x/pv.h

-- 
2.20.1


