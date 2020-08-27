Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C520EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:28:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EE80207CD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE80207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBNZo-0003PE-TM
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 15:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBNS7-0004Gr-8F
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:20:51 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:51841)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBNS4-0000Hj-NC
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:20:50 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M26j1-1k9SZi438j-002YDn; Thu, 27 Aug 2020 21:20:40 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 12/18] linux-user: detect mismatched ELF ABI in
 qemu-mips[n32][el]
Date: Thu, 27 Aug 2020 21:20:12 +0200
Message-Id: <20200827192018.2442099-13-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200827192018.2442099-1-laurent@vivier.eu>
References: <20200827192018.2442099-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3a5cuka67oPdds3oSYa2QogLjTh7BMJaWm8nEX7axOnKbErVT+y
 KMaBf2RC1lqP4dHHdQHqkYpcZAFb5taHh6poQzRYB8eE5MuLzwSnOeWDMvoX2uE1vX3xGwu
 +C/1lnQVq85WX1krLD0qtUBIueMKNIeRQMRcnDpmocyTAIeHVBp/+vozMXU9bCTogQwreCW
 oenu5tRfvO+6ufsOwvK2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cNgmMd3JTFs=:lGhZnAP5N7cqL++s3PriZf
 PFigbpeWjyBwwiGN/aapMjA6jk+c3dGQev2Gm2jrls0VvizWstEcF1+ws26apOAWF981bFFlX
 0xVEfOwxNCyOjllHuyaJTBPA6hr5YcfW9si5CIGXPTI0We9Y+NgnGUhr8lM1rRFbKJcypfFHx
 GfUeLZlGyHEzTzY5Cue/ng9/7GEDI/8pE6W9J6gomrzouhyblj1dUtCyKbw2gqHEXLAk8P+9I
 B9koHu+wndxg/hxu87kf7fyNL5QagNi6vBdhg+/nSyqHS5kDdygKxf0s4vBTn9QuGuCEKiLhJ
 cx/SyVZEQbKcJopt4oKgh1XGmgTOCtJPvhd6nDOQeuCwvJcSI6ygm8l+AvEdf4omNIutgor9F
 XGwCGgldSoBEE7mQuwrErLQLQyJjbbiomsagY/tQhL7mWr0SjfXNmiO2awqwHdsr4UjglKnlD
 AUQNYvG8bUimXDZXNYlTyHY/9+PUBUzLlOiEYp9Ie/yzYMEK7RbXAWjSlVUnbjtGuAHI1XhLj
 oYBdSkP/lA93GkTmTxDMYTBjxco8gTKVDptS5YKgkQEL3vsn/xa8DgeDnB1Q/GeV9J9UeE3cy
 tW11avF//8Xd8mUSe85j1u/QlDp7K6El5o2YZZG9hynLxQhUhoyVlJSWHpl81wEhj1Aisb8lW
 YIyOoWjsH9f9LTsVjAUtgyvcM8ILjdyvulvYyaDoYN35TH6uDWr3OyzVnDGFGLowuHnPRfOH+
 ZzKMCsbEq2D861u3DBxAizlPgL20NS4SRHHCepFVDYJrcBUcluTXScXgc967JT2illSTcnegH
 /jZALvoc/l8JegYJX5IpgsGXPTYknlodJxB/9NHxF1D8KuxHX9wnbcJK7SlHvu216b8HR8e
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 15:20:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Carlo Marcelo Arenas Belón <carenas@gmail.com>

MIPS provides 2 ILP32 ABIs, and therefore 4 possible qemu-mips binaries
with 2 pairs using the same endianess and bitness.

This could lead to an O32 image loading in the N32 binary or vice versa
and in cryptic errors (if lucky that the CPU doesn't match the FPU used)
like :

  qemu: Unexpected FPU mode       (o32 ELF loaded to qemu-mipsn32[el])
  ELF binary's NaN mode not supported by CPU    (n32 -> qemu-mips[el])

Add an ABI check macro that could be used while checking the ELF header
that relies in the ABI2 flag to identify n32 binaries and abort instead
early with a more descriptive error :

  Invalid ELF image for this architecture

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200823101703.18451-1-carenas@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index fe9dfe795ddd..69936dcd4595 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -918,6 +918,12 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUPPCState *en
 
 #define elf_check_arch(x) ((x) == EM_MIPS || (x) == EM_NANOMIPS)
 
+#ifdef TARGET_ABI_MIPSN32
+#define elf_check_abi(x) ((x) & EF_MIPS_ABI2)
+#else
+#define elf_check_abi(x) (!((x) & EF_MIPS_ABI2))
+#endif
+
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
 {
@@ -1487,6 +1493,10 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define elf_check_arch(x) ((x) == ELF_ARCH)
 #endif
 
+#ifndef elf_check_abi
+#define elf_check_abi(x) (1)
+#endif
+
 #ifndef ELF_HWCAP
 #define ELF_HWCAP 0
 #endif
@@ -1644,6 +1654,7 @@ static bool elf_check_ident(struct elfhdr *ehdr)
 static bool elf_check_ehdr(struct elfhdr *ehdr)
 {
     return (elf_check_arch(ehdr->e_machine)
+            && elf_check_abi(ehdr->e_flags)
             && ehdr->e_ehsize == sizeof(struct elfhdr)
             && ehdr->e_phentsize == sizeof(struct elf_phdr)
             && (ehdr->e_type == ET_EXEC || ehdr->e_type == ET_DYN));
-- 
2.26.2


