Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8DBC2BA1D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 21:47:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0D3B2077C
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 21:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyzmS+NQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D3B2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9cMT-0001uL-PK
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 17:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i9cFB-00043b-8s
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 17:39:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i9cFA-0002BA-5w
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 17:39:41 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44034)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i9cFA-0002Av-0R
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 17:39:40 -0400
Received: by mail-wr1-x441.google.com with SMTP id i18so6187941wru.11
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2019 14:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U+YdfCWqylTf26ufhufmjwqtzAn/BfWEQAlWL2QBKqY=;
 b=gyzmS+NQiMFGh0VRdcQBRM4FqhDVWAvMkc7nacFYCWvCI+oP2ZgWf9Hrsnj02LlpBp
 Qb5YQqLJ9EsWfoTQJLEjFPHLKwPMSyAwK5ymZrCA60bs0raNIq73g96VpxzYpeY7BMwl
 iomVTUgmhnU4LdhtfTPQCtM0cCRKbv7jMz//Z0p2PpZR09Cq2/DQvehxzdYbfI/xfjAv
 plnv9M5oe3sfIEhcsXadexk7n+RS6gzzY85KHNOPdVLybyJNXKHzghFHIpxmew+wP0we
 rjg+N4XdOLUhPGnE0MqnhMngRBtwR0FxEJpQF9IG2Y6IUn5xYE8PFPkGjggTuLZvCrSq
 b79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=U+YdfCWqylTf26ufhufmjwqtzAn/BfWEQAlWL2QBKqY=;
 b=orMbbHM6ptnRCU8oKTNwEmwDICi2BMiLGvgkpeFIdhHPsxtvqG+m/NXOE7s/LFdQQI
 KvqOJQl6v+9KW8Gc05NE90x6B0FdEReDD+NLJ0X7Uha8tycn0m8wF3/1GTbzEKQ4FWyY
 +KDlh/YnbgKChpmn1im+QOyOgtu6CK+SrQ882TaFRIHzE84/vMxVHyXkKxkS2Kn4EcEU
 NT5BXe5dygScqZfcCLyXU6L4l58fimecL9xeKqRAIo4veQb93hSmWgWK71ZvvzfaOBt2
 buLRBMCXJvzo/yiFGdzR289xVFFLGI+P9Yytd0nPuEZeQubpHZyCW0zCG9MRVG2K+Gq6
 t6Ig==
X-Gm-Message-State: APjAAAWaKl9Y6YyP9h2xby6hEFoINrsiVZaY/IYqV4iMJNfegIV3MVbV
 WD/Qh2/MNpqqEuHgS6YqCWMOL5SB
X-Google-Smtp-Source: APXvYqz82u/VP6g34kEKaG15A6qmwoiaCPswQGvFKQ23cFSXLzz4yGE0lwBkNgtkfq9vn3O8P70hMw==
X-Received: by 2002:a5d:4491:: with SMTP id j17mr17754346wrq.257.1568583578908; 
 Sun, 15 Sep 2019 14:39:38 -0700 (PDT)
Received: from localhost.localdomain (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id z1sm68738999wre.40.2019.09.15.14.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2019 14:39:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Sun, 15 Sep 2019 23:39:24 +0200
Message-Id: <20190915213924.22223-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190915213924.22223-1-f4bug@amsat.org>
References: <20190915213924.22223-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [RFC PATCH v7 9/9] linux-user/syscall: Align
 target_sockaddr fields using ABI types
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Target architectures align types differently for instance
m68k aligns on 16bit whereas others on 32bit).
Use ABI types to keep alignments good.

Suggested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
RFC: Is target_sockaddr_ll.sll_ifindex of type abi_int?

 linux-user/syscall_defs.h | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 7694d72446..852d4498e0 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -134,22 +134,22 @@
 #define TARGET_IOWRU(type,nr)	TARGET_IOC(TARGET_IOC_READ|TARGET_IOC_WRITE,(type),(nr),TARGET_IOC_SIZEMASK)
 
 struct target_sockaddr {
-    uint16_t sa_family;
+    abi_ushort sa_family;
     uint8_t sa_data[14];
 };
 
 struct target_sockaddr_ll {
-    uint16_t sll_family;   /* Always AF_PACKET */
-    uint16_t sll_protocol; /* Physical layer protocol */
-    int      sll_ifindex;  /* Interface number */
-    uint16_t sll_hatype;   /* ARP hardware type */
-    uint8_t  sll_pkttype;  /* Packet type */
-    uint8_t  sll_halen;    /* Length of address */
-    uint8_t  sll_addr[8];  /* Physical layer address */
+    abi_ushort sll_family;   /* Always AF_PACKET */
+    abi_ushort sll_protocol; /* Physical layer protocol */
+    int        sll_ifindex;  /* Interface number */
+    abi_ushort sll_hatype;   /* ARP hardware type */
+    uint8_t    sll_pkttype;  /* Packet type */
+    uint8_t    sll_halen;    /* Length of address */
+    uint8_t    sll_addr[8];  /* Physical layer address */
 };
 
 struct target_sockaddr_un {
-    uint16_t su_family;
+    abi_ushort su_family;
     uint8_t sun_path[108];
 };
 
@@ -161,24 +161,24 @@ struct target_sockaddr_nl {
 };
 
 struct target_in_addr {
-    uint32_t s_addr; /* big endian */
+    abi_uint s_addr; /* big endian */
 };
 
 struct target_sockaddr_in {
-  uint16_t sin_family;
-  int16_t sin_port; /* big endian */
+  abi_ushort sin_family;
+  abi_short sin_port; /* big endian */
   struct target_in_addr sin_addr;
   uint8_t __pad[sizeof(struct target_sockaddr) -
-                sizeof(uint16_t) - sizeof(int16_t) -
+                sizeof(abi_ushort) - sizeof(abi_short) -
                 sizeof(struct target_in_addr)];
 };
 
 struct target_sockaddr_in6 {
-    uint16_t sin6_family;
-    uint16_t sin6_port; /* big endian */
-    uint32_t sin6_flowinfo; /* big endian */
+    abi_ushort sin6_family;
+    abi_ushort sin6_port; /* big endian */
+    abi_uint sin6_flowinfo; /* big endian */
     struct in6_addr sin6_addr; /* IPv6 address, big endian */
-    uint32_t sin6_scope_id;
+    abi_uint sin6_scope_id;
 };
 
 struct target_sock_filter {
-- 
2.20.1


