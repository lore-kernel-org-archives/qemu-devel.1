Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F481C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:46:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 524BF2065F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAxygP3K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 524BF2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAUbB-0004q5-A4
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 04:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAUQR-0007NV-IQ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:35:27 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:44876)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAUQP-0000vz-Np
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:35:27 -0400
Received: by mail-pg1-x529.google.com with SMTP id m34so6312140pgl.11
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 01:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xSa+lKrzpAxZpfbmVv/lwbN7oH6G4GxEh8xRVQQ8Z/A=;
 b=LAxygP3KPu5ccm2WqUqL7j9A9bug2PsQCac6/0FabO6ypidONU9c52EFjHB8Zqr0p2
 kfR5SGd73frAIjgzFwx57nC7m480UlAo2i3Nwdac7H0ro++AVjMa/KYqiOa+fGMXOagG
 wzP905EsSyIp4JQFRMU3ctsN9vh5cNW89OCTkHJc/aJs/E61W5Dm+vPgApQAXZSSiXDX
 vsNflBol9z8oIiuFzPsp5jh8/r4es4ur2F4L8N/5TT/7fi2Bxev57bDZC1FIJM4x82Z5
 RkbBPanvWMZDJUHSGc4UQwZ600h4Ay5L3ZbMl9maNZtaMFrujSaSeVszty/+HM5qwrtt
 jaSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xSa+lKrzpAxZpfbmVv/lwbN7oH6G4GxEh8xRVQQ8Z/A=;
 b=hZ8K92qgqQ8ADGLtsHiXnEv6oDpp7nSjFQg26yLg/MXl7Ak+QEc1XPQ7mzYO5ZLFIb
 0/bgKO6ISfhhL5Dnw/6l72Wm1AV+NedatZLYM0uzyfOTXEp21vRJ37im68x/Ph+PX3Ge
 X86loNJSZ8HtIoE3V8AvWQxQlAcvnE11lTyKZ0hafzXQT7etA/lotFsJFWJzBMGeW6OY
 oaLLX6kCUBYjDlxHcWpyhwIo5S01UJlJxDzlQBFyW7zqbWrUXGYMHMGSk3sb2Pwp3R2S
 j2+unyxmEmWpBUHX5Ox/myjhSf/42hRk85PcmI5Eabopn26+5u//B+bSCeDCjUUAtW7N
 7NVQ==
X-Gm-Message-State: AOAM531+tKz38NXjOfA6jfRFIf8OrLBTcl35xblCGa04dj9ve4FZFjRR
 PhUcbdGpONsTNzXRBH+X51/+3j+IECWVVfeK
X-Google-Smtp-Source: ABdhPJxhSpeK580wP94VnW0fXEe22qFKcduMg/NDYvLOJ8xxLIyuMp9hnh8Gaww03RB2UqedK0000w==
X-Received: by 2002:a65:60ce:: with SMTP id r14mr6174044pgv.85.1598344523557; 
 Tue, 25 Aug 2020 01:35:23 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id bn14sm1146683pjb.0.2020.08.25.01.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 01:35:22 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] meson: SIMPLE_PATH_RE should match the full path token.
 Or the $ and : contained in path would not matched. if the path are start
 with C:/ and E:/
Date: Tue, 25 Aug 2020 16:34:56 +0800
Message-Id: <20200825083500.359-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x529.google.com
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

From: Yonggang Luo <luoyonggang@gmail.com>

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


