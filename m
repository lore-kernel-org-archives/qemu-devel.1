Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61520C33CB7
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:16:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2785B206F0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rty22U2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2785B206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixhOC-0004gF-9B
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 20:16:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhH4-00016p-2T
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:08:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhH3-0006DG-05
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:08:37 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17129)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhH2-00069K-MM; Fri, 31 Jan 2020 20:08:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580519316; x=1612055316;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NaQyl9TejrG1PIkqOwhTth+GsoVfdYSSLyrBaoAGPZs=;
 b=rty22U2D6k0awQAVxIUTJKmR5vqHmiXiM3TFFTV45dQDdaLA+TSHT+dU
 WROaEFwvnrlbKuIOU0kOk4Ba/9v7tai+lwY1owk7p4iF5XcL9EWeKeFcs
 kXfTb55c/5r3UJ1SYF07EUeqW0iWCKdfpAi/sCSRW43JNxu09EQETYQuX
 InpJmj3kCcmtVzGwP6LdPTtIbTjo69o2DkqemN6J+OEnVjFtifTE1FT4Q
 PF1jUp6GgFClDL6rSCgX++yHDawHKXfyC9ocZ1G0jLnHQ5GHkNvkvsGja
 UCxgmKqRW1Ny43BuBVVFwMwFFG4unrQ/Z8geN7UKrB3sDku7C33f4O6wi g==;
IronPort-SDR: qxRq72Lbk8v+kyvdNPbnhsLoaT2WBIAZvnEb7JKXKaNoRQXeb7XZSo4DbdYceSR4szf7hg/PwM
 lhXFKdq025Nr/DaBZ8H8bBPCOgr/gowc+Lou3xdJ7VVXxyqUC/ZvWrDHIcKDrDewJohAVFmM/N
 CSS0WEi+gqyOkLWWUx49XJtNADdOStwVveBVG57kQBE2HE9W0JckV2H1gch1HZih+EmRqa2wf5
 cV5citXS/+aGgZ3J8XqQ+Iy2OT+rmErP1TUeZ5JP1zRAlY6z0Wbx4bE5piDS+xdCg/Um5pBQqt
 c9A=
X-IronPort-AV: E=Sophos;i="5.70,388,1574092800"; d="scan'208";a="128872427"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2020 09:08:35 +0800
IronPort-SDR: Q3tNeCmW15mC5eHAxvJsvbshVuyvy/bzYLPBw/tqRw/zDoeAmyrBDVaX4FR7rguD4bfilZKPNC
 6vBNPIbcMOXMw2hnuWO+KobJx4KjmPeSeeih+roBbhyxg6bnEuDBlo4OCof1MIuQS6XavT3iCF
 56v7SIN0KHb31o6CNgxLFXpeRRUk6THhFDEpxXN559+/Hq5uQhWiFDRQU2OE1xQb3NFu/4+kty
 NFumkQHWJ9UTdGWpCSgDL1u51rABFbhHido+lipLaLep2ZnUrlqh8avbOK9tp9piy4OvFIIUVx
 SyrGTOF3M4sggavEVcw6gsdZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 17:01:44 -0800
IronPort-SDR: muiTzIm4QTnPJYD1EBSURe4sHDPC0n2wGUrYbiH0Y5J7/PyWueStEkul0U+EebsRTk14CZSHb4
 AJfLFJ0Hjve1gbZ4sQof0q7f8AqayVBKIMi946pIHi/MMqH3tFG0M/mNfVZw26wnsO+ZGVvFme
 btwQxc9/kOjmXzKR5x5x9vYS+ZyoSDgE7c2cU/rsmYg5FRxgQUKeDz02taMYPphg0UvnN5xrOe
 dckadRf/QEJhAuhLBbYUKf3y/0nc4GBeIbAYpuS1/6v96AyOA56Bc0bzI6TjU8ILhuahJY+/bh
 uis=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Jan 2020 17:08:36 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 09/35] target/riscv: Print priv and virt in disas log
Date: Fri, 31 Jan 2020 17:01:59 -0800
Message-Id: <30e4366934ba648c0a46b46fb406d32d66cc1734.1580518859.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580518859.git.alistair.francis@wdc.com>
References: <cover.1580518859.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.42
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/translate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 14dc71156b..afa2d6eea2 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -808,7 +808,15 @@ static void riscv_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
 
 static void riscv_tr_disas_log(const DisasContextBase *dcbase, CPUState *cpu)
 {
+#ifndef CONFIG_USER_ONLY
+    RISCVCPU *rvcpu = RISCV_CPU(cpu);
+    CPURISCVState *env = &rvcpu->env;
+#endif
+
     qemu_log("IN: %s\n", lookup_symbol(dcbase->pc_first));
+#ifndef CONFIG_USER_ONLY
+    qemu_log("Priv: "TARGET_FMT_ld"; Virt: "TARGET_FMT_ld"\n", env->priv, env->virt);
+#endif
     log_target_disas(cpu, dcbase->pc_first, dcbase->tb->size);
 }
 
-- 
2.25.0


