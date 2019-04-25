Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE558C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:42:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8797B206C0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9s4XetU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8797B206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57414 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJeeJ-0003ek-Pj
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 09:42:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJeQe-0000hQ-Ao
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJeQc-0002Uc-Vb
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:28:44 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJeQc-0002PM-NU
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:28:42 -0400
Received: by mail-wr1-x441.google.com with SMTP id a9so12760929wrp.6
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Ug7lH5JQX2D1LVe7jW+RIkoeBivN61kq/FZwpsv0F+4=;
	b=Z9s4XetUHNtU/OTIWh9Ep61jW6f2J+1NNSYnWzNfYvDpPKv6hCfAFgAMI4NFqZwW/N
	6VfOG/T7zZH+Hrmuto2UCRkuGE2Fr8J0xpqf9Kl7SJz8JLlvtuPgDzTiXo4u5bdeePHF
	ai3+YxjYJkHXVZrtz7HuBdvf6B8TK9J87G/5mJakstmkMUtNcvyixdYZ4T1HNd8XL6xY
	c6bXIh8EBZD+0Ykl2pOuRMTK1MeVBwlrQN9f9I9Q8Qc3WC+oF99iUQ9UJb17VgOsuzol
	KZAFA3K4Rw+YePmusQiSjJgMkvhsFsuSx9vmpj8QHtNumeBfYrqaSlCTLUxkHe4j5KuF
	vTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Ug7lH5JQX2D1LVe7jW+RIkoeBivN61kq/FZwpsv0F+4=;
	b=kFlJlj2R8MewLizK06Lk+H5AkvRN7IIfULYXGxArCSpl/rfAYgsrKrwNqdQ07e9Wzc
	ZMOMwzdS2SdBzvqKzvNvZggM7Xr6MX1mV3c4AWMFBXuDJ9mCmfcvolUvsB9UU7tzbseF
	7uGU8bJpUgkj86E/muxtSGCwHhJ3Q+i/63R41tcuk3T9dhJNnEoDRb17yVLBb4pZMuxY
	KHsAjyJfnSNdMJt5o7knbQYXwAnBEu+L+3nJKgu76BtnF7a+Ip87Kw2xbZJoAOcE4Lyd
	+I2iQxr3Tz5I+tJyKJuoJWiyU3lOEPslNKf4VHiLieUYxXrsljqU6ZM4bveCzWY5Hq9q
	/lZQ==
X-Gm-Message-State: APjAAAVJ8T34pbEoX25LWtNMEDDBj6d6QFhZoA0BNCUUWbNgZjLZy/KS
	v4sYctI6b+cBgOVVLyzLck1jeGjJ
X-Google-Smtp-Source: APXvYqwhf/dTH3Nb/k2PjnBmxK20exO1mzv58TmGvVBX0fGGOHXrh8koEDn6ZVO/LoWJm+BQxIuM7w==
X-Received: by 2002:adf:dbce:: with SMTP id e14mr25495974wrj.249.1556198917147;
	Thu, 25 Apr 2019 06:28:37 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id y4sm2316540wrt.34.2019.04.25.06.28.28
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 06:28:33 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Apr 2019 16:26:36 +0300
Message-Id: <20190425132636.31636-22-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425132636.31636-1-arilou@gmail.com>
References: <20190425132636.31636-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v6 21/21] gdbstub: Clear unused variables in
 gdb_handle_packet
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190425132636.TMikkgHvSk36gneYRpLyTnL6kgByeqgahL1rVqWGI90@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 8838241209..32aeefbbe6 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2268,17 +2268,11 @@ static void handle_target_halt(GdbCmdContext *gdb_ctx, void *user_ctx)
 
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
-    const char *p;
-    int ch;
-    uint8_t mem_buf[MAX_PACKET_LENGTH];
-    char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
     const GdbCmdParseEntry *cmd_parser = NULL;
 
     trace_gdbstub_io_command(line_buf);
 
-    p = line_buf;
-    ch = *p++;
-    switch(ch) {
+    switch(line_buf[0]) {
     case '!':
         put_packet(s, "OK");
         break;
@@ -2495,8 +2489,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         break;
     default:
         /* put empty packet */
-        buf[0] = '\0';
-        put_packet(s, buf);
+        put_packet(s, "");
         break;
     }
 
-- 
2.20.1


