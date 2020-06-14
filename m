Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3063BC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 08:47:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0978520714
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 08:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0978520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkOII-0004Ai-BO
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 04:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <like.xu@linux.intel.com>)
 id 1jkOHP-0003JZ-T3
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 04:46:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:62474)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <like.xu@linux.intel.com>)
 id 1jkOHO-0003Ve-7Y
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 04:46:15 -0400
IronPort-SDR: xkgO0W667Wv9OOGsBVKqc4uKBNyOzYWUgLD+9aYAYlyWwmtsHFgEJ6bFQprWiztrowc8JiSimp
 KejF/Dvg/9WQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2020 01:46:07 -0700
IronPort-SDR: FfGAzbDDyQTBrQcby1Mu8ESEwO+LIdlRqOKFcM6loDo9D6amgGJb5kMdJ/gucZlhMu7spcL0YD
 UD8hffIBih0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,510,1583222400"; d="scan'208";a="261405146"
Received: from sqa-gate.sh.intel.com (HELO clx-ap-likexu.tsp.org)
 ([10.239.48.212])
 by orsmga007.jf.intel.com with ESMTP; 14 Jun 2020 01:46:06 -0700
From: Like Xu <like.xu@linux.intel.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] migration/colo/net: fix typo in the COLO Proxy module
Date: Sun, 14 Jun 2020 16:45:10 +0800
Message-Id: <20200614084510.7917-2-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200614084510.7917-1-like.xu@linux.intel.com>
References: <20200614084510.7917-1-like.xu@linux.intel.com>
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
Cc: Zhang Chen <chen.zhang@intel.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 Like Xu <like.xu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Zhang Chen <chen.zhang@intel.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 docs/colo-proxy.txt | 4 ++--
 net/colo-compare.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/colo-proxy.txt b/docs/colo-proxy.txt
index fa1cef0278..0bbd6f720a 100644
--- a/docs/colo-proxy.txt
+++ b/docs/colo-proxy.txt
@@ -21,7 +21,7 @@ and filter-rewriter compose the COLO-proxy.
 == Architecture ==
 
 COLO-Proxy is based on qemu netfilter and it's a plugin for qemu netfilter
-(except colo-compare). It keep Secondary VM connect normally to
+(except colo-compare). It keeps Secondary VM connect normally to
 client and compare packets sent by PVM with sent by SVM.
 If the packet difference, notify COLO-frame to do checkpoint and send
 all primary packet has queued. Otherwise just send the queued primary
@@ -94,7 +94,7 @@ Redirect Server Filter --> COLO-Compare
 COLO-compare receive primary guest packet then
 waiting secondary redirect packet to compare it.
 If packet same,send queued primary packet and clear
-queued secondary packet, Otherwise send primary packet
+queued secondary packet, otherwise send primary packet
 and do checkpoint.
 
 COLO-Compare --> Another Redirector Filter
diff --git a/net/colo-compare.c b/net/colo-compare.c
index c07e7c1c09..3efc61c777 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -658,7 +658,7 @@ static void colo_compare_packet(CompareState *s, Connection *conn,
             g_queue_remove(&conn->secondary_list, result->data);
         } else {
             /*
-             * If one packet arrive late, the secondary_list or
+             * If one packet arrives late, the secondary_list or
              * primary_list will be empty, so we can't compare it
              * until next comparison. If the packets in the list are
              * timeout, it will trigger a checkpoint request.
@@ -1296,7 +1296,7 @@ static void colo_compare_finalize(Object *obj)
         }
     }
 
-    /* Release all unhandled packets after compare thead exited */
+    /* Release all unhandled packets after compare thread exited */
     g_queue_foreach(&s->conn_list, colo_flush_packets, s);
 
     g_queue_clear(&s->conn_list);
-- 
2.21.3


