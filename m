Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FD2C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:03:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ED2A206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xnPgdrd4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED2A206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYia-0002OV-Go
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 16:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKl-0007G5-5D
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKj-0001qd-AW
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:30 -0400
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:44237)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYKj-0001pK-4b
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:29 -0400
Received: by mail-qv1-xf44.google.com with SMTP id ef12so1652725qvb.11
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UAoGpC+tFU+Lrmci3F+3S0Zh/4YRyJd+sLsoLGG3MBc=;
 b=xnPgdrd4XCBnujsdtHIjW8bs30NxJVXFvNVCfxmI6xWv1tF4C3acu3/eY/R/A9lbiL
 bba09HpLfH9rND1SFpn12jq+g9jKzYQB4upYy0h/mqeexNUbGb1b6iVF2zwCy+DOjMRn
 wj8/T+hNCdIVrYVwGB7pfkfyNaj35FQOGVUlbvFe4AiZLEEiqPez/FInn7GMuyfZWh3p
 1tV8HDJcNoWy8rkTErFctDccXreABcyEi7OYgMEdZzW5gpdT/cwzbqtzTAztVnE72Z8T
 XFCpQ4mZaw0p/uywHDDXuB85ruuDQPhMXzHlIGhIwItVbWJctI9vC877nYFk4WMHKRwW
 UT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UAoGpC+tFU+Lrmci3F+3S0Zh/4YRyJd+sLsoLGG3MBc=;
 b=RZFQKANQnsdQYu5oh25CpsGS/xO3vwVJYOfYML1ezKiF63GPEpvzM0BI5O2mufyZuA
 yGJRu92fYQ//ECeBviv2YqKy7/iEnw+Tlyg8TS0NbqtD76OEMq4dkFt33DsNvDBcqlrL
 cS6G0CDzneW9tedH8QppcBJ6MDD561pVU2gDnkqFuEqFJ+6tZQdMsc8FAq/LMvbkkg78
 gC3PsKgNVvous1ZeykA6ZeQHFiFxQlOAY6LbbfiyFvOLK4znpObNgUupw8NKZwhts+7W
 MxDrHs/tJ76jvQaCMDNauyyFyCqg0I63+q/wta2Z0JrAhDFOnVAs8g+xKu3ZB+uTk1A1
 5nwA==
X-Gm-Message-State: ANhLgQ379KyTIPnk98j2hBJnIhcSgMmS3UNoTj57ofs9/GZoAgBjI0MU
 EjAyUeOGemvAzSd7a/jwoXp6UqEZuwsPnw==
X-Google-Smtp-Source: ADFU+vtRvmYX7SGsoflU35VztZTLuW/VT7LzPodSySSDgNET5TKRtDCTJa6xlHpqDpEyHqCfY6egug==
X-Received: by 2002:a0c:fc03:: with SMTP id z3mr9578539qvo.210.1585251506583; 
 Thu, 26 Mar 2020 12:38:26 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:26 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 38/74] openrisc: use cpu_reset_interrupt
Date: Thu, 26 Mar 2020 15:31:20 -0400
Message-Id: <20200326193156.4322-39-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f44
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
Cc: robert.foley@linaro.org, richard.henderson@linaro.org,
 "Emilio G . Cota" <cota@braap.org>, peter.puhov@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, Stafford Horne <shorne@gmail.com>,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Cc: Stafford Horne <shorne@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/openrisc/sys_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 2615571ce7..e54c148d4f 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -167,7 +167,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
                 env->ttmr = (rb & ~TTMR_IP) | ip;
             } else {    /* Clear IP bit.  */
                 env->ttmr = rb & ~TTMR_IP;
-                cs->interrupt_request &= ~CPU_INTERRUPT_TIMER;
+                cpu_reset_interrupt(cs, CPU_INTERRUPT_TIMER);
             }
 
             cpu_openrisc_timer_update(cpu);
-- 
2.17.1


