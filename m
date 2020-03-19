Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF94C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:27:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B262A20753
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B262A20753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jErSq-00079d-T3
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 05:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40870)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jErRv-0005MD-Hj
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jErRu-0004D8-H3
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:26:47 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:39709)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jErRu-0004Ch-7o
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:26:46 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MdwRi-1jokQf2xF8-00b143; Thu, 19 Mar 2020 10:26:35 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v3 06/16] linux-user: Add AT_EXECFN auxval
Date: Thu, 19 Mar 2020 10:26:17 +0100
Message-Id: <20200319092627.51487-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200319092627.51487-1-laurent@vivier.eu>
References: <20200319092627.51487-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3xiK71eCnLP9OVwnkNfXqn1RhykFYo0OKb+RbwyTZRLRs+4jXSj
 zihILX19+8MzJbkP8mKelVuVPlqLFCr6VoP9U6J0QvRndfxpHEZIUnHooZVtuPcU6IZ6bTH
 yMZMAJLzt1JsnyOF6Kmj0dm8JprQRQkiqLJKPWDzHLaQKQXFyN04bo8fNk10WJ0jJOPw2so
 rPq+OZqnBlIBbvMif9zvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WsIW9bez7L4=:DocxGW5Ac1Z5JsB5KUTcoz
 ld4AjfpMESzpi7bf2GikzEWH+GYeHwT0bSHykI9DvTrLusoVK0pMtnV6OhXTuxa/XMGGjixzG
 /6sDFZiiLbIL+NoU6K/w48oYuFFlRDKN7GTeNp6/ku8o80VXrB+GwmDltjqZhyYRgKYREOhyP
 MCVyysUwfVJjN7kg38RN+0Z2vuYYZoOifAPZA/crPy0LZ1VLcJ24PXm+0Cg6dauwxRv49PjrY
 R6lvKC5AzZIof6GYkSXm89t/RfVRKTeXM6Hsg+ylmviC/E5wjY5UrZQNX97+kWPmHKd/TJlur
 JdEK2Q9Oca8Tn+2mJ/cHjXgbS54ed7aREwlwlAsaEnAEoxFOGk3ywZxQKnqQq8m8ZYsIHONfP
 WU5IX8w4zmv5j2bbTBqws//s2OpB6933ahQ4lAgsUbGSJpi73Cuv0afw+nH/j+ZQzfow1KOcz
 Vd+tg5r8PlRYlfJx5x+b1hT18wRh3fa0nfAiGyv/6vgErrHSbX9IZXlnEpwqnVM+Fn+unerVL
 ApYsdofO0Lh8HtAqt8Gag86dBM9f13rHIpENP4Ez0w+oxknOOv4UbK2hQMsSw/GwGgNmBfZL3
 wTRxAIJC93G4h2RcFO8sAf6kYnfKMADqpNjWE3tDnIFqPqS0SthrucOtN9fQow9O7/eswi4FF
 VnM8145VOOD1+OQ/6sNiT0/tGPSiOO3cL1Xuz/f3ce5dYiDwX8lPw10InYdxIhgaabwavDhld
 Vec0D3bzB9c+ocPGCrnxxldIc3UdEgwzxsScPbLqvmIqD34TZg/j/73bkEakU/vzbI8rviSo/
 jxJRbW4xmtcb34S9dGcn9thkjegWdPyZKRz14YzFHZ/pfLBzMA/3PdjCgRDskGdgp7lMuY4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
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
2.25.1


