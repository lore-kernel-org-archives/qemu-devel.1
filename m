Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC99CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:21:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C280920684
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C280920684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMpQQ-00064R-PQ
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 04:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iMpGO-0002wl-Sc
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iMpGN-00059j-Lr
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:11:32 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:35047)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iMpGN-00058h-CL
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:11:31 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N49Qd-1hwb8436SP-0108Lb; Tue, 22 Oct 2019 10:11:21 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 11/11] linux-user/syscall: Align target_sockaddr fields using
 ABI types
Date: Tue, 22 Oct 2019 10:11:04 +0200
Message-Id: <20191022081104.11814-12-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191022081104.11814-1-laurent@vivier.eu>
References: <20191022081104.11814-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:v3YdVmzJmEcP6SRVMaY6hsHojfJohoHzYFuF0CDyKNpgqHxMmuS
 XNkTeoiGBzAakmMR7PBEACMqV33KalFPJZsaNYNmko2oypC7X9hLxMVQTCVssRzTlq4cuKM
 Dsnt5YHKaipOsmsfvzCSUOd4zmnewn1KVIOIzqtMVBmq9Jy8o7qW/eG6LoPD7OqyyZglGI6
 oiFtj2ZsweTb0ZKKDIYcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dglBB5HGoOo=:E0kDKt8gP2uIruNJ1NVatt
 Aj+WKQUdWETQ9+lC+PSFilRGdl+gK5+Muqc3S67MzWMTvmTIzNWMnsjpep/qGbB/TGfXvG3Rp
 wO3kdCY4nw6ANDInkzNtDdiSr3LKAFR9FfhqSCMtPH736Bx3bVzTNyOBQr6FJlBdpLjYK4HWY
 REQM+rpfjgigmM7PKohRmjAte4PInywpvUg2QkYvgBkiEuXYGG54sGFUPHCJSgBmXPNcyAVQb
 f9OV6rxD1px48DnPABrOn6HOC+kt6grarszzGhx36/h9QH1uaILYzhLO5oRpBx0i0mDEe+MYt
 MNT6mCqW5ydgGOeyZ99jgWk6lX5OQVatE6clic1of2FPW/xf3SioIDjIT/y8No8V+bA50puJd
 JukucJS4l8ft69xoL0cHKEKBmpS0PXIZk5y5cSb2QKByaZ0PMLG9pS2RW5mA8TkpBz8uGyPsa
 LBdvcep4VIGrcOkiyejWO5g7juRXXIP1rDee68mzSkxnWifUDuhNUD1ziAzLIEIXHk+8/VQJL
 24PapIyK/hknxLzZIzNmKoBvhZ64bVGWVQlXGoTK6XcFFNZog7IhQf52F1qw3/a6LeyqP5yPa
 856BjShefWFR16y1I3E3QCyYqMy0WzOgw/7uwhvQ3K4Oo2olHTgr+tYYYdjqmTtbq/U+IBCV2
 u231bTqBW+2xZsP2At2TiSUvWqzA6zNSNHm4UtTyJyamirpgTYxwP1SDjeTbAfilrKVs3t+Gl
 d0NK0DpCKRyTAbBKYsqypMUrbR5YDC/3OEAV3N/37wRQrAuVGZEY4aWY9kmZvFk15riJb0t9v
 SedKCvOdgSn7JCbPT3yhnZj4oxRvHF1279xvIjkL2jrTnhhefiKMteaGNoBTNPo5azscvTZHE
 39MRYbBQ49+rhEsapryvVR8Xmhq8tghs0AcMacWRQ=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.13
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Target architectures align types differently for instance m68k
aligns on 16bit whereas others on 32bit).
Use ABI types to keep alignments good.

Suggested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20191021114857.20538-10-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall_defs.h | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 7694d72446d1..98c2119de9c1 100644
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
+    abi_int    sll_ifindex;  /* Interface number */
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
2.21.0


