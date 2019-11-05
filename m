Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10ED7C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 23:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A11DA214B2
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 23:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fF775Z+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11DA214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS8Xt-0002MT-1M
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 18:47:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38055)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iS8SL-0005lf-4J
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 18:41:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iS8SK-0004jv-34
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 18:41:48 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34227)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iS8SJ-0004jX-Tj
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 18:41:48 -0500
Received: by mail-wm1-x341.google.com with SMTP id v3so1020145wmh.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 15:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=WySS2tj+mpRubnHgzdskn314seKpdU+7MYMHfRQ/Nvs=;
 b=fF775Z+5dIMsRGdWH+I2PtFx9WyG3X0MMIUcG3qgO1Q0xghnVUcLQ3a1gFaErboFW3
 e/ON+bySNI0QJXVDif7PZy3RFU8Lq2KxH9DuNKJbfajsMyo/SrRs+RjJCaADd9YarBl3
 /4WymLEBvZwVyUk2JU3KlH1x8imALHQp7HFVV0MckiJd5A71EEJxujJYu9riFJSUCWwi
 edGzcFkmpO30uUO2Eje/Ofr14pd3dV2c39c8xi0zcZk6YjywUFMPA+MSOMidL36sHGvr
 5IVOqtn/baRYdl/s7pRUYNOy+fEfWvIWlaa09Ivh8X/6MXClwiMAOJa+r9txPwQ0npHD
 zf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=WySS2tj+mpRubnHgzdskn314seKpdU+7MYMHfRQ/Nvs=;
 b=sHst/9RmE5tMij9Nyb590o8O7P0p5KYnqKGHf0FfYY97WKgNHol3wmDo86l1EkiXYU
 MJhHhKXuSSk4vPysY1YGmsYQRGUf8HwHbPKCGw/ZJF9GWC2HuxYtDWBbx9ouEnT2T0bd
 jKtk77MfmIQTNn0bSLfb6od+clhAhh6UrBMKzKP3G6CPbnz64PeL/8Er/xE/OYe9YJ79
 1ThOHi/se/jyHMtLL8LOdJHm1vhpio1xQ1D0x0cfrKniRK9a9gX2hB5hG5ec6T7gXTsi
 srsGH/h8nax1laay0m/e3LdSzQlSva/DB0PbgILSm38BemvHRB0PdibgdBu/veROlpjd
 bA4Q==
X-Gm-Message-State: APjAAAW1fuBcgyNztxhwHY6c+c49N7GN8PY6m8AKGQVwPg9Cu45NFD5d
 uRu3gDr7DVfjtKeHtAqfkHCnGJ/NNe/bSw==
X-Google-Smtp-Source: APXvYqxl7N4pKSLFxno3Rdg0GkCD+jJMq+vBS7SlRpf7SeN2uE39lGmusweoOD6EHar026xvARW1hg==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr1341166wmj.84.1572997306754; 
 Tue, 05 Nov 2019 15:41:46 -0800 (PST)
Received: from moi-limbo-9350.home
 (host86-144-13-94.range86-144.btcentralplus.com. [86.144.13.94])
 by smtp.gmail.com with ESMTPSA id q25sm27295010wra.3.2019.11.05.15.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2019 15:41:46 -0800 (PST)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] migration: ram: Switch to ram block writeback
Date: Tue,  5 Nov 2019 23:40:59 +0000
Message-Id: <20191105234100.22052-4-beata.michalska@linaro.org>
In-Reply-To: <20191105234100.22052-1-beata.michalska@linaro.org>
References: <20191105234100.22052-1-beata.michalska@linaro.org>
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
Cc: peter.maydell@linaro.org, quintela@redhat.com, richard.henderson@linaro.org,
 dgilbert@redhat.com, shameerali.kolothum.thodi@huawei.com,
 eric.auger@redhat.com, qemu-arm@nongnu.org, pbonzini@redhat.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch to ram block writeback for pmem migration.

Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 5078f94..38070f1 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -33,7 +33,6 @@
 #include "qemu/bitops.h"
 #include "qemu/bitmap.h"
 #include "qemu/main-loop.h"
-#include "qemu/pmem.h"
 #include "xbzrle.h"
 #include "ram.h"
 #include "migration.h"
@@ -3981,9 +3980,7 @@ static int ram_load_cleanup(void *opaque)
     RAMBlock *rb;
 
     RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
-        if (ramblock_is_pmem(rb)) {
-            pmem_persist(rb->host, rb->used_length);
-        }
+        qemu_ram_block_writeback(rb);
     }
 
     xbzrle_load_cleanup();
-- 
2.7.4


