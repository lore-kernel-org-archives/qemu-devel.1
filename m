Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7D6C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:05:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0ADB20882
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0ADB20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAx3R-00068R-3c
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 10:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iAwx0-0007Dl-Fy
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:58:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iAwtc-0003l0-Ps
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:54:57 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:59585)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iAwtb-0003j5-A4; Thu, 19 Sep 2019 09:54:55 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mqro7-1hoadM1XPd-00mqC0; Thu, 19 Sep 2019 15:54:49 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu, 19 Sep 2019 15:54:39 +0200
Message-Id: <20190919135443.15164-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190919135443.15164-1-laurent@vivier.eu>
References: <20190919135443.15164-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0kbdgrvWoaromifnmGUDSe91cfeXzXS8GwPBAzwU68BC5waGoM7
 trP9/k7N+jk5acjocP+2K78wUfL+y8Q8EyQeh2Bhnj0xCH6Lt7ON7lUeZ5r/khAK7xUOHyO
 ZqE9+If6hgRNTqFa7ap0acnVsOceXys2bHNwISgqM4GPQ27XpKIuLexnKGOPDGOaU+ZAuS7
 YYEvh6NW8niFTPw5bdhrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s29iUPYgn2A=:44CGhlphQwpD/Nij3XjO1W
 k8dYCEEKEs5pB7DhGuD5dBby7BGBi0f2lPfzMUorW0xsaMUmsTj34Rz/nTgvJKnevZ9a5A0Yy
 bzWsTgybkhdQYQlekg0F7sDoymX82EKYIBOuud1aGjUEQ9O3rVET2j1QKnZxYl8WtyoZXU3KR
 C/OHEg8Rl6rWFxqUDvV97FJOWP1SWGf2RFiNR8UB4q/8wyVpcetCGAbuuf5toFUHyJbZu08W5
 USBY4Gu/tcjo4W/Xlhgj0spFf3xn+CQ8L1+L0njJ6zqfyWwDo5pTWsDol1HDrhaG3NawLZ9z2
 WxgSCIq8JYXg28wSrEC/z6+D76YwC7GNNnnK7EUFwSD+6jhTYn5qhPPkDFruSZmhDsEfJNCVH
 3EyapSDZAasa5arp8CZOua7b1LlKoF93bBas6AALvZMbf8bG4jIB1uKFE6CIEMf5Wf/8dFAOX
 LijVEIQxeRQ8ZNmqGNI4Qd4kN9o/I5MlqIUtZNdH7Q2NplGclZCy5YWDbtnViAJlbo2LVeLf/
 qeyKDdIkz69FdmWQGNsXYOnfw03VvR7FfRH9EzMXaRLXSpU1DrsS/rtTWT+yCpu0+2RCAr4OU
 Gytji/pbr0VbXO04n+btEsQulVBh+3adgK5R9+VPt5XkFBD/nCD4nXK1tU3MXSTpmy9OPa056
 P48wq/W3iNG7dmgfHwOoqtgpku0MkxxJfRVUbCr+LBop+pK60JaWatt8wSPuB7FY4p4VgS/At
 Oy7MqWg38+AZBBw83zpG6T976WYYP8L0SkuPFJ0T2IymHswpD/BBwrQ+NX3EN80gaZLfrSRaD
 lXU38NDkYobOA50ncHxQ49hupHLIjM9F3E3vz7qHkVpjyU3jZom1z+dzeC23pLE9qaeKRPFr1
 rNd2lo/evVvt6FwdVXzTHbW2AIkz8Cwz1yrvy6xkY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: [Qemu-devel] [PULL 4/8] target/m68k/fpu_helper.c: rename the access
 arguments
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: KONRAD Frederic <frederic.konrad@adacore.com>

The "access" arguments clash with a macro under Windows with MinGW:
  CC      m68k-softmmu/target/m68k/fpu_helper.o
  target/m68k/fpu_helper.c: In function 'fmovem_predec':
  target/m68k/fpu_helper.c:405:56: error: macro "access" passed 4 arguments,
   but takes just 2
               size = access(env, addr, &env->fregs[i], ra);

So this renames them access_fn.

Tested with:
 ./configure --target-list=m68k-softmmu
 make -j8

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1568296920-29939-1-git-send-email-frederic.konrad@adacore.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/fpu_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 9b039c856df8..4137542ec03b 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -396,14 +396,14 @@ typedef int (*float_access)(CPUM68KState *env, uint32_t addr, FPReg *fp,
                             uintptr_t ra);
 
 static uint32_t fmovem_predec(CPUM68KState *env, uint32_t addr, uint32_t mask,
-                               float_access access)
+                              float_access access_fn)
 {
     uintptr_t ra = GETPC();
     int i, size;
 
     for (i = 7; i >= 0; i--, mask <<= 1) {
         if (mask & 0x80) {
-            size = access(env, addr, &env->fregs[i], ra);
+            size = access_fn(env, addr, &env->fregs[i], ra);
             if ((mask & 0xff) != 0x80) {
                 addr -= size;
             }
@@ -414,14 +414,14 @@ static uint32_t fmovem_predec(CPUM68KState *env, uint32_t addr, uint32_t mask,
 }
 
 static uint32_t fmovem_postinc(CPUM68KState *env, uint32_t addr, uint32_t mask,
-                               float_access access)
+                               float_access access_fn)
 {
     uintptr_t ra = GETPC();
     int i, size;
 
     for (i = 0; i < 8; i++, mask <<= 1) {
         if (mask & 0x80) {
-            size = access(env, addr, &env->fregs[i], ra);
+            size = access_fn(env, addr, &env->fregs[i], ra);
             addr += size;
         }
     }
-- 
2.21.0


