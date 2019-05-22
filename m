Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D87C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4C5C21473
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I/RgZIqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C5C21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49804 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTWaX-000323-2K
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 15:07:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWOo-0008Lh-9x
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:55:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWCQ-0008Al-0d
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:52 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:39304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTWCO-00089d-8E
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:49 -0400
Received: by mail-yw1-xc44.google.com with SMTP id w21so1241570ywd.6
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 11:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=zHL5/dOLNq3cxnvhnBPOBazkJM0pmZq+fc+P6w38V4s=;
	b=I/RgZIqw0PlT8WEjXXx/SNicpUQAAw/6516CBgMzR6eXFNR6Kf8kKEOfp8J/smmNnF
	NYg0VFjZqE7YnqcGyMrYeaQnIQQSZN2I3LKLyVTjSph6ojnD66TUsunKXwVF8FPcCcUf
	tvEjcIPRZ1kDI1WZXMFSb+v+lJ6HipC9sCtCrfKUT1nEJgrMjPhUuFpihrc3BnECxHFH
	f+JkEFKaF4AmwjWEw7LEaRZ6JCyWjlwPo8/QpZ993o1u8qpXE05I7p21HO02psxA9Ep0
	Jz3OlFzAfnW2ITvFDk/sJTYDfgFPkJDc+nvrR+QciOjR5/6ahKWi20hdgF1n4Rrzfppr
	O+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=zHL5/dOLNq3cxnvhnBPOBazkJM0pmZq+fc+P6w38V4s=;
	b=lza19VRpnh448KKodFXzc+exvfJkW+GpNfYeBkFipADzI6qVelrePMJR/QYzyDeobk
	hqTMBV+miOUxzgYBUTuadnKXOJrnXbB5GyimQIoedtaklsmKDRYL/pV7gLK0GhS9OoN4
	h1bOG1PNuEF/MxQveDrn67XBaxNGrT1DYsYfm9GWYQM6l4bTMMHVi21NE+6RzvTCDMz9
	W5zKI4/XLAZ5m5vHzhh1pJM4AtVZXn9362JVHrpgMpNs2n4vrJceB4EUkhWgBywIQjqh
	w7D5PBkCea1BCRkVvNvhCnb7hLHpb/5VvMwp4dOGaW8CST39ShNtugIJtrMpCxMFRZ2O
	rcXw==
X-Gm-Message-State: APjAAAV8777qDC/K8trMZ2pyFUEmhbed5n3dq8FoUNZH/pYc4ZncSYP4
	5FIzGEu99L+LStESm0CvfwCdz9zQ21c=
X-Google-Smtp-Source: APXvYqwxhJuDpn09p2GeN2LXTMoCKfx3Y9DMvoVdJhtAMZAFualpGuYIsRYLxdAMIhdiqB5jdiAwpg==
X-Received: by 2002:a81:b717:: with SMTP id v23mr42621851ywh.120.1558550567474;
	Wed, 22 May 2019 11:42:47 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id
	206sm1299445ywq.74.2019.05.22.11.42.46
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 11:42:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 14:42:19 -0400
Message-Id: <20190522184226.17871-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522184226.17871-1-richard.henderson@linaro.org>
References: <20190522184226.17871-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Subject: [Qemu-devel] [PULL 18/25] hw/misc/nrf51_rng: Use
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The random number is intended for use by the guest.  As such, we should
honor the -seed argument for reproducibility.  Use the *_nofail routine
instead of error_abort directly.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/misc/nrf51_rng.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/nrf51_rng.c b/hw/misc/nrf51_rng.c
index d188f044f4..3400e90a9b 100644
--- a/hw/misc/nrf51_rng.c
+++ b/hw/misc/nrf51_rng.c
@@ -14,7 +14,7 @@
 #include "qapi/error.h"
 #include "hw/arm/nrf51.h"
 #include "hw/misc/nrf51_rng.h"
-#include "crypto/random.h"
+#include "qemu/guest-random.h"
 
 static void update_irq(NRF51RNGState *s)
 {
@@ -145,7 +145,7 @@ static void nrf51_rng_timer_expire(void *opaque)
 {
     NRF51RNGState *s = NRF51_RNG(opaque);
 
-    qcrypto_random_bytes(&s->value, 1, &error_abort);
+    qemu_guest_getrandom_nofail(&s->value, 1);
 
     s->event_valrdy = 1;
     qemu_set_irq(s->eep_valrdy, 1);
-- 
2.17.1


