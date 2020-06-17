Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F84C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 20:18:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF1B0206DB
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 20:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DAtHA5kT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF1B0206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jleW6-0003kv-10
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 16:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jleR1-0005pI-Dg
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 16:13:23 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:39050)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jleQz-0000Ix-Tb
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 16:13:23 -0400
Received: by mail-pl1-x631.google.com with SMTP id v24so1448175plo.6
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 13:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iB6WP5osX7GLomupFEwKpIq8rnoF86CLVB0urJpiacU=;
 b=DAtHA5kTyMCz43/pWlYuyy3VDgHr2r98rnL9NHkyMCVlc9gtocDnahKJwjYt35J2UN
 VPR4PfA6+pSZ39viDfyzm9zuyG1T/jRBSCzY6HPNPgyWC8rMjLu/WSmL4QrMVqeAhvjQ
 GD6XUYlWXR3TRzPr1zsM+duh5/J4DKWvrXCxPkTNv8fVPScAqP9anyDj/L+QtvAHBs8i
 yyDJJTk27dkRLcIdwyHqeZVvAYQdkhRMRqoc2ZOMGKc5H8wmTOVWVqf3u6U7gXLvrNd7
 8T73LBjEcGTHKtr3B4soPomTcNyiBJed84EO8N42Xu4R5ANkCon97P0c8ioPCxby4zi8
 ILyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iB6WP5osX7GLomupFEwKpIq8rnoF86CLVB0urJpiacU=;
 b=RlZswqhPARB9mFp7V2oe1tGIEvk8a8BxAkLX5HS44090XR5/fnBlcj0J1AoT6SFo0B
 EmSflfYIepmjQOv1imY78vkN9leYYrXDSgUoxkdVdF5dxx0gwwyn6noswdnyrhsmlaM4
 RqLn3S2ZjB4klXeihHYISoQrUvgUQnyc6U+YnPzjw1gPaX0T/1+LcN7t+WsleEtTHZiL
 nOq85BHYEflvfLx9gy6z4J4zEeSeKTd4Rmgbfn8L3ZFGRFN0mP/r3JKSkg5aFwWg2CgV
 xPR7MAWWD6JZzBNIM878pDc+qOaNodM2zizbgs9eES8fwaEKYRNpyKfVtMgZWxJXTgvk
 noLA==
X-Gm-Message-State: AOAM532sH8RkAZnhJQOeSlm0d7NF/AYVo3LwZrISZxCfCvbavoODcYaE
 V0PedszMm/H/A5Kx7Xz7TIJEMCvahmY=
X-Google-Smtp-Source: ABdhPJz+cmAnYedg5soQVWclwa2TLNfMa13oMpur9yPU8vhS/KbNbwodLh8tSpnwWP+3ovcii705xA==
X-Received: by 2002:a17:90a:fa8f:: with SMTP id
 cu15mr773414pjb.9.1592424800277; 
 Wed, 17 Jun 2020 13:13:20 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h9sm659259pfe.32.2020.06.17.13.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 13:13:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 6/6] qht: Fix threshold rate calculation
Date: Wed, 17 Jun 2020 13:13:09 -0700
Message-Id: <20200617201309.1640952-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200617201309.1640952-1-richard.henderson@linaro.org>
References: <20200617201309.1640952-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
Cc: philmd@redhat.com, "Emilio G . Cota" <cota@braap.org>,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

tests/qht-bench.c:287:29: error: implicit conversion from 'unsigned long'
  to 'double' changes value from 18446744073709551615
  to 18446744073709551616 [-Werror,-Wimplicit-int-float-conversion]
        *threshold = rate * UINT64_MAX;
                          ~ ^~~~~~~~~~

Fix this by splitting the 64-bit constant into two halves,
each of which is individually perfectly representable, the
sum of which produces the correct arithmetic result.

Cc: Emilio G. Cota <cota@braap.org>
Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
Question: Should we really be scaling by UINT64_MAX?

The comparisons against info->r mean that 1.0 is exceedingly unlikely
to hit.  Or if that is supposed to be the point, why is is the test

  r >= threshold
not
  r > threshold

where, if threshold == UINT64_MAX, there is zero chance of the
test being true for 1.0.
---
 tests/qht-bench.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qht-bench.c b/tests/qht-bench.c
index e3b512f26f..eb88a90137 100644
--- a/tests/qht-bench.c
+++ b/tests/qht-bench.c
@@ -284,7 +284,8 @@ static void do_threshold(double rate, uint64_t *threshold)
     if (rate == 1.0) {
         *threshold = UINT64_MAX;
     } else {
-        *threshold = rate * UINT64_MAX;
+        *threshold = (rate * 0xffff000000000000ull)
+                   + (rate * 0x0000ffffffffffffull);
     }
 }
 
-- 
2.25.1


