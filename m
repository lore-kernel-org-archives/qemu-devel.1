Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84000C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:33:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BFCF2075E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tm6yIhCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BFCF2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32836 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLA9d-0007SE-Bd
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:33:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9fM-0005On-6e
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:02:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9fH-0006zK-2y
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:02:06 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:38628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9fD-0006fd-Qz
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:02:01 -0400
Received: by mail-wr1-x42b.google.com with SMTP id k16so17123991wrn.5
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=csK17uX4zEJUIr2MrElaSeoN3nAbg+cexz+KK3ZxpK4=;
	b=Tm6yIhCZZJFDqhuB+8ysUVKeZC22lYqdVJb7vyeXej927VSjp0TN3XArXTNdfpvBmS
	6gDOxdif6o3es1D4jp7mNsuFJRfLaxei9vSkK5f/Qqq2Z+EFiHmlD89+dpy7WGVZ85Tr
	yBvmFQSXeTOEcVwShzZdF07EG/t13yqMfS/+MW0sQEA6uYSOF2/erbnlyTIwes6HdINL
	d/VTm7iEOpfGTMqTR9O5EZ2LsmnK4gpqlfhlV/lFsJ25rKh+YCaeIV2Vg5QOsq9rgAq2
	KLYlMBO8icJilE92TgfIFOQoqbazjU0GZmjL5qDF73aVQEztWKrVbw2WGB0CvRaxJDQl
	XD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=csK17uX4zEJUIr2MrElaSeoN3nAbg+cexz+KK3ZxpK4=;
	b=KzeidImxOrIwCJOjdF9kwP/L6FWCqvqLUkFaYB8IvGBvsUthWuLxhSybaAvieVFJZr
	jhQbwbtPcdGtNaNDOyTSsDfjvjkCUeDIsld97ilSl37Qpy5hfeSwX/Z32AhFnFTtys0i
	ngkjwbc2iO+xQHh9YonQj3xCw1eZg51xjBjBV45knTMOpE57TxC0P64FfNr7dS4cQ3T9
	dXo867cJSNlzlTMXS7RGn4g9u7wgxCSBmKyjcxC5BKQfxZUAPNVuS4q1Q4YTY7QQx9GI
	HHA+SvV7wRpu600pYfo5jBDBfHMIzpERv9C18DFMLnaZQ0l28dfAkMavMokeSfOjY8yw
	UL4Q==
X-Gm-Message-State: APjAAAXXmzemndEQpdq41wkQKD+oC6c66pWJRw4wMHCTtQQ3fPGJCfNa
	S89D8tgckF7VJLDHCSMEZqkg0LQ2qDE=
X-Google-Smtp-Source: APXvYqzFD1drwjRAA3qP8+cRJNsgjnozZqIt1k/XuNAcCGFaWEi4OmRqKPcC8GpYeInV0h2O3ysMWw==
X-Received: by 2002:adf:f102:: with SMTP id r2mr13262873wro.136.1556557283919; 
	Mon, 29 Apr 2019 10:01:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.01.22
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:01:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 18:00:28 +0100
Message-Id: <20190429170030.11323-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::42b
Subject: [Qemu-devel] [PULL 40/42] hw/net/ne2000-isa: Add guards to the
 header
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429170028.OA9SBILFw8kLp3LRhi3TUsbN8TcZ3syB3BU0lZ-oRIM@z>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190412165416.7977-11-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/net/ne2000-isa.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/hw/net/ne2000-isa.h b/include/hw/net/ne2000-isa.h
index ff2bed9c95d..527337c4548 100644
--- a/include/hw/net/ne2000-isa.h
+++ b/include/hw/net/ne2000-isa.h
@@ -6,6 +6,10 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  */
+
+#ifndef HW_NET_NE2K_ISA_H
+#define HW_NET_NE2K_ISA_H
+
 #include "hw/hw.h"
 #include "hw/qdev.h"
 #include "hw/isa/isa.h"
@@ -31,3 +35,5 @@ static inline ISADevice *isa_ne2000_init(ISABus *bus, int base, int irq,
     }
     return d;
 }
+
+#endif
-- 
2.20.1


