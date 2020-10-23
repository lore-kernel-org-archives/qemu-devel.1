Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F78C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 06:14:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C1A72074A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 06:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C1A72074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVqL9-0001j7-Np
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 02:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kVqJp-0000Bt-4u; Fri, 23 Oct 2020 02:12:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47366 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kVqJn-0000u1-59; Fri, 23 Oct 2020 02:12:52 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 64C02DCB7E5C90CF1D36;
 Fri, 23 Oct 2020 14:12:35 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Fri, 23 Oct 2020
 14:12:27 +0800
From: Chen Qun <kuhn.chenqun@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH RESEND v2 0/7] some memleak trivial patchs
Date: Fri, 23 Oct 2020 14:12:11 +0800
Message-ID: <20201023061218.2080844-1-kuhn.chenqun@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32;
 envelope-from=kuhn.chenqun@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:12:37
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
Cc: lvivier@redhat.com, Chen Qun <kuhn.chenqun@huawei.com>,
 pannengyuan@huawei.com, zhang.zhanghailiang@huawei.com, ganqixin@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,

  Here are some memory leak patches reported by EulerRobot.
Some patch submissions have been unattended for a while and I resend
them.

Thanks,
Chen Qun


Chen Qun (1):
  tests/migration: fix memleak in wait_command/wait_command_fd

Pan Nengyuan (6):
  qga/channel-posix: Plug memory leak in ga_channel_write_all()
  elf2dmp/qemu_elf: Plug memleak in QEMU_Elf_init
  elf2dmp/pdb: Plug memleak in pdb_init_from_file
  migration/colo: Plug memleaks in colo_process_incoming_thread
  blockdev: Fix a memleak in drive_backup_prepare()
  block/file-posix: fix a possible undefined behavior

 block/file-posix.c              |  2 +-
 blockdev.c                      |  1 +
 contrib/elf2dmp/pdb.c           |  1 +
 contrib/elf2dmp/qemu_elf.c      |  1 +
 migration/colo.c                |  5 ++++-
 qga/channel-posix.c             |  6 +++++-
 tests/qtest/migration-helpers.c | 16 ++++++++++++----
 7 files changed, 25 insertions(+), 7 deletions(-)

-- 
2.23.0


