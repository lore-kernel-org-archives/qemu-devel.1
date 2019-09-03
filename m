Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96049C3A5A7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:47:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 647422077B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X4G4gp8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647422077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5B1i-0003gf-Rq
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 11:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArP-0002nR-5C
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArO-0005vv-5g
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:47 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:45771)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5ArN-0005vJ-Vl
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:46 -0400
Received: by mail-wr1-x434.google.com with SMTP id q12so17957733wrj.12
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 08:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=E0RGpyIRgwmsLzuSGhRDQK2g3xA+f5Ux3QZOYd+L+vg=;
 b=X4G4gp8m/dRjAgt1k5efuDP/+c9i7NpnRDsQ+twFKARzuZdh0km3Z2irpoePe6FlRE
 A9xLtELAlj0dMrnsXoaeFelhlhOKQbhqn+5ABS9EgNubAnliCyQStjaFnkCAP4X4QXxm
 xm0l7KgoJ6dznlJPrBckf0Fctk8Ppup+xqjNqL5hHBglIKZapLJK7X1qG9d4j4hLtsAF
 X+6e28XIbhGr/R+Piy3ydaNeeFr0uK7GHaHvr6HZM5hlkO8RCIRManIgeBFv6+jQeYuC
 CLovrIL+PwYVxpQgEmeXQtuif8HHrkMygfjlwJ3Ae0JeSv5cVnedjEIKA7NfWrN9xGnW
 yWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E0RGpyIRgwmsLzuSGhRDQK2g3xA+f5Ux3QZOYd+L+vg=;
 b=XCrYTjcCeyEQq+1tQfNeGMe77SsqyPTH8l4nL10V9WldmTIWiGYABauHj9CW4yk32f
 +mibetzfhwBNxqYubiv2FWr8gnv8XFlri7GvHGNolc13oG/iDReEaQllDzObU7NRZw6b
 NuXmUu+7lburbvZIQsvM0QelTYUkk52W+LPfT3sInMUcrWJwtdyYhmXqSN4QZwKLPOrY
 zyMuiwE3INi2NgHcZwz7I/BzmIkNfoof/NMGyJDj+vv6E6UBJR3+iLhuieKeS/E+uNN3
 nJNJFdczM3vKxfbXv8RQnhz+6lo6omRLYqUsXOge10HzPHLhOK9lpJNpVjL/KHf4vSFZ
 5afQ==
X-Gm-Message-State: APjAAAX8iAB92VrzovuCwQ/2bAJxj11LY4D7mFpAZDu5aQ25sobCmaZy
 v4BAbhTG3wobyKmiWHoQg0Bjr8vm+n0RTQ==
X-Google-Smtp-Source: APXvYqziS/zUaErAykrJsh4T6V3eVocFrUbB5SoimfCSHwnE9r/WtMKUQecf//kvkNXvPT96Wiiv8A==
X-Received: by 2002:adf:e30e:: with SMTP id b14mr44404450wrj.168.1567525004735; 
 Tue, 03 Sep 2019 08:36:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a18sm24435188wrt.18.2019.09.03.08.36.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 08:36:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:36:19 +0100
Message-Id: <20190903153633.6651-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903153633.6651-1-peter.maydell@linaro.org>
References: <20190903153633.6651-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
Subject: [Qemu-devel] [PULL 07/21] hw/arm/smmuv3: Log a guest error when
 decoding an invalid STE
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

From: Eric Auger <eric.auger@redhat.com>

Log a guest error when encountering an invalid STE.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190822172350.12008-5-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 2eaf07fb5f6..31ac4b15c30 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -320,6 +320,7 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
     uint32_t config;
 
     if (!STE_VALID(ste)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "invalid STE\n");
         goto bad_ste;
     }
 
-- 
2.20.1


