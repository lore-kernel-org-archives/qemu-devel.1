Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8927C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:57:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFD68206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ix/ppgNW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD68206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYct-0000F3-Rv
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKY-00079A-UG
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKW-0001hb-QX
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:18 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:39020)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYKW-0001h1-N5
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:16 -0400
Received: by mail-qk1-x742.google.com with SMTP id b62so8194629qkf.6
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O0fBrT3P1tRSLH4phcxb7WjFxDduimB9rIeQgvMHfic=;
 b=Ix/ppgNW371q67atX1d6cmfGUWOXxSPo7C2SBh2ugKoGfWEg4NUKasXK6aV3spE0b2
 KlwElvLOBxB5KYiec8f8eIe54rhl1HC5W6e1OQSPXlMsD1pBJBwcdQ7QUYaW3JDr0l1E
 NdMxepdRYNBvvnQz0nlFkS30SPyMRJoxag4bXQyzQBx1VJWeCQzYKx/0K6C61Uwc5kjs
 uMYEKQMWqRleMKWrBC6I0vLmnZv2p6FtZmBg5Xv7zX0xD+AM0eHiSMIYUYOOCpaERYd/
 yuZgYvYtGhZY3zMez/tVqbzD3jBoNt66oTAkOJXsYVj020PidgrvKnIB/qdGxjNKfnaK
 96Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O0fBrT3P1tRSLH4phcxb7WjFxDduimB9rIeQgvMHfic=;
 b=NQGuSk+rGc3/mQzG33uDFhsyOwiupn8g8vpiSJ7CzIa4tXYN6iOiPRQeZ4aNdWLRSj
 m28ryvMmyrocdleyjHuij5wZnd2PUYKnmm1tfzNXAmI5ncdrUCPnMKQ+67Z1oTml99iz
 IEOyUrJEfBYqo+qdQQ+N+KSzwoiJzuOgvsCN9anDIffCxr/CYleQZCtYl9YXypbcPK57
 p9rg5t2y7aDyCS3E/WUa1pVyKlyoJUGkMIlxnq1KJLdgYdgS0JM+sBOyXklJvDqlUAcf
 Bovj0n7+303UqMvRiw7KTrpvVODdEXJ4TV5/wxu0/F1E6X5tdfOKXHPVUX9RDAB/ObFu
 xagQ==
X-Gm-Message-State: ANhLgQ3eQQeIDalE7anl90r24EfG0w+WvovRoP96uA2XoIVri5dSRpbq
 dQxu6nLB/4iSRaUFFe+57ywznF9HEwnPoA==
X-Google-Smtp-Source: ADFU+vszECd+ASz2NNodepEaX7KkNG1/k2bVJoEWiHgbMY22a0kNucX+67VlNdq1fQ+JyDO6qfAczw==
X-Received: by 2002:a05:620a:88e:: with SMTP id
 b14mr10476524qka.449.1585251495038; 
 Thu, 26 Mar 2020 12:38:15 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.38.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:14 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 30/74] openrisc: convert to cpu_halted
Date: Thu, 26 Mar 2020 15:31:12 -0400
Message-Id: <20200326193156.4322-31-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
Cc: robert.foley@linaro.org, richard.henderson@linaro.org,
 "Emilio G. Cota" <cota@braap.org>, peter.puhov@linaro.org,
 Stafford Horne <shorne@gmail.com>, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Stafford Horne <shorne@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/openrisc/sys_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index d9fe6c5948..2615571ce7 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -134,7 +134,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
         if (env->pmr & PMR_DME || env->pmr & PMR_SME) {
             cpu_restore_state(cs, GETPC(), true);
             env->pc += 4;
-            cs->halted = 1;
+            cpu_halted_set(cs, 1);
             raise_exception(cpu, EXCP_HALTED);
         }
         break;
-- 
2.17.1


