Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D397C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:52:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0917820782
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXZWoOPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0917820782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAaJc-0003iJ-63
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 10:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAaIp-00020I-2F
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:51:59 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:44022)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAaIn-0000ZJ-Ez
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:51:58 -0400
Received: by mail-pf1-x435.google.com with SMTP id y206so7531954pfb.10
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 07:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5EU+iN7Rjwb8vHvybFENyYEoG6wKKZBygxn/P8M+ZLw=;
 b=ZXZWoOPs/nXMQdTiyGtm+ziUpKbig3WJJVSAHTI87ZRUUkvxdIu82pOSCl/+WRbGra
 oDmgn7S4vcf8B36K+zEKmZFYiP7ISxCNAWxlm4UMOZdjojSHAH3h26OcGRVWrFzT0wW2
 6Tva4Lwn+pxrRngE5j5JUaE46Za1wkw5ECVX+Iw1O77YBSsg6XBXrfIYl/RWRWH/lK8y
 ncR9JsjW0heN3nvySo/q+an7z9gs6aO5xYQZJON8sek9+YdduxiWPxV2aObo2Cqua2cT
 RdRKsWawlMcDdQjkkaydj4YcZVSH70iUUA2PQildpovog26olJ0QOfhDAlMLKnCH1Uyr
 1GwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5EU+iN7Rjwb8vHvybFENyYEoG6wKKZBygxn/P8M+ZLw=;
 b=OgUixc8zlIdixeFJEbyn7O2zknDgOnajZgHwY303clkeJGjIY5PGddMMJURLVYH9L2
 xQ3NWXQNzJC70KOzP16rnpuoDD3qdQdS3o4Rb2SQV9sVWm8If1xdKjfl3ljhlI1Hz95B
 DCUoqD2fgBaX/uFMSk6VFHWXCir9Rx6O4G5oK86tNNzi6v0REtADwhQ7Z+mMVoGsDmpU
 gi6S5nSuVa3YR6lRdEohH2+ueyputQWZGYYZ8dr4Rbm+EKeoikoa9ULVHGKTBWG8ddi4
 19DP0pRWtfW6D/UbXo6lvzvUHue4W8Q3JjqFZBZV2Sf+4QKart2DNpXQLANBuwd6TyS+
 4Crg==
X-Gm-Message-State: AOAM532MmGO1D7aioX6XtEPA5Bh3zILg1N56Jg/kiOgnXhBwVTtjWXEH
 1KERHTGbz24Cp6eMDXaA62ENZU3uZlrDT02b
X-Google-Smtp-Source: ABdhPJywd5hanFCEVvpzQYKJFuDjTDmwRPXwqb1CluaJgmQrVEpX414KFgCV13HbDQ/LvvBE4iwAzA==
X-Received: by 2002:a62:808e:: with SMTP id j136mr7751637pfd.99.1598367115753; 
 Tue, 25 Aug 2020 07:51:55 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id m22sm3104383pja.36.2020.08.25.07.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 07:51:55 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] meson: fixes relpath may fail on win32.
Date: Tue, 25 Aug 2020 22:51:31 +0800
Message-Id: <20200825145133.178-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200825145133.178-1-luoyonggang@gmail.com>
References: <20200825145133.178-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x435.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
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


