Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F112C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:13:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0286B20833
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0286B20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iadHJ-0002xw-VR
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 05:13:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iactK-0002oY-IO
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:48:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iactG-0003li-7m
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:48:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32604)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iactF-0003XD-Uj
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:48:42 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAT9mbcP095402
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 04:48:39 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wje2jh0md-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 04:48:38 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Fri, 29 Nov 2019 09:48:23 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 29 Nov 2019 09:48:20 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAT9mJxX50921574
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Nov 2019 09:48:19 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62C9BA4040;
 Fri, 29 Nov 2019 09:48:19 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CD2DA404D;
 Fri, 29 Nov 2019 09:48:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.188.128])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 29 Nov 2019 09:48:17 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/13] s390x: Protected Virtualization support
Date: Fri, 29 Nov 2019 04:47:56 -0500
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112909-0028-0000-0000-000003C18C15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112909-0029-0000-0000-000024849A0F
Message-Id: <20191129094809.26684-1-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-29_02:2019-11-29,2019-11-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911290086
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

https://github.com/frankjaa/qemu/tree/protvirt

v2:
	* Split out cleanups
	* Internal PV state tracking
	* Review feedback


Janosch Frank (13):
  s390x: protvirt: Add diag308 subcodes 8 - 10
  Header sync protvirt
  s390x: protvirt: Support unpack facility
  s390x: protvirt: Handle diag 308 subcodes 0,1,3,4
  s390x: protvirt: Add pv state to cpu env
  s390x: protvirt: KVM intercept changes
  s390x: protvirt: SCLP interpretation
  s390x: protvirt: Add new VCPU reset functions
  s390x: Exit on vcpu reset error
  s390x: protvirt: Set guest IPL PSW
  s390x: protvirt: Move diag 308 data over SIDAD
  s390x: protvirt: Disable address checks for PV guest IO emulation
  s390x: protvirt: Handle SIGP store status correctly

 hw/s390x/Makefile.objs              |   1 +
 hw/s390x/ipl.c                      |  81 +++++++++++++++++-
 hw/s390x/ipl.h                      |  35 ++++++++
 hw/s390x/pv.c                       | 123 ++++++++++++++++++++++++++++
 hw/s390x/pv.h                       |  27 ++++++
 hw/s390x/s390-virtio-ccw.c          |  59 ++++++++++++-
 hw/s390x/sclp.c                     |  17 ++++
 include/hw/s390x/sclp.h             |   2 +
 linux-headers/linux/kvm.h           |  43 ++++++++++
 target/s390x/cpu.c                  |  23 +++++-
 target/s390x/cpu.h                  |   1 +
 target/s390x/cpu_features_def.inc.h |   1 +
 target/s390x/diag.c                 |  56 +++++++++++--
 target/s390x/helper.c               |   4 +
 target/s390x/ioinst.c               |  26 ++++--
 target/s390x/kvm-stub.c             |  10 ++-
 target/s390x/kvm.c                  |  51 ++++++++++--
 target/s390x/kvm_s390x.h            |   4 +-
 target/s390x/sigp.c                 |   1 +
 19 files changed, 536 insertions(+), 29 deletions(-)
 create mode 100644 hw/s390x/pv.c
 create mode 100644 hw/s390x/pv.h

-- 
2.20.1


