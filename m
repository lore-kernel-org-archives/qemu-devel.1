Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84079C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:26:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F12B206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSOJpMmv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F12B206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7Y8-0008JH-K0
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43973)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hs7QD-0007kc-7B
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:18:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hs7QC-0000j8-83
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:18:45 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:35000)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hs7QA-0000dn-6u; Mon, 29 Jul 2019 11:18:44 -0400
Received: by mail-pl1-x642.google.com with SMTP id w24so27637989plp.2;
 Mon, 29 Jul 2019 08:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rZYA5xSOck9aKPGmwHUNllk81b/q8QLNugjTlKfx170=;
 b=WSOJpMmvb6q6f2rrL0A8KE9pSO2qkr7f/bHA4JiDGoE0oNOptA0fr7yePSyXTWf9w9
 4kpNQt21Yx7/Oe0jSHG1NOlgyWBoFbXqUDRDB02WsQ05xik910aV1BHRo11kZT5fmToU
 Tx63tcPlAi89yeqJypL8m2svUmqp4tWImsTjbPjzJYSwcrviHVqwrZemlygFZM84LcaN
 oeR9gME55SJTm3tZALnLtHhEm4CvRJ6Fyl44j5B1UH7QoLXLrv1++xCFNWWX0HmVoyCK
 Ll5+M+sgBFP0+ityv/MYSkxjdlK2njmq2xoJ2aKrQC7bzl96w+5A3fXeCdgzyTytOwiA
 kTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rZYA5xSOck9aKPGmwHUNllk81b/q8QLNugjTlKfx170=;
 b=f1+QOLsPWXw9UPQPMn/RbrXvX2JdyBHSqDPO4c7DB+K4AJKckDu2U0tR4s4WcunfwO
 Q9m09jgq/vAKAxFOlVviQwCCztFfa0ZzZzH+awyCPBcc2fkJOOZLV1zx9JO/emVlsLuk
 mwOTmstgyHcNexbSJZGGFZVwWp37jBDy9PWayW+gHNKgLvEFlgQ5otUZBxezl0oQ3cnX
 a8J8LPa6iapfJYAadb+wrEnoMvOh6mvSdJrBWW+jEdi1c4blv8+B8fhWpOdNGodUaSyE
 9UwoGlKrvcqp5/Ak9ayaHVehDmya8ZGLoJ6MZUJUEuHzgBaljsyeVl/J/Xs8RJ12fsvh
 jKIg==
X-Gm-Message-State: APjAAAUbtB1VMd1ARlsrufaWTiVcUiWClGdiyf+0fEyp159j122PDcVg
 fmmaortMiMrpz823CGVjV317t5qI1VOb9g==
X-Google-Smtp-Source: APXvYqxD93nYleuN1AJqUQjJLPQCm/SxiPHIvotq1cDcZAq5bCdaexkbf0ktDwLy/PI3vpvVZGwczQ==
X-Received: by 2002:a17:902:1129:: with SMTP id
 d38mr112055417pla.220.1564413520456; 
 Mon, 29 Jul 2019 08:18:40 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.97])
 by smtp.gmail.com with ESMTPSA id h129sm58693941pfb.110.2019.07.29.08.18.33
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 29 Jul 2019 08:18:39 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 20:46:46 +0530
Message-Id: <20190729151651.21306-11-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729151651.21306-1-mehta.aaru20@gmail.com>
References: <20190729151651.21306-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v7 10/15] block/io_uring: adds userspace
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io_uring.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/block/io_uring.c b/block/io_uring.c
index c7b2b0a9e2..691130b948 100644
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
     QSIMPLEQ_INIT(&io_q->submit_queue);
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


