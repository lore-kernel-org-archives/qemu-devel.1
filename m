Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E7CC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 16:54:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 435A52074D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 16:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qL+3KK6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435A52074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAcDi-0002Jm-FT
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 12:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAcD1-00017Q-PT
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 12:54:07 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:40815)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAcD0-0003fb-6Q
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 12:54:07 -0400
Received: by mail-pg1-x52d.google.com with SMTP id h12so7229681pgm.7
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 09:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5EU+iN7Rjwb8vHvybFENyYEoG6wKKZBygxn/P8M+ZLw=;
 b=qL+3KK6vayAx6K/Q77UmCkwnlV98CpiYY87x4B0bLtt4pUsgn8B29N2MkFYizRYI2w
 f+IYMotUh9O3lpuhEfWWf5xaZz04tjioRkqxyRFM8lBmHrN3Adji0Kr0T/g0AzftdH9S
 uqy4VNhgyZUCI25BZNBXuEgi+t9EPnGKLPGTG4amKSGBVHWpMun2wAspKMeiPnGFH0aq
 IKbFz9zMD6eMdji1lsvhRFQWJDVBCF7OGN7eYNj3QQqeOwrBrVvWJjWVyRSeBGUcfUJg
 IgnaY1pdXjaSvGQf90b72S3xub6TKjU6mCumVa7K4JCo5BRqC7URJLkwn5309iPV0Yg/
 pz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5EU+iN7Rjwb8vHvybFENyYEoG6wKKZBygxn/P8M+ZLw=;
 b=N8gT3unX78ntFXiuNbDJseYlvImLfVXBByUyFk61crE7NCVKzyzuinxQJZpRVlD8Ah
 giNmu1d9YLQP6Za7TkKN7pEb6MtDSS1WD6rfaTlgTGmnde02VH4RW4JrlHf5Wot7BuJc
 FaFLWrXbdPEIXGAvs3Ty3HMmizGh6pk6PZsrPNIou1zgSIFituZsvmMWgXIz/cVo0+bm
 aJavkrnRYL6XDdgpkZLIQXoB8eB7S5Vi+Mvrs9uyS4S/isEP2NkdoXCEKSWC4i1xeg02
 k3DH7y2EtR4S0WVXqw3I8c473Uet+qdp1+C0CZkIGcQnpWWUjZTKeH8GpgVc128Zb4F+
 3dSQ==
X-Gm-Message-State: AOAM5314hmeGtGEYaYLJgw26cIHahjCR7tmy4ZZ/Y+qXpiuOo6Rr+5JL
 bY8S3knz8CYRFCZ1Y+tdh61MT5vnzNXruuACnqk=
X-Google-Smtp-Source: ABdhPJxqwDwpHYF2VPB+TT8sCBC9YW7f4tqBjlFFpNbVkn4HbXTdEjDBQuyr9evHPWBD4ZaCdv8OGw==
X-Received: by 2002:a17:902:d341:: with SMTP id
 l1mr7497165plk.36.1598374444231; 
 Tue, 25 Aug 2020 09:54:04 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id
 193sm15988527pfu.169.2020.08.25.09.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 09:54:03 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] meson: fixes relpath may fail on win32.
Date: Wed, 26 Aug 2020 00:53:39 +0800
Message-Id: <20200825165341.520-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200825165341.520-1-luoyonggang@gmail.com>
References: <20200825165341.520-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x52d.google.com
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


