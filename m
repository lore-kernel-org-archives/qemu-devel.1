Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3903C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:54:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7889720861
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nRp4TDwe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7889720861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50644 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcvqM-00011S-Ol
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 13:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50690)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcvot-0007fK-Sw
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcvos-0000bz-AG
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:53:27 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:56117)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcvos-0000ag-1I
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:53:26 -0400
Received: by mail-wm1-x341.google.com with SMTP id a15so316309wmj.5
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 10:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=tkA5eV6B+7bWXMQLTUuNg6Ny6QzZoudF4r4qdXt2dKw=;
 b=nRp4TDwedZ2bj3uvzCgOxbHGnnIMrSlYGOSYYiyHPYh1po1TWvybV6Pwlhl7Fq2Vby
 37y1NjDzBOxUP72RK+H8m6+/ciJ3epPK9nK1chEsySdwlhzBZgO6JqJUqhKSBsdnu90f
 lNXgKc0U/B/pBM8ZBS1VrHhce79nNl92Oi6InE1A9HvZDHhECJMYF9trq6ZPpSUL8Yn5
 KfH0mLxTTPLq22qX2DyQIRaA75ecrOOaKbYcQpfrMcsMBSbP/ReX40n+M0P4YINsNQ3y
 WsVmdC/B/c3RacMMyl+i1hjcES2ifsNFXqa1zjTbt4wG6jKCLO21neU0DvVSAuzO2XHo
 gOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tkA5eV6B+7bWXMQLTUuNg6Ny6QzZoudF4r4qdXt2dKw=;
 b=NJrC+Zpr6iDKOQ2WpGdm1J0pN8VT9vTELYBZnrgh1cUc8SQ9wi5r/LC7kFy5CY4RH0
 WMVDLTB7mmd3+ak+Nx9TGGRHbIn3gr+N/v9JVb4UYPIHEPpVuEw80qEBAkG3AvP9nZ7I
 IX7Ivr2BvKGFth2LAqof4JdVsBvm1Gw54mE2bJoQCWtO/DnDXzg2dMj1I6P88rAiW0yb
 5TiBksHXR/C9voOx+OC6F/o8Lz3hLY5hj6p0veLperoy3jSFRlnAMuXl9Ox1pZTGMfrG
 L03pyDaOTPDcLb9BjuPtMocwW1viVp4rXFwsOLLbV/ArBgCKmgBNc2Rj8Bzq7KxJVTb9
 Impg==
X-Gm-Message-State: APjAAAX0m8/0+xo5uJDVkUbX8DjgfSCQNT7Pg0qyUINqMLuIfk/PSZ/U
 sdPJNp45Ym8djQgrHOJqutFSpX5SF7bq3g==
X-Google-Smtp-Source: APXvYqx9OEZbQtxsL8JhzH1yuefk1SoZsB4UJixrCj4o8Fj+emBi9j7Ma5CGZzcuII0l30m3uiEeXQ==
X-Received: by 2002:a05:600c:c6:: with SMTP id
 u6mr20220508wmm.153.1560794003623; 
 Mon, 17 Jun 2019 10:53:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t14sm8713619wrr.33.2019.06.17.10.53.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 10:53:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 18:53:14 +0100
Message-Id: <20190617175317.27557-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617175317.27557-1-peter.maydell@linaro.org>
References: <20190617175317.27557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH 3/6] target/arm: v8M: Check state of exception
 being returned from
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

In v8M, an attempt to return from an exception which is not
active is an illegal exception return. For this purpose,
exceptions which can configurably target either Secure or
NonSecure are not considered to be active if they are
configured for the opposite security state for the one
we're trying to return from (eg attempt to return from
an NS NMI but NMI targets Secure). In the pseudocode this
is handled by IsActiveForState().

Detect this case rather than counting an active exception
possibly of the wrong security state as being sufficient.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 330eb728dd5..9f8f0d3ff55 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -860,7 +860,19 @@ int armv7m_nvic_complete_irq(void *opaque, int irq, bool secure)
         return -1;
     }
 
-    ret = nvic_rettobase(s);
+    /*
+     * If this is a configurable exception and it is currently
+     * targeting the opposite security state from the one we're trying
+     * to complete it for, this counts as an illegal exception return.
+     * We still need to deactivate whatever vector the logic above has
+     * selected, though, as it might not be the same as the one for the
+     * requested exception number.
+     */
+    if (!exc_is_banked(irq) && exc_targets_secure(s, irq) != secure) {
+        ret = -1;
+    } else {
+        ret = nvic_rettobase(s);
+    }
 
     vec->active = 0;
     if (vec->level) {
-- 
2.20.1


