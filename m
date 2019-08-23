Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE30C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:31:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A53921848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="k98NNE0q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A53921848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1BX7-0007to-Cb
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1BR2-0001oX-P7
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:25:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1BR1-0000Cd-L6
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:25:04 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:38180)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1BR1-00006k-9b; Fri, 23 Aug 2019 11:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566573903; x=1598109903;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pAzFSx0tx0Pz0MS9Z/42V+0LphUR85f4qQbToNZTkdc=;
 b=k98NNE0qXUuJj0NFDbqvh7g5fo6qyw7YFl3jViuyUkEX8/7SkbKOKekV
 jcTPErQCK+3R5Ck7dRZWVhCKrICoDJ3d1dZTiFUWTtt1VlidLgAi3ht+H
 zZKA2FdklxZMten3qSFkf3PZizZ/cTRJyIkJe1IzmAZ63BFUwqP+qd8bZ
 5LjFRrRJgL7+khskSHUc6xlWE0rrDvBJnFu/pEJzL7B8rYCXAaT7JRwM1
 SzF8AD5gEsxIs/UPZq23rjzqrXOB9CFhDrvXUuuk4erHPkAIPsIV0u74V
 pcL9nKjySP8NerbYxb1ORM7zL67gKnjm7LCWE79M59/BgCqfGlsoKEQSS Q==;
IronPort-SDR: A/LuUD23Jafu94qqJaW0J++vDMA/L04/HmjqQDVuQbxZl5HcHoFDHTGrsdqlG85sgYn+w+aiFO
 +3+UnDD6n1LF1Cb9/Uk9+Ay1cCIaz1RLhX4iNbWCySVPShoHzwgZLdCAd2230zwqNdiQtXNf2F
 Kkie9p5FIUtEcO+4QgSqc7oerpBMQTHUM6E1WfFtMzC3PoECh+dBbVoqyk6Q801jMYhVtpUvXN
 o3aMGA4Nvl2xSVNmNnSsKHIFpEbM13y9jY+xEaIM3UK5CD9IY967deUND9NinZHmXh2cEPVl9f
 RpE=
X-IronPort-AV: E=Sophos;i="5.64,421,1559491200"; d="scan'208";a="121112436"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 23:25:02 +0800
IronPort-SDR: OGKpyOQoRx/fDALeBA8agT5/oMAinEoT5SoNdZKGF+Ed0O9hAJPsSp3hnzvoAn7lx1URm3YbeI
 5Uy4vntw6lKDmLoJ1mKGwA7vDsrMFFHX02bFmVHcqEPv7tn4ZS8Bzbz8RtTyh/mCg93+Ln/g2A
 TS8UBhTdcJCf1NSntGUVSTRnEt9Dyx5AXh52Kl0o4JR6nKA0Zok2P69xkZoWWIS6w0ZjG9qFHp
 NaQb7+25Zy23AqdLHXYOKn2jaVJ/Rq+VlDHV5Lx0us77img42bn80F4F/u5isV+r0wO/GYgoh6
 JDjOwpgHfapAWZxjZjIp/q7m
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 08:22:20 -0700
IronPort-SDR: EwS7PAfNKiwm/tvCripTUaMpPp7m7IH/tbJs8WCFr7YIUSYj33fQketA+iXOOR1WzB3n2oVjlg
 Y+CtacpxEKBJysuC7soZxg2Yg22sttJDXdFx21WQSIDvkR1Nk620W3Tqmp3qmEpuLm/upUVR3l
 rUqaLgSEH+R/zxYfSrKUMzfV37e3gj1xsxcB/jb6o86/cFN33BqLcEQ7BGZndsc4qucTvw4tyA
 JXNMpGgekcq5NznnZH5TJTMWe1cng4pAu6GKQ12TneAcsktbDBQc1AeRrWLMc8IyR1FljoPZot
 CuQ=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 08:25:03 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 23 Aug 2019 08:21:22 -0700
Message-Id: <0b18d5784d392d315bc0c6df8b7c258022f1f6d5.1566573576.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566573576.git.alistair.francis@wdc.com>
References: <cover.1566573576.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PATCH v4 6/7] target/riscv: Fix mstatus dirty mask
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com,
 bmeng.cn@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
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


