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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A401FC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:38:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DB61208C4
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AG8vG7v2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB61208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57871 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXH2-0002N8-0q
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:38:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX3v-0001lp-PO
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX3u-0003uP-Fi
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:11 -0500
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:45902)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX3u-0003u6-BB; Mon, 06 Jan 2020 13:25:10 -0500
Received: by mail-qt1-x844.google.com with SMTP id l12so43162498qtq.12;
 Mon, 06 Jan 2020 10:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tnY7QxipU1+snECgL7BBBU3+B3MZxCY/MIXbljxzDB8=;
 b=AG8vG7v2VGw2KzpxtIVUSix/hig/+nKsA/yE7FWR40p8AU5NhiYLJ38r7kYFhHSvYY
 CW8ELOWLFo8wKg0P6B/ylPd8YaLgS2lHNQgANVz1OXNV1ci2v43DrVPTk4VtUYGL5kph
 ZsoC7Hpxs98LZ2cj2k9Z/uyTFz36iynVok48mRkvwTY+GAmBTzc/jc859sGy6J+tTJP/
 e5G9AJRwad+nCeHEbcXKFez4vkcHccibprR4FxOhP0yO0riUzEqbu3G2wL5K6mOz5ZgH
 x1gdasslqNGKmyxlxjK+5y9dzoNyoj2+lDtRFWLy4fe4iNjlbVcM9h2ppEdpPQFGxKAt
 3a0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tnY7QxipU1+snECgL7BBBU3+B3MZxCY/MIXbljxzDB8=;
 b=i+xsplcdK1M4v8aoQqvaNe04Bm2m99GvJfZydoPCWcfpLDRssRxEflQxCUx1FwuWmN
 6g97hlTN3xQBa/qHV7nAkTIvvlNMjoevHZHGvy2zK1a/Kpltqo3Ih4KLQoOg9UIBD+xm
 N1CpoKTpEEW4UoNpOjr9K+Sl52ZDzzPvfssi57h1pLcldYv5dRP7lytpDdpdC715tAjh
 hWBSdZ9atgER6sYebojAql1jk2n1iXYM807pUMsKStBgvIxBWrlYT0kg7HrBpnxIafPD
 WpvMbWv+3KeJQXG55iKQXgOCITYwvTFI3PYff6CXdTQQE6GBOMgHbwZBld3fbsxFNtX4
 rnHw==
X-Gm-Message-State: APjAAAXiD6horcvMPhLkrEagkm1EKlVx7SEPZ5YDfIj6C9agyyrwQ7XR
 8HPS4S8bk0TShFuwdfnzrWHPqu7j
X-Google-Smtp-Source: APXvYqye+lhuCh1FLVoCiYftUgeEtIrW0bNAhi7IeTTrucdmUNSCcRaHprn2BTjxc7LZh/69i7qYGQ==
X-Received: by 2002:ac8:490f:: with SMTP id e15mr72867227qtq.32.1578335109804; 
 Mon, 06 Jan 2020 10:25:09 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:25:09 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 10/59] chardev/char-win.c: remove 'fail' label in
 win_chr_serial_init()
Date: Mon,  6 Jan 2020 15:23:36 -0300
Message-Id: <20200106182425.20312-11-danielhb413@gmail.com>
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

The 'fail' label is a simply call to 'return -1' on error. Remove
it and do the return call instead.

CC: Marc-André Lureau <marcandre.lureau@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 chardev/char-win.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/chardev/char-win.c b/chardev/char-win.c
index 34825f683d..72c232e6d9 100644
--- a/chardev/char-win.c
+++ b/chardev/char-win.c
@@ -85,12 +85,12 @@ int win_chr_serial_init(Chardev *chr, const char *filename, Error **errp)
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
 
     s->file = CreateFile(filename, GENERIC_READ | GENERIC_WRITE, 0, NULL,
@@ -98,12 +98,12 @@ int win_chr_serial_init(Chardev *chr, const char *filename, Error **errp)
     if (s->file == INVALID_HANDLE_VALUE) {
         error_setg(errp, "Failed CreateFile (%lu)", GetLastError());
         s->file = NULL;
-        goto fail;
+        return -1;
     }
 
     if (!SetupComm(s->file, NRECVBUF, NSENDBUF)) {
         error_setg(errp, "Failed SetupComm");
-        goto fail;
+        return -1;
     }
 
     ZeroMemory(&comcfg, sizeof(COMMCONFIG));
@@ -114,29 +114,26 @@ int win_chr_serial_init(Chardev *chr, const char *filename, Error **errp)
 
     if (!SetCommState(s->file, &comcfg.dcb)) {
         error_setg(errp, "Failed SetCommState");
-        goto fail;
+        return -1;
     }
 
     if (!SetCommMask(s->file, EV_ERR)) {
         error_setg(errp, "Failed SetCommMask");
-        goto fail;
+        return -1;
     }
 
     cto.ReadIntervalTimeout = MAXDWORD;
     if (!SetCommTimeouts(s->file, &cto)) {
         error_setg(errp, "Failed SetCommTimeouts");
-        goto fail;
+        return -1;
     }
 
     if (!ClearCommError(s->file, &err, &comstat)) {
         error_setg(errp, "Failed ClearCommError");
-        goto fail;
+        return -1;
     }
     qemu_add_polling_cb(win_chr_serial_poll, chr);
     return 0;
-
- fail:
-    return -1;
 }
 
 int win_chr_pipe_poll(void *opaque)
-- 
2.24.1


