Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C90C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:21:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E53A6206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6VDRoh2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53A6206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj962-0004HH-69
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 18:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jj8uV-000627-PY; Wed, 10 Jun 2020 18:09:27 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45380)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jj8uU-0008IU-Sh; Wed, 10 Jun 2020 18:09:27 -0400
Received: by mail-wr1-x444.google.com with SMTP id c3so4017611wru.12;
 Wed, 10 Jun 2020 15:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RyB5laGZqcuqh7DkQBAguo9SE2App1lOHf/woViMpfs=;
 b=m6VDRoh24NuIfYk49TALjWMJFVIz2tQJV/MZC9AMKkW3Lwx7p+8BJPboXA+aeFMI+4
 mzlvdOn/HgKF3b1LtJ3V4NjXZeu5xRHLcANfORioMwadU5pC0PvUEiDcbF7ClzOsjmnI
 vD/agkF3oU8fnLPaRqnxz5OZDrGDOm46q0V5WXxnBcOlpc6EqDwhMhrx4tqsCbXcaxs1
 sSN8eUyKyE9msipA1aQTMyHyz6J/0yO+InBYotOx1oLi94BIIalRr5Qhvv4eM0IXaCNc
 Yk78A6wKNTYg/wrDw4X/xrFZGCRvX26qQC+z56s+X/fMPY4zeJDV+uWgYAulm9mQkQ4J
 yM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=RyB5laGZqcuqh7DkQBAguo9SE2App1lOHf/woViMpfs=;
 b=VSyw+KMyfMiLD0ruoZASPD0NfWayLxZOuPat7Kt1RW9ix6R9AIc7pL/fkcSrjinPBC
 RtDpEiYvDoydEud+BLl5ScF91mgmrVZzbwckQVzj8rV53Wpah9n7rFBniam5huJ8sMeK
 tEswCNV5JgFD9CQyaJbOTxYnvublDG+vudq6T4wqVJL83hDwokbYAtD5O+Cw0SH4SkAu
 n7dflXB6uqA+YgEB6fI34rQ9vlkbP6/nxIoeYkL0vz3FTqQtBi9Wsw1aPLE0skDauiDD
 PgwHsbgNr8KgIPT1i5YWKsSThwEHYwfnTVtTaey+t97/laxHdgC7q9GhAWPSbLx1G+tX
 g+Rw==
X-Gm-Message-State: AOAM532koU8ms52B4WhpnMx2n+6KE0mVkjXPW7EA1fxXoy7IBoc3dseZ
 BkVBTJ7qLijHudT2YtbyfrdV/61J
X-Google-Smtp-Source: ABdhPJyhxn4FbSBu0/HOZzfQhjrkx/vXGESZAfcIkGgSlDavlKVPA/ybaDbB5zE+Z+AUrwLzWJxb0w==
X-Received: by 2002:adf:f0c6:: with SMTP id x6mr6381188wro.301.1591826953292; 
 Wed, 10 Jun 2020 15:09:13 -0700 (PDT)
Received: from x1w.redhat.com (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id 40sm1819354wrc.15.2020.06.10.15.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 15:09:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/11] .travis.yml: Test SH4 QEMU advent calendar image
Date: Thu, 11 Jun 2020 00:08:53 +0200
Message-Id: <20200610220853.8558-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200610220853.8558-1-f4bug@amsat.org>
References: <20200610220853.8558-1-f4bug@amsat.org>
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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


