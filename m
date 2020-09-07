Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFEEC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 19:53:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B55FE2145D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 19:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxwMNcjh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B55FE2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFND8-0003bi-Rt
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 15:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFNAD-0007Dp-Cb
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 15:50:53 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45464)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFNAB-0006fU-OT
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 15:50:53 -0400
Received: by mail-pf1-x442.google.com with SMTP id k15so9075850pfc.12
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 12:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vW7y4R3ozlAHvAmLjvFb89QIuPrCd9TtTePNKyjjAI8=;
 b=kxwMNcjh8lvQzem/TUJ8HPkq5CHr1NKpny88nCRM0hsWPXFYSBNycoag2wJTJD8AJT
 cz2BC9lDgHdLvH+ftyrvz7Lw26GbHAy8buF4xKIUlR10KKgEkwoa4BjyvEUW593Uw0wp
 kllE/mCnhiAAMkox7qZiE3IaowThocHNrIa6/yimFzkdZJhpsE6i1AsMVUyf25+2cCbb
 IXXXzK+RLTLBr/EiC41CkELzKI5hozDegVCr6ZAO6JUJS/DTlbnxHsmLOKp4sSeC/eSk
 aafvLDUWDU4XsGMd6ACx+JHiXuGvSSEweLX1PkmeJiyflj1pcU1maFZp6nBOk87IPW2j
 pmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vW7y4R3ozlAHvAmLjvFb89QIuPrCd9TtTePNKyjjAI8=;
 b=FQ0z9DzmX0rFKxzqxIYFeMXjj12X+4Oao8ot+VX7yDlFfxPr6vHPVmUaMwhuir/exx
 syTvhiLt6AW3Nj1xSwv4b9CtyBSi53RT3apy3lEbhVYPhLS2+U28UvfKzIk1xF3H+xRz
 Is82LQ/lvGNC/GSBlFXYC+2XLvdQj2QlRWidFT0HNDL1QCJmoFyEWl1Yxw9iAYWoAxp7
 Z7tWJP2yQHZX1Z4Oz8+RpN+zdz4vEKh+rxL55zrYg/aG9iuvvO790XvX9zPyL0wOG73E
 PKpWxqYWzim/LSovWxHmcw5B8Ia907EwRemZP29mRFZqsj06h3TaTiGBPD09ifnzFfkK
 jpPg==
X-Gm-Message-State: AOAM532BIaQmb63RGkKGgytXM/hSSSuCG0WHN9VxLaZeF9fQ8mW04z06
 KHc0Yr+E6zbWSYHcluvypYgdE1hZsg2q/Nw4
X-Google-Smtp-Source: ABdhPJwdHW42MUC8CfCIKaRlhVGTM8yYJUHIxtolaWNwTjPGuVW3eiXxIU9tpI58YHaq7sOz7gkpIg==
X-Received: by 2002:a65:624e:: with SMTP id q14mr18147202pgv.307.1599508250007; 
 Mon, 07 Sep 2020 12:50:50 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id ev19sm4818990pjb.42.2020.09.07.12.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 12:50:49 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/4] vmstate: Enable test-vmstate on all platform:
Date: Tue,  8 Sep 2020 03:50:25 +0800
Message-Id: <20200907195025.2308-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200907195025.2308-1-luoyonggang@gmail.com>
References: <20200907195025.2308-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x442.google.com
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
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/meson.build | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/meson.build b/tests/meson.build
index 7f27a15cee..39fa822be3 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -185,11 +185,9 @@ if have_system
     'test-timed-average': [],
     'test-util-sockets': ['socket-helpers.c'],
     'test-base64': [],
+    'test-vmstate': [migration, io],
     'test-bufferiszero': [],
   }
-  if 'CONFIG_POSIX' in config_host
-    tests += {'test-vmstate': [migration, io]}
-  endif
   if 'CONFIG_INOTIFY1' in config_host
     tests += {'test-util-filemonitor': []}
   endif
-- 
2.28.0.windows.1


