Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A8CC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:51:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 937E020658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937E020658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDttg-00037R-NZ
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jDsPc-0007tf-6q
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jDsPb-00081i-5V
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:20 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:58519)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jDsPa-0007qv-SE
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:19 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MWR6x-1ioucO0HkJ-00Xvoy; Mon, 16 Mar 2020 17:16:07 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 04/38] linux-user: Add x86_64 vsyscall page to /proc/self/maps
Date: Mon, 16 Mar 2020 17:15:16 +0100
Message-Id: <20200316161550.336150-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316161550.336150-1-laurent@vivier.eu>
References: <20200316161550.336150-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:aZJhjr1SrOnsZQ0Eh7GbOh1xCz4COGGOOTZHp4QlnihexQ9KgAx
 OEI24kevWu/iirqAk5ty1OFeu53UcviEnp1PfguCVZp+MB/s8PSC8wHz4R1BYYRqn5+1NbE
 PDvMR40ZCB4qy58arwxydxR9er0qeCs3KOKOBim+wTOHAURPP58oGFH/IBx4nUnJbNC3ZKL
 nnCdQC5AIxJJjxKzMpJSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ksttNYJ3YiM=:RaSS9gfOnXm7Obg/KdtIYh
 /o2X0KsGwG+fnmVMVoTjd1cjpGfg97JaJ/Tei93aaKDhA+9quhMkOk5yqTavhnQLxiBYgcuVY
 SoT5X0lQKx0SaFzRxkLvWUfl7RUputVt7OqY9RefGOHnLA4UAZqdIZzG3hLIvpUV6NN21bR5S
 qH+ge423gqHd1tQ/KQ/iTih/1GK7Aq957Ls7NkXgauTtC4h8cXbaV+BJkKEGKlOe4FRsujaUv
 Ekxv2VT71kfLd0nRZIDHEJaQIAdtDQBNjaGziEoZshcFLUDpuy5NHrGZn8fnXEcKZiBf9PD+H
 8PcnNe8Cop38psjdLXynSLSn0yEIVsCz5dpmAkSKOfBMMk0whOn19jPQ7zH/GPClb5cXurpY0
 DUV6BbEkbq4Uf59WdYlOc1CQBRUsIsDp+8kFZyFbf4MyFl2nldER/CkTkQ80KebzVvi5bd2IM
 SiVbjm+2J+ufAEz8+AMn0cMMLwBZ4ytQv6jYKJXd17fbodoIhIQV9f0+k/6SNDiU+UcpNI6wY
 0p8M8B9vfB3hA4bUctTrHzjnlg+DSUIlyLM6I6YmjSCRh/3GE6n3YE6iarGnU4ycEzrnFaIHN
 DwmtKpHMN8BhzN5AMB0Cb2J0rlvNdlEFvYd6cLpuUVPFGdRhXcPiGutlBq6SbKEKE9IPuGwGK
 nSiZKtwjbnKWNurQZ0YTpaIRbCiAIcBz9zzI6NNQa+gjt5PAnIS+mv9kivhI4x+6QqpcZ/kMx
 JJk3zmYTIV73WSDutgellKeoK7IX44VD7MgjN+oE9QJhwvptUU+i+C8lTIKn2cfZC+4Ro96iI
 y75aRBDf0z7so6mPrISjNhDBrNhOSGRbX3sFRNUtzuE84ZdJ01AT/GEeOs+0ggmqNzYXkNW
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
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

The page isn't (necessarily) present in the host /proc/self/maps,
and even if it might be it isn't present in page_flags, and even
if it was it might not have the same set of page permissions.

The easiest thing to do, particularly when it comes to the
"[vsyscall]" note at the end of line, is to special case it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200213032223.14643-5-richard.henderson@linaro.org>
[lv: remove trailing whitespace]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8d27d1080752..5479d67a10be 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7079,6 +7079,16 @@ static int open_self_maps(void *cpu_env, int fd)
         }
     }
 
+#ifdef TARGET_VSYSCALL_PAGE
+    /*
+     * We only support execution from the vsyscall page.
+     * This is as if CONFIG_LEGACY_VSYSCALL_XONLY=y from v5.3.
+     */
+    dprintf(fd, TARGET_FMT_lx "-" TARGET_FMT_lx
+            " --xp 00000000 00:00 0 [vsyscall]\n",
+            TARGET_VSYSCALL_PAGE, TARGET_VSYSCALL_PAGE + TARGET_PAGE_SIZE);
+#endif
+
     free(line);
     fclose(fp);
 
-- 
2.24.1


