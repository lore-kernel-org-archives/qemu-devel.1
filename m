Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B72C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 07:41:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E1820771
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 07:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E1820771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k67ri-0005jr-1s
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 03:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1k67p4-0008Gm-4L; Thu, 13 Aug 2020 03:38:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33548 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1k67p0-0001lI-Rr; Thu, 13 Aug 2020 03:38:49 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id D9554ACE0E4F1CCFC9E6;
 Thu, 13 Aug 2020 15:38:31 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Thu, 13 Aug 2020
 15:38:20 +0800
From: Chen Qun <kuhn.chenqun@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH 00/11] trivial patchs for static code analyzer fixes
Date: Thu, 13 Aug 2020 15:37:01 +0800
Message-ID: <20200813073712.4001404-1-kuhn.chenqun@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32;
 envelope-from=kuhn.chenqun@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 03:38:34
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
Cc: Chen Qun <kuhn.chenqun@huawei.com>, pannengyuan@huawei.com,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi All,
   This series fix trivial warnings reported by the Clang static code analyzer.

Chen Qun (11):
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
  tcg/optimize: Remove redundant statement in tcg_optimize()
  usb/bus: Remove dead assignment in usb_get_fw_dev_path()
  hw/intc: Remove redundant statement in exynos4210_combiner_read()
  hw/display/vga:Remove redundant statement in vga_draw_graphic()

 hw/arm/omap1.c                | 1 -
 hw/arm/virt-acpi-build.c      | 3 +--
 hw/display/vga.c              | 1 -
 hw/intc/exynos4210_combiner.c | 3 +--
 hw/net/virtio-net.c           | 1 -
 hw/usb/bus.c                  | 4 ++--
 hw/vfio/platform.c            | 2 +-
 hw/virtio/vhost-user.c        | 2 +-
 target/arm/translate-a64.c    | 7 ++-----
 tcg/optimize.c                | 1 -
 10 files changed, 8 insertions(+), 17 deletions(-)

-- 
2.23.0


