Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7151AC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 09:28:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCE7F2068E
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 09:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE7F2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJCgf-0005Q9-UM
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 05:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kJCd3-0000Fz-3i
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 05:24:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:42394)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kJCcz-0004Pi-Pv
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 05:24:28 -0400
IronPort-SDR: 8dZIxZgDRLc9n9jlaFahQAEusW6c+g3xxeV7ogr5MzTWD6ep/0sHGhcmWpMYz/F9rZ2KMq8o+V
 VuWpnSeiKqAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="244733436"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; d="scan'208";a="244733436"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2020 02:24:21 -0700
IronPort-SDR: Zc3dnsMBju3jdUGKJcR8ZJOzp8nAfy4gPMUSHjt0O//r9800dWpJU8uzaqJ0AZYybeuVQqDCAL
 RvkDRo85SDSA==
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; d="scan'208";a="484130723"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2020 02:24:20 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Jason Wang <jasowang@redhat.com>,
	qemu-dev <qemu-devel@nongnu.org>
Subject: [PATCH 4/4] net/colo-compare.c: Increase default queued packet scan
 frequency
Date: Fri, 18 Sep 2020 17:22:03 +0800
Message-Id: <20200918092203.20384-5-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918092203.20384-1-chen.zhang@intel.com>
References: <20200918092203.20384-1-chen.zhang@intel.com>
Received-SPF: pass client-ip=192.55.52.43; envelope-from=chen.zhang@intel.com;
 helo=mga05.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 05:24:15
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, FROM_ADDR_WS=2.999,
 FROM_WSP_TRAIL=1, HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhang Chen <chen.zhang@intel.com>

In my test, use this default parameter looks better.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 net/colo-compare.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index f7271b976f..6df6a7e66f 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -52,7 +52,7 @@ static NotifierList colo_compare_notifiers =
 #define COLO_COMPARE_FREE_PRIMARY     0x01
 #define COLO_COMPARE_FREE_SECONDARY   0x02
 
-#define REGULAR_PACKET_CHECK_MS 3000
+#define REGULAR_PACKET_CHECK_MS 1000
 #define DEFAULT_TIME_OUT_MS 3000
 
 /* #define DEBUG_COLO_PACKETS */
-- 
2.17.1


