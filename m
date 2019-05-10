Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B80BC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:27:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26C7520578
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VYt0RnZx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C7520578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45083 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP7Qh-0005xl-BB
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 11:27:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7JZ-0007XE-K9
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7JY-0008SO-P6
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:01 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP7JY-0008S4-JS
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:00 -0400
Received: by mail-pl1-x643.google.com with SMTP id p15so2989743pll.4
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 08:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=9CI4oI1nkvf0QxqoUGGat3a67tCPvWsOkb0Ljyg5Gsk=;
	b=VYt0RnZxKpvBAVDDq+CSEzv1d+0RsSm14ybtttKdZcKmfPqzLP9hTO8PkVhwRZfQH9
	NPJOUOLrBnJMMTDgbiL554bpG3is/VcICqhg61Ht1xoO6UWB4DzdnZjF7eAQrU8syDBn
	5XUJS1SH9igwOLgmeaneDwPsOYuAbpxtW19uOpoEwZTVvInlP3Y4ou0x2mJU6FQIWIN+
	c3LWgUHqtgJ1NQc79QPfk7y4prtLBzBwWMXNpzaZhKTfEvNtBT/bhostrEpshrW/fsZH
	GSMzeafEXIAiH0TAB27iw+au7l5b0DNZJ7Q+z+Rpdk+MZr+Q5h122BVpiRxxjM5TQyEA
	u0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=9CI4oI1nkvf0QxqoUGGat3a67tCPvWsOkb0Ljyg5Gsk=;
	b=uoIbIqrnuQRoXL5F0xFTkN2GP7gXxErJz3GPu1GWI8gL6CeprK6K/fyD/SSOneHqDP
	ZTpn6uO3CiXK6rn8F7klWSmOXwIvoOjxGauiPIB9TDX89HroTQVBcdmidbiZgPCH6W6k
	SWPoklfQYJSAFsdwYd3yLYvA1q3gwEgw41SSJcoDL+JCOI84usYyBc9xXF+pBktUEsup
	/DL4DMaPFscDvSUaZjsqG1G78zvaHsMBKefkIfkTuwC7r6OnKoeAfGFpHhZxRPStEfo+
	+uOEqyQNH3zYlDBVw71EH+HgN5VOgs3zb1kOp0PdCJ527zLJ3JYG15ZGrVm9nu1X1fcP
	z80Q==
X-Gm-Message-State: APjAAAV+p7oQy0YTBjg/pvVESrZ3PreW3fcfx95HnbbcqGJ2qinUGX+J
	RfyuY2jPhfUeoljrzQrBhSAaywjos2E=
X-Google-Smtp-Source: APXvYqwMikYWQRQnVt46USr7TusNbzq874CTk8I3vZQ2+X4xwVVDMmeEwT5DEDuuuOW8qx13ajaToA==
X-Received: by 2002:a17:902:b606:: with SMTP id
	b6mr14084714pls.100.1557501599442; 
	Fri, 10 May 2019 08:19:59 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id 19sm5920517pgz.24.2019.05.10.08.19.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 08:19:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 08:19:27 -0700
Message-Id: <20190510151944.22981-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510151944.22981-1-richard.henderson@linaro.org>
References: <20190510151944.22981-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PULL 10/27] target/mips: Pass a valid error to
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
Cc: peter.maydell@linaro.org
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


