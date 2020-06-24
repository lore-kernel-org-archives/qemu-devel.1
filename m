Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A81C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 01:33:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 232C0206EB
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 01:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232C0206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnuIV-0001QR-EF
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 21:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jnuGz-0000EO-LA
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 21:32:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:58215)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jnuGx-0002a3-3P
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 21:32:21 -0400
IronPort-SDR: aDLI68dhBrrK7MPCwOvH9YsFJRrUqByqwLzJRK8SstbqQmcR/SmT5zuutfXqkwqkkzdvqI7xK1
 zWegNG8JC8nw==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="144319713"
X-IronPort-AV: E=Sophos;i="5.75,273,1589266800"; d="scan'208";a="144319713"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2020 18:32:13 -0700
IronPort-SDR: 3lkBE4T/JbbPVbtmorzlWMYXBNs7UW8D0L/5BLAAo/BbaUzeZ2HjoQiWCZS2viWIAgI3crCTu7
 fh4Co/erKUDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,273,1589266800"; d="scan'208";a="301458049"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by fmsmga004.fm.intel.com with ESMTP; 23 Jun 2020 18:32:11 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Jason Wang <jasowang@redhat.com>
Subject: [PATCH V2 0/2] net/colo-compare.c: Expose "max_queue_size" to users
 and clean up
Date: Wed, 24 Jun 2020 09:20:40 +0800
Message-Id: <20200624012042.29355-1-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=134.134.136.65; envelope-from=chen.zhang@intel.com;
 helo=mga03.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 21:32:13
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, FROM_ADDR_WS=1,
 FROM_WSP_TRAIL=1, HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Zhang Chen <chen.zhang@intel.com>, qemu-dev <qemu-devel@nongnu.org>,
 Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhang Chen <chen.zhang@intel.com>

This series make a way to config COLO "max_queue_size" parameters according to
user's scenarios and environments and do some clean up for descriptions.

V2:
 - Rebase on upstream code.

Zhang Chen (2):
  net/colo-compare.c: Expose compare "max_queue_size" to users
  qemu-options.hx: Clean up and fix typo for colo-compare

 net/colo-compare.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 qemu-options.hx    | 33 +++++++++++++++++----------------
 2 files changed, 59 insertions(+), 17 deletions(-)

-- 
2.17.1


