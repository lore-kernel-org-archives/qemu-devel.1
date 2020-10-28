Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B275CC55178
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 04:21:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ADA72076C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 04:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ADA72076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXcxQ-0003Q8-4y
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 00:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kXcvL-0001YH-OK; Wed, 28 Oct 2020 00:18:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2301)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kXcvJ-0007WR-LT; Wed, 28 Oct 2020 00:18:59 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CLb1F19TRzkZvM;
 Wed, 28 Oct 2020 12:18:57 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Wed, 28 Oct 2020
 12:18:46 +0800
From: Chen Qun <kuhn.chenqun@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH 0/9] silence the compiler warnings
Date: Wed, 28 Oct 2020 12:18:10 +0800
Message-ID: <20201028041819.2169003-1-kuhn.chenqun@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=kuhn.chenqun@huawei.com; helo=szxga04-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 00:18:54
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Chen Qun <kuhn.chenqun@huawei.com>, zhang.zhanghailiang@huawei.com,
 ganqixin@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,

When building with GCC9 using CFLAG -Wimplicit-fallthrough=2 we get a
lot of warning. Some problems may be missing break statements which 
I have submitted the patch separately.

This series is all add the corresponding "fall through" comment to fix them.


Chen Qun (9):
  target/i386: silence the compiler warnings in gen_shiftd_rm_T1
  hw/intc/arm_gicv3_kvm: silence the compiler warnings
  accel/tcg/user-exec: silence the compiler warnings
  linux-user/mips/cpu_loop: silence the compiler warnings
  target/sparc/translate: silence the compiler warnings
  target/sparc/win_helper: silence the compiler warnings
  ppc: silence the compiler warnings
  target/ppc: silence the compiler warnings
  hw/timer/renesas_tmr: silence the compiler warnings

 accel/tcg/user-exec.c      | 2 +-
 hw/intc/arm_gicv3_kvm.c    | 8 ++++++++
 hw/ppc/ppc.c               | 1 +
 hw/timer/renesas_tmr.c     | 1 +
 linux-user/mips/cpu_loop.c | 4 ++++
 target/i386/translate.c    | 4 ++--
 target/ppc/mmu_helper.c    | 1 +
 target/sparc/translate.c   | 2 +-
 target/sparc/win_helper.c  | 1 +
 9 files changed, 20 insertions(+), 4 deletions(-)

-- 
2.27.0


