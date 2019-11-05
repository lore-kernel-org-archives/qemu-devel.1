Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC28C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 18:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D2B1214D8
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 18:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2B1214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS3P9-0005CK-NY
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 13:18:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iS3Is-0005yZ-Jm
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:11:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iS3Ir-0004hw-Er
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:11:42 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:37959)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iS3Ir-0004h5-5n
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:11:41 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MORR2-1iIkPq3Dsk-00PuA3; Tue, 05 Nov 2019 19:11:32 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 09/13] linux-user/sparc64: Fix target_signal_frame
Date: Tue,  5 Nov 2019 19:11:15 +0100
Message-Id: <20191105181119.26779-10-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191105181119.26779-1-laurent@vivier.eu>
References: <20191105181119.26779-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:aaiuIS3g4IUmiBZLTQ3MtB761qKtMPZvu9Wgucdg87lqHFiHQ1o
 nFSTQ41vkPzzPB/X6Ij7+2XjrPve9bTDmbTXCNPPXmkU6/PAE0zMma3YuJ3pXiINDZEZ7gA
 DRIt52K8L5DY3WC6vRaHAJmeUda3C468u5VXmjwOUzMgjThXKEjyUkRE1F4zauLkKVggIQp
 F41N9qinFnWYVl+nzEheA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1T3xwkgqo/I=:Uo1qkAcGUCQd+A8p5ckc3I
 mbjHi1JyCOnCeN6WfyFXGI3zT2z3STAa99StNIZDGSGWN9HO0wfYPVGYQYdk/9SPUhN3LeM4C
 IqTs0cGctopxEK8rlk2i3cTy8/muZIlH5bHA3Hu0hQbExqSQ3GMTBrAn18pQ5uxZ8ZjCep6rs
 zv7ZMWxRIJslMgNw5WXnPg/0bpdbjkOgi32sn53qF61hlOg3k2tWzXtSsF/6glbODaNFAHfnw
 kBDU/QroSAZuBkvvkYcRhAfY2Y0hGwxgXs3P07wgfUZxIBMZJH+9SRn4zm7Kdn8DyfVJk+Otn
 HxRoYKuC8USA1AnGLr2+vpW12vfkphfjQG4kzBkbM5DZYpOwH7CUreEnAyucuzG5+eda9LfsG
 3QLyDx6eeBdTSawNUjRxsYL/P0LJGIHASuDwRzVQ6OcfCwleW2YeNR1EQbgpbJoQ424CckEdP
 YjVJ8alJegk10oMb8wtj5E5bXrSpH5k6TlB/Pbd+uJVTJx+dAUYlBxFKCeRLFIz8fqO7Ed+Ld
 V2NjMFctHSmLUvAVPRxvZ53Use1kPAJB1eEHilPf8MXVF062BgUiRH2ikijH+a4kz9aWFW1LA
 qrIulBCqdoThj/Ku80uF3EE0Fo23JH7A8AEKC4n+GhFmq9Q5cEteZskncCHeMuAhbwsiJXDKi
 WTurMVT4Q2EMHKPeedoHe3xpuTS9lQJJxU929GqasxFedT2+AGFjXsIsug/d1rADBax0wl1za
 PgiKBEEoAC+bu0hw6fW1NUyjhWI4PjkL2yHVHOz4NnWFDxtCPnSd48ybW/ZGGtJAFehATnKey
 K4EVeDjaQV8hrUaf8NTLy94A7vLV5XYz8vcGjeYaiYR+dx4RksENZuCffPcoawvUhVJEU3AEK
 weFWfuJCh53R3pyT6eQQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.73
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Instructions are always 4 bytes; use uint32_t not abi_ulong.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20191025113921.9412-9-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/sparc/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index efb0df7e2b2d..ecfdf937e47b 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -87,7 +87,7 @@ struct target_signal_frame {
     struct sparc_stackf ss;
     __siginfo_t         info;
     abi_ulong           fpu_save;
-    abi_ulong           insns[2] __attribute__ ((aligned (8)));
+    uint32_t            insns[2] __attribute__ ((aligned (8)));
     abi_ulong           extramask[TARGET_NSIG_WORDS - 1];
     abi_ulong           extra_size; /* Should be 0 */
     qemu_siginfo_fpu_t fpu_state;
@@ -98,7 +98,7 @@ struct target_rt_signal_frame {
     abi_ulong           regs[20];
     sigset_t            mask;
     abi_ulong           fpu_save;
-    unsigned int        insns[2];
+    uint32_t            insns[2];
     stack_t             stack;
     unsigned int        extra_size; /* Should be 0 */
     qemu_siginfo_fpu_t  fpu_state;
-- 
2.21.0


