Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D0FC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:47:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9608520674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9608520674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtq1-0003ml-PU
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jDsPW-0007s0-SC
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jDsPV-0007A5-Rb
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:14 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:33739)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jDsPV-0006zr-7Y
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:13 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M8k65-1jI1HP0mQ5-004gec; Mon, 16 Mar 2020 17:16:10 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 06/38] linux-user: Add AT_EXECFN auxval
Date: Mon, 16 Mar 2020 17:15:18 +0100
Message-Id: <20200316161550.336150-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316161550.336150-1-laurent@vivier.eu>
References: <20200316161550.336150-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5R+rosIIZqp4x+AWEBJhCWkTQnritmsp1GCrgjdkNp0r9j7M2qd
 Fpe5OxSdENan4w1x+6Je3h9DAu8lrSl6cWpuelUSAdDChMmDETB/UEXWQdCPBIr22ViG1V0
 lDPNi+3G6vmxHI08oCn8aHZiY1GGB0MrmE7czPb2Q50IDbHkLZv0YJ6aJMOr8PxlSpk+l4p
 KOP3HOWAY5nbR7TARsXgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nykbyp/CenE=:lndPYVXu8QLgV+0fNHOVZa
 aQORoa0iWOho71WoOmiTaal7shXg9g5Vl1QmF4r0HbdudU88I0b0ZVxvgT2OAfnjHCOHzGlpD
 jmgNyKrBCZuSjzdylgne413u2qmUiuYl+V213vKRuSFwhbZoAlj7ZKb1FDxak+kwcrZ2dcLhU
 NmTQ5R4s9GZoyeEcgkPMxh9tK8dfe4R+CgryxwtOHasIcCYnBx1adqlvwswAMgYw9YyrUIfnk
 ZHwBharQGj4bELOKsdd4JFwBmupsDgCizPw/wPGaP8Oskx4PrSwFXfabMFEFwqs3P1qpP9ZzW
 uIfuxr6lGbRttiZV01RR0k0EAihl+sYhDUUuwXIDIEscp270LqIhuHIciLsr+kR+8S1bREsSP
 TBGWfNlqsTELX4+vAlbJ270mY6ci3eOL8FlWGo0wm+NeT+keksBjejPkntKLIf22f0+PbJt6H
 22WidEmLi7JctGN7USLs/QZYrOavVE27hQWvqD6YTMSLSCKT616SdwFiC8uzqBecwEviYn8Lz
 lpEINyz8IXxGk1THu27vuyOQexJWMD6auvdjaSDzN681O0sH8PVoS//uE1ovgK1Gs/5QnRwfs
 6Affz16Z/M/bZsTyDj//9cnnadEdxzOvWOTYKsg1fCUVIO+Arnx2EDYJ+P0jnzEaEaxjVYtUY
 XjvctbqfjSj7U9Vnq79GkBoVC/NWkckgMypAuIgWZNxoFk6vF9LbvJnzgV9NO4caOtRaF8SW8
 Cc1gGtFNoxrxSs4iUh7bsAyDSbBHzNvGq6n4XR1obvPSOSL2tEd4WupCjDlTjAopGRcKTqlk+
 DmFZwRJ1WLwMZkfHXvzbEIAOluLyFXs/pnBC2jNJA1lbq6EkkM36CO3FoMnmhTmjEWAF4Nb
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
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
 Lirong Yuan <yuanzi@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Lirong Yuan <yuanzi@google.com>

This change adds the support for AT_EXECFN auxval.

Signed-off-by: Lirong Yuan <yuanzi@google.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200302193153.66415-1-yuanzi@google.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index db748c58775f..8198be044604 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1573,7 +1573,7 @@ struct exec
                                  ~(abi_ulong)(TARGET_ELF_EXEC_PAGESIZE-1))
 #define TARGET_ELF_PAGEOFFSET(_v) ((_v) & (TARGET_ELF_EXEC_PAGESIZE-1))
 
-#define DLINFO_ITEMS 15
+#define DLINFO_ITEMS 16
 
 static inline void memcpy_fromfs(void * to, const void * from, unsigned long n)
 {
@@ -2037,6 +2037,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     NEW_AUX_ENT(AT_CLKTCK, (abi_ulong) sysconf(_SC_CLK_TCK));
     NEW_AUX_ENT(AT_RANDOM, (abi_ulong) u_rand_bytes);
     NEW_AUX_ENT(AT_SECURE, (abi_ulong) qemu_getauxval(AT_SECURE));
+    NEW_AUX_ENT(AT_EXECFN, info->file_string);
 
 #ifdef ELF_HWCAP2
     NEW_AUX_ENT(AT_HWCAP2, (abi_ulong) ELF_HWCAP2);
-- 
2.24.1


