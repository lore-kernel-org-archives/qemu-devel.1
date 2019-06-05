Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE29CC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:51:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C954E20866
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C954E20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49753 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYcsD-0000Fb-1v
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 16:51:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hYcdU-0003yJ-6G
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hYcdO-0008Rh-Dq
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:35:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hYcdO-0006tj-0A; Wed, 05 Jun 2019 16:35:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 52F51356DB;
	Wed,  5 Jun 2019 20:34:57 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-124.ams2.redhat.com [10.36.116.124])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CB04818BA6;
	Wed,  5 Jun 2019 20:34:55 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  5 Jun 2019 22:33:53 +0200
Message-Id: <20190605203403.29461-24-david@redhat.com>
In-Reply-To: <20190605203403.29461-1-david@redhat.com>
References: <20190605203403.29461-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Wed, 05 Jun 2019 20:34:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL SUBSYSTEM s390x 23/33] s390x/tcg: Implement
 VECTOR FP MULTIPLY
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

Very similar to VECTOR FP DIVIDE.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  2 ++
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c |  3 +++
 target/s390x/vec_fpu_helper.c   | 17 +++++++++++++++++
 4 files changed, 24 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 7526f8e8c6..22e02a0178 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -282,6 +282,8 @@ DEF_HELPER_FLAGS_4(gvec_vfll32, TCG_CALL_NO_WG, void,=
 ptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vfll32s, TCG_CALL_NO_WG, void, ptr, cptr, env, i=
32)
 DEF_HELPER_FLAGS_4(gvec_vflr64, TCG_CALL_NO_WG, void, ptr, cptr, env, i3=
2)
 DEF_HELPER_FLAGS_4(gvec_vflr64s, TCG_CALL_NO_WG, void, ptr, cptr, env, i=
32)
+DEF_HELPER_FLAGS_5(gvec_vfm64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, en=
v, i32)
+DEF_HELPER_FLAGS_5(gvec_vfm64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, e=
nv, i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index f03914d528..e56059ac34 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1234,6 +1234,8 @@
     F(0xe7c4, VFLL,    VRR_a, V,   0, 0, 0, 0, vfll, 0, IF_VEC)
 /* VECTOR LOAD ROUNDED */
     F(0xe7c5, VFLR,    VRR_a, V,   0, 0, 0, 0, vcdg, 0, IF_VEC)
+/* VECTOR FP MULTIPLY */
+    F(0xe7e7, VFM,     VRR_c, V,   0, 0, 0, 0, vfa, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 73e1b1062a..ae31a327cf 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2563,6 +2563,9 @@ static DisasJumpType op_vfa(DisasContext *s, DisasO=
ps *o)
     case 0xe5:
         fn =3D se ? gen_helper_gvec_vfd64s : gen_helper_gvec_vfd64;
         break;
+    case 0xe7:
+        fn =3D se ? gen_helper_gvec_vfm64s : gen_helper_gvec_vfm64;
+        break;
     default:
         g_assert_not_reached();
     }
diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.=
c
index 764f7379da..57b7fe4aff 100644
--- a/target/s390x/vec_fpu_helper.c
+++ b/target/s390x/vec_fpu_helper.c
@@ -487,3 +487,20 @@ void HELPER(gvec_vflr64s)(void *v1, const void *v2, =
CPUS390XState *env,
=20
     vflr64(v1, v2, env, true, XxC, erm, GETPC());
 }
+
+static uint64_t vfm64(uint64_t a, uint64_t b, float_status *s)
+{
+    return float64_mul(a, b, s);
+}
+
+void HELPER(gvec_vfm64)(void *v1, const void *v2, const void *v3,
+                        CPUS390XState *env, uint32_t desc)
+{
+    vop64_3(v1, v2, v3, env, false, vfm64, GETPC());
+}
+
+void HELPER(gvec_vfm64s)(void *v1, const void *v2, const void *v3,
+                         CPUS390XState *env, uint32_t desc)
+{
+    vop64_3(v1, v2, v3, env, true, vfm64, GETPC());
+}
--=20
2.21.0


