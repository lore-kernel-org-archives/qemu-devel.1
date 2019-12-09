Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080EFC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 17:57:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2A38207FF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 17:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A38207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieNHL-0004Fb-BY
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 12:57:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ieNFk-0002X7-Jo
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 12:55:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ieNFj-0004Jl-A5
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 12:55:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63146)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ieNFi-0004J6-TQ
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 12:55:23 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xB9HmM10123877
 for <qemu-devel@nongnu.org>; Mon, 9 Dec 2019 12:55:20 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wrtfqk339-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 12:55:20 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Mon, 9 Dec 2019 17:55:17 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 9 Dec 2019 17:55:14 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xB9HtDbX52756666
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Dec 2019 17:55:13 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D728A4051;
 Mon,  9 Dec 2019 17:55:13 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B2E3A4040;
 Mon,  9 Dec 2019 17:55:13 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.42.200])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  9 Dec 2019 17:55:13 +0000 (GMT)
Subject: [for-5.0 PATCH v2 0/3] cpu: Clarify overloading of reset QOM methods
From: Greg Kurz <groug@kaod.org>
To: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 09 Dec 2019 18:55:12 +0100
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-TM-AS-GCONF: 00
x-cbid: 19120917-0012-0000-0000-000003733B61
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120917-0013-0000-0000-000021AF0B0F
Message-Id: <157591411283.46967.15944326590669093952.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-09_04:2019-12-09,2019-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0
 spamscore=0 mlxscore=0 mlxlogscore=745 suspectscore=0 clxscore=1034
 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912090144
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id xB9HmM10123877
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Each cpu subclass overloads the reset method of its parent class with
its own. But since it needs to call the parent method as well, it keeps
a parent_reset pointer to do so. This causes the same not very explicit
boiler plate to be duplicated all around the place:

    pcc->parent_reset =3D cc->reset;
    cc->reset =3D ppc_cpu_reset;

A similar concern was addressed some time back by Philippe Mathieu-Daud=C3=
=A9
in qdev, with the addition of device_class_set_parent_reset() and friends=
:

https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D46795cf2e2f6
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3Dbf853881690d

Follow the same approach with cpus.

Changes in v2:
- added Reviewed-by and Acked-by tags
- rebased on top of https://github.com/cohuck/qemu.git s390-next
  SHA1 dd6252f035a2

--
Greg

---

Greg Kurz (3):
      cpu: Introduce CPUReset callback typedef
      cpu: Introduce cpu_class_set_parent_reset()
      cpu: Use cpu_class_set_parent_reset()


 hw/core/cpu.c                   |    8 ++++++++
 include/hw/core/cpu.h           |    8 +++++++-
 target/alpha/cpu-qom.h          |    2 +-
 target/arm/cpu-qom.h            |    2 +-
 target/arm/cpu.c                |    3 +--
 target/cris/cpu-qom.h           |    2 +-
 target/cris/cpu.c               |    3 +--
 target/hppa/cpu-qom.h           |    2 +-
 target/i386/cpu-qom.h           |    2 +-
 target/i386/cpu.c               |    3 +--
 target/lm32/cpu-qom.h           |    2 +-
 target/lm32/cpu.c               |    3 +--
 target/m68k/cpu-qom.h           |    2 +-
 target/m68k/cpu.c               |    3 +--
 target/microblaze/cpu-qom.h     |    2 +-
 target/microblaze/cpu.c         |    3 +--
 target/mips/cpu-qom.h           |    2 +-
 target/mips/cpu.c               |    3 +--
 target/moxie/cpu.c              |    3 +--
 target/moxie/cpu.h              |    2 +-
 target/nios2/cpu.c              |    3 +--
 target/nios2/cpu.h              |    2 +-
 target/openrisc/cpu.c           |    3 +--
 target/openrisc/cpu.h           |    2 +-
 target/ppc/cpu-qom.h            |    2 +-
 target/ppc/translate_init.inc.c |    3 +--
 target/riscv/cpu.c              |    3 +--
 target/riscv/cpu.h              |    2 +-
 target/s390x/cpu-qom.h          |    2 +-
 target/s390x/cpu.c              |    3 +--
 target/sh4/cpu-qom.h            |    2 +-
 target/sh4/cpu.c                |    3 +--
 target/sparc/cpu-qom.h          |    2 +-
 target/sparc/cpu.c              |    3 +--
 target/tilegx/cpu.c             |    3 +--
 target/tilegx/cpu.h             |    2 +-
 target/tricore/cpu-qom.h        |    2 +-
 target/tricore/cpu.c            |    3 +--
 target/xtensa/cpu-qom.h         |    2 +-
 target/xtensa/cpu.c             |    3 +--
 40 files changed, 53 insertions(+), 57 deletions(-)


