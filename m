Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C42C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 04:01:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF277214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 04:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF277214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQNcu-0007Zs-Q7
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 00:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36576 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wei.w.wang@intel.com>) id 1jQNcF-00073U-Fe
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 00:01:03 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <wei.w.wang@intel.com>) id 1jQNcD-0000iq-Hl
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 00:01:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:39943)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1jQNcC-0000bQ-UK
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 00:01:01 -0400
IronPort-SDR: ifL10P3UZUPL+mb/QdVRXpJzjelveP6d/+zykw4phOMjAztqqFS5Dj3+gKlvey812hF5GLVmjw
 g7peStOKmzwQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2020 21:00:53 -0700
IronPort-SDR: a1oBbC/UOtemDJnn5RMpeqRX5Sj8OmeTcYK/LIssgL+9mOf9KP7AbVtobZTOVOakuQabPZTfJ6
 JtzPjAGMYWUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,405,1580803200"; d="scan'208";a="333790694"
Received: from unknown (HELO devel-ww.sh.intel.com) ([10.239.48.118])
 by orsmga001.jf.intel.com with ESMTP; 19 Apr 2020 21:00:51 -0700
From: Wei Wang <wei.w.wang@intel.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, dgilbert@redhat.com,
 peterx@redhat.com
Subject: [PATCH v1 0/2] Migration xbzrle changes
Date: Mon, 20 Apr 2020 11:06:41 +0800
Message-Id: <1587352003-3312-1-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
Received-SPF: pass client-ip=134.134.136.24; envelope-from=wei.w.wang@intel.com;
 helo=mga09.intel.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 00:00:54
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 134.134.136.24
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
Cc: gloryxiao@tencent.com, kevin.tian@intel.com, wei.w.wang@intel.com,
 yi.y.sun@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patches change/add some xbzrle statistics to give users some useful
feedbacks about the delta operations.

Wei Wang (2):
  migration/xbzrle: replace transferred xbzrle bytes with encoded bytes
  migration/xbzrle: add encoding rate

 migration/migration.c |  3 ++-
 migration/ram.c       | 49 +++++++++++++++++++++++++++++++++----------
 monitor/hmp-cmds.c    |  6 ++++--
 qapi/migration.json   | 11 ++++++----
 slirp                 |  2 +-
 5 files changed, 52 insertions(+), 19 deletions(-)

-- 
2.20.1


