Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED42FC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:19:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E73920691
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UTqJjLn4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E73920691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZdTv-0004HX-An
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:19:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLn-0000sl-Sa
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:35 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:33118)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLj-0006ZX-QQ
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:35 -0500
Received: by mail-wr1-x434.google.com with SMTP id b8so15525449wrn.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 09:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ddc3YHEWydM8IrInAbVJszIYA0TZHXyS/v+Zbs+mUmc=;
 b=UTqJjLn4noqjXwzjUQY2mEvUC8aasVxYugDeo8R1WlJjxCC436FloXRYOvWDZLlrOK
 ai+yzCti+2Iri1te6jpDicU0LNtFTmnFHRM1xlxOZtZ6lkq4oF+xwUJJkuMjsTLN1ygT
 tdDjtdXKli9QsJ0O9N5JkbrVtqElch/zr/VjevVZ1jv82Ej/+03JEKYq4NZ5jFj5YHK8
 J95EeDdBiQi5N2e3ekQBBkxECmlIOZVntU+VW/opnE7gkDzxYb7tDymTNsCpRANipUzk
 d5TM2FS3BYFACZoGpSIUAZ6G1Lnw0Hr/6pv2wKnbhTwKHuHIwDVefiozt56tJowJpcA0
 5T/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ddc3YHEWydM8IrInAbVJszIYA0TZHXyS/v+Zbs+mUmc=;
 b=mO+uW+SPF8cv/+jl517o4wjjnDBOn+qYqf42UQWuhMRdv8RP8DxEHTgjsxwooyrAc6
 XBG0Yc7wGqS1KD0zdzNFmQfUDvqG5Ii2cEsC4tu16f68NGNE04Qu8XRXLQn9mAj7pKnT
 i5v8bfKEqFFZd6eUJbtSGHmDcGV/Mxi0iUc5YWdpxOD3lVrKQfzt7OM6OrapmdGXsMN7
 889M7UCUuPmNPCQPEr3Z1f5s/sLjW791tgwU+vYr0IFwc6+Z139C0G8TyhZm/vCtk85u
 ZKj+PZ4kLOlnf583E09Fr+vK2SXDueoRCHjGS6GmuDL8bzPv52K5wYsrA7IkeQ7a77w+
 8LZQ==
X-Gm-Message-State: AOAM530IfGUN2FPLkyozusbPPJCyPxm4E1NuHhxcbVVGwmJDlQPLSFDn
 KH89PZ5/oQyZd+0MOO3VnNOEDRCVUcC+IA==
X-Google-Smtp-Source: ABdhPJws6CUIea6XKfrECu/IcOgh3WXIH2KQJzOzMbjMmEQKsWQDzny1/oOr0vvIJ65K/J/uFSxQLQ==
X-Received: by 2002:a5d:534d:: with SMTP id t13mr20582512wrv.69.1604337029421; 
 Mon, 02 Nov 2020 09:10:29 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c18sm22396540wrt.10.2020.11.02.09.10.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 09:10:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/26] target/arm: Simplify do_long_3d and do_2scalar_long
Date: Mon,  2 Nov 2020 17:09:49 +0000
Message-Id: <20201102171005.30690-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201102171005.30690-1-peter.maydell@linaro.org>
References: <20201102171005.30690-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

In both cases, we can sink the write-back and perform
the accumulate into the normal destination temps.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20201030022618.785675-11-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.c.inc | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index c2d67160f9e..1c16c56e7ec 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -2037,17 +2037,14 @@ static bool do_long_3d(DisasContext *s, arg_3diff *a,
     if (accfn) {
         tmp = tcg_temp_new_i64();
         read_neon_element64(tmp, a->vd, 0, MO_64);
-        accfn(tmp, tmp, rd0);
-        write_neon_element64(tmp, a->vd, 0, MO_64);
+        accfn(rd0, tmp, rd0);
         read_neon_element64(tmp, a->vd, 1, MO_64);
-        accfn(tmp, tmp, rd1);
-        write_neon_element64(tmp, a->vd, 1, MO_64);
+        accfn(rd1, tmp, rd1);
         tcg_temp_free_i64(tmp);
-    } else {
-        write_neon_element64(rd0, a->vd, 0, MO_64);
-        write_neon_element64(rd1, a->vd, 1, MO_64);
     }
 
+    write_neon_element64(rd0, a->vd, 0, MO_64);
+    write_neon_element64(rd1, a->vd, 1, MO_64);
     tcg_temp_free_i64(rd0);
     tcg_temp_free_i64(rd1);
 
@@ -2670,16 +2667,14 @@ static bool do_2scalar_long(DisasContext *s, arg_2scalar *a,
     if (accfn) {
         TCGv_i64 t64 = tcg_temp_new_i64();
         read_neon_element64(t64, a->vd, 0, MO_64);
-        accfn(t64, t64, rn0_64);
-        write_neon_element64(t64, a->vd, 0, MO_64);
+        accfn(rn0_64, t64, rn0_64);
         read_neon_element64(t64, a->vd, 1, MO_64);
-        accfn(t64, t64, rn1_64);
-        write_neon_element64(t64, a->vd, 1, MO_64);
+        accfn(rn1_64, t64, rn1_64);
         tcg_temp_free_i64(t64);
-    } else {
-        write_neon_element64(rn0_64, a->vd, 0, MO_64);
-        write_neon_element64(rn1_64, a->vd, 1, MO_64);
     }
+
+    write_neon_element64(rn0_64, a->vd, 0, MO_64);
+    write_neon_element64(rn1_64, a->vd, 1, MO_64);
     tcg_temp_free_i64(rn0_64);
     tcg_temp_free_i64(rn1_64);
     return true;
-- 
2.20.1


