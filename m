Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18244C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:43:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DB1B20E65
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWKX31BW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB1B20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVwQG-0002Qr-Ai
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 08:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVwMS-0005z4-94; Fri, 23 Oct 2020 08:40:00 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:34779)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVwMQ-0003vs-Dm; Fri, 23 Oct 2020 08:39:59 -0400
Received: by mail-pf1-x430.google.com with SMTP id e10so1158915pfj.1;
 Fri, 23 Oct 2020 05:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=RstTi0nphnzvHj6hCe9hwxEh/zT9yWDpAJkz0RhV7QA=;
 b=JWKX31BWPW25tDV7gZVaFdv6RPeuVFPPzZrmrAEcIniS+DsW7gSvevDqY4O9eOzfFJ
 k3y6KMU72pRKHVtr3GJwS3IRlar7peugeydu5oq7C526+zojdKIdv7Ad+fSNT3vEfM1c
 xLo4d3DD+MZAucgGTIVfx0C1MbRphJydYtx9AB7lqKXb6SpMjv4Cd09o79U2ZsKiFMcF
 cw29S8vFqjA0f/CLHvm8AMe4/4VOHvgrEqaPw0rRnTmThv7CumaDgE42NAb5cQblfZZx
 Kesa2G1hlz6jbJ3Wd4DxliN+O2cvBEC0fa8XwDWxxq9LbXTYiLNxenIQhgbGwVRU49IG
 21JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=RstTi0nphnzvHj6hCe9hwxEh/zT9yWDpAJkz0RhV7QA=;
 b=Ql25bFmCm8T2jKrOlVNaqqL/15+wZ6yNn/iK+B4KPFBsVnePyn5cTd1AJg1rlb1/no
 1BTU8k1+MDW+WNEsAzhECymvN4h1fERJkT0J35Mb0cASzLaud6J0T7A1sSz3azaJNV6E
 hSlEdB1s8/eB4gQuh1JRGWG99lgXMu/ekSJ6m/LkkhQ8GpkO09mxZQ2taou3fudOHe5g
 OQcOkzc8MDCuRQxeYLZbzv1Xh6rR72GFI6oboyEG/Nm/7iBPkc/P521MU4P8c8d1sMlc
 wDwMO/Rpbvykb4TFHo7EZo8yW3zHisI7r0Hu7gB4wjE4HJ6fulR/V9Zb7F/cCS+FXeRE
 Cv9A==
X-Gm-Message-State: AOAM5334t0f5zEAFhKmS7EjyvmEK6h9v30MCUr3pbq46vkW7ac2ksndh
 xOJBXS77pmrgvDjOe7oF8iNdQmv/HRyR0QIy
X-Google-Smtp-Source: ABdhPJzul3UZWBDNRyVf373Iv6tX1rinZSFcRITdcASOOJXlDkjtvwPvZIFCFw4hBzYXM8c4DtAXAA==
X-Received: by 2002:a17:90a:a596:: with SMTP id
 b22mr2354058pjq.139.1603456795227; 
 Fri, 23 Oct 2020 05:39:55 -0700 (PDT)
Received: from pulp100.localdomain ([103.199.158.131])
 by smtp.gmail.com with ESMTPSA id n6sm2306073pjo.31.2020.10.23.05.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 05:39:54 -0700 (PDT)
From: Chetan Pant <chetan4windows@gmail.com>
To: qemu-trivial@nongnu.org
Subject: [PATCH 26/30] renesas rx cpus: Fix Lesser GPL version number
Date: Fri, 23 Oct 2020 12:38:40 +0000
Message-Id: <20201023123840.19988-1-chetan4windows@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014134248.14146-1-chetan4windows@gmail.com>
References: <20201014134248.14146-1-chetan4windows@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=chetan4windows@gmail.com; helo=mail-pf1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: qemu-devel@nongnu.org, ysato@users.sourceforge.jp,
 Chetan Pant <chetan4windows@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no "version 2" of the "Lesser" General Public License.
It is either "GPL version 2.0" or "Lesser GPL version 2.1".
This patch replaces all occurrences of "Lesser GPL version 2" with
"Lesser GPL version 2.1" in comment section.

Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
---
 target/rx/insns.decode | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/rx/insns.decode b/target/rx/insns.decode
index 232a61f..ca9334b 100644
--- a/target/rx/insns.decode
+++ b/target/rx/insns.decode
@@ -7,7 +7,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
-- 
2.17.1


