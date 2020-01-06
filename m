Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDB2C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:27:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD1E124676
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oW0fJ1WO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1E124676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioX6S-0005Kx-A8
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:27:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX3u-0001ju-Do
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX3t-0003t3-2H
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:10 -0500
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:33722)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX3s-0003sS-Tj; Mon, 06 Jan 2020 13:25:08 -0500
Received: by mail-qt1-x844.google.com with SMTP id d5so43221896qto.0;
 Mon, 06 Jan 2020 10:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QRyshu9MeZF7Qp8JBN9b2R4zIWlvD97XdczFgR/WKsg=;
 b=oW0fJ1WOFaFYQygb4OiaE2zwvUJCoVB0ClpJiA+CpxlH5uLM/ELeanPSZao/ebTUai
 azFcEXAXgGk5jMU6ksXGrZdoPcQ7w+4hCy2+fnwl7yemAoThA+FTuV2H76J8EfNxVIRx
 /C0gbSFOtqmy8udAeWsKYRouWWF621uQ3Ba+UvCnqmyAtgNZPIBh2vHvIrUhMYw7lOUu
 OSVobWtjOKsj1P+sEc3HZnfUVOapduplG09t3LZRFjUJW3vFzx0mXqYne9VFRn9/CobG
 7I1LlNZmPfpqCl7bGc4sbNINlk2ofK073OgQ4UwM7L7CV5l22HT8RRfv6DcFaNgieVPJ
 +b1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QRyshu9MeZF7Qp8JBN9b2R4zIWlvD97XdczFgR/WKsg=;
 b=Q24w6nMclxdp/QCYJMqeN8VFoj2fJe5yV4n1L6YiCqsQk1oHxZlOX7d2za6oIKxyg/
 /Q/wfKcwxaMDbb+ZzZc6EC/MO878IXIxW7vF49CbvuLcdoznOyICB9ecbuTxkQhEiMxI
 kJfg2XgWsQ53JFHPu9R4a5RzJYJSKB7z7/Bzrlkqe7UI9gNbrhg50Ngg/OIUsGH1bpGE
 TAjHbJnL31WZ6F1t2FUTfEq0C9FFx/sPcg0kgkG+g1PmEASIW6lxHyWj94FghDi+KR7k
 euGDLaJr+QJBiifeff+rAfrLpzzZXnF14xdx1tuLJYqyJ+FZF5fgAevpOE36d/M0pqd/
 QKRQ==
X-Gm-Message-State: APjAAAWvf2hnMXOsX76Z0kH2CSYsN3Krgmfg5XWZnc3eK4Oh6F6CZIbi
 KSql+Ywyu0geqT6tKbtlAs4ZeGZq
X-Google-Smtp-Source: APXvYqz2P1iO6OVNn84mm/5qlWhQzA+cG1IKA4KYCAetSls150BfSZkRNfZfWLTnxF9hsQgqLWY5PQ==
X-Received: by 2002:ac8:41c1:: with SMTP id o1mr61453222qtm.229.1578335108258; 
 Mon, 06 Jan 2020 10:25:08 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:25:07 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 09/59] chardev/char-pipe.c: remove 'fail' label in
 win_chr_pipe_init()
Date: Mon,  6 Jan 2020 15:23:35 -0300
Message-Id: <20200106182425.20312-10-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'fail' label is simply doing a 'return -1'.

CC: Marc-André Lureau <marcandre.lureau@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 chardev/char-pipe.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/chardev/char-pipe.c b/chardev/char-pipe.c
index 94d714ffcd..65d52beb0d 100644
--- a/chardev/char-pipe.c
+++ b/chardev/char-pipe.c
@@ -54,12 +54,12 @@ static int win_chr_pipe_init(Chardev *chr, const char *filename,
     s->hsend = CreateEvent(NULL, TRUE, FALSE, NULL);
     if (!s->hsend) {
         error_setg(errp, "Failed CreateEvent");
-        goto fail;
+        return -1;
     }
     s->hrecv = CreateEvent(NULL, TRUE, FALSE, NULL);
     if (!s->hrecv) {
         error_setg(errp, "Failed CreateEvent");
-        goto fail;
+        return -1;
     }
 
     openname = g_strdup_printf("\\\\.\\pipe\\%s", filename);
@@ -72,7 +72,7 @@ static int win_chr_pipe_init(Chardev *chr, const char *filename,
     if (s->file == INVALID_HANDLE_VALUE) {
         error_setg(errp, "Failed CreateNamedPipe (%lu)", GetLastError());
         s->file = NULL;
-        goto fail;
+        return -1;
     }
 
     ZeroMemory(&ov, sizeof(ov));
@@ -80,7 +80,7 @@ static int win_chr_pipe_init(Chardev *chr, const char *filename,
     ret = ConnectNamedPipe(s->file, &ov);
     if (ret) {
         error_setg(errp, "Failed ConnectNamedPipe");
-        goto fail;
+        return -1;
     }
 
     ret = GetOverlappedResult(s->file, &ov, &size, TRUE);
@@ -90,7 +90,7 @@ static int win_chr_pipe_init(Chardev *chr, const char *filename,
             CloseHandle(ov.hEvent);
             ov.hEvent = NULL;
         }
-        goto fail;
+        return -1;
     }
 
     if (ov.hEvent) {
@@ -99,9 +99,6 @@ static int win_chr_pipe_init(Chardev *chr, const char *filename,
     }
     qemu_add_polling_cb(win_chr_pipe_poll, chr);
     return 0;
-
- fail:
-    return -1;
 }
 
 static void qemu_chr_open_pipe(Chardev *chr,
-- 
2.24.1


