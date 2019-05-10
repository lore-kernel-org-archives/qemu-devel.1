Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CD1C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 07:22:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77A98217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 07:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A98217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38243 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOzrC-0002UJ-IG
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 03:22:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOzlS-0005mo-IC
	for qemu-devel@nongnu.org; Fri, 10 May 2019 03:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOzlR-0001jv-Jc
	for qemu-devel@nongnu.org; Fri, 10 May 2019 03:16:18 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:52555)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hOzlR-0001jB-Ag
	for qemu-devel@nongnu.org; Fri, 10 May 2019 03:16:17 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MaIvT-1hAT2I1WKb-00WH7u; Fri, 10 May 2019 09:16:07 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 09:15:55 +0200
Message-Id: <20190510071557.30126-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510071557.30126-1-laurent@vivier.eu>
References: <20190510071557.30126-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:h4K/Muix8nnOwDYsE8KmBPWIKOFAWv/R08FoTG5nkbPg0twbLH6
	ts2MLG4HJ1ZvWs03fnf9VgPT3dijKAW2YyN0w7rgXLp4pY1C+CnXZZaaLZBz7MRN1ebK5dq
	GoxIiCSj2m4YdZJq+YIZiPhKugG+Hj2k31o0uNHhX5Hu3m6bnjamu6ybvzGTXUualvlpk25
	jzNI6RHaMfPjCF0yZBBzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NSI+UmOAKto=:Xt4sAnAwAyhn6puOUhOoZA
	M2u/+iDSCiv9xbq6DgTqlguI4bbX7RcmHmCqZzwFUkqVZ0MmKGs5ozti1+GcqH6nB6Qixb7q3
	D3hnYHpV7pDGUqTt2iPG6Bqhp/mbEolhpTuA2RdyofqWtoikIbqTBPyVDibS5rqBe8lvFX214
	NgMSuw8NVU8nJ5G6cH58XNBzaNS+QWNCuMb5gLhPo0HH1xoso8dsuliGgEt61Z+pq0dr8hh1P
	YTWIeEt4I1omTQzeViPP+T7x3k3irqf9+m9LanWgrTxN8BqDcMUtMjRxwabyHwCN9sezGUr6B
	fFWt6U+A4y6mksvsOCBBiiCPANVAh6JO5TsSAj+uBis/pdVcxELdrun5hI+B195ja6Yb9aAnC
	33UAoox80w8ck1K4cSlweiCZ8sIV8euQBZ164oZJrL9ZN6euYZsTZGDveDC/N0rq0Ou5AlEys
	zq4XAjPJE50AasaA4nzYee7l5VAMLR3A6skZlQxg026TZ9ZgJcTYTZHRlJQdEN6c2hPHOTOjV
	CfBIcbm3UoKTrwcnCMUdpo4rkmNKTxpk+YuwS2SIuFjUPUojhHVoef3grol3p9LNUgeLRaWXw
	0VIIVH3njBuGKZ20BdbE5ARsnREd96n9EIZhjqE/eCIB/yzrkjK20abL7PRqOTFu8A8byIuTM
	KYZnqlDHbOCsfJVsnWB+zE3YPF52wRGK/gkVQ0i0I+O8LOCh85ivING5BmgB9X/tNf+tVRcB2
	cAr5KtAB5bFyFcWuqUUqoVds2UNS/Us2Jru43w==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: [Qemu-devel] [PULL 5/7] linux-user: elf: Map empty PT_LOAD segments
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
Cc: Giuseppe Musacchio <thatlemon@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
	Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Giuseppe Musacchio <thatlemon@gmail.com>

Some PT_LOAD segments may be completely zeroed out and their p_filesize
is zero, in that case the loader should just allocate a page that's at
least p_memsz bytes large (plus eventual alignment padding).

Calling zero_bss does this job for us, all we have to do is make sure we
don't try to mmap a zero-length page.

Signed-off-by: Giuseppe Musacchio <thatlemon@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20190503122007.lkjsvztgt4ycovac@debian>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index d08fe2346683..ef42e02d8233 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2366,11 +2366,19 @@ static void load_elf_image(const char *image_name, int image_fd,
             vaddr_ps = TARGET_ELF_PAGESTART(vaddr);
             vaddr_len = TARGET_ELF_PAGELENGTH(eppnt->p_filesz + vaddr_po);
 
-            error = target_mmap(vaddr_ps, vaddr_len,
-                                elf_prot, MAP_PRIVATE | MAP_FIXED,
-                                image_fd, eppnt->p_offset - vaddr_po);
-            if (error == -1) {
-                goto exit_perror;
+            /*
+             * Some segments may be completely empty without any backing file
+             * segment, in that case just let zero_bss allocate an empty buffer
+             * for it.
+             */
+            if (eppnt->p_filesz != 0) {
+                error = target_mmap(vaddr_ps, vaddr_len, elf_prot,
+                                    MAP_PRIVATE | MAP_FIXED,
+                                    image_fd, eppnt->p_offset - vaddr_po);
+
+                if (error == -1) {
+                    goto exit_perror;
+                }
             }
 
             vaddr_ef = vaddr + eppnt->p_filesz;
-- 
2.20.1


