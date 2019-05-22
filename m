Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8FCC282DD
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:00:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0761F20645
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wlPqZaOb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0761F20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49693 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTWTi-00049S-7g
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 15:00:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWOo-0008Eq-TQ
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWCL-00087x-Rv
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:47 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:39835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTWCK-000879-61
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:45 -0400
Received: by mail-yb1-xb42.google.com with SMTP id a3so1256401ybr.6
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 11:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=LA1zmsYxmzBAEiSSaTbYsFeqnklh9uk6Ygv0EHqOLtQ=;
	b=wlPqZaOb4ijRuE3yZISM8x6gUnqRkZE2hXEFLBmosSPC4Sc6e8SlftA3Gxpay2eFzt
	2ZHnDRIwfk+IgqhK2Q0Art2CCvn5AyryHoloPKjpOgkxNGEVNvwfiPyHUYI14k1l4zzM
	Iz1O3itt/XXnj863xOesyE+WxpmYGC7H1JiPOHQzxkVL+ZGJzGSl+Oiw0I/RyaziphQh
	c2qsAT0Ucd3mMkF3FaX869tLLn9q0Xw3v5N3QdEzwYz8oOPNX7jMGSZm2dP7npMMh+7G
	lSU2/BVLVYtjhET4vedF1/9SeO6P8JgtDqqsu/q0jm5y7bGZVWuZYs61YNqaCr+xX1jM
	i5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=LA1zmsYxmzBAEiSSaTbYsFeqnklh9uk6Ygv0EHqOLtQ=;
	b=e7q6aa3kV+v94R67+xfzI0GPEABQ7b0LFL9Xk9XJz3mCQ2IhOdpat6kN8fTOuj2sF7
	RrkaBnlhxqVqkz3E2Xc/aO3jGbJPo2O5F8619t7EaXvVUt9Sq6jD/Tk6xnXaHCCHrZhT
	DfOABkplF1Zz1dWcXIr3rXP1WS5DN8da8VGcNDsJi0kPpLMSLAouRYzCuVrgIeMi5ca4
	bWvOY9ADqpYSd59Q1yEj/mBLSxfovB2ekTQkYaJBQr9itQ/2HBHXt0HhlcCUaNQczzpS
	ydGTnnKJrdjtGvsgGH5HLvYGBtDDmtFwbrUsEGcPb82fTwNn2jZEMlarGwj56MYNH1pO
	RQ8A==
X-Gm-Message-State: APjAAAWV9L/zQXMPB/6B5QQg7o/uAI+dR9fRTzxHscVM8TFn1C9riEhM
	EwTGFrKXWVQzLznUUJgaYftBjjdv/A8=
X-Google-Smtp-Source: APXvYqyYeHooBtpFbcKWuQcPTtLawP+2cozRgH+uBadWDejge/xGBI5E+tg8XuSVtXNUyB6D/N0Bmg==
X-Received: by 2002:a25:2d42:: with SMTP id s2mr16062056ybe.476.1558550563421; 
	Wed, 22 May 2019 11:42:43 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id
	206sm1299445ywq.74.2019.05.22.11.42.42
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 11:42:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 14:42:15 -0400
Message-Id: <20190522184226.17871-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522184226.17871-1-richard.henderson@linaro.org>
References: <20190522184226.17871-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b42
Subject: [Qemu-devel] [PULL 14/25] linux-user: Use
 qemu_guest_getrandom_nofail for AT_RANDOM
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

Use a better interface for random numbers than rand * 16.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ef42e02d82..1e06b908b7 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -7,6 +7,7 @@
 #include "qemu.h"
 #include "disas/disas.h"
 #include "qemu/path.h"
+#include "qemu/guest-random.h"
 
 #ifdef _ARCH_PPC64
 #undef ARCH_DLINFO
@@ -1883,12 +1884,9 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     }
 
     /*
-     * Generate 16 random bytes for userspace PRNG seeding (not
-     * cryptically secure but it's not the aim of QEMU).
+     * Generate 16 random bytes for userspace PRNG seeding.
      */
-    for (i = 0; i < 16; i++) {
-        k_rand_bytes[i] = rand();
-    }
+    qemu_guest_getrandom_nofail(k_rand_bytes, sizeof(k_rand_bytes));
     if (STACK_GROWS_DOWN) {
         sp -= 16;
         u_rand_bytes = sp;
-- 
2.17.1


