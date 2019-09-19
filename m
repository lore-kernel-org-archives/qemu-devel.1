Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30BBC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 08:38:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8E77217D6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 08:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E77217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iArxo-0007FY-OS
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 04:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iArve-00052F-4x
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iArvb-0000BU-D4
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34766)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iArvb-0000AP-2C
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 613B0308FBFC;
 Thu, 19 Sep 2019 08:36:38 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 31D735C21E;
 Thu, 19 Sep 2019 08:36:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 812A49D75; Thu, 19 Sep 2019 10:36:29 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 19 Sep 2019 10:36:06 +0200
Message-Id: <20190919083629.29998-4-kraxel@redhat.com>
In-Reply-To: <20190919083629.29998-1-kraxel@redhat.com>
References: <20190919083629.29998-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 19 Sep 2019 08:36:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 03/26] coreaudio: port to the new audio backend
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
Message-id: 60d68c051ed180c7315f7cdd6084b58b6fc9bb6d.1568574965.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/coreaudio.c | 130 ++++++++++++++++++++++++----------------------
 1 file changed, 69 insertions(+), 61 deletions(-)

diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index d1be58b40aa8..5cde42f9826c 100644
--- a/audio/coreaudio.c
+++ b/audio/coreaudio.c
@@ -43,9 +43,6 @@ typedef struct coreaudioVoiceOut {
     UInt32 audioDevicePropertyBufferFrameSize;
     AudioStreamBasicDescription outputStreamBasicDescription;
     AudioDeviceIOProcID ioprocid;
-    size_t live;
-    size_t decr;
-    size_t rpos;
 } coreaudioVoiceOut;
=20
 #if MAC_OS_X_VERSION_MAX_ALLOWED >=3D MAC_OS_X_VERSION_10_6
@@ -397,31 +394,29 @@ static int coreaudio_unlock (coreaudioVoiceOut *cor=
e, const char *fn_name)
     return 0;
 }
=20
-static size_t coreaudio_run_out(HWVoiceOut *hw, size_t live)
-{
-    size_t decr;
-    coreaudioVoiceOut *core =3D (coreaudioVoiceOut *) hw;
-
-    if (coreaudio_lock (core, "coreaudio_run_out")) {
-        return 0;
+#define COREAUDIO_WRAPPER_FUNC(name, ret_type, args_decl, args) \
+    static ret_type glue(coreaudio_, name)args_decl             \
+    {                                                           \
+        coreaudioVoiceOut *core =3D (coreaudioVoiceOut *) hw;     \
+        ret_type ret;                                           \
+                                                                \
+        if (coreaudio_lock(core, "coreaudio_" #name)) {         \
+            return 0;                                           \
+        }                                                       \
+                                                                \
+        ret =3D glue(audio_generic_, name)args;                   \
+                                                                \
+        coreaudio_unlock(core, "coreaudio_" #name);             \
+        return ret;                                             \
     }
-
-    if (core->decr > live) {
-        ldebug ("core->decr %d live %d core->live %d\n",
-                core->decr,
-                live,
-                core->live);
-    }
-
-    decr =3D MIN (core->decr, live);
-    core->decr -=3D decr;
-
-    core->live =3D live - decr;
-    hw->rpos =3D core->rpos;
-
-    coreaudio_unlock (core, "coreaudio_run_out");
-    return decr;
-}
+COREAUDIO_WRAPPER_FUNC(get_buffer_out, void *, (HWVoiceOut *hw, size_t *=
size),
+                       (hw, size))
+COREAUDIO_WRAPPER_FUNC(put_buffer_out_nowrite, size_t,
+                       (HWVoiceOut *hw, void *buf, size_t size),
+                       (hw, buf, size))
+COREAUDIO_WRAPPER_FUNC(write, size_t, (HWVoiceOut *hw, void *buf, size_t=
 size),
+                       (hw, buf, size))
+#undef COREAUDIO_WRAPPER_FUNC
=20
 /* callback to feed audiooutput buffer */
 static OSStatus audioDeviceIOProc(
@@ -433,19 +428,11 @@ static OSStatus audioDeviceIOProc(
     const AudioTimeStamp* inOutputTime,
     void* hwptr)
 {
-    UInt32 frame, frameCount;
-    float *out =3D outOutputData->mBuffers[0].mData;
+    UInt32 frameCount, pending_frames;
+    void *out =3D outOutputData->mBuffers[0].mData;
     HWVoiceOut *hw =3D hwptr;
     coreaudioVoiceOut *core =3D (coreaudioVoiceOut *) hwptr;
-    int rpos, live;
-    struct st_sample *src;
-#ifndef FLOAT_MIXENG
-#ifdef RECIPROCAL
-    const float scale =3D 1.f / UINT_MAX;
-#else
-    const float scale =3D UINT_MAX;
-#endif
-#endif
+    size_t len;
=20
     if (coreaudio_lock (core, "audioDeviceIOProc")) {
         inInputTime =3D 0;
@@ -453,42 +440,51 @@ static OSStatus audioDeviceIOProc(
     }
=20
     frameCount =3D core->audioDevicePropertyBufferFrameSize;
-    live =3D core->live;
+    pending_frames =3D hw->pending_emul >> hw->info.shift;
=20
     /* if there are not enough samples, set signal and return */
-    if (live < frameCount) {
+    if (pending_frames < frameCount) {
         inInputTime =3D 0;
         coreaudio_unlock (core, "audioDeviceIOProc(empty)");
         return 0;
     }
=20
-    rpos =3D core->rpos;
-    src =3D hw->mix_buf + rpos;
+    len =3D frameCount << hw->info.shift;
+    while (len) {
+        size_t write_len;
+        ssize_t start =3D ((ssize_t) hw->pos_emul) - hw->pending_emul;
+        if (start < 0) {
+            start +=3D hw->size_emul;
+        }
+        assert(start >=3D 0 && start < hw->size_emul);
=20
-    /* fill buffer */
-    for (frame =3D 0; frame < frameCount; frame++) {
-#ifdef FLOAT_MIXENG
-        *out++ =3D src[frame].l; /* left channel */
-        *out++ =3D src[frame].r; /* right channel */
-#else
-#ifdef RECIPROCAL
-        *out++ =3D src[frame].l * scale; /* left channel */
-        *out++ =3D src[frame].r * scale; /* right channel */
-#else
-        *out++ =3D src[frame].l / scale; /* left channel */
-        *out++ =3D src[frame].r / scale; /* right channel */
-#endif
-#endif
+        write_len =3D MIN(MIN(hw->pending_emul, len),
+                        hw->size_emul - start);
+
+        memcpy(out, hw->buf_emul + start, write_len);
+        hw->pending_emul -=3D write_len;
+        len -=3D write_len;
+        out +=3D write_len;
     }
=20
-    rpos =3D (rpos + frameCount) % hw->samples;
-    core->decr +=3D frameCount;
-    core->rpos =3D rpos;
-
     coreaudio_unlock (core, "audioDeviceIOProc");
     return 0;
 }
=20
+static UInt32 coreaudio_get_flags(struct audio_pcm_info *info,
+                                  struct audsettings *as)
+{
+    UInt32 flags =3D info->sign ? kAudioFormatFlagIsSignedInteger : 0;
+    if (as->endianness) { /* 0 =3D little, 1 =3D big */
+        flags |=3D kAudioFormatFlagIsBigEndian;
+    }
+
+    if (flags =3D=3D 0) { /* must not be 0 */
+        flags =3D kAudioFormatFlagsAreAllClear;
+    }
+    return flags;
+}
+
 static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as,
                               void *drv_opaque)
 {
@@ -576,6 +572,16 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct=
 audsettings *as,
=20
     /* set Samplerate */
     core->outputStreamBasicDescription.mSampleRate =3D (Float64) as->fre=
q;
+    core->outputStreamBasicDescription.mFormatID =3D kAudioFormatLinearP=
CM;
+    core->outputStreamBasicDescription.mFormatFlags =3D
+        coreaudio_get_flags(&hw->info, as);
+    core->outputStreamBasicDescription.mBytesPerPacket =3D
+        core->outputStreamBasicDescription.mBytesPerFrame =3D
+        hw->info.nchannels * hw->info.bits / 8;
+    core->outputStreamBasicDescription.mFramesPerPacket =3D 1;
+    core->outputStreamBasicDescription.mChannelsPerFrame =3D hw->info.nc=
hannels;
+    core->outputStreamBasicDescription.mBitsPerChannel =3D hw->info.bits=
;
+
     status =3D coreaudio_set_streamformat(core->outputDeviceID,
                                         &core->outputStreamBasicDescript=
ion);
     if (status !=3D kAudioHardwareNoError) {
@@ -686,7 +692,9 @@ static void coreaudio_audio_fini (void *opaque)
 static struct audio_pcm_ops coreaudio_pcm_ops =3D {
     .init_out =3D coreaudio_init_out,
     .fini_out =3D coreaudio_fini_out,
-    .run_out  =3D coreaudio_run_out,
+    .write    =3D coreaudio_write,
+    .get_buffer_out =3D coreaudio_get_buffer_out,
+    .put_buffer_out =3D coreaudio_put_buffer_out_nowrite,
     .ctl_out  =3D coreaudio_ctl_out
 };
=20
--=20
2.18.1


