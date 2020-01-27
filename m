Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F32C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:25:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9581B2067C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WtIU/I+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9581B2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw3SW-0008S3-Qc
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 07:25:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35345)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iw3O2-0000L7-U9
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:21:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iw3O0-0006oJ-LN
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:21:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48573
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iw3Nz-0006nH-5a
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:20:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580127657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k8YucE4UApzky3K+4WAG+uLtPXit8LdY1RPuICjSYcc=;
 b=WtIU/I+oqvu7+mrZtXrnei7Nc4O2lzsG1gfW04/ZDJJ8XXK6u8nYCBlpCc4VIHbTzEZiRT
 AMSjEshGMjt1IInBTjtXsDhri7xkNQ6IvLpgcK988jj4rUtSiJ5WJPfoAuK66GvnoXZgdg
 yR13fFnr2zmigYNk0Wxz6EXQfLuzZ5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-Msdqpf-iPyS7Xgd6-Dx-3w-1; Mon, 27 Jan 2020 07:20:54 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C140A13E2;
 Mon, 27 Jan 2020 12:20:52 +0000 (UTC)
Received: from localhost (ovpn-116-220.ams2.redhat.com [10.36.116.220])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6472560BF1;
 Mon, 27 Jan 2020 12:20:52 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 09/15] target/s390x: Move struct DisasFields definition earlier
Date: Mon, 27 Jan 2020 13:20:10 +0100
Message-Id: <20200127122016.18752-10-cohuck@redhat.com>
In-Reply-To: <20200127122016.18752-1-cohuck@redhat.com>
References: <20200127122016.18752-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Msdqpf-iPyS7Xgd6-Dx-3w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

We will want to include the struct in DisasContext.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200123232248.1800-2-richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/translate.c | 164 ++++++++++++++++++++-------------------
 1 file changed, 83 insertions(+), 81 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index b764ec3140ff..7ef228843aa4 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -53,6 +53,89 @@ typedef struct DisasContext DisasContext;
 typedef struct DisasInsn DisasInsn;
 typedef struct DisasFields DisasFields;
=20
+/*
+ * Define a structure to hold the decoded fields.  We'll store each inside
+ * an array indexed by an enum.  In order to conserve memory, we'll arrang=
e
+ * for fields that do not exist at the same time to overlap, thus the "C"
+ * for compact.  For checking purposes there is an "O" for original index
+ * as well that will be applied to availability bitmaps.
+ */
+
+enum DisasFieldIndexO {
+    FLD_O_r1,
+    FLD_O_r2,
+    FLD_O_r3,
+    FLD_O_m1,
+    FLD_O_m3,
+    FLD_O_m4,
+    FLD_O_m5,
+    FLD_O_m6,
+    FLD_O_b1,
+    FLD_O_b2,
+    FLD_O_b4,
+    FLD_O_d1,
+    FLD_O_d2,
+    FLD_O_d4,
+    FLD_O_x2,
+    FLD_O_l1,
+    FLD_O_l2,
+    FLD_O_i1,
+    FLD_O_i2,
+    FLD_O_i3,
+    FLD_O_i4,
+    FLD_O_i5,
+    FLD_O_v1,
+    FLD_O_v2,
+    FLD_O_v3,
+    FLD_O_v4,
+};
+
+enum DisasFieldIndexC {
+    FLD_C_r1 =3D 0,
+    FLD_C_m1 =3D 0,
+    FLD_C_b1 =3D 0,
+    FLD_C_i1 =3D 0,
+    FLD_C_v1 =3D 0,
+
+    FLD_C_r2 =3D 1,
+    FLD_C_b2 =3D 1,
+    FLD_C_i2 =3D 1,
+
+    FLD_C_r3 =3D 2,
+    FLD_C_m3 =3D 2,
+    FLD_C_i3 =3D 2,
+    FLD_C_v3 =3D 2,
+
+    FLD_C_m4 =3D 3,
+    FLD_C_b4 =3D 3,
+    FLD_C_i4 =3D 3,
+    FLD_C_l1 =3D 3,
+    FLD_C_v4 =3D 3,
+
+    FLD_C_i5 =3D 4,
+    FLD_C_d1 =3D 4,
+    FLD_C_m5 =3D 4,
+
+    FLD_C_d2 =3D 5,
+    FLD_C_m6 =3D 5,
+
+    FLD_C_d4 =3D 6,
+    FLD_C_x2 =3D 6,
+    FLD_C_l2 =3D 6,
+    FLD_C_v2 =3D 6,
+
+    NUM_C_FIELD =3D 7
+};
+
+struct DisasFields {
+    uint64_t raw_insn;
+    unsigned op:8;
+    unsigned op2:8;
+    unsigned presentC:16;
+    unsigned int presentO;
+    int c[NUM_C_FIELD];
+};
+
 struct DisasContext {
     DisasContextBase base;
     const DisasInsn *insn;
@@ -1005,87 +1088,6 @@ typedef enum {
 #undef F5
 #undef F6
=20
-/* Define a structure to hold the decoded fields.  We'll store each inside
-   an array indexed by an enum.  In order to conserve memory, we'll arrang=
e
-   for fields that do not exist at the same time to overlap, thus the "C"
-   for compact.  For checking purposes there is an "O" for original index
-   as well that will be applied to availability bitmaps.  */
-
-enum DisasFieldIndexO {
-    FLD_O_r1,
-    FLD_O_r2,
-    FLD_O_r3,
-    FLD_O_m1,
-    FLD_O_m3,
-    FLD_O_m4,
-    FLD_O_m5,
-    FLD_O_m6,
-    FLD_O_b1,
-    FLD_O_b2,
-    FLD_O_b4,
-    FLD_O_d1,
-    FLD_O_d2,
-    FLD_O_d4,
-    FLD_O_x2,
-    FLD_O_l1,
-    FLD_O_l2,
-    FLD_O_i1,
-    FLD_O_i2,
-    FLD_O_i3,
-    FLD_O_i4,
-    FLD_O_i5,
-    FLD_O_v1,
-    FLD_O_v2,
-    FLD_O_v3,
-    FLD_O_v4,
-};
-
-enum DisasFieldIndexC {
-    FLD_C_r1 =3D 0,
-    FLD_C_m1 =3D 0,
-    FLD_C_b1 =3D 0,
-    FLD_C_i1 =3D 0,
-    FLD_C_v1 =3D 0,
-
-    FLD_C_r2 =3D 1,
-    FLD_C_b2 =3D 1,
-    FLD_C_i2 =3D 1,
-
-    FLD_C_r3 =3D 2,
-    FLD_C_m3 =3D 2,
-    FLD_C_i3 =3D 2,
-    FLD_C_v3 =3D 2,
-
-    FLD_C_m4 =3D 3,
-    FLD_C_b4 =3D 3,
-    FLD_C_i4 =3D 3,
-    FLD_C_l1 =3D 3,
-    FLD_C_v4 =3D 3,
-
-    FLD_C_i5 =3D 4,
-    FLD_C_d1 =3D 4,
-    FLD_C_m5 =3D 4,
-
-    FLD_C_d2 =3D 5,
-    FLD_C_m6 =3D 5,
-
-    FLD_C_d4 =3D 6,
-    FLD_C_x2 =3D 6,
-    FLD_C_l2 =3D 6,
-    FLD_C_v2 =3D 6,
-
-    NUM_C_FIELD =3D 7
-};
-
-struct DisasFields {
-    uint64_t raw_insn;
-    unsigned op:8;
-    unsigned op2:8;
-    unsigned presentC:16;
-    unsigned int presentO;
-    int c[NUM_C_FIELD];
-};
-
 /* This is the way fields are to be accessed out of DisasFields.  */
 #define have_field(S, F)  have_field1((S), FLD_O_##F)
 #define get_field(S, F)   get_field1((S), FLD_O_##F, FLD_C_##F)
--=20
2.21.1


