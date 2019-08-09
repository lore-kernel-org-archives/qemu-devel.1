Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E86C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:20:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD18A217D7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mnOiNaDG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD18A217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw14T-0007kw-1H
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 05:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48035)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hw13q-0005xP-EZ
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:19:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hw13p-0007aq-HI
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:19:46 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35690)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hw13p-0007ZS-BF
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:19:45 -0400
Received: by mail-wm1-x342.google.com with SMTP id l2so4980249wmg.0
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 02:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/m2fkWm2cNUYmNUkZdHYoujbGrC7KdFbzlNmstGf9Cc=;
 b=mnOiNaDGcKQXTGeDlpJf092E2OLQRl4RhAqf9J6gVDI/wcFc7cFFv3xDcX6Det6/F2
 s6AKOPp2R07sOLo0zfdoaJvzXnflBsUzlwDgSSpAnDWWOkTa9sAiT1odCJxYcf68HDa1
 lUwuBqnqwkGo/6YZD5vQWbTFxjclNJwMNPGKMUJI5V7IygD3kk/rUlAejt9EOnm2LcB8
 +kCkWS4BsCkwaHfFRpMVMYlO8SkvkoA1XNSgGUMU0zfRCN6RySudc747DAhN1GpIVN2H
 tGTQiI2+cfk8rvHEkFTY7gFwPmgobu7a9Zgjamc670mrrK3rfB7RPuLjr6+UkHGsFhK2
 9nIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/m2fkWm2cNUYmNUkZdHYoujbGrC7KdFbzlNmstGf9Cc=;
 b=c+JuOkMCgtDPxnX39a+inx58D0zxeSsAxGxAyrNUHYZnSq7bmUTcKagM5MIOmdTaA5
 za6oupmWWky4lL2ll1QMN6WIJWaf+9RU0ECFGjcx2CKJSVscXzbf0qOVGvjVSJHx4Ocv
 Y7KpXpUwofHDVxB3OCDWJVmoFradXjIVxH0gBqa7xxJ4kWwLrgDDIdYRxyF3oIPgi3oa
 /QNI2GpUXe1yE2vIfWwrdLA1u6n5wzE+oYvpUhIMuN6X2DCjJFSMzlp5jVxrsIl1+uKv
 PIIe8SVCfaRQj3bKJ2NfgbCodtGZr69ObtWCaPe2mfWSxzct3HfGdoR8BdsdZ15FRMN9
 /e0Q==
X-Gm-Message-State: APjAAAVr636o5ahxaIAjMgr+UAH/OIZEA7FxIFNI7yXsA2s69RwW5SJm
 /9DDfEXPgEGD0lAqBf+V/iBDtA==
X-Google-Smtp-Source: APXvYqyVLzfmuM3J5s8XmdVVDAS3PsidKf7ILbEg55gfyzXhDLaPC8+8vKH4YIvstd4bXGkIo024wQ==
X-Received: by 2002:a1c:a615:: with SMTP id p21mr3744930wme.121.1565342384202; 
 Fri, 09 Aug 2019 02:19:44 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id b186sm3939441wmb.3.2019.08.09.02.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2019 02:19:42 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 295301FF90;
 Fri,  9 Aug 2019 10:19:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  9 Aug 2019 10:19:36 +0100
Message-Id: <20190809091940.1223-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809091940.1223-1-alex.bennee@linaro.org>
References: <20190809091940.1223-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v2 3/7] fpu: make softfloat-macros
 "self-contained"
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, armbru@redhat.com,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The macros use the "flags" type and to be consistent if anyone just
needs the macros we should bring in the header we need. There is an
outstanding TODO to audit the use of "flags" and replace with bool at
which point this include could be dropped.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-macros.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
index c55aa6d1742..e698bca4e1d 100644
--- a/include/fpu/softfloat-macros.h
+++ b/include/fpu/softfloat-macros.h
@@ -82,6 +82,8 @@ this code that are retained.
 #ifndef FPU_SOFTFLOAT_MACROS_H
 #define FPU_SOFTFLOAT_MACROS_H
 
+#include "fpu/softfloat-types.h"
+
 /*----------------------------------------------------------------------------
 | Shifts `a' right by the number of bits given in `count'.  If any nonzero
 | bits are shifted off, they are ``jammed'' into the least significant bit of
-- 
2.20.1


