Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA19C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 01:37:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0BEA20679
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 01:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pkkFp++b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0BEA20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52938 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd33h-0000Df-4N
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 21:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40870)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0651fb9a1=alistair.francis@wdc.com>)
 id 1hd307-0006cD-A0
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 21:33:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0651fb9a1=alistair.francis@wdc.com>)
 id 1hd306-0008Rg-9E
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 21:33:31 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:60676)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0651fb9a1=alistair.francis@wdc.com>)
 id 1hd305-0008My-Sb; Mon, 17 Jun 2019 21:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1560821610; x=1592357610;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cHdxWgwAn1Fa2k9YWEL6bbjXx/m3IzGg1kbVMyDLUYg=;
 b=pkkFp++bhIibAEiA/Phg7xVnPl6LW1U0ARF4O1VPeISdVaVciOBi6scm
 30uiJ3P02yvACzbs5tZKkvsDdP6gtlCYkFyuZKgJUN8K2nNDV0fdWHNJ9
 77SV1goaibVyQck/PEGMP9ifOjvMlgFOxVOJzSZyDJ0xBm1l2vl14YioB
 RRaU97kgTuLvvUU6z0xLrRvBKnX3XYHGRAT/yJ6UkchufsQCYN0+fCrnM
 oryjGJsIloknVLdj+rrxnCynWejrTAEBKq2vctIKUp3FJOyBLiWZFnaZu
 /X9iTzgT7O1jCt4ere0FakiMOXrzgUyKgpDQUiA4SWiaSJuFu75udJD32 w==;
X-IronPort-AV: E=Sophos;i="5.63,386,1557158400"; d="scan'208";a="115717014"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 09:33:26 +0800
IronPort-SDR: Q1vZTfuib2nLOuovSSZ6BOaoUqU0aO1BqkO7aRa05lnpDFSvAgPPyzYzabEM1eZq5hCeKekngY
 IXEYbgARaEcveCr0BZ3NpKtlF9a7DuwyeU4RGMfIQOQOGljQYp5cjtnQyU91e/MFS6uj9MCvC5
 Fg0zrcWPmgJAfGOXS7O1M/qiYhvo9HPscRURrbMvjlvxaYitQRqPBIxh/JxfywcokZAQSe8cXs
 2RPfyUsnOClU7miVZMqZxTh7/DT4ZRXFKAuufzixL9/tut71WywwZvXgK7wBKSPrriJM4CP8j5
 ohVowmGgfYVOpJAbcJsuK+Jn
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP; 17 Jun 2019 18:32:58 -0700
IronPort-SDR: LfiNOx31Jhh63yW/q+w6WpP7ijeCH9ZZgJWlMoX7n8z0ndOn/wjssnBF2I+55OhCMOu38Bzc7E
 g0ExqrDSvEuSikkOXVFChDG4sPUncjhZLM7Nl0J9LymJCVNNVKZTzIoPk0V4TLN/rqwdr/DYt+
 x1T5JhPtXiIUkf1AS89EmyNqAGX1dWsEhjrG7Zgo1tEFAfT/3M2nDfaPFFQgc75LArzocv8iQk
 xwTOiE0ZIfjl2yrI5sXiKrU30HnO8p1MNJFSeNfRMd4hlBnrkMJVuIYidT8g0Jw+//m7JNjkR6
 qM8=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 17 Jun 2019 18:33:26 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Mon, 17 Jun 2019 18:31:05 -0700
Message-Id: <88a6ea191c4ddc385f7ee1cdde58a27fcdc15855.1560821342.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1560821342.git.alistair.francis@wdc.com>
References: <cover.1560821342.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PATCH v1 2/9] target/riscv: Add the privledge spec
 version 1.11.0
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

Add support for the ratified RISC-V privledge spec.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h                             | 1 +
 target/riscv/insn_trans/trans_privileged.inc.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 1668d12018..4e58c3b856 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -81,6 +81,7 @@ enum {
 #define USER_VERSION_2_02_0 0x00020200
 #define PRIV_VERSION_1_09_1 0x00010901
 #define PRIV_VERSION_1_10_0 0x00011000
+#define PRIV_VERSION_1_11_0 0x00011100
 
 #define TRANSLATE_FAIL 1
 #define TRANSLATE_SUCCESS 0
diff --git a/target/riscv/insn_trans/trans_privileged.inc.c b/target/riscv/insn_trans/trans_privileged.inc.c
index 664d6ba3f2..c5e4b3e49a 100644
--- a/target/riscv/insn_trans/trans_privileged.inc.c
+++ b/target/riscv/insn_trans/trans_privileged.inc.c
@@ -90,7 +90,7 @@ static bool trans_wfi(DisasContext *ctx, arg_wfi *a)
 static bool trans_sfence_vma(DisasContext *ctx, arg_sfence_vma *a)
 {
 #ifndef CONFIG_USER_ONLY
-    if (ctx->priv_ver == PRIV_VERSION_1_10_0) {
+    if (ctx->priv_ver >= PRIV_VERSION_1_10_0) {
         gen_helper_tlb_flush(cpu_env);
         return true;
     }
-- 
2.22.0


