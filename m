Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD44CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:05:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 813002075B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813002075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBFj5-0005Ve-NA
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 07:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kBFhu-00047f-CE; Thu, 27 Aug 2020 07:04:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4277 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kBFhs-0007XT-2O; Thu, 27 Aug 2020 07:04:38 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id DF135EA6F33DC9342383;
 Thu, 27 Aug 2020 19:04:25 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Thu, 27 Aug 2020
 19:04:19 +0800
From: Chen Qun <kuhn.chenqun@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH v3 00/10] trivial patchs for static code analyzer fixes
Date: Thu, 27 Aug 2020 19:03:01 +0800
Message-ID: <20200827110311.164316-1-kuhn.chenqun@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=kuhn.chenqun@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:09:23
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
Cc: Chen Qun <kuhn.chenqun@huawei.com>, pannengyuan@huawei.com,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since v2:
- Patch1: Addressed Li Qiang review comment.
- Patch2: Addressed Peter Maydell and Li Qiang review comment.
- Patch3：Delete memleak commit message, and Addressed Peter Maydell
  review comment.
- Patch4: Addressed Peter Maydell review comment.
- Patch6: Addressed Li Qiang review comment.
- Patch7: Addressed Stefan Hajnoczi and Li Qiang review comment.
- Patch8: Addressed Markus Armbruster review comment.
- Patch9: Change default return value in exynos4210_combiner_read().

Chen Qun (10):
  hw/arm/virt-acpi-build:Remove dead assignment in build_madt()
  hw/arm/omap1:Remove redundant statement in omap_clkdsp_read()
  target/arm/translate-a64:Remove dead assignment in
    handle_scalar_simd_shli()
  target/arm/translate-a64:Remove redundant statement in
    disas_simd_two_reg_misc_fp16()
  hw/virtio/vhost-user:Remove dead assignment in scrub_shadow_regions()
  hw/net/virtio-net:Remove redundant statement in
    virtio_net_rsc_tcp_ctrl_check()
  vfio/platform: Remove dead assignment in vfio_intp_interrupt()
  usb/bus: Remove dead assignment in usb_get_fw_dev_path()
  hw/intc: fix default registers value in exynos4210_combiner_read()
  hw/display/vga:Remove redundant statement in vga_draw_graphic()

 hw/arm/omap1.c                | 1 -
 hw/arm/virt-acpi-build.c      | 3 +--
 hw/display/vga.c              | 1 -
 hw/intc/exynos4210_combiner.c | 1 -
 hw/net/virtio-net.c           | 1 -
 hw/usb/bus.c                  | 4 ++--
 hw/vfio/platform.c            | 2 +-
 hw/virtio/vhost-user.c        | 2 +-
 target/arm/translate-a64.c    | 7 ++-----
 9 files changed, 7 insertions(+), 15 deletions(-)

-- 
2.23.0


