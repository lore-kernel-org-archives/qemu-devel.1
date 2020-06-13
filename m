Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04335C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 13:07:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2FC320739
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 13:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYjg5tDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2FC320739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jk5sN-0006zH-0h
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 09:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jk5rm-0006Yz-Nr
 for qemu-devel@nongnu.org; Sat, 13 Jun 2020 09:06:34 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:38197)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jk5rl-00054G-2i
 for qemu-devel@nongnu.org; Sat, 13 Jun 2020 09:06:34 -0400
Received: by mail-wm1-x336.google.com with SMTP id f185so10418682wmf.3
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2020 06:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UxymZrFuiABFSy74WKjgHF4mxbBkme4bRDdyk44DbUc=;
 b=PYjg5tDyf1xYNKdKPDydL5Hqi1Ck1Nqxiht1nfol2d09WLZjfhMDpAsfcPi39pVuQ1
 uHf93KDWaps3VMY+I9/vLUKaYqQPysvReCvPCXIkwd3KqIlg78qykyBrnYOnzWgQGti+
 /6uP5/OqwhPAJgoZf8TLq/ofoZn+vaBDPbUBHoIgPVCAWQU8k1w/4THfsh2mqSGZuDoI
 m6SUgmAtC7KrK1lnht5/DtGLHoLQ2xVt9JAlDzGoNyqrwftd1F6GSqqQ4P2Pa59FVIft
 ZOIIBwm4+IoD1wAqcrWDU3tPVoiLn5YfvHkuPbgoD8IgCAocHqK2IazUwBo2eBfGy9lv
 vWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=UxymZrFuiABFSy74WKjgHF4mxbBkme4bRDdyk44DbUc=;
 b=BplTKQGj/b1qig1GRWtjS82VhHlRPLdevCqNRTp7HRhxJFNh7KY+VAdr1jFFQEFnJm
 ea3BvAI8/yuq1wJo7cHSmQwSJbq7EMeM1PpUWSJvhzXHbibdGnSzWllCqbgnWHweNWC3
 UU9g1cEct12EVJ+AyHWpNGdSMUcjAZiuGGXj95m2GcIRue2mDCk9yv0Y/avjVQIAIP0W
 D++gF4QkOeMI7XNraRjcfE85IxbBTnHUu5zGs+eN782yOUnYPx2DAJ121qKDJt/qb01J
 a55Mvecm/oVJgNWtzb35fNwGgtXjkTiKpnmXvkLuz4qxv2qt1+wZGISgTXksOILUKRQ9
 Z1sQ==
X-Gm-Message-State: AOAM5317eqq3wb8AAeMG8EwmZ8VTPDQwCc3IbiQ3iNxipM9QEMZ8cIpL
 p57SH+z+g3RGE/dQXjml5GeQkJOm
X-Google-Smtp-Source: ABdhPJwtYtiPeSqbKj7hhx5p1/PpAZJiJcoq8LaUUuTz9b2hHbW+dMRtqzf7CZ26RCVbapLJvV6TWw==
X-Received: by 2002:a1c:7d4c:: with SMTP id y73mr3833829wmc.188.1592053585471; 
 Sat, 13 Jun 2020 06:06:25 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id b18sm14353454wrn.88.2020.06.13.06.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jun 2020 06:06:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] .travis.yml: Use travis_retry() in case of network issues
Date: Sat, 13 Jun 2020 15:06:21 +0200
Message-Id: <20200613130622.20541-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x336.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use travis_retry() when cloning SLOF (see 31c8cc4f94e) in the
s390x container job, to avoid build failures:

  $ ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
  Submodule 'roms/SLOF' (https://git.qemu.org/git/SLOF.git) registered for path 'roms/SLOF'
  Cloning into '/home/travis/build/user/qemu/roms/SLOF'...
  fatal: unable to access 'https://git.qemu.org/git/SLOF.git/': Could not resolve host: git.qemu.org
  fatal: clone of 'https://git.qemu.org/git/SLOF.git' into submodule path '/home/travis/build/user/qemu/roms/SLOF' failed
  Failed to clone 'roms/SLOF'. Retry scheduled
  Cloning into '/home/travis/build/user/qemu/roms/SLOF'...
  fatal: unable to access 'https://git.qemu.org/git/SLOF.git/': Could not resolve host: git.qemu.org
  fatal: clone of 'https://git.qemu.org/git/SLOF.git' into submodule path '/home/travis/build/user/qemu/roms/SLOF' failed
  Failed to clone 'roms/SLOF' a second time, aborting
  The command "( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )" exited with 1.

Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index ec6367af1f..19a1b55aab 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -496,7 +496,7 @@ jobs:
         - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS},s390x-linux-user"
         - UNRELIABLE=true
       script:
-        - ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
+        - ( cd ${SRC_DIR} ; travis_retry git submodule update --init roms/SLOF )
         - BUILD_RC=0 && make -j${JOBS} || BUILD_RC=$?
         - |
           if [ "$BUILD_RC" -eq 0 ] ; then
-- 
2.21.3


