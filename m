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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57723C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 04:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23A692078A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 04:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnYqXqsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A692078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB9tZ-0007jS-EV
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 00:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kB9rM-0003SB-D2
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 00:50:00 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:41134)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kB9rK-0003if-TC
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 00:50:00 -0400
Received: by mail-pf1-x431.google.com with SMTP id t9so2524262pfq.8
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 21:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kZmgaDEBNjpxaFbsHI9krVOWSzauPOV79k08lIpZd10=;
 b=mnYqXqsKTtbQIH6/GS/xi23dYMopeW/QeA0sIyy+n9jIMxPIcAgdtMDb1Ik4JSaeKv
 0KsI1ywEcNzYst2JHICcrBt5tqLyAkzFKD21TDQYx5BPQcY+0HDcle9HszXAiEQtzpC8
 gGPtUeVl9Es7bc44JlhHnCBq3B70TO5Wix8NcSGYrmKT8MpnfUzlkhj7FIrdmaNXIxOJ
 1CmMW1fTIbm6pOZ+0OiLJW+eRTwgvhM2wCiFTw8MuqQexI8T6quSpeRlRMnRYbBZ4PDA
 KiUvFXDs04sj46TR9zP1LuD7cJ76zXrLW61GsVu2/TiGCquiydD1GYnEtgeUw78PgYE3
 gw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kZmgaDEBNjpxaFbsHI9krVOWSzauPOV79k08lIpZd10=;
 b=sudiQBUAeGcZsyJlnwUlzNKRBe6uW75DiI1Ie8EqA8T5PB1KCTUBYGm55l89JO1TYF
 zVw7IEhEp1LembyNqz36jORxjN3qT6KDq475hUPKj6KXayFjvAuEsGDWvqISAuEEHH7X
 6c0iILKuOu1gNh6xohBfFPI9fdo6+1jY4doiO0GrfAoVCQwHPmTxktTNPndZsnWPiOuj
 dy8Xg6Z9LJQplsX/ri49tz5FpQQ6dBe12Sv1J0rwbIv+HhFo+XwDhMpB+bJD3yu5t44P
 OXbq03cDJxAFTLMvJTHcqVZleFHEIlKeCP7HDFHSs8eUEwKBxuArl3jQHaLyatZ2ArSH
 Wyew==
X-Gm-Message-State: AOAM530mg602/qQgLnUQ3sMFN8zvCIj1gdSf1rtzkNNlZYplZwxP3KSX
 iBGc819oz1mzxFYa71WipkSJUgl30AL0SLtBFxU=
X-Google-Smtp-Source: ABdhPJyB7jUpg2txTcOAjfkTu1Uhd106g3LZjOCTGz3xYHrZZhAVdzUlj1GjfLUNLrEEEdQNzpowrQ==
X-Received: by 2002:a17:902:9690:: with SMTP id
 n16mr11900274plp.305.1598503797093; 
 Wed, 26 Aug 2020 21:49:57 -0700 (PDT)
Received: from localhost.localdomain ([2401:c080:1c01:4fe:5400:2ff:fef1:b056])
 by smtp.googlemail.com with ESMTPSA id
 n26sm902296pff.30.2020.08.26.21.49.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 21:49:56 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH 5/6] meson: Fixes ninjatool can not be recognized as script
 under Window/MSYS2
Date: Thu, 27 Aug 2020 12:49:16 +0800
Message-Id: <20200827044917.1356-6-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200827044917.1356-1-luoyonggang@gmail.com>
References: <20200827044917.1356-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x431.google.com
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

use ninja instead ${build_path}/ninjatool

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 3b9e79923d..2ad0c58492 100755
--- a/configure
+++ b/configure
@@ -8222,7 +8222,7 @@ fi
 mv $cross config-meson.cross
 
 rm -rf meson-private meson-info meson-logs
-NINJA="${build_path}/ninjatool" $meson setup \
+NINJA="ninja" $meson setup \
         --prefix "${pre_prefix}$prefix" \
         --libdir "${pre_prefix}$libdir" \
         --libexecdir "${pre_prefix}$libexecdir" \
-- 
2.27.0.windows.1


