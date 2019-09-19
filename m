Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFBDC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 08:53:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 111BB21907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 08:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111BB21907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAsBX-0007FE-IG
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 04:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iArvi-000572-15
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iArve-0000F3-04
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37990)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iArvd-0000D2-96
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3619A8667D;
 Thu, 19 Sep 2019 08:36:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 270F21001947;
 Thu, 19 Sep 2019 08:36:39 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D4D619CAD; Thu, 19 Sep 2019 10:36:29 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 19 Sep 2019 10:36:14 +0200
Message-Id: <20190919083629.29998-12-kraxel@redhat.com>
In-Reply-To: <20190919083629.29998-1-kraxel@redhat.com>
References: <20190919083629.29998-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 19 Sep 2019 08:36:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 11/26] audio: remove remains of the old backend
 api
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
Message-id: 3c160307074a29e5826a89994ab7cfdee7b8ccf8.1568574965.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio_int.h |  7 -------
 audio/audio.c     | 42 ++++++------------------------------------
 2 files changed, 6 insertions(+), 43 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 8fb1ca8a8d0f..c76d7c39e84c 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -153,7 +153,6 @@ struct audio_driver {
 struct audio_pcm_ops {
     int    (*init_out)(HWVoiceOut *hw, audsettings *as, void *drv_opaque=
);
     void   (*fini_out)(HWVoiceOut *hw);
-    size_t (*run_out)(HWVoiceOut *hw, size_t live);
     size_t (*write)   (HWVoiceOut *hw, void *buf, size_t size);
     /*
      * get a buffer that after later can be passed to put_buffer_out; op=
tional
@@ -171,7 +170,6 @@ struct audio_pcm_ops {
=20
     int    (*init_in) (HWVoiceIn *hw, audsettings *as, void *drv_opaque)=
;
     void   (*fini_in) (HWVoiceIn *hw);
-    size_t (*run_in)(HWVoiceIn *hw);
     size_t (*read)    (HWVoiceIn *hw, void *buf, size_t size);
     void  *(*get_buffer_in)(HWVoiceIn *hw, size_t *size);
     void   (*put_buffer_in)(HWVoiceIn *hw, void *buf, size_t size);
@@ -237,11 +235,6 @@ audio_driver *audio_driver_lookup(const char *name);
 void audio_pcm_init_info (struct audio_pcm_info *info, struct audsetting=
s *as);
 void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, i=
nt len);
=20
-size_t audio_pcm_hw_get_live_in(HWVoiceIn *hw);
-
-size_t audio_pcm_hw_clip_out(HWVoiceOut *hw, void *pcm_buf,
-                             size_t live, size_t pending);
-
 int audio_bug (const char *funcname, int cond);
 void *audio_calloc (const char *funcname, int nmemb, size_t size);
=20
diff --git a/audio/audio.c b/audio/audio.c
index e29a1e15eb30..435bcf20c139 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -541,7 +541,7 @@ static size_t audio_pcm_hw_find_min_in (HWVoiceIn *hw=
)
     return m;
 }
=20
-size_t audio_pcm_hw_get_live_in(HWVoiceIn *hw)
+static size_t audio_pcm_hw_get_live_in(HWVoiceIn *hw)
 {
     size_t live =3D hw->total_samples_captured - audio_pcm_hw_find_min_i=
n (hw);
     if (audio_bug(__func__, live > hw->samples)) {
@@ -551,29 +551,7 @@ size_t audio_pcm_hw_get_live_in(HWVoiceIn *hw)
     return live;
 }
=20
-size_t audio_pcm_hw_clip_out(HWVoiceOut *hw, void *pcm_buf,
-                             size_t live, size_t pending)
-{
-    size_t left =3D hw->samples - pending;
-    size_t len =3D MIN (left, live);
-    size_t clipped =3D 0;
-
-    while (len) {
-        struct st_sample *src =3D hw->mix_buf + hw->rpos;
-        uint8_t *dst =3D advance (pcm_buf, hw->rpos << hw->info.shift);
-        size_t samples_till_end_of_buf =3D hw->samples - hw->rpos;
-        size_t samples_to_clip =3D MIN (len, samples_till_end_of_buf);
-
-        hw->clip (dst, src, samples_to_clip);
-
-        hw->rpos =3D (hw->rpos + samples_to_clip) % hw->samples;
-        len -=3D samples_to_clip;
-        clipped +=3D samples_to_clip;
-    }
-    return clipped;
-}
-
-static void audio_pcm_hw_clip_out2(HWVoiceOut *hw, void *pcm_buf, size_t=
 len)
+static void audio_pcm_hw_clip_out(HWVoiceOut *hw, void *pcm_buf, size_t =
len)
 {
     size_t clipped =3D 0;
     size_t pos =3D hw->rpos;
@@ -1083,7 +1061,7 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, =
size_t live)
         }
=20
         decr =3D MIN(size >> hw->info.shift, live);
-        audio_pcm_hw_clip_out2(hw, buf, decr);
+        audio_pcm_hw_clip_out(hw, buf, decr);
         proc =3D hw->pcm_ops->put_buffer_out(hw, buf, decr << hw->info.s=
hift) >>
             hw->info.shift;
=20
@@ -1146,11 +1124,7 @@ static void audio_run_out (AudioState *s)
         }
=20
         prev_rpos =3D hw->rpos;
-        if (hw->pcm_ops->run_out) {
-            played =3D hw->pcm_ops->run_out(hw, live);
-        } else {
-            played =3D audio_pcm_hw_run_out(hw, live);
-        }
+        played =3D audio_pcm_hw_run_out(hw, live);
         replay_audio_out(&played);
         if (audio_bug(__func__, hw->rpos >=3D hw->samples)) {
             dolog("hw->rpos=3D%zu hw->samples=3D%zu played=3D%zu\n",
@@ -1247,12 +1221,8 @@ static void audio_run_in (AudioState *s)
         size_t captured =3D 0, min;
=20
         if (replay_mode !=3D REPLAY_MODE_PLAY) {
-            if (hw->pcm_ops->run_in) {
-                captured =3D hw->pcm_ops->run_in(hw);
-            } else {
-                captured =3D audio_pcm_hw_run_in(
-                    hw, hw->samples - audio_pcm_hw_get_live_in(hw));
-            }
+            captured =3D audio_pcm_hw_run_in(
+                hw, hw->samples - audio_pcm_hw_get_live_in(hw));
         }
         replay_audio_in(&captured, hw->conv_buf, &hw->wpos, hw->samples)=
;
=20
--=20
2.18.1


