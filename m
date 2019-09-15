Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF9DC4CECD
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 21:43:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60A3820692
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 21:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dx0aunV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A3820692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57355 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9cIg-0007XS-Ga
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 17:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53290)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i9cF4-0003vJ-5C
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 17:39:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i9cF3-00028w-4r
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 17:39:34 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34092)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i9cF2-00028a-Tt
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 17:39:33 -0400
Received: by mail-wr1-x443.google.com with SMTP id a11so27109652wrx.1
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2019 14:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AKFRW7iLr4jMOL8ZcycrUAzKCNeQKL6R2udObUOcB8c=;
 b=dx0aunV3H8rv96NZnDBZDKyeKCtTk8XkKV+GqrsZfRu0Uekzrh2yMpD3uJ/SR4a//T
 5sgOOG2/umMkidDkOwneeEFdVFccoWKiGgzUtLJS+SzzTuVGx/2cWe7vOLZ8F5cjO+Wj
 310H7aoDPwgwccXzfwJFw99lGWtrvCLuMVOOcVNWithyGgwggMj6zN/LYaENTsZuD3ui
 a5cxE7+Zwc1PZczd/nEq72i75loEi5xE2juEWDGo0BEXSUzIoK2c0YqE1Ijd/bp9LdNL
 E5P6+HsAIDNUEGaEnVu2KICzA7dnhcjE/GwR6k6ZR0H4cWHFLeSD+zWEuFnIrhWEgPXE
 caAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=AKFRW7iLr4jMOL8ZcycrUAzKCNeQKL6R2udObUOcB8c=;
 b=hi2IeSJAoeqkhoBseJ7hgUj9gxAQi3xYsy3mdXOCEEddSaJaHg3/7zn3TuLtb8fcKd
 MPTtjHba2+N/JrLEwqKE7u8ITi0eqLenFcZdcX7atd3l+0DLeO1IUrbL5JdutPeCoqjI
 WBq2neDiyN4oNEhWFk/BJZTY/SezTJwlrUx3sfCpz7Q5wo72vHlbniGaWdhbSfeknrpr
 xfoiYBrrsFlAkQVKKrQk780/w+PDe5r9ZwkthYS/WKxjs8nwUqZ075GEn0DdTJqMdjb2
 2H7vx4TKZDVFRHeSgPY9tzhePFNGMOPKWKWPglmwcGzm1uAIGrmsFSboJJ5jk0YXhJQr
 5Wdg==
X-Gm-Message-State: APjAAAWMyfKdE95FK2QZ17MtQyOluCwYi3bFtJRLk1tS/K7E5gkidQMj
 a/rZJntB60rKYFlEh2ajJIBhc+KD
X-Google-Smtp-Source: APXvYqx8yYx59Y+b1xvxClehjGs33bXTmJRvidJeXK8ew/XQFgd39McCA/ZETzV7gnoXyiPqeuetHQ==
X-Received: by 2002:a5d:4491:: with SMTP id j17mr17754206wrq.257.1568583571714; 
 Sun, 15 Sep 2019 14:39:31 -0700 (PDT)
Received: from localhost.localdomain (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id z1sm68738999wre.40.2019.09.15.14.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2019 14:39:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Sun, 15 Sep 2019 23:39:19 +0200
Message-Id: <20190915213924.22223-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190915213924.22223-1-f4bug@amsat.org>
References: <20190915213924.22223-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v7 4/9] linux-user/syscall: Introduce
 target_sockaddr_nl
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
Cc: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-By: Guido Günther <agx@sigxcpu.org>
---
v7: use abi_ushort and abi_uint to keep alignments good (lvivier)
---
 linux-user/syscall.c      | 6 ++++--
 linux-user/syscall_defs.h | 7 +++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e2af3c1494..f1ab81b917 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1496,8 +1496,10 @@ static inline abi_long host_to_target_sockaddr(abi_ulong target_addr,
         sizeof(target_saddr->sa_family)) {
         target_saddr->sa_family = tswap16(addr->sa_family);
     }
-    if (addr->sa_family == AF_NETLINK && len >= sizeof(struct sockaddr_nl)) {
-        struct sockaddr_nl *target_nl = (struct sockaddr_nl *)target_saddr;
+    if (addr->sa_family == AF_NETLINK &&
+        len >= sizeof(struct target_sockaddr_nl)) {
+        struct target_sockaddr_nl *target_nl =
+               (struct target_sockaddr_nl *)target_saddr;
         target_nl->nl_pid = tswap32(target_nl->nl_pid);
         target_nl->nl_groups = tswap32(target_nl->nl_groups);
     } else if (addr->sa_family == AF_PACKET) {
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index fa69c6ab8d..7694d72446 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -153,6 +153,13 @@ struct target_sockaddr_un {
     uint8_t sun_path[108];
 };
 
+struct target_sockaddr_nl {
+    abi_ushort nl_family;   /* AF_NETLINK */
+    abi_ushort __pad;
+    abi_uint nl_pid;
+    abi_uint nl_groups;
+};
+
 struct target_in_addr {
     uint32_t s_addr; /* big endian */
 };
-- 
2.20.1


