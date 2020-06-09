Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4CFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83D252072F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qNr97HSB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D252072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jikcE-0003Ym-Qu
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 16:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jikZD-0007fU-5Z
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:09:51 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:35061)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jikZC-0005b3-2s
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:09:50 -0400
Received: by mail-pf1-x443.google.com with SMTP id h185so56290pfg.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 13:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1NsThI0eMK49RH+R+oR0Ud3TTjxqLqaksL0ZDGz/oqg=;
 b=qNr97HSBUrOLimU07hmS+GwNc/esKVcAbmxKLUEx1422R0EYpQRn2sv06RpdmFuYYT
 m5six1s/d8vspHwVB5DnLLNS5GQv1bSwYsazcdAivIzg2cI702ZxcjrpjbSBGfFAe+yb
 3yQq62A7Bm5wEHI3oeeTjKMO1hyVjm/8bub7qon4xNBMIf2/MUhfWtlsT/6Pmfdte6/n
 0ZdMEySxVb2hgOfB++yb78dY7zW36TNeaKylC9nKcplLg5D2n9ym7VBG29ttRm0P+MRA
 gyJ6sMVhn441+TLYzTGraOGwwKFG36Ikaf9EKGHI1DCQNVKZ0giAGKmAsPU6zFDlwYg7
 QrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1NsThI0eMK49RH+R+oR0Ud3TTjxqLqaksL0ZDGz/oqg=;
 b=t7byID3GFmtKfoJ1K8gHiAz+wodBrt4I33PZCAbZpLpV5lghafi9RL/wDkEllL+HdV
 SlVB6LTuTJVDEaDMnFcrnvF7JUKvCzwhhPi7ZblijRb7Jhs1JMxeiRFseUD870c2mbPF
 1rAP2XZ3N4y5Xfk4aD7Xj73ekzjs+XOM9I1Elk57wfdcnYhG0zK+k3ssbtjx3+9J9qKt
 Wcubq5ME5qPiTt7ng4iTgVM28zlFyFgj1Y1KVid1QnyYcGBkn9c7JjBLfruOe4HJz58e
 X/lRgS/luPR/lhIGxQwyKl+8366yNlESm8vOHM1EqaaSM7zWd7WyQsZ4sizS019CWZti
 bcPg==
X-Gm-Message-State: AOAM533RoOTwbRfa+oiZ171+NDOmw5EP7EzrJhprz8bHwCYRZTM8Ou1z
 9JSYDEGlH11d6iHQNQNkWupXEgISUPwQiw==
X-Google-Smtp-Source: ABdhPJxHHzSfYmC1pKiR0IWFZdofK9e9baudvG4kTQOonBCRqOHqxy0qDY2GY164Tvt13uY9qSumKg==
X-Received: by 2002:a65:46cc:: with SMTP id n12mr26290909pgr.80.1591733388359; 
 Tue, 09 Jun 2020 13:09:48 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1d09:cef2:3b1f:abce])
 by smtp.gmail.com with ESMTPSA id n19sm10523374pfu.194.2020.06.09.13.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 13:09:47 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/13] translate-all: call qemu_spin_destroy for PageDesc
Date: Tue,  9 Jun 2020 16:07:32 -0400
Message-Id: <20200609200738.445-8-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609200738.445-1-robert.foley@linaro.org>
References: <20200609200738.445-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=robert.foley@linaro.org; helo=mail-pf1-x443.google.com
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
Cc: robert.foley@linaro.org, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, peter.puhov@linaro.org,
 alex.bennee@linaro.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

The radix tree is append-only, but we can fail to insert
a PageDesc if the insertion races with another thread.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/translate-all.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index c937210e21..c3d37058a1 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -547,6 +547,15 @@ static PageDesc *page_find_alloc(tb_page_addr_t index, int alloc)
 #endif
         existing = atomic_cmpxchg(lp, NULL, pd);
         if (unlikely(existing)) {
+#ifndef CONFIG_USER_ONLY
+            {
+                int i;
+
+                for (i = 0; i < V_L2_SIZE; i++) {
+                    qemu_spin_destroy(&pd[i].lock);
+                }
+            }
+#endif
             g_free(pd);
             pd = existing;
         }
-- 
2.17.1


