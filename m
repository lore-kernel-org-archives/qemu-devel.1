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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771FEC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:50:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F057207BC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFfugg3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F057207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAaHm-0007IM-FG
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 10:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAaGb-0005iC-LA
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:49:41 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033]:35799)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAaGZ-0008RQ-H3
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:49:41 -0400
Received: by mail-pj1-x1033.google.com with SMTP id g6so1362966pjl.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 07:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=s3dYOgA7GkXXyUyxgB9kFfNBkj2FaL3vO8uRc/sluZg=;
 b=dFfugg3jvpd19ezcWaHDtjTFFFgGqRqfE1hCnT72Al0h9R0SgxnAIeSLezovhE6UFH
 95zfNRGBTI9WC1EWGEnAoyTStPDUth03/PdOpxIcK2uxmBIbaV6AWnxahx+AI+fOXWtf
 a0+paZr3TcfZcXnHs3I+wbFBO46EKZtIpQOlk6Vc82UhO+QRHlBqTf5EtU6UP+xiSpo3
 IxiBWr3mp1P4VJs7V+giOeEWEljI6pUPUJ2l2QZ7SNCM9qd3GYyQuWKSmIcz3qCx8Ph1
 ReJq7sDylwkL6M7hf7Otk78comq0p54N62agWVfhqVVabEM7TsV1dUID92Qw2GFS4faI
 y6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s3dYOgA7GkXXyUyxgB9kFfNBkj2FaL3vO8uRc/sluZg=;
 b=kVZh3M/ag6ASy8Mf3ORwZmZAQBtOXlbZ3xRhxvaob2q/tFOzm5+1Je9NWtaNhNz29d
 lcI8t0sejSuJypfgiwvMtSrk19h0dIvbVReK9SiBoR0Zol1Z3YqlhRJRnxA9K7AJ7kqp
 1oZ1/rkVxtA3p1MfxAcm7qmhsq2i7d2lb7pzhO1yRGhLPQlaKnkwOQVXwdHNHhCQRhLR
 NdV7/pTPlNTqcCs5gSwyaqMs+xiyLJoCccEfCr5yBqTaHYqqsYF6egyfgFGFaE2iEA0K
 RsO9uZSrlRppFqr/CpLW87OzI7yCAdyet7N4XhGY1alnpHToHqaXt+0lpKk21W8sun7E
 Xx9g==
X-Gm-Message-State: AOAM531ofIoAzyZUPpeBfVOnRZXYU9g5/oJ3v1Io9j1hO2/2HWR7c+k3
 drarY1x49xbaPkCvEyI78B3L3TA50YVXPBh5
X-Google-Smtp-Source: ABdhPJyJ2EUcZMaICoz0B1SMqd08XP1sObBzNFw7pYBVvGxg8HxP9rPZdX5DpfNifGQEQuhu2IMLZw==
X-Received: by 2002:a17:90b:3197:: with SMTP id
 hc23mr1904911pjb.60.1598366977597; 
 Tue, 25 Aug 2020 07:49:37 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id s198sm3093188pgc.4.2020.08.25.07.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 07:49:36 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] meson: fixes relpath may fail on win32. On win32,
 os.path.relpath would raise exception when do the following relpath:
 C:/msys64/mingw64/x.exe relative to E:/path/qemu-build would fail. So we try
 catch it for stopping it from raise exception on msys2
Date: Tue, 25 Aug 2020 22:49:17 +0800
Message-Id: <20200825144919.1217-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200825144919.1217-1-luoyonggang@gmail.com>
References: <20200825144919.1217-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1033.google.com
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


