Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F69C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 20:29:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6E2120637
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 20:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E2120637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifV5X-0004wG-Vk
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 15:29:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1ifV1T-0008J3-EP
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 15:25:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1ifV1R-0001qo-U5
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 15:25:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17460)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1ifV1R-0001pE-LT; Thu, 12 Dec 2019 15:25:17 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBCKOOVK040745; Thu, 12 Dec 2019 15:25:14 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wuswn4vhs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 15:25:14 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBCKOTls041314;
 Thu, 12 Dec 2019 15:25:13 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wuswn4vhf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 15:25:13 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBCKOfKZ028634;
 Thu, 12 Dec 2019 20:25:13 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma02dal.us.ibm.com with ESMTP id 2wr3q7d5yq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 20:25:13 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBCKPCBx19202434
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Dec 2019 20:25:12 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DDBEDAC065;
 Thu, 12 Dec 2019 20:25:11 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CFB04AC05E;
 Thu, 12 Dec 2019 20:25:11 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 12 Dec 2019 20:25:11 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH v5 5/5] docs: tpm: Add example command line for ppc64 and
 tpm-spapr
Date: Thu, 12 Dec 2019 15:24:30 -0500
Message-Id: <20191212202430.1079725-6-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191212202430.1079725-1-stefanb@linux.vnet.ibm.com>
References: <20191212202430.1079725-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_06:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=1 mlxlogscore=999 bulkscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120157
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
Cc: marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.ibm.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add an example to the TPM docs for how to add a TPM SPAPR
device model to a QEMU VM emulating a pSeries machine.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
index 9c8cca042d..9c3e67d8a7 100644
--- a/docs/specs/tpm.txt
+++ b/docs/specs/tpm.txt
@@ -34,6 +34,12 @@ The CRB interface makes a memory mapped IO region in the area 0xfed40000 -
 QEMU files related to TPM CRB interface:
  - hw/tpm/tpm_crb.c
 
+
+pSeries (ppc64) machines offer a tpm-spapr device model.
+
+QEMU files related to the SPAPR interface:
+ - hw/tpm/tpm_spapr.c
+
 = fw_cfg interface =
 
 The bios/firmware may read the "etc/tpm/config" fw_cfg entry for
@@ -281,7 +287,7 @@ swtpm socket --tpmstate dir=/tmp/mytpm1 \
   --log level=20
 
 Command line to start QEMU with the TPM emulator device communicating with
-the swtpm:
+the swtpm (x86):
 
 qemu-system-x86_64 -display sdl -accel kvm \
   -m 1024 -boot d -bios bios-256k.bin -boot menu=on \
@@ -289,6 +295,18 @@ qemu-system-x86_64 -display sdl -accel kvm \
   -tpmdev emulator,id=tpm0,chardev=chrtpm \
   -device tpm-tis,tpmdev=tpm0 test.img
 
+In case a pSeries machine is emulated, use the following command line:
+
+qemu-system-ppc64 -display sdl -machine pseries,accel=kvm \
+  -m 1024 -bios slof.bin -boot menu=on \
+  -nodefaults -device VGA -device pci-ohci -device usb-kbd \
+  -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
+  -tpmdev emulator,id=tpm0,chardev=chrtpm \
+  -device tpm-spapr,tpmdev=tpm0 \
+  -device spapr-vscsi,id=scsi0,reg=0x00002000 \
+  -device virtio-blk-pci,scsi=off,bus=pci.0,addr=0x3,drive=drive-virtio-disk0,id=virtio-disk0 \
+  -drive file=test.img,format=raw,if=none,id=drive-virtio-disk0
+
 
 In case SeaBIOS is used as firmware, it should show the TPM menu item
 after entering the menu with 'ESC'.
-- 
2.21.0


