Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2270EC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:35:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDF7A2077C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yNLrWy6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF7A2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJb0-0005lv-KU
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:35:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iSJZA-0003m3-7T
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iSJZ8-0007El-84
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:35 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55067)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iSJZ8-0007CW-0t
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:34 -0500
Received: by mail-wm1-x344.google.com with SMTP id z26so2935326wmi.4
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 03:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ioxK2kUUvhJn3ibL7fxkhbHvv7iuDuKl2QhEX38aenY=;
 b=yNLrWy6GyCdnmMokFxjBAnPWS6IkMNctG4Pi56lKHsYGCDR27zkhdR3N8/A/Rm2Muv
 qhmE7gdL+hhiZ6zUBf/9NGyli6aVg7pljq3FA9beQ7dVAx6xVXaMSzyigwMjFMoFl1yK
 LzuhT3rsXN95+8ghZJ//pUUll9lbg2MFL4vOG0lMCGeyyLwca6TsEM3EgDtMOhbhjxyV
 b5/mnbLUP3kevd+qEJ56fyckEFk6tH721GNrdsn2aIzqnPf0dfvv48ulQHsXmF8vTHjm
 pOwXqnw42973g2Q6uL6YPLJ/aLzxYkrZaJsrqPdBFWaWgyLnE3lrJF/lylyscVg7X4Ei
 ouBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ioxK2kUUvhJn3ibL7fxkhbHvv7iuDuKl2QhEX38aenY=;
 b=maVl+oZbAy6i9bc9DG+fACqgwYjSUlte2b1o3czhGy9iuLNO3s6aS1gmPV5bAML0Xh
 kcf/gQPMoo39sLEOoimpLgxk7ol2/JqBF+ssVUBcWM0E2ve2LBTBuCh9D/kGz3giCfJN
 srsy7XIP2YZkdj5q0956frDdSK52J99SAaSFijtMaD2/bx18439AaJt55i7ymnGbnUni
 Qy1XTa8nP5klUie6/nKD+1YtpXH3iafDpMyUw6ezjzHseN7wlFtfT97Dr6JjJ25eQpEb
 b4KG3dV/xZtQwJRFiZ0oXlgyJx7cyOxVNqkY0CWpOEVhlkg1/LVOjfCtL70oN4X6bXCI
 +YAA==
X-Gm-Message-State: APjAAAWAUVz3NRPypmzTF6IREmF+tez1lQvoWdd6TXqAvKVgJtMHFZoZ
 aMKQhagF6036k/yRmcSJ6hxjWPx72oxZmA==
X-Google-Smtp-Source: APXvYqxFWa8yPzw6/A87OUTxngcn5VGsstrflzuahcNq28tBvVlVsSBgpw9GZb6OmbKQ7glK2tN+vw==
X-Received: by 2002:a1c:7e0e:: with SMTP id z14mr2199100wmc.52.1573040011787; 
 Wed, 06 Nov 2019 03:33:31 -0800 (PST)
Received: from localhost.localdomain
 (31.red-176-87-122.dynamicip.rima-tde.net. [176.87.122.31])
 by smtp.gmail.com with ESMTPSA id q124sm1776907wme.13.2019.11.06.03.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 03:33:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/12] scripts/qemu-binfmt-conf: Update for sparc64
Date: Wed,  6 Nov 2019 12:33:07 +0100
Message-Id: <20191106113318.10226-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106113318.10226-1-richard.henderson@linaro.org>
References: <20191106113318.10226-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Also note that we were missing the qemu_target_list entry
for plain sparc; fix that at the same time.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20191025113921.9412-2-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 scripts/qemu-binfmt-conf.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index b5a16742a1..9f1580a91c 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -1,8 +1,8 @@
 #!/bin/sh
 # Enable automatic program execution by the kernel.
 
-qemu_target_list="i386 i486 alpha arm armeb sparc32plus ppc ppc64 ppc64le m68k \
-mips mipsel mipsn32 mipsn32el mips64 mips64el \
+qemu_target_list="i386 i486 alpha arm armeb sparc sparc32plus sparc64 \
+ppc ppc64 ppc64le m68k mips mipsel mipsn32 mipsn32el mips64 mips64el \
 sh4 sh4eb s390x aarch64 aarch64_be hppa riscv32 riscv64 xtensa xtensaeb \
 microblaze microblazeel or1k x86_64"
 
@@ -38,6 +38,10 @@ sparc32plus_magic='\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x
 sparc32plus_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
 sparc32plus_family=sparc
 
+sparc64_magic='\x7fELF\x02\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x2b'
+sparc64_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
+sparc64_family=sparc
+
 ppc_magic='\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x14'
 ppc_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
 ppc_family=ppc
-- 
2.17.1


