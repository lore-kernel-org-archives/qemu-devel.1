Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C6EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:21:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4ED320FC3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XM/7BK+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4ED320FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfUZ-0007Sw-VN
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEA-0003L8-Ik
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:10 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:43935)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfE6-0008W5-Ep
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:10 -0400
Received: by mail-qk1-x743.google.com with SMTP id j68so139639qkb.10
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kW0XRsqxaI6VAROraHDcJYsTCy7+fL1IiAmTn+bRRXA=;
 b=XM/7BK+/iHa4FBsC1UBLrfofa7/j6P5RMeFU/Ek8K59mhBj47wxLUaaCGpCbX4em5m
 5fM10wnUeGFErzBgK3m2N4P3Ht0oni0C5QoJt/6WV0s0AzRdxF8dwZyt221bV8PmDSPh
 7CpwRw6/TfY8uRmXXGZfWKwKpSPbGutShDsAja4MIamIvhBUv+ekuyUm4KgGCpUFB65q
 4b1xQeF3Ixs8gML2Uhe94Q34OPoQ8Qsi1jys6OlHJjcfKI9r80oQY12PZKzmsFd0Qvim
 ituAiAmJtsGTkUcI4HQenqDFJTHCdLXxdqaf7+RUdTEL3WyfFf4t6PSI9o4rk/0p/9H4
 rsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kW0XRsqxaI6VAROraHDcJYsTCy7+fL1IiAmTn+bRRXA=;
 b=VLTH/uXxWgFBG8vFj+mglvEkMmAtLoAkH5RnagPGKYH9VLm///qe7yK2O9NvYNtaMJ
 McTlvfajzr0Wwn9t1zIP2dQ5Lo3M5RWxlA/LM8c7sPZd1QitwYiHsuJFcBsrfMOkuk/2
 ku2hktJTeEt1rvsd5Bt6vSV8qVhudQgVcamj/77NEzHvJSWWCUffa0UlF87FmEIig2Zb
 IugHiGGN02MubmgVQzJFKEkjMsbfJLvsfifazGWwMheJ4mZkwwxKzIsZOYjJFbkbZjqS
 LKAtsq13ZBOqwhICMup9FhdjyP6Sm0esNXArrkYzTK4uUz32ZoNXBlv/sho7561Mo6PE
 wlIQ==
X-Gm-Message-State: AOAM5301He4jhU2eL3EO/HET25IG4lCA4pZpiyyJw3On5hVpAptjLB8y
 LFB4+IKmvEudWZ0eF7Pra+HTxnVPLU+WzA==
X-Google-Smtp-Source: ABdhPJxhTs+/3LWI+xZKLjMn+wzxlDw7mA8mFD6NxqHpAD82UqFp3nCcm+WmsCaIhKKn1IIntHs4iw==
X-Received: by 2002:a37:383:: with SMTP id 125mr522609qkd.487.1592427845272;
 Wed, 17 Jun 2020 14:04:05 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:04 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 34/73] exec: use cpu_reset_interrupt
Date: Wed, 17 Jun 2020 17:01:52 -0400
Message-Id: <20200617210231.4393-35-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::743;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x743.google.com
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
Cc: robert.foley@linaro.org, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, peter.puhov@linaro.org,
 alex.bennee@linaro.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index d6712fba7e..58fc928801 100644
--- a/exec.c
+++ b/exec.c
@@ -752,7 +752,7 @@ static int cpu_common_post_load(void *opaque, int version_id)
 
     /* 0x01 was CPU_INTERRUPT_EXIT. This line can be removed when the
        version_id is increased. */
-    cpu->interrupt_request &= ~0x01;
+    cpu_reset_interrupt(cpu, 1);
     tlb_flush(cpu);
 
     /* loadvm has just updated the content of RAM, bypassing the
-- 
2.17.1


