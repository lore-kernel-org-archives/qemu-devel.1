Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD173C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 20:15:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9957921707
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 20:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hHneAw/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9957921707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jleSx-0000cO-SQ
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 16:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jleQx-0005hl-6r
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 16:13:19 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43422)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jleQv-0000I8-0D
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 16:13:18 -0400
Received: by mail-pg1-x543.google.com with SMTP id h10so1803881pgq.10
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 13:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pT/roiiQXi808rl/3E2k4RxicPI5Pg+au5vRpBZNebo=;
 b=hHneAw/bbNDZ4duj1XldY/58SCN0Txwn3gNkO4jAgf07byTGH00SRA5+RS1mcKJQ25
 l/xtplH8TbyfP0vvZuCANowlfBDYHCT0UJajqAdPpSg1N4E3U4R9dmp5rf83ag3LcQ7+
 zH692X3uO0GoNU+tk++gMcZ/WystOX2cf19Rwfgaw+d8kM79ogZrDXxoSu7yRqplx8T3
 tk1R3ndWHFGcsAjl2HdHr0IHPQ1fjKsU7JOMk0Mku+2y8h/wAZFmoyCGPMe8r4F9rjSX
 FekwiMMPLEOfEjFbps0YAmDnwSI3hTEke2qUkpZwwlPMEUFmM4nyUu6Ba7O8yRIjG+Fx
 FOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pT/roiiQXi808rl/3E2k4RxicPI5Pg+au5vRpBZNebo=;
 b=b0lBk+y1BabPT9LmNiB4m3rs+9J2Fu58HZCkJwkYyP11g38Hp9IgcQ9C41SHzQrcBh
 crPjKFxcoxC/znXzheDhiyQO9WZZq9RCosS6Bbitz4C2Su8Mf7F14CLCGr9ijSn013He
 of+EvG0jAqFBUKIILBwY1syGZMn/Eb25JwLE+rnieR8LTsV+uKyP4dq76QkFIlrokP9V
 58QkjztOzJXk//AG7l8eMxHxgypy0TaVJzvE9WaPRTQdb7B1PUu8W12G5PYBtIxhSGsI
 HybQqaqbCjAziFhTw0AFHi48zfZfdAbeVfKWyQ+G8rPrFVWw0jwG5QQnO8Brr1VqEazM
 e0nw==
X-Gm-Message-State: AOAM532DuWGS3cUqDdkYleCr9q7OwyexnKwF3kwglmPncKCPpbPxjPYW
 UK2ikgjwXItkHgwHGOgRagjO6EQxxeI=
X-Google-Smtp-Source: ABdhPJza9vw8nmtDNGRO1jH1bsUrAV84MOtHDYj9rEfB128/Wvi5PbMfOnvO/7AyjaNvKaXkiD2Acw==
X-Received: by 2002:a63:5f41:: with SMTP id t62mr474112pgb.252.1592424795277; 
 Wed, 17 Jun 2020 13:13:15 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h9sm659259pfe.32.2020.06.17.13.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 13:13:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/6] migration: fix xbzrle encoding rate calculation
Date: Wed, 17 Jun 2020 13:13:05 -0700
Message-Id: <20200617201309.1640952-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200617201309.1640952-1-richard.henderson@linaro.org>
References: <20200617201309.1640952-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: philmd@redhat.com, Wei Wang <wei.w.wang@intel.com>, alex.bennee@linaro.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Wang <wei.w.wang@intel.com>

It's reported an error of implicit conversion from "unsigned long" to
"double" when compiling with Clang 10. Simply make the encoding rate 0
when the encoded_size is 0.

Fixes: e460a4b1a4
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 migration/ram.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 41cc530d9d..069b6e30bc 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -913,10 +913,8 @@ static void migration_update_rates(RAMState *rs, int64_t end_time)
         unencoded_size = (xbzrle_counters.pages - rs->xbzrle_pages_prev) *
                          TARGET_PAGE_SIZE;
         encoded_size = xbzrle_counters.bytes - rs->xbzrle_bytes_prev;
-        if (xbzrle_counters.pages == rs->xbzrle_pages_prev) {
+        if (xbzrle_counters.pages == rs->xbzrle_pages_prev || !encoded_size) {
             xbzrle_counters.encoding_rate = 0;
-        } else if (!encoded_size) {
-            xbzrle_counters.encoding_rate = UINT64_MAX;
         } else {
             xbzrle_counters.encoding_rate = unencoded_size / encoded_size;
         }
-- 
2.25.1


