Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D933C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 04:28:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C3F022319
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 04:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3F022319
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWv7b-000745-J5
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 23:28:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qi1.zhang@intel.com>) id 1iWv6i-0006B3-PR
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 23:27:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qi1.zhang@intel.com>) id 1iWv6g-0002fG-UN
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 23:27:15 -0500
Received: from mga05.intel.com ([192.55.52.43]:34948)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qi1.zhang@intel.com>) id 1iWv6g-0002b7-Mn
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 23:27:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Nov 2019 20:27:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,322,1569308400"; d="scan'208";a="209068477"
Received: from a23004-02.sh.intel.com ([10.239.9.129])
 by orsmga003.jf.intel.com with ESMTP; 18 Nov 2019 20:27:03 -0800
From: qi1.zhang@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] TM field check failed
Date: Tue, 19 Nov 2019 20:27:00 +0800
Message-Id: <cover.1570503331.git.qi1.zhang@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
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
Cc: qi1.zhang@intel.com, ehabkost@redhat.com, mst@redhat.com,
 pbonzini@redhat.com, yadong.qi@intel.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Zhang, Qi" <qi1.zhang@intel.com>

spilt the reserved fields arrays and remove TM field from reserved 
 bits

Changelog V1:
 add descriptons
Changelog V2:
 refine

Zhang, Qi (2):
  intel_iommu: split the resevred fields arrays into two ones
  intel_iommu: TM field should not be in reserved bits

 hw/i386/intel_iommu.c          | 35 ++++++++++++++++++++--------------
 hw/i386/intel_iommu_internal.h | 17 +++++++++++++----
 2 files changed, 34 insertions(+), 18 deletions(-)

-- 
2.20.1


