Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA79C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:51:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A18420658
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fqr90YWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A18420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFje8-0001tx-6h
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 15:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFjc9-0005oi-Q5; Tue, 08 Sep 2020 15:49:13 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:39405)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFjc7-0002X3-VU; Tue, 08 Sep 2020 15:49:13 -0400
Received: by mail-pj1-x1041.google.com with SMTP id s2so133676pjr.4;
 Tue, 08 Sep 2020 12:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ptTGH2qI85N+szgczRA8YGLjVKH01noRoeLoG/lJ5SE=;
 b=Fqr90YWf/CRBl329DxcVSxjwNJrNyNX2p7JYpWNGmFNKIzGbTeJlQCnJNRQZUEbUNf
 rf9J55AI4T8qLTgILwEPBeVGRJkmoLGJIbNIKz4tIqYzjE62nFwVetF8jA3wSlOLUhr2
 0rd35ABpFXGmh5xY+BF2flsM0UV+qSRJt4we3pmqbOQj2y8Ywv4rLgyh9NwO0jUsovF4
 x+AYUA3DQUcX6qIJUF5FFRuy4MAQps4LJ0T+qXFLIEBF/k+ccfbYovBzxSaRhy0xa/h5
 wH+tD3us4QCnguqZ8J5NJwSUJ6AsLDh2slqvqioaGVEwPmEPUKyTexLuLv7m9V/O8v1I
 B60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ptTGH2qI85N+szgczRA8YGLjVKH01noRoeLoG/lJ5SE=;
 b=T/vch4fRf4gu9ae81PEofIVBL2szCYyWQIylx7HGcX99CKLt4xsm6c+vUcNeUklxHR
 f46AhqbYindoYB8vJl79zNc7p7gSoJye2TEL40YVtjxgO+tNFS+6C0kUNYO13voTDC5T
 WwYaNgJEgc3q6FoSJHywYFNm6WJCoFkTJElze6Kxxagcfuqz18j4OUjyWC/O6u8DRIKf
 l7I6/KZaD+2STKtHwAuyZULe7IzGaHOxLB3wr3bL336rE5dy8R9hDE2J/nTbKiuf7c7p
 hTptIRmQmTfwVqZ+0EGQm/ZzsWVrxwf7lW67P709sP53cFqP3O/vn3I+dHGIbR716vs7
 6Ncw==
X-Gm-Message-State: AOAM5324B7vCK+9f7dAJsk4TIs5xkX12LLuI9vGfjWTT9bIrhuYYnYfh
 I4qdh85QwevhcDsAUaGjiL9Ogh3wGO5+WvPZ
X-Google-Smtp-Source: ABdhPJz+TEu6zL1phhnqip2QfWORUbltlcV0twxCNmxAHLDIVg0YPrAuYK6yKTXOvhkkVXXtJynk4w==
X-Received: by 2002:a17:90b:1050:: with SMTP id
 gq16mr410499pjb.234.1599594550024; 
 Tue, 08 Sep 2020 12:49:10 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id n127sm216922pfn.155.2020.09.08.12.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 12:49:09 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/16] block: get file-win32.c handle locking option
 consistence with file-posix.c
Date: Wed,  9 Sep 2020 03:48:12 +0800
Message-Id: <20200908194820.702-9-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200908194820.702-1-luoyonggang@gmail.com>
References: <20200908194820.702-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1041.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Lieven <pl@kamp.de>
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


