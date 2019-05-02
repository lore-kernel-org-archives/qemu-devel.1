Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9296DC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 14:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65DE5205C9
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 14:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65DE5205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51914 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMCcN-0002G0-KR
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 10:23:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCQw-0000Yw-C2
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:11:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCQv-0007QE-Aj
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:11:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hMCQv-0007Pe-4S; Thu, 02 May 2019 10:11:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 66EC3C0578FA;
	Thu,  2 May 2019 14:11:32 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-88.ams2.redhat.com [10.36.117.88])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1061417D58;
	Thu,  2 May 2019 14:11:30 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 16:10:09 +0200
Message-Id: <20190502141019.6385-31-david@redhat.com>
In-Reply-To: <20190502141019.6385-1-david@redhat.com>
References: <20190502141019.6385-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Thu, 02 May 2019 14:11:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 30/40] s390x/tcg: Implement VECTOR SHIFT
 LEFT DOUBLE BY BYTE
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502141009.3vM47fRL44q3jhtBLdr4v-tcEcKbjtn1yp4OwvUZTjk@z>

Inline expansion courtesy of Richard H.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 2621e433cd..76aec5a21f 100644
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
index a776b469d3..fd9c5a46e0 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2056,3 +2056,32 @@ static DisasJumpType op_vsl(DisasContext *s, Disas=
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


