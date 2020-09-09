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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AED9C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 996D921973
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8ZoRTok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996D921973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFwsf-00024L-PF
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 05:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFwhl-0007f9-Ni; Wed, 09 Sep 2020 05:47:53 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:32853)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFwhj-0007nj-US; Wed, 09 Sep 2020 05:47:53 -0400
Received: by mail-pg1-x543.google.com with SMTP id s65so622113pgb.0;
 Wed, 09 Sep 2020 02:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eTowCOmFGkug/aztHy6I04JZoGONhdCbvgRzQeqIV9w=;
 b=K8ZoRToknBhwy0LNMcAhBC1cEnYNfdYq96viBxRBKirtjwmhEzHf+AEr8UKIswdGKx
 KbOahrPAzn3L+TI6sr6uiYNXbTyW1O2PxlrbnJ2WW9DuSivF1XoiW5rA1yfwfrke9bCT
 7eyshGsY5zuTLmC3OiJoNqb0W1tUmHWjGe0D20Vn0M03wIQ9jNx5aiK2dT76IzpxoYQf
 M2H1jVnUYKPEj8LUz4b+9UP8HqAyq7Lhjsw7AT4SigRnyZk3fBs6q91jFDe2SCCZtAWx
 AbYtTOkN/of44gKqts7SwyDYgWkz+Gqb2pjXJhGvScE13iBrHW2KmrmZSgtF2EhupdpM
 5B1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eTowCOmFGkug/aztHy6I04JZoGONhdCbvgRzQeqIV9w=;
 b=jePXxqurQI8jBHgVoTu/sXSY4yVJ+Ru2sd0jjaxW/aWg0u75fCoOpv+cgiNZm7r4bd
 5WF4s6hjood9wwxYAtVj1ZVgyoiwu8Psyozk2nu3/2m/iiVI27aKjgdzS/VZs6sGMWVJ
 negGTySmrvlz+Oqk0gl+TY3Ixm6jZ74vU/3eNaUiLKOAt8e7TVCJQ5xBbqyFWuH1CScX
 Vc+asyCW+0A89GcZ1fMaWMygPNdK7ss1yGsHDAE31ozjGN9XEbYXSJ+TSB3Ij0Q67qZs
 lUpwkqSAfexwpzTQrCjlQ+k3AQkE6n9QZLoPeDD0xoxQ2Lsvo+3RcmiYTV1OhOkwGZNW
 np2A==
X-Gm-Message-State: AOAM533m+uAdA04QqMoS9nuIiH5g3K88Wy86owWzLt2w+ZgqkGCEvzTq
 kZKbjef5M5ENv+TE9midfUb3lRfjyeLOVLle
X-Google-Smtp-Source: ABdhPJz/EmY8mi/fgXvn4htiS42BvHvRaIcGP0iCQSSB7G9thmwCDB9zkaS6qCEoOaFOPLpO3fEg8A==
X-Received: by 2002:a62:7f13:0:b029:13e:d13d:a087 with SMTP id
 a19-20020a627f130000b029013ed13da087mr171278pfd.30.1599644869715; 
 Wed, 09 Sep 2020 02:47:49 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 64sm1708312pgi.90.2020.09.09.02.47.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 02:47:48 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 18/21] tests: fixes aio-win32 about aio_remove_fd_handler,
 get it consistence with aio-posix.c
Date: Wed,  9 Sep 2020 17:46:14 +0800
Message-Id: <20200909094617.1582-19-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200909094617.1582-1-luoyonggang@gmail.com>
References: <20200909094617.1582-1-luoyonggang@gmail.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a fixes for
(C:\work\xemu\qemu\build\tests\test-aio-multithread.exe:19100): GLib-CRITICAL **: 23:03:24.965: g_source_remove_poll: assertion '!SOURCE_DESTROYED (source)' failed
ERROR test-aio-multithread - Bail out! GLib-FATAL-CRITICAL: g_source_remove_poll: assertion '!SOURCE_DESTROYED (source)' failed

(C:\work\xemu\qemu\build\tests\test-bdrv-drain.exe:21036): GLib-CRITICAL **: 23:03:29.861: g_source_remove_poll: assertion '!SOURCE_DESTROYED (source)' failed
ERROR test-bdrv-drain - Bail out! GLib-FATAL-CRITICAL: g_source_remove_poll: assertion '!SOURCE_DESTROYED (source)' failed

And the idea comes from https://patchwork.kernel.org/patch/9975239/

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 util/aio-win32.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/util/aio-win32.c b/util/aio-win32.c
index 953c56ab48..9899546a8a 100644
--- a/util/aio-win32.c
+++ b/util/aio-win32.c
@@ -37,6 +37,15 @@ struct AioHandler {
 
 static void aio_remove_fd_handler(AioContext *ctx, AioHandler *node)
 {
+    /* If the GSource is in the process of being destroyed then
+     * g_source_remove_poll() causes an assertion failure.  Skip
+     * removal in that case, because glib cleans up its state during
+     * destruction anyway.
+     */
+    if (!g_source_is_destroyed(&ctx->source)) {
+        g_source_remove_poll(&ctx->source, &node->pfd);
+    }
+
     /* If aio_poll is in progress, just mark the node as deleted */
     if (qemu_lockcnt_count(&ctx->list_lock)) {
         node->deleted = 1;
@@ -139,8 +148,6 @@ void aio_set_event_notifier(AioContext *ctx,
     /* Are we deleting the fd handler? */
     if (!io_notify) {
         if (node) {
-            g_source_remove_poll(&ctx->source, &node->pfd);
-
             aio_remove_fd_handler(ctx, node);
         }
     } else {
-- 
2.28.0.windows.1


