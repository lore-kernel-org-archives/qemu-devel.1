Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308FFC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:09:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98F0920774
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="F7LSCfHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98F0920774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNL09-0007s7-Du
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 15:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKwR-0002Rf-SD
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:05:36 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:40498)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKwN-0001hx-Uw
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:05:35 -0400
Received: by mail-pj1-x1041.google.com with SMTP id h23so2053502pjv.5
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 12:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9ud1EfWIelJCR3RcWsXtUItZIZfuEp3IhOO9JAvYEDs=;
 b=F7LSCfHi+SGSx3bUvgb2j5nMSKhMEk8WXzJWRiAjIYKjpFZWu+Ex+kKyvS8yJs/MMI
 cR7uVCfCMnBO7mZo+YqHeXiTJguoXuolmJe4wmCo1KR0L0RFurYRbOw13QLn2YznvnoH
 TUYsnfB/9TFGXxP6YSmsFZn2su/T3NzEItEKaWXlnLIRxJm63NfiFwxfie+B63WkTAPL
 9zkk3/v1EejBTRU5fNNikm1TwsMx0B17jrblwPFBMjphV55lztYH94CUmHr/hQh9LJ58
 Gmy6QcxG2iPYRf3x5gdxbMAMuIOolu/KMLjUOk3bSVSIUJQmJOoBTEKqPSdllgFrSG71
 SGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9ud1EfWIelJCR3RcWsXtUItZIZfuEp3IhOO9JAvYEDs=;
 b=uBVXPjoU74KWyYxuL3qkvo+McOk/tHXtOKqabzIG6pKdVO+OVMeX4nQWsd/s3OEG5h
 1j00dcCdEEA/BMLVx9o6x6tpPmuSPt6yG268h6YWpf9JXfGT0KJ317hiOb8sOXDI3vTK
 GlavgtN6OrL15KmlSRhBEbNe/pY2tKJtXkmH+RRu3hrWPRXw54jeeR9mPbHKsVA4cNF0
 JvefwFZ6I/C2dbSoM55Faj2GpmYhvki7M6DzUSjpJiod45nbP6cXcov+6hsr9WnOrGms
 EMqHHSFsFe3fjTY1qqJl+EyREeR2LSJy1qk23aoNw6AZklfXqOye6hQLymBhOYMtjmlt
 a4bA==
X-Gm-Message-State: AOAM533GzJVjCVwp6DSA1mXK8joGOhGlbKuRy4/m9r4nXnwAmEtOD4hM
 VwtlM5g9orWSWu1K4j9vKUuQnP+M+760QA==
X-Google-Smtp-Source: ABdhPJzcvRztNHPSE3d/SFCF3SQpUTuNJaAwVwU2+4XZqDbqT3gqZWF224FakcKDSEu14xlsyLivZw==
X-Received: by 2002:a17:90b:30cd:: with SMTP id
 hi13mr5254213pjb.82.1601406328574; 
 Tue, 29 Sep 2020 12:05:28 -0700 (PDT)
Received: from localhost.localdomain (122-116-72-36.HINET-IP.hinet.net.
 [122.116.72.36])
 by smtp.gmail.com with ESMTPSA id v8sm6003950pgg.58.2020.09.29.12.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:05:28 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v5 05/68] target/riscv: rvv-1.0: introduce writable misa.v field
Date: Wed, 30 Sep 2020 03:03:40 +0800
Message-Id: <20200929190448.31116-6-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Implementations may have a writable misa.v field. Analogous to the way
in which the floating-point unit is handled, the mstatus.vs field may
exist even if misa.v is clear.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/csr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 05aca3243b..9292ee9963 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -552,7 +552,7 @@ static int write_misa(CPURISCVState *env, int csrno, target_ulong val)
     val &= env->misa_mask;
 
     /* Mask extensions that are not supported by QEMU */
-    val &= (RVI | RVE | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
+    val &= (RVI | RVE | RVM | RVA | RVF | RVD | RVC | RVS | RVU | RVV);
 
     /* 'D' depends on 'F', so clear 'D' if 'F' is not present */
     if ((val & RVD) && !(val & RVF)) {
-- 
2.17.1


