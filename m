Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F209C433E5
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 23:38:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F37AF20657
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 23:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TwKiIPkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37AF20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ju2b2-0008PV-88
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 19:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ju2aU-0007yb-Iu
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 19:37:50 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:50522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ju2aS-0001jo-RG
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 19:37:50 -0400
Received: by mail-pj1-x1043.google.com with SMTP id k71so3253827pje.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 16:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WQIquz29/3Mrs8KUr9l4jEYupeyadrQoaBZ2fCjluGU=;
 b=TwKiIPkLB049OzbPEaP6CU3m5yO1dUvja6BAohH5PHb0Mnnabb4MEJeujTQ5k6pas4
 FZbWfeikMy28Rt9GnLNvS3Tn5YihyqV0szBNLNtooOpOHU1bGh7daOgHKPgmRJwa70xR
 5zBWwyuR9l4YeOGDuFpEWhtNzR4+1qq5cCYfaYPrOnSNHfGMIt5XUB86TU4/z1S7FIHl
 LJGzSi7g/OFPT1k6Yl/NLoAX7cfcfaGHJuBgjFtfMnJuIMevNOuIetXDS/vMyMBkedNi
 59JdtjsQSrDdGB+RrGbZ4upxSUNs8oGR9wymOYWNNqeSCQJAEBrN0mOmNJko8F1eiUOx
 rXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WQIquz29/3Mrs8KUr9l4jEYupeyadrQoaBZ2fCjluGU=;
 b=Ie+6O1YEgrQhWzzv54Nyr2I7l41Uxisl8R5tZ1+8IeNDMuB1o9nXtYeQfTPpucQhja
 d7Q9JnqQD+g3USSyj97iM8avTfUq+k7nuBfIJMFcDkQT780ar9973KM6BnqwWlZU5Hkp
 BNO4aXInw0dWCFKH3l+Xulzsm5PLBXwVlA0b1cPJGp9BZG2n41v5IHtixexp50LqATNC
 XALEVfmF64DvV5gPHNPkVPjaCzhoCG3pHCrem3SELE0bkUk/RNaoewQGyABZ0CTIjnvd
 u7JhfzGzNDxKtrJqCQCH1sx0+0EHpN03KzNpckmKCOW6qqaA+V0B4v+CHjDYm7YV20Ls
 QW3Q==
X-Gm-Message-State: AOAM531hRQgTODUB12G/29jED3pZBULfBuqFB7L78OTOyKprgLMI5VUp
 eGRxZppav3VuSwS7NHc+qm3/IVWNn9A=
X-Google-Smtp-Source: ABdhPJwpj6n6o6QzCNzXB+A/qwqQEadvT2OrOwXPXOhg5uSDsY/eHXtEDQxyLpscTwW8cCNe9wkxHQ==
X-Received: by 2002:a17:90a:c305:: with SMTP id
 g5mr7491809pjt.62.1594424266748; 
 Fri, 10 Jul 2020 16:37:46 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id e16sm7097326pff.180.2020.07.10.16.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 16:37:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1] tcg: Save/restore vecop_list around minmax fallback
Date: Fri, 10 Jul 2020 16:37:43 -0700
Message-Id: <20200710233743.177884-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Forgetting this asserts when tcg_gen_cmp_vec is called from
within tcg_gen_cmpsel_vec.

Fixes: 72b4c792c7a
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

I found this while testing SVE2 (and the patch is included in the
large SVE2 patch set), but it seems like it should be reproducible
with master.  What's needed is a guest vector minmax operation of
a size that is not supported by the host.  In the case of x86_64
host, that would be a 64-bit minmax.


r~

---
 tcg/tcg-op-vec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index f784517d84..ed6fb55fe1 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -657,7 +657,9 @@ static void do_minmax(unsigned vece, TCGv_vec r, TCGv_vec a,
                       TCGv_vec b, TCGOpcode opc, TCGCond cond)
 {
     if (!do_op3(vece, r, a, b, opc)) {
+        const TCGOpcode *hold_list = tcg_swap_vecop_list(NULL);
         tcg_gen_cmpsel_vec(cond, vece, r, a, b, a, b);
+        tcg_swap_vecop_list(hold_list);
     }
 }
 
-- 
2.25.1


