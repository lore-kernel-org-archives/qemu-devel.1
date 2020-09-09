Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9ECC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:17:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABFC4206A2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rdz3hZ7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABFC4206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG2mZ-0003sY-Pg
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 12:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG2kK-0008VN-AP; Wed, 09 Sep 2020 12:14:56 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:36380)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG2kI-0006UZ-Cs; Wed, 09 Sep 2020 12:14:56 -0400
Received: by mail-pj1-x1043.google.com with SMTP id b17so1596728pji.1;
 Wed, 09 Sep 2020 09:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CNPvacxKIPvNAAT6pnf6ItFkwT6w9lX5etFkypi0MqU=;
 b=Rdz3hZ7AGJZQJQLjS5LuO/wRySzfTjesStvxehhK2KefuRQP1eUW4lHOczrOw0u1ZM
 vGOV/lzWJ95DYEgM5c048MQa+evpTgQ+3nm/rYINoSL+zN93LxZNPc49asvgpL9xNf/b
 l5kUTWMT3ypWTE/aNqXEHkoHfVeaU0M3WbJyO1GYBFpRYAjPQ8pyFjpZ3kjSptNk/r4v
 /yucd/Ue9EgeqjFwtBt5JpNw+DLc2tvWVuZQwFq1qd0V9T5sXi0jXEnDOQq5djKUbUWD
 Wd45OXt5oGJDkOx5KuGUPYCl023BuOLeeEOcxRpSeDHkRUoTl6dNXeNKqyiui4vtkqQ9
 Oyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CNPvacxKIPvNAAT6pnf6ItFkwT6w9lX5etFkypi0MqU=;
 b=Qp3pCFVkufkiIQ00wlPqdVZxy3i+OzMB2dmqVJWOVzOFhplHQYDsN/2n3+3L7tQJBn
 W6YHdmyIFYq7bWFGReQrVKd79JuI/yDpafV8KHZZ8qj3WC5WJ4QG8u0EhERzPs/SYnOL
 akMxNaMufdu/mE5hFuLYFIGO5Zu+BrU4hXpclobKdsC5Q+IMTEO6Cz5cUhcgYh27oweY
 dE+A5Z/zGRoWkgMYijWVUBo5MJ4cxB3Oz4SZBOZ76Xf4r3EdMqyDOVAoW2Sx4MnJCNnc
 QYygZsErQxn9ZJk1/j+UTvp+nWwGzpcnn/7qFh2yag7fgpjM2uZ8MndIwm857MKvgTi7
 f2Rw==
X-Gm-Message-State: AOAM533fbZEaROXjGaWqFvgeZlYBaXDZMGNlQ+McmB6E4I4e3HXilvVf
 MY13DjAvRjPpGl08g7ntESDkem+HGXHM3Db9
X-Google-Smtp-Source: ABdhPJz8QzwVmDU94RXHXuL0tr5ZoCElosvvYfRJJm1MsK3Uaxe+ZYWeF7EyouqFDJ6ucwKA7Z/14g==
X-Received: by 2002:a17:90a:f309:: with SMTP id
 ca9mr1500742pjb.0.1599668091814; 
 Wed, 09 Sep 2020 09:14:51 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id l123sm2506987pgl.24.2020.09.09.09.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 09:14:51 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 01/24] file-win32: Fix "locking" option
Date: Thu, 10 Sep 2020 00:14:21 +0800
Message-Id: <20200909161430.1789-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200909161430.1789-1-luoyonggang@gmail.com>
References: <20200909161430.1789-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1043.google.com
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
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kevin Wolf <kwolf@redhat.com>

The intended behaviour was that locking=off/auto work and have no
effect (to remain compatible with file-posix), whereas locking=on would
return an error. Unfortunately, the code forgot to remove "locking" from
the options QDict, so any attempt to use the option would fail.

Replace the option parsing code for "locking" with something that is
part of the raw_runtime_opts QemuOptsList (so it is properly removed
from the QDict) and looks more like file-posix.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200907092739.9988-1-kwolf@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-win32.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/block/file-win32.c b/block/file-win32.c
index ab69bd811a..e2900c3a51 100644
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
@@ -333,6 +338,7 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
     Error *local_err = NULL;
     const char *filename;
     bool use_aio;
+    OnOffAuto locking;
     int ret;
 
     s->type = FTYPE_FILE;
@@ -343,10 +349,24 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
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


