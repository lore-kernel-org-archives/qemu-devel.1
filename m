Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C009C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8970B2076E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8970B2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRx86-0007UW-GV
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 08:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yubihong@huawei.com>)
 id 1kRx4t-0003AM-Oa; Mon, 12 Oct 2020 08:37:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5227 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yubihong@huawei.com>)
 id 1kRx4p-0007ZF-RZ; Mon, 12 Oct 2020 08:37:22 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 01295C619A7EA9F6618C;
 Mon, 12 Oct 2020 20:37:04 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 12 Oct 2020
 20:36:54 +0800
From: Bihong Yu <yubihong@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH v2 0/8] Fix some style problems in migration
Date: Mon, 12 Oct 2020 21:08:52 +0800
Message-ID: <1602508140-11372-1-git-send-email-yubihong@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=yubihong@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 07:12:20
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
Cc: yubihong@huawei.com, zhengchuan@huawei.com, quintela@redhat.com,
 dgilbert@redhat.com, alex.chen@huawei.com, wanghao232@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Recently I am reading migration related code, find some style problems in
migration directory while using checkpatch.pl to check migration code. Fix the
error style problems.

v2:
- fix Signed-off-by error
- fix printf format error: "%0x" -> "0x%x"

Bihong Yu (8):
  migration: Do not use C99 // comments
  migration: Don't use '#' flag of printf format
  migration: Add spaces around operator
  migration: Open brace '{' following struct go on the same line
  migration: Add braces {} for if statement
  migration: Do not initialise statics and globals to 0 or NULL
  migration: Open brace '{' following function declarations go on the
    next line
  migration: Delete redundant spaces

 migration/block.c        |  4 ++--
 migration/migration.c    |  4 ++--
 migration/migration.h    |  3 +--
 migration/postcopy-ram.c |  2 +-
 migration/ram.c          | 14 ++++++++------
 migration/rdma.c         |  7 ++++---
 migration/savevm.c       |  4 ++--
 migration/vmstate.c      | 10 +++++-----
 8 files changed, 25 insertions(+), 23 deletions(-)

-- 
1.8.3.1


