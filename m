Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5D1CA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:48:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C248121897
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C248121897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLN06-0004mt-GY
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 03:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59241)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iLMtY-0006IH-Mz
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:41:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iLMtX-00075v-2j
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:41:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41478)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iLMtW-00075e-QN
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:41:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 122013091782;
 Fri, 18 Oct 2019 07:41:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com
 [10.36.116.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 47D82600C1;
 Fri, 18 Oct 2019 07:41:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3D1AB9B18; Fri, 18 Oct 2019 09:41:44 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/13] audio: make mixeng optional
Date: Fri, 18 Oct 2019 09:41:36 +0200
Message-Id: <20191018074144.24071-6-kraxel@redhat.com>
In-Reply-To: <20191018074144.24071-1-kraxel@redhat.com>
References: <20191018074144.24071-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 18 Oct 2019 07:41:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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

Implementation of the previously added mixing-engine option.

Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
Message-id: c05bc258889ed289e8ee1bdbcc5e84174ec221e7.1570996490.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio_template.h | 24 ++++++++++-----
 audio/audio.c          | 70 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 80 insertions(+), 14 deletions(-)

diff --git a/audio/audio_template.h b/audio/audio_template.h
index 1006d6b1eb8a..3287d7075e6a 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -78,13 +78,17 @@ static void glue (audio_pcm_hw_free_resources_, TYPE)=
 (HW *hw)
=20
 static void glue(audio_pcm_hw_alloc_resources_, TYPE)(HW *hw)
 {
-    size_t samples =3D hw->samples;
-    if (audio_bug(__func__, samples =3D=3D 0)) {
-        dolog("Attempted to allocate empty buffer\n");
-    }
+    if (glue(audio_get_pdo_, TYPE)(hw->s->dev)->mixing_engine) {
+        size_t samples =3D hw->samples;
+        if (audio_bug(__func__, samples =3D=3D 0)) {
+            dolog("Attempted to allocate empty buffer\n");
+        }
=20
-    HWBUF =3D g_malloc0(sizeof(STSampleBuffer) + sizeof(st_sample) * sam=
ples);
-    HWBUF->size =3D samples;
+        HWBUF =3D g_malloc0(sizeof(STSampleBuffer) + sizeof(st_sample) *=
 samples);
+        HWBUF->size =3D samples;
+    } else {
+        HWBUF =3D NULL;
+    }
 }
=20
 static void glue (audio_pcm_sw_free_resources_, TYPE) (SW *sw)
@@ -103,6 +107,10 @@ static int glue (audio_pcm_sw_alloc_resources_, TYPE=
) (SW *sw)
 {
     int samples;
=20
+    if (!glue(audio_get_pdo_, TYPE)(sw->s->dev)->mixing_engine) {
+        return 0;
+    }
+
     samples =3D ((int64_t) sw->HWBUF->size << 32) / sw->ratio;
=20
     sw->buf =3D audio_calloc(__func__, samples, sizeof(struct st_sample)=
);
@@ -328,9 +336,9 @@ static HW *glue(audio_pcm_hw_add_, TYPE)(AudioState *=
s, struct audsettings *as)
     HW *hw;
     AudiodevPerDirectionOptions *pdo =3D glue(audio_get_pdo_, TYPE)(s->d=
ev);
=20
-    if (pdo->fixed_settings) {
+    if (!pdo->mixing_engine || pdo->fixed_settings) {
         hw =3D glue(audio_pcm_hw_add_new_, TYPE)(s, as);
-        if (hw) {
+        if (!pdo->mixing_engine || hw) {
             return hw;
         }
     }
diff --git a/audio/audio.c b/audio/audio.c
index 7128ee98dc97..d616a4af98bd 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -838,32 +838,46 @@ static void audio_timer (void *opaque)
  */
 size_t AUD_write(SWVoiceOut *sw, void *buf, size_t size)
 {
+    HWVoiceOut *hw;
+
     if (!sw) {
         /* XXX: Consider options */
         return size;
     }
+    hw =3D sw->hw;
=20
-    if (!sw->hw->enabled) {
+    if (!hw->enabled) {
         dolog ("Writing to disabled voice %s\n", SW_NAME (sw));
         return 0;
     }
=20
-    return audio_pcm_sw_write(sw, buf, size);
+    if (audio_get_pdo_out(hw->s->dev)->mixing_engine) {
+        return audio_pcm_sw_write(sw, buf, size);
+    } else {
+        return hw->pcm_ops->write(hw, buf, size);
+    }
 }
=20
 size_t AUD_read(SWVoiceIn *sw, void *buf, size_t size)
 {
+    HWVoiceIn *hw;
+
     if (!sw) {
         /* XXX: Consider options */
         return size;
     }
+    hw =3D sw->hw;
=20
-    if (!sw->hw->enabled) {
+    if (!hw->enabled) {
         dolog ("Reading from disabled voice %s\n", SW_NAME (sw));
         return 0;
     }
=20
-    return audio_pcm_sw_read(sw, buf, size);
+    if (audio_get_pdo_in(hw->s->dev)->mixing_engine) {
+        return audio_pcm_sw_read(sw, buf, size);
+    } else {
+        return hw->pcm_ops->read(hw, buf, size);
+    }
 }
=20
 int AUD_get_buffer_size_out (SWVoiceOut *sw)
@@ -1090,6 +1104,26 @@ static void audio_run_out (AudioState *s)
     HWVoiceOut *hw =3D NULL;
     SWVoiceOut *sw;
=20
+    if (!audio_get_pdo_out(s->dev)->mixing_engine) {
+        while ((hw =3D audio_pcm_hw_find_any_enabled_out(s, hw))) {
+            /* there is exactly 1 sw for each hw with no mixeng */
+            sw =3D hw->sw_head.lh_first;
+
+            if (hw->pending_disable) {
+                hw->enabled =3D 0;
+                hw->pending_disable =3D 0;
+                if (hw->pcm_ops->enable_out) {
+                    hw->pcm_ops->enable_out(hw, false);
+                }
+            }
+
+            if (sw->active) {
+                sw->callback.fn(sw->callback.opaque, INT_MAX);
+            }
+        }
+        return;
+    }
+
     while ((hw =3D audio_pcm_hw_find_any_enabled_out(s, hw))) {
         size_t played, live, prev_rpos, free;
         int nb_live, cleanup_required;
@@ -1227,6 +1261,17 @@ static void audio_run_in (AudioState *s)
 {
     HWVoiceIn *hw =3D NULL;
=20
+    if (!audio_get_pdo_in(s->dev)->mixing_engine) {
+        while ((hw =3D audio_pcm_hw_find_any_enabled_in(s, hw))) {
+            /* there is exactly 1 sw for each hw with no mixeng */
+            SWVoiceIn *sw =3D hw->sw_head.lh_first;
+            if (sw->active) {
+                sw->callback.fn(sw->callback.opaque, INT_MAX);
+            }
+        }
+        return;
+    }
+
     while ((hw =3D audio_pcm_hw_find_any_enabled_in(s, hw))) {
         SWVoiceIn *sw;
         size_t captured =3D 0, min;
@@ -1751,6 +1796,11 @@ CaptureVoiceOut *AUD_add_capture(
         s =3D audio_init(NULL, NULL);
     }
=20
+    if (!audio_get_pdo_out(s->dev)->mixing_engine) {
+        dolog("Can't capture with mixeng disabled\n");
+        return NULL;
+    }
+
     if (audio_validate_settings (as)) {
         dolog ("Invalid settings were passed when trying to add capture\=
n");
         audio_print_settings (as);
@@ -1905,9 +1955,13 @@ void audio_create_pdos(Audiodev *dev)
 static void audio_validate_per_direction_opts(
     AudiodevPerDirectionOptions *pdo, Error **errp)
 {
+    if (!pdo->has_mixing_engine) {
+        pdo->has_mixing_engine =3D true;
+        pdo->mixing_engine =3D true;
+    }
     if (!pdo->has_fixed_settings) {
         pdo->has_fixed_settings =3D true;
-        pdo->fixed_settings =3D true;
+        pdo->fixed_settings =3D pdo->mixing_engine;
     }
     if (!pdo->fixed_settings &&
         (pdo->has_frequency || pdo->has_channels || pdo->has_format)) {
@@ -1915,6 +1969,10 @@ static void audio_validate_per_direction_opts(
                    "You can't use frequency, channels or format with fix=
ed-settings=3Doff");
         return;
     }
+    if (!pdo->mixing_engine && pdo->fixed_settings) {
+        error_setg(errp, "You can't use fixed-settings without mixeng");
+        return;
+    }
=20
     if (!pdo->has_frequency) {
         pdo->has_frequency =3D true;
@@ -1926,7 +1984,7 @@ static void audio_validate_per_direction_opts(
     }
     if (!pdo->has_voices) {
         pdo->has_voices =3D true;
-        pdo->voices =3D 1;
+        pdo->voices =3D pdo->mixing_engine ? 1 : INT_MAX;
     }
     if (!pdo->has_format) {
         pdo->has_format =3D true;
--=20
2.18.1


