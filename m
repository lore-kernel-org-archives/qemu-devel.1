Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6017C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 12:57:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 734BB22D02
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 12:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZzigXOT3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 734BB22D02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxVMJ-00040O-Jt
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 08:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxVLL-0002IP-7i
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 08:56:31 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxVLI-0007IA-Cd
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 08:56:30 -0400
Received: by mail-wr1-x443.google.com with SMTP id 88so7465830wrh.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 05:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=2R6yuGy1KqPamHh7Iri9C1nOxQozqj4+DJfYR4M9wzg=;
 b=ZzigXOT3oCZHxaK5+lz6WdbPqbHF+1m3tPNF8Fcrfsg8c+lDgm3/lxv4sTsnSrq89M
 vEa36I9pyP8piN1jhHLArJRXCmukGBdVA9wGfysqM72s59r3mHloiCMiUUAg6PxRUNhP
 6GNdrBANIUbD0EWxaCnSDTPfB2E5GHUdp7vqLTgGxp6w46/GIvUkp93jt01DKjM/qsr0
 kEmp1HGpem9SLaoiyzmQAwteC6Bm+GZbuwHuE/isEfj9u4Gwjk1X5/NSbBMo556SSEVU
 MTOkiGCAm6EEup3tkreEdXAClPBum/yHvXA+4olMjKxS59lshYGhtmvu7UMryu0qSX19
 Ecgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2R6yuGy1KqPamHh7Iri9C1nOxQozqj4+DJfYR4M9wzg=;
 b=nhb7tiRYVpdvAjgsORxdbuWZJEDfBz2uxyfrfgsDiHeVwgxdNIPRFGMTPDcR2w8tHp
 EbrMUaRqO+VcOYBHU8jhd269vXPujOFDopPLPeB4a8u7A620ySejolH0HqH91GMEzH6T
 n225I1wnd/n3ztO1QBJTfoeIDn6JET5r+tbZaOOyAmn0kmRNcG0UhOUgaPWdx5BD0HWQ
 m9DWFRh0ls0U+Hhkl7d137Ty19L2GMi0VEyRkZOh22w/vV4rDiGKa/W3Os7k5b+ZIKHA
 SlujEyxgnzaoW2qlo1e1P8ISZLmRE3bOv8o4Ry7MA4j+PSL/V0CNqo8TacKOi6U0LvcA
 37sw==
X-Gm-Message-State: AOAM531S22JcLlIQsIk1EaPbqC10oawt1pH8FXFLgxbLkuZQyHMizzIW
 /T04UvTthhEWzSQy/54luW64V9kJ0mjI2Q==
X-Google-Smtp-Source: ABdhPJxKjQc86geRQVNg0sIVySMNMw2w2nrX2R3nBy0+ecPDuWl2Nnc8mWGqriRtYur4fo99zbgxBw==
X-Received: by 2002:a5d:6348:: with SMTP id b8mr4820927wrw.362.1595249786432; 
 Mon, 20 Jul 2020 05:56:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p29sm34025403wmi.43.2020.07.20.05.56.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 05:56:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/12] hw/arm/virt: Error for MTE enabled with KVM
Date: Mon, 20 Jul 2020 13:56:11 +0100
Message-Id: <20200720125621.13460-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200720125621.13460-1-peter.maydell@linaro.org>
References: <20200720125621.13460-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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

From: Richard Henderson <richard.henderson@linaro.org>

While we expect KVM to support MTE at some future point,
it certainly won't be ready in time for qemu 5.1.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200713213341.590275-3-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 5866c4ce202..a7f3d442db3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1773,6 +1773,12 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
+    if (vms->mte && kvm_enabled()) {
+        error_report("mach-virt: KVM does not support providing "
+                     "MTE to the guest CPU");
+        exit(1);
+    }
+
     create_fdt(vms);
 
     possible_cpus = mc->possible_cpu_arch_ids(machine);
-- 
2.20.1


