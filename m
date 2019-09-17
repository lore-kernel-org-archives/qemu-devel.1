Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F00C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 20:06:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4701D214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 20:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4701D214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freepascal.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAJkE-0000it-CV
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 16:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pierre@freepascal.org>) id 1iAJi5-0006um-VN
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:04:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pierre@freepascal.org>) id 1iAJi2-00049k-PN
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:04:25 -0400
Received: from vps46799.freepascal.org ([85.222.228.11]:52008
 helo=mail.freepascal.org) by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <pierre@freepascal.org>) id 1iAJi2-000497-FU
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:04:22 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.freepascal.org (Postfix) with ESMTP id CFCE581C2F
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 22:04:20 +0200 (CEST)
Received: from mail.freepascal.org ([127.0.0.1])
 by localhost (idefix.freepascal.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d_y03MgLC-rJ for <qemu-devel@nongnu.org>;
 Tue, 17 Sep 2019 22:04:20 +0200 (CEST)
Received: from [192.168.1.22] (89-89-1-25.abo.bbox.fr [89.89.1.25])
 by mail.freepascal.org (Postfix) with ESMTPSA id 458E581C2E
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 22:04:20 +0200 (CEST)
To: qemu-devel@nongnu.org
From: Pierre Muller <pierre@freepascal.org>
Openpgp: preference=signencrypt
Autocrypt: addr=pierre@freepascal.org; prefer-encrypt=mutual; keydata=
 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 Hw==
Message-ID: <1615bbe5-3033-3b76-5cfb-52e343dc4d67@freepascal.org>
Date: Tue, 17 Sep 2019 22:04:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 85.222.228.11
Subject: [Qemu-devel] [PATCH] * include/fpu/softfloat.h
 (floatx80_invalid_encoding): Handle m68k specific infinity pattern.
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
Reply-To: Pierre Muller <pierre@freepascal.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



Hello,

  I submitted September 12. a bug report about wrong handling of
infinity values for m68k emulator.

https://bugs.launchpad.net/qemu/+bug/1843651

  The analysis I made in the bug report is wrong, because
I did not know that m68k FPU really uses 80-bit representations internally.
  It thus seems now to me that the m68k specific floatx80_infinity_low
corresponds to a different internal encoding of infinity on m68k floating
point units, different from the one of the usual x87 floating point unit.
  The main problem still remains that the function floatx80_invalid_encoding
does not properly handle those m68k infinity patterns.

  The patch below seems to fix the reported problem on current git.

Pierre Muller
Member of core development team of Free Pascal compiler


From e053d3d07b1951faf0b4637ce1ec4194b8d952e5 Mon Sep 17 00:00:00 2001
From: Pierre Muller <pierre@freepascal.org>
Date: Thu, 12 Sep 2019 08:10:48 +0000
Subject: [PATCH]        * include/fpu/softfloat.h (floatx80_invalid_encoding):
 Handle         m68k specific infinity pattern.

---
 include/fpu/softfloat.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index ecb8ba0114..538c35767e 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -685,10 +685,17 @@ static inline int floatx80_is_any_nan(floatx80 a)
 | pseudo-infinities and un-normal numbers. It does not include
 | pseudo-denormals, which must still be correctly handled as inputs even
 | if they are never generated as outputs.
+| As m68k uses a different pattern for infinity, thus an additional test
+| for valid infinity value must be added for m68k CPU.
 *----------------------------------------------------------------------------*/
 static inline bool floatx80_invalid_encoding(floatx80 a)
 {
+#if defined (TARGET_M68K)
+    return ((a.low & (1ULL << 63)) == 0 && (a.high & 0x7FFF) != 0)
+           && (! floatx80_is_infinity(a));
+#else
     return (a.low & (1ULL << 63)) == 0 && (a.high & 0x7FFF) != 0;
+#endif
 }

 #define floatx80_zero make_floatx80(0x0000, 0x0000000000000000LL)
--
2.20.1


