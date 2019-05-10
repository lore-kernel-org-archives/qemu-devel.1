Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAECC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 10:58:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 041CF20881
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 10:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 041CF20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41100 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP3EL-0001KY-84
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 06:58:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hP32J-0007Hf-Ba
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:45:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hP32I-0003aN-EE
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:45:55 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:50657)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hP32I-0003Zg-5q
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:45:54 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1M1rGy-1hRFxX1zo0-002CQV; Fri, 10 May 2019 12:45:43 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 12:45:32 +0200
Message-Id: <20190510104536.17483-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510104536.17483-1-laurent@vivier.eu>
References: <20190510104536.17483-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zwCQFbEF2oiMW0z/Mnw23Pi0cFeUSvW5cM2E7CsUIGrKz7gFYEh
	jnJxELBGEr6sT1q/AWgWP/+/XHRs/eHkz/XfdCC4M6a37/BKEAqf7IbtqsVGOk7m6AFpkoW
	Fvgtj1QuJSbjlm3WrlfctRbPXkG5naS4sOxcUlRcbs6lom0YBQnk8GawoVoNuuB5jQa1KSF
	4BHz0ekebS0Pz3SIqoJ3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UtHemGKOe4Y=:ILJzR47XEXM8h1R1Tp79MI
	ccdW5T3Hh6oFWR0aKyY67Big8cOhzmidY4sU+e18sStxzzYTBJ41gfNSm8FlYU1Az1K2cllVY
	DSL99F2VQUFznRTFEoZja3DwSlrAhn/aWTdg7kFJF6wJovBvQUWzKdCuliCrTSFdadCdrZSGu
	SW7oB9QlemKO7n0jEpGpbAQ5Mm5e+aPUYsHBNH1dMRoc7U89OBMydeZOP79cdpI4emFhHvmwP
	AoFTO/5fmYzPwURG/eLcSbjmLBhpgWhyx3NG4BSLJu1ed+koXAJY1uohadwSbnzoXUGVEIpPy
	V3b7OMD2blXf9Ob10Gfds+3cGdO/zXQSjFiOSsbvC1f74Tj9cEAKR1fvFW/HFgZH8hr8u8Yz8
	GJ0hzU5u4cOeHuwHI6o3pCfOFUasv5jDRvYW66+XGOtGkrtJVkjUw69fjYHcSMJWITHTy0CuI
	R9COzPCAeJWPh+pCGRgwDDGAsGpI/AyUKphUC0vX0RcJ3/NKIs3Wlm8FySQC6vuI47t70Oacd
	c6R/IOWp1168qLCBvsljPL92TWBz/ReiHwUj0R93bnnkk2ob3xs5CLLthUXa1K4YhGqfc476N
	WpAxXxdOtwkSqoNCJd6A7HukqiXardoYVeaBUWIqZd/pC8O4ua54O0A8XAnuDH7dIxCfRHTmn
	t+8SUReSNheClC6+TvAI8MeiDqG3vg3U7FV5JRbosByCcCdEUyhGXPXpJS51/iRUiQ3+oO13g
	nGQrufji/X2w42BkNxbdoSUdZvLbdRToyCwi3rqfxTqtHLcgp774yc5cfyk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
Subject: [Qemu-devel] [PULL v2 3/7] linux-user: avoid string truncation
 warnings in uname field copying
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Riku Voipio <riku.voipio@iki.fi>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrangé <berrange@redhat.com>

In file included from /usr/include/string.h:494,
                 from include/qemu/osdep.h:101,
                 from linux-user/uname.c:20:
In function ‘strncpy’,
    inlined from ‘sys_uname’ at linux-user/uname.c:94:3:
/usr/include/bits/string_fortified.h:106:10: warning: ‘__builtin_strncpy’ output may be truncated copying 64 bytes from a string of length 64 [-Wstringop-truncation]
  106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

We don't care where the NUL terminator in the original uname
field was. It suffices to copy the entire original field and
simply force a NUL terminator at the end of the new field.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190501144646.4851-1-berrange@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/uname.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/linux-user/uname.c b/linux-user/uname.c
index 313b79dbad47..1c05f95387f4 100644
--- a/linux-user/uname.c
+++ b/linux-user/uname.c
@@ -72,9 +72,8 @@ const char *cpu_to_uname_machine(void *cpu_env)
 
 #define COPY_UTSNAME_FIELD(dest, src) \
   do { \
-      /* __NEW_UTS_LEN doesn't include terminating null */ \
-      (void) strncpy((dest), (src), __NEW_UTS_LEN); \
-      (dest)[__NEW_UTS_LEN] = '\0'; \
+      memcpy((dest), (src), MIN(sizeof(src), sizeof(dest))); \
+      (dest)[sizeof(dest) - 1] = '\0'; \
   } while (0)
 
 int sys_uname(struct new_utsname *buf)
-- 
2.20.1


