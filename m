Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0E3C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 08:14:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CF58207CD
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 08:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF58207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRA13-0002Uv-PL
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 04:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangyifei@huawei.com>)
 id 1kR9tz-00007W-G7; Sat, 10 Oct 2020 04:06:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5214 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangyifei@huawei.com>)
 id 1kR9tx-0007nU-7I; Sat, 10 Oct 2020 04:06:51 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 29E402EAB6008F810988;
 Sat, 10 Oct 2020 16:06:37 +0800 (CST)
Received: from huawei.com (10.174.185.47) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Sat, 10 Oct 2020
 16:06:26 +0800
From: Yifei Jiang <jiangyifei@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
Subject: [PATCH V2 0/5] Support RISC-V migration
Date: Sat, 10 Oct 2020 16:06:18 +0800
Message-ID: <20201010080623.768-1-jiangyifei@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.174.185.47]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=jiangyifei@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 04:06:37
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: zhang.zhanghailiang@huawei.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, victor.zhangxiaofeng@huawei.com,
 richard.henderson@linaro.org, Yifei Jiang <jiangyifei@huawei.com>,
 Alistair.Francis@wdc.com, yinyipeng1@huawei.com, palmer@dabbelt.com,
 wu.wubin@huawei.com, dengkai1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patches supported RISC-V migration based on tcg accel. And we have
verified related migration features such as snapshot and live migration.

A few weeks ago, we submitted RFC patches about supporting RISC-V migration
based on kvm accel: https://www.spinics.net/lists/kvm/msg223605.html.
And we found that tcg accelerated migration can be supported with a few
changes. Most of the devices have already implemented the migration
interface, so, to achieve the tcg accelerated migration, we just need to
add vmstate of both cpu and sifive_plic.

Changes since v1:
1. Add license head to target/riscv/machine.c.
2. Regenerate some state of PMP at post_load hook.

Yifei Jiang (5):
  target/riscv: Add basic vmstate description of CPU
  target/riscv: Add PMP state description
  target/riscv: Add H extension state description
  target/riscv: Add V extension state description
  target/riscv: Add sifive_plic vmstate

 hw/intc/sifive_plic.c    |  26 ++++-
 hw/intc/sifive_plic.h    |   1 +
 target/riscv/cpu.c       |   7 --
 target/riscv/cpu.h       |   4 +
 target/riscv/machine.c   | 203 +++++++++++++++++++++++++++++++++++++++
 target/riscv/meson.build |   3 +-
 target/riscv/pmp.c       |  29 +++---
 target/riscv/pmp.h       |   2 +
 8 files changed, 255 insertions(+), 20 deletions(-)
 create mode 100644 target/riscv/machine.c

-- 
2.19.1


