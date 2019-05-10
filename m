Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916BBC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:48:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B7AC217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ehYp3aoJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7AC217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47722 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP9cx-0007Yy-Ha
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 13:48:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9MZ-0007Ur-Rs
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9MZ-0006AW-0P
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:15 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:43225)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP9MY-00069x-R4
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:14 -0400
Received: by mail-pl1-x641.google.com with SMTP id n8so3133298plp.10
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=iRt1ekpVqMBTFPlbEkwvccpMEH6z9s1kPn0wCee76Ys=;
	b=ehYp3aoJk6VPXB0pVCayxMCdYclH7yxIWbfUw9HmALoWfx1ww1+x8dh8NkU3Mm61pn
	qp0V/jNsvuDFUBloYorQnMIpz4cu9R88FlvMwFFpm3o4ldLmwjPNM/rKhZW0qGDTbyh1
	Y7ooTEjVXBiFk/MtZSBVTfBP2IcOST+JwL6JKSmGFi2S6sgWiDT539/vwYyhtd/K7aCt
	VLsU5v/xqpNRC0NQFevLXL121aU+vNNHn90nS0gxQ8gpZpCW5FighaCQMRZnotwFtpf5
	DrlD4bwdMgpqV5O8tXZaWTr/+1H3fjb5Hrw5EN8AVjXgfc+N4hsbqZwqCiLl2brwYjTh
	O/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=iRt1ekpVqMBTFPlbEkwvccpMEH6z9s1kPn0wCee76Ys=;
	b=Tl69pUUIiPt7ioZPqnVKyKb9da6pYEpQ1ANSTRrhkdxCh0ulearsGK9z5R5REf0Puz
	JRXdYTiPLDAab5nskdqnKucuEiDckOgdjK6cWm5h/hTYGAq8/JWatJuCsYN6xA4PURjN
	CHknT+4DtXLNw6lLORj0G4zGOtUAqaGC2v2Q88EyUpSe4bP1U/shfqNduYoI3YC45Hf2
	uLdZNPVfvGAbSa9fZsWiepGkHTUryw4i28zj+1+kt+L64PKkuc+H7fKRVqCrg7tXZej5
	cP2AiHVl5X4dWy5lmq+MgewMH+6Rwff16mgVSS6y7FsqhD/uS9sX8jVfBpWgWGfnqd9V
	AkgQ==
X-Gm-Message-State: APjAAAWHpOIluPQlN3IAOnxzRT3B6VWAYSKbxD4Bu8sbNnDe0DiClWt8
	NMegViKlYw4Gz8P9mw1ETeScb+93Xr0=
X-Google-Smtp-Source: APXvYqweTSeoSGeWy2u+a8Uawi8fIL69IWBytxQmc2d1oRx43mMP2IPWWPpwtaqm6VdroZQgQ0EtjQ==
X-Received: by 2002:a17:902:446:: with SMTP id
	64mr14480345ple.322.1557509473495; 
	Fri, 10 May 2019 10:31:13 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	v64sm7936792pfv.106.2019.05.10.10.31.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 10:31:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 10:30:42 -0700
Message-Id: <20190510173049.28171-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510173049.28171-1-richard.henderson@linaro.org>
References: <20190510173049.28171-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v6 18/25] hw/misc/nrf51_rng: Use
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
Cc: qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The random number is intended for use by the guest.  As such, we should
honor the -seed argument for reproducibility.  Use the *_nofail routine
instead of error_abort directly.

Cc: qemu-arm@nongnu.org
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


