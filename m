Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EAAC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 00:48:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43B652076B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 00:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V4SZ0rI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B652076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kILcQ-00083c-CZ
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 20:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kILaz-0006KY-DI
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 20:46:49 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e]:35395)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kILax-0001Wt-Uv
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 20:46:49 -0400
Received: by mail-pj1-x102e.google.com with SMTP id jw11so651274pjb.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 17:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dqbg1+YUD56oz0mEVRHEVZEpbEBWoWejpoX6YFZKEQU=;
 b=V4SZ0rI5iaEkHjBOYajV8wfP166DB7wHEjOLKMGwCBLD0HZlXs+HqwlB9dyXR6h5YD
 eXylJy52HH2bIJx+N6TbnJ/29tJ9gFGq+TfoZv3Zo2+eAfC4A7a94wqY2UrUFAmCVIsk
 tssV5c6rNM7E5S7A2Xq0EE11VI6ivpzcqMfOlSIY6tdyWZV+zij/ai1pArOZcUS4VMQA
 Ys+/kq37QgJeROu4ay8yPMki5IFXVOLKmaNvqRORf9YgSwIOkErvZ3AbjYV0zV4noqPT
 mdZ94XDQ/9wsFWBIaDHewPKZXN3RErshA+oPQcne0LwFzmcenkTneWQQJvyhlNjsNfHl
 3XMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dqbg1+YUD56oz0mEVRHEVZEpbEBWoWejpoX6YFZKEQU=;
 b=CYrlQPUTUfd48AMQFlXHkZUpfrYs4WGX45zedxap6lm2LguE3NiU7dtLw0ZdXySy5y
 JhEqAg6AlEViW1T89Wr0LSqiDsYHKK5ARYRfG5XxmXHDA/fv8Vu+b+uzuO2cQkER8wxs
 jW+h3gLRgKBEY98i+8wvz22XnwM4p4ZVUYFY3qMtWDj8RvdervykTqTC/v2QogzPNJt8
 Fm+dOmOwuxMAZ2n/+HeWYHJ1KUywSZ0Ee6qxlddonkXGQLYMuuEM0HllixBRYiYQlZ+5
 SL/vJ6cV1L4N3ad/Pr4K9v7dkfRsow3OxY1qgnKItuSTAmE/ItG6O8y7vtEiqEmrszQ/
 CTfw==
X-Gm-Message-State: AOAM530DRsW5Eucvhlcwnnjf8GZucFhqPlAGXtQc8v7E+ntBkzWJDZT5
 ESKWtLp7jsaGFkL40i+UtbmfG0lyylz8Kw==
X-Google-Smtp-Source: ABdhPJyB0a6HD1odyvXgF/38HdPTjf6DkmeoNFdyBFVad/ZfeBolhbcsjiNw6CZ4BFbrhrH4EdL3bw==
X-Received: by 2002:a17:90b:793:: with SMTP id
 l19mr1728901pjz.154.1600217206348; 
 Tue, 15 Sep 2020 17:46:46 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id kf10sm611723pjb.2.2020.09.15.17.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 17:46:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/6] target/riscv: Set instance_align on RISCVCPU TypeInfo
Date: Tue, 15 Sep 2020 17:46:37 -0700
Message-Id: <20200916004638.2444147-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916004638.2444147-1-richard.henderson@linaro.org>
References: <20200916004638.2444147-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix alignment of CPURISCVState.vreg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Cc: qemu-riscv@nongnu.org
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 57c006df5d..0bbfd7f457 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -628,6 +628,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .name = TYPE_RISCV_CPU,
         .parent = TYPE_CPU,
         .instance_size = sizeof(RISCVCPU),
+        .instance_align = __alignof__(RISCVCPU),
         .instance_init = riscv_cpu_init,
         .abstract = true,
         .class_size = sizeof(RISCVCPUClass),
-- 
2.25.1


