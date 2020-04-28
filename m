Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D148EC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A77B82082E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A77B82082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTTw4-0008MO-Q9
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 13:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1jTTt4-00043T-4H
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:19:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1jTTt2-0003ae-Lf
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:19:13 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:45742
 helo=smtp.eu.adacore.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frederic.konrad@adacore.com>)
 id 1jTTt2-0003a8-5h
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:19:12 -0400
Received: from localhost (localhost [127.0.0.1])
 by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 4797581343;
 Tue, 28 Apr 2020 19:19:10 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
 by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7n_DhTv0SgVL; Tue, 28 Apr 2020 19:19:10 +0200 (CEST)
Received: from localhost.localdomain.localdomain
 (lfbn-tou-1-1471-22.w90-89.abo.wanadoo.fr [90.89.4.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtp.eu.adacore.com (Postfix) with ESMTPSA id 0107B8137A;
 Tue, 28 Apr 2020 19:19:09 +0200 (CEST)
From: KONRAD Frederic <frederic.konrad@adacore.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] softfloat: m68k: infinity is a valid encoding
Date: Tue, 28 Apr 2020 19:17:57 +0200
Message-Id: <1588094279-17913-2-git-send-email-frederic.konrad@adacore.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588094279-17913-1-git-send-email-frederic.konrad@adacore.com>
References: <1588094279-17913-1-git-send-email-frederic.konrad@adacore.com>
Received-SPF: pass client-ip=2a02:2ab8:224:1::a0a:d2;
 envelope-from=frederic.konrad@adacore.com; helo=smtp.eu.adacore.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a02:2ab8:224:1::a0a:d2
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
Cc: Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 laurent@vivier.eu, frederic.konrad@adacore.com, philmd@redhat.com,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The MC68881 say about infinities (3.2.4):

"*For the extended precision format, the most significant bit of the
mantissa (the integer bit) is a don't care."

https://www.nxp.com/docs/en/reference-manual/MC68881UM.pdf

The m68k extended format is implemented with the floatx80 and
floatx80_invalid_encoding currently treats 0x7fff00000000000000000000 as
an invalid encoding.  This patch fixes floatx80_invalid_encoding so it
accepts that the most significant bit of the mantissa can be 0.

This bug can be revealed with the following code which pushes extended
infinity on the stack as a double and then reloads it as a double.  It
should normally be converted and read back as infinity and is currently
read back as nan:

        .global _start
        .text
_start:
        lea val, %a0
        lea fp, %fp
        fmovex (%a0), %fp0
        fmoved %fp0, %fp@(-8)
        fmoved %fp@(-8), %fp0
end:
        bra end

.align 0x4
val:
        .fill 1, 4, 0x7fff0000
        .fill 1, 4, 0x00000000
        .fill 1, 4, 0x00000000
.align 0x4
        .fill 0x100, 1, 0
fp:

-------------

(gdb) tar rem :1234
Remote debugging using :1234
_start () at main.S:5
5              lea val, %a0
(gdb) display $fp0
1: $fp0 = nan(0xffffffffffffffff)
(gdb) si
6             lea fp, %fp
1: $fp0 = nan(0xffffffffffffffff)
(gdb) si
_start () at main.S:7
7              fmovex (%a0), %fp0
1: $fp0 = nan(0xffffffffffffffff)
(gdb) si
8             fmoved %fp0, %fp@(-8)
1: $fp0 = inf
(gdb) si
9             fmoved %fp@(-8), %fp0
1: $fp0 = inf
(gdb) si
end () at main.S:12
12          bra end
1: $fp0 = nan(0xfffffffffffff800)
(gdb) x/1xg $fp-8
0x40000120 <val+260>:   0x7fffffffffffffff

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
---
 include/fpu/softfloat.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index ecb8ba0..dc80298 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -688,7 +688,12 @@ static inline int floatx80_is_any_nan(floatx80 a)
 *----------------------------------------------------------------------------*/
 static inline bool floatx80_invalid_encoding(floatx80 a)
 {
+#if defined(TARGET_M68K)
+    return (a.low & (1ULL << 63)) == 0 && (((a.high & 0x7FFF) != 0)
+                                           && (a.high != 0x7FFF));
+#else
     return (a.low & (1ULL << 63)) == 0 && (a.high & 0x7FFF) != 0;
+#endif
 }
 
 #define floatx80_zero make_floatx80(0x0000, 0x0000000000000000LL)
-- 
1.8.3.1


