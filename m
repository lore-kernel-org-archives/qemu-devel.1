Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFC3C468BC
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 15:49:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09ECF20840
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 15:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09ECF20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49004 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZH7q-0008My-9Q
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 11:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53760)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hZFiI-0004mC-4c
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:19:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hZFiG-0004zc-Ma
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:19:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37670)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hZFiG-0004y0-Cb; Fri, 07 Jun 2019 10:19:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 90DB6C0524FB;
 Fri,  7 Jun 2019 14:19:23 +0000 (UTC)
Received: from localhost (dhcp-192-191.str.redhat.com [10.33.192.191])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A9A07FE9A;
 Fri,  7 Jun 2019 14:19:23 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  7 Jun 2019 16:17:21 +0200
Message-Id: <20190607141727.29018-29-cohuck@redhat.com>
In-Reply-To: <20190607141727.29018-1-cohuck@redhat.com>
References: <20190607141727.29018-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 07 Jun 2019 14:19:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 28/34] s390x/tcg: Implement VECTOR FP SUBTRACT
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

Similar to VECTOR FP ADD.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  2 ++
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c |  3 +++
 target/s390x/vec_fpu_helper.c   | 17 +++++++++++++++++
 4 files changed, 24 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 23b37af1e492..c788fc1b7fa2 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -290,6 +290,8 @@ DEF_HELPER_FLAGS_6(gvec_vfms64, TCG_CALL_NO_WG, void,=
 ptr, cptr, cptr, cptr, env
 DEF_HELPER_FLAGS_6(gvec_vfms64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, =
cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vfsq64, TCG_CALL_NO_WG, void, ptr, cptr, env, i3=
2)
 DEF_HELPER_FLAGS_4(gvec_vfsq64s, TCG_CALL_NO_WG, void, ptr, cptr, env, i=
32)
+DEF_HELPER_FLAGS_5(gvec_vfs64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, en=
v, i32)
+DEF_HELPER_FLAGS_5(gvec_vfs64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, e=
nv, i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 354252d57cc0..4426f4025075 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1244,6 +1244,8 @@
     F(0xe7cc, VFPSO,   VRR_a, V,   0, 0, 0, 0, vfpso, 0, IF_VEC)
 /* VECTOR FP SQUARE ROOT */
     F(0xe7ce, VFSQ,    VRR_a, V,   0, 0, 0, 0, vfsq, 0, IF_VEC)
+/* VECTOR FP SUBTRACT */
+    F(0xe7e2, VFS,     VRR_c, V,   0, 0, 0, 0, vfa, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 75f3596c4baa..c0a19aa9f3da 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2566,6 +2566,9 @@ static DisasJumpType op_vfa(DisasContext *s, DisasO=
ps *o)
     case 0xe7:
         fn =3D se ? gen_helper_gvec_vfm64s : gen_helper_gvec_vfm64;
         break;
+    case 0xe2:
+        fn =3D se ? gen_helper_gvec_vfs64s : gen_helper_gvec_vfs64;
+        break;
     default:
         g_assert_not_reached();
     }
diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.=
c
index 18773eb559d4..ccdc97562895 100644
--- a/target/s390x/vec_fpu_helper.c
+++ b/target/s390x/vec_fpu_helper.c
@@ -569,3 +569,20 @@ void HELPER(gvec_vfsq64s)(void *v1, const void *v2, =
CPUS390XState *env,
 {
     vop64_2(v1, v2, env, true, false, 0, vfsq64, GETPC());
 }
+
+static uint64_t vfs64(uint64_t a, uint64_t b, float_status *s)
+{
+    return float64_sub(a, b, s);
+}
+
+void HELPER(gvec_vfs64)(void *v1, const void *v2, const void *v3,
+                        CPUS390XState *env, uint32_t desc)
+{
+    vop64_3(v1, v2, v3, env, false, vfs64, GETPC());
+}
+
+void HELPER(gvec_vfs64s)(void *v1, const void *v2, const void *v3,
+                         CPUS390XState *env, uint32_t desc)
+{
+    vop64_3(v1, v2, v3, env, true, vfs64, GETPC());
+}
--=20
2.20.1


