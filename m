Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCB5C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:45:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8595E2166E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FSHBi39k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8595E2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfsA-00052S-Ou
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEl-0004S4-IF
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:47 -0400
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43]:41391)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEh-0000NJ-QR
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:47 -0400
Received: by mail-qv1-xf43.google.com with SMTP id er17so1756991qvb.8
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E2rKLqGPhEt5KLMSHY+b9yS/ljZbSYYEkJSY3sQ9lfk=;
 b=FSHBi39kWjJXbvfD+LjWVR+egqIhudII4Eiv+X3PtmHKMB/5fA96rUFM7ElEP3NpI0
 +dF6oTriVZpfDZXmu7dHfhcLQ1ZLv6oA7+6PBbAY3P67/PILpMs7cS8ID4g4WF5ar92C
 aZQPZifbTDs0muaferUZR4YgSGSl+xXUZJLMcl4TmDX/f7AgmZVotbWaYcRnu0SsYHnW
 4G4elB34Y893JR3oePpDqkbP8sjZ8dk4GPCRSEsYjSKbJP0zEmstNu91fdCBYXlBFQVw
 ABCICIyaDo13RX517oCP4EsLUTIs4eCr/U4hR/8XjDVMZzgtVjkYFpTCMlPse2EozqNg
 am3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E2rKLqGPhEt5KLMSHY+b9yS/ljZbSYYEkJSY3sQ9lfk=;
 b=D4iyly/0HSuoLneic4llFbIdamYrQzXbi+mBA+E8khNzYr47DDzXA1+U07f8f7rK3O
 wj+MrXbRP8a5clwdgaFu39StmJOBughZCH7BQAqqzOr1avqjVOp8R4nkD2i7mXr01VQN
 trYUame4TpNupihmz/yFtPnP2aE+VGEKE3dfhUJ9jZ7eY6pIi6slPCI8I3efPcKf+JRV
 up1FScExszeD+9Zhxy1LWV8wzoBJkqXWpfHuq6DxW2JmxKwaVqL9rrDc/INph//+0/Dw
 MW0s2uPovlwvaIYKhlkWaK038mtNobmoFYpMhiBUWv97011dAGCdlMkj0RfWRC9mJQfD
 I+cw==
X-Gm-Message-State: AOAM531b3xyyRheKTqiPEUgT6xhi/o9ZPRV3OhnO4CzJTSUXPYYQt2pA
 lo0OpgdPLomSYPStS1nmpDZjp76c/sVFfw==
X-Google-Smtp-Source: ABdhPJyV9c1DOWH0BDXp+eroMssVKvn5BAvJRmUG+WURzvFGQPPGAMiKKfJ2PT7JgCLp//6cUZCXAQ==
X-Received: by 2002:a05:6214:1432:: with SMTP id
 o18mr551765qvx.57.1592427882239; 
 Wed, 17 Jun 2020 14:04:42 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:41 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 60/73] cpu: convert to interrupt_request
Date: Wed, 17 Jun 2020 17:02:18 -0400
Message-Id: <20200617210231.4393-61-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f43;
 envelope-from=robert.foley@linaro.org; helo=mail-qv1-xf43.google.com
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
Cc: robert.foley@linaro.org, cota@braap.org, peter.puhov@linaro.org,
 alex.bennee@linaro.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

This finishes the conversion to interrupt_request.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 hw/core/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index d3223f6d42..59f02594a3 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -273,7 +273,7 @@ static void cpu_common_reset(DeviceState *dev)
         log_cpu_state(cpu, cc->reset_dump_flags);
     }
 
-    cpu->interrupt_request = 0;
+    cpu_interrupt_request_set(cpu, 0);
     cpu_halted_set(cpu, 0);
     cpu->mem_io_pc = 0;
     cpu->icount_extra = 0;
@@ -413,7 +413,7 @@ static vaddr cpu_adjust_watchpoint_address(CPUState *cpu, vaddr addr, int len)
 
 static void generic_handle_interrupt(CPUState *cpu, int mask)
 {
-    cpu->interrupt_request |= mask;
+    cpu_interrupt_request_or(cpu, mask);
 
     if (!qemu_cpu_is_self(cpu)) {
         qemu_cpu_kick(cpu);
-- 
2.17.1


