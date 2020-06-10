Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8CFC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:41:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D667204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ReRT4Opb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D667204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj7Xe-0005c8-If
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 16:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jj7Vs-0003Sa-Ob
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:39:56 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46077)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jj7Vq-0007h2-Vz
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:39:56 -0400
Received: by mail-pf1-x442.google.com with SMTP id a127so1608853pfa.12
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 13:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/1VQEyGIT5SioB6kHr1I24ND+09JThHqu5Yl+UsE9Vk=;
 b=ReRT4OpbE2F7VnzIVlCibzaZIif7MzfWXFS7/+SXGR6ew5xiqe31TNe4qjjJTa7SQO
 eHBtRS30SFRUjKfC8GVFjiSMkAeRd6n2IZIIMs24m1lOHLIKQScQBSPNBzblSpvDyI1B
 K6LKI2xppQuao3ln+X6i13oRFngCgV+s5tC65PUhHM2DUbqM00k2NnqX8XSEs6Z39a6Z
 3/BnyZIEr60l9b80f2HW1gPgn1khZU7XDCwW0mBXtKhNrOc1LvYDoyYaenfjuC7Jl60c
 tJ1vAl8MYd+gGwF2+wVH3RYUAzSc9Yan86o6hL/Hf+Qap7FSXHowZkWGylQuArEKkKXj
 PcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/1VQEyGIT5SioB6kHr1I24ND+09JThHqu5Yl+UsE9Vk=;
 b=GprfeGtNEGSd94nUIb4mNHYdlzs8q5sJNEdlDYwjZkia54hRJOMaGGUd+GjxkBp/B6
 sj75FFAbXyIxVBhKcHk/7sN4+8q5yWU85P/1t+bYm53PlqBMs38qnZCdSMqjYl5kYqoU
 wLAAv3EuqhE9iPpMbYWGP0Az0Ty6pHRNBjv88lLiHgghfMXz4jbRjDPoTrlmMuICfQlp
 OYHy9lQiGuSk3F2c3h1PuLlx9kurySSI/vVmPuYRY+R37DdK66M/b4qpR9H0XQdD6P80
 Pe/wtNgza9EDm/TEc5sETvUEeeSf+S8eMD3Dt1a9ihZj6VYV3qaHS2k1P1J1UaBvdH3N
 uhPQ==
X-Gm-Message-State: AOAM531sHaOOT3GUXQA9NlnzdwCRf2sbhSKoYJsn+VE5vm94a11Sm8aF
 ziQJYFJUe9CvDQZdZwQwnoqGwfeQj1s=
X-Google-Smtp-Source: ABdhPJwFcOmIA7QqpS4W6l15Jt4KV5U+yLoNOOrVnTTqnR0gYc9lpoEP4EbqANnhhLM3/iPmJhcAxw==
X-Received: by 2002:aa7:97bd:: with SMTP id d29mr4013253pfq.262.1591821586787; 
 Wed, 10 Jun 2020 13:39:46 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id g6sm740648pfb.164.2020.06.10.13.39.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 13:39:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/5] migration: fix xbzrle encoding rate calculation
Date: Wed, 10 Jun 2020 13:39:39 -0700
Message-Id: <20200610203942.887374-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200610203942.887374-1-richard.henderson@linaro.org>
References: <20200610203942.887374-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
Cc: Wei Wang <wei.w.wang@intel.com>,
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


