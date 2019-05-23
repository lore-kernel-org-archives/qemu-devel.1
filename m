Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A620C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:54:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 615AC20863
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615AC20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38192 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTp6t-0003la-MZ
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:54:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hToxI-0004Zb-Bv
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:44:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hToxH-0006qD-3t
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:44:28 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:34027)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hToxG-0006my-R7
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:44:27 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1M4K6z-1hU5vU2RAv-000Ikn; Thu, 23 May 2019 16:43:45 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 16:43:32 +0200
Message-Id: <20190523144336.13960-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523144336.13960-1-laurent@vivier.eu>
References: <20190523144336.13960-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vOPW+lduhkMebW1fHRlZBTEPg6cT0dAhKXzKtqUnbIHrrP3DNkA
	TBwRphh/4P7VQ60+fZwOOYgVVKjmjeRrBQYf+5qXV3Fxac2qlHIEvjOMukNaBFBA6FqBawe
	KNTslxmPuSMSAtpl0Kci/dfFujvg7MizL5Ua8ulav55z1Yg90Jd4CVBhg6bZFG2IYcHybNm
	mHRAx/EP3/QyiQ2JkW0Rg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FYtVsMceus0=:T/Y6hMlhLGucsEs2z96vGe
	Hj5uJaElewe8F3qnW/dSliBKKGrImbeSH3D3sD+HOP7Cq1/Wq/Xbj8ow9vCBdWbEEieOpdmBJ
	Cij/7gxXm/zQ6zIvcVPtzoAlAZFW03z3HzVCc0LkXVQaNiILCG0Al5sn5gom4veRoWj4MfSV8
	XJ3zNlROj1qsW5mnFSp0kuaCR91RccIhW+Xzf48f+WG9YDRhQBCeHa9PdTAO6Z45S4+x8rq+w
	DciynQBiQQa9AIiTYtX8p0bX1f99ktbDWG2gD2fBYYvD1LIQZuLETqOjgeXRo9kvBLukBTjLs
	AlOUkavc7XQE3brmLP3mxlvcn6XRUz1ELokvj+8DxDYO6ibHpPx9IHTCpJJNBNLKQMUG/6Qjn
	w/YRd7l3fx7oiKoeVBF9eVHYPf3iv7+7l9MXJt/XIWDv2HuKDgf21mRu1A/G/vbQb6wy0HdXR
	KwO0eFm52HGUUsFNSpiNtPcu7t6Z8XuRHFdYDek7ONn0u1OOHlMX5xuiE8KpHZaAp3AE4Qgbh
	HmosTN46/mqrRJRepdfLnE6f4C0zIbCIppUm/J+Zts2W9o2/oYkO96AdylcuU//tTyOW8koAx
	fsdlOFh5QlKk2kKgEkZB1GCNCMn46Xj8fH0EaQcHUHGAY2cGQaQ88uFZWMq3KQ1sl8mLRJL29
	OvCaW1UlauOTuNr1/7hMhl9DWNLn8TN2QyVIUPsTLpS5Axah17PlgWpKnipQFjA91FNfpis/a
	OX7RtB8/yq0pWD113D81ICxe4yt3GDCONEOvBS/28ZZxIy11L5macLsHS34=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
Subject: [Qemu-devel] [PULL 06/10] linux-user: Sanitize interp_info and,
 for mips only, init field fp_abi
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
	Laurent Vivier <laurent@vivier.eu>,
	Daniel Santos <daniel.santos@pobox.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel Santos <daniel.santos@pobox.com>

Sanitize interp_info structure in load_elf_binary() and, for MIPS only,
init its field fp_abi to MIPS_ABI_FP_UNKNOWN. This fixes appearances of
"Unexpected FPU mode" message in some MIPS use cases. Currently, this
bug is a complete stopper for some MIPS binaries.

In load_elf_binary(), struct image_info interp_info is used without
being properly initialized. One result is that when the ELF's program
header doesn't contain an entry for the ABI flags, then the value of
the struct image_info's fp_abi field is set to whatever happened to
be in stack memory at the time.

Backporting to 4.0 and, if possible, to 3.1 is recommended.

Fixes: https://bugs.launchpad.net/qemu/+bug/1825002

Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1558282527-22183-6-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ef42e02d8233..02832adfbc0c 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2706,6 +2706,11 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
     char *elf_interpreter = NULL;
     char *scratch;
 
+    memset(&interp_info, 0, sizeof(interp_info));
+#ifdef TARGET_MIPS
+    interp_info.fp_abi = MIPS_ABI_FP_UNKNOWN;
+#endif
+
     info->start_mmap = (abi_ulong)ELF_START_MMAP;
 
     load_elf_image(bprm->filename, bprm->fd, info,
-- 
2.20.1


