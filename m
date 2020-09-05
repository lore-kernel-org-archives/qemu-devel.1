Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6ED6C433E2
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 06:32:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51E7220797
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 06:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tm7nYRFx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E7220797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kERkk-0000e8-At
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 02:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kERcU-00077Y-CD; Sat, 05 Sep 2020 02:24:15 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43903)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kERcS-0003Xt-Iv; Sat, 05 Sep 2020 02:24:14 -0400
Received: by mail-pg1-x543.google.com with SMTP id d19so5401705pgl.10;
 Fri, 04 Sep 2020 23:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ptTGH2qI85N+szgczRA8YGLjVKH01noRoeLoG/lJ5SE=;
 b=Tm7nYRFxnPJsDqIyA9OeScujNzxou/2ZoWhYCAGM7dEcXSp6WAk/M0VFrSlWTTWVB6
 JjIHK3M3xmXfHD6tsiRsi4YeBKb+uIkvPAkoSYlpWLr5mgIBgcGvP6G686lACLUv18Fr
 V5yZbRy+bL5Sc0ZQyGKmrXvPCbO0CY7m6X3QI8AoMBMmE49Nbzh0eveMfltlYBkG1gmK
 d4jlWE0o4ClA2ppBN4ioaPw6xMibfl0XMR0w84+rtlhOZkWQPuEAanvpacmS3dw/LmVD
 t4pirq39PXENI7t2ouhOGLlhpY+TmyaSMMWn/62FCL63/nu+FLr1CIWM4jNP4wdIt08c
 6L+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ptTGH2qI85N+szgczRA8YGLjVKH01noRoeLoG/lJ5SE=;
 b=VDLJ156dy/rz72+Xkttppe5wODovy6jWUFygDpbVyPYI7TbncaPdnvnUIenkPOaVBY
 Rx+11cXWA2VBhGwvJ/p+QvBDu4JXFEnstCJQzM4gedh7P8GbYTjXoaj1own13vlRcnis
 WnN63nfguC+WUKz8SvP4j2RmnAfzg68w36gXNb9j7VtxIZ4Q9w9/Z2nJSwI/wY4VYjJP
 /K2Rr+boXufH70QUVtmjAjJLTe2jVX4Vvd0Ep2oRBE9dgjhXadm4RwjKJ78MfgOERTox
 QuHmFEeqIneyx4eOai+9sN1603uHE0KjC+HW1rxqPvnrcFrU47YUyYLSyYSYG6Y/PAdN
 Wi2g==
X-Gm-Message-State: AOAM530rqHK3Qkz03cZLCzR/byIK0+yhoNWOMBeSyiuu2mg6UFe6EhsU
 c0g4yJBvXBNAVWwbu5ThzKEBsGpCXx4RSwoM
X-Google-Smtp-Source: ABdhPJz2IcaSrrolwIbbd0a0f2NPNAGN527a9mYy7zoxiKtNJ6Xjw+Mn1gWkl41DoLHeSSQPKLEpEQ==
X-Received: by 2002:a65:6a0f:: with SMTP id m15mr464718pgu.93.1599287050039;
 Fri, 04 Sep 2020 23:24:10 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id v8sm21436381pju.1.2020.09.04.23.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 23:24:09 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 07/11] block: get file-win32.c handle locking option
 consistence with file-posix.c
Date: Sat,  5 Sep 2020 14:23:29 +0800
Message-Id: <20200905062333.1087-8-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200905062333.1087-1-luoyonggang@gmail.com>
References: <20200905062333.1087-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x543.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Block <qemu-block@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 block/file-win32.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/block/file-win32.c b/block/file-win32.c
index ab69bd811a..14e5f5c3b5 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -299,6 +299,11 @@ static QemuOptsList raw_runtime_opts = {
             .type = QEMU_OPT_STRING,
             .help = "host AIO implementation (threads, native)",
         },
+        {
+            .name = "locking",
+            .type = QEMU_OPT_STRING,
+            .help = "file locking mode (on/off/auto, default: auto)",
+        },
         { /* end of list */ }
     },
 };
@@ -334,6 +339,7 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
     const char *filename;
     bool use_aio;
     int ret;
+    OnOffAuto locking;
 
     s->type = FTYPE_FILE;
 
@@ -342,11 +348,24 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
         ret = -EINVAL;
         goto fail;
     }
-
-    if (qdict_get_try_bool(options, "locking", false)) {
+    locking = qapi_enum_parse(&OnOffAuto_lookup,
+                              qemu_opt_get(opts, "locking"),
+                              ON_OFF_AUTO_AUTO, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret = -EINVAL;
+        goto fail;
+    }
+    switch (locking) {
+    case ON_OFF_AUTO_ON:
         error_setg(errp, "locking=on is not supported on Windows");
         ret = -EINVAL;
         goto fail;
+    case ON_OFF_AUTO_OFF:
+    case ON_OFF_AUTO_AUTO:
+        break;
+    default:
+        g_assert_not_reached();
     }
 
     filename = qemu_opt_get(opts, "filename");
-- 
2.28.0.windows.1


