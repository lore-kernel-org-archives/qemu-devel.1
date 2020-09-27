Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD31C4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 08:20:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B1452065C
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 08:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qu6OHC7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B1452065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMRv4-0005KD-7i
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 04:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kMRu3-0004U0-1d
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 04:19:27 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:40098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kMRu1-0005LE-Gx
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 04:19:26 -0400
Received: by mail-pl1-x634.google.com with SMTP id bd2so1694817plb.7
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2020 01:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9ZjByY0MppOyobXen+0uddzbK8uVuelULUAbb8n9Gk0=;
 b=qu6OHC7c2ED/mw8bC7edoJvHFYyXFJT7m9MMLDym+mPnzYN9EgIbTyCK/VclVaCg0M
 qFPP+xl0ZlATwtCsBYb8fVa3QPKIQPRzNvtgq9+l70cLoQ3/U9/qBfXYlGl6H14BqH+Z
 al1f3/I0K4Lm1hu0MgO61E7ubAPAl9MjshTHn/hkPodD5STAkHpRqjT2416UYu1jhogF
 UrvrzADdR8ryAEtqrLAYn3geI7QbOvk1YhW6LMPnccqpRBleai7n3CGb0XBnAXKIXwcy
 vgLGKglmqQvk80jiboHXtu2FH93Ig1Nm4kO7jkTeChcXCRui57mfUJlMULt1hYXuDKTk
 xmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9ZjByY0MppOyobXen+0uddzbK8uVuelULUAbb8n9Gk0=;
 b=cKT4STASUZmghfmJHH5GUnacnpM/j5YLuwWwduw8kYINzNzESryRcxfyB0bRtHRlx3
 A64IS7l616bsdI8STzGlshaJbdipom2Z52ELpkIFD7GnoeMKxcumxuhbtv21M5defb4x
 tN5tT+mHP9nTUyQmSX3YfDWOReKA24W4Ldk9uFFdHbJf2yY3+eKT5N08h70GirljdeJn
 FrzBh3xHWUeNVONOZ982lUaiv75MBXaaALRcJ6g12T4ixEV+ZD0+nnNCQ+GpP5prfp2u
 ZuWwqGzxsZmNxA/lpp5xGsTTPDcFs6E3jji6m1qF/m45g2mABf+14Yfe/U7kyPa5zLnP
 y2KQ==
X-Gm-Message-State: AOAM531ao5789g38AiKeaFHjz2u4nnMKacHcT6DG13SMd/KfIf4MvQod
 MNFPj87CW+PsetySnD9TLWpN41jC2s7UmdZ4
X-Google-Smtp-Source: ABdhPJwtEvx0Zg7hcStOf9Cujcegykat0HlskXdyTn5/u4tBl6028kcm8x2K3TWCdMyTs/Y7V1czNw==
X-Received: by 2002:a17:902:7489:b029:d2:439c:4e0e with SMTP id
 h9-20020a1709027489b02900d2439c4e0emr6465168pll.71.1601194763832; 
 Sun, 27 Sep 2020 01:19:23 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id z22sm3317693pjq.2.2020.09.27.01.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2020 01:19:22 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] cirrus: Enable plugin in cirrus for windows
Date: Sun, 27 Sep 2020 16:19:00 +0800
Message-Id: <20200927081901.771-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200927081901.771-1-luoyonggang@gmail.com>
References: <20200927081901.771-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x634.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=E8=8C=85e?= <alex.bennee@linaro.org>,
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


