Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31707C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:26:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 086F124125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086F124125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuXpI-0006Nc-P6
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 03:26:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iuXlI-00011S-2G
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iuXlG-0002t7-HG
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:47 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:43277)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iuXlG-0002oZ-7v
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:46 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MQdpG-1jI6E008HO-00NgMR; Thu, 23 Jan 2020 09:22:34 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 01/17] linux-user:Fix align mistake when mmap guest space
Date: Thu, 23 Jan 2020 09:22:11 +0100
Message-Id: <20200123082227.2037994-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123082227.2037994-1-laurent@vivier.eu>
References: <20200123082227.2037994-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qn6JMmYNdNfmHxOlpWiAP26Rna0EFvuX7k+7mR0zyHjLMOqIqmj
 x5rG3dVEp5JExxAcqTw9oOMaTchKpDUWX8gECl7qqtg2uH1Jp8NmxMyUG9XYf0/QqI8tBfc
 FdML4G1/VpDuqGhWqCUgdEIzFvgic0c1UhF2tSuo7fz6IPYmefvaxieUyWllBgXxeixIlT4
 TyKtmyY7xhQV8nt2s9x1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z6bhkNrDhUw=:ked2FmQBb06bKKCDfROfk5
 uFUBR9SFI5GAzwpA+eNP4b59ahjuwkJ8o+7p88GDLTGLooJENDymIkfq2anMZQWFEh4RuuKHF
 kupz/WqgQYYZGzGSTa+ZyTZU9S4zM0vKvXgM0OaaSov7fRdp5TGy4ufxPW3MwsVwivmlzFJOW
 8mTecrcN4ex23q/TN/QXnuiFwdvUbRq+LnKG2it1CoxpQgzhci06ceeyCbu9NhiPxY+5exDgW
 rEPgSfRR4H4o/XVfUbIxibQ1BaCM+wVRQlDWg/HkckmkcIA9Y96qb+kjtn/iHn8FKlhUE1yQS
 NPjylT9QNH9M2QQlW5yAfqb2zt9O0jGSvEW0wMgCQPujfVWxoXAjk5ioofF6HBqw2/Td8mf6P
 gzF7a6xCiOgv9sdDV07P69pJDypP1bDEVuVg8/4PNoAywPcXiOjczQA7ru0cLBOfZBt1PSE64
 EjVA2udj8WdCU6E6irZC7NVnXKrNUqjNy/Y1AZoHNPcCb4m1t95SmQ0rgaIZ5K84IsGHOlW+Z
 YVuncRzC41kend++UoHxTtEd2VyefMjL6vhp0McI8gV2ZBfd6+RqPpBt1DwuulcT01I75mwwM
 0cQp+SryIzV6GgegB6UI/6s4SJ6ZuEBrohOgxf7byd/0u4Pzv039kVTsC6IPiAKfKiK/NGRxd
 TAqzpXoNkOFmHVKH+bI2i1y25p2WjSMMr9yxHHzka8A32PqhT/e7BflsNeuyM55B58+weSMSW
 nibrXqnSgLd9z1BMrqltdUYaSw/YgWQF1eXekNrLR9coUrDO+SIrlO/5AE9MA4n0iLM0kq1g3
 fIrO6FMDgXxu69j1huTxjXLmCleBk0ktoQza+IsCLX6q1z+6+U=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Xinyu Li <precinct@mail.ustc.edu.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xinyu Li <precinct@mail.ustc.edu.cn>

In init_guest_space, we need to mmap guest space. If the return address
of first mmap is not aligned with align, which was set to MAX(SHMLBA,
qemu_host_page_size), we need unmap and a new mmap(space is larger than
first size). The new size is named real_size, which is aligned_size +
qemu_host_page_size. alugned_size is the guest space size. And add a
qemu_host_page_size to avoid memory error when we align real_start
manually (ROUND_UP(real_start, align)). But when SHMLBA >
qemu_host_page_size, the added size will smaller than the size to align,
which can make a mistake(in a mips machine, it appears). So change
real_size from aligned_size +qemu_host_page_size
to aligned_size + align will solve it.

Signed-off-by: Xinyu Li <precinct@mail.ustc.edu.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20191213022919.5934-1-precinct@mail.ustc.edu.cn>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 07b16cc0f470..511e4500788b 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2191,7 +2191,7 @@ unsigned long init_guest_space(unsigned long host_start,
              * to where we need to put the commpage.
              */
             munmap((void *)real_start, host_size);
-            real_size = aligned_size + qemu_host_page_size;
+            real_size = aligned_size + align;
             real_start = (unsigned long)
                 mmap((void *)real_start, real_size, PROT_NONE, flags, -1, 0);
             if (real_start == (unsigned long)-1) {
-- 
2.24.1


