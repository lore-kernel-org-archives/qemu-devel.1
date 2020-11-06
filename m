Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9B4C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 11:30:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88E29206B2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 11:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d9e8ZSf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E29206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kazx4-0004yO-A2
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 06:30:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kazwA-0004Jy-4d
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 06:29:46 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:32823)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kazw8-00005b-CE
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 06:29:45 -0500
Received: by mail-wm1-x341.google.com with SMTP id p19so752807wmg.0
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 03:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sBzZbxOaDzhkED96Ml51ZDDBBbPq+OYnSrAXiAMh9s8=;
 b=d9e8ZSf/AGefJuuJ4O79zTi50Klm9dlLjQJeL89hxcdSYwBm1k+Ol5LGjADDKpYZAV
 lAobDEMY9gnZZHcKEMNRMgjY/bxWDobMT//xt6eAeu5oKUBzcxHh/sWy11EFAu3sjtiw
 CXY+3oQAKBLNSjL4KhN36rgAi2D18yqzFfzZlPE91OWOrtR2EHgItT4pmwgCBx+3wvlT
 NUulEnipjTXP2M8edbW5MuNgtsrNEaTw5m4gwLpLdzbPYvDT2bu3f47wxdKTHSww2fr+
 +0Z4CVMnEvwD5sZBEBwfwFzhCe7Td5UDX8ZdBiXJCRgeQ/R5O21Z8nr1c4X0q6SPxVpr
 w0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sBzZbxOaDzhkED96Ml51ZDDBBbPq+OYnSrAXiAMh9s8=;
 b=dGl2ovz9AkBQEw8eWeO6F9uWHv5rOoVTJP0xuCwh57paeSb9Zpp7HNfNe1lgRHULWm
 MFmJjpGp47TBaq+9ZkzfbC+q7cInL3YILkygyUJAh5VXQdhoJBxYGVAgU7ICfPftGmj+
 zUwkv06ld8o8hNFeB5/gcUsnBNx9dptCdBVFt75Y4OAMGlYskPNTTEVNlfMaWy67TtGu
 kBllLYH64QvMCz7mbRUhxvP/SnfhpJvcYz8ECcyXPK77l6shu1+CzMwO0CBprBfbJXrO
 OHRaykkluUcjWumY3N8M/AGu2KnhGokQEIRgpVGreprWyE4TLVf80OkJZ85vDZ/GWipa
 vVIw==
X-Gm-Message-State: AOAM5300wwFrLK/TvSBl0OqsOvCjkd3ykFDv+CSsOx7hkcRTiqM/NReH
 mzK/73PmDeQCGn75rCbVufWDKIjnuJBJaw==
X-Google-Smtp-Source: ABdhPJxWrkxCRFfga7ylwsyuh8c94BLbuiBI8XVFpfKfrFo/f8JVwa4eYVmhEnBiRptbZMd2ILQ6pg==
X-Received: by 2002:a1c:4302:: with SMTP id q2mr2047297wma.182.1604662182672; 
 Fri, 06 Nov 2020 03:29:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id h128sm2019919wme.38.2020.11.06.03.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 03:29:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] CODING_STYLE.rst: Be less strict about 80 character limit
Date: Fri,  6 Nov 2020 11:29:40 +0000
Message-Id: <20201106112940.31300-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Gan Qixin <ganqixin@huawei.com>, "Chenqun \(kuhn\)" <kuhn.chenqun@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Relax the wording about line lengths a little bit; this goes with the
checkpatch changes to warn at 100 characters rather than 80.

(Compare the Linux kernel commit bdc48fa11e46f8; our coding style is
not theirs, but the rationale is good and applies to us too.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 CODING_STYLE.rst | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/CODING_STYLE.rst b/CODING_STYLE.rst
index 8b13ef0669e..7bf4e39d487 100644
--- a/CODING_STYLE.rst
+++ b/CODING_STYLE.rst
@@ -85,8 +85,13 @@ Line width
 Lines should be 80 characters; try not to make them longer.
 
 Sometimes it is hard to do, especially when dealing with QEMU subsystems
-that use long function or symbol names.  Even in that case, do not make
-lines much longer than 80 characters.
+that use long function or symbol names. If wrapping the line at 80 columns
+is obviously less readable and more awkward, prefer not to wrap it; better
+to have an 85 character line than one which is awkwardly wrapped.
+
+Even in that case, try not to make lines much longer than 80 characters.
+(The checkpatch script will warn at 100 characters, but this is intended
+as a guard against obviously-overlength lines, not a target.)
 
 Rationale:
 
-- 
2.20.1


