Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656E2C2D0E0
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 02:37:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2C0120770
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 02:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C0120770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHHtX-0006Vy-Ll
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 22:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kHHsm-0004wB-Od
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 22:36:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4688 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kHHsk-0003VW-2k
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 22:36:48 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 7533667A06A439A332DC;
 Sun, 13 Sep 2020 10:36:38 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Sun, 13 Sep 2020
 10:36:31 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <eblake@redhat.com>, <dgilbert@redhat.com>,
 <berrange@redhat.com>
Subject: [PATCH v3 0/6] *** Add Multifd support for TLS migration ***
Date: Sun, 13 Sep 2020 10:47:30 +0800
Message-ID: <1599965256-72150-1-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=zhengchuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 22:36:39
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
Cc: zhengchuan@huawei.com, zhang.zhanghailiang@huawei.com, yuxiating@huawei.com,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, alex.chen@huawei.com,
 jinyan12@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2 -> v3:
    rebase patches on master

v1 -> v2:
    fix memoryleak of MigrationState hostname
    add tls_hostname into MultiFDSendParams for handshake use
    fix function alignment
    squash Patch005 and Patch006
    add ioc into trace-events

TLS migration could easily reach bottleneck of cpu because of encryption
and decryption in migration thread.
In our test, the tls migration could only reach 300MB/s under bandwidth
of 500MB/s.

Inspired by multifd, we add multifd support for tls migration to make fully
use of given net bandwidth at the cost of multi-cpus and could reduce
at most of 100% migration time with 4U16G test vm.

Evaluate migration time of migration vm.
The VM specifications for migration are as follows:
- VM use 4-K page;
- the number of VCPU is 4;
- the total memory is 16Gigabit;
- use 'mempress' tool to pressurize VM(mempress 4096 100);
- migration flag is 73755 (8219 + 65536 (TLS)) vs 204827 (8219 + 65536 (TLS) + 131072(Multifd))

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
|                      |         TLS           |      MultiFD + TLS (2 channel)    |
--------------------------------------------------------t---------------------------
| mempress 1024 120    |       25.035s         |           15.067s                 |
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
| mempress 1024 200    |       48.798s         |           25.334s                 |
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Chuan Zheng (6):
  migration/tls: save hostname into MigrationState
  migration/tls: extract migration_tls_client_create for common-use
  migration/tls: add MigrationState and tls_hostname into
    MultiFDSendParams
  migration/tls: extract cleanup function for common-use
  migration/tls: add support for multifd tls-handshake
  migration/tls: add trace points for multifd-tls

 migration/channel.c    |   6 +++
 migration/migration.c  |   1 +
 migration/migration.h  |   5 ++
 migration/multifd.c    | 124 +++++++++++++++++++++++++++++++++++++++++++------
 migration/multifd.h    |   4 ++
 migration/tls.c        |  26 +++++++----
 migration/tls.h        |   6 +++
 migration/trace-events |   4 ++
 8 files changed, 154 insertions(+), 22 deletions(-)

-- 
1.8.3.1


