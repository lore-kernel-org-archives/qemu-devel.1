Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E36CA9EB7
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:14:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 254D02089C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 254D02089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMXVp-0006en-Vz
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 09:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iMXUA-0005Nf-Nz
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:12:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iMXU8-0003oS-GO
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:12:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50228
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iMXU7-0003nN-GE
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:12:32 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9LD8YsQ087721
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 09:12:29 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vsc733a98-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 09:12:28 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <clg@kaod.org>;
 Mon, 21 Oct 2019 14:12:27 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 21 Oct 2019 14:12:24 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x9LDCNmt59637962
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Oct 2019 13:12:23 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 044515205A;
 Mon, 21 Oct 2019 13:12:23 +0000 (GMT)
Received: from smtp.tls.ibm.com (unknown [9.101.4.1])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E564152054;
 Mon, 21 Oct 2019 13:12:22 +0000 (GMT)
Received: from yukon.kaod.org.ibmuc.com (sig-9-145-86-58.uk.ibm.com
 [9.145.86.58])
 by smtp.tls.ibm.com (Postfix) with ESMTP id 412AA22016B;
 Mon, 21 Oct 2019 15:12:22 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 0/5] ppc/pnv: Add PNOR support
Date: Mon, 21 Oct 2019 15:12:10 +0200
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
x-cbid: 19102113-0028-0000-0000-000003ACEB4C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102113-0029-0000-0000-0000246F1276
Message-Id: <20191021131215.3693-1-clg@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-21_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=969 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910210128
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x9LD8YsQ087721
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
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org,
 Joel Stanley <joel@jms.id.au>, "Marty E . Plummer" <hanetzer@startmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On a POWERPC PowerNV system, the host firmware is stored in a PNOR
flash chip which contents is mapped on the LPC bus. This model adds a
simple dummy device to map the contents of a block device in the host
address space and activates HIOMAP support on the QEMU PowerNV machine
to let the host negotiate with the BMC the access to the mapping.

The command options to activate these models in QEMU:

  -device ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D10 =
\
  -drive file=3D./witherspoon.pnor,format=3Draw,if=3Dmtd

The last two patches add the logic to load in the machine memory the
PAYLOAD partition (skiboot) from an OpenPOWER firmware file. These
should be considered as RFCs as the firmware file could have a
different format. Something to discuss.


Thanks,

C.=20

C=C3=A9dric Le Goater (5):
  ppc/pnv: Add a PNOR model
  ipmi: Add support to customize OEM functions
  ppc/pnv: Add HIOMAP commands
  libxz: Add XZ Embedded library for PPC
  ppc/pnv: Read the PNOR partition table

 include/hw/ipmi/ipmi.h    |   36 ++
 include/hw/ppc/ffs.h      |  150 +++++
 include/hw/ppc/pnv.h      |    4 +
 include/hw/ppc/pnv_pnor.h |   36 ++
 libxz/xz.h                |  304 ++++++++++
 libxz/xz_config.h         |  124 ++++
 libxz/xz_lzma2.h          |  204 +++++++
 libxz/xz_private.h        |  156 +++++
 libxz/xz_stream.h         |   62 ++
 hw/ipmi/ipmi_bmc_sim.c    |   41 +-
 hw/ppc/pnv.c              |   48 +-
 hw/ppc/pnv_bmc.c          |  101 ++++
 hw/ppc/pnv_lpc.c          |   13 +
 hw/ppc/pnv_pnor.c         |  291 +++++++++
 libxz/xz_crc32.c          |   59 ++
 libxz/xz_dec_lzma2.c      | 1171 +++++++++++++++++++++++++++++++++++++
 libxz/xz_dec_stream.c     |  847 +++++++++++++++++++++++++++
 hw/ppc/Makefile.objs      |    4 +-
 libxz/Makefile.objs       |    1 +
 target/ppc/Makefile.objs  |    1 +
 20 files changed, 3606 insertions(+), 47 deletions(-)
 create mode 100644 include/hw/ppc/ffs.h
 create mode 100644 include/hw/ppc/pnv_pnor.h
 create mode 100644 libxz/xz.h
 create mode 100644 libxz/xz_config.h
 create mode 100644 libxz/xz_lzma2.h
 create mode 100644 libxz/xz_private.h
 create mode 100644 libxz/xz_stream.h
 create mode 100644 hw/ppc/pnv_pnor.c
 create mode 100644 libxz/xz_crc32.c
 create mode 100644 libxz/xz_dec_lzma2.c
 create mode 100644 libxz/xz_dec_stream.c
 create mode 100644 libxz/Makefile.objs

--=20
2.21.0


