Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3E5C06511
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:25:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B41F206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rz9NQKhr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B41F206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiKfA-0008DL-Rc
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 11:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58029)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hiKLz-0004wA-BZ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:06:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hiKLv-0007aW-Jv
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:05:53 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51215)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hiKLt-0007YG-Pq
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:05:51 -0400
Received: by mail-wm1-x342.google.com with SMTP id 207so1202762wma.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 08:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ty0ceSlhLSlZJKGDv3kDThADamDPPm/37CRvid7ZnoA=;
 b=Rz9NQKhrlQwy/RsupH8RGg0IpFk7hNbm+LIaBM8RjeI/5x5jZXfN1JX046AL0djN54
 1CjQgOWqxIwFlqjTRkEV/gr5qPbdj+W5E4H5/c+/9taxurNW0DdnmDa3+ffhRE8It+gV
 KxMnhEB9aAOC25XmPu6H4+viyZqrNzPnsDCJn4v4MBc+WouC341cbQQWcG+LlMOxXgTU
 S1VCW79oNSa6H2hoId8AKk561lr5dWig7f5E6T0GQp8MromrS3C5JWPsHF11z1nbsAoM
 lC42dSt/wv3zyrnoydpsUddRAjmmGF4yAsupwU6Oxvabpt5jIK5HqQdYCt3NcPNvWJB2
 9w8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ty0ceSlhLSlZJKGDv3kDThADamDPPm/37CRvid7ZnoA=;
 b=dnBjFTb6VMd1nBpM2xAhPz90UPKO8vvnxA8+AppTNmKdfNKuRP3ssPfRMbTNAnHDy/
 k8cqPyi/Qr+VWnJipWllwiFh5RLiTMi34so6ea4BOq4RWklMFbuo+rqQIbttzl/hTzTL
 HWPMLda9wdt0or4hUNZBF6SkPAdOzHjS3PWMtfdaokxmlsOdmtfdXVi5pwoGYfgy0ft9
 MnmYe0FGJ/aQzEeEMvrZeTy+bn5TXkWydEvFmbJz0qkmB5Yfh0tDfleojvsBV5uVFH9U
 p4Vlk22+AR8RSI2LBxqGewN8ccQ4WzWw4cMGZ7YkPBfT+i5UAD5BuyiCGTxyQUdLxt3y
 zxOg==
X-Gm-Message-State: APjAAAUiSadKvlDjw/2HZ7lo2dIqpl5wYfKP+2NzLDn9rirBMZici5Zo
 L7uHyc6TiBZpFNG/NNkCeEzpUzTvHLdEgw==
X-Google-Smtp-Source: APXvYqxX6KfCQ5auoSAeEczEKgKnlDsldHSbRUPtkkib87IL95Ovh+7rsU3sA/G0k1ophnrBEM+ZNQ==
X-Received: by 2002:a1c:39d6:: with SMTP id g205mr3552458wma.85.1562079947701; 
 Tue, 02 Jul 2019 08:05:47 -0700 (PDT)
Received: from localhost.localdomain (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id w10sm12975657wru.76.2019.07.02.08.05.46
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 02 Jul 2019 08:05:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 17:05:42 +0200
Message-Id: <20190702150542.12008-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190702150542.12008-1-richard.henderson@linaro.org>
References: <20190702150542.12008-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PULL 3/3] tcg: Fix expansion of INDEX_op_not_vec
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This operation can always be emitted, even if we need to
fall back to xor.  Adjust the assertions to match.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-vec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index c8fdc24f56..6714991bf4 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -90,6 +90,9 @@ bool tcg_can_emit_vecop_list(const TCGOpcode *list,
         case INDEX_op_bitsel_vec:
             /* These opcodes are mandatory and should not be listed.  */
             g_assert_not_reached();
+        case INDEX_op_not_vec:
+            /* These opcodes have generic expansions using the above.  */
+            g_assert_not_reached();
         default:
             break;
         }
@@ -438,11 +441,14 @@ static bool do_op2(unsigned vece, TCGv_vec r, TCGv_vec a, TCGOpcode opc)
 
 void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
 {
+    const TCGOpcode *hold_list = tcg_swap_vecop_list(NULL);
+
     if (!TCG_TARGET_HAS_not_vec || !do_op2(vece, r, a, INDEX_op_not_vec)) {
         TCGv_vec t = tcg_const_ones_vec_matching(r);
         tcg_gen_xor_vec(0, r, a, t);
         tcg_temp_free_vec(t);
     }
+    tcg_swap_vecop_list(hold_list);
 }
 
 void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
-- 
2.17.1


