Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF45AC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 08:19:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 545592080A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 08:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u+7npZBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 545592080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTKxP-0001j8-8l
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 04:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTKvR-0008RA-Vp
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 04:17:21 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:35484)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTKvP-0006G3-Nf
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 04:17:21 -0400
Received: by mail-pf1-x435.google.com with SMTP id k8so1052168pfk.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 01:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=m0vpWTQi7lQcf+oIhIvda/slW9NTohrk35TKxPBDwEI=;
 b=u+7npZBLxsGMiT2qF1qZx4SyyG2nO7QbWx1c8SMCZoQpxdBGvqPQzY+Dz7GVhz7ZUQ
 U6znREGLqtgDJtPAOc8YDUYn0DOGGUlxRBy9B0CMOXC/Ld5K5mjXiSOp5EjcUP0t2LmE
 ks759BP19GYuTOUeLYxuaJxE6Zc6JuCwgJ1ji7TrhUihgfVMZvtB4u0OvDaCgK8vCQfc
 7ZxSRAcmolofjFxKFrgxIGP53cEfzItDLQKoYvNMXURF266pP5TydLML8ECfMKFw8MW+
 V8oWjb0rHY3dJ9MIEKhJdoapxTvCsKtrRE+s2OYA38DsGtHH5stqeNuYM9ThItqgxEFq
 CAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m0vpWTQi7lQcf+oIhIvda/slW9NTohrk35TKxPBDwEI=;
 b=thsq3d7VBB3xeVvHvLDzpggBuFpCgXNAiT/2V3LU+Bj2iaHg2/fYs75aUJ3IJMG6P5
 cpFNgg+kOcKSM2rmabpxARf5lMrS4ABG7FYQiLGiGREV8cjjsKEIgmnI+pNg2nE1zbtV
 Mp1a3oLjoQlao14axn4QC76YJxBiBgoXlFUTKAQPO8swXPQJDYsJ1op1MAGQbEGMx4pr
 WYz1D8UaexgxgyNZxPnPg6+DK1GsBg/QWVM+/9j+PwsXNqPKpEevvuJyYpdPWsK0Kkgj
 l7v0cvrW7cGRy/uCG+M2gwKdO2qzfEvUss2tqBZJ6fTkTtXqpzZ+hPzhKrn4fMqfux4i
 i6Aw==
X-Gm-Message-State: AOAM532Ek3qnVMSwWSVfCFevo+aZH+6ELVb5M7hSxoMbab0H1IWjF7eP
 i0PzA0Eb0mnJcoO2K2Z9qUSe65R0rCAvEoaR
X-Google-Smtp-Source: ABdhPJyi105GNHqDkjrPiNC2Kgrh/RVl/O8wxtAwRxemJU58Y6cPNFe9XISR1gtOxpqgJzJzaR1TkA==
X-Received: by 2002:a63:e65:: with SMTP id 37mr2142418pgo.445.1602836237645;
 Fri, 16 Oct 2020 01:17:17 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id d2sm1940343pjx.4.2020.10.16.01.17.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 01:17:16 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 1/4] docs: Fixes build docs on msys2/mingw
Date: Fri, 16 Oct 2020 16:16:55 +0800
Message-Id: <20201016081658.1890-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201016081658.1890-1-luoyonggang@gmail.com>
References: <20201016081658.1890-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x435.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

meson didn't support running ../scripts/kernel-do directly
Add the perl as the first parameter

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 docs/sphinx/kerneldoc.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/sphinx/kerneldoc.py b/docs/sphinx/kerneldoc.py
index 3e87940206..af130d0939 100644
--- a/docs/sphinx/kerneldoc.py
+++ b/docs/sphinx/kerneldoc.py
@@ -67,7 +67,7 @@ class KernelDocDirective(Directive):
 
     def run(self):
         env = self.state.document.settings.env
-        cmd = [env.config.kerneldoc_bin, '-rst', '-enable-lineno']
+        cmd = ['perl', env.config.kerneldoc_bin, '-rst', '-enable-lineno']
 
         filename = env.config.kerneldoc_srctree + '/' + self.arguments[0]
         export_file_patterns = []
-- 
2.28.0.windows.1


