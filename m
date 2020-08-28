Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629F0C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:27:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2777520838
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uw0tuyls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2777520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBnmB-00083h-Dj
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 19:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1kBnhB-0001oU-Dt; Fri, 28 Aug 2020 19:22:10 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632]:32862)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1kBnh9-0006KA-OA; Fri, 28 Aug 2020 19:22:09 -0400
Received: by mail-ej1-x632.google.com with SMTP id a21so1272154ejp.0;
 Fri, 28 Aug 2020 16:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bg//xUODCPLE5mBh/l+245X3L+l4EDTj7jXGaXaVBqc=;
 b=uw0tuyls5LKFhVy5n4JG2LyLVEUjLDL42NQh39Bb5+ppd2zFUTNb0ZkMCVD4Up+p+t
 5jQNZ641nNA7AOY4CD6cQ58rYfvI8+PzvPOpI+Htd8eShvXGgCFSnfIt+1rWpHbA6b+/
 RVZXcQ18mzOwuyXm3M8D2w7+iVH9ZIzg+i1eMERFIdaQmH3V3M3LmWChcBVzvmiL8atz
 UpqW89i37HpxZ2uzrTUnVgwvQGQXeCHc8MCQ2FtQjXWaKOYQ9vEE/yMVLJBEBDE9i/Fx
 ths/GgDGLileYm8Wzs9qZF1Tru0e589Y0lGD2UD+pj/OjaNkwjbQnavbUbtxbFfd1wW3
 lgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bg//xUODCPLE5mBh/l+245X3L+l4EDTj7jXGaXaVBqc=;
 b=fk/OBIo1NdiuedW7iJa7QTI//jZM3ugevByIGBR6iGL7dSSQZaYRsaWQn84WnDcg5I
 e3S1FQL5ZF1TYj2ebJnvD26vNQaW78GSaKaKZOew3g5XXJTy2ZJ9zoOQfmtczXzoaGnr
 eSdM6KMbaaGfNrVmkglaFwGBvdyDods0BgWox7TH3jJrCLX+Xm7DHZ8fcXrJPMNwQWMV
 nhIXbVALp6mLym/tq3mOwzkkSSVXs1e8hpQXWpb+XJaf15a7N+r/tLo2QxYsNHlW4DGa
 9mGukZk8ei/LY1F4sCp6BjQfen7a1lUWcjXqEWaMqV8vdubzJSE8B2IbAR+K9g+DFR4i
 ykHw==
X-Gm-Message-State: AOAM530RsFc9MQ1YYFIM5VngPj0nOLmdn0dvQq/RSUuHF0ZkQZ2CxEiH
 /tkuHUvKyNQhILIDB292xbZPlZPa010hz+/G
X-Google-Smtp-Source: ABdhPJz0JY0QwFrlT8xSKdN63O92/vBrDdqm9df/ZhHaVUxlLfm254eO+W0Y4tBx26juBYEmOzt+lQ==
X-Received: by 2002:a17:907:9487:: with SMTP id
 dm7mr1184180ejc.114.1598656924782; 
 Fri, 28 Aug 2020 16:22:04 -0700 (PDT)
Received: from localhost.localdomain (109-186-204-55.bb.netvision.net.il.
 [109.186.204.55])
 by smtp.gmail.com with ESMTPSA id j21sm523436eja.109.2020.08.28.16.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 16:22:04 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 5/5] qemu-iotests: Simplify FilePath __init__
Date: Sat, 29 Aug 2020 02:21:52 +0300
Message-Id: <20200828232152.205833-6-nsoffer@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200828232152.205833-1-nsoffer@redhat.com>
References: <20200828232152.205833-1-nsoffer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=nirsof@gmail.com; helo=mail-ej1-x632.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use list comprehension instead of append loop.

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 7a233330c9..cd0abf37e5 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -470,9 +470,8 @@ class FilePath:
 
     """
     def __init__(self, *names, base_dir=test_dir):
-        self.paths = []
-        for name in names:
-            self.paths.append(os.path.join(base_dir, file_pattern(name)))
+        self.paths = [os.path.join(base_dir, file_pattern(name))
+                      for name in names]
 
     def __enter__(self):
         if len(self.paths) == 1:
-- 
2.26.2


