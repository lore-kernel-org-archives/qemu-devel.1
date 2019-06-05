Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B08C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECDCB2067C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECDCB2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49897 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYczf-0007F7-5W
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 16:58:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hYcdP-0003uG-OU
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:35:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hYcdM-0008Lz-Ln
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:35:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hYcdM-0006wd-8z; Wed, 05 Jun 2019 16:35:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F240730860A3;
	Wed,  5 Jun 2019 20:35:00 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-124.ams2.redhat.com [10.36.116.124])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6F749619A9;
	Wed,  5 Jun 2019 20:34:59 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  5 Jun 2019 22:33:55 +0200
Message-Id: <20190605203403.29461-26-david@redhat.com>
In-Reply-To: <20190605203403.29461-1-david@redhat.com>
References: <20190605203403.29461-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Wed, 05 Jun 2019 20:35:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL SUBSYSTEM s390x 25/33] s390x/tcg: Implement
 VECTOR FP PERFORM SIGN OPERATION
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

The only FP instruction we can implement without an helper.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 52 +++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index e86ade9e44..fa2e801747 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1240,6 +1240,8 @@
     F(0xe78f, VFMA,    VRR_e, V,   0, 0, 0, 0, vfma, 0, IF_VEC)
 /* VECTOR FP MULTIPLY AND SUBTRACT */
     F(0xe78e, VFMS,    VRR_e, V,   0, 0, 0, 0, vfma, 0, IF_VEC)
+/* VECTOR FP PERFORM SIGN OPERATION */
+    F(0xe7cc, VFPSO,   VRR_a, V,   0, 0, 0, 0, vfpso, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index b624c7a8aa..9b8606ba25 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2727,3 +2727,55 @@ static DisasJumpType op_vfma(DisasContext *s, Disa=
sOps *o)
                    0, fn);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vfpso(DisasContext *s, DisasOps *o)
+{
+    const uint8_t v1 =3D get_field(s->fields, v1);
+    const uint8_t v2 =3D get_field(s->fields, v2);
+    const uint8_t fpf =3D get_field(s->fields, m3);
+    const uint8_t m4 =3D get_field(s->fields, m4);
+    const uint8_t m5 =3D get_field(s->fields, m5);
+    TCGv_i64 tmp;
+
+    if (fpf !=3D FPF_LONG || extract32(m4, 0, 3) || m5 > 2) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    if (extract32(m4, 3, 1)) {
+        tmp =3D tcg_temp_new_i64();
+        read_vec_element_i64(tmp, v2, 0, ES_64);
+        switch (m5) {
+        case 0:
+            /* sign bit is inverted (complement) */
+            tcg_gen_xori_i64(tmp, tmp, 1ull << 63);
+            break;
+        case 1:
+            /* sign bit is set to one (negative) */
+            tcg_gen_ori_i64(tmp, tmp, 1ull << 63);
+            break;
+        case 2:
+            /* sign bit is set to zero (positive) */
+            tcg_gen_andi_i64(tmp, tmp, (1ull << 63) - 1);
+            break;
+        }
+        write_vec_element_i64(tmp, v1, 0, ES_64);
+        tcg_temp_free_i64(tmp);
+    } else {
+        switch (m5) {
+        case 0:
+            /* sign bit is inverted (complement) */
+            gen_gvec_fn_2i(xori, ES_64, v1, v2, 1ull << 63);
+            break;
+        case 1:
+            /* sign bit is set to one (negative) */
+            gen_gvec_fn_2i(ori, ES_64, v1, v2, 1ull << 63);
+            break;
+        case 2:
+            /* sign bit is set to zero (positive) */
+            gen_gvec_fn_2i(andi, ES_64, v1, v2, (1ull << 63) - 1);
+            break;
+        }
+    }
+    return DISAS_NEXT;
+}
--=20
2.21.0


