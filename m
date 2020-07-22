Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BA1C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:37:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D99282065F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JZK7Y+pf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99282065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyBBp-0003vC-4M
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAuR-0001M1-Ud
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:19:31 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:45293)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAuO-0005aS-Oz
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:19:31 -0400
Received: by mail-pl1-x62f.google.com with SMTP id k4so640086pld.12
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=KVxDKWjVz4Zva3Fp7UMB08Qi7DJsUHimuZ64cCy4XnY=;
 b=JZK7Y+pfOh8yngq0TbgvuFfgfKD+Sg7AQrPHLENBc+IhCDBCbMmfOQM857Jog/ZbFk
 SOyJv4hUChr2TN4HMAGTyZfw7ObNXsfw+Ut6GZFfoVpJxr2+HuzR6VCbqJlgbNn5BE6S
 3E9r8j+96nv2huJFjvKiBrJUBXHoT/ALBK0vhMwE/PTZq13LfJBnjSfoVG3/rdvTescQ
 5SWho/ZoTZy0WWnPDkk4ToI8ZitNnr1FZ1XdP2/ZqEJ7aj0+ydegKIBK3Kp4K7GGe7lU
 EioT/UGox3osB8HhUbxzDiA57CZS7FRu2rITCYyGaCeAB3F5crWIvdAzAQOt08N4Ie8Q
 FZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=KVxDKWjVz4Zva3Fp7UMB08Qi7DJsUHimuZ64cCy4XnY=;
 b=fCsJcIJPLF0R/uII/7Q9vmEkzoHCgTlyQYgqGcFrKxr9VQJKP6NNtvlSPowh+fkUXN
 QQdpQ1uxn4i9dm0NpYJ7BC7tY3tktsH8uWC6DWDGmhV0SZWK3yQJY2bWB0rwnghSaH0I
 eNWGL9D8ScDoL9F8EN7QFiJtTLhJSCQTH9x4fbEEUbKZ/veVYiQdeZzF9g+Gvv5tOB6j
 6zy8ssIqgHpigfC5psbeU9+GIh0sAu23embcvlnrtISLftsmIwo0y4GReYAnFvLOhLf1
 ZBYdyN/VAa/KOUzVbYUGccB4Foc1Ghf01wWK2YVTxfER/dF2/QzpbHKEBcbPhB6lj22z
 isPQ==
X-Gm-Message-State: AOAM530oBV3u+UolcgsbM93zTPQDtfiJoerubZnYikhb3Nplff/FRJ4N
 ASmU6c+2A713uYMSBQXoxMaNuy/XViY=
X-Google-Smtp-Source: ABdhPJzkcUJ/gf6K/luE6VAk06t1JXREvSK6wxGXIyJpevc+8ZzYRcgN3ogWmad8CPxAcru3eJwwCw==
X-Received: by 2002:a17:90b:3114:: with SMTP id
 gc20mr8473742pjb.233.1595409566851; 
 Wed, 22 Jul 2020 02:19:26 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:19:26 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 26/76] target/riscv: rvv-0.9: amo operations
Date: Wed, 22 Jul 2020 17:15:49 +0800
Message-Id: <20200722091641.8834-27-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Frank Chang <frank.chang@sifive.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/helper.h                   | 100 ++++++++---
 target/riscv/insn32-64.decode           |  18 +-
 target/riscv/insn32.decode              |  36 +++-
 target/riscv/insn_trans/trans_rvv.inc.c | 212 +++++++++++++++-------
 target/riscv/vector_helper.c            | 228 ++++++++++++++++--------
 5 files changed, 409 insertions(+), 185 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index db032fd47f..808f88fbeb 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -145,36 +145,80 @@ DEF_HELPER_5(vle16ff_v, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vle32ff_v, void, ptr, ptr, tl, env, i32)
 DEF_HELPER_5(vle64ff_v, void, ptr, ptr, tl, env, i32)
 
+DEF_HELPER_6(vamoswapei8_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoswapei8_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoswapei16_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoswapei16_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoswapei32_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoswapei32_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoaddei8_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoaddei8_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoaddei16_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoaddei16_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoaddei32_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoaddei32_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoxorei8_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoxorei8_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoxorei16_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoxorei16_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoxorei32_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoxorei32_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoandei8_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoandei8_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoandei16_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoandei16_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoandei32_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoandei32_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoorei8_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoorei8_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoorei16_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoorei16_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoorei32_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoorei32_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamominei8_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamominei8_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamominei16_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamominei16_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamominei32_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamominei32_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamomaxei8_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamomaxei8_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamomaxei16_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamomaxei16_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamomaxei32_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamomaxei32_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamominuei8_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamominuei8_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamominuei16_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamominuei16_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamominuei32_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamominuei32_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamomaxuei8_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamomaxuei8_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamomaxuei16_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamomaxuei16_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamomaxuei32_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamomaxuei32_64_v, void, ptr, ptr, tl, ptr, env, i32)
 #ifdef TARGET_RISCV64
-DEF_HELPER_6(vamoswapw_v_d, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vamoswapd_v_d, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vamoaddw_v_d,  void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vamoaddd_v_d,  void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vamoxorw_v_d,  void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vamoxord_v_d,  void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vamoandw_v_d,  void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vamoandd_v_d,  void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vamoorw_v_d,   void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vamoord_v_d,   void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vamominw_v_d,  void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vamomind_v_d,  void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vamomaxw_v_d,  void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vamomaxd_v_d,  void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vamominuw_v_d, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vamominud_v_d, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vamomaxuw_v_d, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vamomaxud_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoswapei64_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoswapei64_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoaddei64_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoaddei64_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoxorei64_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoxorei64_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoandei64_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoandei64_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoorei64_32_v,  void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamoorei64_64_v,  void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamominei64_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamominei64_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamomaxei64_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamomaxei64_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamominuei64_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamominuei64_64_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamomaxuei64_32_v, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vamomaxuei64_64_v, void, ptr, ptr, tl, ptr, env, i32)
 #endif
-DEF_HELPER_6(vamoswapw_v_w, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vamoaddw_v_w,  void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vamoxorw_v_w,  void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vamoandw_v_w,  void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vamoorw_v_w,   void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vamominw_v_w,  void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vamomaxw_v_w,  void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vamominuw_v_w, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vamomaxuw_v_w, void, ptr, ptr, tl, ptr, env, i32)
-
 DEF_HELPER_6(vadd_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32-64.decode b/target/riscv/insn32-64.decode
index 86153d93fa..c3283a5530 100644
--- a/target/riscv/insn32-64.decode
+++ b/target/riscv/insn32-64.decode
@@ -58,15 +58,15 @@ amominu_d  11000 . . ..... ..... 011 ..... 0101111 @atom_st
 amomaxu_d  11100 . . ..... ..... 011 ..... 0101111 @atom_st
 
 #*** Vector AMO operations (in addition to Zvamo) ***
-vamoswapd_v     00001 . . ..... ..... 111 ..... 0101111 @r_wdvm
-vamoaddd_v      00000 . . ..... ..... 111 ..... 0101111 @r_wdvm
-vamoxord_v      00100 . . ..... ..... 111 ..... 0101111 @r_wdvm
-vamoandd_v      01100 . . ..... ..... 111 ..... 0101111 @r_wdvm
-vamoord_v       01000 . . ..... ..... 111 ..... 0101111 @r_wdvm
-vamomind_v      10000 . . ..... ..... 111 ..... 0101111 @r_wdvm
-vamomaxd_v      10100 . . ..... ..... 111 ..... 0101111 @r_wdvm
-vamominud_v     11000 . . ..... ..... 111 ..... 0101111 @r_wdvm
-vamomaxud_v     11100 . . ..... ..... 111 ..... 0101111 @r_wdvm
+vamoswapei64_v  00001 . . ..... ..... 111 ..... 0101111 @r_wdvm
+vamoaddei64_v   00000 . . ..... ..... 111 ..... 0101111 @r_wdvm
+vamoxorei64_v   00100 . . ..... ..... 111 ..... 0101111 @r_wdvm
+vamoandei64_v   01100 . . ..... ..... 111 ..... 0101111 @r_wdvm
+vamoorei64_v    01000 . . ..... ..... 111 ..... 0101111 @r_wdvm
+vamominei64_v   10000 . . ..... ..... 111 ..... 0101111 @r_wdvm
+vamomaxei64_v   10100 . . ..... ..... 111 ..... 0101111 @r_wdvm
+vamominuei64_v  11000 . . ..... ..... 111 ..... 0101111 @r_wdvm
+vamomaxuei64_v  11100 . . ..... ..... 111 ..... 0101111 @r_wdvm
 
 # *** RV64F Standard Extension (in addition to RV32F) ***
 fcvt_l_s   1100000  00010 ..... ... ..... 1010011 @r2_rm
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index b0aaa186b8..6a9cf6ad53 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -268,15 +268,33 @@ vle32ff_v     ... 000 . 10000 ..... 110 ..... 0000111 @r2_nfvm
 vle64ff_v     ... 000 . 10000 ..... 111 ..... 0000111 @r2_nfvm
 
 #*** Vector AMO operations are encoded under the standard AMO major opcode ***
-vamoswapw_v     00001 . . ..... ..... 110 ..... 0101111 @r_wdvm
-vamoaddw_v      00000 . . ..... ..... 110 ..... 0101111 @r_wdvm
-vamoxorw_v      00100 . . ..... ..... 110 ..... 0101111 @r_wdvm
-vamoandw_v      01100 . . ..... ..... 110 ..... 0101111 @r_wdvm
-vamoorw_v       01000 . . ..... ..... 110 ..... 0101111 @r_wdvm
-vamominw_v      10000 . . ..... ..... 110 ..... 0101111 @r_wdvm
-vamomaxw_v      10100 . . ..... ..... 110 ..... 0101111 @r_wdvm
-vamominuw_v     11000 . . ..... ..... 110 ..... 0101111 @r_wdvm
-vamomaxuw_v     11100 . . ..... ..... 110 ..... 0101111 @r_wdvm
+vamoswapei8_v   00001 . . ..... ..... 000 ..... 0101111 @r_wdvm
+vamoswapei16_v  00001 . . ..... ..... 101 ..... 0101111 @r_wdvm
+vamoswapei32_v  00001 . . ..... ..... 110 ..... 0101111 @r_wdvm
+vamoaddei8_v    00000 . . ..... ..... 000 ..... 0101111 @r_wdvm
+vamoaddei16_v   00000 . . ..... ..... 101 ..... 0101111 @r_wdvm
+vamoaddei32_v   00000 . . ..... ..... 110 ..... 0101111 @r_wdvm
+vamoxorei8_v    00100 . . ..... ..... 000 ..... 0101111 @r_wdvm
+vamoxorei16_v   00100 . . ..... ..... 101 ..... 0101111 @r_wdvm
+vamoxorei32_v   00100 . . ..... ..... 110 ..... 0101111 @r_wdvm
+vamoandei8_v    01100 . . ..... ..... 000 ..... 0101111 @r_wdvm
+vamoandei16_v   01100 . . ..... ..... 101 ..... 0101111 @r_wdvm
+vamoandei32_v   01100 . . ..... ..... 110 ..... 0101111 @r_wdvm
+vamoorei8_v     01000 . . ..... ..... 000 ..... 0101111 @r_wdvm
+vamoorei16_v    01000 . . ..... ..... 101 ..... 0101111 @r_wdvm
+vamoorei32_v    01000 . . ..... ..... 110 ..... 0101111 @r_wdvm
+vamominei8_v    10000 . . ..... ..... 000 ..... 0101111 @r_wdvm
+vamominei16_v   10000 . . ..... ..... 101 ..... 0101111 @r_wdvm
+vamominei32_v   10000 . . ..... ..... 110 ..... 0101111 @r_wdvm
+vamomaxei8_v    10100 . . ..... ..... 000 ..... 0101111 @r_wdvm
+vamomaxei16_v   10100 . . ..... ..... 101 ..... 0101111 @r_wdvm
+vamomaxei32_v   10100 . . ..... ..... 110 ..... 0101111 @r_wdvm
+vamominuei8_v   11000 . . ..... ..... 000 ..... 0101111 @r_wdvm
+vamominuei16_v  11000 . . ..... ..... 101 ..... 0101111 @r_wdvm
+vamominuei32_v  11000 . . ..... ..... 110 ..... 0101111 @r_wdvm
+vamomaxuei8_v   11100 . . ..... ..... 000 ..... 0101111 @r_wdvm
+vamomaxuei16_v  11100 . . ..... ..... 101 ..... 0101111 @r_wdvm
+vamomaxuei32_v  11100 . . ..... ..... 110 ..... 0101111 @r_wdvm
 
 # *** new major opcode OP-V ***
 vadd_vv         000000 . ..... ..... 000 ..... 1010111 @r_vm
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 19c6866838..fb6d092539 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -262,6 +262,53 @@ static bool vext_check_ld_index(DisasContext *s, int vd, int vs2,
     return ret;
 }
 
+/*
+ * Vector AMO check function.
+ *
+ * Rules to be checked here:
+ *   1. RVA must supported.
+ *   2. AMO can either operations on 64-bit (RV64 only) or 32-bit words
+ *      in memory:
+ *      For RV32: 32 <= SEW <= 32.
+ *      For RV64: 32 <= SEW <= 64.
+ *   3. Destination vector register number is multiples of LMUL.
+ *      (Section 3.3.2, 8)
+ *   4. Address vector register number is multiples of EMUL.
+ *      (Section 3.3.2, 8)
+ *   5. EMUL must within the range: 1/8 <= EMUL <= 8. (Section 7.3)
+ *   6. If wd = 1:
+ *      6.1. Destination vector register group for a masked vector
+ *           instruction cannot overlap the source mask register (v0).
+ *           (Section 5.3)
+ *      6.2. Destination vector register cannot overlap a source vector
+ *           register (vs2) group.
+ *           (Section 5.2)
+ */
+static bool vext_check_amo(DisasContext *s, int vd, int vs2,
+                           int wd, int vm)
+{
+    bool ret = has_ext(s, RVA) &&
+               (1 << s->sew >= 4) &&
+               (1 << s->sew <= sizeof(target_ulong)) &&
+               require_align(vd, s->flmul) &&
+               require_align(vs2, s->emul) &&
+               (s->emul >= 0.125 && s->emul <= 8);
+    if (wd) {
+        ret &= require_vm(vm, vd);
+        if (s->eew > (1 << (s->sew + 3))) {
+            if (vd != vs2) {
+                ret &= require_noover(vd, s->flmul, vs2, s->emul);
+            }
+        } else if (s->eew < (1 << (s->sew + 3))) {
+            if (s->emul < 1) {
+                ret &= require_noover(vd, s->flmul, vs2, s->emul);
+            } else {
+                ret &= require_noover_widen(vd, s->flmul, vs2, s->emul);
+            }
+        }
+    }
+    return ret;
+}
 
 /*
  * Check function for vector instruction with format:
@@ -1026,38 +1073,48 @@ static bool amo_op(DisasContext *s, arg_rwdvm *a, uint8_t seq)
 {
     uint32_t data = 0;
     gen_helper_amo *fn;
-    static gen_helper_amo *const fnsw[9] = {
+    static gen_helper_amo *const fns[27][2] = {
         /* no atomic operation */
-        gen_helper_vamoswapw_v_w,
-        gen_helper_vamoaddw_v_w,
-        gen_helper_vamoxorw_v_w,
-        gen_helper_vamoandw_v_w,
-        gen_helper_vamoorw_v_w,
-        gen_helper_vamominw_v_w,
-        gen_helper_vamomaxw_v_w,
-        gen_helper_vamominuw_v_w,
-        gen_helper_vamomaxuw_v_w
+        { gen_helper_vamoswapei8_32_v, gen_helper_vamoswapei8_64_v },
+        { gen_helper_vamoswapei16_32_v, gen_helper_vamoswapei16_64_v },
+        { gen_helper_vamoswapei32_32_v, gen_helper_vamoswapei32_64_v },
+        { gen_helper_vamoaddei8_32_v, gen_helper_vamoaddei8_64_v },
+        { gen_helper_vamoaddei16_32_v, gen_helper_vamoaddei16_64_v },
+        { gen_helper_vamoaddei32_32_v, gen_helper_vamoaddei32_64_v },
+        { gen_helper_vamoxorei8_32_v, gen_helper_vamoxorei8_64_v },
+        { gen_helper_vamoxorei16_32_v, gen_helper_vamoxorei16_64_v },
+        { gen_helper_vamoxorei32_32_v, gen_helper_vamoxorei32_64_v },
+        { gen_helper_vamoandei8_32_v, gen_helper_vamoandei8_64_v },
+        { gen_helper_vamoandei16_32_v, gen_helper_vamoandei16_64_v },
+        { gen_helper_vamoandei32_32_v, gen_helper_vamoandei32_64_v },
+        { gen_helper_vamoorei8_32_v, gen_helper_vamoorei8_64_v },
+        { gen_helper_vamoorei16_32_v, gen_helper_vamoorei16_64_v },
+        { gen_helper_vamoorei32_32_v, gen_helper_vamoorei32_64_v },
+        { gen_helper_vamominei8_32_v, gen_helper_vamominei8_64_v },
+        { gen_helper_vamominei16_32_v, gen_helper_vamominei16_64_v },
+        { gen_helper_vamominei32_32_v, gen_helper_vamominei32_64_v },
+        { gen_helper_vamomaxei8_32_v, gen_helper_vamomaxei8_64_v },
+        { gen_helper_vamomaxei16_32_v, gen_helper_vamomaxei16_64_v },
+        { gen_helper_vamomaxei32_32_v, gen_helper_vamomaxei32_64_v },
+        { gen_helper_vamominuei8_32_v, gen_helper_vamominuei8_64_v },
+        { gen_helper_vamominuei16_32_v, gen_helper_vamominuei16_64_v },
+        { gen_helper_vamominuei32_32_v, gen_helper_vamominuei32_64_v },
+        { gen_helper_vamomaxuei8_32_v, gen_helper_vamomaxuei8_64_v },
+        { gen_helper_vamomaxuei16_32_v, gen_helper_vamomaxuei16_64_v },
+        { gen_helper_vamomaxuei32_32_v, gen_helper_vamomaxuei32_64_v }
     };
+
 #ifdef TARGET_RISCV64
-    static gen_helper_amo *const fnsd[18] = {
-        gen_helper_vamoswapw_v_d,
-        gen_helper_vamoaddw_v_d,
-        gen_helper_vamoxorw_v_d,
-        gen_helper_vamoandw_v_d,
-        gen_helper_vamoorw_v_d,
-        gen_helper_vamominw_v_d,
-        gen_helper_vamomaxw_v_d,
-        gen_helper_vamominuw_v_d,
-        gen_helper_vamomaxuw_v_d,
-        gen_helper_vamoswapd_v_d,
-        gen_helper_vamoaddd_v_d,
-        gen_helper_vamoxord_v_d,
-        gen_helper_vamoandd_v_d,
-        gen_helper_vamoord_v_d,
-        gen_helper_vamomind_v_d,
-        gen_helper_vamomaxd_v_d,
-        gen_helper_vamominud_v_d,
-        gen_helper_vamomaxud_v_d
+    static gen_helper_amo *const fns64[9][2] = {
+        { gen_helper_vamoswapei64_32_v, gen_helper_vamoswapei64_64_v },
+        { gen_helper_vamoaddei64_32_v, gen_helper_vamoaddei64_64_v },
+        { gen_helper_vamoxorei64_32_v, gen_helper_vamoxorei64_64_v },
+        { gen_helper_vamoandei64_32_v, gen_helper_vamoandei64_64_v },
+        { gen_helper_vamoorei64_32_v, gen_helper_vamoorei64_64_v },
+        { gen_helper_vamominei64_32_v, gen_helper_vamominei64_64_v },
+        { gen_helper_vamomaxei64_32_v, gen_helper_vamomaxei64_64_v },
+        { gen_helper_vamominuei64_32_v, gen_helper_vamominuei64_64_v },
+        { gen_helper_vamomaxuei64_32_v, gen_helper_vamomaxuei64_64_v }
     };
 #endif
 
@@ -1066,15 +1123,25 @@ static bool amo_op(DisasContext *s, arg_rwdvm *a, uint8_t seq)
         s->base.is_jmp = DISAS_NORETURN;
         return true;
     } else {
-        if (s->sew == 3) {
+        if (s->eew == 64) {
 #ifdef TARGET_RISCV64
-            fn = fnsd[seq];
+            /* EEW == 64. */
+            fn = fns64[seq][s->sew - 2];
+#else
+            /* RV32 does not support EEW = 64 AMO insns. */
+            g_assert_not_reached();
+#endif
+        } else if (s->sew == 3) {
+#ifdef TARGET_RISCV64
+            /* EEW <= 32 && SEW == 64. */
+            fn = fns[seq][s->sew - 2];
 #else
             /* Check done in amo_check(). */
             g_assert_not_reached();
 #endif
         } else {
-            fn = fnsw[seq];
+            /* EEW <= 32 && SEW == 32. */
+            fn = fns[seq][s->sew - 2];
         }
     }
 
@@ -1086,42 +1153,57 @@ static bool amo_op(DisasContext *s, arg_rwdvm *a, uint8_t seq)
     data = FIELD_DP32(data, VDATA, WD, a->wd);
     return amo_trans(a->rd, a->rs1, a->rs2, data, fn, s);
 }
-/*
- * There are two rules check here.
- *
- * 1. SEW must be at least as wide as the AMO memory element size.
- *
- * 2. If SEW is greater than XLEN, an illegal instruction exception is raised.
- */
+
+
 static bool amo_check(DisasContext *s, arg_rwdvm* a)
 {
-    return (!s->vill && has_ext(s, RVA) &&
-            (!a->wd || vext_check_overlap_mask(s, a->rd, a->vm, false)) &&
-            vext_check_reg(s, a->rd, false) &&
-            vext_check_reg(s, a->rs2, false) &&
-            ((1 << s->sew) <= sizeof(target_ulong)) &&
-            ((1 << s->sew) >= 4));
-}
-
-GEN_VEXT_TRANS(vamoswapw_v, 0, rwdvm, amo_op, amo_check)
-GEN_VEXT_TRANS(vamoaddw_v, 1, rwdvm, amo_op, amo_check)
-GEN_VEXT_TRANS(vamoxorw_v, 2, rwdvm, amo_op, amo_check)
-GEN_VEXT_TRANS(vamoandw_v, 3, rwdvm, amo_op, amo_check)
-GEN_VEXT_TRANS(vamoorw_v, 4, rwdvm, amo_op, amo_check)
-GEN_VEXT_TRANS(vamominw_v, 5, rwdvm, amo_op, amo_check)
-GEN_VEXT_TRANS(vamomaxw_v, 6, rwdvm, amo_op, amo_check)
-GEN_VEXT_TRANS(vamominuw_v, 7, rwdvm, amo_op, amo_check)
-GEN_VEXT_TRANS(vamomaxuw_v, 8, rwdvm, amo_op, amo_check)
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_amo(s, a->rd, a->rs2, a->wd, a->vm);
+}
+
+GEN_VEXT_TRANS(vamoswapei8_v,  8,  0,  rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamoswapei16_v, 16, 1,  rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamoswapei32_v, 32, 2,  rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamoaddei8_v,   8,  3,  rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamoaddei16_v,  16, 4,  rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamoaddei32_v,  32, 5,  rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamoxorei8_v,   8,  6,  rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamoxorei16_v,  16, 7,  rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamoxorei32_v,  32, 8,  rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamoandei8_v,   8,  9,  rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamoandei16_v,  16, 10, rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamoandei32_v,  32, 11, rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamoorei8_v,    8,  12, rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamoorei16_v,   16, 13, rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamoorei32_v,   32, 14, rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamominei8_v,   8,  15, rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamominei16_v,  16, 16, rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamominei32_v,  32, 17, rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamomaxei8_v,   8,  18, rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamomaxei16_v,  16, 19, rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamomaxei32_v,  32, 20, rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamominuei8_v,  8,  21, rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamominuei16_v, 16, 22, rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamominuei32_v, 32, 23, rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamomaxuei8_v,  8,  24, rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamomaxuei16_v, 16, 25, rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamomaxuei32_v, 32, 26, rwdvm, amo_op, amo_check)
+
+/*
+ * Index EEW cannot be greater than XLEN,
+ * else an illegal instruction is raised (Section 8)
+ */
 #ifdef TARGET_RISCV64
-GEN_VEXT_TRANS(vamoswapd_v, 9, rwdvm, amo_op, amo_check)
-GEN_VEXT_TRANS(vamoaddd_v, 10, rwdvm, amo_op, amo_check)
-GEN_VEXT_TRANS(vamoxord_v, 11, rwdvm, amo_op, amo_check)
-GEN_VEXT_TRANS(vamoandd_v, 12, rwdvm, amo_op, amo_check)
-GEN_VEXT_TRANS(vamoord_v, 13, rwdvm, amo_op, amo_check)
-GEN_VEXT_TRANS(vamomind_v, 14, rwdvm, amo_op, amo_check)
-GEN_VEXT_TRANS(vamomaxd_v, 15, rwdvm, amo_op, amo_check)
-GEN_VEXT_TRANS(vamominud_v, 16, rwdvm, amo_op, amo_check)
-GEN_VEXT_TRANS(vamomaxud_v, 17, rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamoswapei64_v, 64, 0,  rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamoaddei64_v,  64, 1,  rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamoxorei64_v,  64, 2,  rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamoandei64_v,  64, 3,  rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamoorei64_v,   64, 4,  rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamominei64_v,  64, 5,  rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamomaxei64_v,  64, 6,  rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamominuei64_v, 64, 7,  rwdvm, amo_op, amo_check)
+GEN_VEXT_TRANS(vamomaxuei64_v, 64, 8,  rwdvm, amo_op, amo_check)
 #endif
 
 /*
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 35ce006698..f49af084ef 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -649,23 +649,22 @@ typedef void vext_amo_noatomic_fn(void *vs3, target_ulong addr,
                                   uint32_t wd, uint32_t idx, CPURISCVState *env,
                                   uintptr_t retaddr);
 
-/* no atomic opreation for vector atomic insructions */
+/* no atomic operation for vector atomic instructions */
 #define DO_SWAP(N, M) (M)
 #define DO_AND(N, M)  (N & M)
 #define DO_XOR(N, M)  (N ^ M)
 #define DO_OR(N, M)   (N | M)
 #define DO_ADD(N, M)  (N + M)
+#define DO_MAX(N, M)  ((N) >= (M) ? (N) : (M))
+#define DO_MIN(N, M)  ((N) >= (M) ? (M) : (N))
 
-#define GEN_VEXT_AMO_NOATOMIC_OP(NAME, ESZ, MSZ, H, DO_OP, SUF) \
+#define GEN_VEXT_AMO_NOATOMIC_OP(NAME, MTYPE, H, DO_OP, SUF)    \
 static void                                                     \
 vext_##NAME##_noatomic_op(void *vs3, target_ulong addr,         \
                           uint32_t wd, uint32_t idx,            \
                           CPURISCVState *env, uintptr_t retaddr)\
 {                                                               \
-    typedef int##ESZ##_t ETYPE;                                 \
-    typedef int##MSZ##_t MTYPE;                                 \
-    typedef uint##MSZ##_t UMTYPE __attribute__((unused));       \
-    ETYPE *pe3 = (ETYPE *)vs3 + H(idx);                         \
+    MTYPE *pe3 = (MTYPE *)vs3 + H(idx);                         \
     MTYPE  a = cpu_ld##SUF##_data(env, addr), b = *pe3;         \
                                                                 \
     cpu_st##SUF##_data(env, addr, DO_OP(a, b));                 \
@@ -674,42 +673,79 @@ vext_##NAME##_noatomic_op(void *vs3, target_ulong addr,         \
     }                                                           \
 }
 
-/* Signed min/max */
-#define DO_MAX(N, M)  ((N) >= (M) ? (N) : (M))
-#define DO_MIN(N, M)  ((N) >= (M) ? (M) : (N))
-
-/* Unsigned min/max */
-#define DO_MAXU(N, M) DO_MAX((UMTYPE)N, (UMTYPE)M)
-#define DO_MINU(N, M) DO_MIN((UMTYPE)N, (UMTYPE)M)
-
-GEN_VEXT_AMO_NOATOMIC_OP(vamoswapw_v_w, 32, 32, H4, DO_SWAP, l)
-GEN_VEXT_AMO_NOATOMIC_OP(vamoaddw_v_w,  32, 32, H4, DO_ADD,  l)
-GEN_VEXT_AMO_NOATOMIC_OP(vamoxorw_v_w,  32, 32, H4, DO_XOR,  l)
-GEN_VEXT_AMO_NOATOMIC_OP(vamoandw_v_w,  32, 32, H4, DO_AND,  l)
-GEN_VEXT_AMO_NOATOMIC_OP(vamoorw_v_w,   32, 32, H4, DO_OR,   l)
-GEN_VEXT_AMO_NOATOMIC_OP(vamominw_v_w,  32, 32, H4, DO_MIN,  l)
-GEN_VEXT_AMO_NOATOMIC_OP(vamomaxw_v_w,  32, 32, H4, DO_MAX,  l)
-GEN_VEXT_AMO_NOATOMIC_OP(vamominuw_v_w, 32, 32, H4, DO_MINU, l)
-GEN_VEXT_AMO_NOATOMIC_OP(vamomaxuw_v_w, 32, 32, H4, DO_MAXU, l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoswapei8_32_v,  uint32_t, H4, DO_SWAP, l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoswapei8_64_v,  uint64_t, H8, DO_SWAP, q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoswapei16_32_v, uint32_t, H4, DO_SWAP, l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoswapei16_64_v, uint64_t, H8, DO_SWAP, q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoswapei32_32_v, uint32_t, H4, DO_SWAP, l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoswapei32_64_v, uint64_t, H8, DO_SWAP, q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoaddei8_32_v,   uint32_t, H4, DO_ADD,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoaddei8_64_v,   uint64_t, H8, DO_ADD,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoaddei16_32_v,  uint32_t, H4, DO_ADD,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoaddei16_64_v,  uint64_t, H8, DO_ADD,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoaddei32_32_v,  uint32_t, H4, DO_ADD,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoaddei32_64_v,  uint64_t, H8, DO_ADD,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoxorei8_32_v,   uint32_t, H4, DO_XOR,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoxorei8_64_v,   uint64_t, H8, DO_XOR,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoxorei16_32_v,  uint32_t, H4, DO_XOR,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoxorei16_64_v,  uint64_t, H8, DO_XOR,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoxorei32_32_v,  uint32_t, H4, DO_XOR,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoxorei32_64_v,  uint64_t, H8, DO_XOR,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoandei8_32_v,   uint32_t, H4, DO_AND,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoandei8_64_v,   uint64_t, H8, DO_AND,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoandei16_32_v,  uint32_t, H4, DO_AND,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoandei16_64_v,  uint64_t, H8, DO_AND,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoandei32_32_v,  uint32_t, H4, DO_AND,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoandei32_64_v,  uint64_t, H8, DO_AND,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoorei8_32_v,    uint32_t, H4, DO_OR,   l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoorei8_64_v,    uint64_t, H8, DO_OR,   q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoorei16_32_v,   uint32_t, H4, DO_OR,   l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoorei16_64_v,   uint64_t, H8, DO_OR,   q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoorei32_32_v,   uint32_t, H4, DO_OR,   l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoorei32_64_v,   uint64_t, H8, DO_OR,   q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamominei8_32_v,   int32_t,  H4, DO_MIN,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamominei8_64_v,   int64_t,  H8, DO_MIN,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamominei16_32_v,  int32_t,  H4, DO_MIN,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamominei16_64_v,  int64_t,  H8, DO_MIN,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamominei32_32_v,  int32_t,  H4, DO_MIN,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamominei32_64_v,  int64_t,  H8, DO_MIN,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamomaxei8_32_v,   int32_t,  H4, DO_MAX,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamomaxei8_64_v,   int64_t,  H8, DO_MAX,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamomaxei16_32_v,  int32_t,  H4, DO_MAX,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamomaxei16_64_v,  int64_t,  H8, DO_MAX,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamomaxei32_32_v,  int32_t,  H4, DO_MAX,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamomaxei32_64_v,  int64_t,  H8, DO_MAX,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamominuei8_32_v,  uint32_t, H4, DO_MIN,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamominuei8_64_v,  uint64_t, H8, DO_MIN,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamominuei16_32_v, uint32_t, H4, DO_MIN,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamominuei16_64_v, uint64_t, H8, DO_MIN,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamominuei32_32_v, uint32_t, H4, DO_MIN,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamominuei32_64_v, uint64_t, H8, DO_MIN,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamomaxuei8_32_v,  uint32_t, H4, DO_MAX,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamomaxuei8_64_v,  uint64_t, H8, DO_MAX,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamomaxuei16_32_v, uint32_t, H4, DO_MAX,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamomaxuei16_64_v, uint64_t, H8, DO_MAX,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamomaxuei32_32_v, uint32_t, H4, DO_MAX,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamomaxuei32_64_v, uint64_t, H8, DO_MAX,  q)
 #ifdef TARGET_RISCV64
-GEN_VEXT_AMO_NOATOMIC_OP(vamoswapw_v_d, 64, 32, H8, DO_SWAP, l)
-GEN_VEXT_AMO_NOATOMIC_OP(vamoswapd_v_d, 64, 64, H8, DO_SWAP, q)
-GEN_VEXT_AMO_NOATOMIC_OP(vamoaddw_v_d,  64, 32, H8, DO_ADD,  l)
-GEN_VEXT_AMO_NOATOMIC_OP(vamoaddd_v_d,  64, 64, H8, DO_ADD,  q)
-GEN_VEXT_AMO_NOATOMIC_OP(vamoxorw_v_d,  64, 32, H8, DO_XOR,  l)
-GEN_VEXT_AMO_NOATOMIC_OP(vamoxord_v_d,  64, 64, H8, DO_XOR,  q)
-GEN_VEXT_AMO_NOATOMIC_OP(vamoandw_v_d,  64, 32, H8, DO_AND,  l)
-GEN_VEXT_AMO_NOATOMIC_OP(vamoandd_v_d,  64, 64, H8, DO_AND,  q)
-GEN_VEXT_AMO_NOATOMIC_OP(vamoorw_v_d,   64, 32, H8, DO_OR,   l)
-GEN_VEXT_AMO_NOATOMIC_OP(vamoord_v_d,   64, 64, H8, DO_OR,   q)
-GEN_VEXT_AMO_NOATOMIC_OP(vamominw_v_d,  64, 32, H8, DO_MIN,  l)
-GEN_VEXT_AMO_NOATOMIC_OP(vamomind_v_d,  64, 64, H8, DO_MIN,  q)
-GEN_VEXT_AMO_NOATOMIC_OP(vamomaxw_v_d,  64, 32, H8, DO_MAX,  l)
-GEN_VEXT_AMO_NOATOMIC_OP(vamomaxd_v_d,  64, 64, H8, DO_MAX,  q)
-GEN_VEXT_AMO_NOATOMIC_OP(vamominuw_v_d, 64, 32, H8, DO_MINU, l)
-GEN_VEXT_AMO_NOATOMIC_OP(vamominud_v_d, 64, 64, H8, DO_MINU, q)
-GEN_VEXT_AMO_NOATOMIC_OP(vamomaxuw_v_d, 64, 32, H8, DO_MAXU, l)
-GEN_VEXT_AMO_NOATOMIC_OP(vamomaxud_v_d, 64, 64, H8, DO_MAXU, q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoswapei64_32_v, uint32_t, H4, DO_SWAP, l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoswapei64_64_v, uint64_t, H8, DO_SWAP, q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoaddei64_32_v,  uint32_t, H4, DO_ADD,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoaddei64_64_v,  uint64_t, H8, DO_ADD,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoxorei64_32_v,  uint32_t, H4, DO_XOR,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoxorei64_64_v,  uint64_t, H8, DO_XOR,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoandei64_32_v,  uint32_t, H4, DO_AND,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoandei64_64_v,  uint64_t, H8, DO_AND,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoorei64_32_v,   uint32_t, H4, DO_OR,   l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamoorei64_64_v,   uint64_t, H8, DO_OR,   q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamominei64_32_v,  int32_t,  H4, DO_MIN,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamominei64_64_v,  int64_t,  H8, DO_MIN,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamomaxei64_32_v,  int32_t,  H4, DO_MAX,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamomaxei64_64_v,  int64_t,  H8, DO_MAX,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamominuei64_32_v, uint32_t, H4, DO_MIN,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamominuei64_64_v, uint64_t, H8, DO_MIN,  q)
+GEN_VEXT_AMO_NOATOMIC_OP(vamomaxuei64_32_v, uint32_t, H4, DO_MAX,  l)
+GEN_VEXT_AMO_NOATOMIC_OP(vamomaxuei64_64_v, uint64_t, H8, DO_MAX,  q)
 #endif
 
 static inline void
@@ -717,8 +753,7 @@ vext_amo_noatomic(void *vs3, void *v0, target_ulong base,
                   void *vs2, CPURISCVState *env, uint32_t desc,
                   vext_get_index_addr get_index_addr,
                   vext_amo_noatomic_fn *noatomic_op,
-                  clear_fn *clear_elem,
-                  uint32_t esz, uint32_t msz, uintptr_t ra)
+                  clear_fn *clear_elem, uint32_t esz, uintptr_t ra)
 {
     uint32_t i;
     target_long addr;
@@ -731,8 +766,8 @@ vext_amo_noatomic(void *vs3, void *v0, target_ulong base,
         if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
-        probe_pages(env, get_index_addr(base, i, vs2), msz, ra, MMU_DATA_LOAD);
-        probe_pages(env, get_index_addr(base, i, vs2), msz, ra, MMU_DATA_STORE);
+        probe_pages(env, get_index_addr(base, i, vs2), esz, ra, MMU_DATA_LOAD);
+        probe_pages(env, get_index_addr(base, i, vs2), esz, ra, MMU_DATA_STORE);
     }
     for (i = 0; i < env->vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
@@ -744,45 +779,90 @@ vext_amo_noatomic(void *vs3, void *v0, target_ulong base,
     clear_elem(vs3, vta, env->vl, env->vl * esz, vlmax * esz);
 }
 
-#define GEN_VEXT_AMO(NAME, MTYPE, ETYPE, INDEX_FN, CLEAR_FN)    \
+#define GEN_VEXT_AMO(NAME, ETYPE, INDEX_FN, CLEAR_FN)           \
 void HELPER(NAME)(void *vs3, void *v0, target_ulong base,       \
                   void *vs2, CPURISCVState *env, uint32_t desc) \
 {                                                               \
     vext_amo_noatomic(vs3, v0, base, vs2, env, desc,            \
                       INDEX_FN, vext_##NAME##_noatomic_op,      \
-                      CLEAR_FN, sizeof(ETYPE), sizeof(MTYPE),   \
+                      CLEAR_FN, sizeof(ETYPE),                  \
                       GETPC());                                 \
 }
 
+GEN_VEXT_AMO(vamoswapei8_32_v,  int32_t, idx_b, clearl)
+GEN_VEXT_AMO(vamoswapei8_64_v,  int64_t, idx_b, clearq)
+GEN_VEXT_AMO(vamoswapei16_32_v, int32_t, idx_h, clearl)
+GEN_VEXT_AMO(vamoswapei16_64_v, int64_t, idx_h, clearq)
+GEN_VEXT_AMO(vamoswapei32_32_v, int32_t, idx_w, clearl)
+GEN_VEXT_AMO(vamoswapei32_64_v, int64_t, idx_w, clearq)
+GEN_VEXT_AMO(vamoaddei8_32_v,   int32_t, idx_b, clearl)
+GEN_VEXT_AMO(vamoaddei8_64_v,   int64_t, idx_b, clearq)
+GEN_VEXT_AMO(vamoaddei16_32_v,  int32_t, idx_h, clearl)
+GEN_VEXT_AMO(vamoaddei16_64_v,  int64_t, idx_h, clearq)
+GEN_VEXT_AMO(vamoaddei32_32_v,  int32_t, idx_w, clearl)
+GEN_VEXT_AMO(vamoaddei32_64_v,  int64_t, idx_w, clearq)
+GEN_VEXT_AMO(vamoxorei8_32_v,   int32_t, idx_b, clearl)
+GEN_VEXT_AMO(vamoxorei8_64_v,   int64_t, idx_b, clearq)
+GEN_VEXT_AMO(vamoxorei16_32_v,  int32_t, idx_h, clearl)
+GEN_VEXT_AMO(vamoxorei16_64_v,  int64_t, idx_h, clearq)
+GEN_VEXT_AMO(vamoxorei32_32_v,  int32_t, idx_w, clearl)
+GEN_VEXT_AMO(vamoxorei32_64_v,  int64_t, idx_w, clearq)
+GEN_VEXT_AMO(vamoandei8_32_v,   int32_t, idx_b, clearl)
+GEN_VEXT_AMO(vamoandei8_64_v,   int64_t, idx_b, clearq)
+GEN_VEXT_AMO(vamoandei16_32_v,  int32_t, idx_h, clearl)
+GEN_VEXT_AMO(vamoandei16_64_v,  int64_t, idx_h, clearq)
+GEN_VEXT_AMO(vamoandei32_32_v,  int32_t, idx_w, clearl)
+GEN_VEXT_AMO(vamoandei32_64_v,  int64_t, idx_w, clearq)
+GEN_VEXT_AMO(vamoorei8_32_v,    int32_t, idx_b, clearl)
+GEN_VEXT_AMO(vamoorei8_64_v,    int64_t, idx_b, clearq)
+GEN_VEXT_AMO(vamoorei16_32_v,   int32_t, idx_h, clearl)
+GEN_VEXT_AMO(vamoorei16_64_v,   int64_t, idx_h, clearq)
+GEN_VEXT_AMO(vamoorei32_32_v,   int32_t, idx_w, clearl)
+GEN_VEXT_AMO(vamoorei32_64_v,   int64_t, idx_w, clearq)
+GEN_VEXT_AMO(vamominei8_32_v,   int32_t, idx_b, clearl)
+GEN_VEXT_AMO(vamominei8_64_v,   int64_t, idx_b, clearq)
+GEN_VEXT_AMO(vamominei16_32_v,  int32_t, idx_h, clearl)
+GEN_VEXT_AMO(vamominei16_64_v,  int64_t, idx_h, clearq)
+GEN_VEXT_AMO(vamominei32_32_v,  int32_t, idx_w, clearl)
+GEN_VEXT_AMO(vamominei32_64_v,  int64_t, idx_w, clearq)
+GEN_VEXT_AMO(vamomaxei8_32_v,   int32_t, idx_b, clearl)
+GEN_VEXT_AMO(vamomaxei8_64_v,   int64_t, idx_b, clearq)
+GEN_VEXT_AMO(vamomaxei16_32_v,  int32_t, idx_h, clearl)
+GEN_VEXT_AMO(vamomaxei16_64_v,  int64_t, idx_h, clearq)
+GEN_VEXT_AMO(vamomaxei32_32_v,  int32_t, idx_w, clearl)
+GEN_VEXT_AMO(vamomaxei32_64_v,  int64_t, idx_w, clearq)
+GEN_VEXT_AMO(vamominuei8_32_v,  int32_t, idx_b, clearl)
+GEN_VEXT_AMO(vamominuei8_64_v,  int64_t, idx_b, clearq)
+GEN_VEXT_AMO(vamominuei16_32_v, int32_t, idx_h, clearl)
+GEN_VEXT_AMO(vamominuei16_64_v, int64_t, idx_h, clearq)
+GEN_VEXT_AMO(vamominuei32_32_v, int32_t, idx_w, clearl)
+GEN_VEXT_AMO(vamominuei32_64_v, int64_t, idx_w, clearq)
+GEN_VEXT_AMO(vamomaxuei8_32_v,  int32_t, idx_b, clearl)
+GEN_VEXT_AMO(vamomaxuei8_64_v,  int64_t, idx_b, clearq)
+GEN_VEXT_AMO(vamomaxuei16_32_v, int32_t, idx_h, clearl)
+GEN_VEXT_AMO(vamomaxuei16_64_v, int64_t, idx_h, clearq)
+GEN_VEXT_AMO(vamomaxuei32_32_v, int32_t, idx_w, clearl)
+GEN_VEXT_AMO(vamomaxuei32_64_v, int64_t, idx_w, clearq)
 #ifdef TARGET_RISCV64
-GEN_VEXT_AMO(vamoswapw_v_d, int32_t,  int64_t,  idx_d, clearq)
-GEN_VEXT_AMO(vamoswapd_v_d, int64_t,  int64_t,  idx_d, clearq)
-GEN_VEXT_AMO(vamoaddw_v_d,  int32_t,  int64_t,  idx_d, clearq)
-GEN_VEXT_AMO(vamoaddd_v_d,  int64_t,  int64_t,  idx_d, clearq)
-GEN_VEXT_AMO(vamoxorw_v_d,  int32_t,  int64_t,  idx_d, clearq)
-GEN_VEXT_AMO(vamoxord_v_d,  int64_t,  int64_t,  idx_d, clearq)
-GEN_VEXT_AMO(vamoandw_v_d,  int32_t,  int64_t,  idx_d, clearq)
-GEN_VEXT_AMO(vamoandd_v_d,  int64_t,  int64_t,  idx_d, clearq)
-GEN_VEXT_AMO(vamoorw_v_d,   int32_t,  int64_t,  idx_d, clearq)
-GEN_VEXT_AMO(vamoord_v_d,   int64_t,  int64_t,  idx_d, clearq)
-GEN_VEXT_AMO(vamominw_v_d,  int32_t,  int64_t,  idx_d, clearq)
-GEN_VEXT_AMO(vamomind_v_d,  int64_t,  int64_t,  idx_d, clearq)
-GEN_VEXT_AMO(vamomaxw_v_d,  int32_t,  int64_t,  idx_d, clearq)
-GEN_VEXT_AMO(vamomaxd_v_d,  int64_t,  int64_t,  idx_d, clearq)
-GEN_VEXT_AMO(vamominuw_v_d, uint32_t, uint64_t, idx_d, clearq)
-GEN_VEXT_AMO(vamominud_v_d, uint64_t, uint64_t, idx_d, clearq)
-GEN_VEXT_AMO(vamomaxuw_v_d, uint32_t, uint64_t, idx_d, clearq)
-GEN_VEXT_AMO(vamomaxud_v_d, uint64_t, uint64_t, idx_d, clearq)
+GEN_VEXT_AMO(vamoswapei64_32_v, int32_t, idx_d, clearl)
+GEN_VEXT_AMO(vamoswapei64_64_v, int64_t, idx_d, clearq)
+GEN_VEXT_AMO(vamoaddei64_32_v,  int32_t, idx_d, clearl)
+GEN_VEXT_AMO(vamoaddei64_64_v,  int64_t, idx_d, clearq)
+GEN_VEXT_AMO(vamoxorei64_32_v,  int32_t, idx_d, clearl)
+GEN_VEXT_AMO(vamoxorei64_64_v,  int64_t, idx_d, clearq)
+GEN_VEXT_AMO(vamoandei64_32_v,  int32_t, idx_d, clearl)
+GEN_VEXT_AMO(vamoandei64_64_v,  int64_t, idx_d, clearq)
+GEN_VEXT_AMO(vamoorei64_32_v,   int32_t, idx_d, clearl)
+GEN_VEXT_AMO(vamoorei64_64_v,   int64_t, idx_d, clearq)
+GEN_VEXT_AMO(vamominei64_32_v,  int32_t, idx_d, clearl)
+GEN_VEXT_AMO(vamominei64_64_v,  int64_t, idx_d, clearq)
+GEN_VEXT_AMO(vamomaxei64_32_v,  int32_t, idx_d, clearl)
+GEN_VEXT_AMO(vamomaxei64_64_v,  int64_t, idx_d, clearq)
+GEN_VEXT_AMO(vamominuei64_32_v, int32_t, idx_d, clearl)
+GEN_VEXT_AMO(vamominuei64_64_v, int64_t, idx_d, clearq)
+GEN_VEXT_AMO(vamomaxuei64_32_v, int32_t, idx_d, clearl)
+GEN_VEXT_AMO(vamomaxuei64_64_v, int64_t, idx_d, clearq)
 #endif
-GEN_VEXT_AMO(vamoswapw_v_w, int32_t,  int32_t,  idx_w, clearl)
-GEN_VEXT_AMO(vamoaddw_v_w,  int32_t,  int32_t,  idx_w, clearl)
-GEN_VEXT_AMO(vamoxorw_v_w,  int32_t,  int32_t,  idx_w, clearl)
-GEN_VEXT_AMO(vamoandw_v_w,  int32_t,  int32_t,  idx_w, clearl)
-GEN_VEXT_AMO(vamoorw_v_w,   int32_t,  int32_t,  idx_w, clearl)
-GEN_VEXT_AMO(vamominw_v_w,  int32_t,  int32_t,  idx_w, clearl)
-GEN_VEXT_AMO(vamomaxw_v_w,  int32_t,  int32_t,  idx_w, clearl)
-GEN_VEXT_AMO(vamominuw_v_w, uint32_t, uint32_t, idx_w, clearl)
-GEN_VEXT_AMO(vamomaxuw_v_w, uint32_t, uint32_t, idx_w, clearl)
 
 /*
  *** Vector Integer Arithmetic Instructions
-- 
2.17.1


