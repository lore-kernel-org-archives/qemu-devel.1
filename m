Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF68C2D0ED
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:14:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F214C20737
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TcPB++bP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F214C20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHtUy-0003Ov-VL
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 14:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jHtTy-0001ip-9c
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jHtTx-0000ds-0v
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:26 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:44030)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jHtTw-0000Yr-Lt
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:24 -0400
Received: by mail-wr1-x433.google.com with SMTP id m11so6663190wrx.10
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 11:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mknqnLXNdO3bv9jIJ1lrUIcyeKoH8TMNeDvGSd6HYu8=;
 b=TcPB++bPPZIvNvMS0exK3Uls0hzzw7XKDGUkqXGuYcIu0WifnP88RKYRT8dYyIVjd8
 jhKqOD5Uj5LRTy2cwLfni+dzvTfaKk2zcLa1n/GN8j3ZkPzL8CRdmaPCPnbI+UKBsHrx
 YeyimjLRdtGcXUcy6iMlXk35OXJqAOyha/4quV2hzOnNRG1nuYmAUHfFVYnhTYTt1+UT
 Mnu4x+UVlr03hxxuhW4PL0s7IOMdFZ6zw346UlSsN4PdEJPpx7eFhkWUynArYOGR7DkB
 b3Go3GMsNu3zNUboYwvKRSmsfizbQREYmxL4rZH/5bJCLBfZ/imPjT6nSvO7VyY0Wha8
 DoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mknqnLXNdO3bv9jIJ1lrUIcyeKoH8TMNeDvGSd6HYu8=;
 b=s9b8Q8V1fJB8WbHPTh6MlctvZX/jCZiRDBEsdot7gMRO5ED4MKmw0u6BzIEMmwHKLw
 O0BvI3kwda98fo2DTJ3bMfRDL1L4THekvqWtg6+XCSZTHSO7PBuK5PTQjJyI3nhUfVJy
 rE94dAUA/WsVxgHQM5IrjXLyIvo6+zgiIJLJF5Lwxi5vuI11p0783ajTVpdxCIsaF1JV
 ZhLdsNKt2FibQFD3KkDxt7TnzgVQ2gbdthxcYDM6OHVyDQrxISIOfLOMighOi5ddjJe1
 GlL/4zK+53hZhO2Keio25WtqmPZ0lRjOsvRZ6N58j1Co3w9Ysbn154+1Pir1D9NDtnDB
 r9eg==
X-Gm-Message-State: ANhLgQ25kjmZxAikEBM00CqC+2EznntdRiTecLRgOCAGTDwYuFCg/sil
 NBfvvSzCxE6oeSncAQBrbQF4Kw==
X-Google-Smtp-Source: ADFU+vsXYJT0AvkXU0gfE1V3v8Nz76W2W3rRyVfk57qyaaRFuStoiqTfGfGgsud95Tw5Q/43+SxItA==
X-Received: by 2002:adf:9d8a:: with SMTP id p10mr663293wre.190.1585332802957; 
 Fri, 27 Mar 2020 11:13:22 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z203sm9214902wmg.12.2020.03.27.11.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 11:13:21 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5B4011FF87;
 Fri, 27 Mar 2020 18:13:20 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 01/12] qemu/atomic.h: add #ifdef guards for stdatomic.h
Date: Fri, 27 Mar 2020 18:13:09 +0000
Message-Id: <20200327181320.23329-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200327181320.23329-1-alex.bennee@linaro.org>
References: <20200327181320.23329-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Deep inside the FreeBSD netmap headers we end up including stdatomic.h
which clashes with qemu's atomic functions which are modelled along
the C11 standard. To avoid a massive rename lets just ifdef around the
problem.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200326170121.13045-1-alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index f9cd24c8994..ff72db51154 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -208,11 +208,14 @@
 /* Provide shorter names for GCC atomic builtins, return old value */
 #define atomic_fetch_inc(ptr)  __atomic_fetch_add(ptr, 1, __ATOMIC_SEQ_CST)
 #define atomic_fetch_dec(ptr)  __atomic_fetch_sub(ptr, 1, __ATOMIC_SEQ_CST)
+
+#ifndef atomic_fetch_add
 #define atomic_fetch_add(ptr, n) __atomic_fetch_add(ptr, n, __ATOMIC_SEQ_CST)
 #define atomic_fetch_sub(ptr, n) __atomic_fetch_sub(ptr, n, __ATOMIC_SEQ_CST)
 #define atomic_fetch_and(ptr, n) __atomic_fetch_and(ptr, n, __ATOMIC_SEQ_CST)
 #define atomic_fetch_or(ptr, n)  __atomic_fetch_or(ptr, n, __ATOMIC_SEQ_CST)
 #define atomic_fetch_xor(ptr, n) __atomic_fetch_xor(ptr, n, __ATOMIC_SEQ_CST)
+#endif
 
 #define atomic_inc_fetch(ptr)    __atomic_add_fetch(ptr, 1, __ATOMIC_SEQ_CST)
 #define atomic_dec_fetch(ptr)    __atomic_sub_fetch(ptr, 1, __ATOMIC_SEQ_CST)
@@ -392,11 +395,14 @@
 /* Provide shorter names for GCC atomic builtins.  */
 #define atomic_fetch_inc(ptr)  __sync_fetch_and_add(ptr, 1)
 #define atomic_fetch_dec(ptr)  __sync_fetch_and_add(ptr, -1)
+
+#ifndef atomic_fetch_add
 #define atomic_fetch_add(ptr, n) __sync_fetch_and_add(ptr, n)
 #define atomic_fetch_sub(ptr, n) __sync_fetch_and_sub(ptr, n)
 #define atomic_fetch_and(ptr, n) __sync_fetch_and_and(ptr, n)
 #define atomic_fetch_or(ptr, n) __sync_fetch_and_or(ptr, n)
 #define atomic_fetch_xor(ptr, n) __sync_fetch_and_xor(ptr, n)
+#endif
 
 #define atomic_inc_fetch(ptr)  __sync_add_and_fetch(ptr, 1)
 #define atomic_dec_fetch(ptr)  __sync_add_and_fetch(ptr, -1)
-- 
2.20.1


