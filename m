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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C71C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:53:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C787E2067C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhgPWbkN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C787E2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFikO-0000xm-NB
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 14:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFih4-0002eb-1I; Tue, 08 Sep 2020 14:50:14 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:40694)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFigy-0002ga-SU; Tue, 08 Sep 2020 14:50:13 -0400
Received: by mail-pg1-x535.google.com with SMTP id j34so188259pgi.7;
 Tue, 08 Sep 2020 11:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ptTGH2qI85N+szgczRA8YGLjVKH01noRoeLoG/lJ5SE=;
 b=EhgPWbkNVems8YLYyE6wr7sF3xArBQOXekof16RmurAfg/8Tf1cIeCmt/8VD9gsfzn
 hofsdtHoodqunACuZc2+2JGv9mkx1AgmLK18zV+xPKmP0gOzkv3x8xLIK8e6ipKKpihl
 3x0izdXJ87iBlKZVgCFfWd7pwpiX/J8lHc3XLUmOT1HQGXlG6T9826Dd5q+4R63Nyg6X
 ppGq1/goPM3KNvJyrUV4pDDjjkAWvqoMDEhJgAR/8KiABIKdDcibu/gwhRbrcI6Goull
 QUHh75lL0o+LLOghC4tAieWjKAJc7MeeNqzNegh1wognn6h7TJFBwkUM7ITtF29XDI7f
 nYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ptTGH2qI85N+szgczRA8YGLjVKH01noRoeLoG/lJ5SE=;
 b=GrbebvKgExntvqxpAq8pykbLN9fHpa3c2ES3+KRoyLBUZ3HYjlFm4AjRItp43kIKgk
 tqgTW6UmmooyFRN3XN1ecpeu6j5bdFGRzpO7pQbzivQ8jkL04JzA1CyT2gsrOVaEALfT
 oeTeaQhExZahjShRYnQil1LBoy43GxR1S4mlXr+Y7KczXSo9vkI7aZ7/0DjO2iM06ULr
 3MSaRW3RSrOrILllZmt57mrqoDCpLmOpBDYeLoAwOoH0RMMrY9FfR1mXVTZMD79yQ673
 mo0NGf5Am9CX2WLunheRhrz4A5lYH55JpWHjvZikS/uUzbUNTMpg2EmMn9I2J8OTFHbE
 iXwA==
X-Gm-Message-State: AOAM533YPocgLgrih3PWQ4vr5pICh/dlT7ynWOGiXI3B9afebvbHfyTA
 iHbFhYeFRuPNnrQuvONKOzns4YeXYP1id+DL
X-Google-Smtp-Source: ABdhPJy0fnPJmIYZlrwQzKWxv3tGj9eNmltm6Epm6cqbri+NIC4Jer4Ny3/j8TTkxOf4OVOTlRXsDA==
X-Received: by 2002:a65:68d6:: with SMTP id k22mr128248pgt.136.1599591006582; 
 Tue, 08 Sep 2020 11:50:06 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 8sm43553pjx.14.2020.09.08.11.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 11:50:05 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/16] block: get file-win32.c handle locking option
 consistence with file-posix.c
Date: Wed,  9 Sep 2020 02:49:10 +0800
Message-Id: <20200908184918.1085-9-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200908184918.1085-1-luoyonggang@gmail.com>
References: <20200908184918.1085-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x535.google.com
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
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>
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


