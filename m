Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAAFC76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 11:23:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52DD72173B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 11:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DD72173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoQz8-0007mR-5R
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 07:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37117)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hoQyy-0007Nj-Kp
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 07:23:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hoQyx-0006v4-MA
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 07:23:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40426)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hoQyx-0006uI-HE
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 07:23:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A39AF308620E;
 Fri, 19 Jul 2019 11:23:22 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6640564037;
 Fri, 19 Jul 2019 11:23:18 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 13:23:15 +0200
Message-Id: <20190719112315.14432-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 19 Jul 2019 11:23:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC PATCH-for-4.1] target/i386: Correct misplaced
 break statement in gen_shiftd_rm_T1()
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reported by GCC9 when building with CFLAG -Wimplicit-fallthrough=3D2:

    CC      target/i386/translate.o
  target/i386/translate.c: In function =E2=80=98gen_shiftd_rm_T1=E2=80=99=
:
  target/i386/translate.c:1785:12: error: this statement may fall through=
 [-Werror=3Dimplicit-fallthrough=3D]
   1785 |         if (is_right) {
        |            ^
  target/i386/translate.c:1810:5: note: here
   1810 |     default:
        |     ^~~~~~~
  cc1: all warnings being treated as errors

Fixes: f437d0a3c24
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/i386/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 03150a86e2..4b2b5937ca 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -1805,8 +1805,8 @@ static void gen_shiftd_rm_T1(DisasContext *s, TCGMe=
mOp ot, int op1,
             tcg_gen_shri_i64(s->tmp0, s->tmp0, 32);
             tcg_gen_shri_i64(s->T0, s->T0, 32);
         }
-        break;
 #endif
+        break;
     default:
         tcg_gen_subi_tl(s->tmp0, count, 1);
         if (is_right) {
--=20
2.20.1


