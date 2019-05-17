Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827A5C04AAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43D562082E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rSlT5PdZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D562082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40283 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRSzj-00080W-GX
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 22:53:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSmr-0005iM-7c
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSmj-0002Aq-JQ
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:52 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:32784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRSmi-0002AD-Rv
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:49 -0400
Received: by mail-pf1-x443.google.com with SMTP id z28so2889495pfk.0
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 19:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=gZNiNYQQXuA93bC9AkQ3RkBuv003My9kgUQccuqjr10=;
	b=rSlT5PdZWoMmzlvVALK4QZx5CapvAFEkl6AKPnVZZwr32HJoy5+tNWsl1E4unc9uHA
	YbyiiBa0oxZe5zQPJWc+LC4CMHxBUsVk4/QQwh4mKsLnw3XANj2WFHfSYPHlXMNuwCOm
	WQnXvuoLNmCGMocKCs8uaHJvzJrZSxioQ3SzABM0QQraO9VhmLegvjN5RqK81JptkWqz
	HRoaUcis5WcE23ZQawZ14kdlM1xDgg6GvzcyaQgx4GNWQwcRUR+nx0zHvyfT1Ebhzwt1
	O0DRkefBZZjObx44bSPeKvHB2oFQI9JOelnL//CmHDvzjHqogQ8xPUL885unKqekvJAK
	g5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=gZNiNYQQXuA93bC9AkQ3RkBuv003My9kgUQccuqjr10=;
	b=t0S3o0hZMzoTdoEClsxujckLNM1nWgpkmk7NsTANYp9Dde7/j7glhjt/sIJjcoKq5A
	5o9kM60fMAjLcBp5rxZvSFzL+u3HMs7eudQzGn9sW6RkaCptuGIQcyRoQauzY1zf0BaH
	1UufV40QCgHFzDFBsQNZrXYi9rCXgve43E2+CaWB2ftkV3IY0nw8m5YXQKlFW6lQ7gR3
	9kw2gvqhDSVD7pnjXJvQT9A4ypb7vTuKY17yXFMu8iL/hTOT/PqdTDIkwe6GpETsHUls
	+1F6pK0BNCkq9+2NSMk4Mc9hzsnuNkAdL0mJ0q+3CSn3rY/K42ITJNA2VJhJ5ZiEBem6
	xpJg==
X-Gm-Message-State: APjAAAUtrGDgiDw+9laq/7UeI2AJq8eniGhPI6BybPa8UM0gEQfIbbXs
	KROhZOTVwp5fAIBPX0fKA3Q1/ROKfC0=
X-Google-Smtp-Source: APXvYqwaOOutmKtfNwV2o9N3F9a92QqCjBpkxQgkSy5Y6LabtTLeAGMvAC6RXPQO9VLEBb/VTAegWQ==
X-Received: by 2002:aa7:951c:: with SMTP id b28mr39939557pfp.99.1558060787692; 
	Thu, 16 May 2019 19:39:47 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id w6sm6984152pge.30.2019.05.16.19.39.46
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 19:39:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 16 May 2019 19:39:16 -0700
Message-Id: <20190517023924.1686-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517023924.1686-1-richard.henderson@linaro.org>
References: <20190517023924.1686-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v8 17/25] aspeed/scu: Use
 qemu_guest_getrandom_nofail
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
Cc: lvivier@redhat.com, berrange@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The random number is intended for use by the guest.  As such, we should
honor the -seed argument for reproducibility.  Use the *_nofail routine
instead of rolling our own error handling locally.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/misc/aspeed_scu.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index c8217740ef..ab1e18ed4b 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -16,7 +16,7 @@
 #include "qapi/visitor.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
-#include "crypto/random.h"
+#include "qemu/guest-random.h"
 #include "trace.h"
 
 #define TO_REG(offset) ((offset) >> 2)
@@ -157,14 +157,8 @@ static const uint32_t ast2500_a1_resets[ASPEED_SCU_NR_REGS] = {
 
 static uint32_t aspeed_scu_get_random(void)
 {
-    Error *err = NULL;
     uint32_t num;
-
-    if (qcrypto_random_bytes((uint8_t *)&num, sizeof(num), &err)) {
-        error_report_err(err);
-        exit(1);
-    }
-
+    qemu_guest_getrandom_nofail(&num, sizeof(num));
     return num;
 }
 
-- 
2.17.1


