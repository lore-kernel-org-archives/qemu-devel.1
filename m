Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21657C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:56:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E564D20738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E564D20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhXM-0007Lw-6g
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1jnhIr-0006Dv-62
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:41:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34566)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1jnhIp-0004i6-99
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:41:24 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05NBWpqP183461; Tue, 23 Jun 2020 07:41:20 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31sk2s8b9e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2020 07:41:20 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05NBPuuf032315;
 Tue, 23 Jun 2020 11:41:18 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma04wdc.us.ibm.com with ESMTP id 31u20cw6hk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2020 11:41:18 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05NBfHde49152332
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2020 11:41:17 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A871DC6057;
 Tue, 23 Jun 2020 11:41:17 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4DB87C6055;
 Tue, 23 Jun 2020 11:41:17 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2020 11:41:17 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 00/12] Merge tpm 2020/06/23 v1
Date: Tue, 23 Jun 2020 07:41:02 -0400
Message-Id: <20200623114114.1375104-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-23_06:2020-06-23,
 2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=834
 suspectscore=1 clxscore=1015 lowpriorityscore=0 bulkscore=0
 cotscore=-2147483648 mlxscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 spamscore=0 phishscore=0 impostorscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006230092
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=stefanb@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 07:29:31
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This PR cleans up header includes in TPM code and moves some backend components
into backends/tpm.

The following changes since commit 292ef18a38270e1cb8e9a3dc06bca589068f293d:

  Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' into staging (2020-06-18 16:52:10 +0100)

are available in the Git repository at:

  git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2020-06-23-1

for you to fetch changes up to ca64b08638e259c313a3e7c3da106116b59be8e9:

  tpm: Move backend code under the 'backends/' directory (2020-06-19 07:25:55 -0400)

----------------------------------------------------------------
Merge tpm 2020/06/23 v1

----------------------------------------------------------------
Philippe Mathieu-Daudé (12):
      docs/specs/tpm: Correct header path name
      backends: Add TPM files into their own directory
      hw/tpm: Rename TPMDEV as TPM_BACKEND in Kconfig
      hw/tpm: Do not include 'qemu/osdep.h' in header
      hw/tpm: Include missing 'qemu/option.h' header
      hw/tpm: Move 'hw/acpi/tpm.h' inclusion from header to sources
      hw/tpm: Remove unnecessary 'tpm_int.h' header inclusion
      hw/tpm: Make TRACE_TPM_UTIL_SHOW_BUFFER check local to tpm_util.c
      hw/tpm: Move few declarations from 'tpm_util.h' to 'tpm_int.h'
      hw/tpm: Move DEFINE_PROP_TPMBE() macro to 'tmp_prop.h' local header
      hw/tpm: Make 'tpm_util.h' publicly accessible as "sysemu/tpm_util.h"
      tpm: Move backend code under the 'backends/' directory

 MAINTAINERS                            |  2 +-
 Makefile                               |  2 +-
 Makefile.objs                          |  1 +
 backends/Kconfig                       |  1 +
 backends/Makefile.objs                 |  2 +-
 backends/tpm/Kconfig                   | 14 ++++++++++++++
 backends/tpm/Makefile.objs             |  4 ++++
 backends/{tpm.c => tpm/tpm_backend.c}  |  0
 {hw => backends}/tpm/tpm_emulator.c    |  2 +-
 {hw => backends}/tpm/tpm_int.h         | 19 ++++++++++++++++---
 {hw => backends}/tpm/tpm_ioctl.h       |  0
 {hw => backends}/tpm/tpm_passthrough.c |  2 +-
 {hw => backends}/tpm/tpm_util.c        |  5 ++++-
 backends/tpm/trace-events              | 33 +++++++++++++++++++++++++++++++++
 docs/specs/tpm.rst                     | 14 +++++++-------
 hw/tpm/Kconfig                         | 21 +++------------------
 hw/tpm/Makefile.objs                   |  3 ---
 hw/tpm/tpm_crb.c                       |  4 ++--
 hw/tpm/tpm_ppi.c                       |  1 +
 hw/tpm/tpm_ppi.h                       |  1 -
 hw/tpm/tpm_prop.h                      | 31 +++++++++++++++++++++++++++++++
 hw/tpm/tpm_spapr.c                     |  4 ++--
 hw/tpm/tpm_tis.h                       |  1 -
 hw/tpm/tpm_tis_common.c                | 11 +++--------
 hw/tpm/tpm_tis_isa.c                   |  3 ++-
 hw/tpm/tpm_tis_sysbus.c                |  3 ++-
 hw/tpm/trace-events                    | 34 +---------------------------------
 {hw/tpm => include/sysemu}/tpm_util.h  | 19 +++----------------
 tests/qtest/tpm-emu.c                  |  2 +-
 29 files changed, 136 insertions(+), 103 deletions(-)
 create mode 100644 backends/Kconfig
 create mode 100644 backends/tpm/Kconfig
 create mode 100644 backends/tpm/Makefile.objs
 rename backends/{tpm.c => tpm/tpm_backend.c} (100%)
 rename {hw => backends}/tpm/tpm_emulator.c (99%)
 rename {hw => backends}/tpm/tpm_int.h (81%)
 rename {hw => backends}/tpm/tpm_ioctl.h (100%)
 rename {hw => backends}/tpm/tpm_passthrough.c (99%)
 rename {hw => backends}/tpm/tpm_util.c (98%)
 create mode 100644 backends/tpm/trace-events
 create mode 100644 hw/tpm/tpm_prop.h
 rename {hw/tpm => include/sysemu}/tpm_util.h (80%)

-- 
2.24.1


