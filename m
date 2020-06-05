Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC81C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 04:18:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC0E6207D5
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 04:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dkGcpEw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0E6207D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh3on-0006hn-TN
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 00:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jh3na-0004Ef-4T
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 00:17:42 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:36156)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jh3nX-0000it-Gb
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 00:17:41 -0400
Received: by mail-pj1-x1042.google.com with SMTP id q24so2180561pjd.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 21:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eLZZtVFaB75BQS+spGGXnwizsOQKSuMWVvyzFk16uJw=;
 b=dkGcpEw/QA8qwpDaDFqgPmDutz39Gfwybi7llJl84hrNtzI8DD261uTAlCrwspeY25
 HDasxtEIgKSuUghhmyPWGmEDECPRG9uOGNweAyTvQG7KY/nY/AIlf/Lg8y7KdjTWnFXu
 +5Tjorxm6GtCjAlWDPyfcdqDcBlOxGX25Q/38/B1uZypAOf4K0qNv7ltf2b0f009/R18
 BoXlgvIDdRIboQY4TkqMxQjRGzPjGEeMTSKooxYqv7KRaUX5brtPitOGdnwSHrVXhsqm
 Y+ob45FpwXUlAE7GTJN+aTOAPOrgvq4lb+1RFzjz7OLxh1otKOH3PuoVmlC+NqlMf4++
 V/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eLZZtVFaB75BQS+spGGXnwizsOQKSuMWVvyzFk16uJw=;
 b=p/91jvpTahBezvTfLaZH/8a71y5o2L6ROqTqvHVjdEm9fIuUTehanmC012LhDB68vl
 LjBHzgg01CP8+PtTwKAZGjRt5zuTpT3oo8WqPmNBiPZfH0ZSGpHMzQ3ZWktvO95gbXnq
 mAYD8j/xypNVVoweyrnZtXm8MjanYiwyHK7In0FGq592l4kWKdGhV5jM2rRwSTExEi8e
 5P7n9hVkEckycDWNeY7bkTyloBWTu4t4W4fMNevLet3a/VqboQmXozFbSQ4rVkcpnpsl
 03GWsyM4mMTlLT6rnfvr5XLd2EUa3YwbRY+TTUFLiJlJFvBkHqSip32eTHRMiWDelB1H
 QHxA==
X-Gm-Message-State: AOAM532Qe1tcfSiEzPo/np6e0MuPmZXKYL3cteICHzdBplK1SXU9KRKL
 vdniYDd9X0FvTLEo6eVFjwh1rtPBICc=
X-Google-Smtp-Source: ABdhPJzbflzv84kKEfku0V6ceXvoGpKT25K1pl2PVm9aeyzYwzYCpKczwkXcvm+bRljb6hqimjn9TQ==
X-Received: by 2002:a17:902:24d:: with SMTP id 71mr5345398plc.12.1591330657785; 
 Thu, 04 Jun 2020 21:17:37 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h15sm5440902pgl.12.2020.06.04.21.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 21:17:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/17] linux-user: Introduce PAGE_ANON
Date: Thu,  4 Jun 2020 21:17:18 -0700
Message-Id: <20200605041733.415188-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200605041733.415188-1-richard.henderson@linaro.org>
References: <20200605041733.415188-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Record whether the backing page is anonymous, or if it has file
backing.  This will allow us to get close to the Linux AArch64
ABI for MTE, which allows tag memory only on ram-backed VMAs.

The real ABI allows tag memory on files, when those files are
on ram-backed filesystems, such as tmpfs.  We will not be able
to implement that in QEMU linux-user.

Thankfully, anonymous memory for malloc arenas is the primary
consumer of this feature, so this restricted version should
still be of use.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 2 ++
 linux-user/mmap.c      | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index e5f564fa1f..3cac7750e4 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -277,6 +277,8 @@ extern intptr_t qemu_host_page_mask;
 #define PAGE_WRITE_INV 0x0020
 /* For use with page_set_flags: page is being replaced; target_data cleared. */
 #define PAGE_RESET     0x0040
+/* For linux-user, indicates that the page is MAP_ANON. */
+#define PAGE_ANON      0x0080
 
 #if defined(CONFIG_BSD) && defined(CONFIG_USER_ONLY)
 /* FIXME: Code that sets/uses this is broken and needs to go away.  */
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index f9832609b0..fdd55986a1 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -599,6 +599,9 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         }
     }
  the_end1:
+    if (flags & MAP_ANONYMOUS) {
+        page_flags |= PAGE_ANON;
+    }
     page_flags |= PAGE_RESET;
     page_set_flags(start, start + len, page_flags);
  the_end:
-- 
2.25.1


