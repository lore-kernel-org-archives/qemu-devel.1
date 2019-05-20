Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EC8C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:22:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 910BD214AE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 17:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 910BD214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39057 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSlzJ-0007dP-LT
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 13:22:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hSln7-0005BX-39
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:09:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hSln5-0004kT-Cm
	for qemu-devel@nongnu.org; Mon, 20 May 2019 13:09:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hSln5-0004jl-6M; Mon, 20 May 2019 13:09:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8CC1372665;
	Mon, 20 May 2019 17:09:25 +0000 (UTC)
Received: from localhost (ovpn-204-110.brq.redhat.com [10.40.204.110])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CCF810027BF;
	Mon, 20 May 2019 17:09:14 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2019 19:02:43 +0200
Message-Id: <20190520170302.13643-36-cohuck@redhat.com>
In-Reply-To: <20190520170302.13643-1-cohuck@redhat.com>
References: <20190520170302.13643-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Mon, 20 May 2019 17:09:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 35/54] s390x/tcg: Implement VECTOR SHIFT LEFT
 DOUBLE BY BYTE
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

Inline expansion courtesy of Richard H.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 2621e433cd03..76aec5a21ff6 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1164,6 +1164,8 @@
     F(0xe774, VSL,     VRR_c, V,   0, 0, 0, 0, vsl, 0, IF_VEC)
 /* VECTOR SHIFT LEFT BY BYTE */
     F(0xe775, VSLB,    VRR_c, V,   0, 0, 0, 0, vsl, 0, IF_VEC)
+/* VECTOR SHIFT LEFT DOUBLE BY BYTE */
+    F(0xe777, VSLDB,   VRI_d, V,   0, 0, 0, 0, vsldb, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 734c022b3610..43f67e3f82c0 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2060,3 +2060,32 @@ static DisasJumpType op_vsl(DisasContext *s, Disas=
Ops *o)
     tcg_temp_free_i64(shift);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vsldb(DisasContext *s, DisasOps *o)
+{
+    const uint8_t i4 =3D get_field(s->fields, i4) & 0xf;
+    const int left_shift =3D (i4 & 7) * 8;
+    const int right_shift =3D 64 - left_shift;
+    TCGv_i64 t0 =3D tcg_temp_new_i64();
+    TCGv_i64 t1 =3D tcg_temp_new_i64();
+    TCGv_i64 t2 =3D tcg_temp_new_i64();
+
+    if ((i4 & 8) =3D=3D 0) {
+        read_vec_element_i64(t0, get_field(s->fields, v2), 0, ES_64);
+        read_vec_element_i64(t1, get_field(s->fields, v2), 1, ES_64);
+        read_vec_element_i64(t2, get_field(s->fields, v3), 0, ES_64);
+    } else {
+        read_vec_element_i64(t0, get_field(s->fields, v2), 1, ES_64);
+        read_vec_element_i64(t1, get_field(s->fields, v3), 0, ES_64);
+        read_vec_element_i64(t2, get_field(s->fields, v3), 1, ES_64);
+    }
+    tcg_gen_extract2_i64(t0, t1, t0, right_shift);
+    tcg_gen_extract2_i64(t1, t2, t1, right_shift);
+    write_vec_element_i64(t0, get_field(s->fields, v1), 0, ES_64);
+    write_vec_element_i64(t1, get_field(s->fields, v1), 1, ES_64);
+
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+    tcg_temp_free(t2);
+    return DISAS_NEXT;
+}
--=20
2.20.1


