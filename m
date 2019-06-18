Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C68C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 01:42:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93862082C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 01:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WNctb61J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93862082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52998 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd38v-0006QU-4x
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 21:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41013)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0651fb9a1=alistair.francis@wdc.com>)
 id 1hd30H-0006sy-Da
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 21:33:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0651fb9a1=alistair.francis@wdc.com>)
 id 1hd30G-0000BX-CS
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 21:33:41 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:24430)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0651fb9a1=alistair.francis@wdc.com>)
 id 1hd30G-0000A1-1s; Mon, 17 Jun 2019 21:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1560821621; x=1592357621;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1DnzSt3sQDws/SE2q/bnTC49Un43YEdEs+g3y0l0KYg=;
 b=WNctb61J+9jHlFBAgYh955a4Ph0+0hfnoBpOThMXwwnnFb4ukPB3vLsY
 yjR3EokVYZk5fclcc4cpTQj8WvKj0Ez2jxd57Vvt/Cnr6wna8fRyC0jzb
 15tVyxIGZg25wO3L/pl6mfWFQuEtJ9I44wwCiZMkhMFR51AcnNnkRABLv
 U82kQtZ+QR0G6WD/L2vIrTsznmYFQZBDFwkHYPPs+O7ni1NeBqohnyYYx
 n96EIO9sE1dhRBxaAq/G+03avlcel2EGncONmGXflhLjYOBUJAhya1OZt
 dAlZHdb54cxTYF5+yPvGm7lld7hcMsRVzOz3TvLtvlrhv/JbqWPHnv7+Q g==;
X-IronPort-AV: E=Sophos;i="5.63,386,1557158400"; d="scan'208";a="112055101"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 09:33:38 +0800
IronPort-SDR: YBoaTcgeHuQmWtwjEceuKgQyr62f5QVv4gAALma4fWRDHiFiGuoesIcrltWCdHHWSmA54lt7Lw
 PP1PWZqnN5ErtDbspe0/Fur7dHKPVzbD2dTgQltA/HYtbvUdVI5F5p3CJV20HLRs+PjeMzOrmY
 0KI1mx0b39/eTnvPE3FXSt5cNMtxtMrW0xgY0JtyuNDAX02Tzqho3hm5i9KFEs/VC7o0vD4Xa4
 uI6DiMe/o2/I76+3Z/7EyAfXR2wC//jW2ORzvNsB3NeU+E6kBnbmTewwVUzyAf6YeMfFI17GaK
 m2VjdZo3XV7EfPzRMqqNw/ow
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP; 17 Jun 2019 18:33:07 -0700
IronPort-SDR: RS7siusuP5TGzbvWZZ2x2Mnk/ZZGiH2qzf91ExeyColmx7cSvCM/UFjSCxzQNojCLyEaC+nnCX
 idkYNfgS85CERjr4Ejc6POxMOo/flTPyg3HeXNLd8Hh+tqy0MT4Xb+x9CzDaGfHZ91dNu+sWDG
 u6Qq1twsya0N4qHTjNcskpM1Zgk1Q2PZajbeilxeU0/0sgAbH5BwXXZDsOOhB5nZU+zY7ytnBo
 Jw9UbVYgYjdqRC0hmZC2yM4ZFRwhrPKcupTOU64V/FmEvj0VfklKdWLgwmEn6OukMO0iDdNDrw
 hUQ=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip01.wdc.com with ESMTP; 17 Jun 2019 18:33:37 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Mon, 17 Jun 2019 18:31:16 -0700
Message-Id: <c22007097ef0d92ebaf9c642f2e38ac86c5c4013.1560821342.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1560821342.git.alistair.francis@wdc.com>
References: <cover.1560821342.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v1 6/9] target/riscv: Require either I or E
 base extension
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a23d83921a..21bfaa9722 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -373,6 +373,12 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
                        return;
        }
 
+        if (!cpu->cfg.ext_i && !cpu->cfg.ext_e) {
+            error_setg(errp,
+                       "Either I or E extension must be set");
+                       return;
+       }
+
        if (cpu->cfg.ext_g && !(cpu->cfg.ext_i & cpu->cfg.ext_m &
                                cpu->cfg.ext_a & cpu->cfg.ext_f &
                                cpu->cfg.ext_d)) {
-- 
2.22.0


