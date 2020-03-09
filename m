Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE252C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 11:28:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DF7920828
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 11:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF7920828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBGaF-0003Uo-Jr
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 07:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48065)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jBGUg-0000q9-Th
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jBGUf-0004vf-NA
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:22:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21870
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jBGUf-0004my-IR
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:22:45 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 029BLUJd164285
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2020 07:22:35 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ym648dn0s-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 07:22:34 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Mon, 9 Mar 2020 11:22:33 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 9 Mar 2020 11:22:30 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 029BMTY050200710
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2020 11:22:29 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 716FF4C052;
 Mon,  9 Mar 2020 11:22:29 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B189F4C04A;
 Mon,  9 Mar 2020 11:22:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.152.224.87])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2020 11:22:28 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 14/15] docs: Add protvirt docs
Date: Mon,  9 Mar 2020 07:22:05 -0400
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309112206.20261-1-frankja@linux.ibm.com>
References: <20200309112206.20261-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20030911-0020-0000-0000-000003B1DFD5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030911-0021-0000-0000-0000220A26B2
Message-Id: <20200309112206.20261-15-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-09_02:2020-03-08,
 2020-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 priorityscore=1501 mlxscore=0 suspectscore=1 bulkscore=0 spamscore=0
 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003090080
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

Lets add some documentation for the Protected VM functionality.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 docs/system/index.rst    |  1 +
 docs/system/protvirt.rst | 56 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 docs/system/protvirt.rst

diff --git a/docs/system/index.rst b/docs/system/index.rst
index 1a4b2c82ac..d2dc63b973 100644
--- a/docs/system/index.rst
+++ b/docs/system/index.rst
@@ -16,3 +16,4 @@ Contents:
 
    qemu-block-drivers
    vfio-ap
+   protvirt
diff --git a/docs/system/protvirt.rst b/docs/system/protvirt.rst
new file mode 100644
index 0000000000..6c8cf0f791
--- /dev/null
+++ b/docs/system/protvirt.rst
@@ -0,0 +1,56 @@
+Protected Virtualization on s390x
+=================================
+
+The memory and most of the registers of Protected Virtual Machines
+(PVMs) are encrypted or inaccessible to the hypervisor, effectively
+prohibiting VM introspection when the VM is running. At rest, PVMs are
+encrypted and can only be decrypted by the firmware, represented by an
+entity called Ultravisor, of specific IBM Z machines.
+
+
+Prerequisites
+-------------
+
+To run PVMs a machine with the Protected Virtualization feature
+which is indicated by the Ultravisor Call facility (stfle bit
+158) is required. The Ultravisor needs to be initialized at boot by
+setting `prot_virt=1` on the kernel command line.
+
+If those requirements are met, the capability `KVM_CAP_S390_PROTECTED`
+will indicate that KVM can support PVMs on that LPAR.
+
+
+QEMU Settings
+-------------
+
+To indicate to the VM that it can transition into protected mode, the
+`Unpack facility` (stfle bit 161 represented by the feature
+`S390_FEAT_UNPACK`) needs to be part of the cpu model of the VM.
+
+All I/O devices need to use the IOMMU.
+Passthrough (vfio) devices are currently not supported.
+
+Host huge page backings are not supported. However guests can use huge
+pages as indicated by its facilities.
+
+
+Boot Process
+------------
+
+A secure guest image can either be loaded from disk or supplied on the
+QEMU command line. Booting from disk is done by the unmodified
+s390-ccw BIOS. I.e., the bootmap is interpreted, multiple components
+are read into memory and control is transferred to one of the
+components (zipl stage3). Stag3 does some fixups and then transfers
+control to some program residing in guest memory, which is normally
+the OS kernel. The secure image has another component prepended
+(stage3a) that uses the new diag308 subcodes 8 and 10 to trigger the
+transition into secure mode.
+
+Booting from the image supplied via the QEMU command line requires
+that the file passed via -kernel has the same memory layout as would
+result from the disk boot. This memory layout includes the encrypted
+components (kernel, initrd, cmdline), the stage3a loader and
+metadata. In case this boot method is used, the command line
+options -initrd and -cmdline are ineffective. The preparation of a PVM
+image is done by genprotimg of the s390-tools package.
-- 
2.20.1


