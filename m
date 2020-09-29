Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77021C2D0A8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 02:07:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A70DF21531
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 02:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A70DF21531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN52v-0007e6-No
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 22:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangyifei@huawei.com>)
 id 1kN50B-0004qe-N3; Mon, 28 Sep 2020 22:04:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51140 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangyifei@huawei.com>)
 id 1kN507-0002wm-E8; Mon, 28 Sep 2020 22:04:23 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id C135571F64CF45F35389;
 Tue, 29 Sep 2020 10:03:59 +0800 (CST)
Received: from huawei.com (10.174.187.31) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Tue, 29 Sep 2020
 10:03:52 +0800
From: Yifei Jiang <jiangyifei@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
Subject: [PATCH 0/5] Support RISC-V migration
Date: Tue, 29 Sep 2020 10:03:32 +0800
Message-ID: <20200929020337.1559-1-jiangyifei@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.174.187.31]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=jiangyifei@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:04:00
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
 Yifei Jiang <jiangyifei@huawei.com>, Alistair.Francis@wdc.com,
 yinyipeng1@huawei.com, palmer@dabbelt.com, wu.wubin@huawei.com,
 dengkai1@huawei.com
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

Yifei Jiang (5):
  target/riscv: Add basic vmstate description of CPU
  target/riscv: Add PMP state description
  target/riscv: Add H extention state description
  target/riscv: Add V extention state description
  target/riscv: Add sifive_plic vmstate

 hw/intc/sifive_plic.c    |  26 +++++-
 hw/intc/sifive_plic.h    |   1 +
 target/riscv/cpu.c       |   7 --
 target/riscv/cpu.h       |   4 +
 target/riscv/machine.c   | 184 +++++++++++++++++++++++++++++++++++++++
 target/riscv/meson.build |   3 +-
 6 files changed, 214 insertions(+), 9 deletions(-)
 create mode 100644 target/riscv/machine.c

-- 
2.19.1


