Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4CFC48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 15:24:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 751202080C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 15:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751202080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33054 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfnJT-0001T9-Lu
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 11:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57647)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <walling@linux.ibm.com>) id 1hfnDD-00046L-EV
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:18:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <walling@linux.ibm.com>) id 1hfnDA-0007Fl-VK
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:18:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43598
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <walling@linux.ibm.com>)
 id 1hfnD9-00078K-1d
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:18:19 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5PF3R8N025384
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 11:18:13 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tbnn9hp3w-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 11:18:13 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
 Tue, 25 Jun 2019 16:18:12 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
 by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 25 Jun 2019 16:18:09 +0100
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5PFI8MJ49938898
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Jun 2019 15:18:08 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 035BE124054;
 Tue, 25 Jun 2019 15:18:08 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE5E912405A;
 Tue, 25 Jun 2019 15:18:07 +0000 (GMT)
Received: from collin-T470p.pok.ibm.com (unknown [9.63.14.221])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 25 Jun 2019 15:18:07 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 rth@twiddle.net, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, mst@redhat.com, pbonzini@redhat.com
Date: Tue, 25 Jun 2019 11:17:07 -0400
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 19062515-0064-0000-0000-000003F3864D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011328; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01223108; UDB=6.00643639; IPR=6.01004281; 
 MB=3.00027462; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-25 15:18:11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062515-0065-0000-0000-00003E071D9D
Message-Id: <1561475829-19202-1-git-send-email-walling@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-25_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250116
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH v5 0/2] Guest Support for DIAGNOSE 0x318
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changelog:

    v5
        - split off header updates in kvm_s390x.h to a separate patch
        - implemented CPU model feature for this insn made available with
            zEC12-full and later models
        - s/cpc/diag318_info in order to make the relevant data more clear
        - reduced S390_MAX_CPUS from 248 to 247

The DIAGNOSE 0x318 instruction is a privileged instruction that is executed by the
linux kernel once and only once during setup. This requires interception by KVM to 
handle the instruction call safely. The instruction assists with determining the 
environment the VM is running in -- this is better described in the KVM patches.

The analogous KVM patches still under review can be found here:
https://marc.info/?l=linux-s390&m=156147521528818&w=2

Guest support for the diag 318 instruction is accomplished by implementing a device 
class, a cpu model feature, and adjusting the Read Info struct. The Read Info struct
adjustment coincidentally reduces the maximum number of VCPUs we can have by one.

A device class is used for this instruction in order to streamline the migration and 
reset of the DIAG 318 related data.

A CPU model feature is added for this instruction, appropriately named diag318.

The instruction is determined by a Read Info byte 134 bit 0. This is a new byte that
expands into the space of the Read Info SCCB that is also used to contain CPU entry
data. Due to this expansion, we lose space for one CPU entry and we must reduce the
maximum possible CPUs from 248 to 247. Hopefully this drawback does not affect many 
VMs.

Collin Walling (2):
  s390/kvm: header sync for diag318
  s390: diagnose 318 info reset and migration support

 hw/s390x/Makefile.objs          |  1 +
 hw/s390x/diag318.c              | 80 +++++++++++++++++++++++++++++++++++++++++
 hw/s390x/diag318.h              | 38 ++++++++++++++++++++
 hw/s390x/s390-virtio-ccw.c      | 17 +++++++++
 hw/s390x/sclp.c                 |  3 ++
 include/hw/s390x/sclp.h         |  2 ++
 linux-headers/asm-s390/kvm.h    |  4 +++
 target/s390x/cpu.h              |  8 ++++-
 target/s390x/cpu_features.c     |  3 ++
 target/s390x/cpu_features.h     |  1 +
 target/s390x/cpu_features_def.h |  3 ++
 target/s390x/gen-features.c     |  1 +
 target/s390x/kvm-stub.c         | 10 ++++++
 target/s390x/kvm.c              | 29 +++++++++++++++
 target/s390x/kvm_s390x.h        |  2 ++
 15 files changed, 201 insertions(+), 1 deletion(-)
 create mode 100644 hw/s390x/diag318.c
 create mode 100644 hw/s390x/diag318.h

-- 
2.7.4


