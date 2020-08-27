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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFA9C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 05:07:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A7FE2080C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 05:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwGxgV3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A7FE2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBA7q-0004Tq-N9
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 01:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kBA6x-0002wU-Rn
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 01:06:07 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:34033)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kBA6w-0005eR-CF
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 01:06:07 -0400
Received: by mail-pg1-x536.google.com with SMTP id i10so2505361pgk.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 22:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7+MsaJjYLlKc/kuo4dhCFuDpn67NQClb7RmuHL3RlA8=;
 b=QwGxgV3DwW4Gqh6cTpNyIQNVr1PFP/aqnbfRYl7USE5FcwLjenD5+M8iFkq6Si7dEP
 i8Bi0ARPPVvlkkilAkP2Ydor18D2kgXdsGmhOhSgYfNEVv2MKbuq9thsMRPJTeMZbS6j
 FrK3zB+cpDtvdLKft/VuI/sUWzVvrzT8pGuUlQ8fBsYNF2Vi9t2nSF9SIRUs/39k1vX5
 rdLoHGRz0juAjdY1qmmKymuwQ831oNBWe/Zo6A6HGHGhzTdgQE7HAa+i4ETCEmeWB6jE
 9L8xeDK0XJrTMQnJZioR9aJXUty6kZh47k45sYvlklJtwsZTo+vyWzSU3BvMwJf12KdB
 qjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7+MsaJjYLlKc/kuo4dhCFuDpn67NQClb7RmuHL3RlA8=;
 b=qAmpd3UQfmrgF6lwUfb8krGbcBNLLLKeL96xcawPml2wdPM6hfPd0T4Ilz2YdO10HT
 tBFxY0tebiXFYqorZUrWA7HTODiKUC7V8kNomhe1J428IOqwymCLsRLksQ+iElOl61HN
 ZAd8hfQoinJT1ciQxIp6yUY5rQhwoKaBaH9Jnk5IePUlzZAvTvsWYPO/2N5nJP3/E9iS
 68FCeLT+krCeHHSaKRPilc1qdk16c/5/g64OWuPnUSd+jxT4DZJ/5h85modYiw+uey74
 e47AONyVxXYDNnWyX0i8d0w1oZbzWl9DphhxWk+2H1N7Ae0pCFsujJ1+PxsMOKT3VY4F
 EkhA==
X-Gm-Message-State: AOAM532EJYmgqqATXbhHiGZYjnoT2lEfWz3Q7vveJOPBbLhsR6+z7g0Z
 kObRnp6k84GD8jcI9gsPUvYRoZYc+yp+gDFGCoc=
X-Google-Smtp-Source: ABdhPJwUwogKFyngGRwqRTTqva0L4MpZuRuZ4gZmaJf4YOfBPlEEQgQzDdK4eYS+VXB0aBfEJl/Lbg==
X-Received: by 2002:a63:920e:: with SMTP id o14mr13184291pgd.367.1598504764477; 
 Wed, 26 Aug 2020 22:06:04 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id u3sm724213pjn.29.2020.08.26.22.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 22:06:03 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/6] meson: fixes relpath may fail on win32.
Date: Thu, 27 Aug 2020 13:05:39 +0800
Message-Id: <20200827050543.44-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200827050543.44-1-luoyonggang@gmail.com>
References: <20200827050543.44-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x536.google.com
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
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=E8=8C=85?= <berrange@redhat.com>
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


