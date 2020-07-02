Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5F4C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:32:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E30E020781
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30E020781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr1Ci-0000pN-2Z
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 11:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jr17X-0000TU-AD
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:27:27 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:43037)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jr17S-0006IL-Ba
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:27:27 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MhlbM-1jDGRk2hvc-00dlyL; Thu, 02 Jul 2020 17:27:12 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 01/12] target/sparc: Translate flushw opcode
Date: Thu,  2 Jul 2020 17:26:59 +0200
Message-Id: <20200702152710.84602-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200702152710.84602-1-laurent@vivier.eu>
References: <20200702152710.84602-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XAeweq2/wNjsvfr4kwoLXVH2UbpOdVUgt001l1B6y9UtnsVU7/i
 clHAVj3H2Z9dyFpumAwADp9qufvRmKHx136MWK6JP/Stv96litmiTkk0ujU/MunwGa3YW9s
 ILkNNe0xzuWocgcFemF73iiP+KxgObKhT5QL0gOQjKVhWu4JGf61QDoe+CePUOL1A9FRmMn
 3hGIDTX1VoYsnCj2Sy3Yg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j3CxfANrJiA=:cylJceBTqCdgyPcx1AcEz1
 3RW6vms2WH41TLBe413qvBcpmPDavgEJp7i6rLZ2992UT8MW4VOml7PHnGu9/MKbwWzkHi8TS
 gYy6U1XmjRusa3YQ4b15wXGxnNVW3nzUMqJu2DETzkRbkvjCSrWJJkbFPQ7aTIDNEaPh/lLsB
 EA7RTu1xDYnhTPGZyhaIc9sJcIq9Z2cgTlq/t+hbpGMuzF/IkQwowu4i/81NcBoc51HF40J/h
 iKK0mfaHyMo7BvPYX37UDm9DhN5yuer/RStFqMd+FBkSg4Y2qTLMZztlo+SoPEvNZeZnJWgE7
 soWbr0jiTFCPEi6jARgVboZrLX104lRWuUCQY+Cdo4c15oY+C5kRrssPxjslfEeOU6FjAOONA
 Ktx82zySZ47FYOX+IjbpGAXtO1zbYWpUduKtQevy9SKzJdPgwKno8Pahuuk3CAkA0Br6k7mXT
 f4irVCWIF1zTzoA+G5yzOGD3lHqQbIuKy3G2ysA/KWQz90OjTI+Kmt2mhkJ3ifh/uhtaHf75u
 x3/XQ08A2yZHXIaKJUXZiDHWXTWDWLWJpGnjQMCl+5+c2Nf2zATOLoI/smqmRaJJF+MNcIpE7
 VvaxVWaYB/XkIzB72Sg0U0uVznDujf7uv5Gv3OQNr89pTlvCFemnPkGWC02M1Lf4Wsh95oiZt
 4GRoH/ujFlXL+P/etmTAXvW1B49HKjOwWqNdU7OG2FMjothXwhC2+Y1qHP6j47WWFy9i2RBaV
 PuUx4wKRsDBkHtiBQunTYrfyCaDNvKgESZJfVx5PI959YhscXARZXdGSpN4SZD4yAcQY2PLic
 81AsmTFXJRXBCSKUuPP10P4VvbeOvpZSS9kn3jpq8J1DIPa+9U=
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 11:27:21
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Giuseppe Musacchio <thatlemon@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Giuseppe Musacchio <thatlemon@gmail.com>

The ifdef logic should unconditionally compile in the `xop == 0x2b` case
when targeting sparc64.

Signed-off-by: Giuseppe Musacchio <thatlemon@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200625091204.3186186-2-laurent@vivier.eu>
---
 target/sparc/translate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 9416a551cf46..1a4efd4ed665 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -3663,6 +3663,8 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
 #endif
                 gen_store_gpr(dc, rd, cpu_tmp0);
                 break;
+#endif
+#if defined(TARGET_SPARC64) || !defined(CONFIG_USER_ONLY)
             } else if (xop == 0x2b) { /* rdtbr / V9 flushw */
 #ifdef TARGET_SPARC64
                 gen_helper_flushw(cpu_env);
-- 
2.26.2


