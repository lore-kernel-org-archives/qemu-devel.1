Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C37DC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:02:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A32206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A32206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igrtg-0003wV-Eu
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 10:02:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1igrsI-0002i7-Fg
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:01:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1igrsH-0006Gm-5N
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:01:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48162)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1igrsG-0006Et-Uu
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:01:29 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBGEudwR013804
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 10:01:21 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wvue75xr1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 10:01:19 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Mon, 16 Dec 2019 15:01:11 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 16 Dec 2019 15:01:08 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBGF17GF50725058
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2019 15:01:07 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5750A52071;
 Mon, 16 Dec 2019 15:01:07 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.39.6])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id F0BC152054;
 Mon, 16 Dec 2019 15:01:06 +0000 (GMT)
Subject: [PATCH v3 0/2] cpu: Clarify overloading of reset QOM methods
From: Greg Kurz <groug@kaod.org>
To: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 16 Dec 2019 16:01:06 +0100
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-TM-AS-GCONF: 00
x-cbid: 19121615-0020-0000-0000-00000398C333
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121615-0021-0000-0000-000021EFDA95
Message-Id: <157650846660.354886.16810288202617432561.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-16_05:2019-12-16,2019-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 mlxlogscore=717 spamscore=0 priorityscore=1501 adultscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1034 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912160132
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id xBGEudwR013804
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

Changes in v3:
- drop 'cpu: Introduce CPUReset callback typedef' patch which isn't neede=
d
  and makes the code less clear. This changes the declaration of the help=
er
  in 'cpu: Introduce cpu_class_set_parent_reset()', but it is minor so I
  keep the Reviewed-by and Acked-by tags.

Changes in v2:
- added Reviewed-by and Acked-by tags
- rebased on top of https://github.com/cohuck/qemu.git s390-next
  SHA1 dd6252f035a2

--
Greg

---

Greg Kurz (2):
      cpu: Introduce cpu_class_set_parent_reset()
      cpu: Use cpu_class_set_parent_reset()


 hw/core/cpu.c                   |    8 ++++++++
 include/hw/core/cpu.h           |    4 ++++
 target/arm/cpu.c                |    3 +--
 target/cris/cpu.c               |    3 +--
 target/i386/cpu.c               |    3 +--
 target/lm32/cpu.c               |    3 +--
 target/m68k/cpu.c               |    3 +--
 target/microblaze/cpu.c         |    3 +--
 target/mips/cpu.c               |    3 +--
 target/moxie/cpu.c              |    3 +--
 target/nios2/cpu.c              |    3 +--
 target/openrisc/cpu.c           |    3 +--
 target/ppc/translate_init.inc.c |    3 +--
 target/riscv/cpu.c              |    3 +--
 target/s390x/cpu.c              |    3 +--
 target/sh4/cpu.c                |    3 +--
 target/sparc/cpu.c              |    3 +--
 target/tilegx/cpu.c             |    3 +--
 target/tricore/cpu.c            |    3 +--
 target/xtensa/cpu.c             |    3 +--
 20 files changed, 30 insertions(+), 36 deletions(-)


