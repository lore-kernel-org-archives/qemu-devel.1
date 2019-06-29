Return-Path: <SRS0=rHaa=U4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAFFC4321A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 13:49:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE55C214AF
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 13:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h9HiZzCT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE55C214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhDjn-0006N3-3R
	for qemu-devel@archiver.kernel.org; Sat, 29 Jun 2019 09:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49494)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hhDih-0005fj-JS
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:48:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hhDif-0000x3-JS
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:48:47 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33424)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hhDic-0000iO-3O
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:48:45 -0400
Received: by mail-wr1-x442.google.com with SMTP id n9so9110235wru.0
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2019 06:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id;
 bh=uJnhNMoGL8yFyTGzU7fmju13WdcLl6dc7pthg5EJAo8=;
 b=h9HiZzCTr3WRg3uUU1pdE16zH9zq7/JxKsSRldOByR1j/6CuvuA5sA6hxeFH3zAoPG
 D8nrE+x+XxcbJD41CQ/AvAsLStJ3KSIHQ8Q4yglEtLJ5/hc0m/Tv3R7GzQRxhlDZ9uqL
 js6GFG+52y2wxBTBAmI5wDZnAYIcxy2PE3cWxXn8Nb1R9ZwHcW7WuhkfmPka2bKfu7aS
 jOxENb20/PSm3h6wUIPVa9uKuLZBv99cVo68TGEuwUW6WkmTMYC8aSWTl0fX4rJTHHmT
 Fs1JDA/8tG9eoJ4YKpO7zCUQ6gPJaZk306MBFF3CoACvF+1LAtoLkMA8lAgaEeCeFptw
 kn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id;
 bh=uJnhNMoGL8yFyTGzU7fmju13WdcLl6dc7pthg5EJAo8=;
 b=fhJDBtXvT2nyzX8GaRJQoxZcJuJ2rI5AWA47kKfAB5gc6HlJiqBuSzW/ULoAJ3PeDn
 Wda8W+mn0szPcIXSMaLve6gNamvgJx0P9drnrO6Un+brLQnB01/n0uyMU2s6CqvLs22n
 NZge5PyjXg8gcpz6j6JDli5W2Z1P1Ywjpmd7D94KLlW/cHPJX1RE3j30Fj31AiauAGlz
 /aPBUx9FjGWhh3zFhU7WkxP8NvCqG2NxhTWSt3JsB4ihTDpskZcQmaxWMaCWgPPhI46/
 QLAy3kQ/jePh9U2y7JmCwkvTTkVLxpf2cvtOen4mUnz8jkSZjcBErX8xbYPeZJDDA0ZT
 u28w==
X-Gm-Message-State: APjAAAXvMqGsUNHof0yLkfXRJ7aX1UiS9/IlK2Ek2ySkkWR1klEcF1OF
 HpEpWDURXqKoA4BPpQXg4kyskZhQIHJpfQ==
X-Google-Smtp-Source: APXvYqwtA4mqTadK4Mno3T8QliuEwxAKcMSCJGQugO1h0Iin2iWK+w2VHmbSwYTPAQUBTUjdRP/P3A==
X-Received: by 2002:adf:b605:: with SMTP id f5mr12534454wre.305.1561816119938; 
 Sat, 29 Jun 2019 06:48:39 -0700 (PDT)
Received: from localhost.localdomain (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id c1sm10435114wrh.1.2019.06.29.06.48.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 29 Jun 2019 06:48:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 29 Jun 2019 15:48:38 +0200
Message-Id: <20190629134838.5490-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH] tcg: Fix expansion of INDEX_op_not_vec
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This operation can always be emitted, even if we need to
fall back to xor.  Adjust the assertions to match.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

While expanding the AA64 vector ORC, Altivec needs a bare NOT operation.

This failure does not appear for aa64 or power8 hosts because we have a
native vector orc and so do not go down this path.  It also does not
appear for x86_64 because we don't have a native vector not, and so go
down a different path to expand not via xor with -1.


r~

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


