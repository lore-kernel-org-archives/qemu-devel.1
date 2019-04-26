Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8787C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 18:23:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 876C62077B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 18:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RjISiv8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876C62077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50539 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK5Vu-0007HK-Mo
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 14:23:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK5UH-000654-0U
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 14:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK5UG-0006ON-4X
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 14:22:17 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:40847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hK5UF-0006Nb-T8
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 14:22:16 -0400
Received: by mail-pg1-x52c.google.com with SMTP id d31so1993096pgl.7
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 11:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=4u8gKkpGR4aqCQFLKD9tFetlT7FI9TY2FudP4qiIP+A=;
	b=RjISiv8R+AINfNFxZa5MkHAHVCtpo2mGQnFrnRiqNKs1U+gnVmHxiFJsv+sNuxrE2T
	1I8oAryan6bkzzqdOosChkHErHiBUkOWVKSnrrx53w5/zH7VzwPPCHUas4Le3zgpYytN
	C2BzpYpUgvtpcAU+X4UCnctWDs4/CutzjqeOJ6VT57YI2826o8L0hQVqrSnTsIiVjRhZ
	rDKr+b8fDfVEjI/HkowLduVxp0oBsI4fdNqgCfLbwGz74qxWc417wYGy3roGInXnZo6o
	Ugm3wctoGi8Wn7arRRFPG4WuJbQNeXsZ7gYVZQpnHozFxuksII4THnqjkU7OC2pInb7P
	0bIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=4u8gKkpGR4aqCQFLKD9tFetlT7FI9TY2FudP4qiIP+A=;
	b=TjJNq3ur1+zZUPLE6nbRxYofmvXsUo0d3AYcPTkidJ9tSVKrdA2AyR+OKbzzthRdko
	sEXOYeViCex5HW2Dmeg7nCVkbBnWBSF8RCsvlF8eW9s1D9+7t2pScHKB7MIr/Cfwiq5W
	/wzadz2b0jcjEG7rCjM7nQxrGo0ebmJvlFo2aZXv4MaL6LXqjynNy65VX0fnq3Apdbmh
	xlnxP5esJUKtqCaxhM4LN/8gos5QRaXcFeHQl9tiI6GzyXzV22Ldnr6Ilp/wW6vGfHCZ
	VUT90vwiUnvlUnfkizWSpHLyzrd09NG5cgajmsgVd6HuYxlkwrnRKgRjGvhNOH0o4NZd
	dqYw==
X-Gm-Message-State: APjAAAW6dYW8sJYS9UpzMbh54Ozb01uBku9UOwB+rV8DBH3xswrsse25
	35Psr8J68Ml85PRzc5UdCnUM7pTeo60=
X-Google-Smtp-Source: APXvYqw0NVYeTiIJtiI0yQ6IAiBv1z9+vDdM0kxi9FzNIGHTnAWlx+cZREWaC/x+0EmAUn8A7dp7Dw==
X-Received: by 2002:a63:243:: with SMTP id 64mr44676764pgc.214.1556302934530; 
	Fri, 26 Apr 2019 11:22:14 -0700 (PDT)
Received: from localhost.localdomain (97-113-179-147.tukw.qwest.net.
	[97.113.179.147]) by smtp.gmail.com with ESMTPSA id
	c28sm15977095pgm.42.2019.04.26.11.22.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 26 Apr 2019 11:22:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 11:22:10 -0700
Message-Id: <20190426182210.10442-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426182210.10442-1-richard.henderson@linaro.org>
References: <20190426182210.10442-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::52c
Subject: [Qemu-devel] [PULL 2/2] target/hppa: Always return EXCP_DMAR for
 protection id trap
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
Cc: Nick Hudson <skrll@netbsd.org>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426182210.MR1f2k28pXjONsczWzYmljqU-F6KLoSF7MlSeDcpq40@z>

From: Nick Hudson <skrll@netbsd.org>

The EXCP_DMP trap is considered legacy.

"In PA-RISC 1.1 (Second Edition) and later revisions, processors must use
traps 26, 27,and 28 which provide equivalent functionality"

Signed-off-by: Nick Hudson <skrll@netbsd.org>
Message-Id: <20190423063621.8203-3-nick.hudson@gmx.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/mem_helper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index c9b57d07c3..77fb544838 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -154,8 +154,7 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
 
     if (unlikely(!(prot & type))) {
         /* The access isn't allowed -- Inst/Data Memory Protection Fault.  */
-        ret = (type & PAGE_EXEC ? EXCP_IMP :
-               prot & PAGE_READ ? EXCP_DMP : EXCP_DMAR);
+        ret = (type & PAGE_EXEC) ? EXCP_IMP : EXCP_DMAR;
         goto egress;
     }
 
-- 
2.17.1


