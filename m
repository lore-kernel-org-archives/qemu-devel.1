Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E58C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 05:27:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58AB921835
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 05:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnCeoemJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58AB921835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuV1b-0006RM-1i
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 00:27:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42135)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1iuV04-0004fZ-Fu
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 00:25:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1iuV03-0001lg-HY
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 00:25:52 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:40570)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1iuV01-0001kO-AA; Thu, 23 Jan 2020 00:25:49 -0500
Received: by mail-pg1-x542.google.com with SMTP id k25so766863pgt.7;
 Wed, 22 Jan 2020 21:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=zmHKjnC247jc9vlKJYZDXG9jAMZekmio1XePlTMOT6Y=;
 b=SnCeoemJj5Yr/4O76Fc7eU6E98/NwPNHCJRt0trG5eceTVI1Z26p3vTio9GwYrbpN/
 YfjFQTcj3AtqIMSO6C6BOvMrtBIEENP2AfqeVaglip8/UDX8zcT3/vHyDq5KWsMCh0l2
 7SIPbxKg4BG507u8K5Z5LfaNHVP7MXKDSzPoGyR5OhbDicjfYNCYy+jvwxMvpCfM7cOZ
 HJwMpj6tU3g+JJUV/lSwr1FszqMr7fy0de1WAmCUWK+05iIqLCPSRjixQQ4sIZO8vmCc
 RgzgIsFFAEw5p34Dr/VIrP27tVECCuOD1SQ+PZPYCJim22nWosRzCLhK2EfcSwwtBgiH
 UBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=zmHKjnC247jc9vlKJYZDXG9jAMZekmio1XePlTMOT6Y=;
 b=LG9ExwoFT7syDKr067IKubK1XFJDV0+I+S1YYudx+guAAzDhTttL4tYs8lJ5oxyH/B
 A4YiOJ/jSlKWrbGtt4SzZSpgJRbKoResPxHj3AadWVYFNGFoPPqt0paoLUpNEHkCBFLv
 oJnRgizdq64nplzbLf9SfwXjs6kAzhJBPmCGsUzFEXOcm3MGIrOeRiForUJbG5JpjSG5
 zFTDpFKSouyyKuRANhfB2KWG+PrQgpQWxSRCheJkt0+CLrVEMqwMJJ0CcfXD4eGwqEWp
 N1TCV83Qcdk/Nk8fxyt0YcotwqfSCr02UAB6lxilq6MtqEABIj+hmku7O336ju3dlEx9
 5FVw==
X-Gm-Message-State: APjAAAX9Zrvm0F7QLuwf16dh4boaKsACFET7dV3/72SUr9PRPwqhOQMN
 P2z+CtaOqZF9EVv0Ay+p79PYGrmd
X-Google-Smtp-Source: APXvYqzuJ+TJoW/cn3ch+fzi6T7QyxAHJvvLS8ScegBDGz9/hSW+KjFxc1XdgfrOZYbY6HmI6CJ28Q==
X-Received: by 2002:a63:d249:: with SMTP id t9mr2160009pgi.263.1579757148483; 
 Wed, 22 Jan 2020 21:25:48 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id j28sm930802pgb.36.2020.01.22.21.25.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 22 Jan 2020 21:25:48 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 2/8] hw/core/or-irq: Increase limit of or-lines to 48
Date: Wed, 22 Jan 2020 21:25:34 -0800
Message-Id: <20200123052540.6132-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200123052540.6132-1-linux@roeck-us.net>
References: <20200123052540.6132-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Exynos DMA requires up to 33 interrupt lines (32 event interrupts
plus abort interrupt), which all need to be wired together. Increase
the maximum number of or-irq lines to 48 to support this configuration.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: Added patch

 include/hw/or-irq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/or-irq.h b/include/hw/or-irq.h
index 3a3230dd84..0038bfbe3d 100644
--- a/include/hw/or-irq.h
+++ b/include/hw/or-irq.h
@@ -33,7 +33,7 @@
 /* This can safely be increased if necessary without breaking
  * migration compatibility (as long as it remains greater than 15).
  */
-#define MAX_OR_LINES      32
+#define MAX_OR_LINES      48
 
 typedef struct OrIRQState qemu_or_irq;
 
-- 
2.17.1


