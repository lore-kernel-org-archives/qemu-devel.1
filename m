Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6978FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:04:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3458B2065D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="snY6vt1C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3458B2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7fkc-00089W-Dc
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1k7fi1-0003LT-5s; Mon, 17 Aug 2020 10:01:57 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:44241)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1k7fhy-0001Xe-Vx; Mon, 17 Aug 2020 10:01:56 -0400
Received: by mail-lf1-x143.google.com with SMTP id x24so8402389lfe.11;
 Mon, 17 Aug 2020 07:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gRwNidHb/xzDXEvtr3z3PMKv/URa1A0x7rFiibmqh6s=;
 b=snY6vt1CXWl9LUwqROGVCqaHldkYLhrO/SVpV3q/z4WM0N2XlnhMRL/SzOG9DSPrRc
 FDoe2FwWKc8XpOmnxFcXytqiQJga++uIwM83vpwTTTBFwEaFcxzkO3M0JXuQxzXasX7V
 z/z1+M5o87cjnkHmXK3ClPxprKJRxTn3ODdXW4Z6myOd8anyX7wyGARXnPCffLYvKDOe
 W2rFyG5Hfklphw63swW1CXstQNuGF0qjnH1rA4CFfn8BZyh8fFqConQC27VvBUPhzq5H
 b4NpfGQNLSWsyJvKmxBOmTyldw17qYRa5y9XBJ4Xugfb9uZkUIzYTcRzVlZxHFTCdGUT
 bfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gRwNidHb/xzDXEvtr3z3PMKv/URa1A0x7rFiibmqh6s=;
 b=XLUqk/BgijLTKv70Pv72hXZriobZPAhFwBtAovU9gYj8np53x9GYIbR8b40LjfvztY
 7Hf0KvPzWDr8HPD+uT7N4fMYxU74XuMisMG4kc9oRpYyH6tp4OEuInL/bSw4lY9yEVt5
 hElaPAxoeG9NBJjFw/zVcTioPjwQFccA6jBIslBI7VvDqQxL4a1Q0UprBFFwtdgfmpNa
 IAEdj0/uFEIFpcC2RC2xyYoOsCIzkDSqfkEsWmuiH7WEkhDY7NdjxI9QFcksR81eSVH6
 +gYlmJHou959RQF47c3RSNKEbCy0+CS4UKkPkQGgK863BiGdGWAGjQEZlCt8+mtqP04W
 sU3g==
X-Gm-Message-State: AOAM531DJzqoSNZh+V48pdkdWKMDExifHoEuWauuk8LHdS0NQLuRiSDR
 utm7tPwUSEQblJYi8rOhd+fkFF+6zTtxweQf
X-Google-Smtp-Source: ABdhPJzJkRodM4UO4geVDmC1nu9978k3vs7vvm1TKrYnC02NfGsRg/jpRFt0W3g8M97xR4h5hAd9Zg==
X-Received: by 2002:a19:cb51:: with SMTP id b78mr7459536lfg.130.1597672912623; 
 Mon, 17 Aug 2020 07:01:52 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id c4sm5040593ljk.70.2020.08.17.07.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:01:52 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 4/5] target/microblaze: swx: Use atomic_cmpxchg
Date: Mon, 17 Aug 2020 16:01:43 +0200
Message-Id: <20200817140144.373403-5-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200817140144.373403-1-edgar.iglesias@gmail.com>
References: <20200817140144.373403-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Use atomic_cmpxchg to implement the atomic cmpxchg sequence.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index c58f334a0f..530c15e5ad 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1075,14 +1075,16 @@ static void dec_store(DisasContext *dc)
         swx_skip = gen_new_label();
         tcg_gen_brcond_tl(TCG_COND_NE, env_res_addr, addr, swx_skip);
 
-        /* Compare the value loaded at lwx with current contents of
-           the reserved location.
-           FIXME: This only works for system emulation where we can expect
-           this compare and the following write to be atomic. For user
-           emulation we need to add atomicity between threads.  */
+        /*
+         * Compare the value loaded at lwx with current contents of
+         * the reserved location.
+         */
         tval = tcg_temp_new_i32();
-        tcg_gen_qemu_ld_i32(tval, addr, cpu_mmu_index(&dc->cpu->env, false),
-                            MO_TEUL);
+
+        tcg_gen_atomic_cmpxchg_i32(tval, addr, env_res_val,
+                                   cpu_R[dc->rd], mem_index,
+                                   mop);
+
         tcg_gen_brcond_i32(TCG_COND_NE, env_res_val, tval, swx_skip);
         write_carryi(dc, 0);
         tcg_temp_free_i32(tval);
@@ -1108,7 +1110,10 @@ static void dec_store(DisasContext *dc)
                 break;
         }
     }
-    tcg_gen_qemu_st_i32(cpu_R[dc->rd], addr, mem_index, mop);
+
+    if (!ex) {
+        tcg_gen_qemu_st_i32(cpu_R[dc->rd], addr, mem_index, mop);
+    }
 
     /* Verify alignment if needed.  */
     if (dc->cpu->cfg.unaligned_exceptions && size > 1) {
-- 
2.25.1


