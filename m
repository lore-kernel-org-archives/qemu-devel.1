Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73766C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 21:41:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E864206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 21:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Vt/QbBP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E864206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyNUf-0004wy-1Y
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 17:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1236ab962=alistair.francis@wdc.com>)
 id 1hyNS7-0002z2-Gx
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 17:38:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1236ab962=alistair.francis@wdc.com>)
 id 1hyNS6-0006I1-AA
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 17:38:35 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54908)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1236ab962=alistair.francis@wdc.com>)
 id 1hyNS5-0006E6-QK; Thu, 15 Aug 2019 17:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1565905115; x=1597441115;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JH2/KzCxUZ/IlH6d53HOYIkrrIM66OuD6Zo3M2JGc0c=;
 b=Vt/QbBP8wlsaxfupL3eXMYEKg5eFq+1C5jGv1BDlZisCvmtp6Ybza3ZS
 rd2gH2dpe8Z0C9F3u384Pq9k0HJzgrZdMGpo/VmDxwBtD6xmn4o+DxgJz
 ZTjQydGXeZj3FziOc4DalhsLCqbMJauFRBr7QSTNafXIcvj5bnxWacKgi
 2NBF3WiEhxIGowMc4/+ZrSAaQSK0Hfkuka3jwfmFDpRguY23Wwihl/c2y
 FezaAciZNvAzcfY+6kf5qZdFP8dEhJsH8tZBbLD/NKCAKoVmPkqU4CSIt
 KRWe4IvsDYDzQmA9SwT55cgFfXeZcuIBKe15aPTkXsJxXQSb3qultu66/ A==;
IronPort-SDR: hPTW4t0CwQ28KEhadNeLRR1b4KdGHxPoYkM1vbhh+1woJ8YQtET3q4gqC5FuW2HOUNEOVJU/rX
 7plMT2184fCqq2cr/CmoiXw+HrK1IAG0peVt3kqWKnXPBNiOqkw1KeakDoeHlavkwJ3akB6Esl
 AMHb6bNxRpzDvFdY81sISP1gp7cuxRfs/TciVS8vBgoUMUPLs0v+7lcX4bUHC2+stUvf1ouLsW
 FNgQR4kwfJpdu3HT4jR+JO3gv8vmjarWgqUwvoLOe2mY2/8AR4YXmjaHiSgRdB0LITVSxfPiXa
 5qI=
X-IronPort-AV: E=Sophos;i="5.64,389,1559491200"; d="scan'208";a="116881536"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2019 05:38:30 +0800
IronPort-SDR: bmh2v6siYRrnbxUfcHxb3zT7u2Moj0nU8TP3CsQp2YbHAQpy5HEOANIyNjxrxEFxo4IgIyu2mF
 pT6IpRdhFNSzo0WGiQ+xu/PR9jiTsjGIPZ4341fTmaXGo3XLFU0hzbvke+Gpd0sWJ/6d2Gmg7H
 DVMXB8At5GXSMOakoGEk+DqM91EZ7hYaW1/fOCH7sxxcObseAUfEMrcnDQaRQb5tFqAxst/Vwn
 GP8teCJCfSyjzFHzu0P/qFteFZQtabZ5COdaa/ikFDJGfFnY5NG5jQSMo0CWHdHv3Ksnx7ZKPX
 ER+VrD92NRPnwh9As809kwuZ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2019 14:36:00 -0700
IronPort-SDR: oyBUCGt9ck7qhNkSKYabd2xBKnF0VAwdvrl3m6ME9/uBgeycfaVErUAmfqeelx6PMvs4EbeHsx
 q24O6hx43LEB2pc61hAUpIC/MZxgbiaAJUvyqkbYayw8yhtGAqENCPlfDIYdqMo+iC/1WGSUQ1
 W/QnuG5p1/YL078pzV1tdEaZirYKb/jWibtH1qCyb5YIyIsicExNW8QpFcygfj+cQXqAws3KQ6
 AW4gcVTCPFEPWwbKrtFbxI4gQ/n0wfaxZWzCBmfVbyY4FDcG7GHt8ckircY6Rag/VJVGmGXWuY
 xTI=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 15 Aug 2019 14:38:29 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Thu, 15 Aug 2019 14:35:01 -0700
Message-Id: <083ae70e31e202880ed8babf4de1a3c1ea27100b.1565904855.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1565904855.git.alistair.francis@wdc.com>
References: <cover.1565904855.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v3 6/7] target/riscv: Fix mstatus dirty mask
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
 target/riscv/csr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 2789215b5e..f767ad24be 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -335,7 +335,7 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
              * RV32: MPV and MTL are not in mstatus. The current plan is to
              * add them to mstatush. For now, we just don't support it.
              */
-            mask |= MSTATUS_MPP | MSTATUS_MPV;
+            mask |= MSTATUS_MTL | MSTATUS_MPV;
 #endif
     }
 
-- 
2.22.0


