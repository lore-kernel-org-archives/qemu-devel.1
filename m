Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFD6C19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 23:46:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68810206A3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 23:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9Drqivk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68810206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htKme-0006Ji-OP
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 19:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60849)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1htKiF-0007DM-JP
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 19:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1htKiD-0003OV-2m
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 19:42:22 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37750)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1htKi7-0003Lh-4L; Thu, 01 Aug 2019 19:42:17 -0400
Received: by mail-pf1-x443.google.com with SMTP id 19so34949509pfa.4;
 Thu, 01 Aug 2019 16:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jqwyu4mBtWhJeShMhcEvRijFXLobB+NL3V3xOjbt+Qw=;
 b=g9DrqivkWlorJHMRZjUjiU44jjXufzqi01TiqLasEH7FvzEFknNE9UpIBDOyIVsk9D
 IHopBvsUsbiHvXudePqsRIwj1lD7fYw7g/9JMXBS9w4dDIOuxXK+0oeVfzHWlsQQHykj
 OZHPgFKsrb1HJSQrM23uQ0x02cM/o3KjMTiS3BQpAhIj3yRd6lpdaEQwrnGBLmj+3P27
 2ohBagsXIHrSTuS6jUk3eVU5Nt6xsYgbYWLLH3mX6ZLEdTBbND7+y6TJrQXux+lDKEje
 FMHmky7A4Yy7dyc5v0wnUH+knJcdmD4ca9LYDKrxpg/q/Ah4YYoczuyGUrKqVeFiudBW
 NCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jqwyu4mBtWhJeShMhcEvRijFXLobB+NL3V3xOjbt+Qw=;
 b=QTEE55FG4WRkfUxdKCaLlEF3H1M96l+ZuPACOsAfAU+T8/6bfMuZStkZQBN6soqp0Q
 WNeORc08raSHi81P+8ilURJjE5gh2z/7t8p5MDw3JUfr/BRVh/NKzlNqm2o6p0GLt0KU
 2kVlHroPvbzDG+7ywvofhCpBweZ0JQ+qjqKgOSTsmrJ1e+yEO9Aays8cmrq6es51jjnO
 1UftBaOJ1sAem+1GwProPO1ha4rdzsa/tBugZRiCGpoNQBMXsEBvH4hfqvxv1ktR2yln
 7a3Qyc6bgxv4ge9e32Y3pagku2QzeuaCnyBx2xckB3IbFgtPvkEYE7fg0D60ZvLzbbmO
 BE2g==
X-Gm-Message-State: APjAAAVYOHZDE4/0iyKrrF/3LwFEPPQc0oVloi4dtg40YVisk6t+I5PY
 46olbQOg2OFGHkexds6AgCuMen4qlrytXg==
X-Google-Smtp-Source: APXvYqwo4InSN0QwORIXhQ2RTqHMJJsHrJnCVPvR5U2XPDhvNc6Z5iOvhUXTAw3XppYhuYTrVmduTg==
X-Received: by 2002:a62:15c3:: with SMTP id 186mr58297383pfv.141.1564702931311; 
 Thu, 01 Aug 2019 16:42:11 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:572:3de5:765:cb16:92cd:ee3e])
 by smtp.gmail.com with ESMTPSA id
 g18sm117975426pgm.9.2019.08.01.16.42.05
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 01 Aug 2019 16:42:10 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri,  2 Aug 2019 05:10:24 +0530
Message-Id: <20190801234031.29561-11-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190801234031.29561-1-mehta.aaru20@gmail.com>
References: <20190801234031.29561-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v9 10/17] block/io_uring: adds userspace
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
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
index c8e6526747..86f32e18a1 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -238,6 +238,21 @@ static void qemu_luring_completion_cb(void *opaque)
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
@@ -395,7 +410,7 @@ void luring_attach_aio_context(LuringState *s, AioContext *new_context)
     s->aio_context = new_context;
     s->completion_bh = aio_bh_new(new_context, qemu_luring_completion_bh, s);
     aio_set_fd_handler(s->aio_context, s->ring.ring_fd, false,
-                       qemu_luring_completion_cb, NULL, NULL, s);
+                       qemu_luring_completion_cb, NULL, qemu_luring_poll_cb, s);
 }
 
 LuringState *luring_init(Error **errp)
-- 
2.21.0


