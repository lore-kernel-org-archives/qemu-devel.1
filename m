Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1B1C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:41:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB36F20B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB36F20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48164 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZCJG-0004hD-Lm
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 06:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55015)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hZBZ0-0002cT-7O
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:53:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hZBYw-0001ck-9d
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:53:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54458)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hZBYu-0001Ux-80; Fri, 07 Jun 2019 05:53:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BF06E2F8BCF;
 Fri,  7 Jun 2019 09:53:25 +0000 (UTC)
Received: from localhost (dhcp-192-191.str.redhat.com [10.33.192.191])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 677127DFEF;
 Fri,  7 Jun 2019 09:53:25 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  7 Jun 2019 11:52:17 +0200
Message-Id: <20190607095237.11364-16-cohuck@redhat.com>
In-Reply-To: <20190607095237.11364-1-cohuck@redhat.com>
References: <20190607095237.11364-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 07 Jun 2019 09:53:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 15/35] s390x/tcg: Implement VECTOR FP COMPARE
 (AND SIGNAL) SCALAR
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
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

As far as I can see, there is only a tiny difference.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  2 ++
 target/s390x/insn-data.def      |  4 ++++
 target/s390x/translate_vx.inc.c | 21 +++++++++++++++++++++
 target/s390x/vec_fpu_helper.c   | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 21658a277190..d34d6802a605 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -252,6 +252,8 @@ DEF_HELPER_6(gvec_vstrc_cc_rt32, void, ptr, cptr, cpt=
r, cptr, env, i32)
 /* =3D=3D=3D Vector Floating-Point Instructions */
 DEF_HELPER_FLAGS_5(gvec_vfa64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, en=
v, i32)
 DEF_HELPER_FLAGS_5(gvec_vfa64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, e=
nv, i32)
+DEF_HELPER_4(gvec_wfc64, void, cptr, cptr, env, i32)
+DEF_HELPER_4(gvec_wfk64, void, cptr, cptr, env, i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 79892f6042f0..c45e101b1056 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1208,6 +1208,10 @@
=20
 /* VECTOR FP ADD */
     F(0xe7e3, VFA,     VRR_c, V,   0, 0, 0, 0, vfa, 0, IF_VEC)
+/* VECTOR FP COMPARE SCALAR */
+    F(0xe7cb, WFC,     VRR_a, V,   0, 0, 0, 0, wfc, 0, IF_VEC)
+/* VECTOR FP COMPARE AND SIGNAL SCALAR */
+    F(0xe7ca, WFK,     VRR_a, V,   0, 0, 0, 0, wfc, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 44da9f26457b..283e8aa07ae4 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2567,3 +2567,24 @@ static DisasJumpType op_vfa(DisasContext *s, Disas=
Ops *o)
                    get_field(s->fields, v3), cpu_env, 0, fn);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_wfc(DisasContext *s, DisasOps *o)
+{
+    const uint8_t fpf =3D get_field(s->fields, m3);
+    const uint8_t m4 =3D get_field(s->fields, m4);
+
+    if (fpf !=3D FPF_LONG || m4) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    if (s->fields->op2 =3D=3D 0xcb) {
+        gen_gvec_2_ptr(get_field(s->fields, v1), get_field(s->fields, v2=
),
+                       cpu_env, 0, gen_helper_gvec_wfc64);
+    } else {
+        gen_gvec_2_ptr(get_field(s->fields, v1), get_field(s->fields, v2=
),
+                       cpu_env, 0, gen_helper_gvec_wfk64);
+    }
+    set_cc_static(s);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.=
c
index c7db0791d7ca..f9357d922103 100644
--- a/target/s390x/vec_fpu_helper.c
+++ b/target/s390x/vec_fpu_helper.c
@@ -117,3 +117,35 @@ void HELPER(gvec_vfa64s)(void *v1, const void *v2, c=
onst void *v3,
 {
     vop64_3(v1, v2, v3, env, true, vfa64, GETPC());
 }
+
+static int wfc64(const S390Vector *v1, const S390Vector *v2,
+                 CPUS390XState *env, bool signal, uintptr_t retaddr)
+{
+    /* only the zero-indexed elements are compared */
+    const float64 a =3D s390_vec_read_element64(v1, 0);
+    const float64 b =3D s390_vec_read_element64(v2, 0);
+    uint8_t vxc, vec_exc =3D 0;
+    int cmp;
+
+    if (signal) {
+        cmp =3D float64_compare(a, b, &env->fpu_status);
+    } else {
+        cmp =3D float64_compare_quiet(a, b, &env->fpu_status);
+    }
+    vxc =3D check_ieee_exc(env, 0, false, &vec_exc);
+    handle_ieee_exc(env, vxc, vec_exc, retaddr);
+
+    return float_comp_to_cc(env, cmp);
+}
+
+void HELPER(gvec_wfc64)(const void *v1, const void *v2, CPUS390XState *e=
nv,
+                        uint32_t desc)
+{
+    env->cc_op =3D wfc64(v1, v2, env, false, GETPC());
+}
+
+void HELPER(gvec_wfk64)(const void *v1, const void *v2, CPUS390XState *e=
nv,
+                        uint32_t desc)
+{
+    env->cc_op =3D wfc64(v1, v2, env, true, GETPC());
+}
--=20
2.20.1


