Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA88C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 19:59:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38D3A20880
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 19:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yh54DIO2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D3A20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaPwc-0008OH-Eq
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 14:59:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iaPpO-0005iO-G0
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 14:51:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iaPkB-0005TS-KY
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 14:46:28 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50928)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iaPk1-00055O-OT
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 14:46:25 -0500
Received: by mail-wm1-x341.google.com with SMTP id l17so12054004wmh.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 11:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EvBD8IKIg2gzoIa1FIZ8ylgY2xvcdkR/vxvnu9RgvMk=;
 b=Yh54DIO2b3MVy2y5TD2oIi5TzGCVrFghW7znPF1LDltMLYrPNKXAgGktyry3xml1Ji
 dZuVFqkMxrPZcXaaST+giz3rvFz7Cv18ZvPyHzEhf/LAhPFhdDO+wPYWmlJgOQRYWI/c
 QqtxhTthb+bJctKADHnE0rcAsUlPdEfx9UH5XMiJOHC1YZHnIRxiOwzpWasfP9Cjp0Vq
 AvMNmugnJe2LXzLpUEjdnywqr62onILwDC3/X7rJVrNARbi8RUdqwO6bC6fHXCBOCSYA
 aGTzYU1MwSs57FLikFDqx84KGm8ztgRlCC+G2FwdOm/Cz/FcY4Yfttxppe1BOa9G06L0
 6ziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EvBD8IKIg2gzoIa1FIZ8ylgY2xvcdkR/vxvnu9RgvMk=;
 b=ZEHHjAdMkQTHq0x+g8HToacpPROpTSSolh201GfD06RHePtTOh40/423G2/UoKutZ8
 ISOOIBYxb8Bk/dRYz57OFFE5JdPP94uW+VJ80OWgbKJyf99uunn7yg0Cn0A2q+OwQ8JH
 l2fpbMREyA7StpR4C5aJXd9Z2uP5w8DWP2tRniuGKU3Pfn377J9aY/jr3rQCVRJTWnhZ
 BPINI4cbBAfTf/FOBaaSTDgVMyENaNjYlKSMbljvl7VOZ66gMyPB6vtYdLhgcCRnB9fr
 oaeHHp71QtYqxHy71Y4v82plu8UIE5S2X7GsmB+o6brQNZ9VYoYZCk5yangGAGDFeft+
 yXpQ==
X-Gm-Message-State: APjAAAWSApIIk5IHeEnMnKK5q8KkA0Bn/mb4tOJ8mBkFPP0miphUVmvm
 sca3vp81lmhegocXpH2+n7lmcA==
X-Google-Smtp-Source: APXvYqw4485f0ZIjBjvBe3bpTbz8F0inWMxdX3bkI1F5zb5cuPcH3c5npIQz6h0+Sw3x+xkN8eLGVA==
X-Received: by 2002:a1c:f404:: with SMTP id z4mr11174602wma.12.1574970371247; 
 Thu, 28 Nov 2019 11:46:11 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p9sm24335055wrs.55.2019.11.28.11.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2019 11:46:08 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CC4841FF91;
 Thu, 28 Nov 2019 19:46:03 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 4/5] linux-user: log page table changes under -d page
Date: Thu, 28 Nov 2019 19:46:02 +0000
Message-Id: <20191128194603.24818-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191128194603.24818-1-alex.bennee@linaro.org>
References: <20191128194603.24818-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The CPU_LOG_PAGE flag is woefully underused and could stand to do
extra duty tracking page changes. If the user doesn't want to see the
details as things change they still have the tracepoints available.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/mmap.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index a2c7037f1b6..c2755fcba1f 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -18,6 +18,7 @@
  */
 #include "qemu/osdep.h"
 #include "trace.h"
+#include "exec/log.h"
 #include "qemu.h"
 
 //#define DEBUG_MMAP
@@ -578,10 +579,12 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
     page_set_flags(start, start + len, prot | PAGE_VALID);
  the_end:
     trace_target_mmap_complete(start);
-#ifdef DEBUG_MMAP
-    page_dump(stdout);
-    printf("\n");
-#endif
+    if (qemu_loglevel_mask(CPU_LOG_PAGE)) {
+        qemu_log_lock();
+        qemu_log("new page @ 0x"TARGET_ABI_FMT_lx" updates page map:\n", start);
+        log_page_dump();
+        qemu_log_unlock();
+    }
     tb_invalidate_phys_range(start, start + len);
     mmap_unlock();
     return start;
-- 
2.20.1


