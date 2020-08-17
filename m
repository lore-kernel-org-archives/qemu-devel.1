Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48094C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:20:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143F722B3F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Yf+JB7JG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143F722B3F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7bJW-0007XY-8h
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7atQ-0003KD-LU
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:53:24 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:34380)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7atP-0005OI-0h
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:53:24 -0400
Received: by mail-pg1-x52e.google.com with SMTP id i10so2258148pgk.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6kkcYautSYvytvSbaEQJQyjXHNh36DVL7LgNPrrKZR0=;
 b=Yf+JB7JGL3mKa2gEm/WdhCluqAQc/JagAXXbxYOY9irtKedfYxMWX1TqomFyAUjr5E
 z7aMt7EvlZYqZG/2a14t7C5eQIL9Jls6PSJ8cj10aanTv/k3Q1rK61H8UaGGN7eTLDWn
 Oj3XYR0OMyh5/rmBy2QbgOJYAS7zw74RA8StaN5gHy1F25tUeX9CdDqw7nRJEjnB4Q1+
 noCQ17BoApwE4PNahIXEq+E8qvZ4ggZf5spZl5Ibovi9sRQwPS09zBINK5hCi7VPJjDL
 JLrGyppErDq5BoqxhqjQfJ2uJE2+uReMqw3RuqeiLlBPLW47X1QhHw6XinJDBYHwaHPX
 g3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6kkcYautSYvytvSbaEQJQyjXHNh36DVL7LgNPrrKZR0=;
 b=HzEmzUP/TKgI9kqxw/wFLCUJ8is8VYpF/gZ9LLEfr4HTRH3bHOs390gp0DzMuNiu5C
 Iz936sVS1xMS7SC689kTT4AmVrYZYROcP87C0AH4QDZfW9drSAALXF1jVf61myOLgZFZ
 GUKoePNPe1x6Qu12Qo/T0/DCRub0H7ZQiBv9wmDePbP8l7GrsB0Qdgciao4YX5HUH1gS
 nixZlx7blvBO/jmJM2oXtX1g9oNaTXCrDlN/0z2yTmF2gtBwf8Vh7bZZu92qlVGdA+LG
 ckTwDSPd6VGHKhrUBcU9NiqlvJeZPaLyBIHnK6kNl8vLeaGxYqo/mR4RZ3ZyM3+o5i8V
 tnJA==
X-Gm-Message-State: AOAM530ce2E8CmsEhSH6iFZXbKHn/LmfpeEe10V8nItiMYpR28XfJpZz
 NxDV6STtbDQxkcrBUaO1dQn1beYrhhkRrA==
X-Google-Smtp-Source: ABdhPJwfZcwwag2FneObXlOF+JimkHxftHRKnrG1uYpfC7q3nuq3d8e73t0subr8MW9m2BV4wiL9ng==
X-Received: by 2002:aa7:84d4:: with SMTP id x20mr10272819pfn.96.1597654401489; 
 Mon, 17 Aug 2020 01:53:21 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id d9sm16478588pgv.45.2020.08.17.01.53.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:53:21 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v4 70/70] target/riscv: gdb: support vector registers for rv32
Date: Mon, 17 Aug 2020 16:49:55 +0800
Message-Id: <20200817084955.28793-71-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817084955.28793-1-frank.chang@sifive.com>
References: <20200817084955.28793-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x52e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
 Greentime Hu <greentime.hu@sifive.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greentime Hu <greentime.hu@sifive.com>

This patch adds vector support for rv32 gdb. It allows gdb client to access
vector registers correctly.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 gdb-xml/riscv-32bit-csr.xml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/gdb-xml/riscv-32bit-csr.xml b/gdb-xml/riscv-32bit-csr.xml
index 3d2031da7dc..bb98b927995 100644
--- a/gdb-xml/riscv-32bit-csr.xml
+++ b/gdb-xml/riscv-32bit-csr.xml
@@ -248,4 +248,11 @@
   <reg name="mucounteren" bitsize="32"/>
   <reg name="mscounteren" bitsize="32"/>
   <reg name="mhcounteren" bitsize="32"/>
+  <reg name="vstart" bitsize="32" group="vector"/>
+  <reg name="vxsat" bitsize="32" group="vector"/>
+  <reg name="vxrm" bitsize="32" group="vector"/>
+  <reg name="vcsr" bitsize="32" group="vector"/>
+  <reg name="vl" bitsize="32" group="vector"/>
+  <reg name="vtype" bitsize="32" group="vector"/>
+  <reg name="vlenb" bitsize="32" group="vector"/>
 </feature>
-- 
2.17.1


