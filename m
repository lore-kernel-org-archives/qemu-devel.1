Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77ED9C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 22:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4771A2084A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 22:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4771A2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37813 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRP4s-0001i6-Fd
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 18:42:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hROyS-0005s4-4N
	for qemu-devel@nongnu.org; Thu, 16 May 2019 18:35:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hROyR-0002BV-7F
	for qemu-devel@nongnu.org; Thu, 16 May 2019 18:35:40 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:43035)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hROyQ-00027t-TO
	for qemu-devel@nongnu.org; Thu, 16 May 2019 18:35:39 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MPGJf-1h1mRO2dWH-00PeTG; Fri, 17 May 2019 00:35:35 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 00:35:19 +0200
Message-Id: <20190516223519.7520-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190516223519.7520-1-laurent@vivier.eu>
References: <20190516223519.7520-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:S4fUsaEfbFWoVDtO9Z9CNwiL19XuGmWLqaDvU0hnfkSDVnln7KG
	ADuPgyHIlY8clI6nOyCFRqr1wj/lWrKrZx3Mdh6PwtOiPRbsHNlZ8kGQ1f8jSkVSRKD3eT7
	YI9eGy6N47rCCza//liuqFO9qyTCmsTh9xpzyhkcUyTNwtAnEjmWnFDMK/MuczR0slMw4ru
	FQLH78LUFsapmz7DYyRAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R3SG6I2/Pz0=:cvoEUxxATRb894hyjl/2c8
	GL35H4aQ5z7tI4+s6eTB/DwaAzeNzksf9QR01mJDXJ2xjx8NPjzOeNpQ4+/+f6pvVmbSHeEmN
	QAswRWL8N3QQfay+kdyvinSruoryNjidNx6kEOtQJMyO80YUQ71kpaCH/8FQ75atAfFITcVl7
	9D2bTYQCsO/f2joHKT/z+djI81I8UkjSMK3P+v7Y19MHX3CgDJi19oB7MeZ/fQ4ynRsvp46s5
	LVQ6cRPnTbdTKpapNSsu4Z9dsdQL4G9JwSvUWKds84FvtA0oImARXtthd1YO3vKKvo0KHZH4F
	e0JQATMoczqUVfRdRiywX30mXkqRfuPmgPDOeVTBHb0pSW9rKZNUA6RrqsWF69RtLcZE2yPLi
	MVZYTHOXTy0UhD7KdzrZ1ekCfOOvA0wNrAtOZYhADF6sLHmugUGQppDjfXmuDTcUU7ufH3j/U
	ziWUpWNp+rf2IpVFOPa9HT+/5e0D1Ww+HWBcfRNQDqMygMO7Q/uLMNBB5QNAXMePMqZ87UdYR
	nYJwBHK6wqumgQpMq/3P+4n06jgwKog8jkvXvi9VCI5R50Yt2QAQrIc6L3OBKzfIdajHxB7JU
	e9IpOpboZjvmFqafQmuryrkjAHk4axPt8A6V/B2jQ3GHnpXezWcFG8b2r+P6x/vzwAADKSSV5
	9mBn9A1bec+akKlaWzVrGLGOQyMPfpWYZ4SHs35sAxkw3z4AZuuhAo0cuzckuO3IwiayqeyzF
	mbyaG5i/pJzZIN5sbPNmbqCuVfOHCAmw+QYd/pUV/5dAzw2UsdzRJj1rUP4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: [Qemu-devel] [PULL 6/6] target/m68k: Optimize rotate_x() using
 extract_i32()
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
Cc: Thomas Huth <huth@tuxfamily.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Laurent Vivier <laurent@vivier.eu>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Optimize rotate_x() using tcg_gen_extract_i32(). We can now free the
'sz' tcg_temp earlier. Since it is allocated with tcg_const_i32(),
free it with tcg_temp_free_i32().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190310003428.11723-6-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/translate.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index bf700c01b1..f0534a4ba0 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -3693,6 +3693,7 @@ static TCGv rotate_x(TCGv reg, TCGv shift, int left, int size)
         tcg_gen_sub_i32(shl, shl, shift); /* shl = size + 1 - shift */
         tcg_gen_sub_i32(shx, sz, shift); /* shx = size - shift */
     }
+    tcg_temp_free_i32(sz);
 
     /* reg = (reg << shl) | (reg >> shr) | (x << shx); */
 
@@ -3708,9 +3709,7 @@ static TCGv rotate_x(TCGv reg, TCGv shift, int left, int size)
     /* X = (reg >> size) & 1 */
 
     X = tcg_temp_new();
-    tcg_gen_shr_i32(X, reg, sz);
-    tcg_gen_andi_i32(X, X, 1);
-    tcg_temp_free(sz);
+    tcg_gen_extract_i32(X, reg, size, 1);
 
     return X;
 }
-- 
2.20.1


