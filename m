Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34777C5517A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 04:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7205C207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 04:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OsHYyba2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7205C207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV67e-0001yM-Fg
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 00:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kV66P-0000Hc-Ub
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 00:51:57 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35934)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kV66N-0005eV-0m
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 00:51:57 -0400
Received: by mail-pf1-x441.google.com with SMTP id b26so755224pff.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 21:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Uo4RG0mllZ2fk2xwAGQl5NTqYDo64UsJZy9yJcWfCYg=;
 b=OsHYyba2VO1i9iEkSfIPV/0acufQCDXptkjiSEf7MX3W+Z3BTCsejRmMtc4u53+7zn
 kox+eSGFRh/KEOruRTQhh4QdiYAdyNhOxswaYGarvyxq7xzzNWs/JTHQejBvTvh8ZtJA
 u9bHpdHj1jmjUXJdeuY3oUCM5AFDZCKh8xsqSL1YtGe69gjo2xtuJKYMuzmov3TJXZE8
 KrOefIZwknEVMN8OkqoQppTSSThZvvJvzH5+FnJ7kW/45LpEX+nrg0unYR9GKZDqC64h
 jzsMYtM4lxADlMguB+wO3/s6hl8SC/j88F1UXEfPZQvTc/M0MbkmuUrtomxvqlThMOl7
 FeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Uo4RG0mllZ2fk2xwAGQl5NTqYDo64UsJZy9yJcWfCYg=;
 b=CzCmMG9Ejb+/EiQWt5rWMwyVKfr4Go8LqG45YotnJfmOADHXYoVcZL9UHqS74hwkrf
 nqWo1cP0oV0sVOJrZiAy27G1bvsi2BmH2C957e1E2JQE8hujt4SA7bYHgK3cjGwd7emU
 uwKNxc9YKvB6dC4Edxgr/edYBAR/rOapc9ywfzouram3p//JkHarrkqYAkeNEKdGIekb
 W1wLo+515lT7XXfcqIYZG3AaP8rS/didDZ8nO1QHHF/lbZZvkBwdDfHLoWYf+qah9ObW
 /PKIhHlCWC9Nu56bRPhURhQ+gMfbcCVS8+yUdeshFkCsvW/j52+7nLkUjcbZe75F55Et
 7ObA==
X-Gm-Message-State: AOAM5324Z35WFU28K7CpNqIFZTecVPeg2QT4TapDqVVkfZGqF6JacNPe
 OorWxrom9CHKJ8BPvT/uH4Cw6qGJajxCsg==
X-Google-Smtp-Source: ABdhPJxL8GM8D2dP7Om6LNPQcHicUSICs541u/lPfqKriLcuYYtjv0VMG8PgvFpTG66OUeV2aPNnTA==
X-Received: by 2002:a05:6a00:2bc:b029:155:5945:2eb2 with SMTP id
 q28-20020a056a0002bcb029015559452eb2mr1462201pfs.55.1603255912902; 
 Tue, 20 Oct 2020 21:51:52 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j11sm620070pfh.143.2020.10.20.21.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 21:51:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 01/15] qemu/int128: Add int128_or
Date: Tue, 20 Oct 2020 21:51:35 -0700
Message-Id: <20201021045149.1582203-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021045149.1582203-1-richard.henderson@linaro.org>
References: <20201021045149.1582203-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/int128.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/qemu/int128.h b/include/qemu/int128.h
index 76ea405922..52fc238421 100644
--- a/include/qemu/int128.h
+++ b/include/qemu/int128.h
@@ -58,6 +58,11 @@ static inline Int128 int128_and(Int128 a, Int128 b)
     return a & b;
 }
 
+static inline Int128 int128_or(Int128 a, Int128 b)
+{
+    return a | b;
+}
+
 static inline Int128 int128_rshift(Int128 a, int n)
 {
     return a >> n;
@@ -208,6 +213,11 @@ static inline Int128 int128_and(Int128 a, Int128 b)
     return (Int128) { a.lo & b.lo, a.hi & b.hi };
 }
 
+static inline Int128 int128_or(Int128 a, Int128 b)
+{
+    return (Int128) { a.lo | b.lo, a.hi | b.hi };
+}
+
 static inline Int128 int128_rshift(Int128 a, int n)
 {
     int64_t h;
-- 
2.25.1


