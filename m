Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75742C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:50:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 389542075F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYM4fsSs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 389542075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAaHc-00075g-EI
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 10:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAaGY-0005fR-3u
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:49:38 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:34525)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAaGW-0008RA-LL
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:49:37 -0400
Received: by mail-pg1-x52c.google.com with SMTP id i10so6992114pgk.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 07:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xSa+lKrzpAxZpfbmVv/lwbN7oH6G4GxEh8xRVQQ8Z/A=;
 b=dYM4fsSsessGgBC6f16hCveN61KGkdQV7yIftTd8Y/DKuUFrxFBzy2ssSEJstyiVTp
 2fCIf++Ehf2HCBOMedMB46er+luEp+A8gAlzpsmCptg1ComReGzZm7e6xgvL39ffGk4R
 /SxsQuNAsqnsQPLjouj+sUhkCjxLH320nDWcSJMHXF7gw+To+kRiQ0ZVdcaWeAqDtHpR
 1yRtP2njssYXfIjhvmDhak+JyEJxnipYzSFM7Nnwq2Mc0ygPe5Ul7cfpKsOH9gTwgc0s
 QTGE4pNN/shijP1QqkhoFZLeqpN/RJOo+2j6uJLqrfH0dmXFgIyGy3+VItsKz4ueXzFa
 T94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xSa+lKrzpAxZpfbmVv/lwbN7oH6G4GxEh8xRVQQ8Z/A=;
 b=DpZjiaTuxnLJlQueft93Ew8jek6zyi8x+UH8zeASPMiAnV16Es1MtgHNJ9qhQgqlLS
 RK9GKX9hVjXDcwNkQivY/0txnmsZPgC4+QhxdPG036GZeMoXeU34D6m+PMBTtzvsewni
 sQdeP003LjnEP57awm845hYqDF4iZQ9SRAWG26eSYJoTHYzlDdKkWig1ecU9AsjYno69
 1ieUErek6AGckFF5ULT8OdpsfBFGchd2LHRIQj8QvkRc3qhuatPAbXU31XSYRPrU+LEd
 VFW9J59BAHQeGuIB5SKEkg8jE7AnAgNQ9096FEj6ARFXImvi1NYZP78otp+1JVpiTTu8
 QZCQ==
X-Gm-Message-State: AOAM531cRO3N6MIUkHw6AgAjyNOfkJecICdwIMphtDJGGom67Y1PTMnp
 BNrOOwkiD50Zh4UM6wvQuJuDjKSTxRyc/7yg
X-Google-Smtp-Source: ABdhPJyCrbgCZdBHPGMjIJSF2LNOR43TdtRnspTFZMNZjwBQyO2MKXhMKYceluBtdLoAJfN83gaiBQ==
X-Received: by 2002:aa7:8285:: with SMTP id s5mr8215790pfm.226.1598366974701; 
 Tue, 25 Aug 2020 07:49:34 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id s198sm3093188pgc.4.2020.08.25.07.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 07:49:33 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] meson: Fixes the ninjatool issue that E$$: are generated
 in Makefile.ninja SIMPLE_PATH_RE should match the full path token. Or the $
 and : contained in path would not matched if the path are start with C:/ and
 E:/
Date: Tue, 25 Aug 2020 22:49:16 +0800
Message-Id: <20200825144919.1217-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x52c.google.com
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


