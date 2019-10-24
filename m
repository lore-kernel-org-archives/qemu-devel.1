Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA36CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:25:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37B4E2084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bXUZnR+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B4E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNaJB-0006b8-DK
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 06:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNaGY-0002A4-Ce
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNaGX-00046B-B4
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:50 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43127)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNaGX-00045t-55
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:49 -0400
Received: by mail-wr1-x444.google.com with SMTP id c2so20195589wrr.10
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 03:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VVvH7cAnAB8K2nnuUridcFUTxcRBjM1kLOxGGOEimW8=;
 b=bXUZnR+AmGDYeBi6ZXeCStt3ZyDF+ID3WpM/EJ77AGp5BndTNtzk0vRSD8MFGfcI6Q
 lU12v9s00SvgZJFAnrSRcCZ5msxGwukAxj9Op3cHELAN0csAo1/Vz6pBl/NPsbMj3m3o
 fLTZlJFE1k+0PP5hmU4nU3zeGmPASrb4L9UwrYxCJmePu46VKOLmZeQiP4Qb4OZfNE8Q
 mVz7/cZ7MuBPFzeMMSY3ZJhi6rCMEL4tvyjzoVJf+B+PKPSQDD9b6mY8wOp9oozoBPW4
 6w4AMRUrvuC1UCyG/lRklg9qyvbVo/8De5mgEyI4PnmKZOCiI/IWv8WhSafn4LpfZyGo
 1peA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VVvH7cAnAB8K2nnuUridcFUTxcRBjM1kLOxGGOEimW8=;
 b=DSL6uS+mOpjM6WRZTm/fGpe8s6nKTm33AoyMQO8lkfZOTFYeN2B4owbgUbadFcUOBx
 WuWbiEg0WhtGc/OvS13k2QaUJGy+rBReykXwRwgqt6HjfBkYEby6yEIKPyAnlPSyYRKI
 FuZ3TVbE0jPF/qUL46Qsn+z1Bk1gt2rTTNN/cJjJ7d383FvTHkhZJuFyE5XjJMesuPka
 q/8HhAPfEIjqD5+dqn+56tw2NfxoIzvJyhLCubfGGurzPfvDqvBNL3W1rdpYjqQmN8R/
 bUSXhzFnelC58W3pA2emhfbN1KtUB3B3bVL90q8Yr2HQMFqwr0x3bhkV354aJSrKFL0K
 my7w==
X-Gm-Message-State: APjAAAVQdmzG7hYVAiCh7CALA/zlza7cEF9Nxrb4AvFUNwJOkXRkZRBS
 VOsLxdvHdhJKbnTZA6Bb0m4xwA==
X-Google-Smtp-Source: APXvYqyRBaOli1nLnwQTqa87Ah3PnggnBd0F1AGWevMpqMIvnfA3ICCV08EAeLwif4584weKsNHMtw==
X-Received: by 2002:adf:8289:: with SMTP id 9mr3336383wrc.0.1571912567989;
 Thu, 24 Oct 2019 03:22:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c144sm2483799wmd.1.2019.10.24.03.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 03:22:45 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EB9861FF96;
 Thu, 24 Oct 2019 11:22:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 07/17] cirrus.yml: reduce scope of MacOS build
Date: Thu, 24 Oct 2019 11:22:30 +0100
Message-Id: <20191024102240.2778-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024102240.2778-1-alex.bennee@linaro.org>
References: <20191024102240.2778-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, Ed Maste <emaste@freebsd.org>,
 cota@braap.org, stefanha@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, Li-Wen Hsu <lwhsu@freebsd.org>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The MacOS build can time out on Cirrus running to almost an hour.
Reduce the scope to the historical MacOS architectures much the same
way we do on Travis.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .cirrus.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index 8326a3a4b16..4b042c0e12c 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -1,5 +1,6 @@
 env:
   CIRRUS_CLONE_DEPTH: 1
+  MACOS_ARCHES: i386-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,x86_64-softmmu
 
 freebsd_12_task:
   freebsd_instance:
@@ -22,6 +23,6 @@ macos_task:
   install_script:
     - brew install pkg-config python gnu-sed glib pixman make sdl2
   script:
-    - ./configure --python=/usr/local/bin/python3 || { cat config.log; exit 1; }
+    - ./configure --python=/usr/local/bin/python3 --target-list=${MACOS_ARCHES} || { cat config.log; exit 1; }
     - gmake -j$(sysctl -n hw.ncpu)
     - gmake check -j$(sysctl -n hw.ncpu)
-- 
2.20.1


