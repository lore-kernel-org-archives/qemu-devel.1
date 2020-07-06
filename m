Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69996C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:07:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4307F206B6
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4307F206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsXOd-0003IV-GX
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 16:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jsXNe-0001bj-4C
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 16:06:22 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:44911)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jsXNc-0004sn-DS
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 16:06:21 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mrh9Y-1kfwc51uWS-00nl1b; Mon, 06 Jul 2020 22:06:05 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 3/3] softfloat,
 m68k: disable floatx80_invalid_encoding() for m68k
Date: Mon,  6 Jul 2020 22:05:59 +0200
Message-Id: <20200706200559.160209-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200706200559.160209-1-laurent@vivier.eu>
References: <20200706200559.160209-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hQ7+V73jS8osY4BZP51pZsm/CritqkcXleC1/1o3Xwq5vssvZZX
 6/hO8faAlvKOQXTvOx4+1R4p0xypYk3Rz/6gySKrueYVbexmw4Du2SNeGH8WBiscCmeBU1p
 JlGGFpmV+E8SRJ5Ivf9UjfQWr1ZgLOglD7+V69CiwIDFxKtPhVRz2cQger6KU6dxkZKZgmS
 6fHXr7FFTC4j9Uv/AMCYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jRjAnRCLjns=:6Z4QqL4mMD9xrLJOumVLo4
 kyOmk2oRI2HZQcdHVg3qmsgLaJzzc5HBM5oZO3IgGWMYHIka/HmpgUxOglxwnso4yWutNuFYh
 RqGUhm0CPJtt2ncWpccAShHyd5hgPEFWSQWoye+g4jWvI821melSNrcsOFWr1xsIaWLPNCUzX
 VbnIyntCME3Dmab7J8qNaV5i5UPcXAV6pmVWtoL9MlKZH92AutC3VP3p01rCftaZrRKgVv+zR
 hANv23a+LWTvc15kOD0S3xlwdOCWT0W3Ktjqfv2PT0uD6bTToT+0DD8dtm5e4ITo76JAoI8Zj
 F1pFJLtykpudry8fPiqWYSnwsYmfnGeAxem9VmBcPd7twPxdYEt8nAqHrwtQTVdWyVufFtNhy
 FcO+6DQ0HNm/6xcvoIiyLJAudLcwHt+Y3AyN5pbTI5dLz5YemtKWFmVkKnmlqh/aCYM+FdbdY
 yVpsvNANIaJTj7waV1MNW+4BFo7bqnvFrDd1y3DGx57IMw4xX9yCNnBXRcFNBnrG0rSQ+PajC
 SKafVBAeq4sAzf7YDFQTD+frQe/RJ41t/ZSbMD8Nr+64mpyiIM3Tz5joNBRgTognWXc/UpAKF
 ZVJ1hOQm8Q1USZdpYsF4LHNYB7mbVDsXIQwYPwXRhqVnY3xHyOVl0MADctwPAp8vRWDS5Z4iV
 LCIfdJRBQE9rKXXMOAX62O+nrlyVW0aOT97qREXt3HNlBdLkHOS/TA09LDMWl5dlgk5+8d7xd
 wHQPVG40QfbwsQ8jI2SnFsCainFc+OddaJTZd5vakoQXso8xjFjqicX7Usp4ZSuGS9OskaPQM
 /4zY0ljmioNwaCJP0J9bylsvV/hgZP7EIR2NQhxiodzxsPZ+X9EgULuhYTUExWJURnbZfHV
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 15:40:39
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200612140400.2130118-1-laurent@vivier.eu>
---
 include/fpu/softfloat.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index ff4e2605b16d..f1a19df066b7 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -794,7 +794,31 @@ static inline bool floatx80_unordered_quiet(floatx80 a, floatx80 b,
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


