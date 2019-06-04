Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480CAC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 10:07:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1211824C10
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 10:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1211824C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49685 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY6Lr-0001rw-14
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 06:07:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tina.zhang@intel.com>) id 1hY6J6-00083O-8I
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 06:04:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tina.zhang@intel.com>) id 1hY6J4-0000mp-BV
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 06:04:39 -0400
Received: from mga18.intel.com ([134.134.136.126]:33967)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tina.zhang@intel.com>)
	id 1hY6J4-0000aq-0b
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 06:04:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	04 Jun 2019 03:04:26 -0700
X-ExtLoop1: 1
Received: from gvt.bj.intel.com ([10.238.158.187])
	by orsmga007.jf.intel.com with ESMTP; 04 Jun 2019 03:04:23 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: intel-gvt-dev@lists.freedesktop.org,
	qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 17:58:44 +0800
Message-Id: <20190604095847.10532-1-tina.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.126
Subject: [Qemu-devel] [RFC PATCH 0/3] hw/display: Refresh UI depending on
 vGPU page flip events
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kevin.tian@intel.com, zhenyuw@linux.intel.com,
	Tina Zhang <tina.zhang@intel.com>, alex.williamson@redhat.com,
	zhiyuan.lv@intel.com, hang.yuan@intel.com, zhi.a.wang@intel.com,
	kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series shows the idea to refresh UI console depending on vGPU
page flip events.

Tina Zhang (3):
  vfio: Add a funtion to return a specific irq capabilities
  ui/console: Introduce two new APIs
  vfio/display: Refresh display depending on vGPU page flip events

 hw/vfio/common.c              |  78 +++++++++++
 hw/vfio/display.c             | 249 +++++++++++++++++++++++++++++-----
 include/hw/vfio/vfio-common.h |  11 ++
 include/ui/console.h          |   2 +
 ui/console.c                  |  35 +++++
 5 files changed, 343 insertions(+), 32 deletions(-)

-- 
2.17.1


