Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B9BC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B2A92080A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="db2YfREK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2A92080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ79h-00073K-QE
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 06:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQ76n-0004AM-4C; Wed, 07 Oct 2020 06:55:45 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36964)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQ76l-0002BS-9J; Wed, 07 Oct 2020 06:55:44 -0400
Received: by mail-pg1-x542.google.com with SMTP id h6so1145273pgk.4;
 Wed, 07 Oct 2020 03:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mtOj77giTs+Gv/UGGrOJ+B0ZMX7yR2a8eSFCmsTJe1Y=;
 b=db2YfREKc3Pm6YRfoNiQ03ja+Yq4vuRbUgWHWDYBUdMyoWS0VaTlcKCVGp3XeCcGxz
 LETodHBQP9fMRqBiKA5ItKyTSfqT5pnYLsbw5UL1vDpWjLjqa6Ba8lMppbwjsMOhWyIc
 qowGG3ujWtYcXoCxAwUi5URXb98RLoL1fbpQ8UciU+6t51Rlc0ovbbnuzVzdz9ctJcsl
 DaMEo1Li/g9lcmosvOVKbOLVITsnmGdivjQusxxIoGa8ZVZ5fOwS0BjR22W1mhHH2WHx
 l9sel7H3W4DET5Qaip6qMaRHpiUGI0JFDxvmRntOvX1Vy3TMzbzbZiYzhPppliI+NesA
 JxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mtOj77giTs+Gv/UGGrOJ+B0ZMX7yR2a8eSFCmsTJe1Y=;
 b=ruwW4UDAovnPkckvbUJvQ02PqoSrI/msSkgGFsyAd3lG2xNDvbn0HQxdkjkcdhqY59
 XG6fmPkRZWbVh0+dO3SRYoiX+Tuk1YmiIGsPceR8FNh3Vje5tK9cnymdjow68mx5JZpU
 3cAiTH/iDnR7dTkmtJvCpszUpOS54pyWiDPlKDQRepzlTn/BFiLg3kV0/+uE2jCaxb98
 ByIuhmmys+S2I7oZ7egvr7V95ZLL7W9h5hPCRLznXEETLh6LttP0InLrQInh6lttOgRP
 S5XmR8Xnd7mM0EVYPiUJAx5N+xS8K78xMyQ4mjuDPzzvvTm4NZVN7APyfiKfB/KmCAdz
 v0bQ==
X-Gm-Message-State: AOAM533Z0lXTN3QW6MAtLdE0ssA2WpiSnWJpffQbiNqwnj2kEaPeYHWz
 2+BqqaeRkaksEqLaAHxS3Fn8u2MB+LOj3w==
X-Google-Smtp-Source: ABdhPJwYJMptdeVDgSBJBzVvr8fwBllR+EKHuduoPCzcn9d2Dp834rbqrt5bG3XyEXg0UruV522aGg==
X-Received: by 2002:a62:6044:0:b029:151:1a04:895 with SMTP id
 u65-20020a6260440000b02901511a040895mr2473110pfb.34.1602068140945; 
 Wed, 07 Oct 2020 03:55:40 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id d6sm1947351pjz.12.2020.10.07.03.55.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 03:55:40 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/2] cirrus: msys2/mingw speed is up,
 add excluded target back
Date: Wed,  7 Oct 2020 18:55:18 +0800
Message-Id: <20201007105518.1019-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201007105518.1019-1-luoyonggang@gmail.com>
References: <20201007105518.1019-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x542.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following target are add back:
i386-softmmu,arm-softmmu,ppc-softmmu,mips-softmmu

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 .cirrus.yml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index b58fb63521..fc4b066170 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -116,8 +116,7 @@ windows_msys2_task:
   script:
     - C:\tools\msys64\usr\bin\bash.exe -lc "mkdir build"
     - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && ../configure
-      --python=python3 --ninja=ninja
-      --target-list-exclude=i386-softmmu,arm-softmmu,ppc-softmmu,mips-softmmu"
+      --python=python3 --ninja=ninja"
     - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make -j8"
   test_script:
     - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make V=1 check"
-- 
2.28.0.windows.1


