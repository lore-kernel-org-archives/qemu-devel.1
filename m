Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07830C2D0CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:37:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6DDE217F4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jS8WIY5j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6DDE217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu5tU-00065e-6c
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 21:37:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iu5pl-0001Ab-Kx
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:33:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iu5pk-0001zT-I2
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:33:33 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:39760)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iu5pk-0001z6-C4
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:33:32 -0500
Received: by mail-pj1-x1042.google.com with SMTP id e11so2635043pjt.4
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 18:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LyaUkwCB5pGZjL9QvGR1TmTQePhraVEHq9yGAmQ9nZc=;
 b=jS8WIY5jn7QUqtD1vMXlFlqB3+ZWDYdnTQRfESwZiWps9NsmsD69Lo0aoSB0LfNzT3
 MfgW57GQOcbF2U+gC02A8P1YzSc82dUg5eYmeuUNYpdeva5JnBUglrYdoBuSjyyXSrnq
 aF8Qbx5HdymNeaEQCMHQsaPnonqfjulv0GPDv5yX1svDUhGekcHIVTKsFufyREckTGgn
 fnz83kH9nCrpeRk2mz8DBsj1RtlrsL8tlTxfWj7yQXp1aRwBuR/r4lcp6elPKJN9xZzX
 j0ujs4p+noDICBTlHFfYv9MsHlhbsGmYhvRo0+1Wh63VEfbJ3qHQN+R8svfEUfvowcyt
 BF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LyaUkwCB5pGZjL9QvGR1TmTQePhraVEHq9yGAmQ9nZc=;
 b=lHzSKPRXCOk68gKUT09I2s3YicgLQAlPf3vqId+fIeVCIsDcZL9YQ54eJhAEZYPF/9
 uR0vQYVWc8x3PQD0VRCfgiL1gYwxuYGRvXWjytaXcnVbS2usW356kdffVyGpgTdrqcjq
 hvbDrWxJd2mbZ4GmmtIFNFrtF9Oh98azO8LGlDTuzTKJkl7+fYWsB+WfemrXsAd/vc8s
 OtgxUG4HrJ1yXYVxmLKu2SZ+0sJG/MHEd2tqMrKbmFpT0hEp+ajWBRE4uilw0EMxqhqq
 ucOy19Yy+adXQ4b9tg+nYxdSBG8/kaPmrz/Ot7ZC3D1m+UgCa90TtTXpSXfIluqtC3Uh
 f8nA==
X-Gm-Message-State: APjAAAVFX7vmKwPR7U/+I9bdrbKOyAqzTd24u6zFCX56Ya44yTFxRvHP
 vPlGelTrTl6QGd1E2OamsCrxMXIlB0M=
X-Google-Smtp-Source: APXvYqw+jGSupeP23ec0Ay5SkGgrtiTM0Ndc/qAHRqChBXgY//X5a5Kc7eUVdBZX4xX1s0bOKBmXjQ==
X-Received: by 2002:a17:902:b40b:: with SMTP id
 x11mr8833755plr.268.1579660411022; 
 Tue, 21 Jan 2020 18:33:31 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id t1sm42935209pgq.23.2020.01.21.18.33.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 18:33:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/11] hw/hppa/machine: Map the PDC memory region with higher
 priority
Date: Tue, 21 Jan 2020 16:32:55 -1000
Message-Id: <20200122023256.27556-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200122023256.27556-1-richard.henderson@linaro.org>
References: <20200122023256.27556-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: peter.maydell@linaro.org, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The region in range [0xf0000000 - 0xf1000000] is the PDC area
(Processor Dependent Code), where the firmware is loaded.
This region has higher priority than the main memory.

When the machine has more than 3840MB of RAM, there is an
overlap. Since the PDC is closer to the CPU in the bus
hierarchy, it gets accessed first, and the CPU does not have
access to the RAM in this range.

To model the same behavior and keep a simple memory layout,
reduce the priority of the RAM region. The PDC region ends
overlapping the RAM.

Acked-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200109000525.24744-4-f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/hppa/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 57cb4e0f34..2d62a248b8 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -100,7 +100,7 @@ static void machine_hppa_init(MachineState *machine)
     ram_region = g_new(MemoryRegion, 1);
     memory_region_allocate_system_memory(ram_region, OBJECT(machine),
                                          "ram", ram_size);
-    memory_region_add_subregion(addr_space, 0, ram_region);
+    memory_region_add_subregion_overlap(addr_space, 0, ram_region, -1);
 
     /* Init Lasi chip */
     lasi_init(addr_space);
-- 
2.20.1


