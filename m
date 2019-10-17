Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D71DFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:51:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35273205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fn1iFLQw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35273205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL77t-0005nQ-3E
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5wD-00061t-5R
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5wB-0004TT-2m
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:32 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:34091)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5w9-0004Rq-5C
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:31 -0400
Received: by mail-wm1-x332.google.com with SMTP id y135so7059961wmc.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AQnBIoxWJcGF7VxKdA+3Fs3YaFpJDSvvaPPi8ZLzb54=;
 b=Fn1iFLQwMnhoxS3yIPFju9E96YfLjx54BdqcfhmrWNVrygLbKNGyEfeLQ2ATJTGKBj
 8eaJVRsCZ4YYfBxWiiUQ7ObY9poNZpZo+Ii/xu+pBFMmsDDtTW+zbLmMShsI7ch3gPeQ
 Ibh0+BKPNGv2ZCa4Q9KNnnSITSSyDRWi6YtTbupvHJ+10medIFoh06pOmQKp5t6cSbK7
 5Pgj261wcEltaMNNrsV5G3STQw00cuZ+zCNUEDpmUKeTgL1vta2tygeiRMKILPzvUq9O
 xV4F1+jCGXdnWxIJRCo7PL9NumsqDcqtTN5SbUfrwvcyyhL3/CnmMBl4bB84P4kpDuVr
 pRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AQnBIoxWJcGF7VxKdA+3Fs3YaFpJDSvvaPPi8ZLzb54=;
 b=LD77z2rGUHOa/LX0VLktgTZi3cLWaMK5dq8pP052xJwtux7D/KxwVPHCdMB+NBFFNU
 pl+QoY63YguQCsGjc126Po5TpwSb4IJTi2pLGNPU/ypi2sFBdCL/5cBI0EmR8ntxvP77
 9tEMW6qMUXRTEmrUnbJDu/Hl3NQgLTjcAm8LZ5VX6pp0KLTaxrrtWDSZKWkp8hlTrdXA
 /OrDxWVjo4+INNXNF/GNwLo2ykuX0tclUkTanODwSsIoniPtnXSXPEeQ55qKSOFvg3K5
 6abFPtYnDoEm7AqX9k8rZGDZIGVBz+kNBSUSnoSAHT9PrWy5BFzJiVRXCaBZI+IiZif7
 DM4Q==
X-Gm-Message-State: APjAAAWI6TFy52qroC5U70jX3HC+AivEK4f+kvwT+CcuC3eIddFW/19z
 D+ow3OwVVmuYK6A0zTgBZ5Lvzw==
X-Google-Smtp-Source: APXvYqzxw9w+S5heXlMTAlT5xz0v/AYuhnFSXq4tR1OLPc+mX9V2MuqvF51pjE1sTKtLwfn49hgX/g==
X-Received: by 2002:a1c:2d88:: with SMTP id t130mr2927385wmt.75.1571319327222; 
 Thu, 17 Oct 2019 06:35:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r140sm2650465wme.47.2019.10.17.06.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:35:25 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B18361FFC8;
 Thu, 17 Oct 2019 14:16:20 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 51/54] accel/stubs: reduce headers from tcg-stub
Date: Thu, 17 Oct 2019 14:16:12 +0100
Message-Id: <20191017131615.19660-52-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't need much for these. However I do wonder why these aren't
just null inlines in exec-all.h

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/stubs/tcg-stub.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index e2d23edafe..677191a69c 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -11,7 +11,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "tcg/tcg.h"
 #include "exec/exec-all.h"
-- 
2.20.1


