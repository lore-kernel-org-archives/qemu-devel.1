Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CD4C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:15:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D002D206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D002D206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwaL-0006TZ-AY
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:15:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37152)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1ihwSU-0001em-6k
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:07:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1ihwSS-0006EX-NG
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:07:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8762
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1ihwSS-00069N-Ea; Thu, 19 Dec 2019 09:07:16 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBJE3DsS028662; Thu, 19 Dec 2019 09:07:12 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2x04mafqn8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Dec 2019 09:07:10 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBJE3DQI028688;
 Thu, 19 Dec 2019 09:07:03 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2x04mafqaa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Dec 2019 09:07:03 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBJE43eD025868;
 Thu, 19 Dec 2019 14:06:55 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma05wdc.us.ibm.com with ESMTP id 2wvqc6prpu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Dec 2019 14:06:55 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBJE6sYP41353684
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Dec 2019 14:06:55 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E3351AC060;
 Thu, 19 Dec 2019 14:06:54 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CBD68AC059;
 Thu, 19 Dec 2019 14:06:54 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 19 Dec 2019 14:06:54 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH v7 0/6] Add vTPM emulator support for ppc64 platform
Date: Thu, 19 Dec 2019 09:05:59 -0500
Message-Id: <20191219140605.3243321-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_01:2019-12-17,2019-12-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912190119
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following series of patches adds vTPM emulator support for the
ppc64 platform (pSeries). 

It can be tested as follows with swtpm/libtpms:

mkdir /tmp/mytpm1
swtpm socket --tpmstate dir=/tmp/mytpm1 \
  --ctrl type=unixio,path=/tmp/mytpm1/swtpm-sock \
  --log level=20

If TPM 2 is desired, add --tpm2 as parameter to the above.

In another terminal start QEMU:

sudo ./ppc64-softmmu/qemu-system-ppc64 -display sdl \
	-machine pseries,accel=kvm \
	-m 1024 -bios slof.bin -boot menu=on \
	-nodefaults -device VGA -device pci-ohci -device usb-kbd \
	-chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
	-tpmdev emulator,id=tpm0,chardev=chrtpm \
	-device tpm-spapr,tpmdev=tpm0 \
	-device spapr-vscsi,id=scsi0,reg=0x00002000 \
	-device virtio-blk-pci,scsi=off,bus=pci.0,addr=0x3,drive=drive-virtio-disk0,id=virtio-disk0 \
	-drive file=test.img,format=raw,if=none,id=drive-virtio-disk0

Links:
 - libtpms: https://github.com/stefanberger/libtpms/wiki
 - swtpm: https://github.com/stefanberger/swtpm/wiki

Changes:
 v6->v7:
  - Implemented get_dt_compatible() and using it
  - Moved tpm_this_show_buffer to tpm_util.c

 v5->v6:
  - adjusted names of structures and simplified
  - only transmitting min. necessary bytes to pass to VM after resume
  - addressed other issues pointed out by D. Gibson

 v4->v5:
  - use runstate_check(RUN_STATE_FINISH_MIGRATE) to check whether devices
    are suspending; ditch 3 patches in this series that tried to do similar

 v3->v4:
  - addressed comments to v3
  - reworked suspend/resume support that requires extensions to backends

 v2->v3:
  - patch 1: a TPM 2 is identified by IBM,vtpm20 in the compatible node
  - patch 1: convert to tracing to display Tx and Rx buffers
  - added documentation patch
  - added patch to enable TPM device as part of pSeries

 v1->v2:
  - followed Cedric Le Goater's suggestions to patch 1
  - send appropriate CRQ error responses if DMA read or write fails
  - renamed tpm_spapr_got_payload to tpm_spapr_process_cmd and
    pass endianess-adjusted data pointer from CRQ to it

Regards,
    Stefan



Stefan Berger (6):
  tpm: Move tpm_tis_show_buffer to tpm_util.c
  spapr: Implement get_dt_compatible() callback
  tpm_spapr: Support TPM for ppc64 using CRQ based interface
  tpm_spapr: Support suspend and resume
  hw/ppc/Kconfig: Enable TPM_SPAPR as part of PSERIES config
  docs: tpm: Add example command line for ppc64 and tpm-spapr

 docs/specs/tpm.txt         |  20 +-
 hw/ppc/Kconfig             |   1 +
 hw/ppc/spapr_vio.c         |  11 +-
 hw/tpm/Kconfig             |   6 +
 hw/tpm/Makefile.objs       |   1 +
 hw/tpm/tpm_spapr.c         | 443 +++++++++++++++++++++++++++++++++++++
 hw/tpm/tpm_tis.c           |  32 +--
 hw/tpm/tpm_util.c          |  25 +++
 hw/tpm/tpm_util.h          |   3 +
 hw/tpm/trace-events        |  16 +-
 include/hw/ppc/spapr_vio.h |   1 +
 include/sysemu/tpm.h       |   3 +
 qapi/tpm.json              |   6 +-
 13 files changed, 533 insertions(+), 35 deletions(-)
 create mode 100644 hw/tpm/tpm_spapr.c

-- 
2.21.0


