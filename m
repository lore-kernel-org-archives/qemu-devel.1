Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6103EC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:19:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 363552080C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363552080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48520 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZCu4-0006Bb-Qq
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 07:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55237)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hZBZJ-0002qu-Q7
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hZBZD-0002Dw-Qm
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:53:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54602)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hZBZB-00024J-KO; Fri, 07 Jun 2019 05:53:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5330C2F8BDF;
 Fri,  7 Jun 2019 09:53:44 +0000 (UTC)
Received: from localhost (dhcp-192-191.str.redhat.com [10.33.192.191])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F32A37DFE0;
 Fri,  7 Jun 2019 09:53:43 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  7 Jun 2019 11:52:22 +0200
Message-Id: <20190607095237.11364-21-cohuck@redhat.com>
In-Reply-To: <20190607095237.11364-1-cohuck@redhat.com>
References: <20190607095237.11364-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 07 Jun 2019 09:53:44 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 20/35] s390x/tcg: Implement VECTOR FP CONVERT TO
 LOGICAL 64-BIT
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  2 ++
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c |  3 +++
 target/s390x/vec_fpu_helper.c   | 23 +++++++++++++++++++++++
 4 files changed, 30 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 9893c677da1b..9b9062970ac4 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -272,6 +272,8 @@ DEF_HELPER_FLAGS_4(gvec_vcdlg64, TCG_CALL_NO_WG, void=
, ptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vcdlg64s, TCG_CALL_NO_WG, void, ptr, cptr, env, =
i32)
 DEF_HELPER_FLAGS_4(gvec_vcgd64, TCG_CALL_NO_WG, void, ptr, cptr, env, i3=
2)
 DEF_HELPER_FLAGS_4(gvec_vcgd64s, TCG_CALL_NO_WG, void, ptr, cptr, env, i=
32)
+DEF_HELPER_FLAGS_4(gvec_vclgd64, TCG_CALL_NO_WG, void, ptr, cptr, env, i=
32)
+DEF_HELPER_FLAGS_4(gvec_vclgd64s, TCG_CALL_NO_WG, void, ptr, cptr, env, =
i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 97c62a8af5f4..ed8b888d5908 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1224,6 +1224,8 @@
     F(0xe7c1, VCDLG,   VRR_a, V,   0, 0, 0, 0, vcdg, 0, IF_VEC)
 /* VECTOR FP CONVERT TO FIXED 64-BIT */
     F(0xe7c2, VCGD,    VRR_a, V,   0, 0, 0, 0, vcdg, 0, IF_VEC)
+/* VECTOR FP CONVERT TO LOGICAL 64-BIT */
+    F(0xe7c0, VCLGD,   VRR_a, V,   0, 0, 0, 0, vcdg, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index a42de2ff01e7..0395d69968da 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2663,6 +2663,9 @@ static DisasJumpType op_vcdg(DisasContext *s, Disas=
Ops *o)
     case 0xc2:
         fn =3D se ? gen_helper_gvec_vcgd64s : gen_helper_gvec_vcgd64;
         break;
+    case 0xc0:
+        fn =3D se ? gen_helper_gvec_vclgd64s : gen_helper_gvec_vclgd64;
+        break;
     default:
         g_assert_not_reached();
     }
diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.=
c
index e7251aca0463..09ef0abfb0d8 100644
--- a/target/s390x/vec_fpu_helper.c
+++ b/target/s390x/vec_fpu_helper.c
@@ -346,3 +346,26 @@ void HELPER(gvec_vcgd64s)(void *v1, const void *v2, =
CPUS390XState *env,
=20
     vop64_2(v1, v2, env, true, XxC, erm, vcgd64, GETPC());
 }
+
+static uint64_t vclgd64(uint64_t a, float_status *s)
+{
+    return float64_to_uint64(a, s);
+}
+
+void HELPER(gvec_vclgd64)(void *v1, const void *v2, CPUS390XState *env,
+                          uint32_t desc)
+{
+    const uint8_t erm =3D extract32(simd_data(desc), 4, 4);
+    const bool XxC =3D extract32(simd_data(desc), 2, 1);
+
+    vop64_2(v1, v2, env, false, XxC, erm, vclgd64, GETPC());
+}
+
+void HELPER(gvec_vclgd64s)(void *v1, const void *v2, CPUS390XState *env,
+                           uint32_t desc)
+{
+    const uint8_t erm =3D extract32(simd_data(desc), 4, 4);
+    const bool XxC =3D extract32(simd_data(desc), 2, 1);
+
+    vop64_2(v1, v2, env, true, XxC, erm, vclgd64, GETPC());
+}
--=20
2.20.1


