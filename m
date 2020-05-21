Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435D8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:01:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F362E207F7
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dofwbhIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F362E207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboZy-00048v-1U
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIV-000367-Ly
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:55 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:37282)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIU-0006Z8-QW
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:55 -0400
Received: by mail-qk1-x744.google.com with SMTP id m11so7881267qka.4
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=r3ihf6Hm5TzP8tkXXmmJd+HhpHTqUNEyVizEpWsgvtc=;
 b=dofwbhIQEtWvVwznSPn68P9c4ugfBCTexDdljcODqQWG+DjyYOY5lP7pauQpAYMjjL
 +aXx0gqXBKheKyeehSQQFJLgDNZ1SGDybjZauKqFAOsNrI0U3goLecHNVlRhKHq6C50A
 FchHgD+Xf+qTIuoz1daCb4X/xU5kCbrAuJ6vxm/4+uDsM/kOZHP4T3SZfrEGqO1OC4SJ
 AWVQ36HblfaL7N5JeJXOz2t9y+FEBjSSIgnLbEsAU0O7iddzyrbsEXAUxoWTbRLvtX9T
 aGfY1h8AbsWMwB8Rd8HeBXzWl1Xqo+a6o6GumqKs7IQhpzn6bdY8FS4x9lNzLEjaX+Zs
 rx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=r3ihf6Hm5TzP8tkXXmmJd+HhpHTqUNEyVizEpWsgvtc=;
 b=gyLB74qVdmyUt258HL7zE1KQsQcuEfMJBvL0zxeoJpex1LRtSqp16OQV8X/PbaeCwo
 TeE8F6MjScb71syhYi+xJQxM5fqw5SeIFLrgEVD7OPd7Hzm59kNi0ZedIX+qHBWjFcSe
 Az/PdElspcZkpNEP3pb4LRrBJHk3w13f+fjrMFmeLnl65l9KsHbPbdGsfPozm9aK2dLK
 KsNTiZML059+9Wu7smavWULeddEMa7WHSICAL/Q7YCul+FwEKUJixvSeX3l2u5Mmjlf3
 DrJReBIO1vj1leIvvhayE1QJcUOjD8IxqWU5bd1GnpxB5eVZOonlgsULQxIYe8SDjbRE
 75yg==
X-Gm-Message-State: AOAM532iFTUGCZZBIIcEfidzwpMMmHCszMwTsxLNKATs7u8OhHfAdIDV
 lVOCaIuMJ8gQo41fMpdZklNjFIKiGT8p9Q==
X-Google-Smtp-Source: ABdhPJwl7FNruas9E/6C2KUyEKPpuIlgq7JHEyLeL/y4PTGdEoF+Hz7JoKctY+EQEdSsVLgv2amh2Q==
X-Received: by 2002:a37:6fc3:: with SMTP id k186mr7870093qkc.419.1590079433750; 
 Thu, 21 May 2020 09:43:53 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:43:53 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 29/74] gdbstub: convert to cpu_halted
Date: Thu, 21 May 2020 12:39:26 -0400
Message-Id: <20200521164011.638-30-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: richard.henderson@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
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


