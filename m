Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE9CC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 07:46:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0C2321707
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 07:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRVMlwH3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C2321707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVVIn-0005Gv-UN
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 03:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kVVG6-00014r-3q; Thu, 22 Oct 2020 03:43:38 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:36932)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kVVFr-0007eb-8g; Thu, 22 Oct 2020 03:43:37 -0400
Received: by mail-lj1-x243.google.com with SMTP id i2so894145ljg.4;
 Thu, 22 Oct 2020 00:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O+goKHHTPNQf+byU52c8msGIZZ/A616sN7JzkzNgsEM=;
 b=PRVMlwH3p9cdDtK/AJjNTto6KpeLjgX0dzV39nTWtIGeQQBLVi65h5aun2g4RA8nhf
 lRW4AmyV1C2HDSn7t+oqfo0mVRpCfTUIfWseFi9YAsY9aZh2j2/RJ4XJWguOthgxw51r
 9NL7u0VspkU+pxFuCq+gsvdM10aUiEvZSZe50ZIrCoHDCHNvC835qYXanB4fsVKo4t+b
 C0+zy9nlN/OVThqggR6JHQ+RuTIu8d26Myyrp6kBWxreHmMX10ep1jDtDzsI5XFJqQpl
 zrG5aPo5vFXepnMjYkl+6CmIK8Kev60HMUkjbkS5532VVW87B55OudRXcYyREzlr2GpE
 ePPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O+goKHHTPNQf+byU52c8msGIZZ/A616sN7JzkzNgsEM=;
 b=b6ILhd0Mmjraenu/mgas4+14kRAkDEsJXU2jx7Cs38vHah/Tz25MXvLkrF/FODErMd
 gkW4MXHOi1u3xhbPxdrwud8QXIJK07qp8OYmdCh1gXpsLqySiaIUCvXoKySOcjnvNDKo
 6K8XtMvza6Ik+E7P3qwowHjBGNmBysTmg2560f8hvjhzS8M3jGGVnta2j60hJlgax/wC
 J8rMW9qxNrk0jib6Sdffrao3rsZsmeW4h5eEuFoEj0qO3Q5Bu9C9kfrmoekBAKYYwo2y
 l6NpZXD4KAw1eFSTFS1v8k4oYEmYGCImr84V6IAPYKSioAqyRYJRuffi//SrES3/yInw
 oJfw==
X-Gm-Message-State: AOAM5323X6kv5CR5Gw7nxSSuAK0iV39IIV8Ir1DH2o3I744Ol2us5FQn
 psHD6CtUDtmq5HpG437e7EU=
X-Google-Smtp-Source: ABdhPJxTOrqgaVLzeKl/VvMQW/Bc2T5j2fVDZFWAjonNuJ+3L1Yyj3kEKpNOjivNK47y6+8HDzHwbQ==
X-Received: by 2002:a2e:9d3:: with SMTP id 202mr518428ljj.449.1603352601388;
 Thu, 22 Oct 2020 00:43:21 -0700 (PDT)
Received: from neptune.lab ([46.39.229.104])
 by smtp.googlemail.com with ESMTPSA id n19sm138887lfe.142.2020.10.22.00.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2020 00:43:20 -0700 (PDT)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <space.monkey.delivers@gmail.com>
To: 
Subject: [PATCH v5 6/6] [RISCV_PM] Allow experimental J-ext to be turned on
Date: Thu, 22 Oct 2020 10:43:09 +0300
Message-Id: <20201022074309.3210-7-space.monkey.delivers@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201022074309.3210-1-space.monkey.delivers@gmail.com>
References: <20201022074309.3210-1-space.monkey.delivers@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: baturo.alexey@gmail.com, qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, space.monkey.delivers@gmail.com,
 Alistair.Francis@wdc.com, kupokupokupopo@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexey Baturo <space.monkey.delivers@gmail.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1c00d9ea26..56633c14eb 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -465,6 +465,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         }
         if (cpu->cfg.ext_j) {
             env->mmte |= PM_EXT_INITIAL;
+            target_misa |= RVJ;
         }
         if (cpu->cfg.ext_v) {
             target_misa |= RVV;
-- 
2.20.1


