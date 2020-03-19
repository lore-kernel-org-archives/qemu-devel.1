Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61ED9C4332E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 13:26:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3559B207FC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 13:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3559B207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEvBh-00042U-BL
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 09:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35213)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jEv5m-0002mO-6I
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 09:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jEv5k-0001w0-Tk
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 09:20:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21256
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jEv5k-0001e7-OP
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 09:20:08 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02JD7Ijn051949
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 09:19:58 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yu98uffe5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 09:19:58 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 19 Mar 2020 13:19:56 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 19 Mar 2020 13:19:54 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02JDJr6E60162252
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Mar 2020 13:19:53 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5767EA405B;
 Thu, 19 Mar 2020 13:19:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1DD55A4060;
 Thu, 19 Mar 2020 13:19:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.146.136])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 19 Mar 2020 13:19:51 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 15/16] docs: system: Add protvirt docs
Date: Thu, 19 Mar 2020 09:19:20 -0400
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200319131921.2367-1-frankja@linux.ibm.com>
References: <20200319131921.2367-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031913-4275-0000-0000-000003AF19A2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031913-4276-0000-0000-000038C4481E
Message-Id: <20200319131921.2367-16-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-19_04:2020-03-19,
 2020-03-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 suspectscore=1 impostorscore=0 mlxscore=0
 lowpriorityscore=1 malwarescore=0 bulkscore=1 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003190058
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

Let's add some documentation for the Protected VM functionality.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 docs/system/s390x/protvirt.rst | 60 ++++++++++++++++++++++++++++++++++
 docs/system/target-s390x.rst   |  5 +++
 2 files changed, 65 insertions(+)
 create mode 100644 docs/system/s390x/protvirt.rst

diff --git a/docs/system/s390x/protvirt.rst b/docs/system/s390x/protvirt.rst
new file mode 100644
index 0000000000000000..712974ad87b9e856
--- /dev/null
+++ b/docs/system/s390x/protvirt.rst
@@ -0,0 +1,60 @@
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
+To run PVMs, a machine with the Protected Virtualization feature, as
+indicated by the Ultravisor Call facility (stfle bit 158), is
+required. The Ultravisor needs to be initialized at boot by setting
+`prot_virt=1` on the host's kernel command line.
+
+Running PVMs requires using the KVM hypervisor.
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
+`unpack`/`S390_FEAT_UNPACK`) needs to be part of the cpu model of
+the VM.
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
+components (zipl stage3). Stage3 does some fixups and then transfers
+control to some program residing in guest memory, which is normally
+the OS kernel. The secure image has another component prepended
+(stage3a) that uses the new diag308 subcodes 8 and 10 to trigger the
+transition into secure mode.
+
+Booting from the image supplied on the QEMU command line requires that
+the file passed via -kernel has the same memory layout as would result
+from the disk boot. This memory layout includes the encrypted
+components (kernel, initrd, cmdline), the stage3a loader and
+metadata. In case this boot method is used, the command line
+options -initrd and -cmdline are ineffective. The preparation of a PVM
+image is done via the `genprotimg` tool from the s390-tools
+collection.
diff --git a/docs/system/target-s390x.rst b/docs/system/target-s390x.rst
index 4c8b7cdd66154d26..7d76ae97b4018ae6 100644
--- a/docs/system/target-s390x.rst
+++ b/docs/system/target-s390x.rst
@@ -24,3 +24,8 @@ or vfio-ap is also available.
 .. toctree::
    s390x/vfio-ap
 
+Architectural features
+======================
+
+.. toctree::
+   s390x/protvirt
-- 
2.25.1


