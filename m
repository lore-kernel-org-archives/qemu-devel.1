Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866B2C07548
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:34:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 226FC20BED
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxG+705s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226FC20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJtx-0002JZ-5g
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGJrU-0006b2-5e; Thu, 10 Sep 2020 06:31:28 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:45217)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGJrS-00034b-Ek; Thu, 10 Sep 2020 06:31:27 -0400
Received: by mail-pg1-x543.google.com with SMTP id 67so3996764pgd.12;
 Thu, 10 Sep 2020 03:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CNPvacxKIPvNAAT6pnf6ItFkwT6w9lX5etFkypi0MqU=;
 b=IxG+705s4HfVJTmkW4Etp8qIToKpzpikRor4KgwE7Z1E7pimX4d9Sx1wDuA3CaegI6
 Lzvb4+zQyTEfF4U8CAt7rbg1RO+scWTdzPlULJ2oul+RQ0MYeyINSPJtny2sQ/SEfb4y
 EJz+ztjRcdGud1lgcVpByyjt5EB8wXCzaA6Q/xXMrFfCKf8RI0FB7+LItwJlmVY+mbQS
 Rh146ClVnDYOlPErmP45zdR1zDYgwKxiQi1ZbO2Bv4wje4fqe62p+0eJkgCtMMgH5BC/
 kNhGxN8fBt1cJ0WBxWzQtqNc3KBW3iWIdWMSgOtyS3cBE4bz69WuAN0c+xeQHSdjOx9Q
 Ek9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CNPvacxKIPvNAAT6pnf6ItFkwT6w9lX5etFkypi0MqU=;
 b=oJGxLrmbn1uRm7dPQWEpnhmspoX0OVgcpnP3vo7M3vTT6a6DsQR03pgrGP0RjaETq2
 90OXWy+bZF0caeFctqX+bbHGIpN2Isc1/QCeBN8ADAQuer3veiNORt13pfbRQXwtxIqS
 DBp0Ewm56Rrzb7B9ysKKD0oiub049uK9iGmE6oHhpy+3LrcKUYAB01Sk/pzqzat0Szff
 QWsEYVdLfbmW2/esuE4cAowLfDSbX+0lLVsfGWXLfyafMX5ZcyoECdjL9u051CBPD2AD
 2ZlPpVcUSRmKVqvAjWxdnhw2/WWTiu6NLDVzanNzoO/M4E4Ulp+P80TPxvrlHznPYQmQ
 6a5A==
X-Gm-Message-State: AOAM532fwi6E9Pjymz6FhpNr0bsCMd5S7EEWfWdvslUAqmUWpT9pCTTd
 zB1sI+B5PwwWnbAyzLtjOsGBe7ma4p5LmijzVzI=
X-Google-Smtp-Source: ABdhPJwhsK7nsQ/7CyqWDCg4diLxwuri3qYmPRT8J2fZthBUFSp8KItvuAIntwkdMPpDmIHXwtIEDQ==
X-Received: by 2002:a63:f546:: with SMTP id e6mr3843785pgk.7.1599733884285;
 Thu, 10 Sep 2020 03:31:24 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id g21sm2000203pfh.30.2020.09.10.03.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 03:31:23 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 01/25] file-win32: Fix "locking" option
Date: Thu, 10 Sep 2020 18:30:35 +0800
Message-Id: <20200910103059.987-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200910103059.987-1-luoyonggang@gmail.com>
References: <20200910103059.987-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>
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


