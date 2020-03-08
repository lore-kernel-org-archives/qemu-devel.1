Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC018C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 19:34:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9A932067C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 19:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A932067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jB1gx-0003DM-Tg
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 15:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <volker.ruemelin@t-online.de>) id 1jB1g5-0002M8-BM
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 15:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <volker.ruemelin@t-online.de>) id 1jB1g3-0006yz-Ab
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 15:33:32 -0400
Received: from mailout09.t-online.de ([194.25.134.84]:48622)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jB1g3-0006wU-0p
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 15:33:31 -0400
Received: from fwd25.aul.t-online.de (fwd25.aul.t-online.de [172.20.26.130])
 by mailout09.t-online.de (Postfix) with SMTP id 19EDE4230EEB;
 Sun,  8 Mar 2020 20:33:29 +0100 (CET)
Received: from linpower.localnet
 (GWwSMcZCohoZDM9rI++fNADFZQEoH8vN3SJNnetaZW4WDBrCd9lH8gqyjD6HFGTwwa@[79.208.31.100])
 by fwd25.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jB1fw-1s6DFQ0; Sun, 8 Mar 2020 20:33:24 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 94C5D200637; Sun,  8 Mar 2020 20:33:21 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 2/6] audio: change naming scheme of FLOAT_CONV macros
Date: Sun,  8 Mar 2020 20:33:17 +0100
Message-Id: <20200308193321.20668-2-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <2a4ade5f-d39b-3094-578f-6cced4650720@t-online.de>
References: <2a4ade5f-d39b-3094-578f-6cced4650720@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-ID: GWwSMcZCohoZDM9rI++fNADFZQEoH8vN3SJNnetaZW4WDBrCd9lH8gqyjD6HFGTwwa
X-TOI-MSGID: b5b192e7-bc73-4bf1-bcc8-50842ebb173f
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 194.25.134.84
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
Cc: John Arbuckle <programmingkidx@gmail.com>,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, QEMU <qemu-devel@nongnu.org>,
 =?UTF-8?q?Zolt=C3=A1n=20K=C5=91v=C3=A1g=C3=B3?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch changes the naming scheme of the FLOAT_CONV_TO and
FLOAT_CONV_FROM macros to the scheme used in mixeng_template.h.

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
---
 audio/mixeng.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/audio/mixeng.c b/audio/mixeng.c
index c14b0d874c..b57fad83bf 100644
--- a/audio/mixeng.c
+++ b/audio/mixeng.c
@@ -268,17 +268,17 @@ f_sample *mixeng_clip[2][2][2][3] =3D {
 };
=20
 #ifdef FLOAT_MIXENG
-#define FLOAT_CONV_TO(x) (x)
-#define FLOAT_CONV_FROM(x) (x)
+#define CONV_NATURAL_FLOAT(x) (x)
+#define CLIP_NATURAL_FLOAT(x) (x)
 #else
 static const float float_scale =3D UINT_MAX;
-#define FLOAT_CONV_TO(x) ((x) * float_scale)
+#define CONV_NATURAL_FLOAT(x) ((x) * float_scale)
=20
 #ifdef RECIPROCAL
 static const float float_scale_reciprocal =3D 1.f / UINT_MAX;
-#define FLOAT_CONV_FROM(x) ((x) * float_scale_reciprocal)
+#define CLIP_NATURAL_FLOAT(x) ((x) * float_scale_reciprocal)
 #else
-#define FLOAT_CONV_FROM(x) ((x) / float_scale)
+#define CLIP_NATURAL_FLOAT(x) ((x) / float_scale)
 #endif
 #endif
=20
@@ -288,7 +288,7 @@ static void conv_natural_float_to_mono(struct st_samp=
le *dst, const void *src,
     float *in =3D (float *)src;
=20
     while (samples--) {
-        dst->r =3D dst->l =3D FLOAT_CONV_TO(*in++);
+        dst->r =3D dst->l =3D CONV_NATURAL_FLOAT(*in++);
         dst++;
     }
 }
@@ -299,8 +299,8 @@ static void conv_natural_float_to_stereo(struct st_sa=
mple *dst, const void *src,
     float *in =3D (float *)src;
=20
     while (samples--) {
-        dst->l =3D FLOAT_CONV_TO(*in++);
-        dst->r =3D FLOAT_CONV_TO(*in++);
+        dst->l =3D CONV_NATURAL_FLOAT(*in++);
+        dst->r =3D CONV_NATURAL_FLOAT(*in++);
         dst++;
     }
 }
@@ -316,7 +316,7 @@ static void clip_natural_float_from_mono(void *dst, c=
onst struct st_sample *src,
     float *out =3D (float *)dst;
=20
     while (samples--) {
-        *out++ =3D FLOAT_CONV_FROM(src->l) + FLOAT_CONV_FROM(src->r);
+        *out++ =3D CLIP_NATURAL_FLOAT(src->l) + CLIP_NATURAL_FLOAT(src->=
r);
         src++;
     }
 }
@@ -327,8 +327,8 @@ static void clip_natural_float_from_stereo(
     float *out =3D (float *)dst;
=20
     while (samples--) {
-        *out++ =3D FLOAT_CONV_FROM(src->l);
-        *out++ =3D FLOAT_CONV_FROM(src->r);
+        *out++ =3D CLIP_NATURAL_FLOAT(src->l);
+        *out++ =3D CLIP_NATURAL_FLOAT(src->r);
         src++;
     }
 }
--=20
2.16.4


