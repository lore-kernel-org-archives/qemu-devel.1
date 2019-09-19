Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8242CC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 08:41:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5807C21848
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 08:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5807C21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAs0f-0002Sb-T3
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 04:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iArvc-00050V-OS
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iArvb-0000Ah-3z
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58926)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iArva-0000AL-RU
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2E660309BF04;
 Thu, 19 Sep 2019 08:36:38 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CDB401001947;
 Thu, 19 Sep 2019 08:36:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 956619D34; Thu, 19 Sep 2019 10:36:29 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 19 Sep 2019 10:36:08 +0200
Message-Id: <20190919083629.29998-6-kraxel@redhat.com>
In-Reply-To: <20190919083629.29998-1-kraxel@redhat.com>
References: <20190919083629.29998-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 19 Sep 2019 08:36:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 05/26] noaudio: port to the new audio backend api
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
Cc: Kővágó@redhat.com, =?UTF-8?q?Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>

Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
Message-id: 066dc6dd54f4382d80de4376306f585b7fb47805.1568574965.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/noaudio.c | 39 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/audio/noaudio.c b/audio/noaudio.c
index 0fb2629cf283..b054fd225b66 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -41,10 +41,9 @@ typedef struct NoVoiceIn {
     int64_t old_ticks;
 } NoVoiceIn;
=20
-static size_t no_run_out(HWVoiceOut *hw, size_t live)
+static size_t no_write(HWVoiceOut *hw, void *buf, size_t len)
 {
     NoVoiceOut *no =3D (NoVoiceOut *) hw;
-    size_t decr, samples;
     int64_t now;
     int64_t ticks;
     int64_t bytes;
@@ -52,13 +51,9 @@ static size_t no_run_out(HWVoiceOut *hw, size_t live)
     now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     ticks =3D now - no->old_ticks;
     bytes =3D muldiv64(ticks, hw->info.bytes_per_second, NANOSECONDS_PER=
_SECOND);
-    bytes =3D MIN(bytes, SIZE_MAX);
-    samples =3D bytes >> hw->info.shift;
=20
     no->old_ticks =3D now;
-    decr =3D MIN (live, samples);
-    hw->rpos =3D (hw->rpos + decr) % hw->samples;
-    return decr;
+    return MIN(len, bytes);
 }
=20
 static int no_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv=
_opaque)
@@ -92,25 +87,21 @@ static void no_fini_in (HWVoiceIn *hw)
     (void) hw;
 }
=20
-static size_t no_run_in(HWVoiceIn *hw)
+static size_t no_read(HWVoiceIn *hw, void *buf, size_t size)
 {
+    size_t to_clear;
     NoVoiceIn *no =3D (NoVoiceIn *) hw;
-    size_t live =3D audio_pcm_hw_get_live_in(hw);
-    size_t dead =3D hw->samples - live;
-    size_t samples =3D 0;
=20
-    if (dead) {
-        int64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-        int64_t ticks =3D now - no->old_ticks;
-        int64_t bytes =3D
-            muldiv64(ticks, hw->info.bytes_per_second, NANOSECONDS_PER_S=
ECOND);
+    int64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    int64_t ticks =3D now - no->old_ticks;
+    int64_t bytes =3D
+        muldiv64(ticks, hw->info.bytes_per_second, NANOSECONDS_PER_SECON=
D);
=20
-        no->old_ticks =3D now;
-        bytes =3D MIN (bytes, SIZE_MAX);
-        samples =3D bytes >> hw->info.shift;
-        samples =3D MIN (samples, dead);
-    }
-    return samples;
+    no->old_ticks =3D now;
+    to_clear =3D MIN(bytes, size);
+
+    audio_pcm_info_clear_buf(&hw->info, buf, to_clear >> hw->info.shift)=
;
+    return to_clear;
 }
=20
 static int no_ctl_in (HWVoiceIn *hw, int cmd, ...)
@@ -133,12 +124,12 @@ static void no_audio_fini (void *opaque)
 static struct audio_pcm_ops no_pcm_ops =3D {
     .init_out =3D no_init_out,
     .fini_out =3D no_fini_out,
-    .run_out  =3D no_run_out,
+    .write    =3D no_write,
     .ctl_out  =3D no_ctl_out,
=20
     .init_in  =3D no_init_in,
     .fini_in  =3D no_fini_in,
-    .run_in   =3D no_run_in,
+    .read     =3D no_read,
     .ctl_in   =3D no_ctl_in
 };
=20
--=20
2.18.1


