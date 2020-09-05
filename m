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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91548C433E2
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 21:14:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 021D220709
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 21:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kg/yrIHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 021D220709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEfVw-0008Ix-V3
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 17:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kEfSi-0005GB-7p; Sat, 05 Sep 2020 17:11:04 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44294)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kEfSg-0006ds-Bf; Sat, 05 Sep 2020 17:11:03 -0400
Received: by mail-pf1-x443.google.com with SMTP id o20so6517745pfp.11;
 Sat, 05 Sep 2020 14:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ptTGH2qI85N+szgczRA8YGLjVKH01noRoeLoG/lJ5SE=;
 b=kg/yrIHTiFToquAiDBch0QwBWI26YxASfDpEbKFWWc2UIBvut6CtutwzzqO74r1pye
 83OMqWfo0CXYn3b0qmc2rH54iwboGbv8+CEa1MAQDdOFvB2uuJ+2NIFVEcHM+FbVMog6
 llio9f7efRNcRO1dWxIb9ouy0pTKjU0nSdOcdEirQvjQgRLmg5XcUXyKIcEfbUL28zTl
 10T+a+Bcd0N2glwXElTvbOYpbvMLfVEq7OoJ5+A5gQn0JJhlGD2keStqGhxSTkGPF/Pp
 0W+uPIpVNzlyaNG2QmVDSoYoy3cbDA/stELngDv9JohX2iwTQg0g08diEBwZbfkEORJY
 RnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ptTGH2qI85N+szgczRA8YGLjVKH01noRoeLoG/lJ5SE=;
 b=BXe6OVTxYMgpppz2PVSaJ1jHd52i+c78jvywFSgyhZSFSdbBEpS03IrJdStWdoDit9
 uH37Nmh9ewr3P5bWpWMiJJBRhJJtuzr2FE9oJw1O3OsW1ZPeS+aXamb0uD/4KshhLozG
 h2rc2nXagTu5eEvpesHAaDmrm19ZVaLXG9lQD9WRp9SFFPM/4OlMWsotBQ3tavdT6rvM
 gZme6J6ODYQgPrwtfmODZDtrF3Bcwub3T0pNi08wH/yQxLUUgQsUMgSEyqDuij/iy8Hj
 OekO2vnnvJnF0xq4ssuNuFEDI2DMLQeZGKY8qJBCae4O//n98QHB+yjHPVKNmbuiuLnk
 TJzg==
X-Gm-Message-State: AOAM531+V7kI2tQYSEpqmuI5PPTYEBSRvDpy9o1gnmuoJrklhIWMaE0Y
 uCk9WshsaChT0Vh/UoLETgXkr+rguNT6ISnU
X-Google-Smtp-Source: ABdhPJxXVtpJAXIWKrV9qpNrCj+JG8vHFr6/bPILqbweNT0/Its1BuXXWjLZRqxRP04+OSAQzAREAQ==
X-Received: by 2002:a62:8806:0:b029:13c:d37c:5e47 with SMTP id
 l6-20020a6288060000b029013cd37c5e47mr12366910pfd.13.1599340259779; 
 Sat, 05 Sep 2020 14:10:59 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id k88sm8576010pjk.19.2020.09.05.14.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2020 14:10:58 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] block: get file-win32.c handle locking option consistence
 with file-posix.c
Date: Sun,  6 Sep 2020 05:10:38 +0800
Message-Id: <20200905211038.904-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200905211038.904-1-luoyonggang@gmail.com>
References: <20200905211038.904-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x443.google.com
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
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Wen Congyang <wencongyang2@huawei.com>
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


