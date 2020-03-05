Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1810EC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 19:41:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB7B82073B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 19:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7B82073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9wNO-0003st-26
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 14:41:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1j9wKj-0007Ou-SV
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:39:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1j9wKi-0005Fh-EH
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:39:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14304
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1j9wKi-0005Dt-9U
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:39:00 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 025JLZxi008656; Thu, 5 Mar 2020 14:38:58 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yjrtsx3s0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2020 14:38:58 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 025JM3aA011171;
 Thu, 5 Mar 2020 14:38:58 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yjrtsx3rp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2020 14:38:58 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 025JaHEM020278;
 Thu, 5 Mar 2020 19:38:57 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma03wdc.us.ibm.com with ESMTP id 2yffk7dquq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2020 19:38:57 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 025Jcvu035848694
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Mar 2020 19:38:57 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F4A1124053;
 Thu,  5 Mar 2020 19:38:57 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01E0B124060;
 Thu,  5 Mar 2020 19:38:57 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu,  5 Mar 2020 19:38:56 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 07/10] docs/specs/tpm: Document TPM_TIS sysbus device for ARM
Date: Thu,  5 Mar 2020 14:38:52 -0500
Message-Id: <20200305193855.278878-8-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305193855.278878-1-stefanb@linux.vnet.ibm.com>
References: <20200305193855.278878-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-05_06:2020-03-05,
 2020-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=1 adultscore=0
 mlxscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 malwarescore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003050114
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
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.ibm.com>,
 eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

Update the documentation with recent changes related to the
sysbus TPM_TIS device addition and add the command line
to be used with arm VIRT.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Message-id: 20200305165149.618-8-eric.auger@redhat.com
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 docs/specs/tpm.rst | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
index 2bdf637f55..da9eb39ca9 100644
--- a/docs/specs/tpm.rst
+++ b/docs/specs/tpm.rst
@@ -18,9 +18,15 @@ The TIS interface makes a memory mapped IO region in the area
 0xfed40000-0xfed44fff available to the guest operating system.
 
 QEMU files related to TPM TIS interface:
- - ``hw/tpm/tpm_tis.c``
+ - ``hw/tpm/tpm_tis_common.c``
+ - ``hw/tpm/tpm_tis_isa.c``
+ - ``hw/tpm/tpm_tis_sysbus.c``
  - ``hw/tpm/tpm_tis.h``
 
+Both an ISA device and a sysbus device are available. The former is
+used with pc/q35 machine while the latter can be instantiated in the
+ARM virt machine.
+
 CRB interface
 -------------
 
@@ -325,6 +331,23 @@ In case a pSeries machine is emulated, use the following command line:
     -device virtio-blk-pci,scsi=off,bus=pci.0,addr=0x3,drive=drive-virtio-disk0,id=virtio-disk0 \
     -drive file=test.img,format=raw,if=none,id=drive-virtio-disk0
 
+In case an ARM virt machine is emulated, use the following command line:
+
+.. code-block:: console
+
+  qemu-system-aarch64 -machine virt,gic-version=3,accel=kvm \
+    -cpu host -m 4G \
+    -nographic -no-acpi \
+    -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
+    -tpmdev emulator,id=tpm0,chardev=chrtpm \
+    -device tpm-tis-device,tpmdev=tpm0 \
+    -device virtio-blk-pci,drive=drv0 \
+    -drive format=qcow2,file=hda.qcow2,if=none,id=drv0 \
+    -drive if=pflash,format=raw,file=flash0.img,readonly \
+    -drive if=pflash,format=raw,file=flash1.img
+
+  On ARM, ACPI boot with TPM is not yet supported.
+
 In case SeaBIOS is used as firmware, it should show the TPM menu item
 after entering the menu with 'ESC'.
 
-- 
2.24.1


