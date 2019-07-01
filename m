Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AE7C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 22:43:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5784A2064A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 22:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xfg4lYen"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5784A2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi513-0006tf-1Y
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 18:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45879)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3P3-0001H0-IT
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:00:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3Oz-00086X-7O
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:59:54 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:51543)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi3Ox-000728-Ve
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:59:52 -0400
Received: by mail-wm1-f52.google.com with SMTP id 207so847871wma.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 13:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=XcLWFdKkB/rUAkrzuf/RQAaPaI22ZL/bi/Hf38//vjk=;
 b=xfg4lYenWKCBHy7ePukdANVAbk1D+y8auxwxywxKbpsI6Zfn478I6fhU3RUYEjGEVZ
 cwcZEZPZJoMbnSalfkeL6GSYfX8B7RIs1jnLLpwZluXo7jXhqPOV1UmzO4pi/+03YqG/
 lFO+0x5ltpJeYt9QHG7yq0BbDaLvvafbsdOY1JAXRI1UIrY4q2du3oAIIhxl+HKlE7Px
 +Cclxd+VtXVMxeYprcozfPNek8LY7MYcbbUC0vcGOHesMc0aSGMd4eIKAlt/5hzvWW0k
 BF7zPpgb10z59V/zvUQW2zY1k9a3Wf3toB+xMnS/pS6QeRhfQrPiZ5EQdLWy6Mb+cD+n
 rpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XcLWFdKkB/rUAkrzuf/RQAaPaI22ZL/bi/Hf38//vjk=;
 b=B1lnuJ/4lFhT3cLcEKVNVj36vfXrPj9jmic+qPrgrkyZqIm476iqhxzQMf8JfeZN7b
 W1A18uYngyZ8kmma0mtwyhUsmnR+cutb5EGTGRHCFxIzoQIOot0K3AHcF5HHyez2DhkT
 5LCDGQfEOWiIm/BAWQOrBzrfA03gYNANDeKUe5BWMs1ddWDtD9yyMd19LG9aoC+0rO/7
 fssNcXEQL8O+c+AZ10f2NkFxS1dZtwBKIwq2L5Hq50q9UxaemnJF2Cy982eeDW+zmQeX
 NIuDPBJ4HWT7ly4cUner7KAsSOcQcPvBVI87a/xf6XXblHOtM4/TfEmL1RKAE7cuxCY4
 pqug==
X-Gm-Message-State: APjAAAVmt0N1V+PLPGzxjhY4ImG74XXhZICPDABDfD0IOaGz3PhH6MFB
 jq7BO2H0yQ7oXr/bkCc46AHAeIm6+dD95A==
X-Google-Smtp-Source: APXvYqxnJwHbdfzH4lrHoepapVEo340M4TINf2VSH610Un69v+f5ePiplg7Ko8dJ75XZkgJUqKZT0Q==
X-Received: by 2002:a7b:c774:: with SMTP id x20mr145125wmk.30.1561999234274;
 Mon, 01 Jul 2019 09:40:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.40.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:40:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:41 +0100
Message-Id: <20190701163943.22313-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.52
Subject: [Qemu-devel] [PULL 44/46] target/arm: Restrict PSCI to TCG
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

Under KVM, the kernel gets the HVC call and handle the PSCI requests.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190701132516.26392-20-philmd@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 46a1313d69d..57e0253ef48 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -529,11 +529,15 @@ vaddr arm_adjust_watchpoint_address(CPUState *cs, vaddr addr, int len);
 /* Callback function for when a watchpoint or breakpoint triggers. */
 void arm_debug_excp_handler(CPUState *cs);
 
-#ifdef CONFIG_USER_ONLY
+#if defined(CONFIG_USER_ONLY) || !defined(CONFIG_TCG)
 static inline bool arm_is_psci_call(ARMCPU *cpu, int excp_type)
 {
     return false;
 }
+static inline void arm_handle_psci_call(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
 #else
 /* Return true if the r0/x0 value indicates that this SMC/HVC is a PSCI call. */
 bool arm_is_psci_call(ARMCPU *cpu, int excp_type);
-- 
2.20.1


