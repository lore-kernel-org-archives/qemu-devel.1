Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F50C433E5
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 16:20:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FC12207D4
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 16:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC12207D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juIET-0000XZ-JI
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 12:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1juIDJ-0007Fl-3l; Sat, 11 Jul 2020 12:18:57 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:47377)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1juIDE-0001Lv-IE; Sat, 11 Jul 2020 12:18:56 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1233035|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0740104-0.00102722-0.924962;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03294; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.I0GMGMe_1594484317; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.I0GMGMe_1594484317)
 by smtp.aliyun-inc.com(10.147.44.129);
 Sun, 12 Jul 2020 00:18:38 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH 00/11] RISC-V risu porting
Date: Sun, 12 Jul 2020 00:16:44 +0800
Message-Id: <20200711161655.2856-1-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/11 12:18:40
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 wxy194768@alibaba-inc.com, chihmin.chao@sifive.com, wenmeng_zhang@c-sky.com,
 Alistair.Francis@wdc.com, alex.bennee@linaro.org,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In contrast to the RFC, add more instructions description. Now it supports
RV64IMACFD. Some cross verifications have been done, such as comparison
between QEMU and TinyEMU, and comparison between QEMU and C906 FPGA.

Now it has some productive.

Features:
* support RV64IMACFD.
* support multi-precision float point.
* support accurate special values generation.

Todo:
* support RVV and RVP.


LIU Zhiwei (11):
  riscv: Add RV64I instructions description
  riscv: Add RV64M instructions description
  riscv: Add RV64A instructions description
  riscv: Add RV64F instructions description
  riscv: Add RV64D instructions description
  riscv: Add RV64C instructions description
  riscv: Generate payload scripts
  riscv: Add standard test case
  riscv: Define riscv struct reginfo
  riscv: Implement payload load interfaces
  riscv: Add configure script

 configure              |   4 +-
 risu_reginfo_riscv64.c | 132 +++++++++
 risu_reginfo_riscv64.h |  28 ++
 risu_riscv64.c         |  47 +++
 risugen_riscv.pm       | 643 +++++++++++++++++++++++++++++++++++++++++
 rv64.risu              | 466 +++++++++++++++++++++++++++++
 rv64c.risu             |  97 +++++++
 test_riscv64.s         |  85 ++++++
 upstream/configure     | 204 +++++++++++++
 9 files changed, 1705 insertions(+), 1 deletion(-)
 create mode 100644 risu_reginfo_riscv64.c
 create mode 100644 risu_reginfo_riscv64.h
 create mode 100644 risu_riscv64.c
 create mode 100644 risugen_riscv.pm
 create mode 100644 rv64.risu
 create mode 100644 rv64c.risu
 create mode 100644 test_riscv64.s
 create mode 100644 upstream/configure

-- 
2.23.0


