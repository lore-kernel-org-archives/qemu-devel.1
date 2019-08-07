Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFB3C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:17:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 296002199C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296002199C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvGCR-00006d-Ap
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 03:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59864)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bala24@linux.ibm.com>) id 1hvGAf-0006yN-Di
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1hvGAe-0001YO-1V
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:15:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15826
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1hvGAd-0001Xr-Pl
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:15:39 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x777ENfM019735
 for <qemu-devel@nongnu.org>; Wed, 7 Aug 2019 03:15:38 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2u7pyapax9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 03:15:37 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Wed, 7 Aug 2019 08:15:33 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 7 Aug 2019 08:15:30 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x777FT1U8126684
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Aug 2019 07:15:29 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED903A4057;
 Wed,  7 Aug 2019 07:15:28 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7820BA4065;
 Wed,  7 Aug 2019 07:15:27 +0000 (GMT)
Received: from dhcp-9-109-247-185.in.ibm.com (unknown [9.109.247.185])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  7 Aug 2019 07:15:27 +0000 (GMT)
From: Balamuruhan S <bala24@linux.ibm.com>
To: qemu-devel@nongnu.org
Date: Wed,  7 Aug 2019 12:44:39 +0530
X-Mailer: git-send-email 2.14.5
X-TM-AS-GCONF: 00
x-cbid: 19080707-0020-0000-0000-0000035BD0CE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080707-0021-0000-0000-000021AFF356
Message-Id: <20190807071445.4109-1-bala24@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-07_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908070078
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [RFC PATCH 0/6] Enhancing Qemu MMIO emulation with
 scripting interface
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
Cc: maddy@linux.vnet.ibm.com, Balamuruhan S <bala24@linux.ibm.com>,
 anju@linux.vnet.ibm.com, clg@kaod.org, hari@linux.vnet.ibm.com,
 pbonzini@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi All,

This is a proposal to extend mmio callbacks in Qemu with scripting interface
that is prototyped with python in this implementation. It gives ability to
feed runtime data through callbacks without recompiling Qemu in generic way.
This patchset adds library that provides APIs for Qemu to talk with python
scripts placed in path -module-path and how existing xscom can be extended
with python interface infrastructure.

We have also added an hacky emulation for memory region (OCC common area and HOMER)
which is shared between core and un-core engine (ideally this should be via
sram device) to showcase the effectiveness of having the scripting interface
(uncore engine taken for discussion here is powerpc specificed called OCC).
Having scripting interface helps to emulate/test different uncore-core
interactions including uncore engine failure or hang. It also helps in feeding
randomized data at byte level access. This patchset is primarily to extend mmio
callbacks with scripting interface and to demonstrate effectiveness it.

Some changes are required in PowerPC skiboot tree to test these changes since
the memory region is disabled currently for Qemu emulated PowerNV host,
https://github.com/balamuruhans/skiboot/commit/a655514d2a730e0372a2faee277d1cf01f71a524

Qemu commandline used to test,

```
# qemu/ppc64-softmmu/qemu-system-ppc64 \
-M powernv \
-cpu POWER9 \
-m 16G \
-kernel vmlinux \
-initrd debug_homer.cpio \
-nographic -bios skiboot/skiboot.lid \
-module-path /home/bala/homer/python-modules/,xscom_module=homer,xscom_read=xscom_read,xscom_write=xscom_write,homer_module=homer,homer=homer_read,occ_module=homer,occ=occ_read
```

Script used to feed data can be something like,
https://github.com/balamuruhans/python-modules/blob/master/script.py

It could uncover couple of firmware bugs,
https://github.com/balamuruhans/skiboot/commit/fd3d93d92ec66a7494346d6d24ced7b48264c9a0
https://github.com/balamuruhans/skiboot/commit/165b3829a93bc177c18133945a8cca3a2d701173

Code changes:
Patch 1: adds library to provide python interface APIs
Patch 2: extend existing xscom to adopt this python interface
Patch 3 - 6: emulate uncore/core shared memory region with mmio callbacks and
add support with this infrastructure.

I request for comments, suggestions, ideas on getting a scripting interface
like python added in qemu.

Balamuruhan S (6):
  utils/python_api: add scripting interface for Qemu with python lib
  hw/ppc/pnv_xscom: extend xscom to use python interface
  hw/ppc/pnv_homer: add homer/occ common area emulation for PowerNV
  hw/ppc/pnv: initialize and realize homer/occ common area
  hw/ppc/pnv_xscom: retrieve homer/occ base address from PBA BARs
  hw/ppc/pnv_homer: add python interface support for homer/occ common
    area

 configure                   |  10 +++
 hw/ppc/Makefile.objs        |   2 +-
 hw/ppc/pnv.c                |  49 ++++++++++-
 hw/ppc/pnv_homer.c          | 205 ++++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/pnv_xscom.c          |  59 +++++++++++--
 include/hw/ppc/pnv.h        |  15 ++++
 include/hw/ppc/pnv_homer.h  |  41 +++++++++
 include/sysemu/python_api.h |  30 +++++++
 include/sysemu/sysemu.h     |   8 ++
 qemu-options.hx             |  14 +++
 util/Makefile.objs          |   1 +
 util/python_api.c           | 100 +++++++++++++++++++++
 vl.c                        |  66 ++++++++++++++
 13 files changed, 588 insertions(+), 12 deletions(-)
 create mode 100644 hw/ppc/pnv_homer.c
 create mode 100644 include/hw/ppc/pnv_homer.h
 create mode 100644 include/sysemu/python_api.h
 create mode 100644 util/python_api.c

-- 
2.14.5


