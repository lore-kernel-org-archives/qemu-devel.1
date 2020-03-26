Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30347C2D0E5
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:45:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 018E0206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CSydcz3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 018E0206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYRl-00047B-FB
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKA-0006Te-Q4
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYK8-0001UB-Me
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:54 -0400
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:42843)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYK8-0001Tu-Iv
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:52 -0400
Received: by mail-qv1-xf44.google.com with SMTP id ca9so3690098qvb.9
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=klf9qVFdgtejUVaZm03YCM6EuSDU/7CS5KQfsLceHvs=;
 b=CSydcz3fPydfjRTN/2AGoGyuURZiJwJhHIv3PLzipl14r0ubkUqGaWAIXZanyTynj0
 KjxEy+5B9W4c0ORKEUeQHpmC7E3IGMdn2plQyNjf40h2t0wmgjUnv3f+XzOb2eZaIbyE
 jfvFiXJik1t9meSt4Sup+MpIejanl1/Fdx9D+832gSZOiq1AeGIaz1pY6tfclkJuSa4Q
 /3LHN6/ESDT7PyyL+sxDCF10khi0Dqoxywk2rNpf1gsRHvAOvAvEchttcNYgmjbsy3pb
 TlAN7ixwnyo2y/1l0wUSEellFvvOFWoP3OSYEZF2b21OuDp/Vg9GlmMEOVt4RlGlOUe3
 y75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=klf9qVFdgtejUVaZm03YCM6EuSDU/7CS5KQfsLceHvs=;
 b=TxcgOsNcefiVO13xD0r1VIz+qfCeWRkkgGppQJURyNvXjmkuipD80MVaduQ3Svri5h
 V3nl4fbfzo0hmXyh1WBMivTS1ybhwwTbalA/0M0JmWdXReoY5Kl9jEFzrCd0ZYXDXn2Q
 0hfx8Mm+J+8oL9ndnbGHoX7b3WDSvhFOJV7Da42Ai63R37VTX46omHjB8Efo8wyncPTc
 Wh68IPG6rN+elw4LE60yCcnhHmZlB/AdZkxkU8mgtX5Q+cjyAGaiZLSlnD3Fom1CM/Vk
 7RnTX2ifqY1JSocP7AXe5a1oj0FeeHjnUtQCyc4EENO6NUhGFdCFgB3P4PLj8IeGrd4c
 zDdw==
X-Gm-Message-State: ANhLgQ2196CXDP6MWPvlMGD7CkzqLmTyAEXunutoBMT/C+uWZOxZJKZO
 HD7sE44zk377WEgEo5xv/pYT3GdolFweTQ==
X-Google-Smtp-Source: ADFU+vukIjzJHPbHlnNi9hGxGdvWiTXmh/AgGxqdAmxAAepzi6JPTWN9htrlxTFcdFDuVnigN/9QTw==
X-Received: by 2002:ad4:46e6:: with SMTP id h6mr9918078qvw.208.1585251471034; 
 Thu, 26 Mar 2020 12:37:51 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.37.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:37:50 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 14/74] microblaze: convert to helper_cpu_halted_set
Date: Thu, 26 Mar 2020 15:30:56 -0400
Message-Id: <20200326193156.4322-15-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f44
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
Cc: robert.foley@linaro.org, richard.henderson@linaro.org,
 "Emilio G. Cota" <cota@braap.org>, peter.puhov@linaro.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/microblaze/translate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 37a844db99..deef94a471 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1236,9 +1236,7 @@ static void dec_br(DisasContext *dc)
             LOG_DIS("sleep\n");
 
             t_sync_flags(dc);
-            tcg_gen_st_i32(tmp_1, cpu_env,
-                           -offsetof(MicroBlazeCPU, env)
-                           +offsetof(CPUState, halted));
+            gen_helper_cpu_halted_set(cpu_env, tmp_1);
             tcg_gen_movi_i64(cpu_SR[SR_PC], dc->pc + 4);
             gen_helper_raise_exception(cpu_env, tmp_hlt);
             tcg_temp_free_i32(tmp_hlt);
-- 
2.17.1


