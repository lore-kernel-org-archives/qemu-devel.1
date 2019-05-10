Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE96C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 07:24:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC282175B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 07:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC282175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38260 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOzt3-0003w0-V2
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 03:24:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOzlU-0005oB-0C
	for qemu-devel@nongnu.org; Fri, 10 May 2019 03:16:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOzlT-0001lA-11
	for qemu-devel@nongnu.org; Fri, 10 May 2019 03:16:19 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:45747)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hOzlS-0001kV-OF
	for qemu-devel@nongnu.org; Fri, 10 May 2019 03:16:18 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1N7iKq-1gdL8x21jO-014nGL; Fri, 10 May 2019 09:16:05 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 09:15:52 +0200
Message-Id: <20190510071557.30126-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510071557.30126-1-laurent@vivier.eu>
References: <20190510071557.30126-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:owK2vc3S+Zw1Nlmut8ymxmTtbgoD+kYzp7L9DFd/pAjXX+mxpyA
	pujHFa5TnhOOpW4ML+bDkADDLoF67o3xyGhz6oAabkjv5aUb7vpNkURYGtLAa84pNJQ1H7K
	+2bePamZRCfmTT/9ogxTsXwscjsdj6d8nFxu4N/REzfBHsapeMZGTu61qrfoSoLLWpc3P7L
	+A+TJLyoPrauuBAlRwMCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xaT1F1bhi4A=:mf5Ib+j+dNJwtuzChqNqVP
	whV1x85qqLQE3ZJmS/DUTbiGSKVMHIEsB899VmcdGf5cyMrc1qRQFmkI0bvo53vla+rPrOVFO
	N8AgOpi87NP4bR86r5cBzehGQj9ALDEhfMO+j1nG5vUiWH3DbkbbLmbEbPtj5qV5kHP0Zd0Uy
	VUiTXg2yEg/TabXgFV3jhcZCe6/gc2dWY1zfnPmaOOfQMVaY9dDLu7XpJCqkj8x6bJLrrjAmD
	Ct5j713YZ9tbX8rDA+HhJTzfR0/URyCvbJcjTH4XRiYPrugQPgVZVqUNz6xkwQpnYDaZceplD
	q6IK1JY92Trz86bhr6J/4ImWq1WBY30Ud0nPig53z75PpABVg+/qa7n0vZAFQLFM+c4sqHKdz
	okyaIVP/oNlZ6fK4XoKE+0PH2/LyP1PC4ISNwVwaCFc05hfAptsbGV0YtU1Z/3Obs7Mkstr0T
	jLTBI6cWcWYtQfIUQcEf3hh6cezljI95Sf5WqPFCMZftF+bMV8XKfMTkO75mTLUpA7x3bpey/
	7wb6/jlPATA3MCdh55Szuw6UH94ogOdwOIYtex4ycsj5TjMAndqd4RL6AJL45RACzvezbIuJM
	xfotMTZrjP+/xpcR9TSbD/3vLwovhigarKr+1uFuG9xmwMqnMPm9P+Sz0XYiKZWxO53PIbkP6
	82S0bzCqGuxQzhe5CihpkSUciJ1+toWjSSjFocO+RJxtTTJ8jNBf54jiZlCqmBkzgrg0ay6dn
	zqqY3ADTm4OOfm0OjFW6u+F767qD9KK/CvHmffu7C0KzHi1ME86KyA5QFuI=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: [Qemu-devel] [PULL 2/7] linux-user/elfload: Fix GCC 9 build warnings
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Riku Voipio <riku.voipio@iki.fi>,
	Alistair Francis <alistair.francis@wdc.com>,
	Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <Alistair.Francis@wdc.com>

Fix this warning when building with GCC9 on Fedora 30:
In function ‘strncpy’,
    inlined from ‘fill_psinfo’ at /home/alistair/qemu/linux-user/elfload.c:3208:12,
    inlined from ‘fill_note_info’ at /home/alistair/qemu/linux-user/elfload.c:3390:5,
    inlined from ‘elf_core_dump’ at /home/alistair/qemu/linux-user/elfload.c:3539:9:
/usr/include/bits/string_fortified.h:106:10: error: ‘__builtin_strncpy’ specified bound 16 equals destination size [-Werror=stringop-truncation]
  106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <c4d2b1de9efadcf1c900b91361af9302823a72a9.1556666645.git.alistair.francis@wdc.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index c1a26021f8d7..d08fe2346683 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2872,7 +2872,7 @@ struct target_elf_prpsinfo {
     target_gid_t pr_gid;
     target_pid_t pr_pid, pr_ppid, pr_pgrp, pr_sid;
     /* Lots missing */
-    char    pr_fname[16];           /* filename of executable */
+    char    pr_fname[16] QEMU_NONSTRING; /* filename of executable */
     char    pr_psargs[ELF_PRARGSZ]; /* initial part of arg list */
 };
 
-- 
2.20.1


