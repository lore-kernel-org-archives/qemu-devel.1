Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8471DC76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 13:15:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EBDA21921
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 13:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yRijLWEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EBDA21921
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpY9h-0000LY-L7
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 09:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47603)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hpY9B-0007Ny-H3
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:14:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hpY9A-00034f-H6
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:14:33 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:54279)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hpY9A-00033z-BA
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:14:32 -0400
Received: by mail-wm1-x336.google.com with SMTP id p74so35118453wme.4
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 06:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=GzeCjbtXLdqWVGSKySjABkNnwqpyaiVuNILnUkbYPsw=;
 b=yRijLWEG7gpaqi6/bGZUuADYOKXuwlIG5GTnp/YPnmHFlULLz2p6q5oES24a/UiNDo
 z8wvN79LI8wWOBmstyjFBqDo5YCN5JlJZLJvlE2k4YyoX6e53uR68AMN9AnpWxKTCtnI
 C2iqwQ+hpw5CD4LTvCJ8uSH+AHDqWdo8QtpLjVNOpLJrnY0WDmd35Z6cygKxsnlKIIII
 ef08ZWukToD6q+86XyY7W9Fdt6G0/u2LGHkRFrX4H3DORtzUJFMPht3tX7iG+rTfBYsS
 qXwviHJpuQz59aoWJqhy6rrA24mB0t6KPlVHo8OQt8aH9E7JD2VDY58sFn26T5nhwg8l
 rhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GzeCjbtXLdqWVGSKySjABkNnwqpyaiVuNILnUkbYPsw=;
 b=HGYbpkqxe5qS103JRpibgkaQ33+rF3x9akTqQSrHOTiZrmU40LDisKz6N5AQcRQaU3
 nYKxWMK3XRbJtKV1lS5RpSovcKLjK7/yYL79UautjtYSDoel1w/jCf1JsW/kqZHDlWz3
 apq2uIFaALBoMpbG8HbzXB/VmMNH1IeVIuIMhGimlHVGPbyynFxbe68vw+Ri1KlZnstl
 chMfU3si7EhuaDO5LpEEPGKsI9Q0e/sATulrbX2VQP8f1opbDfLYfGrE3Iorw+sjwmZv
 89HP5BHsnmlpRRon9Jx8iU80SEDd0Azz1U5AsCPSFz0tZYxQenddDr41FdyG+TlZKxFK
 fNmw==
X-Gm-Message-State: APjAAAVefrhva69toxQScj/Nnzz0vxf5Vu7I0FJNxW/AUJp17pbZb1gk
 HAfwXmEKhVnJri3BwhtRx0yWpHhm7N54yg==
X-Google-Smtp-Source: APXvYqzFewCPsLWBZ4vxLH6AdAMWX4Ou4foab2QGEXLCZ/xZAdzQ0r8QtUHB2jZ1E6EufzUIv4Cy2Q==
X-Received: by 2002:a1c:c188:: with SMTP id r130mr60520677wmf.73.1563801270907; 
 Mon, 22 Jul 2019 06:14:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f12sm42207217wrg.5.2019.07.22.06.14.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 22 Jul 2019 06:14:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 22 Jul 2019 14:14:23 +0100
Message-Id: <20190722131427.2669-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722131427.2669-1-peter.maydell@linaro.org>
References: <20190722131427.2669-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
Subject: [Qemu-devel] [PULL 1/5] target/arm: Add missing break statement for
 Hypervisor Trap Exception
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Reported by GCC9 when building with  -Wimplicit-fallthrough=2:

  target/arm/helper.c: In function ‘arm_cpu_do_interrupt_aarch32_hyp’:
  target/arm/helper.c:7958:14: error: this statement may fall through [-Werror=implicit-fallthrough=]
   7958 |         addr = 0x14;
        |         ~~~~~^~~~~~
  target/arm/helper.c:7959:5: note: here
   7959 |     default:
        |     ^~~~~~~
  cc1: all warnings being treated as errors

Fixes: b9bc21ff9f9
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reported-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20190719111451.12406-1-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 20f8728be11..b74c23a9bc0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7956,6 +7956,7 @@ static void arm_cpu_do_interrupt_aarch32_hyp(CPUState *cs)
         break;
     case EXCP_HYP_TRAP:
         addr = 0x14;
+        break;
     default:
         cpu_abort(cs, "Unhandled exception 0x%x\n", cs->exception_index);
     }
-- 
2.20.1


