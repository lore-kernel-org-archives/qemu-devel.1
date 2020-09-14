Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C35C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:14:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C5CC21655
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rB1kjDZx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5CC21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHpFF-0005Uz-Ha
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 10:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8N-0002hB-3c
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:07 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39467)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8L-0007b8-Ca
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:06 -0400
Received: by mail-wr1-x443.google.com with SMTP id a17so18900576wrn.6
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=D5qunu0CTAqDwxFmW0nXsux9porA4hJjQp+c3oiNwKw=;
 b=rB1kjDZxLsvXma6ltfL7AYJ/zFtuigYFJK+yKOKfL/+vJRqrbmSuCbCJ+9+9aqnkTN
 PkqHXVQhKvNlwYbJfYxI21N8XTprrSNAI/DTmlMX2PQ1Qex6IRYYYZTzlsaFfLqD/UFN
 +bKWby4k92SmHKhPPmSyofNOR41uSem4JAUwZ5RGNpvhiuwu64vLnqL4is2tirBS2gzZ
 H4rjfzvt9hmylie9y46P7ji73yav9TmQwCA5/E3LCFVD+ekv6IRS375ZJ6bFNE35hC5e
 RHOpXZw5uojP5GObvyu8LElpHg9CT/+ZoLFoLBTfVNTB9pIv5aNpspPKrNn9RmXXBt03
 LVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D5qunu0CTAqDwxFmW0nXsux9porA4hJjQp+c3oiNwKw=;
 b=Tqf6CkKHyPctEzS2QCX+rP6KcH/F8BoLWbaabIiwU13NrXHJ352x929SFiwU4lmwhE
 lzLhaurQeJHYImWy67u2F+5w/ZfvvjIJf8kyVCPDekn6XOMh1vcY40h4jr17RF1g8MFE
 72wwiQesBl85+eLITOwT7Q003ZFMzbxDjfd0RWZ+Neoa21Iq7gELAYIlL4gj/F61NY37
 KSgjKerWToSh6pw+XnrYZQQPxsTKh88Yl9E2U00t+KTMe46bUkhsbXDkEzlhSudKNJqZ
 83vy2q7ZmMVP7egne/DEcKwSpzG+PFnGpIfd19uIFizXwEp1B7TwCHwiy101XgKuYEK1
 FzkA==
X-Gm-Message-State: AOAM53072VkhR7Y9SEMLlzHSgz/lN1kZJ7jMxGBlAkiT3VvqfLmQYQ5D
 wmHhRllhbQaih6telY6mjB2tuzcGk03cn2On
X-Google-Smtp-Source: ABdhPJwqISjxmuWt3eBvolgeHYOYkyeOwYJNrIZ1mig8lzdqLv+MGyvG1Z/qF2Ar2c1BcNUSrz8wvw==
X-Received: by 2002:a5d:6cb1:: with SMTP id a17mr11833601wra.386.1600092423630; 
 Mon, 14 Sep 2020 07:07:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x16sm20834041wrq.62.2020.09.14.07.07.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 07:07:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/36] hw/arm: versal-virt: Correct the tx/rx GEM clocks
Date: Mon, 14 Sep 2020 15:06:23 +0100
Message-Id: <20200914140641.21369-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914140641.21369-1-peter.maydell@linaro.org>
References: <20200914140641.21369-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
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

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Correct the GEMs tx/rx clocks to use the 125Mhz fixed-clock.
This matches the setup with the fixed-link 100Mbit PHY.
It also avoids the following warnings from the Linux kernel
driver:

eth0: unable to generate target frequency: 125000000 Hz

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20200909174647.662864-2-edgar.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-versal-virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 5a01e856fd9..1f9409eb32a 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -214,7 +214,7 @@ static void fdt_add_gem_nodes(VersalVirt *s)
                               s->phandle.ethernet_phy[i]);
         qemu_fdt_setprop_cells(s->fdt, name, "clocks",
                                s->phandle.clk_25Mhz, s->phandle.clk_25Mhz,
-                               s->phandle.clk_25Mhz, s->phandle.clk_25Mhz);
+                               s->phandle.clk_125Mhz, s->phandle.clk_125Mhz);
         qemu_fdt_setprop(s->fdt, name, "clock-names",
                          clocknames, sizeof(clocknames));
         qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
-- 
2.20.1


