Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A2AC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 18:07:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E430920936
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 18:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wIMVXKQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E430920936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIFMI-0001Wp-15
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 14:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIF2b-0001fO-3J
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:46:53 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45324)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIF2T-0007G1-8J
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:46:52 -0400
Received: by mail-pf1-x441.google.com with SMTP id k15so2351090pfc.12
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 10:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dqbg1+YUD56oz0mEVRHEVZEpbEBWoWejpoX6YFZKEQU=;
 b=wIMVXKQ7A9wqMV6ahF3x93b67teFXTMtRtMBgKFJlMtmwUbP0oEe3XInieb3KuYQOG
 KiyAECgOBhhGh7lAmlBzF9JA5F2+IcEz84xSlAh78slltADr9TJS8wQ4+Mb51fSZ0fF1
 OMINPJCzzzJwcHshlmNwReuj4YtxvFSIV0gWOJ2NM3OsWbc/L0Dvy4hN90ohEvJzokBO
 LjH/0YIMQ/q3+yir565kq1rzenX9UoEYl6c1XsGUpkuTBKTvtLCIOFP6ROTC5Be4gCNn
 t1gu72yQqYlI7hg+aznPw4jeectTZnlwy+2oIwhTeh6tLoSCMTUQCrCAL7D5ua+H5itn
 UthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dqbg1+YUD56oz0mEVRHEVZEpbEBWoWejpoX6YFZKEQU=;
 b=Z2rgEU+1IHY8SzeBLgcroxZ5Jdj4GKocBvuUGhmajMHEzr9O9YT10QBPaNB+eARB9z
 DcDanMfniVjW3xMkC5mnWBFwdeJhfp9pf/HXhdV7AKsOzkyjWvpu3Rc1YEOOTGfd4yKd
 AuB88eSBMj6ZbXjICqNucVAyBuzSp89hBfq8aaJ5+D5a5uQ9Zu+0EUMz62gOArDtvc/p
 L/qwUkCRsSzAcFGehuk1IX1YQftOA9+DfMdahIMJ+qWo8zZhLxGpEWlRoe/Zk7akvCKF
 ra7LAz2I3kMPnmiGcOdGmTTN9WeaD1xjyTuAm7Ogs4gWWjnFqeo61Ob6lGoSS3xSCwd5
 FC5A==
X-Gm-Message-State: AOAM531M/HO8LOZ8dEQ1t41jl2qI+Ta+W7fkFGpqZo2KlFLj/lkjDPDW
 +eIuppnZcfFcxfHi1/qc2zK1RHGRSc3lzg==
X-Google-Smtp-Source: ABdhPJzeP40a2R73hVlHspFFH3oT/sMTNQWEuJ4nQfNH1+17WZu5COItofZZYVlIQKycfXM1e7MZYg==
X-Received: by 2002:a65:624d:: with SMTP id q13mr10219029pgv.237.1600192001890; 
 Tue, 15 Sep 2020 10:46:41 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id cf7sm147896pjb.52.2020.09.15.10.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 10:46:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/5] target/riscv: Set instance_align on RISCVCPU TypeInfo
Date: Tue, 15 Sep 2020 10:46:34 -0700
Message-Id: <20200915174635.2333553-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200915174635.2333553-1-richard.henderson@linaro.org>
References: <20200915174635.2333553-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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


