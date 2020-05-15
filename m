Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B83C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 22:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38FDC20643
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 22:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38FDC20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZiid-0002ha-DB
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 18:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jZihV-0000yc-CD; Fri, 15 May 2020 18:21:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20784
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jZihU-0006gu-AN; Fri, 15 May 2020 18:21:05 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04FM3f88077237; Fri, 15 May 2020 18:21:01 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 310t9q3vku-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 May 2020 18:21:01 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04FM7NS9090197;
 Fri, 15 May 2020 18:21:01 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 310t9q3vkm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 May 2020 18:21:01 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04FMKGwM000673;
 Fri, 15 May 2020 22:21:00 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma03dal.us.ibm.com with ESMTP id 3100uc92bx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 May 2020 22:21:00 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04FMKxFI42074370
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 May 2020 22:20:59 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88F0A112063;
 Fri, 15 May 2020 22:20:59 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4DAA3112061;
 Fri, 15 May 2020 22:20:59 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.146.125])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri, 15 May 2020 22:20:59 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v2 0/8] s390: Extended-Length SCCB & DIAGNOSE 0x318
Date: Fri, 15 May 2020 18:20:24 -0400
Message-Id: <20200515222032.18838-1-walling@linux.ibm.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-15_07:2020-05-15,
 2020-05-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 phishscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 cotscore=-2147483648 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005150185
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 18:21:01
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, david@redhat.com,
 cohuck@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, mst@redhat.com,
 svens@linux.ibm.com, pbonzini@redhat.com, mihajlov@linux.ibm.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changelog:

    v2

    • QEMU now handles the instruction call
        - as such, the "enable diag 318" IOCTL has been removed

    • patch #1 now changes the read scp/cpu info functions to
      retrieve the machine state once
        - as such, I have not added any ack's or r-bs since this
          patch differs from the previous version

    • patch #3 introduces a new "get_read_scp_info_data_len"
      function in order clean-up the variable data length assignment
      in patch #7
        - a comment above this function should help clarify what's
          going on to make things a bit easier to read

    • other misc clean ups and fixes
        - s/diag318/diag_318 in order to keep the naming scheme
          consistent with Linux and other diag-related code
        - s/byte_134/fac134 to align naming scheme with Linux

-----------------------------------------------------------------------

This patch series introduces two features for an s390 KVM quest:
    - Extended-Length SCCB (els) for the Read SCP/CPU Info SCLP 
        commands
    - DIAGNOSE 0x318 (diag_318) enabling / migration handling

The diag 318 feature depends on els and KVM support.

The els feature is handled entirely with QEMU, and does not require 
KVM support.

Both features are made available starting with the zEC12-full model.

These patches are introduced together for two main reasons:
    - els allows diag 318 to exist while retaining the original 248 
        VCPU max
    - diag 318 is presented to show how els is useful

Full els support is dependant on the Linux kernel, which must react
to the SCLP response code and set an appropriate-length SCCB. 

A user should take care when tuning the CPU model for a VM.
If a user defines a VM with els support and specifies 248 CPUs, but
the guest Linux kernel cannot react to the SCLP response code, then
the guest will crash immediately upon kernel startup.

Collin L. Walling (8):
  s390/sclp: get machine once during read scp/cpu info
  s390/sclp: check sccb len before filling in data
  s390/sclp: rework sclp boundary and length checks
  s390/sclp: read sccb from mem based on sccb length
  s390/sclp: use cpu offset to locate cpu entries
  s390/sclp: add extended-length sccb support for kvm guest
  s390/kvm: header sync for diag318
  s390: guest support for diagnose 0x318

 hw/s390x/s390-virtio-ccw.c          |  45 +++++++++++
 hw/s390x/sclp.c                     | 117 ++++++++++++++++++++++------
 include/hw/s390x/s390-virtio-ccw.h  |   1 +
 include/hw/s390x/sclp.h             |   4 +
 linux-headers/asm-s390/kvm.h        |   4 +
 target/s390x/cpu.c                  |  23 ++++++
 target/s390x/cpu.h                  |   4 +
 target/s390x/cpu_features.h         |   1 +
 target/s390x/cpu_features_def.inc.h |   4 +
 target/s390x/cpu_models.c           |   1 +
 target/s390x/gen-features.c         |   2 +
 target/s390x/kvm-stub.c             |  10 +++
 target/s390x/kvm.c                  |  44 +++++++++++
 target/s390x/kvm_s390x.h            |   2 +
 14 files changed, 237 insertions(+), 25 deletions(-)

-- 
2.21.3


