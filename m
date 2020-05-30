Return-Path: <SRS0=1N+K=7M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7320EC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 09:25:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AE512074B
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 09:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lz04JjqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE512074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jexkK-0006Cd-Bt
	for qemu-devel@archiver.kernel.org; Sat, 30 May 2020 05:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jexi2-00021f-0z; Sat, 30 May 2020 05:23:18 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37880)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jexi1-00074d-BE; Sat, 30 May 2020 05:23:17 -0400
Received: by mail-wm1-x341.google.com with SMTP id f5so6496785wmh.2;
 Sat, 30 May 2020 02:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RyB5laGZqcuqh7DkQBAguo9SE2App1lOHf/woViMpfs=;
 b=lz04JjqD7Lqv1Vfd9A2mVmwF02navKfjGKq8Rv9ZaWoSoc/BzdZnF3TxOguDWlPZ5E
 G9Lt2d2UvPR0ieKmAYkN4cfXoShCRVpmQW/B2nglXKXv3r4MQFp+9S5QC1PM3v0oxzS1
 69tQTfOv6cOEKtI6qywhjeUr99vnD9t4PUjH0fHGMk4agNyWgtBg420rRz+EpWsv+pk/
 A/j6nbe0Vzr1nE4o+wuvG2kZNQ6QeJFJrmUN6w/iPRGOe5enUKGztqhd3IXhpZDmQNID
 hF7xx0ZLB7aQCDNYm4BbQzV8aAz3EsaaBcolcmYYHlqrMrXe1F2DH0hyhgOklv7SFrdo
 nnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=RyB5laGZqcuqh7DkQBAguo9SE2App1lOHf/woViMpfs=;
 b=RYtYVg6H4hJN7vQ+7udquHUf+j9tDU1ZZrYLvsh0Yq1x5lIYvqE1O9WTq6cU7g2s48
 3c10WLDI76FNx/iQTVSOHn/W7ELMlsbeRCLFB3FUUfl9swLmvK6tDgCp3QvVPiQ3X4Av
 AeYgWOiKxxiwLxEZRRFlcBD0df7GNAMTlpfx8bD7kfADmSYMKYwF9ijPuZFBi5lg57wA
 0XfyrWuHgei6SoTdyhBpqJow+inSm2+3yQB0fk0cJsII3AQEgCIy1NrhKtkNiWHI9Bpy
 A9tuUUtZyBuqku/ciyymC8pL3CJtc5BfAc9e4TCJUy2ub+8eKy3br157bgTDB2wKMUtT
 PwkA==
X-Gm-Message-State: AOAM530fMqWCQSwlduHYXAiWnpdkU2eeoZwEZYABTfFrBwtqtCtJ8IlD
 ERFO+GQj3DYmImcBac7F8ivH683t
X-Google-Smtp-Source: ABdhPJyix5Qby6MEN91R2dhbegH44Eww60AxIjww16Grua/Kj+pdYpSL63TrUSGpzNB3LACyTZhyig==
X-Received: by 2002:a1c:acc8:: with SMTP id
 v191mr13160900wme.154.1590830595534; 
 Sat, 30 May 2020 02:23:15 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id h1sm3195237wme.42.2020.05.30.02.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2020 02:23:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] .travis.yml: Test SH4 QEMU advent calendar image
Date: Sat, 30 May 2020 11:23:06 +0200
Message-Id: <20200530092306.26628-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200530092306.26628-1-f4bug@amsat.org>
References: <20200530092306.26628-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Now that we can select the second serial console in the acceptance tests
(see commit 746f244d9720 "Allow to use other serial consoles than default"),
we can also test the sh4 image from the QEMU advent calendar 2018.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200515164337.4899-1-thuth@redhat.com>
[PMD: Split tests/acceptance/boot_linux_console.py in previous commit]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 564be50a3c..e2003565d8 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -293,7 +293,7 @@ jobs:
     - name: "GCC check-acceptance"
       dist: bionic
       env:
-        - CONFIG="--enable-tools --target-list=aarch64-softmmu,alpha-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
+        - CONFIG="--enable-tools --target-list=aarch64-softmmu,alpha-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,sh4-softmmu,sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
         - TEST_CMD="make check-acceptance"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-acceptance"
       after_script:
-- 
2.21.3


