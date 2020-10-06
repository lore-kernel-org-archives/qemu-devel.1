Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8939EC4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:13:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5D7920663
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="urNh0aSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D7920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPlqg-00088G-Mu
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 08:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPlnM-0003UU-97
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:10:16 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:36836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPlnK-0004FM-JF
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:10:15 -0400
Received: by mail-pg1-x52e.google.com with SMTP id x16so7890923pgj.3
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 05:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9ZjByY0MppOyobXen+0uddzbK8uVuelULUAbb8n9Gk0=;
 b=urNh0aSPHimYCDbh5F40nns7wONq/7IYIack8l1bO+X1G5FlSsXi1/ywEpubiS0bbp
 nXGOnzYrkbX6ybuHKOLkhjSaU8kfq1vuPpJGGpZTAHK3DgKea0+4xYo86FdhdFQT/exX
 aaVrcV4t9g6WeLrIix7vGfI5RXPC7JWUsJ/QAOpi/2igpbJOocAuPp816VLd4AwJ7AgO
 W9vbUWO9iwxVY1tgTSk48DdYOedK1wjZyA08qXzPCPKBuMDFEpKxZTb1h81v51Xs+1nD
 Tg8oNwvwK6R6kHCCo/Re9H97e8x+VEkqiBpWtjVRQc55p5pbzU8uJyRq+224C2rePbJA
 HgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9ZjByY0MppOyobXen+0uddzbK8uVuelULUAbb8n9Gk0=;
 b=sd2ulPTFLezsvycHIDb6GLuRNe2G6IaWMJOt7WXG2XGDeC0UM7MVuJfi9sx/ItWtJg
 djtvKeGoROfyIOW3aDPOXOLFXAEbZ8+D6kkgt3EH+RNhVUq8e/dpx0OiT+uWSlrayPtq
 pgaqz3iSEQ7C0PRTjnsEphparLfZLxnJm9O8Ai/c79eRtGp4J0m6fOQ9AfH6053Fsw3w
 61hvULVwztRkffsV5wWakGOiJJgrjGVEa2E0itGg5eeBsrwJrHcfMDZ7dJ6Rbco22Uxn
 mVPjc6ch47U9yjt7vYp8Af7uj9WAUVURDA/1m6PC6XBJi0W8TG7vePB9E8Ds3jDyxnY2
 Vn3A==
X-Gm-Message-State: AOAM533+eNxpgHjyiMl3UEgdimwZVO6YsNKSYmZwSYHR3cKRVdno1QVr
 v0BI3SGiqNAnb5nYAtMhKaF9xgWKXNdYIA==
X-Google-Smtp-Source: ABdhPJz+zAsFQLJjeVAvi8mKrGy3hNxXDZLy1GKjzQn9OunR1Ye4PN9/CDQMH68EKemOPOANVS1BLg==
X-Received: by 2002:a63:fe03:: with SMTP id p3mr3773610pgh.100.1601986211368; 
 Tue, 06 Oct 2020 05:10:11 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id f4sm2965681pgk.19.2020.10.06.05.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 05:10:10 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 7/7] cirrus: Enable plugin in cirrus for windows
Date: Tue,  6 Oct 2020 20:09:00 +0800
Message-Id: <20201006120900.1579-8-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201006120900.1579-1-luoyonggang@gmail.com>
References: <20201006120900.1579-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x52e.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 .cirrus.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index 86ea33926a..5363142373 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -104,7 +104,8 @@ windows_msys2_task:
     - C:\tools\msys64\usr\bin\bash.exe -lc "mkdir build"
     - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && ../configure
       --python=python3 --ninja=ninja
-      --target-list-exclude=i386-softmmu,arm-softmmu,ppc-softmmu,mips-softmmu"
+      --target-list-exclude=i386-softmmu,arm-softmmu,ppc-softmmu,mips-softmmu
+      --enable-plugins"
     - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make -j$NUMBER_OF_PROCESSORS"
   test_script:
     - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make V=1 check"
-- 
2.28.0.windows.1


