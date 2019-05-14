Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3B5C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:33:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 945A420862
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wdyp/cs6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945A420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53140 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQdAn-0007id-Aw
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 15:33:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcvR-0002d6-Hn
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcvO-00070o-IO
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:20 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQcvO-0006zM-9X
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:18 -0400
Received: by mail-pf1-x443.google.com with SMTP id z28so18290pfk.0
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 12:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=gZNiNYQQXuA93bC9AkQ3RkBuv003My9kgUQccuqjr10=;
	b=wdyp/cs6Zycjdm7r/zoV+/gINfmq+a87JqC8wqYy9g4QWWQ2Ih3wvoSqi38BS4y10N
	dBE7kInnbygibVpGV8xlAgCow7QXo4s9KsjQa3+SDIN9jIrpJxW1L/NLb/K7OVhsXYcd
	yicu/NxBEdishimKpwxf1daCezCJ/0zeg4j+TWzwDbHgyEj2IHma/RuSqUOWco3Nyw6N
	QOvdRFNIp2TJB7Bh4CXiZbtN2LOWTyyoAJsDNkpJ/BVF8sFmFCNVn1+apMaCuwJqhDEc
	9YIsOXH91TlsOQnIxu+X2jyQXCo3V7IXSNj1x0ro83Cgv1GhS2LDFXqvSeFYXlCS9tFp
	9ZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=gZNiNYQQXuA93bC9AkQ3RkBuv003My9kgUQccuqjr10=;
	b=R6uqOhYsU/VAhwmiPX2vnkKooMdQN5PuAAlOKYeT7lVIWpag+hHmOFiJWawppB+Tc9
	25+srYrRrqRLp/SZbs2Ac/lBtDEpX0sZQXlWmVs9d/GztcKxCR1m5baXLAwl1ZcTAE7p
	22/ev/9VEJXCoa926fDbrsyagYucrk3W3y2L/jFU5sHY0YkEoBlijFY7+0pDtDM33Zks
	nSsLaE+2+fWUHUMJee8am0ki2UPCDqAoYNzdLJO63VK5oVC+RyVhSvZGwbwoqKIXDH1E
	67XO4irGJtPqcg3sHwnvO9PQach67E5BjFPfh+JgxszzNs0cb/kkna2ujXu6vPidEPsl
	F78Q==
X-Gm-Message-State: APjAAAVXd6wgWqa6EFOPuRkUVRIOo9XqH9ePrDv3Iug98OOSm8GPyVcD
	dMntiEeqbpmA1KmkApmBcr8AYFKKJGA=
X-Google-Smtp-Source: APXvYqxNq4t4fK30j+Qt3BVQi/JRh4jPCw0hThTfUJe+5F81dbAHCtxzCbw3JEu70uEPMSJkUe5FOg==
X-Received: by 2002:a63:b901:: with SMTP id z1mr29239919pge.102.1557861436949; 
	Tue, 14 May 2019 12:17:16 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	o6sm18682982pfa.88.2019.05.14.12.17.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 12:17:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 12:16:45 -0700
Message-Id: <20190514191653.31488-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514191653.31488-1-richard.henderson@linaro.org>
References: <20190514191653.31488-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v7 16/24] aspeed/scu: Use
 qemu_guest_getrandom_nofail
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
Cc: lvivier@redhat.com, berrange@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The random number is intended for use by the guest.  As such, we should
honor the -seed argument for reproducibility.  Use the *_nofail routine
instead of rolling our own error handling locally.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/misc/aspeed_scu.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index c8217740ef..ab1e18ed4b 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -16,7 +16,7 @@
 #include "qapi/visitor.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
-#include "crypto/random.h"
+#include "qemu/guest-random.h"
 #include "trace.h"
 
 #define TO_REG(offset) ((offset) >> 2)
@@ -157,14 +157,8 @@ static const uint32_t ast2500_a1_resets[ASPEED_SCU_NR_REGS] = {
 
 static uint32_t aspeed_scu_get_random(void)
 {
-    Error *err = NULL;
     uint32_t num;
-
-    if (qcrypto_random_bytes((uint8_t *)&num, sizeof(num), &err)) {
-        error_report_err(err);
-        exit(1);
-    }
-
+    qemu_guest_getrandom_nofail(&num, sizeof(num));
     return num;
 }
 
-- 
2.17.1


