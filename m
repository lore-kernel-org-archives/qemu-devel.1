Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57ECAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:21:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 202772166E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FLazHiiM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 202772166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfUe-0007aM-C5
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfE7-0003Gg-3s
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:07 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:39456)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDy-0008V4-6M
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:06 -0400
Received: by mail-qk1-x744.google.com with SMTP id w3so3495522qkb.6
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=r3ihf6Hm5TzP8tkXXmmJd+HhpHTqUNEyVizEpWsgvtc=;
 b=FLazHiiMttd3/Qd+Dl/Rze/N8LbtIMW3GoaMCj4W1fl1o0Yl35Z2o0BYg52G5ggmAB
 7T2Um0hj/foyGWbpjIHDiGGGmhQ6MU+dJE0qTP1MbRPvyr7YkQ3KxOy/ZPeJa6S+BSl7
 IOngYd60f5oHr5U7C8XS3o9sk2f3nrx3rpDx1bQ7G59v1tavYzGMINDx0YBufOUlEsAe
 w4lZb6tuyKCK+xm9owNYFNVcVcRHG+xrhFF3rSwD0xEnvfNE4FXquQoMu/NcXdoPu46j
 NZVeaUEJJHcW4jAFbUs+NZh/pD6Y7raWKPy+MJuTKwkLHfKGe7AdDHosd8JL15PudG+a
 8mvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=r3ihf6Hm5TzP8tkXXmmJd+HhpHTqUNEyVizEpWsgvtc=;
 b=QfukeIaWbc3cYYfr2SGuqHl+gAbZVpNWzc+ZHG/brGcl8z+kCWqTDG5N1Kh2FosjxU
 VZKbduUn8bk53LbzTb8afodSNjMkpNW56ggVfd7IW9+TSEdlyvMZ8EMBtwmh2VYk/AUg
 G0I63AKSgJntYQJ3QM9Jl6b6eYiyqKzt+euZc4TowxjDEwBlhWM8saJIsE7apCmBqp39
 GhaxDprH/2YvZkrOAEVl5iJ2wT4xO7DjYuHUaa0ukF7o8Mw2STCTF7ao36HRrZOd76XQ
 gsFpB47Tb8DTyMUABVQXi1UGt21nKFfm/Xd95YNFoOl0pGzwgRDXs1hIDauSpllhuwxo
 b5uQ==
X-Gm-Message-State: AOAM530hAUMQKZbbUQM/U46M1XpwmEDS8JqErwl5OU1TBdp7ScLlt9pG
 DVTF4iOLS0au+t7p6mkzBmaAk4j6Au2dIA==
X-Google-Smtp-Source: ABdhPJyAThCZa/zBmHIFbY4iGsWkaL1FbA02flAYJWC/OYAUSKBAuRDs5KdvXwy+EwJlzMK7/CnNbA==
X-Received: by 2002:a37:4ed2:: with SMTP id c201mr604934qkb.138.1592427836755; 
 Wed, 17 Jun 2020 14:03:56 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:03:56 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 28/73] gdbstub: convert to cpu_halted
Date: Wed, 17 Jun 2020 17:01:46 -0400
Message-Id: <20200617210231.4393-29-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::744;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x744.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 gdbstub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 6950fd243f..b25796b33d 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2062,10 +2062,10 @@ static void handle_query_thread_extra(GdbCmdContext *gdb_ctx, void *user_ctx)
         g_autofree char *cpu_name =
             object_get_canonical_path_component(OBJECT(cpu));
         g_string_printf(rs, "%s %s [%s]", cpu_model, cpu_name,
-                        cpu->halted ? "halted " : "running");
+                        cpu_halted(cpu) ? "halted " : "running");
     } else {
         g_string_printf(rs, "CPU#%d [%s]", cpu->cpu_index,
-                        cpu->halted ? "halted " : "running");
+                                   cpu_halted(cpu) ? "halted " : "running");
     }
     trace_gdbstub_op_extra_info(rs->str);
     memtohex(gdbserver_state.str_buf, (uint8_t *)rs->str, rs->len);
-- 
2.17.1


