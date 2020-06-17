Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3FCC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 04:40:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C1902082F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 04:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UEM4xrSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C1902082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlPsT-0001rM-87
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 00:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlPpt-0006kh-7E
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 00:38:05 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46415)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlPpr-0001T1-Gk
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 00:38:04 -0400
Received: by mail-pg1-x543.google.com with SMTP id u128so633530pgu.13
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 21:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/1VQEyGIT5SioB6kHr1I24ND+09JThHqu5Yl+UsE9Vk=;
 b=UEM4xrSfOR2sim6xTGwBYqO7P8+vDB/HVhPbjwZHUS5AaoSrdSSFSgYIKnPWagC2WW
 9043tBu3dnEBLRnlcMyvknpG7gHzWjxfu2nrQTCwSuQfmzdRwM4BV2c9yjn2Bo4fQnWU
 F+eUyHEuNKEAibMVtM3/Kb83XMSOMPWvxCb6Pe+OynU9kVWmVv2czYRLFYjDH+yQx+mI
 6QzsfXsVWyeZYeGZgGSVNQg4NlHsJ1e2ugGl0aXoRxp3/LoiraiF1mcf9I7syewIDXWl
 GJKhEBBfFBt4UxmZqTJ3lJoRDBWtPuYV3Ftmk25es80CD3Z6OD9/Eglem3m1HVFxENWw
 NDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/1VQEyGIT5SioB6kHr1I24ND+09JThHqu5Yl+UsE9Vk=;
 b=JDs1wJbRxkg5yQ1CQD771UCGnxYLVKnJZbR8rRPPtKoE34+mUzbOlghFMmH3vbei/o
 WUVaSk+werjnLwig1jJSl6DC5E1nT/gr3T4+P+TGHkrhcgBuIpZqvTEbxrUk6GOzvPDk
 XzfW+icfh2qmFGuzjUaF124/nPta1+iaribZQZnKyYZMFIrYcGPFzGAa9T3I5ndKslc4
 fntUlicv7rnALMkqmNRQ2wws2wuIUFnwbk5Lg9wU6AYrXhJWn3QYxpTLq7AaiHbIEBoz
 KMIGKFAyTKgMPpuJkExUsVt5EAmiuF5ldtqZUe4FVDOAGX/jBgTgoe+NE+p3enO2eLhv
 KBNw==
X-Gm-Message-State: AOAM531uobXrVFYJhV5ZzA2of3gSEnVEFh1Lex9cojGYXaPytMaRS+P9
 +rA8Yz48xq0/YYCuOtTV5nq+0xfWc9A=
X-Google-Smtp-Source: ABdhPJyhUJNKS35OSdDyVmmDpqYAgSZjCHCx6iEPJETPHuVObDqM2hxDuPNUg3l621UzBweeBGVT5Q==
X-Received: by 2002:a63:1515:: with SMTP id v21mr2735712pgl.185.1592368681845; 
 Tue, 16 Jun 2020 21:38:01 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id x3sm18585808pfi.57.2020.06.16.21.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 21:38:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/5] migration: fix xbzrle encoding rate calculation
Date: Tue, 16 Jun 2020 21:37:54 -0700
Message-Id: <20200617043757.1623337-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200617043757.1623337-1-richard.henderson@linaro.org>
References: <20200617043757.1623337-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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
Cc: Wei Wang <wei.w.wang@intel.com>, alex.bennee@linaro.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Wang <wei.w.wang@intel.com>

It's reported an error of implicit conversion from "unsigned long" to
"double" when compiling with Clang 10. Simply make the encoding rate 0
when the encoded_size is 0.

Fixes: e460a4b1a4
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


