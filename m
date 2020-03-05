Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A0BC3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 19:40:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A4712073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 19:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4712073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9wLi-0000HX-4F
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 14:40:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1j9wKj-0007Or-La
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:39:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1j9wKi-0005FU-D1
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:39:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61294)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1j9wKi-0005E3-55
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:39:00 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 025JMYQ9052963; Thu, 5 Mar 2020 14:38:58 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yhsvbh4ub-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2020 14:38:58 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 025JMvC2053761;
 Thu, 5 Mar 2020 14:38:57 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yhsvbh4u1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2020 14:38:57 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 025JZGdO027093;
 Thu, 5 Mar 2020 19:38:56 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma04wdc.us.ibm.com with ESMTP id 2yffk6wrtv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2020 19:38:56 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 025Jcu3h54198692
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Mar 2020 19:38:56 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5708C124054;
 Thu,  5 Mar 2020 19:38:56 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F9D5124052;
 Thu,  5 Mar 2020 19:38:56 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu,  5 Mar 2020 19:38:56 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/10] Merge TPM 2020/03/04
Date: Thu,  5 Mar 2020 14:38:45 -0500
Message-Id: <20200305193855.278878-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-05_06:2020-03-05,
 2020-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=999 clxscore=1015 suspectscore=1 impostorscore=0 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003050114
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series of patches adds support for TPM on ARM.
This PR is based on v5 of Eric's series.

Regards,
    Stefan

The following changes since commit af4378c39e54705d9b585089de80aae9526ac7e7:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2020-03-05' into staging (2020-03-05 15:18:19 +0000)

are available in the Git repository at:

  git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2020-03-04-2

for you to fetch changes up to fe985ed6837ac6169ab9673547115df2897bcf6d:

  test: tpm-tis: Add Sysbus TPM-TIS device test (2020-03-05 12:18:47 -0500)

----------------------------------------------------------------

Eric Auger (10):
  tpm: rename TPM_TIS into TPM_TIS_ISA
  tpm: Use TPMState as a common struct
  tpm: Separate tpm_tis common functions from isa code
  tpm: Separate TPM_TIS and TPM_TIS_ISA configs
  tpm: Add the SysBus TPM TIS device
  hw/arm/virt: vTPM support
  docs/specs/tpm: Document TPM_TIS sysbus device for ARM
  test: tpm: pass optional machine options to swtpm test functions
  test: tpm-tis: Get prepared to share tests between ISA and sysbus
    devices
  test: tpm-tis: Add Sysbus TPM-TIS device test

 default-configs/i386-softmmu.mak        |   2 +-
 docs/specs/tpm.rst                      |  25 +-
 hw/arm/Kconfig                          |   1 +
 hw/arm/sysbus-fdt.c                     |  33 ++
 hw/arm/virt.c                           |   7 +
 hw/i386/Kconfig                         |   2 +-
 hw/i386/acpi-build.c                    |   6 +-
 hw/tpm/Kconfig                          |  12 +-
 hw/tpm/Makefile.objs                    |   4 +-
 hw/tpm/tpm_tis.h                        |  91 +++++
 hw/tpm/{tpm_tis.c => tpm_tis_common.c}  | 181 +---------
 hw/tpm/tpm_tis_isa.c                    | 170 +++++++++
 hw/tpm/tpm_tis_sysbus.c                 | 159 +++++++++
 include/sysemu/tpm.h                    |   7 +-
 tests/qtest/Makefile.include            |  11 +-
 tests/qtest/tpm-crb-swtpm-test.c        |   9 +-
 tests/qtest/tpm-crb-test.c              |   3 +
 tests/qtest/tpm-tests.c                 |  10 +-
 tests/qtest/tpm-tests.h                 |   5 +-
 tests/qtest/tpm-tis-device-swtpm-test.c |  76 ++++
 tests/qtest/tpm-tis-device-test.c       |  87 +++++
 tests/qtest/tpm-tis-swtpm-test.c        |   8 +-
 tests/qtest/tpm-tis-test.c              | 414 +---------------------
 tests/qtest/tpm-tis-util.c              | 451 ++++++++++++++++++++++++
 tests/qtest/tpm-tis-util.h              |  23 ++
 tests/qtest/tpm-util.c                  |  11 +-
 tests/qtest/tpm-util.h                  |   8 +-
 27 files changed, 1207 insertions(+), 609 deletions(-)
 create mode 100644 hw/tpm/tpm_tis.h
 rename hw/tpm/{tpm_tis.c => tpm_tis_common.c} (85%)
 create mode 100644 hw/tpm/tpm_tis_isa.c
 create mode 100644 hw/tpm/tpm_tis_sysbus.c
 create mode 100644 tests/qtest/tpm-tis-device-swtpm-test.c
 create mode 100644 tests/qtest/tpm-tis-device-test.c
 create mode 100644 tests/qtest/tpm-tis-util.c
 create mode 100644 tests/qtest/tpm-tis-util.h

-- 
2.24.1


