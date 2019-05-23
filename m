Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC379C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:33:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA8E821019
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s36ruKot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8E821019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37653 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTon2-0002s9-Tg
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:33:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTodu-0002tz-1E
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTodt-000766-08
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:24:25 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hTodr-0006uh-0H
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:24:24 -0400
Received: by mail-wm1-x344.google.com with SMTP id c66so7251224wme.0
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 07:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=0a+RF8S0YvjE+0k16KJTj/Qgw1ZTceu2oeIc7kE90J8=;
	b=s36ruKotbViYmwprbIqvwx6JUZmsVUHq6HOWeloAGXrzSXJwOLmoMELRfOO3Z/3L4i
	Hy4BmS1mVzyAF6UdVTB9jVPGlYBai4XYD/YWteNamg7E71jb3mJTfU4+z//REdvFUgxm
	COLg+jS/3Rx3Dz6QRC52uYW/nPwxKW7ui+wdTjWu7k/j5V5DAvKXY7Acx+q4/TCFywJn
	dX3mn0jfm6RWbL916JHpOlSxATv+lWc/S5qY7ZhxKTbk8Uqg+98Mp9foX0xQcBguKttq
	5gC2br08PihZXYGr0tO4zIiBAJKvtwZyWTwy4jxJGxJ57qbjZmVlQo4pvvudaaIetxns
	rFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=0a+RF8S0YvjE+0k16KJTj/Qgw1ZTceu2oeIc7kE90J8=;
	b=sWK21TLZxX46bT/xi2q5ezEyi3QvEqnc2RdKBUgjkC3aqUtWi3QCJYIVGjx/Usf+og
	qCzWf14N3Cd72LPkSC3LtLk6DqEjJrl+skf4VE3hybTEW1/SgjQ3OyAo35S0+b9osfTE
	oJyvUjqPJ8w8XGyHhrSg0N+6xwuh4dIhW2/EiHyJGpj4efJLn0jEVZCn35W/Zkkhs7Ll
	5AZp6aD4Qt3jzxaOP/RZehB2RVdmmPCCH9ClQy8JhkpXdp//a2nuaOcidhKmH3qXq5Gn
	6jbzTxeeS8mE+gWB2SuP1r/K8OpMMEL1VVt6/9oReGqQJChb0j8EPuS/AMEvZYgbTt+d
	iMEg==
X-Gm-Message-State: APjAAAVLLRCgZVH5zQMcA+Qqff4wDnwjLsk8d9WptKgBVSqt46Bil3r8
	NnVmfC1odhZR9K3WuQtGZYeK1gY4EI5w+g==
X-Google-Smtp-Source: APXvYqxkFoC1IHZ4kgp7ihcVOunAJD/p+XZvT93ETAUCp7dA97AmpbwkOqbyxAKETNKO96JiQMKDzw==
X-Received: by 2002:a1c:a804:: with SMTP id r4mr11960271wme.21.1558621448518; 
	Thu, 23 May 2019 07:24:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id z5sm9700617wmi.34.2019.05.23.07.24.07
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 07:24:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 15:23:53 +0100
Message-Id: <20190523142357.5175-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523142357.5175-1-peter.maydell@linaro.org>
References: <20190523142357.5175-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PULL 08/12] hw/intc/arm_gicv3: Fix writes to
 ICC_CTLR_EL3
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

The ICC_CTLR_EL3 register includes some bits which are aliases
of bits in the ICC_CTLR_EL1(S) and (NS) registers. QEMU chooses
to keep those bits in the cs->icc_ctlr_el1[] struct fields.
Unfortunately a missing '~' in the code to update the bits
in those fields meant that writing to ICC_CTLR_EL3 would corrupt
the ICC_CLTR_EL1 register values.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190520162809.2677-5-peter.maydell@linaro.org
---
 hw/intc/arm_gicv3_cpuif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 000bdbd6247..3b212d91c8f 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -1856,7 +1856,7 @@ static void icc_ctlr_el3_write(CPUARMState *env, const ARMCPRegInfo *ri,
     trace_gicv3_icc_ctlr_el3_write(gicv3_redist_affid(cs), value);
 
     /* *_EL1NS and *_EL1S bits are aliases into the ICC_CTLR_EL1 bits. */
-    cs->icc_ctlr_el1[GICV3_NS] &= (ICC_CTLR_EL1_CBPR | ICC_CTLR_EL1_EOIMODE);
+    cs->icc_ctlr_el1[GICV3_NS] &= ~(ICC_CTLR_EL1_CBPR | ICC_CTLR_EL1_EOIMODE);
     if (value & ICC_CTLR_EL3_EOIMODE_EL1NS) {
         cs->icc_ctlr_el1[GICV3_NS] |= ICC_CTLR_EL1_EOIMODE;
     }
@@ -1864,7 +1864,7 @@ static void icc_ctlr_el3_write(CPUARMState *env, const ARMCPRegInfo *ri,
         cs->icc_ctlr_el1[GICV3_NS] |= ICC_CTLR_EL1_CBPR;
     }
 
-    cs->icc_ctlr_el1[GICV3_S] &= (ICC_CTLR_EL1_CBPR | ICC_CTLR_EL1_EOIMODE);
+    cs->icc_ctlr_el1[GICV3_S] &= ~(ICC_CTLR_EL1_CBPR | ICC_CTLR_EL1_EOIMODE);
     if (value & ICC_CTLR_EL3_EOIMODE_EL1S) {
         cs->icc_ctlr_el1[GICV3_S] |= ICC_CTLR_EL1_EOIMODE;
     }
-- 
2.20.1


