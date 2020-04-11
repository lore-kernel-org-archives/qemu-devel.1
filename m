Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2563C2BA19
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 03:48:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EA2020708
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 03:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA2020708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jN78R-0000iH-Cs
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 23:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jN77k-0008HT-GJ
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 23:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1jN77i-0004iE-SY
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 23:48:03 -0400
Received: from mga18.intel.com ([134.134.136.126]:21812)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1jN77i-0004c4-LE
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 23:48:02 -0400
IronPort-SDR: iQsqf8A3umFQVkbts5hlkF/8Lof2B0d5CUy6zJY9U0zEgsgU+a7NqrMGWMeQMRyTMrTHxHhb0T
 YQ26zMdf2hXA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2020 20:47:53 -0700
IronPort-SDR: 2P2HRP+SPXKX38FZo8CML0B83YBB5TIBbMKjwR62CZQ539WuyUnKVA9gl4UTBGYLh4RouXiRl6
 TULt1vHE+2Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,368,1580803200"; d="scan'208";a="276368258"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by fmsmga004.fm.intel.com with ESMTP; 10 Apr 2020 20:47:51 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Jason Wang <jasowang@redhat.com>,
	qemu-dev <qemu-devel@nongnu.org>
Subject: [PATCH 0/2] net/colo-compare.c: Expose "max_queue_size" to users and
 clean up
Date: Sat, 11 Apr 2020 11:38:22 +0800
Message-Id: <20200411033824.19389-1-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.126
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

This series make a way to config COLO "max_queue_size" parameters according to
user's scenarios and environments and do some clean up for descriptions.

Zhang Chen (2):
  net/colo-compare.c: Expose compare "max_queue_size" to users
  qemu-options.hx: Clean up and fix typo for colo-compare

 net/colo-compare.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 qemu-options.hx    | 33 +++++++++++++++++----------------
 2 files changed, 59 insertions(+), 17 deletions(-)

-- 
2.17.1


