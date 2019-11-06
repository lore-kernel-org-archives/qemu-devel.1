Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24806C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:13:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCB68217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB68217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSL87-0006yw-J9
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 08:13:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iSKzx-0003Yq-D8
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iSKzv-0002ys-Qy
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:21 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:57175)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iSKzv-0002y3-HF
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:19 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N4i3j-1hkzWM2Av1-011kB0; Wed, 06 Nov 2019 14:05:17 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 13/13] linux-user/alpha: Set r20 secondary return value
Date: Wed,  6 Nov 2019 14:04:56 +0100
Message-Id: <20191106130456.6176-14-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191106130456.6176-1-laurent@vivier.eu>
References: <20191106130456.6176-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sT58QnB+9d3LffVxpnM5Qac7Rc7XxNgy+jbm6hcpvpCOZtG5bCa
 Xk0r88/fTxQXxtQGImnrI0Juy3vZimxPwTHS2X5Rbj7FeZr39RLaLdNrHDZTBrDJOzlF1lz
 f7lExXIb919ZyTBKXsjAAF1GGgU3+Zr3qX5SQxbrzdiekbxo9c2unQUCI9r2JHgIVNZ08NM
 TIgV+ouom55nFs9eoodMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:85v3dB7Rzso=:aRwOqgolEVh7fzd222PCJ7
 4ZIEFhuVbHwj9aaaRbm8O3+49AsBoVe3NbWBl5CtG+DWT0sCEyiyT+pueSh8JnmGvM+qR4MlH
 VwU8hTPhYpIoLhPyhrSgZjnO25cAbS5tEZPhf1ZtDZereh7XNaBwQ3ntozyiZU/P7nOQSvTjh
 fQhFhQ2uWZ2I76etvxlzmtlyaEaxbYTZiznS5IOidiksU3gnG9oul2FmC84zqyxKrW8jT5Prq
 c/A5hbnqwDpu4Q5u1PtEwrlJvSJDdci8WExzIo2+6FtoFtSPaH3l89mJCjOsIxCAUUN9zIXIp
 JhMrsKug9xRm78/HCE+diyTewdT9WTyjoSgAdO4uHCtnhn6+8zQ+vfgT8HdhqQVN7NzBOQkEf
 ok6ydOkFYlBs+sJVT6s3OG2Atjt3Pnf34r+a5AvHFgvl4R0hzJ0VcI6n45ZgEpFSZ0X2+eYJR
 NnED1yu1c28dDBkqEHdl+1z4OYD68MG5rsHZqVQa5f3zyuDPYg9dxbOSoY4IT+Pr2ADq+6rq2
 /fiYfbkdAGYk80HCGt9X2keG2wIr7ZTK3Ur7L/LcBu2es7GM2LuhhGTlE4u12NZF5SP3D3zZU
 4ssejeP30UeYRfKZ3W07hbWXSspYdsSiq/BIYXBtCKs9H5+WNnQlA3RC5LGHcnOia15CfdrTc
 Lov7WUmRgjfErsfbcK8TDGtNefGkdb7eyIGr2PVkMLYOlANQWujgepK0t58xnDwIpxid/+xKQ
 KcusbiSYUh80Ex/1q75PHrT9BLNcmJ538cBbc3Q5Tq20N5nq+mrCZyB/Bz8KcwFkvRJnS6yiw
 fvJoe5Dvr8nRLXCwiGjoK92X9jCsJY+E7kAT4TbcM+72t+lDn0rKwewEjt0Nsm67swAPi1ggA
 pGVyAlJyMW9a25Srebqw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.135
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

This value is not, as far as I know, used by any linux software,
but it is set by the kernel and is part of the ABI.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20191106113318.10226-13-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/alpha/target_cpu.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/linux-user/alpha/target_cpu.h b/linux-user/alpha/target_cpu.h
index dd25e18f47fb..ad408ab5cc8e 100644
--- a/linux-user/alpha/target_cpu.h
+++ b/linux-user/alpha/target_cpu.h
@@ -27,10 +27,19 @@ static inline void cpu_clone_regs_child(CPUAlphaState *env, target_ulong newsp,
     }
     env->ir[IR_V0] = 0;
     env->ir[IR_A3] = 0;
+    env->ir[IR_A4] = 1;  /* OSF/1 secondary return: child */
 }
 
 static inline void cpu_clone_regs_parent(CPUAlphaState *env, unsigned flags)
 {
+    /*
+     * OSF/1 secondary return: parent
+     * Note that the kernel does not do this if SETTLS, because the
+     * settls argument register is still live after copy_thread.
+     */
+    if (!(flags & CLONE_SETTLS)) {
+        env->ir[IR_A4] = 0;
+    }
 }
 
 static inline void cpu_set_tls(CPUAlphaState *env, target_ulong newtls)
-- 
2.21.0


