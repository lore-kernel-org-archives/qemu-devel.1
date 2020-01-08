Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92540C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 16:12:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E23206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 16:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E23206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipDwX-0002eu-60
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 11:12:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.ibm.com>) id 1ipDua-0000XP-JW
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 11:10:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.ibm.com>) id 1ipDuZ-0000pg-1S
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 11:10:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54022
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
 id 1ipDuY-0000o5-S9; Wed, 08 Jan 2020 11:10:22 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 008G80NI097036; Wed, 8 Jan 2020 11:10:17 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2xdeb01gg7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2020 11:10:17 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 008G80vj097058;
 Wed, 8 Jan 2020 11:10:16 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2xdeb01gfs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2020 11:10:16 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 008G6M55019402;
 Wed, 8 Jan 2020 16:10:15 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma02wdc.us.ibm.com with ESMTP id 2xajb75r18-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2020 16:10:15 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 008GAFeX59638142
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Jan 2020 16:10:15 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0EDBB6A057;
 Wed,  8 Jan 2020 16:10:15 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E0626A04F;
 Wed,  8 Jan 2020 16:10:14 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed,  8 Jan 2020 16:10:14 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH v8 0/6] Add vTPM emulator support for ppc64 platform
Date: Wed,  8 Jan 2020 11:10:06 -0500
Message-Id: <20200108161012.1821385-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-08_04:2020-01-08,
 2020-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001080132
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id 008G80NI097036
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
Cc: marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.ibm.com>,
 qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


The following series of patches adds vTPM emulator support for the
ppc64 platform (pSeries).=20

It can be tested as follows with swtpm/libtpms:

mkdir /tmp/mytpm1
swtpm socket --tpmstate dir=3D/tmp/mytpm1 \
  --ctrl type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock \
  --log level=3D20

If TPM 2 is desired, add --tpm2 as parameter to the above.

In another terminal start QEMU:

sudo ./ppc64-softmmu/qemu-system-ppc64 -display sdl \
	-machine pseries,accel=3Dkvm \
	-m 1024 -bios slof.bin -boot menu=3Don \
	-nodefaults -device VGA -device pci-ohci -device usb-kbd \
	-chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
	-tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
	-device tpm-spapr,tpmdev=3Dtpm0 \
	-device spapr-vscsi,id=3Dscsi0,reg=3D0x00002000 \
	-device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x3,drive=3Ddrive-v=
irtio-disk0,id=3Dvirtio-disk0 \
	-drive file=3Dtest.img,format=3Draw,if=3Dnone,id=3Ddrive-virtio-disk0

Links:
 - libtpms: https://github.com/stefanberger/libtpms/wiki
 - swtpm: https://github.com/stefanberger/swtpm/wiki

Changes:
 v7->v8:
  - Folded documentation patch into 3rd patch
  - Added Marc-Andr=C3=A9's patch to end of series

 v6->v7:
  - Implemented get_dt_compatible() and using it
  - Moved tpm_this_show_buffer to tpm_util.c

 v5->v6:
  - adjusted names of structures and simplified
  - only transmitting min. necessary bytes to pass to VM after resume
  - addressed other issues pointed out by D. Gibson

 v4->v5:
  - use runstate_check(RUN_STATE_FINISH_MIGRATE) to check whether devices
    are suspending; ditch 3 patches in this series that tried to do simil=
ar

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


Marc-Andr=C3=A9 Lureau (1):
  docs/specs/tpm: reST-ify TPM documentation

Stefan Berger (5):
  tpm: Move tpm_tis_show_buffer to tpm_util.c
  spapr: Implement get_dt_compatible() callback
  tpm_spapr: Support TPM for ppc64 using CRQ based interface
  tpm_spapr: Support suspend and resume
  hw/ppc/Kconfig: Enable TPM_SPAPR as part of PSERIES config

 docs/specs/index.rst       |   1 +
 docs/specs/tpm.rst         | 503 +++++++++++++++++++++++++++++++++++++
 docs/specs/tpm.txt         | 427 -------------------------------
 hw/ppc/Kconfig             |   1 +
 hw/ppc/spapr_vio.c         |  11 +-
 hw/tpm/Kconfig             |   6 +
 hw/tpm/Makefile.objs       |   1 +
 hw/tpm/tpm_spapr.c         | 443 ++++++++++++++++++++++++++++++++
 hw/tpm/tpm_tis.c           |  32 +--
 hw/tpm/tpm_util.c          |  25 ++
 hw/tpm/tpm_util.h          |   3 +
 hw/tpm/trace-events        |  16 +-
 include/hw/ppc/spapr_vio.h |   1 +
 include/sysemu/tpm.h       |   3 +
 qapi/tpm.json              |   6 +-
 15 files changed, 1018 insertions(+), 461 deletions(-)
 create mode 100644 docs/specs/tpm.rst
 delete mode 100644 docs/specs/tpm.txt
 create mode 100644 hw/tpm/tpm_spapr.c

--=20
2.24.1


