Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9C0C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:05:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6201322247
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DJCOG8D4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6201322247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUu8i-0006Pd-83
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu0z-000531-S2
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:33 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41873)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu0x-0003v7-Vx
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:33 -0400
Received: by mail-wr1-x441.google.com with SMTP id s9so2784557wro.8
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 08:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=aiSyOYix0/dW9DlAA5bSO54twllkW4GLLUBLNeGd4rE=;
 b=DJCOG8D4ZSoVm0+Il4H2fF01Q1mVTv3yJ+p3+ZZ7B8P7bEGR6/yrSN+FrOWtybMktD
 wyR8KSNUocrKJAsyGtSp6WiqOsMGuSkJteSNgSsUF3o9z/J7kqPKSQYeIBe0+jXeDNas
 NeGmbirh0O+/w7E7aoQLpTNmhmg4claKNU+btvuTPU1PTlPGCl78ljIgoNOv4BM9gO5e
 PD2OwErDHay2b4TevSVigug0dT053/BS13Sve3GNbty1ollJpYWyb6eDpCJQfengFVao
 WzXIC/P9vD0sN3GlZpvuCtdHe9EjyAl2rT3Ab9XQoMpTiDbtNq7ZRm9PYtjOjYcs79qp
 Ds9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aiSyOYix0/dW9DlAA5bSO54twllkW4GLLUBLNeGd4rE=;
 b=K2em0ZsDSFNfPgjNuZxlDmxsWQd4LOdrWRgWelhEBx67eltgfTf+quU0xW5Pttx/BY
 SCxwzFuNZKi+2pU2AuvWPY1GaNZZAcEQ8vdq8fBayKsdPBNzHVtyzYkCOdM/r8GjkUQi
 gZM5oVbbmGh+wUC6aOlNCUmgtE7QdOs1fNGtMm77xgLM7hsjFp33PBrKexMUUkN68r87
 CJfQ8j7baMbHtvmJWJwOwLteZbXfUPvPeJp3JCgUcFn3xSqwhuMLu94anvv88zRVsrHW
 UmEJ0bkj7NAmM1rEsTVwTxMAJBKMfsWaWPMJcynDUSt+NU1o9FEVsj27O+flfCnzxqnD
 MnGQ==
X-Gm-Message-State: AOAM530mYsuJCcLaWxd0fIzRI8VwOO1blA4vTheggrVHbby4poh95ljQ
 9yeATAAF5jy6r6WmurTXUPvXRDzWU01jIQ==
X-Google-Smtp-Source: ABdhPJwSzW1/2eeEi5M8EVdp8mEPPOR76+A+exOzW4lI7b6YmxoKdqyx6QGeC9rTFSA0Sxmnk6vuZg==
X-Received: by 2002:adf:fc51:: with SMTP id e17mr4133922wrs.45.1603209450410; 
 Tue, 20 Oct 2020 08:57:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v6sm3780205wrp.69.2020.10.20.08.57.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 08:57:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/41] hw/arm/nseries: Fix loading kernel image on n8x0 machines
Date: Tue, 20 Oct 2020 16:56:34 +0100
Message-Id: <20201020155656.8045-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020155656.8045-1-peter.maydell@linaro.org>
References: <20201020155656.8045-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Commit 7998beb9c2e removed the ram_size initialization in the
arm_boot_info structure, however it is used by arm_load_kernel().

Initialize the field to fix:

  $ qemu-system-arm -M n800 -append 'console=ttyS1' \
    -kernel meego-arm-n8x0-1.0.80.20100712.1431-vmlinuz-2.6.35~rc4-129.1-n8x0
  qemu-system-arm: kernel 'meego-arm-n8x0-1.0.80.20100712.1431-vmlinuz-2.6.35~rc4-129.1-n8x0' is too large to fit in RAM (kernel size 1964608, RAM size 0)

Noticed while running the test introduced in commit 050a82f0c5b
("tests/acceptance: Add a test for the N800 and N810 arm machines").

Fixes: 7998beb9c2e ("arm/nseries: use memdev for RAM")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-id: 20201019095148.1602119-1-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/nseries.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index e48092ca047..76fd7fe9854 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -1318,6 +1318,7 @@ static void n8x0_init(MachineState *machine,
         g_free(sz);
         exit(EXIT_FAILURE);
     }
+    binfo->ram_size = machine->ram_size;
 
     memory_region_add_subregion(get_system_memory(), OMAP2_Q2_BASE,
                                 machine->ram);
-- 
2.20.1


