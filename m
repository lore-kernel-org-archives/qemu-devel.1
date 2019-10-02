Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3F1C10F14
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:22:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B08921848
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPBorgXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B08921848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFiKK-0003qw-T5
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 13:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35547)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrX-0005id-Rw
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrW-0003eD-MT
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:27 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53246)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFhrW-0003dL-Fu
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:26 -0400
Received: by mail-wm1-x341.google.com with SMTP id r19so7972746wmh.2
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 09:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PclzfJqSWV+t6X/wVoNBPmc3tE3VD7bLUzGhh4ftL74=;
 b=ZPBorgXSQ3Y5PmTDTO0fRDUf4F5uk3YQPb8higaS3xNGQirpSr4PjJmkYoDA4cyp6V
 p8Cp2bchXRBpTzXRmAN1nKR5NrfH5vL/FWB5oGmA919OsOQiHA3y8KmDIEOAWvN7atUa
 QSxqT3wTNBEMe6vT4D7aJcWx+LSHQCCVLkEXuiICZONP+N8eFNl+HpTyGAa+SGGiQnQQ
 3CCd9XRuoTrtLMANKw2u9FW6RVJp8cJ6BFVD/cC2km2XviM3z7QLFZKRWZwWF0aGHT1h
 1eVP0yZQM3GWHLJXMiR3kbdqXpQEXIA9G+t0tVOk7/qZizmNfc8fFX8llYyyRftB42EI
 3+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=PclzfJqSWV+t6X/wVoNBPmc3tE3VD7bLUzGhh4ftL74=;
 b=THCJJTl5sJ52q4mif2UAVeNQ/RRqipwOzksfXkfkEmQ/HPXuYSIGtAn6+H+EcykAwx
 +ragqwZ4vmSh2kKQ9t86tjkH5l3ylW7CMcqtH1Y7eNmCvKSraHX/1IidLUGhYXUumcVE
 90ajDoVhfRJHyFyqSoZs83qCeuV5zt8wU/y2c6bN7/RigVb0aztubMexKWVM4pFDsYqx
 lOcEKFaz4JDg8nnoYkUbAuvkNcSd3AlxbX/wqWiX8YO/HDQBwv+uis2R0mvsWiUfyPd0
 vk2oZs7tKZk0cg7Kblw0qlMcL0JGC3ty2AGMpnECWHckGlN5jhOTVtYGFb8aALBkgPNf
 2z1g==
X-Gm-Message-State: APjAAAXdBVhGNjZ1NPBAml/kP7iY13AYWW+4LiG15ZPOj5aeQrN53Xo5
 l3DPRhkT8ZRlsWe3YM2V7PT3Fffn
X-Google-Smtp-Source: APXvYqyrcwi8CxxIaB3r6xiT0v3cRAyxgXiIGM4hIRb98NMNLSRDOzteiyEDp0IMlxV2Mmamm53iow==
X-Received: by 2002:a1c:80ca:: with SMTP id b193mr3357043wmd.171.1570035145160; 
 Wed, 02 Oct 2019 09:52:25 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g4sm27303990wrw.9.2019.10.02.09.52.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Oct 2019 09:52:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/30] win32: work around main-loop busy loop on socket/fd event
Date: Wed,  2 Oct 2019 18:51:51 +0200
Message-Id: <1570035113-56848-29-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
References: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 James Le Cuirot <chewi@gentoo.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Commit 05e514b1d4d5bd4209e2c8bbc76ff05c85a235f3 introduced an AIO
context optimization to avoid calling event_notifier_test_and_clear() on
ctx->notifier. On Windows, the same notifier is being used to wakeup the
wait on socket events (see commit
d3385eb448e38f828c78f8f68ec5d79c66a58b5d).

The ctx->notifier event is added to the gpoll sources in
aio_set_event_notifier(), aio_ctx_check() should clear the event
regardless of ctx->notified, since Windows sets the event by itself,
bypassing the aio->notified. This fixes qemu not clearing the event
resulting in a busy loop.

Paolo suggested to me on irc to call event_notifier_test_and_clear()
after select() >0 from aio-win32.c's aio_prepare. Unfortunately, not all
fds associated with ctx->notifiers are in AIO fd handlers set.
(qemu_set_nonblock() in util/oslib-win32.c calls qemu_fd_register()).

This is essentially a v2 of a patch that was sent earlier:
https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg00420.html

that resurfaced when James investigated Spice performance issues on Windows:
https://gitlab.freedesktop.org/spice/spice/issues/36

In order to test that patch, I simply tried running test-char on
win32, and it hangs. Applying that patch solves it. QIO idle sources
are not dispatched. I haven't investigated much further, I suspect
source priorities and busy looping still come into play.

This version keeps the "notified" field, so event_notifier_poll()
should still work as expected.

Cc: James Le Cuirot <chewi@gentoo.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/async.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/util/async.c b/util/async.c
index 4e4c7af..ca83e32 100644
--- a/util/async.c
+++ b/util/async.c
@@ -354,7 +354,11 @@ void aio_notify(AioContext *ctx)
 
 void aio_notify_accept(AioContext *ctx)
 {
-    if (atomic_xchg(&ctx->notified, false)) {
+    if (atomic_xchg(&ctx->notified, false)
+#ifdef WIN32
+        || true
+#endif
+    ) {
         event_notifier_test_and_clear(&ctx->notifier);
     }
 }
-- 
1.8.3.1



