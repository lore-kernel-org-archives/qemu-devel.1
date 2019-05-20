Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336BFC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:25:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A246214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A246214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39092 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSm23-0001qK-2q
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 13:25:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hSlnH-0005L5-6F
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hSlnF-0004qo-In
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:09:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hSlnF-0004q8-BD; Mon, 20 May 2019 13:09:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3584F821C3;
	Mon, 20 May 2019 17:09:38 +0000 (UTC)
Received: from localhost (ovpn-204-110.brq.redhat.com [10.40.204.110])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E2A246E64;
	Mon, 20 May 2019 17:09:32 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2019 19:02:44 +0200
Message-Id: <20190520170302.13643-37-cohuck@redhat.com>
In-Reply-To: <20190520170302.13643-1-cohuck@redhat.com>
References: <20190520170302.13643-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Mon, 20 May 2019 17:09:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 36/54] s390x/tcg: Implement VECTOR SHIFT RIGHT
 ARITHMETIC
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
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Similar to VECTOR SHIFT LEFT ARITHMETIC. Add s390_vec_sar() similar to
s390_vec_shr().

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  1 +
 target/s390x/insn-data.def      |  4 ++++
 target/s390x/translate_vx.inc.c | 17 +++++++++++++++++
 target/s390x/vec_int_helper.c   | 26 ++++++++++++++++++++++++++
 4 files changed, 48 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index b4ddc8a7225e..fda274d32575 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -205,6 +205,7 @@ DEF_HELPER_FLAGS_4(gvec_verll16, TCG_CALL_NO_RWG, voi=
d, ptr, cptr, i64, i32)
 DEF_HELPER_FLAGS_4(gvec_verim8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
 DEF_HELPER_FLAGS_4(gvec_verim16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 i32)
 DEF_HELPER_FLAGS_4(gvec_vsl, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_vsra, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i32=
)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 76aec5a21ff6..587de3eaac29 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1166,6 +1166,10 @@
     F(0xe775, VSLB,    VRR_c, V,   0, 0, 0, 0, vsl, 0, IF_VEC)
 /* VECTOR SHIFT LEFT DOUBLE BY BYTE */
     F(0xe777, VSLDB,   VRI_d, V,   0, 0, 0, 0, vsldb, 0, IF_VEC)
+/* VECTOR SHIFT RIGHT ARITHMETIC */
+    F(0xe77e, VSRA,    VRR_c, V,   0, 0, 0, 0, vsra, 0, IF_VEC)
+/* VECTOR SHIFT RIGHT ARITHMETIC BY BYTE */
+    F(0xe77f, VSRAB,   VRR_c, V,   0, 0, 0, 0, vsra, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 43f67e3f82c0..a5636f073309 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2089,3 +2089,20 @@ static DisasJumpType op_vsldb(DisasContext *s, Dis=
asOps *o)
     tcg_temp_free(t2);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vsra(DisasContext *s, DisasOps *o)
+{
+    TCGv_i64 shift =3D tcg_temp_new_i64();
+
+    read_vec_element_i64(shift, get_field(s->fields, v3), 7, ES_8);
+    if (s->fields->op2 =3D=3D 0x7e) {
+        tcg_gen_andi_i64(shift, shift, 0x7);
+    } else {
+        tcg_gen_andi_i64(shift, shift, 0x78);
+    }
+
+    gen_gvec_2i_ool(get_field(s->fields, v1), get_field(s->fields, v2),
+                    shift, 0, gen_helper_gvec_vsra);
+    tcg_temp_free_i64(shift);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.=
c
index 3df069f03319..67e9f2b0eda3 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -49,6 +49,26 @@ static void s390_vec_shl(S390Vector *d, const S390Vect=
or *a, uint64_t count)
     }
 }
=20
+static void s390_vec_sar(S390Vector *d, const S390Vector *a, uint64_t co=
unt)
+{
+    uint64_t tmp;
+
+    if (count =3D=3D 0) {
+        d->doubleword[0] =3D a->doubleword[0];
+        d->doubleword[1] =3D a->doubleword[1];
+    } else if (count =3D=3D 64) {
+        d->doubleword[1] =3D a->doubleword[0];
+        d->doubleword[0] =3D 0;
+    } else if (count < 64) {
+        tmp =3D a->doubleword[1] >> count;
+        d->doubleword[1] =3D deposit64(tmp, 64 - count, count, a->double=
word[0]);
+        d->doubleword[0] =3D (int64_t)a->doubleword[0] >> count;
+    } else {
+        d->doubleword[1] =3D (int64_t)a->doubleword[0] >> (count - 64);
+        d->doubleword[0] =3D 0;
+    }
+}
+
 static void s390_vec_shr(S390Vector *d, const S390Vector *a, uint64_t co=
unt)
 {
     uint64_t tmp;
@@ -535,3 +555,9 @@ void HELPER(gvec_vsl)(void *v1, const void *v2, uint6=
4_t count,
 {
     s390_vec_shl(v1, v2, count);
 }
+
+void HELPER(gvec_vsra)(void *v1, const void *v2, uint64_t count,
+                       uint32_t desc)
+{
+    s390_vec_sar(v1, v2, count);
+}
--=20
2.20.1


