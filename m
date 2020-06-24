Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F81C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 20:29:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1DCB2080C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 20:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1DCB2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joC1P-00069S-5V
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 16:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1joBvx-0006Kr-BF; Wed, 24 Jun 2020 16:23:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26136)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1joBvs-00031a-Vq; Wed, 24 Jun 2020 16:23:49 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05OK3FD8005946; Wed, 24 Jun 2020 16:23:43 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31uwyxeay9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2020 16:23:42 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05OK4rf9011032;
 Wed, 24 Jun 2020 16:23:42 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31uwyxeaxq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2020 16:23:42 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05OKKRWm017861;
 Wed, 24 Jun 2020 20:23:41 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma02wdc.us.ibm.com with ESMTP id 31uus3phaf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2020 20:23:41 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05OKNetD54329828
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jun 2020 20:23:40 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BEF1FAE05C;
 Wed, 24 Jun 2020 20:23:40 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A591AE063;
 Wed, 24 Jun 2020 20:23:40 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.198.108])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 24 Jun 2020 20:23:40 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v4 0/8] s390: Extended-Length SCCB & DIAGNOSE 0x318
Date: Wed, 24 Jun 2020 16:23:04 -0400
Message-Id: <20200624202312.28349-1-walling@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-24_15:2020-06-24,
 2020-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0
 cotscore=-2147483648 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 suspectscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240129
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 15:31:11
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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

    v4
    
    • added r-b's and ack's (thanks, everyone!)

    • renamed boundary and length function

    • updated header sync to reflect a change discussed in the respective
        KVM patches

    • s/data_len/offset_cpu

    • added /* fallthrough */ comment in boundary check

    v3

    • Device IOCTLs removed
        - diag 318 info is now communicated via sync_regs

    • Reset code removed
        - this is now handled in KVM
        - diag318_info is stored within the CPU reset portion of the
            S390CPUState

    • Various cleanups for ELS preliminary patches

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

 hw/s390x/sclp.c                     | 115 ++++++++++++++++++++++------
 include/hw/s390x/sclp.h             |   4 +
 linux-headers/asm-s390/kvm.h        |   7 +-
 linux-headers/linux/kvm.h           |   1 +
 target/s390x/cpu.h                  |   2 +
 target/s390x/cpu_features.h         |   1 +
 target/s390x/cpu_features_def.inc.h |   4 +
 target/s390x/cpu_models.c           |   1 +
 target/s390x/gen-features.c         |   2 +
 target/s390x/kvm.c                  |  39 ++++++++++
 target/s390x/machine.c              |  17 ++++
 11 files changed, 166 insertions(+), 27 deletions(-)

-- 
2.26.2


