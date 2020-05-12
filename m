Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EFBC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 10:44:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61DD3206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 10:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xPqyg1Y/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61DD3206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYSP8-0003QP-FB
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 06:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYSO4-00028V-Dd
 for qemu-devel@nongnu.org; Tue, 12 May 2020 06:43:48 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40130)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYSO3-0001Zv-3v
 for qemu-devel@nongnu.org; Tue, 12 May 2020 06:43:47 -0400
Received: by mail-wm1-x344.google.com with SMTP id u16so22698518wmc.5
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 03:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WSVYZz5m9bdJR5qh6kgTR7m9S6gKqrqojPkoGJzP6qY=;
 b=xPqyg1Y/+f2IO81ET2GErSa4uCjv5sGB1/SK67XuTWRjCTUCTuPEzGa4Hp3cuGaLla
 XTdikU4WNLEF1p5iCVcQmsuH9F+cvoxPRDaYbrc0uzmc8Q1Iwooj64ThMrG5m6tXa3jA
 KYPK4MDQa1TvZC+HI1A7FZFHo9myaK4KxNEdE19p6XtxLztuDvmMEnKeBwX76MI5g2AY
 MyvIAn1IgkWD6RpqVUN8Gbm9rxflNKBKXmIUihzwPaHWxJ06JUQHUwZRyj/zDouSeVaN
 hMDwVhO36Im2QQBk2/IswdRFo3AHDWTeOxZ0VTaw722B2C/1wR0wP+oZXTjP9T24G46u
 vwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WSVYZz5m9bdJR5qh6kgTR7m9S6gKqrqojPkoGJzP6qY=;
 b=aslfR7nv7KGHcG6atZIPhflrqSnumnQ5Vxt5o+a8w2wNk877RP8XOFWHUlw3wVCkg2
 G3oNN23EAHuTZ5Qsga/MBadCAqOwLPFjhmVNgwRbqyoLKXzSMkK3hZl5fK1S1hgIHo/o
 pNt0CnLs8rrrOr4SgG6FKGQxqxEasO7sGD5URJOsNbvbMsYVP44vdzvowrjX+L4JsVIe
 Wq0g4icQAgWxBpYQMFvdCKrlqL41gH9xYMcgGl9k7sfyhUSD8rt328Rv6isaDsFbaBvD
 b00IjhJkdoZ6JM4g768VQ63+eox8+eRZTX8pW6gJP0uQdmfRHUlluQeEXSzIuy2zmkS3
 pdJA==
X-Gm-Message-State: AGi0PuaeOK6bxqygFZ784GWzSNAgcAJpMMM/kJgqmA3NFEliKex47vNq
 0s0Oc1y7bbqBypCNUMWK1hPczw==
X-Google-Smtp-Source: APiQypJH0y5tJFHaiGWWlD7m0xUKc9mk5j1OPeMld3nqq/VlkWds0mYoxwEs6ynhWwZP2895GO7+PQ==
X-Received: by 2002:a1c:b104:: with SMTP id a4mr35564494wmf.24.1589280225029; 
 Tue, 12 May 2020 03:43:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o203sm14559433wme.12.2020.05.12.03.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 03:43:43 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 263531FF7E;
 Tue, 12 May 2020 11:43:43 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/guest-debug: catch hanging guests
Date: Tue, 12 May 2020 11:43:38 +0100
Message-Id: <20200512104338.27365-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If gdb never actually connected with the guest we need to catch that
and clean-up after ourselves.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/guest-debug/run-test.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index d9af9573b9e..71c55690546 100755
--- a/tests/guest-debug/run-test.py
+++ b/tests/guest-debug/run-test.py
@@ -80,4 +80,10 @@ if __name__ == '__main__':
         print("GDB crashed? SKIPPING")
         exit(0)
 
+    try:
+        inferior.wait(2)
+    except subprocess.TimeoutExpired:
+        print("GDB never connected? Killed guest")
+        inferior.kill()
+
     exit(result)
-- 
2.20.1


