Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14C3C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:20:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A239020723
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hDFxAIro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A239020723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcAOy-0003Ci-RF
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 12:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcAKJ-0002uJ-7x
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:15:15 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:40693)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcAKI-00068v-5D
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:15:14 -0400
Received: by mail-pf1-x444.google.com with SMTP id v2so317048pfv.7
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 09:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=v6Twul2TWinr3wq/OK/PDzXQA1fcuJlgD8ranJI4BbA=;
 b=hDFxAIroI0ANOVWUCCGJeF68Vy9zZCrDKE0UnTkapT+zSSGzHRoBZzk6RBzsRYlnr3
 KIQF+IzAqeNeY0Dns4JNH5e1qztDV4rKfeafnjPCIBRi3NVVPoWBNTndJzL3fuekbTLj
 lZAnriIraJ1RRMdr+tMqAEijsvxw98sYdxDc+N6nCffhazzwnoTZFcXYoZWLavn/0Gqk
 AJe9MgLlNCDLs6diOr0qf8/vn6FIv5zULDbLg1ifTx3Mz+qcKX5Psfy7ueF1kH4vrk0Q
 zn5YWqre7rhbapq5+U53fpZhuc3k1bTsUAK6+iog6lS363WllMLD+zLF4frfURQtYDER
 cOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=v6Twul2TWinr3wq/OK/PDzXQA1fcuJlgD8ranJI4BbA=;
 b=UWjbxSRERWThzq54hnbWAXJfCLTw04SdU0dk68zgf9UcgsF1g9pTFYvYZv/012q0J+
 D38OssZ5i2wRmxOTsZ8T4Jh1nUcHfptEvGvjz+GVbPxkxujagEBQqBZ01TGhZVgFeir7
 2nZfipwYoESnrEqy5pn4ZRr8bfqY92ItnbNDD3s4dZQA5KM7FSaqBeL1qMZwMYkokmC2
 EJySmb97zaYr/NPa5MSOs8riHvA+Z1LIGutC2thzhGMFTO6hjHh3AHP76rvf36KcLYYu
 Hd34Iz2wxbB7tOJtVHp+naLyYHUsE7hsTC11QHh1xYmndcVuxG20QDeUR5nQk1v20GqS
 0piA==
X-Gm-Message-State: AOAM532p0OjtqYf6Vt86Z/6+JFGMrWHyuCsS/Angco7z1QQeIMmQCJbn
 bMu4UVumphIWZcbSHY1Cgg5RUdOP0OWUuQ==
X-Google-Smtp-Source: ABdhPJykOQgaC2KLYX1YDI/KN2+rrp9UKAfxluW7PefbeLWNJjsIEOOcwORr9g/x9gWSGvfSfS/KoA==
X-Received: by 2002:aa7:8a48:: with SMTP id n8mr4571386pfa.257.1590164112406; 
 Fri, 22 May 2020 09:15:12 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:f1d9:5fce:c451:d2e2])
 by smtp.gmail.com with ESMTPSA id y75sm7255428pfb.212.2020.05.22.09.15.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 09:15:11 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/19] translate-all: call qemu_spin_destroy for PageDesc
Date: Fri, 22 May 2020 12:07:43 -0400
Message-Id: <20200522160755.886-8-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200522160755.886-1-robert.foley@linaro.org>
References: <20200522160755.886-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=robert.foley@linaro.org; helo=mail-pf1-x444.google.com
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

The radix tree is append-only, but we can fail to insert
a PageDesc if the insertion races with another thread.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 accel/tcg/translate-all.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 3708aab36b..3fb71a1503 100644
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


