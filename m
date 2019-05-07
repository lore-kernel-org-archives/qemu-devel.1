Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D11AC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:14:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67CC0205ED
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ypd5zaHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67CC0205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45803 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNyz4-0001hi-Mc
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 08:14:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNym0-0007lU-Ts
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNylw-000421-2Q
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:40 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36306)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hNylv-0003zU-Rk
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:35 -0400
Received: by mail-wr1-x441.google.com with SMTP id o4so21968493wra.3
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 05:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=NJGpq0OAxWQIci6soRm4qOcyKSMv9zMfLaUKqYHLGrI=;
	b=Ypd5zaHXyixCR2IeX22+kB9GhGgdLbrfh6rcHXqq+F3VvQUBgbgtj3P9t0BMzXIL4O
	hkfjU/Pofb4HQ/q9iSwVAYFaubCVLdTtDZGsNdZTU3R9SCVGEQLjYgtmh/EUK1hii2Rn
	EASGtiiq+pg9l7GkSMHofX2S6q4vO5T6uptvTTBzvE/ez/5t+poKJqu6Gp4EfK/YIjPK
	64R7c0idan28rcrhTSMdkF2hu56OChC6hkvKqrWEHVmfVgcThKJ87CzJyvudbsSWcfRk
	oKQqZaUWoMr0iRIPYdVJPHdxujK/7Q8wnADogHdykKfWsj9DqtPr4uxSM1inReIO3B9/
	KC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=NJGpq0OAxWQIci6soRm4qOcyKSMv9zMfLaUKqYHLGrI=;
	b=CxaYG+HVSrnwvTDvVd0zAclA7P/uBzIE1xoWPxvGuEDcuCngvTr/A1s4LKu2MRkqg1
	y+DktePzSww2JPVQD69oKzuXVJXcY9xoDEr0PeFwePI9A9UUN1/CGfjsuXa8GhZWbpZ/
	kcGFMzUJDB9HrwhpliIlgKsMp47+02ASILt47SZt4nEE1cwNZPLZWm3y0p34VN4thS2j
	3DJj6vF2nVsLm8G0kuKM3vNk6r/N1botYwkT8QOwNKAHQyUKYSsai3rOVM4dK2UTiKHP
	MJH0YFq9BnxjU65MFgp/GYR33XxDG75rhUWCw92h+p3kgiD8IaxslYdPTUG/D+bDMaeV
	GjNw==
X-Gm-Message-State: APjAAAUXC2Ws0UbZaY/iKaOVOq/RfUS0H+HKmcrI+fqNfjVC8sAfQv8L
	zrz8OYxx2CHABezgfPF2vF2fm0AREBs=
X-Google-Smtp-Source: APXvYqybl6SF3JrzwEkmHIQOuE2l6ycYLBvL+8bELV8Ei78lSrB6ZZugW5Gl94w/lk91P2tOIZyneQ==
X-Received: by 2002:a5d:6a47:: with SMTP id t7mr21326158wrw.307.1557230434760; 
	Tue, 07 May 2019 05:00:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id g3sm12348596wmf.9.2019.05.07.05.00.33
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 05:00:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 13:00:11 +0100
Message-Id: <20190507120011.18100-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507120011.18100-1-peter.maydell@linaro.org>
References: <20190507120011.18100-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PULL 15/15] target/arm: Stop using variable length
 array in dc_zva
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

Currently the dc_zva helper function uses a variable length
array. In fact we know (as the comment above remarks) that
the length of this array is bounded because the architecture
limits the block size and QEMU limits the target page size.
Use a fixed array size and assert that we don't run off it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190503120448.13385-1-peter.maydell@linaro.org
---
 target/arm/helper.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b9745a42bab..1e6eb0d0f36 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1,4 +1,5 @@
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "target/arm/idau.h"
 #include "trace.h"
 #include "cpu.h"
@@ -13130,14 +13131,17 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
          * We know that in fact for any v8 CPU the page size is at least 4K
          * and the block size must be 2K or less, but TARGET_PAGE_SIZE is only
          * 1K as an artefact of legacy v5 subpage support being present in the
-         * same QEMU executable.
+         * same QEMU executable. So in practice the hostaddr[] array has
+         * two entries, given the current setting of TARGET_PAGE_BITS_MIN.
          */
         int maxidx = DIV_ROUND_UP(blocklen, TARGET_PAGE_SIZE);
-        void *hostaddr[maxidx];
+        void *hostaddr[DIV_ROUND_UP(2 * KiB, 1 << TARGET_PAGE_BITS_MIN)];
         int try, i;
         unsigned mmu_idx = cpu_mmu_index(env, false);
         TCGMemOpIdx oi = make_memop_idx(MO_UB, mmu_idx);
 
+        assert(maxidx <= ARRAY_SIZE(hostaddr));
+
         for (try = 0; try < 2; try++) {
 
             for (i = 0; i < maxidx; i++) {
-- 
2.20.1


