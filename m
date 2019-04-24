Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DF3C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:50:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4875E20674
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N28EOZry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4875E20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46432 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNuh-0004Zs-Gn
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:50:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNkZ-0004H1-T7
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:40:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNkY-0004XJ-T8
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:40:11 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35733)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJNkY-0004Vy-Ld
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:40:10 -0400
Received: by mail-wr1-x441.google.com with SMTP id f7so4177026wrs.2
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 12:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Ug7lH5JQX2D1LVe7jW+RIkoeBivN61kq/FZwpsv0F+4=;
	b=N28EOZryNDYx9JGeSRKnuNiR5EcCLoVv5geHixzg7NVz5JmwOBdj6P5dRQOOpbwYa0
	fve8WbtWpLjDKYw15TCdPQBLIAzydTMzbvCLsqOhGAL599YPPTcMD7uBL6Mut9RH5lgt
	u/RJICCd39KVaDr9qz9mPCSjvVKGHhlFq24dBpj9MjbD7+i19WpfDX5ZTjwO4LxPaygc
	byQUEHQ/ig6MZLuoR2IgjFVPM3jWCYSbh/kdNt+r/3p+EnzVFVC5P3d3qJAQjFR4NpKD
	/VcggmF/jAQbw/5NrqSSKuqK7mfjqZTq11LUq2HFmfH4ytduYE+ADxY9WomPydeZhJbQ
	KO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Ug7lH5JQX2D1LVe7jW+RIkoeBivN61kq/FZwpsv0F+4=;
	b=j88a3vVuDmFJ367Fi4614ThxndsXMi1pDrs5rAjKqijb4W0PoeeXBBmycrcz0WSIst
	uMJEViSkD+/maHYY71UKjIDHl1BveysChawwkBU0B2HgyCT3vlAWwdvsGkOtvU5hcHu/
	xvqn8pukA6JeqSuFAquV4mN6dKVZGyt+hcru0Gl+99cQQn2tZXaYsizongJAK62VwUbP
	vGHNAFsGk6pdsaBtYLKSKyXMZYBZiQ8bJ638WGTM4hlTfzzuw+ao75QZk1WDhKuNCV2a
	q5ojF2/7rGKdPW4TpPwCur1RPqAlW9IDpGoCA2tsWsBIJE5OU7wBqFRzcJKC7EYc7YKe
	Ag6w==
X-Gm-Message-State: APjAAAWAWqWoINW3PS2oqLECIOC7kvkNhGxRbOEN6+bkjWlLmVdXpuJR
	Ugn7aJZ2BNn2fUwWcyzGJiR8jHAh
X-Google-Smtp-Source: APXvYqziI8/oIFT6GAZbG3z/zVpuEHqO1UEuZK2AOpD3DS/yWFFF3DJsEWaPTUX4H7sAkDHqrDabAA==
X-Received: by 2002:a5d:6987:: with SMTP id g7mr21851518wru.299.1556134808940; 
	Wed, 24 Apr 2019 12:40:08 -0700 (PDT)
Received: from linux.local ([31.154.166.148]) by smtp.gmail.com with ESMTPSA id
	n18sm16281372wrt.16.2019.04.24.12.40.04
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Apr 2019 12:40:05 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 22:38:59 +0300
Message-Id: <20190424193859.31817-21-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424193859.31817-1-arilou@gmail.com>
References: <20190424193859.31817-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v5 21/21] gdbstub: Clear unused variables in
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
Message-ID: <20190424193859.l4NcB2HmPlJPUpyI2wzjlXqw_XS7HBd94WU3ZL5rWjU@z>

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


