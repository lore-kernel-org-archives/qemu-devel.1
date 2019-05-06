Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A69CC04AAD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:47:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA3E12082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E32KfjgM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3E12082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60080 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhiE-0004lU-4U
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:47:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhVK-0001Cz-Gs
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhVI-0001Qp-Lf
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:18 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNhVG-0001P9-Ol
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:15 -0400
Received: by mail-pg1-x544.google.com with SMTP id e6so6799970pgc.4
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 10:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=6ZLSvDsE417cQFXtdznOdElqMvcAzRRA3vqOLnZRXkY=;
	b=E32KfjgMlH1BNZqxvEe87rzW5aXT1ryTedZZsN1NoTPRj8Lo5MKTENOVYjBnYfpgQg
	vI74qDBQ6nv8qxXXDbvERkYtVaZ31P3Cl+Vt6tGex/nFUQ+UT6Po1dw5GesRWry95Jko
	ofBkUgbvbqwLTajEGDRqWgdm7ymFIk14MvdVu0+eL8V/oluZMMi+wDHw3c8/RUzCAfYX
	8lwUbS1f42yaO7pdTL9RuljvwMIUuAYI7+aZco1eMucsi4JO9ixoowwuz7SctYK2frWy
	3tIAOI8kS8r/4C6ZvmE/9DeGVwIkTOTM9mC+Pxe4xUPs5YBoEcixmRz6as2LTlM/95Zn
	wR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=6ZLSvDsE417cQFXtdznOdElqMvcAzRRA3vqOLnZRXkY=;
	b=CZ1Q8NW9hb6hL9Ri+DI6z4szHgEZTFRuqEI4X22qxudm8sbGY7XdVWeEeHkE1R4lvi
	hKoCISA7xjfjuHSSOE1jjeOuIYPpmUV5YcH8ZVJ+UkA+luDbPGFR1ugrB0AI3/WDDJzp
	nFUNuOX+obeQM6dDl92NEvboPb7eiqHS2SGndylMp4BWXF5xTscLqyKNZv8oNne/HDtc
	Bw0gfC6YNh/EcnMZMSJXTEbRm/lWALIpt0v36zWSytVmeklhPxNHKEDwsblutzZ6E2Ic
	z4hPSt4kFM0W15KjbRM3I4tLPYdKuXkoABoiqvQMQU+mBLfQu8+7YCZNgkhZhKjOUvxO
	9wYQ==
X-Gm-Message-State: APjAAAXuc/jZfwI9HNurogvIjpkdA1Pjiv+zhs0yrHdvvU0HM3r8xHXA
	HrCvCkjHmJAaWh6hTFPtH3AUhNiVAnM=
X-Google-Smtp-Source: APXvYqxjmnCwkhzAnroSW6y7utolcv6REpaPfJYXYJy1DNDYwVvAcmW4VV1vMfiStn4wWS8C5FW+xQ==
X-Received: by 2002:a62:5a42:: with SMTP id o63mr36429284pfb.170.1557164052846;
	Mon, 06 May 2019 10:34:12 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	k9sm2268839pfa.180.2019.05.06.10.34.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 10:34:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  6 May 2019 10:33:43 -0700
Message-Id: <20190506173353.32206-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506173353.32206-1-richard.henderson@linaro.org>
References: <20190506173353.32206-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v4 14/24] linux-user: Use
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use a better interface for random numbers than rand * 16.

Cc: Laurent Vivier <laurent@vivier.eu>
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


