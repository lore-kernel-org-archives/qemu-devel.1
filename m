Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81C9C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 07:20:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAFEC208DB
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 07:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAFEC208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCe6p-0007Xw-LH
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 03:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1kCe48-0002c0-My
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 03:17:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56134 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1kCe45-0005sb-HV
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 03:17:20 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 7A5897CC721159E468F3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 15:17:05 +0800 (CST)
Received: from opensource.huawei.com (10.175.100.152) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 31 Aug 2020 15:16:55 +0800
From: Pan Nengyuan <pannengyuan@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v2 00/10] fix some error memleaks
Date: Mon, 31 Aug 2020 09:43:05 -0400
Message-ID: <20200831134315.1221-1-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.152]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35;
 envelope-from=pannengyuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 03:17:06
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kuhn.chenqun@huawei.com, Pan Nengyuan <pannengyuan@huawei.com>,
 zhang.zhanghailiang@huawei.com, euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series fix some Error/GError memleaks.

V2: 
  1. remove two patches.(One has aleardy applied. The other has fixed.)
  2. change patch 5/10 and 7/10.

Pan Nengyuan (10):
  qga/channel-posix: Plug memory leak in ga_channel_write_all()
  elf2dmp/qemu_elf: Plug memleak in QEMU_Elf_init
  elf2dmp/pdb: Plug memleak in pdb_init_from_file
  target/i386/sev: Plug memleak in sev_read_file_base64
  ui/gtk-gl-area: Plug memleak in gd_gl_area_create_context()
  target/i386/cpu: Fix memleak in x86_cpu_class_check_missing_features
  migration/colo: Plug memleaks in colo_process_incoming_thread
  blockdev: Fix a memleak in drive_backup_prepare()
  block/file-posix: fix a possible undefined behavior
  vnc-auth-sasl: Plug memleak in vnc_socket_ip_addr_string

 block/file-posix.c         |  2 +-
 blockdev.c                 |  1 +
 contrib/elf2dmp/pdb.c      |  1 +
 contrib/elf2dmp/qemu_elf.c |  1 +
 migration/colo.c           |  5 ++++-
 qga/channel-posix.c        |  6 +++++-
 target/i386/cpu.c          |  1 +
 target/i386/sev.c          |  1 +
 ui/gtk-gl-area.c           | 11 +++++++++++
 ui/vnc-auth-sasl.c         |  1 +
 10 files changed, 27 insertions(+), 3 deletions(-)

-- 
2.18.2


