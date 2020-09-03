Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCDDC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:37:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEF472072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF472072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDpQe-0007vz-17
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 09:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FelixCui-oc@zhaoxin.com>)
 id 1kDmDB-00086Y-1v
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:11:21 -0400
Received: from [203.148.12.81] (port=45413 helo=ZXSHCAS1.zhaoxin.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <FelixCui-oc@zhaoxin.com>)
 id 1kDmD8-0006D1-NF
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:11:20 -0400
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 3 Sep 2020
 17:49:49 +0800
Received: from localhost.localdomain (124.64.16.12) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 3 Sep 2020
 17:49:48 +0800
From: FelixCuioc <FelixCui-oc@zhaoxin.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, 
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 0/1] Skip flatview_simplify() for specific cpu vendor
Date: Thu, 3 Sep 2020 05:49:34 -0400
Message-ID: <20200903094935.2361-1-FelixCui-oc@zhaoxin.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [124.64.16.12]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 203.148.12.81 (failed)
Received-SPF: pass client-ip=203.148.12.81;
 envelope-from=FelixCui-oc@zhaoxin.com; helo=ZXSHCAS1.zhaoxin.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 05:49:52
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 03 Sep 2020 09:34:31 -0400
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
Cc: TonyWWang-oc@zhaoxin.com, RockCui-oc@zhaoxin.com, qemu-devel@nongnu.org,
 CobeChen-oc@zhaoxin.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The reason we want to skip flatview_simplify() is
to prevent unnecessary IOVA address range mapping
from being unmapped.

The actual situation we encountered is:
When assign EHCI device to the virtual machine,
after initializing EHCI in seabios, it will continuously
send dma cycles.And EHCI dma buffer is allocated from
the range 0xd9000-0xexxxx belonging to zonelow.
But in seabios, make_bios_readonly_intel() will modify
the attributes in the range of 0xc0000-0x100000,except
for the zonelow range.
Before these ranges attributes are not changed,qemu will
perform flatview_simplify(),and the actual address range
formed in flatview is 0xc0000-0xbfffffff.When the properties
of this large range are modified to readonly,qemu will
unmap all the IOVA mappings in the address range 0xc0000-0xbfffffff.
But EHCI device still send dma cycle.

So dma cycles of the EHCI device will be blocked by the IOMMU.
And we want to skip flatview_simplify().

Error log when starting the virtual machine:
DMAR: [DMA Read] Request device [00:10.7] fault addr eb000 [fault reason 06] PTE Read access is not set
DMAR: [DMA Read] Request device [00:10.7] fault addr eb000 [fault reason 06] PTE Read access is not set

FelixCuioc (1):
  Skip flatview_simplify() for specific cpu vendor

 softmmu/memory.c  | 16 +++++++++++++++-
 target/i386/cpu.c |  8 ++++++++
 target/i386/cpu.h |  3 +++
 3 files changed, 26 insertions(+), 1 deletion(-)

-- 
2.17.1


