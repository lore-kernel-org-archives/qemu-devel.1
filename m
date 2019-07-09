Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7983FC73C53
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 16:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 340F621537
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 16:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w1w9jfpB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 340F621537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hktL9-0002T1-3b
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 12:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38092)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hkt7T-0003BQ-A1
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 12:37:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hkt7Q-0006gv-CM
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 12:37:29 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:44677)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hkt7Q-0006fi-6F
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 12:37:28 -0400
Received: by mail-pf1-x429.google.com with SMTP id t16so9548901pfe.11
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 09:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sH3HXM90i35Znfmo2ZGAwhUVyrLtmUH4wH93sEFL2IQ=;
 b=w1w9jfpBUL2R9wo3JtnQGTgHsunNZVJRYWCWyI0mNGTUG0OqHsGbVl854Q8IFI9GKU
 Ffb6NLTpjccUz0+1mre52bKP+Tf/V5xwYxglRR39pAH7x7Gd07+HRmm/LtfPmKBTCdoQ
 iThfxeO2e10Koi59KD/0Xau41Fye4XGJX76/+9pqia2WTBgjowGkNSW2gvEliwzq89+0
 qJa20oKZDPgCROUjtw1mZWOWqUGvMfpexdl04126IpF5m35/tdvtBiTRLOQ8AyzvX/0Z
 kIENDloEuhIMk5kJ42KVhb32PmmKSpryZkO9e5YQwYnkg/QymSAEo7AeBZxOgouW6G47
 RoMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sH3HXM90i35Znfmo2ZGAwhUVyrLtmUH4wH93sEFL2IQ=;
 b=a7SUZUH/FcXPzX9u4OLCRjwIPi6ta9dsLJq1ai0L/o3QSr4XsSckYi+YG4rpcNFpvi
 TItesqfgpUTX14L/k/BxUT7g43VpEOgG8UwL8a2xTCtwSMElSM2zB4QIUS64bdUFrD+r
 poYqb0rRc1LoaTUvOScUoORvr0vX42Zkbjti4SIFSdczwm8arPfpErat46ORSpfz3HKO
 yo+IvHZEHeCivSJcGBuUlV7iQDecuk4Z2QIZfUH9pMOgMN5vCfqDjuA8doBKWV0E3djm
 krhTkgm7dF/63NI38eqY5Em9yqxgS4VeUfmjAzjSN5I/dg5Ew3pEgqyi+NuPn1oWv7oK
 ScCQ==
X-Gm-Message-State: APjAAAXsfOZdpkmYMrpNInUByfTJDH3beXVribkrvQIhBaSuG2EmkjGT
 WbRrzvu/4WYe72zpw1zmOBJ11DppewQ=
X-Google-Smtp-Source: APXvYqxbwEZ14n4UEMtyG43rn7pIKIqiFm8k4838eIYPjmrpNrFf03LqF52JSEf1UiCHMonDqJf4Nw==
X-Received: by 2002:a17:90a:3247:: with SMTP id
 k65mr1053401pjb.49.1562690246238; 
 Tue, 09 Jul 2019 09:37:26 -0700 (PDT)
Received: from localhost.localdomain ([172.56.12.212])
 by smtp.gmail.com with ESMTPSA id v8sm19225231pgs.82.2019.07.09.09.37.22
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 09 Jul 2019 09:37:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 18:36:55 +0200
Message-Id: <20190709163656.3100-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190709163656.3100-1-richard.henderson@linaro.org>
References: <20190709163656.3100-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::429
Subject: [Qemu-devel] [PATCH v2 4/5] tcg: Remove duplicate #if
 !defined(CODE_ACCESS)
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org, alex.bennee@linaro.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This code block is already surrounded by #ifndef CODE_ACCESS.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst_useronly_template.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu_ldst_useronly_template.h
index 8c7a2c6cd7..d663826ac2 100644
--- a/include/exec/cpu_ldst_useronly_template.h
+++ b/include/exec/cpu_ldst_useronly_template.h
@@ -118,11 +118,9 @@ static inline void
 glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr,
                                       RES_TYPE v)
 {
-#if !defined(CODE_ACCESS)
     trace_guest_mem_before_exec(
         env_cpu(env), ptr,
         trace_mem_build_info(SHIFT, false, MO_TE, true));
-#endif
     glue(glue(st, SUFFIX), _p)(g2h(ptr), v);
 }
 
-- 
2.17.1


