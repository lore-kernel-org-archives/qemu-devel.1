Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E1BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 04:51:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AB032078A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 04:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0m1ka4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB032078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB9tA-0007KZ-R4
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 00:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kB9r8-0002uj-Di
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 00:49:46 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46108)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kB9r5-0003gk-Qs
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 00:49:46 -0400
Received: by mail-pg1-x544.google.com with SMTP id 31so2446534pgy.13
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 21:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7+MsaJjYLlKc/kuo4dhCFuDpn67NQClb7RmuHL3RlA8=;
 b=C0m1ka4nMOIT8pbURzi32/XLZXhAAVj/llq5s7GnnlYPsVjBuzyUf647/wcrQxfECB
 shePWwDQBmS9T3WJhd3Oq9/vck9BCmcJvp1sTaf01DHOxtpBF0P1IO6jvf0d6bsux1Wz
 J8yCj6YDPQl+fmfH5Xssk7FVqq20ijww/51e7SDGo3I80VD3/DNgmSXk4v8wlhP4WFV/
 RKJKucHsUr96aQRn9GIPjJwZgSt+lZ88nQEAI7cCFi3FD4c7Tnz3C98iWsvhCBpESsDR
 zOgK/ILy4yogUhy5sJPpxSzZ/D/3tLjTUFco4n7bIGkbpL22jzdZXtJR6Yoq5R2kYZYc
 j5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7+MsaJjYLlKc/kuo4dhCFuDpn67NQClb7RmuHL3RlA8=;
 b=GPSvHtbkBDJcN6uN2pvaOSMr1eblAa6s5+dRtmfAxHoqGzhcWsnI1Yuciog6knM394
 czgKzd6oWOklVQ+owWdP6VMSr7gyS6dHWjtiv1xqhW4bedyClwDojE3Pdy2zHwrBzQyL
 S629NtGwF9nAesk3/FftdXQ/5mx7i5CzmHrRFmXrMlq/fu4r1SmaZJF4BPQlCscMABYF
 AGt1l3sZOhZbfV8+tgMDZZmVo0kaUZwxbXVgVHchp9/YD2hzQR5NryR/o2ak5n8FV0jx
 PK8uBA9clX99DU3a9WlxKzicjwL+Q3s0CPf6gOpXdL1Xw0P29gHNfzT5w788wLKqxOUy
 otFQ==
X-Gm-Message-State: AOAM532PKUT76WjOUs6BjwL3X5SeEJ8yNP9hKjqa+m/AzwaNL0mrTjKt
 HiwbbOZXjXjtxG7KuCzwcZduF50wzeNdXb7VZiU=
X-Google-Smtp-Source: ABdhPJygoErTZpcYOEEZIwnw2ndhPQz3lOJ5nJTBI3YErIW/Z5+AEZKvx+BSQtXWbF/NPceT0FmMFw==
X-Received: by 2002:a17:902:bf01:: with SMTP id
 bi1mr14688209plb.118.1598503781986; 
 Wed, 26 Aug 2020 21:49:41 -0700 (PDT)
Received: from localhost.localdomain ([2401:c080:1c01:4fe:5400:2ff:fef1:b056])
 by smtp.googlemail.com with ESMTPSA id
 n26sm902296pff.30.2020.08.26.21.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 21:49:41 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH 2/6] meson: fixes relpath may fail on win32.
Date: Thu, 27 Aug 2020 12:49:13 +0800
Message-Id: <20200827044917.1356-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200827044917.1356-1-luoyonggang@gmail.com>
References: <20200827044917.1356-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x544.google.com
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

On win32, os.path.relpath would raise exception when do the following relpath:
C:/msys64/mingw64/x.exe relative to E:/path/qemu-build would fail.
So we try catch it for stopping it from raise exception on msys2

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 scripts/mtest2make.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
index bdb257bbd9..d7a51bf97e 100644
--- a/scripts/mtest2make.py
+++ b/scripts/mtest2make.py
@@ -53,9 +53,16 @@ i = 0
 for test in json.load(sys.stdin):
     env = ' '.join(('%s=%s' % (shlex.quote(k), shlex.quote(v))
                     for k, v in test['env'].items()))
-    executable = os.path.relpath(test['cmd'][0])
+    executable = test['cmd'][0]
+    try:
+        executable = os.path.relpath(executable)
+    except:
+        pass
     if test['workdir'] is not None:
-        test['cmd'][0] = os.path.relpath(test['cmd'][0], test['workdir'])
+        try:
+            test['cmd'][0] = os.path.relpath(executable, test['workdir'])
+        except:
+            test['cmd'][0] = executable
     else:
         test['cmd'][0] = executable
     cmd = '$(.test.env) %s %s' % (env, ' '.join((shlex.quote(x) for x in test['cmd'])))
-- 
2.27.0.windows.1


