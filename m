Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448C0C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 23:05:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFDF0206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 23:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Guubmxio"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFDF0206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHxXk-0005Lk-2l
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 19:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHxUI-0000t6-IV
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 19:02:18 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:37735)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHxUH-0006a2-0Y
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 19:02:18 -0400
Received: by mail-pj1-x1042.google.com with SMTP id kk9so723785pjb.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 16:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2HG6KEW7qktQOtGssjrwwM3B6qNk6TpaJpF0ge2S31g=;
 b=GuubmxioeUKeJyFqPgyDdkJv9wSbBF78RqD0CeckpM6teJLShkohBPFQGt5IJ9uwwy
 BEYlu+Hgw00vScXE5M5G2fMJseKGbzj1CACG88WuF1gXds+D7KdBHvJp+sIdSFBxo8Bd
 X0tmEAXrvgtJrwWTITI4w1ZrsUvxToaE9djYOGi96lepC1C+7c3xGxqN2/+GghqkC+TF
 qXnByWmKbTmmxwoyoPyG9of+E2Yyee38kqCsMIwDsea2Tf83YXHww/QOsKRcTRxl865e
 HFJr1JqtrYPHyrtcOZvviCfe4gAGSty5+N35cC7mYpZHz3IfZm+dQi2mBm9Im3zwiio1
 t/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2HG6KEW7qktQOtGssjrwwM3B6qNk6TpaJpF0ge2S31g=;
 b=YFIRfRaTUIxa8kKlw4uC7iPqTOxMXr4Yj940gmJ9F2/KEQDYd/bWMq+ksImTdhWbdC
 YPwh564a7NFLskCI31h2vIVKiwm9S9vRJhmeH/JcEXjKebcqIO9NaZ40DDfJcStTkCpr
 v9ss37oJohHiubw/99JJwoMwjxZew24Ga6Z7tEC3vdR3evGy0UAWitLDPnlUMZoinEv9
 XuTTLk2w5OhkrHOzev2uV1TsHYFMy2NeMxK/IUPD+Cb79ud2PVXVwx5kBicENeowUF7f
 y4B1+4TJlyu/BnKscMazhoKdIbJ/e2pv/kV4Oil4fFa6EOfJ0yf4KUjMTqvhzOTCo9HN
 eZ4A==
X-Gm-Message-State: AOAM530dJ4yl2N1CIUQtj96WOzMCh3aK2384V+CcVjr19rwDpFqDXpyT
 MU28YN/tJN18/JYyIeb5r/SJAkKhUloi+Q==
X-Google-Smtp-Source: ABdhPJz2cUE5iu+TTErqNFSzv4Ze07k4KrKSoIJkRcoMBKOOVXCN/8u2yrmsdkHjfHYt8FQkZ1/SsA==
X-Received: by 2002:a17:90a:e02:: with SMTP id v2mr1440479pje.6.1600124535400; 
 Mon, 14 Sep 2020 16:02:15 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id l23sm9106076pgt.16.2020.09.14.16.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 16:02:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/10] capstone: Update to upstream "next" branch
Date: Mon, 14 Sep 2020 16:02:02 -0700
Message-Id: <20200914230210.2185860-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200914230210.2185860-1-richard.henderson@linaro.org>
References: <20200914230210.2185860-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: luoyonggang@gmail.com, alex.bennee@linaro.org, thuth@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This branch contains a number of improvements over master,
including making all of the disassembler data constant.

We are skipping past the 4.0 branchpoint, which changed
the location of the includes within the source directory.

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 capstone    | 2 +-
 meson.build | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/capstone b/capstone
index 22ead3e0bf..f8b1b83301 160000
--- a/capstone
+++ b/capstone
@@ -1 +1 @@
-Subproject commit 22ead3e0bfdb87516656453336160e0a37b066bf
+Subproject commit f8b1b833015a4ae47110ed068e0deb7106ced66d
diff --git a/meson.build b/meson.build
index df7d2eb52f..cbb8257d6b 100644
--- a/meson.build
+++ b/meson.build
@@ -681,6 +681,7 @@ if capstone_opt == 'internal'
       'capstone/arch/X86/X86DisassemblerDecoder.c',
       'capstone/arch/X86/X86ATTInstPrinter.c',
       'capstone/arch/X86/X86IntelInstPrinter.c',
+      'capstone/arch/X86/X86InstPrinterCommon.c',
       'capstone/arch/X86/X86Mapping.c',
       'capstone/arch/X86/X86Module.c'
     )
@@ -705,7 +706,7 @@ if capstone_opt == 'internal'
                                c_args: capstone_cargs,
                                include_directories: 'capstone/include')
   capstone = declare_dependency(link_with: libcapstone,
-                                include_directories: 'capstone/include')
+                                include_directories: 'capstone/include/capstone')
 endif
 config_host_data.set('CONFIG_CAPSTONE', capstone.found())
 
-- 
2.25.1


