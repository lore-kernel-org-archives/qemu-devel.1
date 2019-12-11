Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7733C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:26:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 797732073D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797732073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if4oJ-00026E-Fa
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 11:25:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1if4kK-0006FI-T5
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 11:21:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1if4kJ-0000i7-KJ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 11:21:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57496)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1if4kJ-0000fo-9G; Wed, 11 Dec 2019 11:21:51 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBBGCZoi043542; Wed, 11 Dec 2019 11:21:39 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wtf8j5g99-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Dec 2019 11:21:39 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBBGCgwV044109;
 Wed, 11 Dec 2019 11:21:39 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wtf8j5g8m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Dec 2019 11:21:39 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBBGLS7N020598;
 Wed, 11 Dec 2019 16:21:37 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma03wdc.us.ibm.com with ESMTP id 2wr3q6p7fw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Dec 2019 16:21:37 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBBGLa2m57999684
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Dec 2019 16:21:36 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C2DDF6E054;
 Wed, 11 Dec 2019 16:21:36 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 344966E04E;
 Wed, 11 Dec 2019 16:21:36 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 11 Dec 2019 16:21:36 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org
Subject: [PACTH v3 5/5] docs: tpm: Add example command line for ppc64 and
 tpm-spapr
Date: Wed, 11 Dec 2019 11:20:50 -0500
Message-Id: <20191211162050.970199-6-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191211162050.970199-1-stefanb@linux.vnet.ibm.com>
References: <20191211162050.970199-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_04:2019-12-11,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=1 bulkscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110137
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
---
 docs/specs/tpm.txt | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

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


