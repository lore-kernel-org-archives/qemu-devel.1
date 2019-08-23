Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A5CC3A5A2
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 00:11:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A19C20850
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 00:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DzUSDJtG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A19C20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1JeO-0005ez-Bb
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 20:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50039)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCi-0001ZG-6E
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCh-0000Rl-3O
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:48 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:60088)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCg-0000R2-PN; Fri, 23 Aug 2019 19:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566603766; x=1598139766;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=o2HTtI+4LKfm9DM09fPz6hUY5VIWzNwppTrYYS10GKc=;
 b=DzUSDJtGdbIFA0PnlTyrz6R0qhlzT67sDsS3wFXKZhmT25tas8k926t9
 AO0hJo7OlkgFXB/Av6LEIJDjGQhObnYE7ZyYFZzxWlmI21b7JPEcbg7nu
 kL4CZdIh7w4zfS28TE3TodVY7a3QkV0oHQQN+kLKBbfBELuuDjQtwHaoH
 YVaWbnxz6Ixd4jxseSZPxe/J0KbfBUwT4Wt32krPwuIrml92H5AkiBFDS
 OWYIYmOr33ppksB7bTa/SCLouXkNtsr45gPkcuWYEIOlykdYazZzD2gCQ
 8Pjx/Ttx5yfpff8dfZMhwYLd75LC+PXx9/FQJNdqdII0+aN3gjDlgX3E+ g==;
IronPort-SDR: BcRfKT71rd6/QYkvPj6GzquI9fKViLtSj4gInY1/ufQ/NUQFOSnzuYdukS4a5bjb0HWJnFp1VP
 2/f+BNKgKGr8hoKBS6swX/eUFTZlW8fl4B1+nrf1JdbiyzfW9IqsZSY6qrdZm7TTPy5tW9X0ll
 IEbriFS+UesdPBmxaBfPH39aV8cKaIiYrSHFkspASQL53d21lmlyhkda4qlu+xkm2Ni6kpixX2
 fseHLXOguuQkGNSOAF6iSxdp/fSmbrB8SAWxLjNjdSl6r896W7m0zdMb0hen13PuzfCytVqA3C
 F8U=
X-IronPort-AV: E=Sophos;i="5.64,422,1559491200"; d="scan'208";a="223175147"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2019 07:42:43 +0800
IronPort-SDR: GVRANIszS/aHv/mG6QESlzRBSJlPelnOSonJB4uCKvyxC+bAHwefbOOWYPMFXc5vIjCLWh9GW7
 ERZZQt1l4QfJpaOEvtM9rhmPzZR5CCrCNFpLN7t+n9a0TLzQ75lfZ5Ssi6ygNUrJj1j7Ee8tsQ
 2i9he7azA3QWZSkrxh0BXki5JYhK3wc5SRqABh1LC19+8aIS3e8rstybtOlDOMRFXocbN6aPqy
 VZVaBBS8lBB3QpeHvDrOGTPogaNwktC+h4o31lVyApyDJenQYbpbogccgFgcC5FwLk5PMN7BOZ
 lJ7ED7yhbg/asEpp6F59Vow+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 16:40:01 -0700
IronPort-SDR: 17qSDkOpB9QBQxWDRiMg4LRpEvOyGEAVgAmwbugyAoUKeKCVVYI5qXcqCQHla05A1cxLoix/pO
 P1eAmvMj6nXov637PweCWlIKyRhpe+9NfPe3EUDNd20V/G9L4qIibchfwdBiQZQKiQ6RyPJLtc
 YUgbfFFYVxB1CZZMZxPCbJyO6oq6VGnfM3uRvktQiyljVr94VxU2n8sv0zQLUf5YfU1JGcuysk
 DUgO1WCe9vQKgjvjc44+61xwH9A9gmpM03UPUVar2hRurl2Vu7qNrQ9RxX5MWqWSN34k11vxXR
 Z4k=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 16:42:43 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 23 Aug 2019 16:39:03 -0700
Message-Id: <8dae4338c8938696dfcecee6e736f6b09cc82877.1566603412.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566603412.git.alistair.francis@wdc.com>
References: <cover.1566603412.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.141.245
Subject: [Qemu-devel] [PATCH v1 28/28] target/riscv: Allow enabling the
 Hypervisor extension
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
Cc: alistair23@gmail.com, Anup.Patel@wdc.com, palmer@sifive.com,
 alistair.francis@wdc.com, Atish.Patra@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 5 +++++
 target/riscv/cpu.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 06ee551ebe..39e1c130df 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -447,6 +447,9 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         if (cpu->cfg.ext_u) {
             target_misa |= RVU;
         }
+        if (cpu->cfg.ext_h) {
+            target_misa |= RVH;
+        }
 
         set_misa(env, RVXLEN | target_misa);
     }
@@ -493,6 +496,8 @@ static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("c", RISCVCPU, cfg.ext_c, true),
     DEFINE_PROP_BOOL("s", RISCVCPU, cfg.ext_s, true),
     DEFINE_PROP_BOOL("u", RISCVCPU, cfg.ext_u, true),
+    /* This is experimental so mark with 'x-' */
+    DEFINE_PROP_BOOL("x-h", RISCVCPU, cfg.ext_h, false),
     DEFINE_PROP_BOOL("Counters", RISCVCPU, cfg.ext_counters, true),
     DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
     DEFINE_PROP_BOOL("Zicsr", RISCVCPU, cfg.ext_icsr, true),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b63f1f3cdc..500496a3be 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -268,6 +268,7 @@ typedef struct RISCVCPU {
         bool ext_c;
         bool ext_s;
         bool ext_u;
+        bool ext_h;
         bool ext_counters;
         bool ext_ifencei;
         bool ext_icsr;
-- 
2.22.0


