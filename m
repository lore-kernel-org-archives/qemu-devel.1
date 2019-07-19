Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFCFC76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:38:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CC4B2173B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/QYJuDj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC4B2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoT5z-0006DM-PC
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 09:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38107)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hoT4Q-0007CY-6r
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:37:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hoT4P-00089J-9b
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:37:10 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:37383)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hoT4P-00088u-3f; Fri, 19 Jul 2019 09:37:09 -0400
Received: by mail-pg1-x543.google.com with SMTP id i70so3746666pgd.4;
 Fri, 19 Jul 2019 06:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K0d0PCOxvKT348YcfiEgoxDIJrmae1+DAY9ThSTRtEQ=;
 b=r/QYJuDj0YIXBPsXgJuy9Aw3F1BUydqk4wwADtMiGNE6TLNLV4bR8NHkY53ngd2lzy
 vpe+F0EEvnXPlkKGs3kS4d/TUtWD7iX+29/kPzwvVc81MGjeFjgXdh8s8jvx0MWUpPxP
 uo1z+Amb8KNpFgRQ8WtQbb54M5zoW9xkeCOlFCgRkW9L2Eph0YT6MivRfxabuYrLhW0R
 TQXYg47XPgmPmfkyUGegglb44Y1teUmRS1gnv4ukHoRSVwUypWIxad4xTLKG8vyo/bQV
 +/tl3pL17tlRKsZIT0Yc2ORFlSa6Cfq0m42N4T19MWkwXMEfWmjylNdZecjfb94rjkaW
 q7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K0d0PCOxvKT348YcfiEgoxDIJrmae1+DAY9ThSTRtEQ=;
 b=I4hhh8C7tSIm7T9bHfi1/swozx9HbBbWv8NjiDfZgBU8ZjV3TsoR+r3/U8HLfpVgsy
 VFYwkpYI9KqeuaJtitf2VHxvtGfTyPiFCkbPusbZSRqw/E2bTWgRWZUiutQpDHi3sWz4
 rplofubDW2KxF7e/2/3JIa/UaW53SOTkum9KIdX5V4voXNadHpaRDuId0DC2a/icXldq
 PjK5ePKp56jUVgNfVj9cIWBYybXV8sX1UjbTC3mMVCtcCKfF6GSLwmPPeofI2v0j9RTH
 4p0qaE9yUGUwvJYdJ+uItlSmdFkXOAb67HZ3h89DxGIT4gR8abtiLy/vPpUFYqHe9wz7
 v2mw==
X-Gm-Message-State: APjAAAWHghuZK9SMzDiplTJSoBkzCVScm5fLqV/9OMgpRAYjQ2S4E11S
 TJ6EBN1jjnUDYQY5uDqbKjpeIu9go1A=
X-Google-Smtp-Source: APXvYqzpV8fgokXY1y1thuPBE+F1iSLIIxgoSWFVE5AwUyW1pJTSqG+tOOyZZuiBJV/Bxt9IRc5igw==
X-Received: by 2002:a17:90a:1c1:: with SMTP id 1mr58096780pjd.72.1563543427845; 
 Fri, 19 Jul 2019 06:37:07 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:433:31a4:f2fb:dab8:3a89:c056])
 by smtp.gmail.com with ESMTPSA id 11sm31895369pfw.33.2019.07.19.06.37.01
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 06:37:07 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 19:05:26 +0530
Message-Id: <20190719133530.28688-11-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190719133530.28688-1-mehta.aaru20@gmail.com>
References: <20190719133530.28688-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v6 10/14] block/io_uring: adds userspace
 completion polling
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 saket.sinha89@gmail.com, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 block/io_uring.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/block/io_uring.c b/block/io_uring.c
index e9c1dc1dc7..de2a037151 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -237,6 +237,21 @@ static void qemu_luring_completion_cb(void *opaque)
     luring_process_completions_and_submit(s);
 }
 
+static bool qemu_luring_poll_cb(void *opaque)
+{
+    LuringState *s = opaque;
+    struct io_uring_cqe *cqes;
+
+    if (io_uring_peek_cqe(&s->ring, &cqes) == 0) {
+        if (cqes) {
+            luring_process_completions_and_submit(s);
+            return true;
+        }
+    }
+
+    return false;
+}
+
 static void ioq_init(LuringQueue *io_q)
 {
     QSIMPLEQ_INIT(&io_q->sq_overflow);
@@ -394,7 +409,7 @@ void luring_attach_aio_context(LuringState *s, AioContext *new_context)
     s->aio_context = new_context;
     s->completion_bh = aio_bh_new(new_context, qemu_luring_completion_bh, s);
     aio_set_fd_handler(s->aio_context, s->ring.ring_fd, false,
-                       qemu_luring_completion_cb, NULL, NULL, s);
+                       qemu_luring_completion_cb, NULL, qemu_luring_poll_cb, s);
 }
 
 LuringState *luring_init(Error **errp)
-- 
2.21.0


