Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB546C04AB3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:33:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78B0A2182B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aB2fPoOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B0A2182B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35096 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOuPH-0004nP-LJ
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 21:33:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHn-0006Jy-Ro
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHm-0001D8-Sx
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:19 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:43033)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOuHm-0001B5-MD
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:18 -0400
Received: by mail-pg1-x544.google.com with SMTP id t22so2116689pgi.10
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 18:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=Rw5R34uV/AA62KXp+YUGZEBrbetteys0TOZc4Uvv8RM=;
	b=aB2fPoOWuQCw5NIc5+gb078QFH6muv4uHr2aYtDjwlaZsJIRmcfCOBCCm8ftdQNCMK
	7CPbCGUK200HhSjdkNMtg5Cj3nN+5fKAInsKpNXiWqsUD3Fp8DS6YzQlcnZ/WzeMRnHF
	6LHPBaPbCBawvZWV62E0HO+C+METlFtxLegUmrrFboVAyY+H5tUd9JVhNQyzzZaaXkDQ
	Xq0dWc9lPVfDhx34Ai9YGpHNWbRUJwseEkV2JseS7zj1m/Kuk47rOADXWQSOdm2wJjHS
	yFKBEA6YDBOhgfShvmvk1I7ABQXEkPcbfz/0L9ozLmsbaBk+gNQsOk+NI5ElSkXUABBr
	3kJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Rw5R34uV/AA62KXp+YUGZEBrbetteys0TOZc4Uvv8RM=;
	b=qX7lUplvLpmtTWQC53bYxpSt9f5bETMGNM2+vYAe0cX4KS/9IHAhJcMtCzqUAU1PE3
	ou2uHaCmWjrMTFvZO0vpKCw8fAePd2FJyxVLoavbCpGIwEtTLNzhXYCsNJFXXYk3AvGH
	0myV1dRjB5gyqefE1jx6AfORh/dllgOvnSRb1PKQSpIqYhJC2xXDSy938LNQlxottfu9
	sKZNoqQlrpxcYwAep6cL5u8QPKkn5bs0U6jml88JKc0GI427sBaqlVNNBgN5WPBMoIo3
	lZRikg4HwXR8EHsGtWU3NbZ/slFbLIz/JeTQ7ceyOte0o+EIc23r1wA5hPaR6zphpV5s
	LNQA==
X-Gm-Message-State: APjAAAV3LHrwZ+hgS0OKrK2QasfCFE0/qiehPNWCfe9TpYan4VpSFYO0
	McPJueiDHpA9F2ikApqmAPyp6fNuMts=
X-Google-Smtp-Source: APXvYqylmW3PTAqJa9o0AwtYzUN0C7+/Go4MCqpUr7d5Wb1bJGgfUKdVO2iy53oE2JoYA97LRIErIw==
X-Received: by 2002:a62:b40a:: with SMTP id h10mr2261748pfn.216.1557451517305; 
	Thu, 09 May 2019 18:25:17 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	n18sm8252700pfi.48.2019.05.09.18.25.16 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 18:25:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 18:24:48 -0700
Message-Id: <20190510012458.22706-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510012458.22706-1-richard.henderson@linaro.org>
References: <20190510012458.22706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v5 14/24] linux-user: Use
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
index c1a26021f8..e673f7ea55 100644
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


