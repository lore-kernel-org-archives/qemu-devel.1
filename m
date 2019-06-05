Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79829C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 21:00:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 336EA2067C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 21:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 336EA2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49963 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYd1m-0000no-DT
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 17:00:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hYcdQ-0003v7-Oc
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:35:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hYcdN-0008Oc-Ex
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:35:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hYcdM-0006Zh-RP; Wed, 05 Jun 2019 16:35:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F1733082A9C;
	Wed,  5 Jun 2019 20:34:42 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-124.ams2.redhat.com [10.36.116.124])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 00A1B619A9;
	Wed,  5 Jun 2019 20:34:40 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  5 Jun 2019 22:33:46 +0200
Message-Id: <20190605203403.29461-17-david@redhat.com>
In-Reply-To: <20190605203403.29461-1-david@redhat.com>
References: <20190605203403.29461-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Wed, 05 Jun 2019 20:34:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL SUBSYSTEM s390x 16/33] s390x/tcg: Implement
 VECTOR FP CONVERT FROM LOGICAL 64-BIT
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  2 ++
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c |  3 +++
 target/s390x/vec_fpu_helper.c   | 23 +++++++++++++++++++++++
 4 files changed, 30 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index a60f4c49fc..6fd996e924 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -268,6 +268,8 @@ DEF_HELPER_5(gvec_vfche64_cc, void, ptr, cptr, cptr, =
env, i32)
 DEF_HELPER_5(gvec_vfche64s_cc, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vcdg64, TCG_CALL_NO_WG, void, ptr, cptr, env, i3=
2)
 DEF_HELPER_FLAGS_4(gvec_vcdg64s, TCG_CALL_NO_WG, void, ptr, cptr, env, i=
32)
+DEF_HELPER_FLAGS_4(gvec_vcdlg64, TCG_CALL_NO_WG, void, ptr, cptr, env, i=
32)
+DEF_HELPER_FLAGS_4(gvec_vcdlg64s, TCG_CALL_NO_WG, void, ptr, cptr, env, =
i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index d3386024c8..465b36dd70 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1220,6 +1220,8 @@
     F(0xe7ea, VFCHE,   VRR_c, V,   0, 0, 0, 0, vfc, 0, IF_VEC)
 /* VECTOR FP CONVERT FROM FIXED 64-BIT */
     F(0xe7c3, VCDG,    VRR_a, V,   0, 0, 0, 0, vcdg, 0, IF_VEC)
+/* VECTOR FP CONVERT FROM LOGICAL 64-BIT */
+    F(0xe7c1, VCDLG,   VRR_a, V,   0, 0, 0, 0, vcdg, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 6741b707cc..fa755cd1d6 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2657,6 +2657,9 @@ static DisasJumpType op_vcdg(DisasContext *s, Disas=
Ops *o)
     case 0xc3:
         fn =3D se ? gen_helper_gvec_vcdg64s : gen_helper_gvec_vcdg64;
         break;
+    case 0xc1:
+        fn =3D se ? gen_helper_gvec_vcdlg64s : gen_helper_gvec_vcdlg64;
+        break;
     default:
         g_assert_not_reached();
     }
diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.=
c
index 53430c7843..181378e167 100644
--- a/target/s390x/vec_fpu_helper.c
+++ b/target/s390x/vec_fpu_helper.c
@@ -300,3 +300,26 @@ void HELPER(gvec_vcdg64s)(void *v1, const void *v2, =
CPUS390XState *env,
=20
     vop64_2(v1, v2, env, true, XxC, erm, vcdg64, GETPC());
 }
+
+static uint64_t vcdlg64(uint64_t a, float_status *s)
+{
+    return uint64_to_float64(a, s);
+}
+
+void HELPER(gvec_vcdlg64)(void *v1, const void *v2, CPUS390XState *env,
+                          uint32_t desc)
+{
+    const uint8_t erm =3D extract32(simd_data(desc), 4, 4);
+    const bool XxC =3D extract32(simd_data(desc), 2, 1);
+
+    vop64_2(v1, v2, env, false, XxC, erm, vcdlg64, GETPC());
+}
+
+void HELPER(gvec_vcdlg64s)(void *v1, const void *v2, CPUS390XState *env,
+                           uint32_t desc)
+{
+    const uint8_t erm =3D extract32(simd_data(desc), 4, 4);
+    const bool XxC =3D extract32(simd_data(desc), 2, 1);
+
+    vop64_2(v1, v2, env, true, XxC, erm, vcdlg64, GETPC());
+}
--=20
2.21.0


