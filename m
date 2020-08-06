Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98606C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 03:58:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65F672084D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 03:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F672084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3X2t-0008Mn-Id
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 23:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1k3X2C-0007Rv-D4
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 23:57:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38798 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1k3X2A-0001P7-4Z
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 23:57:40 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 9F04CE14A2174A48224B;
 Thu,  6 Aug 2020 11:57:26 +0800 (CST)
Received: from localhost (10.174.185.104) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Thu, 6 Aug 2020
 11:57:18 +0800
From: Ying Fang <fangying1@huawei.com>
To: <qemu-devel@nongnu.org>, <imammedo@redhat.com>, <mst@redhat.com>
Subject: [PATCH v5 0/2] add new options to set smbios type 4 fields
Date: Thu, 6 Aug 2020 11:56:32 +0800
Message-ID: <20200806035634.376-1-fangying1@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.185.104]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=fangying1@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 23:57:27
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
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
Cc: lvivier@redhat.com, alex.chen@huawei.com, philmd@redhat.com,
 zhang.zhanghailiang@huawei.com, fangying <fangying1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: fangying <fangying1@huawei.com>

Hi, this patchset was previously posted by my teamate Heyi Guo several
months ago, however we missed the merge window. It is reposted here to
make it an end. Thanks.

Patch description:
 
Common VM users sometimes care about CPU speed, so we add two new
options to allow VM vendors to present CPU speed to their users.
Normally these information can be fetched from host smbios.

Strictly speaking, the "max speed" and "current speed" in type 4
are not really for the max speed and current speed of processor, for
"max speed" identifies a capability of the system, and "current speed"
identifies the processor's speed at boot (see smbios spec), but some
applications do not tell the differences.

Changelog:

v4 -> v5:
- Rebase patch for lastest upstream

v3 -> v4:
- Fix the default value when not specifying "-smbios type=4" option;
it would be 0 instead of 2000 in previous versions
- Use uint64_t type to check value overflow
- Add test case to check smbios type 4 CPU speed
- v4 https://patchwork.kernel.org/cover/11444635/

v2 -> v3:
- Refine comments per Igor's suggestion.

v1 -> v2:
- change "_" in option names to "-"
- check if option value is too large to fit in SMBIOS type 4 speed
fields.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>

Ying Fang (2):
  hw/smbios: add options for type 4 max-speed and current-speed
  tests/bios-tables-test: add smbios cpu speed test

 hw/smbios/smbios.c       | 36 ++++++++++++++++++++++++++++++----
 qemu-options.hx          |  2 +-
 tests/bios-tables-test.c | 42 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 5 deletions(-)

-- 
2.23.0


