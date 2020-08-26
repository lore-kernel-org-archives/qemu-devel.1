Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12C6C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:18:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BF8F2078D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDPnH5sV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF8F2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAxCQ-0005VZ-4v
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 11:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAx6s-0007uq-RE
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:13:10 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:46591)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAx6r-0003zt-7M
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:13:10 -0400
Received: by mail-pl1-x635.google.com with SMTP id k13so1034186plk.13
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 08:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kZmgaDEBNjpxaFbsHI9krVOWSzauPOV79k08lIpZd10=;
 b=GDPnH5sV94MI8EJqD4/T2+aIBbV5g+4hzb4yzFy/Z/E1zaFWtbXlq+o//Hwy1cqfIb
 CxcroJi+QFvbXkPfvK3QLDQr7oGV/bVelm987SRP3CvZERTyl3n9FrEDaV8oZYQVJ6CZ
 ykQH0JxOEYzYyyLvkKeYstJqsD+THNmJGltYoEt8dBv6W7R7QNfMrSivLT7jojSbv0kh
 FcznwodFuT57opUTcxdu54LI+lcdk9uG78DHRwZVH+lf1tucH+8tiA9RAsu+Smodccy/
 V39ytlUnbdzSZQkXxI7vqUH87Ucq2zXNf6LEJEBPpkGM6V0siQFhN58PkAuoFetbdb/x
 eGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kZmgaDEBNjpxaFbsHI9krVOWSzauPOV79k08lIpZd10=;
 b=NXRpKG7heA3qIXlZxQC7fS/eqZZ7xXOK1o8nIpn+G+6x2xe8O5aFWjBp3jGiM2sSi1
 EkoXTIf/Oi7T5xwYTKiGwagiBEId96Gy6y2KoxDAQWlKLac8Z8SDRtXQnG2qnK6prMxa
 1xc1vOQPsGdIM6+BThFzYaT2T6IPT5/vvlOiFFFWNO4pM0BObELo2xe0JDywCut1ovmF
 em865a2pdUB8STBsFfFwdXDFnXT092/IcILMZ7jwM5/vUbSr3izoDUxCeGUotMFLUGfM
 jBGsQ3EXCRqh6IsLkckHfggc3sXsYcu6oUTBBtw4sI8D6IYND/LQzSLWnRA4QBrt8ex9
 Y9Ug==
X-Gm-Message-State: AOAM5309JqUPVXbOTqbSx2HTcAQjBhPsAcGdA+m4CyJrok5RMeP5tRcU
 xMa/R9xnKJleeT3OhaPEI6fGXOrw9om17/pb
X-Google-Smtp-Source: ABdhPJyxFMS8rAJP/vb9AlHEpvzrULsThT0SjL+mT4HFo9kSoiBAtcmE/Ngik4IL5EN58gva+ddT1w==
X-Received: by 2002:a17:90b:4b81:: with SMTP id
 lr1mr6705837pjb.71.1598454787394; 
 Wed, 26 Aug 2020 08:13:07 -0700 (PDT)
Received: from localhost.localdomain ([2401:c080:1c01:4fe:5400:2ff:fef1:b056])
 by smtp.googlemail.com with ESMTPSA id
 27sm2423169pgk.89.2020.08.26.08.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 08:13:06 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH v5 5/6] meson: Fixes ninjatool can not be recognized as script
 under Window/MSYS2
Date: Wed, 26 Aug 2020 23:10:05 +0800
Message-Id: <20200826151006.80-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200826151006.80-1-luoyonggang@gmail.com>
References: <20200826151006.80-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x635.google.com
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


