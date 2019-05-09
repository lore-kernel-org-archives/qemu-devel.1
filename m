Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FA2C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 22:29:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7840E2173B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 22:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UQy5424k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7840E2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33450 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOrXg-0001C4-KI
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 18:29:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOrV2-0007fq-Ro
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:26:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOrV1-0005TL-UT
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:26:48 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:42807)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOrV1-0005TE-Oz
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:26:47 -0400
Received: by mail-pf1-x442.google.com with SMTP id 13so2041243pfw.9
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 15:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=9CI4oI1nkvf0QxqoUGGat3a67tCPvWsOkb0Ljyg5Gsk=;
	b=UQy5424kPPPWI4jgBR28IqDLu+Zq0U/tL5t6vQZK6SVOOhY3TM26QzfmXbx3dCQLFE
	rQAOcVZg7pUcT7Wpp/Kot1n9cgLRw8j7Ymo0RbrIckZLL0WrSVkEC4I/E7iN5WDwV7eN
	fKPW2PbBq9N4Nq1SqRRs5O/0uNvChUQvXnJqht7ZZpOH7QTpBtTLuWfMn1xFR8PEYDiH
	YM5aUfveJYPfD3oSphBAmm2bMjGNp+VMw8cYBJu1s98bQdiG/Ohub/dnwLAyn5ZQ+8mK
	tWoqVwzUN9STQTpJn3TWPnGt1ummSKaxQAe1Vm/QeQCntwxnnv8/vL6q6Xgm0VkpEjk+
	8Otg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=9CI4oI1nkvf0QxqoUGGat3a67tCPvWsOkb0Ljyg5Gsk=;
	b=A3hG9D+S4U+mGj8+Vub00pAPaHKmhjtGqaaoBWwB9p1ucRQB4t/TJuqzut8Rm+VlyQ
	6hUTLwTVu8Wb5yUBBbj1NAdJ1ryzMz33JY86FWgOWGpF/QCltpDipCtzPbZc5AjkmeF3
	PPdukm1+acDdYXvQjEyjE0QkUQthODxtdu+JW3pMMLZiJskeP/MdvRndNQBtO+PcbZ8V
	GgRri7LDX6MhK7Dytdxoc1KA7QhFRZlxiIC/HCpyzHDBxxFq6wIcLrFKwL6xsHEWYDsy
	cFDfS+Wcd4mzHKmIqVNgqZRFzZ//ldkeaE63/mV+xzj51PY4X3svRFblprje0jfaUAPi
	+HCA==
X-Gm-Message-State: APjAAAUDLuo4A3Cr2Fj4bEZSQVEuOAWVDd5aYkvw5uqZqBDG+xhC4NuE
	lHgOV8JFRuhVYcJ3rCzQnIShHnhZ7jQ=
X-Google-Smtp-Source: APXvYqwuumf6KWL0RblLIbXnA1Rg/i/WyCl5tgH2BkaLiHjV10xagSCLEMaHDsD1UaslDG18hgmYGw==
X-Received: by 2002:a62:4558:: with SMTP id s85mr9130985pfa.171.1557440806561; 
	Thu, 09 May 2019 15:26:46 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id m2sm4490521pfi.24.2019.05.09.15.26.45
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 15:26:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 15:26:14 -0700
Message-Id: <20190509222631.14271-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509222631.14271-1-richard.henderson@linaro.org>
References: <20190509222631.14271-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v3 10/27] target/mips: Pass a valid error to
 raise_mmu_exception for user-only
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At present we give ret = 0, or TLBRET_MATCH.  This gets matched
by the default case, which falls through to TLBRET_BADADDR.
However, it makes more sense to use a proper value.  All of the
tlb-related exceptions are handled identically in cpu_loop.c,
so TLBRET_BADADDR is as good as any other.  Retain it.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/helper.c b/target/mips/helper.c
index c44cdca3b5..cc7be7703a 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -884,7 +884,7 @@ int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
     int prot;
     int access_type;
 #endif
-    int ret = 0;
+    int ret = TLBRET_BADADDR;
 
 #if 0
     log_cpu_state(cs, 0);
-- 
2.17.1


