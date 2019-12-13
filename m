Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6302C3F68F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:26:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4716224125
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4716224125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifjg8-0001zG-Qh
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 07:04:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57047)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ifjbg-0006yK-0x
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:59:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ifjbe-0003XB-JY
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:59:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31826
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ifjbe-0003V4-C3
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:59:38 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBDBvgoe121422
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 06:59:35 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wu4t86r7w-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 06:59:34 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 13 Dec 2019 11:59:33 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 13 Dec 2019 11:59:30 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xBDBwlwB49283516
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2019 11:58:47 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 34FF54C044;
 Fri, 13 Dec 2019 11:59:29 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 040694C040;
 Fri, 13 Dec 2019 11:59:29 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.185.241])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 13 Dec 2019 11:59:28 +0000 (GMT)
Subject: [PATCH 00/13] ppc/pnv: Get rid of chip_type attributes
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 13 Dec 2019 12:59:28 +0100
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19121311-0008-0000-0000-00000340727E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121311-0009-0000-0000-00004A607864
Message-Id: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-13_03:2019-12-13,2019-12-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1034 suspectscore=0
 mlxscore=0 mlxlogscore=285 malwarescore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912130097
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
Cc: qemu-ppc@nongnu.org, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The PnvChipClass type has a chip_type attribute which identifies various
POWER CPU chip types that can be used in a powernv machine.

typedef enum PnvChipType {
    PNV_CHIP_POWER8E,     /* AKA Murano (default) */
    PNV_CHIP_POWER8,      /* AKA Venice */
    PNV_CHIP_POWER8NVL,   /* AKA Naples */
    PNV_CHIP_POWER9,      /* AKA Nimbus */
    PNV_CHIP_POWER10,     /* AKA TBD */
} PnvChipType;

This attribute is used in many places where we want a different behaviour
depending on the CPU type, either directly like:

    switch (PNV_CHIP_GET_CLASS(chip)->chip_type) {
    case PNV_CHIP_POWER8E:
    case PNV_CHIP_POWER8:
    case PNV_CHIP_POWER8NVL:
        return ((addr >> 4) & ~0xfull) | ((addr >> 3) & 0xf);
    case PNV_CHIP_POWER9:
    case PNV_CHIP_POWER10:
        return addr >> 3;
    default:
        g_assert_not_reached();
    }

or through various helpers that rely on it:

        /* Each core has an XSCOM MMIO region */
        if (pnv_chip_is_power10(chip)) {
            xscom_core_base = PNV10_XSCOM_EC_BASE(core_hwid);
        } else if (pnv_chip_is_power9(chip)) {
            xscom_core_base = PNV9_XSCOM_EC_BASE(core_hwid);
        } else {
            xscom_core_base = PNV_XSCOM_EX_BASE(core_hwid);
        }

The chip_type is also duplicated in the PnvPsiClass type.

It looks a bit unfortunate to implement manually something that falls into
the scope of QOM. Especially since we don't seem to need a finer grain than
the CPU familly, ie. POWER8, POWER9, POWER10, ..., and we already have
specialized versions of PnvChipClass and PnvPsiClass for these.

This series basically QOM-ifies all the places where we check on the chip
type, and gets rid of the chip_type attributes and the is_powerXX() helpers.

Patch 1 was recently posted to the list but it isn't available in David's
ppc-for-5.0 tree yet, so I include it in this series for convenience.

--
Greg

---

Greg Kurz (13):
      ppc: Drop useless extern annotation for functions
      ppc/pnv: Introduce PnvPsiClass::compat
      ppc/pnv: Drop PnvPsiClass::chip_type
      ppc/pnv: Introduce PnvMachineClass and PnvMachineClass::compat
      ppc/pnv: Introduce PnvMachineClass::dt_power_mgt()
      ppc/pnv: Drop pnv_is_power9() and pnv_is_power10() helpers
      ppc/pnv: Introduce PnvChipClass::intc_print_info() method
      ppc/pnv: Introduce PnvChipClass::xscom_core_base() method
      ppc/pnv: Pass XSCOM base address and address size to pnv_dt_xscom()
      ppc/pnv: Pass content of the "compatible" property to pnv_dt_xscom()
      ppc/pnv: Drop pnv_chip_is_power9() and pnv_chip_is_power10() helpers
      ppc/pnv: Introduce PnvChipClass::xscom_pcba() method
      ppc/pnv: Drop PnvChipClass::type


 hw/ppc/pnv.c               |  150 +++++++++++++++++++++++++++++++++-----------
 hw/ppc/pnv_psi.c           |   28 +++-----
 hw/ppc/pnv_xscom.c         |   48 ++------------
 include/hw/ppc/pnv.h       |   53 ++++++----------
 include/hw/ppc/pnv_psi.h   |    3 +
 include/hw/ppc/pnv_xscom.h |   24 ++++---
 include/hw/ppc/spapr_vio.h |    6 +-
 7 files changed, 169 insertions(+), 143 deletions(-)


