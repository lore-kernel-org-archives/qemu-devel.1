Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F111CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:17:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72AA320684
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72AA320684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMpLu-0000BB-Io
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 04:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44159)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iMpGG-0002hD-Mp
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:11:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iMpGF-00054N-Ej
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:11:24 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:40997)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iMpGF-00053W-4t
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:11:23 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MybX9-1i6Vha17qn-00yzDT; Tue, 22 Oct 2019 10:11:19 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 06/11] linux-user/syscall: Introduce target_sockaddr_nl
Date: Tue, 22 Oct 2019 10:10:59 +0200
Message-Id: <20191022081104.11814-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191022081104.11814-1-laurent@vivier.eu>
References: <20191022081104.11814-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cZCZNjFSvn6JZ5+AViajwJTnhlc+xH1cJl92ap2WOuFI7HJd+YP
 Ny3c/DvDRX+jV3hDnIrmkfmcWzELybH/cReND6lqryMrKTGlJm+/9Zos3vrPoskOw3Uf7iH
 Rv+COdgOMLK9Zpik1u1p2PuVYVl+APBSnf9Hw7aaUM+gQ6RvoJlyem21ueqX1u4ZFKTDVO/
 DB7Z8HO6F4+w2rXY3NTPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6Qn5bnVgGAc=:mCL7xW8618kbGqJ7gorYNI
 FSa8MHPlQbeSQjROQIG8pd9qchPFBksyCxhMhs4kkpx/6vcg+l6mEYy88yM/SgyxMPm7E954S
 HOdxOXCHSPmPuGo9knTE9EL2s3UEBahi9mOX+dgCQ3HoBa5lMqto82x6Fx3oRBYRh16xlSwWP
 y29aIgv3L2Qlz8nWM9DJftvWGojS6qIQF9AS6wQm+WKlLEUNedpIv1n1GtuFc2bL7TLeii/Oe
 vwrT8S9Zn1PLRBSYpf/JwYzrZ7TDCxmc9c8qpKMQg5jARDc42kVW90oFustde+zuUSvVG1lJ+
 FbL1d+W7dVyr6NMjj60/ZS8ZNrSPe9h/NeIQuy8/XQ/vZUugc0iF1BDcsB0aDv6VierBr4e8J
 LbLzapXdkUHD4j7QSxflCdVhBOFOP5mGp1bUwDcLRR7aqOmD8NFPxjPGvQTicuCRAJu/Iy26T
 3gKcgC892VQ+t9J8vXmuo4dMrOFLEiFQv8vU35vz0WtmvohbFbUIi3oDB4FJdmHW2j3vh3jmK
 FNF0pS6y0HKBddP8bK9luL2igFAVX+gpOU0gIeFbI1EdRvA1yR2CPC8+g3/zkiX0AiGRT2nRX
 WclTBXH7RlZXwieSx4+XVRsFuDKoqNXv46kqf4fL0jn0gatnJtn2x8CWAiTBAPgyDgzbp4eUL
 tvELaWmxyHXmhySphON5RLW7TvsCpbhvRTaecPN1xx88joLXLMG3rsQU1ctj4HC9bZsE6C4k7
 CA1ietTDyhOe9xhvs9aaSMgt+L8z0sC5XtYHnR2YWasl/phkzQFQyNLs3NHA1PqfbG5puDoOR
 Qbf0zpyy8SAVVKEVtnSkQaZCXXQCNEhZnd8/O1h5wTuT7SLq5Y8rgvOEfR540utX8hel8z/YY
 lMQ2IV4wHOR6bfwCbNzlN5pbGuXDPdlc5c4l0togU=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.24
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Tested-By: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20191021114857.20538-5-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c      | 6 ++++--
 linux-user/syscall_defs.h | 7 +++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e2af3c1494fa..f1ab81b91771 100644
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
index fa69c6ab8d01..7694d72446d1 100644
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
2.21.0


