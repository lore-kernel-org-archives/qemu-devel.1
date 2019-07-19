Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2652C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:16:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C83FC20873
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C83FC20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoSkh-0006T0-Ld
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 09:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60921)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hoSjF-00016L-0f
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:15:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hoSjD-0000so-Vr
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:15:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52998)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hoSjB-0000r4-Pd; Fri, 19 Jul 2019 09:15:13 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 073F0317916B;
 Fri, 19 Jul 2019 13:15:13 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7D9C26E79;
 Fri, 19 Jul 2019 13:15:03 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 15:14:23 +0200
Message-Id: <20190719131425.10835-6-philmd@redhat.com>
In-Reply-To: <20190719131425.10835-1-philmd@redhat.com>
References: <20190719131425.10835-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 19 Jul 2019 13:15:13 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH-for-4.1? 5/7] target/ppc: Rewrite a fall
 through comment
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-block@nongnu.org, Corey Minyard <minyard@acm.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Michael Tokarev <mjt@tls.msk.ru>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

GCC9 is confused by this comment when building with CFLAG
-Wimplicit-fallthrough=3D2:

  target/ppc/mmu_helper.c: In function =E2=80=98dump_mmu=E2=80=99:
  target/ppc/mmu_helper.c:1349:12: error: this statement may fall through=
 [-Werror=3Dimplicit-fallthrough=3D]
   1349 |         if (ppc64_v3_radix(env_archcpu(env))) {
        |            ^
  target/ppc/mmu_helper.c:1356:5: note: here
   1356 |     default:
        |     ^~~~~~~
  cc1: all warnings being treated as errors

Rewrite the comment using 'fall through' which is recognized by
GCC and static analyzers.

Reported-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/ppc/mmu_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 261a8fe707..862824b073 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -98,7 +98,7 @@ static int pp_check(int key, int pp, int nx)
         case 0x1:
         case 0x2:
             access |=3D PAGE_WRITE;
-            /* No break here */
+            /* fall through */
         case 0x3:
             access |=3D PAGE_READ;
             break;
@@ -706,7 +706,7 @@ static int mmu40x_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
             if (pr !=3D 0) {
                 goto check_perms;
             }
-            /* No break here */
+            /* fall through */
         case 0x3:
             /* All accesses granted */
             ctx->prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
@@ -720,7 +720,7 @@ static int mmu40x_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
                 ret =3D -2;
                 break;
             }
-            /* No break here */
+            /* fall through */
         case 0x1:
         check_perms:
             /* Check from TLB entry */
--=20
2.20.1


