Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1657EC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:02:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E52820409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E52820409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDu4E-00058g-Ms
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jDsPb-0007tI-5C
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jDsPZ-0007no-Ql
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:19 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:49757)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jDsPZ-0007d6-HV
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:17 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mmhs6-1jcRnQ0xeA-00jqdF; Mon, 16 Mar 2020 17:16:02 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 01/38] target/i386: Renumber EXCP_SYSCALL
Date: Mon, 16 Mar 2020 17:15:13 +0100
Message-Id: <20200316161550.336150-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316161550.336150-1-laurent@vivier.eu>
References: <20200316161550.336150-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Hg9TaecfWGqylFxCaSMjU0Xvv3kM1cHLMv3Dww2adAN0L0Nu5K/
 zxDvSi0i6WKP0yD7r5WDdCJeGGzZiwnWksXUKXn6p/+oK8EI/taRiGkl9jPMwbyLpbmD+l0
 n8qtAdHBo0UokEQQrWQzF3H9+uUXsoi7Pnv5SgAlvw4zSR2limoKqVvHMXkQSe05JPM36fG
 pIUeFUjXJnsH3pebM/fMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OPgmv/Ops7s=:Y24l7FXX7NrVtDsUpGnD0I
 YJPqMXb5VezVkjzt+PiVagokymx3AWYWHQwVfxWUH9PvwaXCVtPzG/qdAgMWF3RsaESuDQi1c
 ualncTB6x50iToASwTogzRGazczoyCtiZxlk+Oeexq85cUDbVmEX4LbKN9hTgC8WM+lRTzRDq
 5YSNX/9bjGoosxxJ/jeqXyknQ7TZASgjpuPfVEaKpjmMOKM6esGD+dIjvrQMhmsfBrs8N8zuP
 zQNMKTHyaRFtV8iLnOdKCYSGSh05XGojmPDw4Ky8G7c9T1MbIN8JAUJnzh3xjWGVXf8JTpdQJ
 ElQbZ5zgLj7WUniXA1q9EPux/n3jGEasUBMNynJe6tZ9oBQTGhNfU8On1hOnmYDnHCrsu+IYg
 9ceHwDGpz/fRcbtoXNy9fewpTVkCaaOYVI5+QC+Y4UyIHD5PYLNYRaXT5j+Wo5sbzMsto+TW0
 PKMm47RNrWUamKHfBEA+SfbJbsqDvp/wG73Wbcj+9uSeCbhk24I0bqoR061xhP/IJTOGojupP
 csJgdUdHCEx5dYdbbHp2oXSLehdL6IGZomqW30porrgJFyrNOu/wn08Tbv2+o1XQMrH/ah8Hv
 gF0Y+FBf4Ld147/NP6IOiHQfcWTPimQOvSDOemEwI1nQ5bpv44IEJS5KjgBgMpYJBP3X0BvmP
 +oTsRgkDvZmcKg9Tkd5FogX8K+0SXjCjXPH7MhRzvPZghHcGFIssA8/HyzMm1adHcEaBhQ3cP
 Wp616lqqi06nzIVRsyw98BxXC6+pj5Z6QAkIWIWKJEWCJIMFpfneDYewnYKjvWqCzVIFpu8w2
 s9YmEn30GCKJ3ob8/SIbJ4mkbG+lbgEKdh3dqT5QZAavlKNxWk47mv39JlY8EKWXhqdle2W
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

We are not short of numbers for EXCP_*.  There is no need to confuse things
by having EXCP_VMEXIT and EXCP_SYSCALL overlap, even though the former is
only used for system mode and the latter is only used for user mode.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200213032223.14643-2-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/i386/cpu.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 576f309bbfc8..08b4422f36bd 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -999,9 +999,8 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 #define EXCP11_ALGN	17
 #define EXCP12_MCHK	18
 
-#define EXCP_SYSCALL    0x100 /* only happens in user only emulation
-                                 for syscall instruction */
-#define EXCP_VMEXIT     0x100
+#define EXCP_VMEXIT     0x100 /* only for system emulation */
+#define EXCP_SYSCALL    0x101 /* only for user emulation */
 
 /* i386-specific interrupt pending bits.  */
 #define CPU_INTERRUPT_POLL      CPU_INTERRUPT_TGT_EXT_1
-- 
2.24.1


