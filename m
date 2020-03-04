Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED81C3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 11:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9389F2146E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 11:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9389F2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9SW6-00079l-Qo
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 06:48:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j9SRE-0006oq-Ex
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:43:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j9SRC-0007qq-JM
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:43:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10642
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j9SRB-0007hd-Cj
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:43:42 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 024BdJ8w185139
 for <qemu-devel@nongnu.org>; Wed, 4 Mar 2020 06:43:30 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yhpwmwb5g-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 06:43:30 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Wed, 4 Mar 2020 11:43:28 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 4 Mar 2020 11:43:25 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 024BgQTW50856298
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Mar 2020 11:42:26 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA56442042;
 Wed,  4 Mar 2020 11:43:24 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 33D9C42045;
 Wed,  4 Mar 2020 11:43:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.152.224.55])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  4 Mar 2020 11:43:24 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 17/18] docs: Add protvirt docs
Date: Wed,  4 Mar 2020 06:42:30 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304114231.23493-1-frankja@linux.ibm.com>
References: <20200304114231.23493-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20030411-0008-0000-0000-000003593BC2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030411-0009-0000-0000-00004A7A6E74
Message-Id: <20200304114231.23493-18-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-04_01:2020-03-04,
 2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=1
 mlxlogscore=999 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040090
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
 docs/system/protvirt.rst | 57 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)
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
index 0000000000..a1902cc47c
--- /dev/null
+++ b/docs/system/protvirt.rst
@@ -0,0 +1,57 @@
+Protected Virtualization on s390x
+=================================
+
+The memory and most of the register contents of Protected Virtual
+Machines (PVMs) are inaccessible to the hypervisor, effectively
+prohibiting VM introspection when the VM is running. At rest, PVMs are
+encrypted and can only be decrypted by the firmware of specific IBM Z
+machines.
+
+
+Prerequisites
+-------------
+
+To run PVMs, you need to have a machine with the Protected
+Virtualization feature, which is indicated by the Ultravisor Call
+facility (stfle bit 158). This is a KVM only feature, therefore you
+need a KVM which is able to support PVMs and activate the Ultravisor
+initialization by setting `prot_virt=1` on the kernel command line.
+
+If those requirements are met, the capability `KVM_CAP_S390_PROTECTED`
+will indicate that KVM can support PVMs on that LPAR.
+
+
+QEMU Settings
+-------------
+
+To indicate to the VM that it can move into protected mode, the
+`Unpack facility` (stfle bit 161) needs to be part of the cpu model of
+the VM.
+
+All I/O devices need to use the IOMMU.
+Passthrough (vfio) devices are currently not supported.
+
+Host huge page backings are not supported. The guest however can use
+huge pages as indicated by its facilities.
+
+
+Boot Process
+------------
+
+A secure guest image can be both booted from disk and using the QEMU
+command line. Booting from disk is done by the unmodified s390-ccw
+BIOS. I.e., the bootmap is interpreted and a number of components is
+read into memory and control is transferred to one of the components
+(zipl stage3), which does some fixups and then transfers control to
+some program residing in guest memory, which is normally the OS
+kernel. The secure image has another component prepended (stage3a)
+which uses the new diag308 subcodes 8 and 10 to trigger the transition
+into secure mode.
+
+Booting from the command line requires that the file passed
+via -kernel has the same memory layout as would result from the disk
+boot. This memory layout includes the encrypted components (kernel,
+initrd, cmdline), the stage3a loader and metadata. In case this boot
+method is used, the command line options -initrd and -cmdline are
+ineffective.  The preparation of secure guest image is done by a
+program (name tbd) of the s390-tools package.
-- 
2.20.1


