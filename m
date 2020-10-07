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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A95C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 14:57:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DE7E208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 14:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sNDRcSE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE7E208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQAtB-0000Hh-Hx
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 10:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQAp1-0004eD-9O; Wed, 07 Oct 2020 10:53:39 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44102)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQAoy-0006lr-MA; Wed, 07 Oct 2020 10:53:38 -0400
Received: by mail-pl1-x642.google.com with SMTP id h2so1111134pll.11;
 Wed, 07 Oct 2020 07:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h9qB+cYtAljBmE+4oAASbt9KeE0cbCLtFq/3AIskHy0=;
 b=sNDRcSE7EQDiJ87x4F53d0aMYs72KrQahdkhjPq3KA4WWmqL0V6pTGq/JShCR9Yx/t
 IcQ7VpsT3Gm5qrc1DFN+6Z0WQ+rxnZMGK0lvlJu7zmZ+1MwJdNdeEBlxDSDxapAh7h+e
 FFJHuZUrIGMLyXVhXYBnO8WT0VHb35c6ptLd/ZgIBNXZGGdtMlyf6hq97CuTBpOuVRLu
 3TCMXEpahLNxj3/LNmWiIxl3VQKr5zxsa5AatlBbdGQ+0EguhKHBrZ8LLEGZKmelz8LD
 rAKc2k16q3rhV1CFwj90bX0nevXLx74bTgk/iztb+/xQZyQpSyPJoUPIeFOlIcZrq2aC
 13wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h9qB+cYtAljBmE+4oAASbt9KeE0cbCLtFq/3AIskHy0=;
 b=W6ZlN0PJRdLAUbQw1BCimQql/I6dvSXbGcYSwR17lFe2EXaU+XLlW7h/FV1H7NUQFD
 wQknBW/Xoo8p2JddkpzIt5JmxCX1iVeZkVVlAhYQTpZ60fW2LXLOGhnWe5HKHOWgeK0u
 QDfRPo6dKBx9jI96CrttZ7ZVQ8tvztiH+1f53hqJ1mR48INGUEdkn0uTFwf7Vc9sYNei
 Ao+FjpLSXy5mNkxqB7CoDXIACIAGz3lBISZqS+sVsyXU+7/GKUbAAVTFnYUPN0S5q/Ax
 PP5kZn6MhEBUIxoip94pYB07Ay1kgzt9fxMgNHzRE5bApPuodYm8UuIDYvQK1oeKS44N
 WMIw==
X-Gm-Message-State: AOAM5328A+iQA4W51VCKWsxsweRBo0qcgUqEc0hLFbmkypfk3m7CJjqh
 rWt9uTiWnMyeEMCLQVZs/vWOw+Mli+Kc6g==
X-Google-Smtp-Source: ABdhPJwpcmJQpMgAj06aaY9xWEGiRcPxPBo6FLU2aUCX73Rcd9gCiTZrvGH0ir2s8qbHiTc+jkALzw==
X-Received: by 2002:a17:90a:7c03:: with SMTP id
 v3mr3166956pjf.233.1602082411254; 
 Wed, 07 Oct 2020 07:53:31 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id u14sm3301514pfm.80.2020.10.07.07.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 07:53:30 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 2/2] cirrus: msys2/mingw speed is up,
 add excluded target back
Date: Wed,  7 Oct 2020 22:53:00 +0800
Message-Id: <20201007145300.1197-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201007145300.1197-1-luoyonggang@gmail.com>
References: <20201007145300.1197-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x642.google.com
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
index a1145d0366..639f0b51c4 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -124,8 +124,7 @@ windows_msys2_task:
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


