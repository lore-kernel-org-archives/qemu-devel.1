Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEC4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 04:50:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4780E2078A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 04:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayl8lTK3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4780E2078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB9rm-00046y-DS
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 00:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kB9r3-0002lA-5h
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 00:49:41 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:40556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kB9r1-0003gR-O1
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 00:49:40 -0400
Received: by mail-pf1-x442.google.com with SMTP id k18so2525174pfp.7
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 21:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nHEmWVZQoKiBv31d0b1nWAUGSiNgf5i9gDUSz3OTqd8=;
 b=ayl8lTK3HbdJ2w5DMD+s7vbhyF3kQHWt1OBC459fFYkfQPYtsOiHlWp/hXFOC5j1Uu
 Fr02t7HNRgfk2N/uqDb5M+joMjkIujQcjDpdhrm5qSnU/PJa7b2srjwhTksrE6kpV2y3
 UJdtE9bPL4Vx8D5LlLpQUhAj5rhQp+8kZv/tqBTPpMTngWNwmllzGk8r8deRLM65WxND
 svlvWWEK11i1HCBXEynEjJ8578mC8nbMTMwuoIBzMQhWT9ZZ0JERR12hvzATlW2aJJwM
 o+hYfVgsMF+FCxGYnTrkX7eWKHomMi7NFgDaEvneZFOaHNMnLZDXd87BAa/5sJ/LRQMb
 Ur+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nHEmWVZQoKiBv31d0b1nWAUGSiNgf5i9gDUSz3OTqd8=;
 b=f+VI+LSf7o/c+qO7zNyxTWfU6fsHnpLWG5MKmhmIiCIvxXtFN9kY49ltGthRTDzmEO
 /1R8DZPTrb8guflF3bQmFV8vFxsRmasHIARTVMgNa4BRP03u7aKXY2GLD62T6ZZ1rCY4
 uyXQiM2w2Xrc1nsUAP0A/1QjbB6mSkLN2fbirlXkU0b2aPvJFXA1vX1DodbOttY8SMc7
 3zH//UZH6NlIYHAMakQJJ8aGeobmXuM6T2eLvsRKmBwfWnesCF1GghpquxKTESblogCs
 mJglJF8t392TPTDxsSYwNo/76rRZCBqTPxpGYOBrRPX3bgXT4tWgaMrY+tq6oU5bNk30
 1T0g==
X-Gm-Message-State: AOAM531JsFqWCM0tSPGsF8leZvsjGTs+Gyc7tvvbFXUNhHMnopUxsZeF
 0/tdnS17O135RKwwbGbEU2yuHldtrx4YMNOuJ3I=
X-Google-Smtp-Source: ABdhPJxWICLA5u99WN3jePmnSqiPn33OehnwvNlzu4tur4+OyFe+CR2prFe2L0ugNvlauI12MA9AKg==
X-Received: by 2002:a63:6e01:: with SMTP id j1mr13037528pgc.147.1598503777962; 
 Wed, 26 Aug 2020 21:49:37 -0700 (PDT)
Received: from localhost.localdomain ([2401:c080:1c01:4fe:5400:2ff:fef1:b056])
 by smtp.googlemail.com with ESMTPSA id
 n26sm902296pff.30.2020.08.26.21.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 21:49:37 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH 1/6] meson: Fixes the ninjatool issue that E$$: are generated
 in Makefile.ninja
Date: Thu, 27 Aug 2020 12:49:12 +0800
Message-Id: <20200827044917.1356-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200827044917.1356-1-luoyonggang@gmail.com>
References: <20200827044917.1356-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x442.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

SIMPLE_PATH_RE should match the full path token.
Or the $ and : contained in path would not matched if the path are start with C:/ and E:/

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 scripts/ninjatool.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/ninjatool.py b/scripts/ninjatool.py
index cc77d51aa8..6ca8be6f10 100755
--- a/scripts/ninjatool.py
+++ b/scripts/ninjatool.py
@@ -55,7 +55,7 @@ else:
 
 PATH_RE = r"[^$\s:|]+|\$[$ :]|\$[a-zA-Z0-9_-]+|\$\{[a-zA-Z0-9_.-]+\}"
 
-SIMPLE_PATH_RE = re.compile(r"[^$\s:|]+")
+SIMPLE_PATH_RE = re.compile(r"^[^$\s:|]+$")
 IDENT_RE = re.compile(r"[a-zA-Z0-9_.-]+$")
 STRING_RE = re.compile(r"(" + PATH_RE + r"|[\s:|])(?:\r?\n)?|.")
 TOPLEVEL_RE = re.compile(r"([=:#]|\|\|?|^ +|(?:" + PATH_RE + r")+)\s*|.")
-- 
2.27.0.windows.1


