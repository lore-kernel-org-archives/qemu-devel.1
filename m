Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC22C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 07:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 196B822243
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 07:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196B822243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSy9W-0002bI-16
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 03:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kSy8M-0001Rs-3e
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 03:57:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:22516)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kSy8J-0001pn-Ey
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 03:57:09 -0400
IronPort-SDR: sMUuFlldScqme7bEFFWCWlNfCHaKrQwgcAxUwcoyoFSx7yOfeSyB6coQBZDCaTAfNpu1zm1Ap8
 GjFDlOfvR8CQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="166408912"
X-IronPort-AV: E=Sophos;i="5.77,378,1596524400"; d="scan'208";a="166408912"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2020 00:57:02 -0700
IronPort-SDR: 84sf/HG3Jlq4guF0nmitiUuVyYhnssx37+HTZyU/75/aGjxwmD//Q75qNkSF81bmWXt6Q9buOE
 ww4diahlizfg==
X-IronPort-AV: E=Sophos;i="5.77,378,1596524400"; d="scan'208";a="531154069"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2020 00:57:00 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Jason Wang <jasowang@redhat.com>,
	qemu-dev <qemu-devel@nongnu.org>
Subject: [PATCH 10/10] net/colo-compare.c: Increase default queued packet scan
 frequency
Date: Thu, 15 Oct 2020 15:54:37 +0800
Message-Id: <20201015075437.20033-1-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=134.134.136.24; envelope-from=chen.zhang@intel.com;
 helo=mga09.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 03:57:02
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, FROM_ADDR_WS=2.999,
 FROM_WSP_TRAIL=1, HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Zhang Chen <chen.zhang@intel.com>, Zhang Chen <zhangckid@gmail.com>
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
index c22f2af941..36f8199bbb 100644
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


