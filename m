Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA8DC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 19:11:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ECF020842
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 19:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ECF020842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8qT6-0005Aw-Hm
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 14:11:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <volker.ruemelin@t-online.de>) id 1j8qSB-0003u8-Gm
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:10:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <volker.ruemelin@t-online.de>) id 1j8qSA-00055f-Bo
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:10:11 -0500
Received: from mailout07.t-online.de ([194.25.134.83]:44108)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <volker.ruemelin@t-online.de>)
 id 1j8qSA-00053z-2C
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:10:10 -0500
Received: from fwd39.aul.t-online.de (fwd39.aul.t-online.de [172.20.27.138])
 by mailout07.t-online.de (Postfix) with SMTP id 0F1F64208573;
 Mon,  2 Mar 2020 20:10:08 +0100 (CET)
Received: from linpower.localnet
 (VrkvCqZD8hyB-IEMgR48tQuEVgo1weNMjBmBCsLt-LroYYO8PNszmY4LkMXsVpHZpD@[79.208.28.226])
 by fwd39.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1j8qS7-0YCO7k0; Mon, 2 Mar 2020 20:10:07 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 8F8FF21159F; Mon,  2 Mar 2020 20:10:04 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 2/5] audio: change naming scheme of FLOAT_CONV macros
Date: Mon,  2 Mar 2020 20:10:01 +0100
Message-Id: <20200302191004.5991-2-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <417bfe2f-e3c1-d83d-b437-47859daf524d@t-online.de>
References: <417bfe2f-e3c1-d83d-b437-47859daf524d@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-ID: VrkvCqZD8hyB-IEMgR48tQuEVgo1weNMjBmBCsLt-LroYYO8PNszmY4LkMXsVpHZpD
X-TOI-MSGID: ec45cee6-a315-48ed-a0b1-934a4e997b18
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 194.25.134.83
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


