Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D00C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 17:04:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02451206F5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 17:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h0l3U9Bm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02451206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyI9y-0005vB-6k
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 13:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=465c3c755=alistair.francis@wdc.com>)
 id 1jyI4k-0005yV-B8
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:58:38 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10302)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=465c3c755=alistair.francis@wdc.com>)
 id 1jyI4i-0002jR-Gs
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1595437116; x=1626973116;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wjZgWmbxiWOu+2b26iONQcOU3qvLXTQffE2z6wWEdj8=;
 b=h0l3U9BmVtHvyrQgFkQQ826Wf8oF5stpcbjn2fYotNN+ukVkcfgKHl5q
 ZirDBUkDlV59Vx5KFVllS7HaRQqsgB5/rx1udE23xSfDfNJnkQaVqEI0C
 5zr8iUCtwMUyXSoXDNRwpRwcMEpsS9he1pHQA8LMp8aW/jwGb4Dojph+0
 1cFQioz3wXw+vHa3lQUFmbQDIo+1mMEEOLD2xcK/BqLSqdmfwD6A13oyt
 96b++YDgx9aRJOzNf3uwaNJJKODGwut+AmbwDvREInUkAVF9IG/As8vhZ
 jzH1CjMFQ7Mu1LuOKL1C5Wuvk0kflcV8mJWW6+Q9rj2B45InBKpbL8JXl w==;
IronPort-SDR: 47UmbFsWVpltXSK67u4vkyGnZLfHLD5/Xp3Cvy4t1goQvsaurwBa4YoQySJn5zuiGggQ2qvDJp
 MkI/n7Vrxw8QWlOZ+ntmO2GXFZyquc/MzouAlzBP3d88ll39iq1gxpHN4Mj6uh4V8ANwCp1MVy
 7dPlYx1G1dIUXZm5asrXbzYJYgcb0UkjsSztJCbu+85f/iQmk8RNIlBBHfYIoYuTQJwiyTQ3ht
 AJooogJc9Kgfs4WQURJS9J49r+K9fsNznAgUKmWZf0Qu4ssr3AHSY2Zh3I2NNtPwVL+a2aQVqK
 Qaw=
X-IronPort-AV: E=Sophos;i="5.75,383,1589212800"; d="scan'208";a="252418637"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 23 Jul 2020 00:58:22 +0800
IronPort-SDR: Pak/mhMkpKhQd987pBUjTY2yJjYbier79RFYG/8W1TzQa27lwNVoE/3vmDMFVGoGTuFWP66Ded
 a/5bMVbfBsnc//+yanwaVVNXIIXde0yKY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2020 09:46:38 -0700
IronPort-SDR: 69Cyq7dqMU6gU5W9HJaRjo8woJJr5TB+hhXvxmKAA1GHzYdl5SXY7kQKXsGLFcs6MSJ5I4XXLA
 tyr21Upibrxg==
WDCIronportException: Internal
Received: from usa001575.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.115])
 by uls-op-cesaip02.wdc.com with ESMTP; 22 Jul 2020 09:58:22 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/5] hw/riscv: sifive_e: Correct debug block size
Date: Wed, 22 Jul 2020 09:48:37 -0700
Message-Id: <20200722164838.1591305-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722164838.1591305-1-alistair.francis@wdc.com>
References: <20200722164838.1591305-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=465c3c755=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 12:58:21
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
Cc: Bin Meng <bmeng.cn@gmail.com>, Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bmeng.cn@gmail.com>

Currently the debug region size is set to 0x100, but according to
FE310-G000 and FE310-G002 manuals:

  FE310-G000: 0x100 - 0xFFF
  FE310-G002: 0x0   - 0xFFF

Change the size to 0x1000 that applies to both.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <1594891856-15474-1-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_e.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 7bb97b463d..c8b060486a 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -54,7 +54,7 @@ static const struct MemmapEntry {
     hwaddr base;
     hwaddr size;
 } sifive_e_memmap[] = {
-    [SIFIVE_E_DEBUG] =    {        0x0,      0x100 },
+    [SIFIVE_E_DEBUG] =    {        0x0,     0x1000 },
     [SIFIVE_E_MROM] =     {     0x1000,     0x2000 },
     [SIFIVE_E_OTP] =      {    0x20000,     0x2000 },
     [SIFIVE_E_CLINT] =    {  0x2000000,    0x10000 },
-- 
2.27.0


