Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFABC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 11:37:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B87552084C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 11:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87552084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTO3T-00066w-PJ
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 07:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FelixCui-oc@zhaoxin.com>)
 id 1kTO1x-00055t-9v
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 07:36:17 -0400
Received: from zxshcas1.zhaoxin.com ([203.148.12.81]:11749)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <FelixCui-oc@zhaoxin.com>)
 id 1kTO1s-0001At-J5
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 07:36:16 -0400
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 16 Oct
 2020 19:29:43 +0800
Received: from localhost.localdomain (124.64.17.66) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 16 Oct
 2020 19:29:41 +0800
From: FelixCuioc <FelixCui-oc@zhaoxin.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, 
 Eduardo Habkost <ehabkost@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: [PATCH 0/1] Skip flatview_simplify() for cpu vendor zhaoxin
Date: Fri, 16 Oct 2020 07:29:32 -0400
Message-ID: <20201016112933.14856-1-FelixCui-oc@zhaoxin.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [124.64.17.66]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Received-SPF: pass client-ip=203.148.12.81;
 envelope-from=FelixCui-oc@zhaoxin.com; helo=ZXSHCAS1.zhaoxin.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 07:29:44
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Cc: TonyWWang-oc@zhaoxin.com, RockCui-oc@zhaoxin.com, qemu-devel@nongnu.org,
 CobeChen-oc@zhaoxin.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The actual situation we encountered is:
When assign EHCI device to the virtual machine,
after initializing EHCI in seabios,it will continuously
send dma cycles.
After flatview_simplify(),the IOVA mappings of the
EHCI device will be innocently unmapped between the
delate and add phases of the VFIO MemoryListener.
But the EHCI device is always sending DMA cycle.
At this time,the IOMMU will block the DMA cycle.
The purpose of this patch is to skip flatview_simplify()
for zx vendor.

FelixCuioc (1):
  Skip flatview_simplify() for cpu vendor zhaoxin

 softmmu/memory.c  | 20 +++++++++++++++++++-
 target/i386/cpu.c |  7 +++++++
 target/i386/cpu.h |  3 +++
 3 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.17.1


