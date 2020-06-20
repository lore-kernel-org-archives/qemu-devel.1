Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AC6C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:30:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1830A2082F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/9Qq4QQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1830A2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmmwP-000528-DC
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 19:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmmvo-0004EH-Ta
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 19:29:52 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33949)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmmvn-0005Rh-J9
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 19:29:52 -0400
Received: by mail-wr1-x444.google.com with SMTP id v3so5689564wrc.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2020 16:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8OiQzRIpXQoSlFlETl/D8LAJ74Lw4o0LenEUlj77bL0=;
 b=B/9Qq4QQVTOSflnaY4RB4Bg79KKZByGeZ66LEUeSuyqnaPdcQ5ZzRHlP3jwIPdUvS/
 SZYdfyZh54vWBtpefdP0tLUVNPG8g9xKvQLyTlboHneF4JgaG0XZ3e7tRER1QDW7+znl
 aN67m/wT+SWF0jSZAOTH86gIu9AuwkT56+737zlLSW2fMwSVnE9HW8UDCCdW2u1+reGO
 blsOhXu1c/3W8kFgquuVkRvuvegrNyzOWjkJs8OZ5tneUPHHYtq8fj3ccpUDV4kMe3ru
 x0djtWBp/DjivhcyeXEn/EExqIQwnclv6eHZdp3OSwd9C9eeN8oF5foDFd6jxRLJTafI
 uO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=8OiQzRIpXQoSlFlETl/D8LAJ74Lw4o0LenEUlj77bL0=;
 b=rQ5tp7cUa2uHH5q5o2vk1llP05NU6hK8dbym/YudfIFYdVBeF7BER7Hys8ENzZqexQ
 RuscMSUbcp02QPo5bP4tbg34g6oCEACaWo9MzOAgNyMquizuL1K2gEFS83LrJYdv+ICh
 I33R7M91968Xrg5A6/RBSGNKQVvmh1jQ/cFoOP6Zx8ciVr1l/WxinndllLH584otaI2a
 yq2D3QZSzE1SPMdYBRj8WmKgPU7Sau5MmOsLqcgNUr+rFKeEUwkafxfjn5pjjMyp+5DZ
 9J0+IWBWPsDj7IJOob8ouNASyUkHtWb0VajnMw+zH1ONfaN5/1jq8UCRIZNSeYCb7ZaA
 bpLw==
X-Gm-Message-State: AOAM533/td6qec3PhnRVV1ArPrj27l7I1tTph8syUPPazJrUufOKqMO7
 Crw8Ao1o9/OYdSUqzZ7Ny0tBlsVp
X-Google-Smtp-Source: ABdhPJxLaQvwYzlPqAt4wUMMh4pfbD0LquPw5MD67ORvevxk0sh/oGN4vb6FYKIyZRcLkiNCzgPl2A==
X-Received: by 2002:adf:dcd2:: with SMTP id x18mr11062626wrm.258.1592695789786; 
 Sat, 20 Jun 2020 16:29:49 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id x205sm11768998wmx.21.2020.06.20.16.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2020 16:29:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] .travis.yml: Build acceptance tests with -O2 compiler
 optimization
Date: Sun, 21 Jun 2020 01:29:47 +0200
Message-Id: <20200620232947.17895-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we just want the tests to succeed, build them with compiler
optimizations enabled to run the tests faster.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 74158f741b..61b247db9f 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -293,7 +293,7 @@ jobs:
     - name: "GCC check-acceptance"
       dist: bionic
       env:
-        - CONFIG="--enable-tools --target-list=aarch64-softmmu,alpha-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,sh4-softmmu,sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
+        - CONFIG="--extra-cflags=-O2 --enable-tools --target-list=aarch64-softmmu,alpha-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,sh4-softmmu,sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
         - TEST_CMD="make check-acceptance"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-acceptance"
       after_script:
-- 
2.21.3


