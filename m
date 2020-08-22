Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7F7C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 06:05:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 433E120724
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 06:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VFTKHGy4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433E120724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9Mec-0001q7-Gq
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 02:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49637c5a7=alistair.francis@wdc.com>)
 id 1k9MRV-0002bR-IT
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 01:51:53 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:26625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49637c5a7=alistair.francis@wdc.com>)
 id 1k9MRT-0000Cq-M8
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 01:51:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598075512; x=1629611512;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nDU0ucglyQOD3O+MqHmAaIqeWfVvTD7vfgBn1X4KOto=;
 b=VFTKHGy4KtN/snW9krha7VVLugYraLkw/2E2EyyQV6DhHz4U0cBT49Er
 BGBa9U7c64IR/Q9wrKwrkiIIf3yuhDFmpNDaAL7jkeccPh+W45Cn07W13
 9QoKNrVYd5kB5jX9b15RGI52ksRuXnYIg05WP4zEG58Oyi4GMyKHXaGNR
 orbgrx8dfTyNEZ78peuJe7D39eekXoZt3siFbcjEvQdq34DeAf0mKR/GR
 S2GSbCxc5Sl/5XIvMuy7UVkbXxm8caWgowIxlyGWz1V7vXgBt29UX4oNb
 J/olut1Vg6Wa4miB/Z8j4Ro5YSpyp9uylLfDdihB8I635iN3O68eBTf1D Q==;
IronPort-SDR: Xg92Ib2all/e8CvFe/8Nsh8D1JdlKBMYsrepZGsvGI6WrjW8UnD6OzjgrwUaWQrELo0E7x8JmA
 IBd9bU1QLBam52uNZ3F6jC/1zErnrvH7BxeRcJ7k5O4CFesV52lQZ8v8t/9whrnYLbjQE3tYva
 eNv2jeEumx/Loi8L60RgBa3dWRhY1EpMN6s5XBFILCkD8lDqw7yx56Qmy+Uc9D8OZKWLVWOb80
 97XW3ViR3HaMXcuJbFe61NjlUL7fc+vJtj7QMG55HWK76a1n7iQ6kv0yciXRlCF/xmiAJBUwf4
 ILQ=
X-IronPort-AV: E=Sophos;i="5.76,339,1592841600"; d="scan'208";a="145571971"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2020 13:51:21 +0800
IronPort-SDR: dD/0HY383wyf169aG35AxPtyJYmY1BaywWpBHYWmaRi8A6UpYW6ZDLKD8CpkfUtcQhrm3EWAXN
 3dFDv4vWhAlA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2020 22:39:01 -0700
IronPort-SDR: IoS6dcUFN3THfHjyK5PNkf31OMCcmwPHg5TAtGnYmlGDEqJZ+sqHeERpwz4s/3kQKQu3nwMDkb
 GZR41Eg3xf9A==
WDCIronportException: Internal
Received: from 5zn13g2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.90])
 by uls-op-cesaip02.wdc.com with ESMTP; 21 Aug 2020 22:51:22 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 18/20] hw/intc: ibex_plic: Update the pending irqs
Date: Fri, 21 Aug 2020 22:40:59 -0700
Message-Id: <20200822054101.1202175-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200822054101.1202175-1-alistair.francis@wdc.com>
References: <20200822054101.1202175-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=49637c5a7=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/22 01:43:18
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
Cc: alistair23@gmail.com, alistair.francis@wdc.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jessica Clarke <jrtc27@jrtc27.com>
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
2.28.0


