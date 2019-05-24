Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D4FC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 11:34:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC33F217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 11:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC33F217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52809 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU8Sy-00047k-2s
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 07:34:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hU8L2-00060Z-Ry
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hU8L1-0001De-OB
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:26:16 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:37779)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hU8L1-0001DJ-Fc
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:26:15 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MTAJl-1h3z1Q1cSN-00UYZc; Fri, 24 May 2019 13:25:31 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 13:25:17 +0200
Message-Id: <20190524112520.17684-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524112520.17684-1-laurent@vivier.eu>
References: <20190524112520.17684-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yOFi+1/VS9lFfLHE3MmqVhmdwHuNz3e7O6H4CfrBLTkz8XQpfq8
	mgoK/P8HY1atfuEt0jtDqMCHKoVLqlE0thbcyQ84yPXmGPVJZ/AlbmvikS3n3nj6m2Gj5ob
	ddsnwUi//nfXDP90NyXttBNFy9o+my38OlI2RqgFu6wZHcyOLmVQfrMb8mwmfn3JVXgzCZ2
	CxVS2Pd6Uimt8DIglxRmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qPWGBI7w6Ww=:2UsWspFWLraJxPR9MCM7HM
	T3ufGbRYvxsSyRpZafksnpIOjVZFcNvmwRyanUOfEP67BKnwFa8D0FoBuIFoLnVuI00qIpYMu
	IMv5xG2iWNZon7M5VsZEQ0hJ6VqktV0GXDDz20VWuZ1tGXy1vF1p3OygtBBb++kpe0k3hYxrR
	KgEiJxNEOYfTGMPO8sLFDjr4YsstDL1sK9wA9hyqY3PWbutRRbdtB1up0GfL8boW3yezaKNra
	bedS3E+xzkBDr+gnnu7NKjh7eiR8d1jCypP4fuSaXWEyLtNp2wSb+Fhw5MOk+T1zciMVanExQ
	sDYsTkcBFaMOMyWW8+Ozu7HPedt79xZuKd81R5dNi4LuEpYnvLMdOFVdmTNa3cNgSlkr1jtYd
	xhfWNSRREGXHFSVx5gbo0w2TK5tpvpyTf9Zk0CsvL0RgCaEIBth42CYU/6MR//dkCpZne567r
	Ft4/qQfBEqJvwpS2Er3ll6jDW5ESIoClEqbdywTLs5CaaX68ou6MLvesJOIT0m3Ejwg2yanUV
	7mUe3+UyhQN/tY1pQlGkqvF7aYIKKCQApdm2WdLhGehpSgSGJZVWE94gAw4HRDv2ICglARSyp
	//PJLsDSU4OyNL00zmG8J2vBlYA3RSeTnyr4Nkl5Un0ifWuuSmD0nSNEbsa2SubRIGGPOiZW6
	i9fvAYN4e7N0JrW33whC7k65TOygGwC1cNQN/vVRONAAfAu1E/9tDbVaudWJFJ3vBOg73iLVv
	YG1s9mthOxf7dL3xQiA/TVgXcLwci1bnazSZb2k2uqqM9h9EF4sXrZXMltU=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: [Qemu-devel] [PULL v2 6/9] linux-user: Sanitize interp_info and,
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


