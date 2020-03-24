Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FA2C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89E8620775
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89E8620775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGgRP-0007mA-Ky
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 06:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jGgP5-0005z2-Rv
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:03:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jGgP4-0000bD-KB
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:03:23 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:40601)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jGgP4-0000aL-BI
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:03:22 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M1HmG-1jF1RY1Bn8-002sq4; Tue, 24 Mar 2020 11:03:14 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 1/5] target/i386: Renumber EXCP_SYSCALL
Date: Tue, 24 Mar 2020 11:03:07 +0100
Message-Id: <20200324100311.588288-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324100311.588288-1-laurent@vivier.eu>
References: <20200324100311.588288-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nlPmbkZakYTpWoj3tyrKFhmTUvqrTfMerPIcRSr7ey2WCePc4e8
 KGTpavyaH7zxfA+XbImm3ABuGI1vqO/3MHE76cJAOUAHmISZj6p/13p4dH39Outsp8gqU8Z
 I+oGI977R3pYXJSzXqmlFu2t9yqdsDiDn7J45pkIFbr0uQdbE65g2L6SLJhJkE9/gSPBAv+
 VLpCmNH4YtZLmgqv0SxAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bjKTgcuTq6I=:FEWGO5wMM+b72Bi12/wE39
 EvjIt3TxZPVrku3pA6lQoXdMxKKI3uS4vf5GBJdKn7zOEOWD7bp7Goo2BxqqI5BfYpFwlkFOU
 BQvIHsRF5UWOXlpeHTpfMutqYlpSpnN9AfA3dfwrNU+SLU7YqB+1XfWqTAymHnz/bVuy131x9
 aELZWMzv1+LF0bMjHhklsmZtSOqXuwQg88sn9fKYvCwpSi9mx4alBkbHijXwXHdOTNkukXV0r
 Ym/QK/l5VIiUOM8De1FKTqkco3Fmp+35D+e6c8EreTjWUE3s35+Q+iDjACTwAANHewALaRfeg
 EuOLdxdoH1Cq/sbRpuGJQyPOW7KnfsnlkTHLzlfg9HdbDA9PUlEIo6E3afMWUHHUiuTjEGNix
 4tsSkjA562V2ZsMmoz61tCOL54knMZXhppVxbx+FvKEXE9l9nNKdE+Na7tUm+s6emzs3LMmfG
 rgIoiYMb3y+4an3IE5FR63huBn7d3huNgFXm0KzHCX+D1c4kWxkuT+qB5qyjCmstKRMPCoGOO
 7u9qawARgZSd1Su7sItplJd9OSfMFHOQy6zPoZYrp7z1ADIRftcopCO8fWP2yNqNSUzZeHqUk
 kxIhi26pn7ZKTRKXg9cVYEYo/YZ3ofvBsMV1stoyS2ueMmAfU48+Bc3MXFwwL3dAmgIw+q1Q3
 N8VF2CqHgWQbHYL8C/J+2aftAHqR5BYXmU2t1KbkszHwpy/u0cUF0z6pvoJ4soUCiUDCm0sD3
 XBXmh0pGCm+vkWokXjB2z5J5aAweG5qrOkT6amKilfPn6m7yuSk9hviF8jM9QYWSh5mFZhz4M
 26A2y5dIR4BSXKSmItDLnIB8gL/cMhKRFfIQbrU4/qhvDp0VfcGKlj6lEa1NvTKoGgJ6bAT
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
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
index 60d797d5941f..49ecc23104c9 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1001,9 +1001,8 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
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
2.25.1


