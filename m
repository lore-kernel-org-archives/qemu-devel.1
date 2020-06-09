Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43BCC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:45:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EDD4207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L2XPNyqf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EDD4207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jibl8-0000iW-OL
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 06:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jibjY-0007HP-6L
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:43:56 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:51474)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jibjX-0005DZ-3H
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:43:55 -0400
Received: by mail-wm1-x32a.google.com with SMTP id u13so2351129wml.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 03:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l8C2CxQk5isX6LgVBcCj8l8vwP2jRtWs9gzBWt30ZL0=;
 b=L2XPNyqf2oO9DHglFSfCvQCs9Mra96UjWRRjHTcrsu4iADUPDR7GwQzy4HhDR0LFV4
 +FfHvM3JT6qQPtvddPt/L2fYRHfcC91c9Uq3VwLBO3qi3Te2vYxLLiFUTkwZw4MU7t5H
 FwzclMaaSTd/kxYYXzp90J3NljU8ITsJxRmUGz41HYK1+/pfIB1ydU4mLjYgaE78qO7b
 uohj57SaWxEeAouYDXVRCdXiQ5OCa+8sCzaYfqPFlFhngtvKq5niMi6mjWU+myhzvWNV
 uZ56sDEOVoa4knpjMJ69vgtlR7tc1IBzQ6gMajACLPpxgNKbLj/7zUvmVSUmIuaHoKR1
 evoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l8C2CxQk5isX6LgVBcCj8l8vwP2jRtWs9gzBWt30ZL0=;
 b=Nosy6OiiHQSDou1Vs7RYUdz9hDBQ0ZW71NV0AEjOBmpBkkLPC5ZJhq3zxr0FGMH0Dv
 Va6VGPs835YpUgGWvzICPOjVgXg4kClAttOJg30zPsG7CQ5wkqQui6v6WSjEstpJqtJp
 hqnNhe+a4wgYQFOU46xfTRQ/vymIfkzX0taMBTqGDr6v58To6TmTDAjX2enrc0PycrUJ
 eHSwN9OyBqGn7HaN3MMCKetMWwR+9G5dDnphof4widx+mcuTT38YQFN3Iy6h6lcT4JWC
 a2ippbKodH4nLA14XWfD6MTCuva6DGzk6OWqk6LNRDW/blTsJ9CBbAdiCWiiQkbIzXIu
 J33g==
X-Gm-Message-State: AOAM531FhQO2Tx6wMDeJYPhOFJ89sjiiGhwWQ/8mOxbXBOvrFxjUq2OI
 ycGN4r6lU0JPhkt/odxdzPEWXA==
X-Google-Smtp-Source: ABdhPJyWogXUYadrmIYlTOVAmOiWCKvLf98ePUb9bk+eYAnEw0fu6gS+pqIh9UFUVKyW5djW+eF1tA==
X-Received: by 2002:a1c:8048:: with SMTP id b69mr3221723wmd.169.1591699433292; 
 Tue, 09 Jun 2020 03:43:53 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u74sm2510677wmu.31.2020.06.09.03.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 03:43:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1485A1FF7E;
 Tue,  9 Jun 2020 11:38:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 13/17] linux-user: detect overflow of MAP_FIXED mmap
Date: Tue,  9 Jun 2020 11:38:05 +0100
Message-Id: <20200609103809.23443-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200609103809.23443-1-alex.bennee@linaro.org>
References: <20200609103809.23443-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Relaxing the restrictions on 64 bit guests leads to the user being
able to attempt to map right at the edge of addressable memory. This
in turn lead to address overflow tripping the assert in page_set_flags
when the end address wrapped around.

Detect the wrap earlier and correctly -ENOMEM the guest (in the
reported case LTP mmap15).

Fixes: 7d8cbbabcb
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reported-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200605154929.26910-15-alex.bennee@linaro.org>

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index caab62909eb..0019447892e 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -467,7 +467,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
          * It can fail only on 64-bit host with 32-bit target.
          * On any other target/host host mmap() handles this error correctly.
          */
-        if (!guest_range_valid(start, len)) {
+        if (end < start || !guest_range_valid(start, len)) {
             errno = ENOMEM;
             goto fail;
         }
-- 
2.20.1


