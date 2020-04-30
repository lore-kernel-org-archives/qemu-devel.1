Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775AEC83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:24:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DE9720838
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE9720838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU3Yx-0006pZ-EC
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 03:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jU3XX-0004af-8n
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:23:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jU3W7-0006Y8-Ak
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:23:23 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:34278)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jU3W6-0006WG-Kj; Thu, 30 Apr 2020 03:21:54 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08792099|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_regular_dialog|0.1343-0.00143465-0.864266;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01a16384; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.HQfovas_1588231302; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HQfovas_1588231302) by smtp.aliyun-inc.com(10.147.40.7);
 Thu, 30 Apr 2020 15:21:43 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: peter.maydell@linaro.org
Subject: [RFC PATCH 0/8] RISCV risu porting 
Date: Thu, 30 Apr 2020 15:21:31 +0800
Message-Id: <20200430072139.4602-1-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 03:21:44
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Received-From: 121.197.200.217
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
Cc: qemu-riscv@nongnu.org, richard.henderson@linaro.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com, wenmeng_zhang@c-sky.com, palmer@dabbelt.com,
 alistair23@gmail.com, alex.bennee@linaro.org,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When I test RISCV vector extension, many folks advice risu. Here is a
very simple port only support RV64I, RV64F, RV64M.

It's some difficult when I try to support RV32, because it's very
similiar to RV64, so I can't make two .risu files like arm.risu and
aarch64.risu.

Any idea are welcomed.

LIU Zhiwei (8):
  riscv: Add RV64I instructions description
  riscv: Generate payload scripts
  riscv: Define riscv struct reginfo
  riscv: Implement payload load interfaces
  riscv: Add standard test case
  riscv: Add configure script
  riscv: Add RV64M instructions description
  riscv: Add RV64F instructions description

 configure              |   4 +-
 riscv64.risu           | 262 +++++++++++++++++++++
 risu_reginfo_riscv64.c | 134 +++++++++++
 risu_reginfo_riscv64.h |  29 +++
 risu_riscv64.c         |  47 ++++
 risugen_riscv.pm       | 501 +++++++++++++++++++++++++++++++++++++++++
 test_riscv64.s         |  85 +++++++
 7 files changed, 1061 insertions(+), 1 deletion(-)
 create mode 100644 riscv64.risu
 create mode 100644 risu_reginfo_riscv64.c
 create mode 100644 risu_reginfo_riscv64.h
 create mode 100644 risu_riscv64.c
 create mode 100644 risugen_riscv.pm
 create mode 100644 test_riscv64.s

-- 
2.23.0


