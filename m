Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D505C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:21:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C4DF21907
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C4DF21907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAci7-0001v1-Qp
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 12:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iAbu7-0000YB-07
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:30:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iAbu5-0007tF-K6
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:30:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45290)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iAbu5-0007sm-DP; Wed, 18 Sep 2019 11:30:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AC84F111B947;
 Wed, 18 Sep 2019 15:30:00 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-119.ams2.redhat.com [10.36.117.119])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 748455D6A5;
 Wed, 18 Sep 2019 15:29:56 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 18 Sep 2019 17:29:03 +0200
Message-Id: <20190918152922.18949-11-david@redhat.com>
In-Reply-To: <20190918152922.18949-1-david@redhat.com>
References: <20190918152922.18949-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Wed, 18 Sep 2019 15:30:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL SUBSYSTEM s390x 10/29] s390x/tcg: MVCS/MVCP:
 Check for special operation exceptions
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's perform the documented checks.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mem_helper.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 86238e0163..20e1ac0ea9 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1960,12 +1960,18 @@ uint32_t HELPER(rrbe)(CPUS390XState *env, uint64_=
t r2)
=20
 uint32_t HELPER(mvcs)(CPUS390XState *env, uint64_t l, uint64_t a1, uint6=
4_t a2)
 {
+    const uint8_t psw_as =3D (env->psw.mask & PSW_MASK_ASC) >> PSW_SHIFT=
_ASC;
     uintptr_t ra =3D GETPC();
     int cc =3D 0, i;
=20
     HELPER_LOG("%s: %16" PRIx64 " %16" PRIx64 " %16" PRIx64 "\n",
                __func__, l, a1, a2);
=20
+    if (!(env->psw.mask & PSW_MASK_DAT) || !(env->cregs[0] & CR0_SECONDA=
RY) ||
+        psw_as =3D=3D AS_HOME || psw_as =3D=3D AS_ACCREG) {
+        s390_program_interrupt(env, PGM_SPECIAL_OP, ILEN_AUTO, ra);
+    }
+
     if (l > 256) {
         /* max 256 */
         l =3D 256;
@@ -1983,12 +1989,18 @@ uint32_t HELPER(mvcs)(CPUS390XState *env, uint64_=
t l, uint64_t a1, uint64_t a2)
=20
 uint32_t HELPER(mvcp)(CPUS390XState *env, uint64_t l, uint64_t a1, uint6=
4_t a2)
 {
+    const uint8_t psw_as =3D (env->psw.mask & PSW_MASK_ASC) >> PSW_SHIFT=
_ASC;
     uintptr_t ra =3D GETPC();
     int cc =3D 0, i;
=20
     HELPER_LOG("%s: %16" PRIx64 " %16" PRIx64 " %16" PRIx64 "\n",
                __func__, l, a1, a2);
=20
+    if (!(env->psw.mask & PSW_MASK_DAT) || !(env->cregs[0] & CR0_SECONDA=
RY) ||
+        psw_as =3D=3D AS_HOME || psw_as =3D=3D AS_ACCREG) {
+        s390_program_interrupt(env, PGM_SPECIAL_OP, ILEN_AUTO, ra);
+    }
+
     if (l > 256) {
         /* max 256 */
         l =3D 256;
--=20
2.21.0


