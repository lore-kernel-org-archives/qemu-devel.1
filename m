Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAA9C43457
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 04:13:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA4632076C
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 04:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA4632076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTdbO-0002aB-Qm
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 00:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kTdXe-0005rU-0G
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 00:10:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5180 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kTdXb-0007BK-8M
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 00:10:01 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 57EE39B658F523E323E6;
 Sat, 17 Oct 2020 12:09:46 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Sat, 17 Oct 2020
 12:09:39 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [PATCH v3 00/18] Support Multifd for RDMA migration 
Date: Sat, 17 Oct 2020 12:25:30 +0800
Message-ID: <1602908748-43335-1-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=zhengchuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/17 00:09:47
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
Cc: yubihong@huawei.com, zhang.zhanghailiang@huawei.com, fengzhimin1@huawei.com,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, alex.chen@huawei.com,
 wanghao232@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now I continue to support multifd for RDMA migration based on my colleague
zhiming's work:)

The previous RFC patches is listed below:
v1:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg669455.html
v2:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg679188.html

As descried in previous RFC, the RDMA bandwidth is not fully utilized for
over 25Gigabit NIC because of single channel for RDMA migration.
This patch series is going to support multifd for RDMA migration based on
multifd framework.

Comparsion is between origion and multifd RDMA migration is re-tested for v3.
The VM specifications for migration are as follows:
- VM use 4k page;
- the number of VCPU is 4;
- the total memory is 16Gigabit;
- use 'mempress' tool to pressurize VM(mempress 8000 500);
- use 25Gigabit network card to migrate;

For origin RDMA and MultiRDMA migration, the total migration times of
VM are as follows:
+++++++++++++++++++++++++++++++++++++++++++++++++
|             | NOT rdma-pin-all | rdma-pin-all |
+++++++++++++++++++++++++++++++++++++++++++++++++
| origin RDMA |       26 s       |     29 s     |
-------------------------------------------------
|  MultiRDMA  |       16 s       |     17 s     |
+++++++++++++++++++++++++++++++++++++++++++++++++

Test the multifd RDMA migration like this:
virsh migrate --live --multiFd --migrateuri
rdma://192.168.1.100 [VM] --listen-address 0.0.0.0  qemu+tcp://192.168.1.100/system --verbose

v2 -> v3:
    create multifd ops for both tcp and rdma
    do not export rdma to avoid multifd code in mess
    fix build issue for non-rdma
    fix some codestyle and buggy code

Chuan Zheng (18):
  migration/rdma: add the 'migrate_use_rdma_pin_all' function
  migration/rdma: judge whether or not the RDMA is used for migration
  migration/rdma: create multifd_setup_ops for Tx/Rx thread
  migration/rdma: add multifd_setup_ops for rdma
  migration/rdma: do not need sync main for rdma
  migration/rdma: export MultiFDSendParams/MultiFDRecvParams
  migration/rdma: add rdma field into multifd send/recv param
  migration/rdma: export getQIOChannel to get QIOchannel in rdma
  migration/rdma: add multifd_rdma_load_setup() to setup multifd rdma
  migration/rdma: Create the multifd recv channels for RDMA
  migration/rdma: record host_port for multifd RDMA
  migration/rdma: Create the multifd send channels for RDMA
  migration/rdma: Add the function for dynamic page registration
  migration/rdma: register memory for multifd RDMA channels
  migration/rdma: only register the memory for multifd channels
  migration/rdma: add rdma_channel into Migrationstate field
  migration/rdma: send data for both rdma-pin-all and NOT rdma-pin-all
    mode
  migration/rdma: RDMA cleanup for multifd migration

 migration/migration.c |  24 +++
 migration/migration.h |  11 ++
 migration/multifd.c   |  97 +++++++++-
 migration/multifd.h   |  24 +++
 migration/qemu-file.c |   5 +
 migration/qemu-file.h |   1 +
 migration/rdma.c      | 503 +++++++++++++++++++++++++++++++++++++++++++++++++-
 7 files changed, 653 insertions(+), 12 deletions(-)

-- 
1.8.3.1


