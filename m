Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71224C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 20:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 364C2206B6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 20:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OdNW0M3h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364C2206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqMnA-0000UQ-4t
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 16:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=44328bdba=alistair.francis@wdc.com>)
 id 1jqMl9-0005Zh-BW; Tue, 30 Jun 2020 16:21:39 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:36486)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=44328bdba=alistair.francis@wdc.com>)
 id 1jqMl6-0007ik-Ij; Tue, 30 Jun 2020 16:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593548497; x=1625084497;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oe/HJvqIrpe1Q963Js2YhP3t8Wj7CiObFT3VDk5z1o8=;
 b=OdNW0M3h2W97AAJjx1r0FA/WQLH6eetQ8M+M3ssFkIyIUHY0Zg6UDaVD
 wL/EIhUD1mU1Q2zisO+zCBLkCE4nXRkuaAkkNVxLTl3DJFhHWu44Aw8Bb
 ANaB9Hq11rMBzVzZoRLhaBdaetZhuUu+Qg6uIfM+wUdeJ9N9G8aTojUYn
 9UsKmyVUDjrIRcHdqIi7UC90EP0L7doQ6w4zFB2ecJNve340Fi9rlHBsm
 p52wqLnqQSOjVZxjxYWoykZjnxfFhkk8g8duvOMgsOfhKWKgXZSL0Z9SF
 9cETWzMi6N/uDgryzMg3d4zmeIHHvjyMXHcwanSYAmfqLUAvtjRBqCEn/ g==;
IronPort-SDR: 5MJgjR+SrZWiAq7SPVI4Y7b90JKLx+mEQGNjb1DVTyp4ZwaYlw+81smFZjFpptUiDUSGigfitF
 bIjmJxFzG9l0HnxxnIWhnovdHG5Z7TX28B7FQu9dqkDP38YsbebWKZQAB/EHFcBbJaAMsbCIZM
 +62DzCKVhsneFWE5zfJew7oJHgRhrneE/NtmXC83txftCtvUsiciR1/Mt5aemmi83rm4ExpGPG
 0c2SpmboIkx3E+DqRMWvbySqh8TxPpwqZpj4nTjEwqbN8rbxsAzoLd3XH0b05vQNvGXSlFdh1P
 YLg=
X-IronPort-AV: E=Sophos;i="5.75,298,1589212800"; d="scan'208";a="142665042"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2020 04:21:32 +0800
IronPort-SDR: HfWYZyXpBhM4GGljnyTaHw4G2RVBfcGmTGS7YJ7SZ6Qha2M2sNvBPWe4BfDGf6VkgZm8Vx823F
 38a66sgiNbYyM8ZwfYIiNI6cOYAIiKm+E=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2020 13:10:23 -0700
IronPort-SDR: oY5mkjpCir8lill1zcfNbQ4ehqRRe6RyKBb8gd+UYngMQzo3MUFrpLJP98J626ZKY06vmUqXkg
 N0pqtQk06FRQ==
WDCIronportException: Internal
Received: from us6fgspc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.109])
 by uls-op-cesaip02.wdc.com with ESMTP; 30 Jun 2020 13:21:31 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 3/3] target/riscv: Regen floating point rounding mode in
 dynamic mode
Date: Tue, 30 Jun 2020 13:12:13 -0700
Message-Id: <ea4f280e6f77e734c8e555e3c98d10085ce9f5b6.1593547870.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1593547870.git.alistair.francis@wdc.com>
References: <cover.1593547870.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=44328bdba=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 16:21:24
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When a guest specificies the the rounding mode should be dynamic 0b111
then we want to re-caclulate the rounding mode on each instruction. The
gen_helper_set_rounding_mode() function will correctly check the
rounding mode and handle a dynamic rounding, we just need to make sure
it's always called if dynamic rounding is selected.

Fixes: 1885350 ("RISCV dynamic rounding mode is not behaving correctly")
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index ce71ca7a92..a39eba679a 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -490,7 +490,7 @@ static void gen_set_rm(DisasContext *ctx, int rm)
 {
     TCGv_i32 t0;
 
-    if (ctx->frm == rm) {
+    if (ctx->frm == rm && rm != 7) {
         return;
     }
     ctx->frm = rm;
-- 
2.27.0


