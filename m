Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50ABC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 15:26:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B062620866
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 15:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YgZYuALr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B062620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6bb5-0006Rz-UY
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 11:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4887bfbec=alistair.francis@wdc.com>)
 id 1k6bQW-0003ob-GC
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 11:15:28 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:2504)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4887bfbec=alistair.francis@wdc.com>)
 id 1k6bQU-0007f7-Cm
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 11:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597418126; x=1628954126;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uwlOCs0TigAYqcOkVWOmrQqtoKu/av8RoK/zaQpBVm0=;
 b=YgZYuALr+/wlQJrKCfGTUgCzjAGXgoFxnCBTRJmAG+ltjb6eLE+tL0U8
 04cdTmoBK+41x8wOTOvb0Y+JLGCxYDQFLMKbxT6hs1IxqfT/nBX1EcPoz
 rCmJeOpkWQhZ/+mpkfX1vhYgQvXkAkG4DIWvxJlHp2Q7HKwmZ3XzeUwpc
 aKEUeC6k6mER60A4zW7C7YovlZZShH/0682atiAVryXUFZqyFO0aE/xr3
 /mCfuzG46CJS3X4BDIzoNm3/Kh4ustZjBV0PlbbD6TYVPsh5TBt3NTuTl
 Mi+OQESyXUsAPS0JUl48zxmIh+Aky33jpDK5GnoagFr+xhL1l4SahaIId w==;
IronPort-SDR: kkp9At/CivIis9aRj8UFZgq5T8pJCgULQ9wzrXJ1NF4fwSLYFw8zMY5TPpme7T3b3AOqRqH0nw
 aIRFNzYjQ5jaQb/8uJC1NRllfGbiSwoQQTtuOZke4n4LebYEZDIw67qbHl5Zmf+mzO0yrMojSZ
 tTjk2PfkJOvte0tYNSgap97/HhgR8oHfUZ2etFad0dJEUzeylwsNTbEGS7gXkXV33XdkBYFwq6
 MxDcKTkKNu/Reuu9EQHcBjWgdx9fFxy5Wrw5/RB+kND1zdVYIg4VwKzTnT8/0eh1R10gxTXcWl
 Sco=
X-IronPort-AV: E=Sophos;i="5.76,312,1592841600"; d="scan'208";a="254369417"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 14 Aug 2020 23:15:16 +0800
IronPort-SDR: i/5vfE+G3Oqu884aydmtwgm+vCdaMY9Zqz8BU92bOsXGBngVxfEKiHN+3R6k0u9ayg006RG3R2
 bbKbXqBr5mZA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2020 08:02:21 -0700
IronPort-SDR: nQvCyNy1oYTod22czV3ViLsaufu7XLwG5FsXnQTvtCa50spc+S0ePO4YvFGZz+j2XUGoIQLcPw
 QEqO01wiohFw==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip02.wdc.com with ESMTP; 14 Aug 2020 08:15:16 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 18/20] hw/intc: ibex_plic: Update the pending irqs
Date: Fri, 14 Aug 2020 08:05:04 -0700
Message-Id: <20200814150506.2070566-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814150506.2070566-1-alistair.francis@wdc.com>
References: <20200814150506.2070566-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=4887bfbec=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 11:15:16
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Jessica Clarke <jrtc27@jrtc27.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After a claim or a priority change we need to update the pending
interrupts. This is based on the same patch for the SiFive PLIC:
55765822804f5a58594e "riscv: plic: Add a couple of mising
sifive_plic_update calls"

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: Jessica Clarke <jrtc27@jrtc27.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <0693aa700a4c67c49b3f1c973a82b257fdb7198d.1595655188.git.alistair.francis@wdc.com>
---
 hw/intc/ibex_plic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/intc/ibex_plic.c b/hw/intc/ibex_plic.c
index 41079518c6..578edd2ce0 100644
--- a/hw/intc/ibex_plic.c
+++ b/hw/intc/ibex_plic.c
@@ -121,6 +121,9 @@ static uint64_t ibex_plic_read(void *opaque, hwaddr addr,
         s->pending[pending_num] &= ~(1 << (s->claim % 32));
 
         ret = s->claim;
+
+        /* Update the interrupt status after the claim */
+        ibex_plic_update(s);
     }
 
     return ret;
@@ -140,6 +143,7 @@ static void ibex_plic_write(void *opaque, hwaddr addr,
     } else if (addr_between(addr, s->priority_base, s->priority_num)) {
         uint32_t irq = ((addr - s->priority_base) >> 2) + 1;
         s->priority[irq] = value & 7;
+        ibex_plic_update(s);
     } else if (addr_between(addr, s->enable_base, s->enable_num)) {
         uint32_t enable_reg = (addr - s->enable_base) / 4;
 
-- 
2.27.0


