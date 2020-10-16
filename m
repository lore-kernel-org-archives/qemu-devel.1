Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED620C43457
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 05:56:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3422A207F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 05:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3422A207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTIic-0007xx-3v
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 01:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kTIhR-0006HR-8x
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 01:54:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:36617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kTIhO-0005C7-5V
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 01:54:45 -0400
IronPort-SDR: km8+vteBKxH1C+3nuHQAWgUsJnXbfQ8hg5UiPGsqdd2mgrdAaKmdtL0Xo8tTTudFg0Bv17Xkj7
 y6qzcjaR+8RQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="184094639"
X-IronPort-AV: E=Sophos;i="5.77,381,1596524400"; d="scan'208";a="184094639"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2020 22:54:36 -0700
IronPort-SDR: 5Tffd1wZUIWzTy/OGZlh3NnLe7zm468cuuJ2C2AqSipVgv5jYuEDQxRzMqz6k6GzXr92ILpLRn
 iNyxbI/noYdQ==
X-IronPort-AV: E=Sophos;i="5.77,381,1596524400"; d="scan'208";a="464572789"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2020 22:54:34 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Jason Wang <jasowang@redhat.com>,
	qemu-dev <qemu-devel@nongnu.org>
Subject: [PATCH V2 00/10] COLO project queued patches 20-Oct
Date: Fri, 16 Oct 2020 13:51:58 +0800
Message-Id: <20201016055208.7969-1-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=192.55.52.88; envelope-from=chen.zhang@intel.com;
 helo=mga01.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 01:54:36
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, FROM_ADDR_WS=2.996,
 FROM_WSP_TRAIL=1, HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_HI=-5,
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
Cc: Derek Su <dereksu@qnap.com>, Zhang Chen <chen.zhang@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhang Chen <chen.zhang@intel.com>

Hi Jason, this series include latest COLO related patches.
please check and merge it.

Li Zhijian (2):
  colo-compare: fix missing compare_seq initialization
  colo-compare: check mark in mutual exclusion

Pan Nengyuan (1):
  net/filter-rewriter: destroy g_hash_table in colo_rewriter_cleanup

Rao, Lei (3):
  Optimize seq_sorter function for colo-compare
  Reduce the time of checkpoint for COLO
  Fix the qemu crash when guest shutdown in COLO mode

Zhang Chen (4):
  net/colo-compare.c: Fix compare_timeout format issue
  net/colo-compare.c: Change the timer clock type
  net/colo-compare.c: Add secondary old packet detection
  net/colo-compare.c: Increase default queued packet scan frequency

 migration/ram.c       | 14 ++++++++++-
 net/colo-compare.c    | 58 ++++++++++++++++++++++---------------------
 net/colo.c            |  5 +---
 net/filter-rewriter.c |  2 ++
 softmmu/vl.c          |  1 +
 5 files changed, 47 insertions(+), 33 deletions(-)

-- 
2.17.1


