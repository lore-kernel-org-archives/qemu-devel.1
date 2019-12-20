Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4561C2D0C0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:35:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 736232465E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bkB8n4O0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736232465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJNK-0000Cu-B8
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:35:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iiJF3-0004ns-3T
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:26:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iiJF1-00078g-SP
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:26:56 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:52386)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iiJF1-00073W-Iu
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:26:55 -0500
Received: by mail-wm1-x333.google.com with SMTP id p9so9138890wmc.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 06:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=woJz/eJmvbgXNcYcfQzwAYhmXMaSuqBNsrUl7dl2UT8=;
 b=bkB8n4O0JGg+VztTag2t2tYr6kjshA9K5xLVexzKsUVvjjyQ1LSF1Ex5M8kJkfYQkU
 aslqLS2NvzoWFK+dqaNZHPVL6AnoRplPoaDR7GZE0PcdfH5q8T0Txh/20pKoU/BSllWq
 aE9uOWIHn4pjwEO1kk550QmAhiGqTHyKt9WjCeC2aaE8bpEbJGvd8vp2AJv6egj6u9w+
 A4BLqxp+l58RvLURe20hks8aTMYm/Ro3f43DeqRwiOs0B1+bcrA0m9cBfZJYTV7Fc3fk
 Mam+l2e1tA4toGxva9QlYwL7R2av/oAM5+7LysR6dul/aP3XWysjvomszRpT+rjbEkbB
 X0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=woJz/eJmvbgXNcYcfQzwAYhmXMaSuqBNsrUl7dl2UT8=;
 b=kdci/t0jQyQ7/yOxjaQEa0ksdcPUFrW+tWqwZ7ylT+FPVcIcC2ZnJ8gnENlBI4I4p4
 28KT4mf5EBuOPUGqaDZsv6ActFklKTh4WIIZkd1YDMy17FB7ZzkvZMN1Sgs79wJFCV+C
 V36IMObwcsygFBdnlP28n0c7BDP5SaoLOTmjBovyLUo4YozVmh6L0isIfr/aILhPVy5m
 qWZdrLHbSwl6U8R/HXVyvmmnpMtlWuYvnuXg6DThWLBNtrDB0IVV9AAP2BTibIkcftEX
 ZlE6AQ6qN9aW/5Z3LLvomkAiXcFu+QxjSBrb75NNVUxozp87MZp6E3uDo7bIbcI0Dh08
 l+xg==
X-Gm-Message-State: APjAAAU0XjCjYKWd3EtIYpdRbUABlJ2p1ltI7GafRgUR05ySh+STR3SV
 8BQk4IkXaHmUaNrngYArnUq4SXLzV7ZfwA==
X-Google-Smtp-Source: APXvYqwrh3J5I1N9Yno+qcYEIH1yDsvBc+QlSZjJ9K2YXss3fNsCvXNUObaP/iZcYUo/xtWWb6krvg==
X-Received: by 2002:a1c:4b01:: with SMTP id y1mr16048592wma.12.1576852014072; 
 Fri, 20 Dec 2019 06:26:54 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t5sm9741814wrr.35.2019.12.20.06.26.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 06:26:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/12] hw/arm/smmuv3: Apply address mask to linear strtab base
 address
Date: Fri, 20 Dec 2019 14:26:37 +0000
Message-Id: <20191220142644.31076-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220142644.31076-1-peter.maydell@linaro.org>
References: <20191220142644.31076-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Simon Veith <sveith@amazon.de>

In the SMMU_STRTAB_BASE register, the stream table base address only
occupies bits [51:6]. Other bits, such as RA (bit [62]), must be masked
out to obtain the base address.

The branch for 2-level stream tables correctly applies this mask by way
of SMMU_BASE_ADDR_MASK, but the one for linear stream tables does not.

Apply the missing mask in that case as well so that the correct stream
base address is used by guests which configure a linear stream table.

Linux guests are unaffected by this change because they choose a 2-level
stream table layout for the QEMU SMMUv3, based on the size of its stream
ID space.

ref. ARM IHI 0070C, section 6.3.23.

Signed-off-by: Simon Veith <sveith@amazon.de>
Acked-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 1576509312-13083-2-git-send-email-sveith@amazon.de
Cc: Eric Auger <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Acked-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index e2fbb8357ea..eef9a18d70f 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -429,7 +429,7 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
         }
         addr = l2ptr + l2_ste_offset * sizeof(*ste);
     } else {
-        addr = s->strtab_base + sid * sizeof(*ste);
+        addr = (s->strtab_base & SMMU_BASE_ADDR_MASK) + sid * sizeof(*ste);
     }
 
     if (smmu_get_ste(s, addr, ste, event)) {
-- 
2.20.1


