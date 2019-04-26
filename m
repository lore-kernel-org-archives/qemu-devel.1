Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99B4C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:14:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D9B206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UN3tstHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D9B206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39973 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJu80-00047O-Qf
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 02:14:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0X-0005Rl-23
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0V-0004Na-HS
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:49 -0400
Received: from ozlabs.org ([203.11.71.1]:42015)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hJu0U-0004Hz-Sq; Fri, 26 Apr 2019 02:06:47 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44r3Tk6TXHz9sMQ; Fri, 26 Apr 2019 16:06:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1556258794;
	bh=CpVDQft0uHqfW1Yh26ZLPa9IQjTyO3ExmmZG59YXhOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UN3tstHbpH9IGERbjehm3l6GqmVWwRG8uE4Cz8eodQlYvhlvhhz01v8aOENHs9fPT
	J+WGcYmzZk/INPefOPaakDNvGLrp2CUpqWPrGofLshFd5nXkQBjxlZAsthZOhRIK0M
	HOoLRZzzSRvm/Z3tvFOAGlx1vbk8obqYHxILaDKs=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Fri, 26 Apr 2019 16:06:00 +1000
Message-Id: <20190426060627.18153-10-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 09/36] target/ppc: Style fixes for dfp_helper.c
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: gkurz@kaod.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, clg@kaod.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426060600.q7tuwe2OKTWYK-kt7O1HG2w-IDLnvFxykUOuHoWIoYk@z>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/dfp_helper.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/ppc/dfp_helper.c b/target/ppc/dfp_helper.c
index 9164fe701b..f102177572 100644
--- a/target/ppc/dfp_helper.c
+++ b/target/ppc/dfp_helper.c
@@ -1104,19 +1104,19 @@ void helper_##op(CPUPPCState *env, uint64_t *t, u=
int64_t *b, uint32_t s)     \
         }                                                               =
     \
         }                                                               =
     \
                                                                         =
     \
-    while (offset < (size)/4) {                                         =
     \
+    while (offset < (size) / 4) {                                       =
     \
         n++;                                                            =
     \
-        digits[(size)/4-n] =3D dfp_get_bcd_digit_##size(dfp.b64, offset+=
+);    \
-        if (digits[(size)/4-n] > 10) {                                  =
     \
+        digits[(size) / 4 - n] =3D dfp_get_bcd_digit_##size(dfp.b64, off=
set++); \
+        if (digits[(size) / 4 - n] > 10) {                              =
     \
             dfp_set_FPSCR_flag(&dfp, FP_VX | FP_VXCVI, FPSCR_VE);       =
     \
             return;                                                     =
     \
         } else {                                                        =
     \
-            nonzero |=3D (digits[(size)/4-n] > 0);                      =
       \
+            nonzero |=3D (digits[(size) / 4 - n] > 0);                  =
       \
         }                                                               =
     \
     }                                                                   =
     \
                                                                         =
     \
     if (nonzero) {                                                      =
     \
-        decNumberSetBCD(&dfp.t, digits+((size)/4)-n, n);                =
     \
+        decNumberSetBCD(&dfp.t, digits + ((size) / 4) - n, n);          =
     \
     }                                                                   =
     \
                                                                         =
     \
     if (s && sgn)  {                                                    =
     \
@@ -1170,13 +1170,13 @@ DFP_HELPER_XEX(dxexq, 128)
 static void dfp_set_raw_exp_64(uint64_t *t, uint64_t raw)
 {
     *t &=3D 0x8003ffffffffffffULL;
-    *t |=3D (raw << (63-13));
+    *t |=3D (raw << (63 - 13));
 }
=20
 static void dfp_set_raw_exp_128(uint64_t *t, uint64_t raw)
 {
     t[HI_IDX] &=3D 0x80003fffffffffffULL;
-    t[HI_IDX] |=3D (raw << (63-17));
+    t[HI_IDX] |=3D (raw << (63 - 17));
 }
=20
 #define DFP_HELPER_IEX(op, size)                                        =
  \
--=20
2.20.1


