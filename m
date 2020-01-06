Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E66C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:52:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DEA42070E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hquBNycW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DEA42070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXUn-0003nU-9I
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:52:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4m-00035D-FR
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4l-0004ov-EP
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:04 -0500
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:42728)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX4l-0004ob-Az; Mon, 06 Jan 2020 13:26:03 -0500
Received: by mail-qt1-x843.google.com with SMTP id j5so43174722qtq.9;
 Mon, 06 Jan 2020 10:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=301DkkDUxv3dPn9xvTGgX6Pv43C1RPkzmMlQLGd0qHc=;
 b=hquBNycWNl+ENHsKsMjfCmPFF1DOp8XloeCrj3iHYhmGbriBB7dQUpG+X6sgjAUFPx
 X3yaM30aHtL7QxT050qO1F0HH1wkUPDRJbxjprBkCjXnIWDZcCtQKVROwfG2wwBv/ytY
 5cvTkWDCfXjmQHKTcLvNOjoHgRtP21guRyxVjXloVSiFJ8zsvmVlKXH35OJIh9w2pkQD
 NU3EJ39+K3onHFB+O59L29NTetZPuTO0ljPqjTYz/v2RjoOg33Ul0r9QOk/yYR6ggm0l
 7rpMTM0r0XyuIzV6G1LU1eEVU0whQvUH7PaKIr6G6vcs/nndvu9vm6iqhp0/Ljq+gTt8
 PuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=301DkkDUxv3dPn9xvTGgX6Pv43C1RPkzmMlQLGd0qHc=;
 b=bjJk9zh/obI+jWoBSb9QyrV/czTVSj3MplIQXBpoesCme4cYoNCJq/h3OFmhLsgPPX
 XgCsNwXmt9wsyY1jVtPDycDw/6zrDNkuvgVpYXeNUJ5O3EllidQkTLKI4CEE8CsqOW+i
 7Qb8wF+LvO5ttggQi4MQUHOy3ces1wIBy53ftltE/kk7ksp11ppZQYegrGp4wwMV9kie
 Kx2qqiCf2SrgwRfFiZDcc/ShiaSbeFsnFpyyT6n2HXUYODj3gSvQvZJ5ok97lM5Jid15
 jhg7t8DWSVi8InT5RzGwtZR9GzU5hD8+Pjg+0pfkKFZ3xFeNJchoNIIM47v5Jkn2a4gA
 6jHQ==
X-Gm-Message-State: APjAAAVEyTWsakmwAQexDfyYeFnfhy7NmxfwmvZoe3cnnUW1YyCFAISd
 S3EdHIXFxf8fT6YOmSDlWeNSeWDF
X-Google-Smtp-Source: APXvYqyRUk8GcrdqDkPnDntduyUj6VAGXrcqJmNj0X4PDHykubAkSDc5os1yABVEG6x3845DnHIBuw==
X-Received: by 2002:ac8:6f73:: with SMTP id u19mr74465496qtv.102.1578335162748; 
 Mon, 06 Jan 2020 10:26:02 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:26:02 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 39/59] usb/dev-mtp.c: remove unneeded label in write_retry()
Date: Mon,  6 Jan 2020 15:24:05 -0300
Message-Id: <20200106182425.20312-40-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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
Cc: qemu-trivial@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'done' can be replaced by 'return 0'. The 'ret' variable can
be removed since it's only set in qemu_write_full(), which
is now the returned value of the function.

write_retry() body also has an extra layer of identation. Let's
fix that to make it compliant with the other functions in the
file.

CC: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/usb/dev-mtp.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 7c07295519..818aa066c9 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1576,16 +1576,11 @@ static char *utf16_to_str(uint8_t len, uint8_t *str16)
 /* Wrapper around write, returns 0 on failure */
 static uint64_t write_retry(int fd, void *buf, uint64_t size, off_t offset)
 {
-        uint64_t ret = 0;
-
-        if (lseek(fd, offset, SEEK_SET) < 0) {
-            goto done;
-        }
-
-        ret = qemu_write_full(fd, buf, size);
+    if (lseek(fd, offset, SEEK_SET) < 0) {
+        return 0;
+    }
 
-done:
-        return ret;
+    return qemu_write_full(fd, buf, size);
 }
 
 static int usb_mtp_update_object(MTPObject *parent, char *name)
-- 
2.24.1


