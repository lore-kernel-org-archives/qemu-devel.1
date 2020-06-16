Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AC5C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:27:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F016E20786
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YC68vXMa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F016E20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCYF-0007DU-89
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPM-0001Sg-8b; Tue, 16 Jun 2020 10:17:48 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38664)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPK-0006Yr-MF; Tue, 16 Jun 2020 10:17:47 -0400
Received: by mail-oi1-x243.google.com with SMTP id c194so19393377oig.5;
 Tue, 16 Jun 2020 07:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bFiVQnw2jG4LqsuDKjNy6cYrD1dF4NUODorK7JaUXfs=;
 b=YC68vXMa940Bx/AMnFsl6CsrC69kIKc3PjyW3Uuqz4nRg2ApKFY1kCxAL3J+CXiDx0
 ZjWwzKMSWsRLfkuLhHrV7mHa5KHAwQeHaZtWGIlVuO8VxO4mC5AUJy8Oxkd5ttdvRvti
 4MrLtMEoR01V6LZ1ESiAyKz5cTSemwvE4pcOj/7W8ovEjSMK0mFnvloErhdDmoKQ8Cng
 rwbTuON8ugWO6NNQM+48b7Xpx+MlzCKrmtsoAZUkWbazLzt3WeJbyvLIhQQt4T5Fgy8b
 gXAvnEdx5Q0GjI7Y1vTHY3QZf1khGkVpqtZJHj8WgDK4E6fpkcMtz0hUsf/QkW29x7n7
 rr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=bFiVQnw2jG4LqsuDKjNy6cYrD1dF4NUODorK7JaUXfs=;
 b=KZDRCcq8m3OyLPggNf55gejCDVI7exlhMBhT4a+l9OJ+xWl/3SPtSlyTXZ+W/CWK5D
 k8Vs5TX4kBiWQ15yD6T9L6+l0jrax6DbfqHiyQIOAWI+8PlIAcshfi8i6tcikmUx3Qtf
 iRMKuuHmSL30PFRErt83x7kbPRar1pN6zs4M80HFMk495weSrHj2ffFjVxtS1cm86uCk
 mVoB1YRO9nVsfHKwDq5vjgU4sFLRb55GwO4DTF26Rwwu6fAjNnYKcZWZ6EkFSg6pn3uZ
 /ARNRvw9oWhTKiNooy66cBiyaCaGqImtpSe87zCdbvxadt6lPmxQWUVFaNwfXOp02jwT
 QV+Q==
X-Gm-Message-State: AOAM533WqPDlDnGBJGjfWn1t3tslcn4aiI+CA8tYhxEpF1QsgWoCg9I9
 Q8RQfL9pC+ZWf4FOG8wkLJ8VBgAX
X-Google-Smtp-Source: ABdhPJxNOlbGxFmRld+mVDGzcPRNxdnWnCwjToLsYjrpOoXqfPcarj+Y4UoEMEGFIvOqMK9zSLWdDw==
X-Received: by 2002:aca:d956:: with SMTP id q83mr3400237oig.78.1592317064963; 
 Tue, 16 Jun 2020 07:17:44 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id v14sm4171856oie.20.2020.06.16.07.17.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:17:43 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/78] target/arm: Set ISSIs16Bit in make_issinfo
Date: Tue, 16 Jun 2020 09:14:45 -0500
Message-Id: <20200616141547.24664-17-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

During the conversion to decodetree, the setting of
ISSIs16Bit got lost.  This causes the guest os to
incorrectly adjust trapping memory operations.

Cc: qemu-stable@nongnu.org
Fixes: 46beb58efbb8a2a32 ("target/arm: Convert T16, load (literal)")
Reported-by: Jeff Kubascik <jeff.kubascik@dornerworks.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200117004618.2742-3-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 1a1fbc6cbb34c26d43d8360c66c1d21681af14a9)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/arm/translate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 83aa331b1e..ad052a2abd 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8556,6 +8556,9 @@ static ISSInfo make_issinfo(DisasContext *s, int rd, bool p, bool w)
     /* ISS not valid if writeback */
     if (p && !w) {
         ret = rd;
+        if (s->base.pc_next - s->pc_curr == 2) {
+            ret |= ISSIs16Bit;
+        }
     } else {
         ret = ISSInvalid;
     }
-- 
2.17.1


