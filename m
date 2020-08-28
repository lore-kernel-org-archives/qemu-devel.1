Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3C5C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:43:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65244207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65244207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBeet-0006KQ-Id
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 09:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBea9-00040z-Dh
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:38:17 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:54001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBea7-0007HC-7A
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:38:17 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MqZE0-1kyErW21iK-00mcpm; Fri, 28 Aug 2020 15:38:06 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 12/18] linux-user: detect mismatched ELF ABI in
 qemu-mips[n32][el]
Date: Fri, 28 Aug 2020 15:37:47 +0200
Message-Id: <20200828133753.2622286-13-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200828133753.2622286-1-laurent@vivier.eu>
References: <20200828133753.2622286-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nErqG+xrP5ehjIzp/14dthCCJVsrY4T3lftaSCNosmlNNcX8UYT
 FXYeaex3aqmdRKpGIbb10pjzh2PD/cfib8okzQ0+6dUKQ++xNHVmWfbCJyNvh0EgoKZu0Xq
 x9lMMyMjvKeJaiBGL9OQasJ8QH2RKfUiDsXioOY2PXUXDs7PZHVTw2YgWo2j40Pw+7v0FaM
 HpsHqExWHxbcR4uQc7gng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aocaX+l7jwM=:rr6Y4SevKA75oRw+gmrJcR
 JSQOx4rrGChdmxVGMBc8EQgR0fq4OThgg5tsfYo8cB6NLLigBU48d76hZOM7Y9ZsSwJk3f5EM
 Fn7O886oKhXd/1CIrfIV0dXY6SJsqte1dnKPlfFamib8/xWSte7sg0dxHuURtUrzC0By+2gRU
 VcokWoZto62HMJUc88sYmPppJBo4wmq2PlfzkEJtdWhFCLgjBigAmji09BmFDceBkM6La0jrB
 bSaPEJJwHzTx181DoNCmE8zgBqAiN9UDwjHXxkmoXCuAfvbUw2SrZ4oSb0rbAuf1eumRu9UgE
 d6PHu2jdqV4eciKkQThb4/KvV3G+xLIYQ4pZmBx/J8XG6witt+zIWksh6rE7XuPQxrWADcEC5
 dDl9VG4qV2SHzPilCNdERJftVmDUYMDAW0lX5anNRNnH4mUTo0Du6FEXFBJtWHSbp44J0RfH+
 mXSi9xVxjugL8mD/gyeLOG0dYDz4Gp4hFz3HlFV47BwT325lXxLjbsjReNcMfdmfmfy+JyOsu
 g2XNP0nqaWgLlc7FMWPxMvE9y/VigDZqpbywLEM8j2QzHdpBPyEnUmxryFcrqixN/JzOPQYe2
 TXkQjxGMLDc+nRkOaHptkJtqAKVSD0sk+M+kuFa46P2H1T6phstt2Y62T9cMwExiA8DQtCiaF
 A7K3SjqVpI8XFjv0/PYs7d9pWCnO+zNxPbtnmye0WSAobdbGbfd74MriYgG15nxBcQl7Qn/j9
 2gDIOir4KKUl8PlReVCOyHojzjfXhhmpmPBR2ZNwJiw1OhAaWHPYTzUnU9Fp5ZKdwKPNsAyo0
 nz+yzO/kSihZpAgrURH1vaXEbG1fgfb7GD4RetBhEKhKkJYpkh3ZusCCnssepMLO4IR1KYT
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 09:38:08
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


