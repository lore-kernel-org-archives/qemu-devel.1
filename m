Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D48C28CC6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 09:15:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29BBD27F21
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 09:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29BBD27F21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60159 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXj4F-0003il-CE
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 05:15:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hXiwT-00057E-Km
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:07:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hXiwR-0003Uc-M2
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:07:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hXiwQ-0003MA-07; Mon, 03 Jun 2019 05:07:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 09FD35D61E;
	Mon,  3 Jun 2019 09:07:37 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.117.0])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D3D1160C7F;
	Mon,  3 Jun 2019 09:07:32 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 11:06:33 +0200
Message-Id: <20190603090635.10631-21-david@redhat.com>
In-Reply-To: <20190603090635.10631-1-david@redhat.com>
References: <20190603090635.10631-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Mon, 03 Jun 2019 09:07:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 20/22] s390x/tcg: Implement VECTOR FP TEST
 DATA CLASS IMMEDIATE
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
Cc: Thomas Huth <thuth@redhat.com>, Denys Vlasenko <dvlasenk@redhat.com>,
	David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Pino Toscano <ptoscano@redhat.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can reuse float64_dcmask().

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  2 ++
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 21 +++++++++++++++++++
 target/s390x/vec_fpu_helper.c   | 37 +++++++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index c788fc1b7f..e9aff83b05 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -292,6 +292,8 @@ DEF_HELPER_FLAGS_4(gvec_vfsq64, TCG_CALL_NO_WG, void,=
 ptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vfsq64s, TCG_CALL_NO_WG, void, ptr, cptr, env, i=
32)
 DEF_HELPER_FLAGS_5(gvec_vfs64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, en=
v, i32)
 DEF_HELPER_FLAGS_5(gvec_vfs64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, e=
nv, i32)
+DEF_HELPER_4(gvec_vftci64, void, ptr, cptr, env, i32)
+DEF_HELPER_4(gvec_vftci64s, void, ptr, cptr, env, i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 4426f40250..f421184fcd 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1246,6 +1246,8 @@
     F(0xe7ce, VFSQ,    VRR_a, V,   0, 0, 0, 0, vfsq, 0, IF_VEC)
 /* VECTOR FP SUBTRACT */
     F(0xe7e2, VFS,     VRR_c, V,   0, 0, 0, 0, vfa, 0, IF_VEC)
+/* VECTOR FP TEST DATA CLASS IMMEDIATE */
+    F(0xe74a, VFTCI,   VRI_e, V,   0, 0, 0, 0, vftci, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index c0a19aa9f3..69c675e411 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2801,3 +2801,24 @@ static DisasJumpType op_vfsq(DisasContext *s, Disa=
sOps *o)
                    0, fn);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vftci(DisasContext *s, DisasOps *o)
+{
+    const uint16_t i3 =3D get_field(s->fields, i3);
+    const uint8_t fpf =3D get_field(s->fields, m4);
+    const uint8_t m5 =3D get_field(s->fields, m5);
+    gen_helper_gvec_2_ptr *fn =3D gen_helper_gvec_vftci64;
+
+    if (fpf !=3D FPF_LONG || extract32(m5, 0, 3)) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    if (extract32(m5, 3, 1)) {
+        fn =3D gen_helper_gvec_vftci64s;
+    }
+    gen_gvec_2_ptr(get_field(s->fields, v1), get_field(s->fields, v2), c=
pu_env,
+                   i3, fn);
+    set_cc_static(s);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.=
c
index ccdc975628..a48bd704bc 100644
--- a/target/s390x/vec_fpu_helper.c
+++ b/target/s390x/vec_fpu_helper.c
@@ -586,3 +586,40 @@ void HELPER(gvec_vfs64s)(void *v1, const void *v2, c=
onst void *v3,
 {
     vop64_3(v1, v2, v3, env, true, vfs64, GETPC());
 }
+
+static int vftci64(S390Vector *v1, const S390Vector *v2, CPUS390XState *=
env,
+                   bool s, uint16_t i3)
+{
+    int i, match =3D 0;
+
+    for (i =3D 0; i < 2; i++) {
+        float64 a =3D s390_vec_read_element64(v2, i);
+
+        if (float64_dcmask(env, a) & i3) {
+            match++;
+            s390_vec_write_element64(v1, i, -1ull);
+        } else {
+            s390_vec_write_element64(v1, i, 0);
+        }
+        if (s) {
+            break;
+        }
+    }
+
+    if (match) {
+        return s || match =3D=3D 2 ? 0 : 1;
+    }
+    return 3;
+}
+
+void HELPER(gvec_vftci64)(void *v1, const void *v2, CPUS390XState *env,
+                          uint32_t desc)
+{
+    env->cc_op =3D vftci64(v1, v2, env, false, simd_data(desc));
+}
+
+void HELPER(gvec_vftci64s)(void *v1, const void *v2, CPUS390XState *env,
+                           uint32_t desc)
+{
+    env->cc_op =3D vftci64(v1, v2, env, true, simd_data(desc));
+}
--=20
2.21.0


