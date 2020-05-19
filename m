Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D054AC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 20:13:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A97B7207FB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 20:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97B7207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb8cO-000683-RL
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 16:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jb8bc-0004IG-TI
 for qemu-devel@nongnu.org; Tue, 19 May 2020 16:12:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:59949)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jb8bb-00089z-90
 for qemu-devel@nongnu.org; Tue, 19 May 2020 16:12:52 -0400
IronPort-SDR: YUCtJlXt6hOmYP2ZdU0XhbNqltjSBuSt4RPKhiWdKGUglgsUIGPqkQhx1PAONtWkJ6SwKOjwSh
 mWCue7cPvpNg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2020 13:12:40 -0700
IronPort-SDR: IHqP5eng41vaKlPqmdJTvWHwuBmlDArm4AmjjBcSD1bJc3kuUZn7g440DtFvyaHbXbvkez2F/a
 YyVlTgYH2aiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,410,1583222400"; d="scan'208";a="268007838"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by orsmga006.jf.intel.com with ESMTP; 19 May 2020 13:12:38 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Jason Wang <jasowang@redhat.com>
Subject: [PATCH 0/7] Latest COLO tree queued patches
Date: Wed, 20 May 2020 04:02:00 +0800
Message-Id: <20200519200207.17773-1-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=192.55.52.88; envelope-from=chen.zhang@intel.com;
 helo=mga01.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 16:12:40
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, FROM_ADDR_WS=2.999,
 FROM_WSP_TRAIL=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Hi Jason, this series include latest COLO related patches.
I have finish basic test and review.
If no other comments, please check and merge this series.

Derek Su (1):
  colo-compare: Fix memory leak in packet_enqueue()

Lukas Straub (6):
  net/colo-compare.c: Create event_bh with the right AioContext
  chardev/char.c: Use qemu_co_sleep_ns if in coroutine
  net/colo-compare.c: Fix deadlock in compare_chr_send
  net/colo-compare.c: Only hexdump packets if tracing is enabled
  net/colo-compare.c, softmmu/vl.c: Check that colo-compare is active
  net/colo-compare.c: Correct ordering in complete and finalize

 chardev/char.c     |   7 +-
 net/colo-compare.c | 277 +++++++++++++++++++++++++++++++++------------
 net/colo-compare.h |   1 +
 net/colo.c         |   7 ++
 net/colo.h         |   1 +
 net/trace-events   |   1 +
 softmmu/vl.c       |   2 +
 7 files changed, 225 insertions(+), 71 deletions(-)

-- 
2.17.1


