Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98030C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 14:05:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D762206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 14:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D762206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjkIl-0007Mu-Nn
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 10:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jjkIA-0006wq-FZ
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:04:22 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:39461)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jjkI8-0000y4-ME
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:04:22 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Myb09-1j0JhZ1My5-00yxJY; Fri, 12 Jun 2020 16:04:04 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH] softfloat,m68k: disable floatx80_invalid_encoding() for m68k
Date: Fri, 12 Jun 2020 16:04:00 +0200
Message-Id: <20200612140400.2130118-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:a9jKNi+yn8udGdyoILk5oiydQ93tYVinB3TssE+G77Eh+uueACy
 oJm1XFIzfYCgy4XaxQx0pFoZbwXsJd8ZIcP05K8hgaF9rhLg7UhilLoeiCrmrVceWVWa98x
 aJu2sBOMeYY51a6xM0scNIdQiDz9zrbqPkFxhRjZbfJ7JsbktNcrDqEaAAJIXo/5nvAQgYc
 NNDo5FJ574ez7buOjm79Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:etJL1QB3ZMc=:i2aAXrN8fQqVSxDflPZx69
 fCarQhzoIEj3ePYG85Zwg+iDXf/6bpD0rvNm+J6EIHyIwKCDVsZvIlSWaxg+43h5AkGRjtHWN
 kqGVKUnEEnfqKeDAsmoKWBH2jJWaXYwdBEMEZIugFFeG+qW7V/1Sx35u+PDIH+rD692JKUNJF
 /EvmZheKNAMAbRt8FAfsefNRvhSA048/NXiNiplZBp69yT3u2ZPvSiPYDUW9vjQcKmxg3dZhR
 DfXGEF6b/98GvLoXYo39lFnaFWqUmGR3r7QmtP0LPgD3TDsM426g2EZgnybiHpqw1TJkMZ7Az
 TfWVZNSLwwOpBFfzk+QbxXVpoPpJmOKLE5cffo1KZY6q3LzAiQePIK6xQ7xCxZKGt8IkbzAeK
 g5UjIwZgPbU8mIMEIzMYw1hf1yh6OsgTCGtVeqfI4UbLWy/lfpUb01y9e9+FPS1QC6u5E+8h1
 mcfKIhUJRsGJNcN5cBHCww9PxS8eyLq6g4bCkpGpMADcKtoEqhW2NkCRVlnIhUeEABHNpogqx
 KUe52wJBIAxE05yple6YyNziuPBQkZ79OKrNMizSUZ8SFwBKSAXSUcncU1WRv1ExlDyfGgmEi
 kCzyPspwpGL9W4PNSz50mvetjwD+bQsmEWO3ln52UD/3jAFcnsfO6KU4563QzTknNMFwJKb8x
 hDLsr6WoYhjyl7cd4kzq8uZOy23mqsbNyqqCPXNuzk/jRCkhR/NwLqJFiWfwFYr4sMLzUBDMF
 0P8eW1OwSMKXUVGVZTydrv+kZ0eo4eMtTjTHVGC+kaJ2eJJk2tGcnZK+4K5GNbHpzz1E4/tei
 EOPf1EBAqaugSJXJEccQlJsNVDrpptLsKe4PtkP4VSIo5OEkY0wnzpiQvCvven8IfRSVGLD
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 10:04:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Pierre Muller <pierre@freepascal.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

According to the comment, this definition of invalid encoding is given
by intel developer's manual, and doesn't comply with 680x0 FPU.

With m68k, the explicit integer bit can be zero in the case of:
 - zeros                (exp == 0, mantissa == 0)
 - denormalized numbers (exp == 0, mantissa != 0)
 - unnormalized numbers (exp != 0, exp < 0x7FFF)
 - infinities           (exp == 0x7FFF, mantissa == 0)
 - not-a-numbers        (exp == 0x7FFF, mantissa != 0)

For infinities and NaNs, the explicit integer bit can be either one or
zero.

The IEEE 754 standard does not define a zero integer bit. Such a number
is an unnormalized number. Hardware does not directly support
denormalized and unnormalized numbers, but implicitly supports them by
trapping them as unimplemented data types, allowing efficient conversion
in software.

See "M68000 FAMILY PROGRAMMER’S REFERENCE MANUAL",
    "1.6 FLOATING-POINT DATA TYPES"

We will implement in the m68k TCG emulator the FP_UNIMP exception to
trap into the kernel to normalize the number. In case of linux-user,
the number will be normalized by QEMU.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/fpu/softfloat.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 16ca697a73b7..f6eda4ca8e6c 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -791,7 +791,31 @@ static inline bool floatx80_unordered_quiet(floatx80 a, floatx80 b,
 *----------------------------------------------------------------------------*/
 static inline bool floatx80_invalid_encoding(floatx80 a)
 {
+#if defined(TARGET_M68K)
+    /*-------------------------------------------------------------------------
+    | With m68k, the explicit integer bit can be zero in the case of:
+    | - zeros                (exp == 0, mantissa == 0)
+    | - denormalized numbers (exp == 0, mantissa != 0)
+    | - unnormalized numbers (exp != 0, exp < 0x7FFF)
+    | - infinities           (exp == 0x7FFF, mantissa == 0)
+    | - not-a-numbers        (exp == 0x7FFF, mantissa != 0)
+    |
+    | For infinities and NaNs, the explicit integer bit can be either one or
+    | zero.
+    |
+    | The IEEE 754 standard does not define a zero integer bit. Such a number
+    | is an unnormalized number. Hardware does not directly support
+    | denormalized and unnormalized numbers, but implicitly supports them by
+    | trapping them as unimplemented data types, allowing efficient conversion
+    | in software.
+    |
+    | See "M68000 FAMILY PROGRAMMER’S REFERENCE MANUAL",
+    |     "1.6 FLOATING-POINT DATA TYPES"
+    *------------------------------------------------------------------------*/
+    return false;
+#else
     return (a.low & (1ULL << 63)) == 0 && (a.high & 0x7FFF) != 0;
+#endif
 }
 
 #define floatx80_zero make_floatx80(0x0000, 0x0000000000000000LL)
-- 
2.26.2


