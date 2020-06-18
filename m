Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28328C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:30:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4D922100A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bdRYW64H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D922100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmBf-00087R-1Z
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 00:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlm8a-0001d8-Pp
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:26:52 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43896)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlm8Z-0002Fc-62
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:26:52 -0400
Received: by mail-pg1-x542.google.com with SMTP id h10so2318929pgq.10
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SYhTH7/NoKSZMnkGd9mMb4nrqyxVnLFVoR2e/Dwfxy0=;
 b=bdRYW64Hb395HdicS6bYyY+bGfI6LT6K3jr+lkYBl2rloASfODwrF3o3SWoqOxc6EX
 QCg/AejFxoP0UL9YMTiue9UZ4k/xdnpjW4fbOt8UjF5MMJa32QwO1vwcXVZaOKEmAv9a
 P2Glkzr559TE86VRoGblkBggXGYKVNTCeI4livOr9WrAHpSQ1c/er0xmJfy6ErzngjhD
 yZfJkAxBDaIIJ+koziHNd3u5pNBeXLKFL79sDxZfSQ3qm2gKBPgd2pHKAdr0yv0TWqpY
 ny7yXo+kyqL6+yaZoYQOrPCJpyqx0KUpQVZehEnHqwkMXdUj5d1bR26CRMWj+LI8++fI
 Hheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SYhTH7/NoKSZMnkGd9mMb4nrqyxVnLFVoR2e/Dwfxy0=;
 b=DqwVpWKefdKBi+TmDerahSxXWdODDJ/x25j1P63ziLCFUpHeXh81NRiPmyoXbFrRvP
 Onf68NDKCGil4Tk6SHWBOv63dAJj/MvEefafNtsLirjIEOQde/P2hd1zuN+iWP6yAXFs
 0H5KK8Hi4/DJ7LBk1WSyxTeDh7A+OsHGyEo05S0PGjLvUvnDfqZV3grvmy7gCjhJQm+M
 tgrfrvBTybmPYeBbgHf3migQXEFzBiqyJYT6GnENjqcznfAgXXrVnrdzCF/QSC6dLBs3
 MLgUaXofAHFL45rT3mztIGL4Ogz0knrY++ish9yuj1vwqrYQx7NQk+a4vcAkeyAzv2gk
 pvXw==
X-Gm-Message-State: AOAM530O88unXGrdx6ZYhH+2lH4/fBQeNJJ+ynidya1A5g8xOvjlXwfO
 7hUOz/oMm5ZrOwmKXEqOyqYoRbt2uWE=
X-Google-Smtp-Source: ABdhPJxI4BSvRTrV8Hfw5zePg/UR4C1J4lV6KLxXGDGnKFcLp0dPYdDlobKOEs5usH7Sp0PsglBaWw==
X-Received: by 2002:a62:7dd1:: with SMTP id y200mr1857673pfc.184.1592454409462; 
 Wed, 17 Jun 2020 21:26:49 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id o16sm1162035pgg.57.2020.06.17.21.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:26:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 002/100] qemu/int128: Add int128_lshift
Date: Wed, 17 Jun 2020 21:25:06 -0700
Message-Id: <20200618042644.1685561-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
Cc: qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add left-shift to match the existing right-shift.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/int128.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/qemu/int128.h b/include/qemu/int128.h
index 5c9890db8b..76ea405922 100644
--- a/include/qemu/int128.h
+++ b/include/qemu/int128.h
@@ -63,6 +63,11 @@ static inline Int128 int128_rshift(Int128 a, int n)
     return a >> n;
 }
 
+static inline Int128 int128_lshift(Int128 a, int n)
+{
+    return a << n;
+}
+
 static inline Int128 int128_add(Int128 a, Int128 b)
 {
     return a + b;
@@ -217,6 +222,17 @@ static inline Int128 int128_rshift(Int128 a, int n)
     }
 }
 
+static inline Int128 int128_lshift(Int128 a, int n)
+{
+    uint64_t l = a.lo << (n & 63);
+    if (n >= 64) {
+        return int128_make128(0, l);
+    } else if (n > 0) {
+        return int128_make128(l, (a.hi << n) | (a.lo >> (64 - n)));
+    }
+    return a;
+}
+
 static inline Int128 int128_add(Int128 a, Int128 b)
 {
     uint64_t lo = a.lo + b.lo;
-- 
2.25.1


