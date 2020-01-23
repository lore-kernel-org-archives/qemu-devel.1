Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4586FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:38:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14CD521734
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJxdwXLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14CD521734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iueZI-0000hz-TU
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:38:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrf-0005PJ-BM
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucre-0004DU-7e
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:43 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:39172)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucre-0004C9-1Q
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:42 -0500
Received: by mail-wm1-x32d.google.com with SMTP id 20so2591772wmj.4
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NRtpysghTnIJUNFyZSG4PEwiYVfrrLID8LkUoY/p4CA=;
 b=pJxdwXLcMYwvGwGK+WZ4Luv2M8+omtuPsN5RomK2ZvK4SPXCJJvuPeqgGoepbB+r7D
 3k7xbIhqKVZfI/UPP5NvhDDI54pdrCpgl6m+2LSCLjdX9+hPwE1AbBdAzxQrurb3D/od
 CjrUWDcASkp3zlNDyU7c2q+oxJ0oB8fxDlV1ySyMtovqsz5ncVY90ud5nQEVNIKCTl9O
 WIExG6iRe0gP2XHWVRuh4KFB8/fNnLn6PTlMCe1fsKm37JJMwwvGonktI6Oxe7L2FAIu
 XGHrYWYFU/CImovOMrMaiyi9padEVAYqypbhGp8F0HxVZy/NPbfNNWh5O3dgbMiKDbVo
 dUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=NRtpysghTnIJUNFyZSG4PEwiYVfrrLID8LkUoY/p4CA=;
 b=pgQWnrDUwOXqx8kzBYaprHIQlhGfx7FyMurQF6u+S8BMieDMN62VebREzW5aVEfYBt
 iRCzto5Ul6gbkzLlFfkI57yYKMyMO6FeAt5xjdzavd/rXgpPn15vLMN12iGzr4RXfP7x
 DWDyp6WlCB31xw5t32l8PWVrorlPYGd1atMjVfMQdK0OIE7Jknn31UnZSl7sDPYuQ1dS
 cn73e+ushcswBZdWFCvB13neU5rmrGjfb1/6MOufpPQSj+BSxkHVKCkYLllrH3g69JQu
 Xvq/W4cNl6bVJSVYbGuHdsjcke3lMtesGR/C0WS/J88bCABvYyK+hzmbOD2u+ydrEgkE
 WQUw==
X-Gm-Message-State: APjAAAUQkFpKzLuZagrqh2rUTvtWxVGaeXneoSlMAJkNiFOyPyY9Keta
 67jIvTfXHPzMwD/QH/pmNaS2RnxX
X-Google-Smtp-Source: APXvYqzGjKTURVyJHKhzzMNMurSQlSFHTXb6qeCiQEl5C/GBOAVSxYwm78XEsOAIEAZhWHW8s37cRQ==
X-Received: by 2002:a7b:cf01:: with SMTP id l1mr4314489wmg.86.1579787380985;
 Thu, 23 Jan 2020 05:49:40 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 39/59] qstring: add qstring_free()
Date: Thu, 23 Jan 2020 14:48:42 +0100
Message-Id: <1579787342-27146-40-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Similar to g_string_free(), optionally return the underlying char*.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200110153039.1379601-10-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qapi/qmp/qstring.h |  1 +
 qobject/qstring.c          | 27 ++++++++++++++++++++++-----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/include/qapi/qmp/qstring.h b/include/qapi/qmp/qstring.h
index 3e83e3a..e2e356e 100644
--- a/include/qapi/qmp/qstring.h
+++ b/include/qapi/qmp/qstring.h
@@ -33,6 +33,7 @@ void qstring_append_int(QString *qstring, int64_t value);
 void qstring_append(QString *qstring, const char *str);
 void qstring_append_chr(QString *qstring, int c);
 bool qstring_is_equal(const QObject *x, const QObject *y);
+char *qstring_free(QString *qstring, bool return_str);
 void qstring_destroy_obj(QObject *obj);
 
 #endif /* QSTRING_H */
diff --git a/qobject/qstring.c b/qobject/qstring.c
index 1c6897d..b66a2c3 100644
--- a/qobject/qstring.c
+++ b/qobject/qstring.c
@@ -150,15 +150,32 @@ bool qstring_is_equal(const QObject *x, const QObject *y)
 }
 
 /**
+ * qstring_free(): Free the memory allocated by a QString object
+ *
+ * Return: if @return_str, return the underlying string, to be
+ * g_free(), otherwise NULL is returned.
+ */
+char *qstring_free(QString *qstring, bool return_str)
+{
+    char *rv = NULL;
+
+    if (return_str) {
+        rv = qstring->string;
+    } else {
+        g_free(qstring->string);
+    }
+
+    g_free(qstring);
+
+    return rv;
+}
+
+/**
  * qstring_destroy_obj(): Free all memory allocated by a QString
  * object
  */
 void qstring_destroy_obj(QObject *obj)
 {
-    QString *qs;
-
     assert(obj != NULL);
-    qs = qobject_to(QString, obj);
-    g_free(qs->string);
-    g_free(qs);
+    qstring_free(qobject_to(QString, obj), FALSE);
 }
-- 
1.8.3.1



