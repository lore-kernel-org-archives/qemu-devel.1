Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0503FC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:20:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C408B217D7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wG5LdLv/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C408B217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw14O-0007VS-WC
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 05:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48007)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hw13o-0005x7-OO
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hw13n-0007YG-QM
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:19:44 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43219)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hw13n-0007XG-GB
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:19:43 -0400
Received: by mail-wr1-x441.google.com with SMTP id p13so22980724wru.10
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 02:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ds83hJyVy3euPF2S1v2mM17n4r45qbvhIwoyu2sO0lg=;
 b=wG5LdLv/jeloLlOka4BHFlK3tP7KftKjcNXc5AHuL983nTS26nFSgTpbaTl/nVdS99
 UW6XB5KGwiQhCjsgTf+sEyl8mXlaZ5S2lGxqibMPnq3pWYZAuZoQeflFKlDYMhZ2mKoy
 fWS92ljiaPD+m7df9gsdpC19A35xtL1Yre6GyPfd3Nxa0BTTZGhaxCFkiAhdTWSandM+
 30SLb1R/wcc9n05n3cIXa6dBUUwHWArAvZTjf7T/JjPvfnNW8d6HR10oJ3uslSrxgPxy
 phSG6eU+RIGqcXlxC5qdJ6PSEHenvOZjJtnTlsCExTccAybXfglJ+pEG1AvUajY8n4NY
 x2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ds83hJyVy3euPF2S1v2mM17n4r45qbvhIwoyu2sO0lg=;
 b=So3Np9xMdBkgDxjjbnUoHZpwBe+vfIlg19t4URAstWJV58974s2aTL6UzpO++lEyXM
 +Jk2/LJ6R9ghFaQRviFrFya2yn2iJdmt2Cs/VlaxVsaVgj90mtYZ5OeUl6ceCfkDXGPi
 BiPPoU5yk1PECSK1Zr8ZpqL6OBochN3K7KMSIUppk1LkT5f+ytmAeZMgZfabFjYtMeZt
 J+5QqqIZphAz5WYMcH256nn3YEZVQR9TacbS9Fu4nKiKNud/NOfe+joH3o4JrMfMc0Qk
 qpIxjbVVZEoATHYk61UVjFI2Vy0U4ysUBJ8YhhT4lDCZ8kKCV3ZEKJjtSOllHmwbiEiR
 AABw==
X-Gm-Message-State: APjAAAUylddaxyhHM2agqqzJ6C1btfCyD2UMFfVtctcvxD7t/5aNWQjF
 U72+VVFrbeKijsPet9miZsP82w==
X-Google-Smtp-Source: APXvYqxfLcyoWlk+N9ZwcNoHVEgUdPMOgPc4D1kCGH4naHVuxtCnDn+PvvqfLpCxH9afeYsk0BniSg==
X-Received: by 2002:a5d:4b41:: with SMTP id w1mr2997397wrs.23.1565342382417;
 Fri, 09 Aug 2019 02:19:42 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id n12sm8239608wrw.25.2019.08.09.02.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2019 02:19:41 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 005341FF8C;
 Fri,  9 Aug 2019 10:19:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  9 Aug 2019 10:19:34 +0100
Message-Id: <20190809091940.1223-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809091940.1223-1-alex.bennee@linaro.org>
References: <20190809091940.1223-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v2 1/7] fpu: move LIT64 helper to
 softfloat-types
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

This simple pasting helper can be used by those who don't need the
entire softfloat api. Move it to the smaller types header.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-types.h | 2 ++
 include/fpu/softfloat.h       | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 2aae6a89b19..7e88152dfc4 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -80,6 +80,8 @@ this code that are retained.
 #ifndef SOFTFLOAT_TYPES_H
 #define SOFTFLOAT_TYPES_H
 
+#define LIT64( a ) a##LL
+
 /* This 'flag' type must be able to hold at least 0 and 1. It should
  * probably be replaced with 'bool' but the uses would need to be audited
  * to check that they weren't accidentally relying on it being a larger type.
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 3ff3fa52245..d9333eb65b8 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -82,8 +82,6 @@ this code that are retained.
 #ifndef SOFTFLOAT_H
 #define SOFTFLOAT_H
 
-#define LIT64( a ) a##LL
-
 /*----------------------------------------------------------------------------
 | Software IEC/IEEE floating-point ordering relations
 *----------------------------------------------------------------------------*/
-- 
2.20.1


