Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16133C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:27:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF0FB20870
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF0FB20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Olz-0004zu-ME
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 07:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i0OfW-0005Bx-8E
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:20:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i0OfU-0006gv-Q5
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:20:46 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:60159)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1i0OfI-0006XX-FM; Wed, 21 Aug 2019 07:20:34 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MJn4B-1hgNrk3nRJ-00K5FT; Wed, 21 Aug 2019 13:20:10 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:19:43 +0200
Message-Id: <20190821111947.26580-11-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821111947.26580-1-laurent@vivier.eu>
References: <20190821111947.26580-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dZPXJ7zALzqELWms6CgEg+HsPRg5cmClSJEGrVb744N3hZRY0VY
 GsNSpBr/WJLhfdimJegSry3T4iUgR0Gau1dCpecRqrJICDNbI8tIKBYazKZ+eiJF3IMPrW2
 rAga7e3JfkemVBGx7cLIV39JiZv8DlKZy7Xx8sudEKC2Wa6u0C7X7xR0YpFLgZlQo38VDEz
 Ro6O/YLOSQ8qtlqkySr/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DMrcvKZLe2c=:GljK/BN08zJCcYKWmmTCJu
 zUXpdhsuKZ2PWZl6nk/f21Ra9U865kOcgPAB+lac7HU3DtXHZRdFF8sfr/v5dXAoD9WcGFv0o
 Qfks28aECPpNLmJvLY/djUOUWEdTWscfaBpqtYavwlkJSBHsRTFcipy5dhFrF5Obvqc8am1zF
 WHLD5R64eGJYaLcEoIq+9udX8dQyMW92hdTSFsYW3Oe3m5WloJHGfshWzbMv+84OwZWaYYha6
 ePNw/hCS1ZNvC+2tNkq49TSlheLaIzYf4kFgPinlsoNT6SZ1mbPHCeIp2MkiTLCmF+wJfZeGg
 ltxWjzVagwXHTYUp87IenjjLkd99fFZwbjGkdCUhQHJCT1vOIroNulSkNIIYlEor0j5lhcA+C
 T8qIY+8r1YNXFRQA9QWi1bXgijYP75TATXWoKtq4vl8a+yPKwVXuomXuPg1f2AZG3asfCr7Td
 jNiZEGjiJ3uYyh75r/ryGU1X82s2p/o/A5YjykQ4Hmm8KbuQ5WWbYtGikp+0rNXEuTgq5TyG/
 FWquEvhAqkJuQL9iwX6/cV6eB8NQzaz6caAIpunGDmXAIAj3Xu0hA9cQntO7wWJrY+65M7QwS
 0i+RIjnWdZYPnQYOhU8tZCZMJwABlJTa40S9/IvK6FdSLq1xBcKMVlh2m682oTL2yl47YJ/6N
 /0O76BVBA1u4WZxfGURdOF4+rKGpX3ogwubUys57GVwLG/d1fR5/5N+zwTq2wUS5cKnfQMxiM
 GnLagKPYWd0QSAsISA3PoSTE6EtJftula6Z/rn+46EAvIVd8XJTebQspLbsf2Jad8F1JOnVUL
 tkfuT+Bne7shKIG2nlPPXa0snKxNQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: [Qemu-devel] [PULL 10/14] target/ppc: Rewrite a fall through comment
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
 Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>,
 Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Markus Armbruster <armbru@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

GCC9 is confused by this comment when building with CFLAG
-Wimplicit-fallthrough=2:

  target/ppc/mmu_helper.c: In function ‘dump_mmu’:
  target/ppc/mmu_helper.c:1349:12: error: this statement may fall through [-Werror=implicit-fallthrough=]
   1349 |         if (ppc64_v3_radix(env_archcpu(env))) {
        |            ^
  target/ppc/mmu_helper.c:1356:5: note: here
   1356 |     default:
        |     ^~~~~~~
  cc1: all warnings being treated as errors

Rewrite the comment using 'fall through' which is recognized by
GCC and static analyzers.

Reported-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20190719131425.10835-6-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/ppc/mmu_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 55f7a7f16a12..86c667b09415 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -100,7 +100,7 @@ static int pp_check(int key, int pp, int nx)
         case 0x1:
         case 0x2:
             access |= PAGE_WRITE;
-            /* No break here */
+            /* fall through */
         case 0x3:
             access |= PAGE_READ;
             break;
@@ -708,7 +708,7 @@ static int mmu40x_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
             if (pr != 0) {
                 goto check_perms;
             }
-            /* No break here */
+            /* fall through */
         case 0x3:
             /* All accesses granted */
             ctx->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
@@ -722,7 +722,7 @@ static int mmu40x_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
                 ret = -2;
                 break;
             }
-            /* No break here */
+            /* fall through */
         case 0x1:
         check_perms:
             /* Check from TLB entry */
-- 
2.21.0


