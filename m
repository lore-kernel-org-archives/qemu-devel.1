Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB395C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:39:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8463920FC3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ecIVUAfI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8463920FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlflz-0001zT-QL
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEf-0004Iu-JS
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:41 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:42453)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEZ-0000Mg-DK
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:41 -0400
Received: by mail-qt1-x843.google.com with SMTP id q14so2744537qtr.9
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TvYnAkjAppdRPxTCTiIdH7gnvDHcZXb4SiVpZ+2G8IY=;
 b=ecIVUAfIhsVG8DNL0q88t8bJ1XhdEQ3El8SmKRGwLxu/MxLAocT2DAhvIbtuh1KwPG
 45knDavjQm1HSsPs6XX4eU6+IGVn/JdmsvoLmRtzNxO4zEkqT5IzUs0Qx2gt91EoL4Y1
 aA2U9HVif14sh1NCIKoUqSRS1jgvNrRdKFuUcZNhNM7YY9jwfI6nEIRUlFR8JVf4fgdp
 N1YYOBHIkKAxo0gWZ+lP60bKfhhS4MpqVlE60LmXMm5CZSDySJGzttW+v/tG5D0serqU
 3QZVVXvIk+616xsejbi6ep35XMvsBrslfragTlkHCY6quxhW5PxWupnf4qielcy8sLd/
 wrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TvYnAkjAppdRPxTCTiIdH7gnvDHcZXb4SiVpZ+2G8IY=;
 b=I+QMFii7Mm+1vwpucnUE4tyNEZyFqIrzLOORdQeYcKIIXMbzZE1mJV4vwXXZG8zegK
 TBSaKzCuKzCkc2X3axABNrbZxKHHDlZW0dZsY86XBO3fQCldVyZJmJDd7sXzEgoyr8Ja
 9Ju47IXvERz/4uVgskJ1ITD/0SAP8IuX08HbnKBrqEaHhc8f1KG4bGXp0HYrRFl87mkk
 A7kE8c723zhqaenprtMdj524eEm/LSly1KF2EVP+YrxfLyuyquzFnIysYuMymtd9nBeZ
 YtZLyw60ev96lJBmWttXhHRK6viyRKfohWN1myS4B8+CNTQlulClolIt0H8MCau+i5sP
 GUjg==
X-Gm-Message-State: AOAM532A37Scuw5TOUsj4mvCj99noLQyf3DaeRAsNaDgRwwoWOmNK5Jr
 VVz0CqfX8MFl6OAyfMdf4pgOLvKsCc8aaA==
X-Google-Smtp-Source: ABdhPJz0LjXz1SYvP3++9YKVh1YXhO644lvGi4yUfS2yqvXzOCDD2Gmn0wABu71CqL3RZZqFy97zHw==
X-Received: by 2002:ac8:6b85:: with SMTP id z5mr1092175qts.191.1592427874319; 
 Wed, 17 Jun 2020 14:04:34 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:33 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 54/73] moxie: convert to cpu_interrupt_request
Date: Wed, 17 Jun 2020 17:02:12 -0400
Message-Id: <20200617210231.4393-55-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::843;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x843.google.com
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
Cc: peter.puhov@linaro.org, Anthony Green <green@moxielogic.com>,
 cota@braap.org, alex.bennee@linaro.org, robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Anthony Green <green@moxielogic.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/moxie/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
index 6e0443ccb7..f823eb234d 100644
--- a/target/moxie/cpu.c
+++ b/target/moxie/cpu.c
@@ -32,7 +32,7 @@ static void moxie_cpu_set_pc(CPUState *cs, vaddr value)
 
 static bool moxie_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & CPU_INTERRUPT_HARD;
+    return cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD;
 }
 
 static void moxie_cpu_reset(DeviceState *dev)
-- 
2.17.1


