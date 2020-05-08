Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA95C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 23:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9A212173E
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 23:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A212173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXC8L-0005KG-SS
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 19:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jXC6r-0003NS-Ra; Fri, 08 May 2020 19:08:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24930
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jXC6q-0005nn-5x; Fri, 08 May 2020 19:08:49 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 048N2iZq015499; Fri, 8 May 2020 19:08:45 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 30vtwd347q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2020 19:08:45 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 048N5XMM023029;
 Fri, 8 May 2020 19:08:45 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0b-001b2d01.pphosted.com with ESMTP id 30vtwd347f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2020 19:08:45 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 048N4GCS027771;
 Fri, 8 May 2020 23:08:44 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma01dal.us.ibm.com with ESMTP id 30s0g7k02n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2020 23:08:44 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 048N8hAM52691274
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 May 2020 23:08:43 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 42268AC05B;
 Fri,  8 May 2020 23:08:43 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0DCEAAC05E;
 Fri,  8 May 2020 23:08:43 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.189.36])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri,  8 May 2020 23:08:42 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v1 0/8] s390: Extended-Length SCCB & DIAGNOSE 0x318
Date: Fri,  8 May 2020 19:08:15 -0400
Message-Id: <20200508230823.22956-1-walling@linux.ibm.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-08_19:2020-05-08,
 2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0 spamscore=0
 mlxlogscore=723 suspectscore=0 phishscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2005080190
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 19:08:45
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, mst@redhat.com,
 svens@linux.ibm.com, pbonzini@redhat.com, mihajlov@linux.ibm.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series introduces two features for an s390 KVM quest:
    - Extended-Length SCCB (els) for the Read SCP/CPU Info SCLP 
        commands
    - DIAGNOSE 0x318 (diag318) enabling / migration handling

The diag318 feature depends on els and KVM support.

The els feature is handled entirely with QEMU, and does not require 
KVM support.

These patches are introduced together for two main reasons:
    - els allows diag318 to exist while retaining the original 248 
        VCPU max
    - diag318 is presented to show how els is useful

Full els support is dependant on the Linux kernel, which must react
to the SCLP response code and set an appropriate-length SCCB. 

A user should take care when tuning the CPU model for a VM.
If a user defines a VM with els support and specifies 248 CPUs, but
the guest Linux kernel cannot react to the SCLP response code, then
the guest will crash immediately upon kernel startup.

Since it has been some time since the last review and a few things
have changed, I've removed all ack's and set this submission to v1.

Collin L. Walling (8):
  s390/sclp: remove SCLPDevice param from prepare_cpu_entries
  s390/sclp: check sccb len before filling in data
  s390/sclp: rework sclp boundary and length checks
  s390/sclp: read sccb from mem based on sccb length
  s390/sclp: use cpu offset to locate cpu entries
  s390/sclp: add extended-length sccb support for kvm guest
  s390/kvm: header sync for diag318
  s390: diagnose 318 info reset and migration support

 hw/s390x/s390-virtio-ccw.c          |  45 +++++++++++++
 hw/s390x/sclp.c                     | 101 +++++++++++++++++++++-------
 include/hw/s390x/s390-virtio-ccw.h  |   1 +
 include/hw/s390x/sclp.h             |   4 ++
 linux-headers/asm-s390/kvm.h        |   5 ++
 smp.max_cpus                        |   0
 target/s390x/cpu.c                  |  19 ++++++
 target/s390x/cpu.h                  |   4 ++
 target/s390x/cpu_features.h         |   1 +
 target/s390x/cpu_features_def.inc.h |   4 ++
 target/s390x/cpu_models.c           |   1 +
 target/s390x/gen-features.c         |   2 +
 target/s390x/kvm-stub.c             |  10 +++
 target/s390x/kvm.c                  |  52 ++++++++++++++
 target/s390x/kvm_s390x.h            |   3 +
 15 files changed, 229 insertions(+), 23 deletions(-)
 create mode 100644 smp.max_cpus

-- 
2.21.1


