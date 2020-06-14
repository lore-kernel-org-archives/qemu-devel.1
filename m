Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DB5C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 08:47:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EFD220714
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 08:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EFD220714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkOIH-00048e-HU
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 04:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <like.xu@linux.intel.com>)
 id 1jkOHO-0003JN-Em
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 04:46:14 -0400
Received: from mga11.intel.com ([192.55.52.93]:62473)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <like.xu@linux.intel.com>)
 id 1jkOHM-0003VW-Fb
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 04:46:14 -0400
IronPort-SDR: VT7rMHVbv/sgaK2GXKMz0z0dUu1ATo24x2qEB3+VMOjGahA3cAO4rJAudQun3303WIzAB306pO
 yROfrNTqnYkw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2020 01:46:06 -0700
IronPort-SDR: 4H+x0U98+DkucugVzStO9nJwtlxX5CrHb6lajLx+GZF9zHxnPqavP+XjpHXUTvFHlZ/mBoVEqB
 iFQjBps0+VCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,510,1583222400"; d="scan'208";a="261405140"
Received: from sqa-gate.sh.intel.com (HELO clx-ap-likexu.tsp.org)
 ([10.239.48.212])
 by orsmga007.jf.intel.com with ESMTP; 14 Jun 2020 01:46:05 -0700
From: Like Xu <like.xu@linux.intel.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] migration/colo: fix typo in the COLO Framework module
Date: Sun, 14 Jun 2020 16:45:09 +0800
Message-Id: <20200614084510.7917-1-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.93;
 envelope-from=like.xu@linux.intel.com; helo=mga11.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/14 04:46:06
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: Hailiang Zhang <zhang.zhanghailiang@huawei.com>,
 Like Xu <like.xu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 docs/COLO-FT.txt | 8 ++++----
 migration/colo.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/docs/COLO-FT.txt b/docs/COLO-FT.txt
index c8e1740935..fdc0207cff 100644
--- a/docs/COLO-FT.txt
+++ b/docs/COLO-FT.txt
@@ -10,7 +10,7 @@ See the COPYING file in the top-level directory.
 This document gives an overview of COLO's design and how to use it.
 
 == Background ==
-Virtual machine (VM) replication is a well known technique for providing
+Virtual machine (VM) replication is a well-known technique for providing
 application-agnostic software-implemented hardware fault tolerance,
 also known as "non-stop service".
 
@@ -103,7 +103,7 @@ Primary side.
 
 COLO Proxy:
 Delivers packets to Primary and Secondary, and then compare the responses from
-both side. Then decide whether to start a checkpoint according to some rules.
+both sides. Then decide whether to start a checkpoint according to some rules.
 Please refer to docs/colo-proxy.txt for more information.
 
 Note:
@@ -146,12 +146,12 @@ in test procedure.
 
 == Test procedure ==
 Note: Here we are running both instances on the same host for testing,
-change the IP Addresses if you want to run it on two hosts. Initally
+change the IP Addresses if you want to run it on two hosts. Initially
 127.0.0.1 is the Primary Host and 127.0.0.2 is the Secondary Host.
 
 == Startup qemu ==
 1. Primary:
-Note: Initally, $imagefolder/primary.qcow2 needs to be copied to all hosts.
+Note: Initially, $imagefolder/primary.qcow2 needs to be copied to all hosts.
 You don't need to change any IP's here, because 0.0.0.0 listens on any
 interface. The chardev's with 127.0.0.1 IP's loopback to the local qemu
 instance.
diff --git a/migration/colo.c b/migration/colo.c
index ea7d1e9d4e..80788d46b5 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -632,7 +632,7 @@ out:
     /*
      * It is safe to unregister notifier after failover finished.
      * Besides, colo_delay_timer and colo_checkpoint_sem can't be
-     * released befor unregister notifier, or there will be use-after-free
+     * released before unregister notifier, or there will be use-after-free
      * error.
      */
     colo_compare_unregister_notifier(&packets_compare_notifier);
-- 
2.21.3


