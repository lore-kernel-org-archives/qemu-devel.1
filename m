Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4607C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 10:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 992DD20656
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 10:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 992DD20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46360 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRaZY-000793-RW
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 06:58:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hRa6Z-0006uC-9n
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:28:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hRa1R-0004x4-Qf
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:23:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hRa1R-0004wq-Ll; Fri, 17 May 2019 06:23:29 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 045E7104C1;
	Fri, 17 May 2019 10:23:29 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.100])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7D5C734914;
	Fri, 17 May 2019 10:23:27 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 12:21:21 +0200
Message-Id: <20190517102145.21812-17-david@redhat.com>
In-Reply-To: <20190517102145.21812-1-david@redhat.com>
References: <20190517102145.21812-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Fri, 17 May 2019 10:23:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL SUBSYSTEM s390x 16/40] s390x/tcg: Implement
 VECTOR LOAD POSITIVE
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

Similar to VECTOR LOAD COMPLEMENT.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 07868ff082..fc8886ff42 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1096,6 +1096,8 @@
     F(0xe7bc, VGFMA,   VRR_d, V,   0, 0, 0, 0, vgfma, 0, IF_VEC)
 /* VECTOR LOAD COMPLEMENT */
     F(0xe7de, VLC,     VRR_a, V,   0, 0, 0, 0, vlc, 0, IF_VEC)
+/* VECTOR LOAD POSITIVE */
+    F(0xe7df, VLP,     VRR_a, V,   0, 0, 0, 0, vlp, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 2fc06c7cf3..566a7df6df 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -1537,3 +1537,16 @@ static DisasJumpType op_vlc(DisasContext *s, Disas=
Ops *o)
     gen_gvec_fn_2(neg, es, get_field(s->fields, v1), get_field(s->fields=
, v2));
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vlp(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m3);
+
+    if (es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    gen_gvec_fn_2(abs, es, get_field(s->fields, v1), get_field(s->fields=
, v2));
+    return DISAS_NEXT;
+}
--=20
2.20.1


