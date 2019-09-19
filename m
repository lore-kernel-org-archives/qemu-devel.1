Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AB0C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 08:49:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C92221907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 08:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C92221907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAs8M-00030z-2g
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 04:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iArvk-00059b-Il
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iArvd-0000EK-NP
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56304)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iArvd-0000DF-5i
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:36:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 40A0D36955;
 Thu, 19 Sep 2019 08:36:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DDE660872;
 Thu, 19 Sep 2019 08:36:33 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9F3B49D3C; Thu, 19 Sep 2019 10:36:29 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 19 Sep 2019 10:36:09 +0200
Message-Id: <20190919083629.29998-7-kraxel@redhat.com>
In-Reply-To: <20190919083629.29998-1-kraxel@redhat.com>
References: <20190919083629.29998-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 19 Sep 2019 08:36:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 06/26] ossaudio: port to the new audio backend
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
Message-id: 44f4e888975c1d94f5d89e945df9782c0f541582.1568574965.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/ossaudio.c | 288 +++++++++++++++++------------------------------
 1 file changed, 104 insertions(+), 184 deletions(-)

diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 169693368886..278251270691 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -40,19 +40,15 @@
=20
 typedef struct OSSVoiceOut {
     HWVoiceOut hw;
-    void *pcm_buf;
     int fd;
-    int wpos;
     int nfrags;
     int fragsize;
     int mmapped;
-    int pending;
     Audiodev *dev;
 } OSSVoiceOut;
=20
 typedef struct OSSVoiceIn {
     HWVoiceIn hw;
-    void *pcm_buf;
     int fd;
     int nfrags;
     int fragsize;
@@ -371,98 +367,87 @@ static int oss_open(int in, struct oss_params *req,=
 audsettings *as,
     return -1;
 }
=20
-static void oss_write_pending (OSSVoiceOut *oss)
+static size_t oss_get_available_bytes(OSSVoiceOut *oss)
 {
-    HWVoiceOut *hw =3D &oss->hw;
+    int err;
+    struct count_info cntinfo;
+    assert(oss->mmapped);
=20
+    err =3D ioctl(oss->fd, SNDCTL_DSP_GETOPTR, &cntinfo);
+    if (err < 0) {
+        oss_logerr(errno, "SNDCTL_DSP_GETOPTR failed\n");
+        return 0;
+    }
+
+    return audio_ring_dist(cntinfo.ptr, oss->hw.pos_emul, oss->hw.size_e=
mul);
+}
+
+static void *oss_get_buffer_out(HWVoiceOut *hw, size_t *size)
+{
+    OSSVoiceOut *oss =3D (OSSVoiceOut *) hw;
+    if (oss->mmapped) {
+        *size =3D MIN(oss_get_available_bytes(oss), hw->size_emul - hw->=
pos_emul);
+        return hw->buf_emul + hw->pos_emul;
+    } else {
+        return audio_generic_get_buffer_out(hw, size);
+    }
+}
+
+static size_t oss_put_buffer_out(HWVoiceOut *hw, void *buf, size_t size)
+{
+    OSSVoiceOut *oss =3D (OSSVoiceOut *) hw;
     if (oss->mmapped) {
-        return;
+        assert(buf =3D=3D hw->buf_emul + hw->pos_emul && size < hw->size=
_emul);
+
+        hw->pos_emul =3D (hw->pos_emul + size) % hw->size_emul;
+        return size;
+    } else {
+        return audio_generic_put_buffer_out(hw, buf, size);
+    }
+}
+
+static size_t oss_write(HWVoiceOut *hw, void *buf, size_t len)
+{
+    OSSVoiceOut *oss =3D (OSSVoiceOut *) hw;
+    size_t pos;
+
+    if (oss->mmapped) {
+        size_t total_len;
+        len =3D MIN(len, oss_get_available_bytes(oss));
+
+        total_len =3D len;
+        while (len) {
+            size_t to_copy =3D MIN(len, hw->size_emul - hw->pos_emul);
+            memcpy(hw->buf_emul + hw->pos_emul, buf, to_copy);
+
+            hw->pos_emul =3D (hw->pos_emul + to_copy) % hw->pos_emul;
+            buf +=3D to_copy;
+            len -=3D to_copy;
+        }
+        return total_len;
     }
=20
-    while (oss->pending) {
-        int samples_written;
+    pos =3D 0;
+    while (len) {
         ssize_t bytes_written;
-        int samples_till_end =3D hw->samples - oss->wpos;
-        int samples_to_write =3D MIN (oss->pending, samples_till_end);
-        int bytes_to_write =3D samples_to_write << hw->info.shift;
-        void *pcm =3D advance (oss->pcm_buf, oss->wpos << hw->info.shift=
);
+        void *pcm =3D advance(buf, pos);
=20
-        bytes_written =3D write (oss->fd, pcm, bytes_to_write);
+        bytes_written =3D write(oss->fd, pcm, len);
         if (bytes_written < 0) {
             if (errno !=3D EAGAIN) {
-                oss_logerr (errno, "failed to write %d bytes\n",
-                            bytes_to_write);
+                oss_logerr(errno, "failed to write %zu bytes\n",
+                           len);
             }
-            break;
-        }
-
-        if (bytes_written & hw->info.align) {
-            dolog ("misaligned write asked for %d, but got %zd\n",
-                   bytes_to_write, bytes_written);
-            return;
+            return pos;
         }
=20
-        samples_written =3D bytes_written >> hw->info.shift;
-        oss->pending -=3D samples_written;
-        oss->wpos =3D (oss->wpos + samples_written) % hw->samples;
-        if (bytes_written - bytes_to_write) {
+        pos +=3D bytes_written;
+        if (bytes_written < len) {
             break;
         }
+        len -=3D bytes_written;
     }
-}
-
-static size_t oss_run_out(HWVoiceOut *hw, size_t live)
-{
-    OSSVoiceOut *oss =3D (OSSVoiceOut *) hw;
-    int err;
-    size_t decr;
-    struct audio_buf_info abinfo;
-    struct count_info cntinfo;
-    size_t bufsize;
-
-    bufsize =3D hw->samples << hw->info.shift;
-
-    if (oss->mmapped) {
-        int bytes, pos;
-
-        err =3D ioctl (oss->fd, SNDCTL_DSP_GETOPTR, &cntinfo);
-        if (err < 0) {
-            oss_logerr (errno, "SNDCTL_DSP_GETOPTR failed\n");
-            return 0;
-        }
-
-        pos =3D hw->rpos << hw->info.shift;
-        bytes =3D audio_ring_dist (cntinfo.ptr, pos, bufsize);
-        decr =3D MIN (bytes >> hw->info.shift, live);
-    }
-    else {
-        err =3D ioctl (oss->fd, SNDCTL_DSP_GETOSPACE, &abinfo);
-        if (err < 0) {
-            oss_logerr (errno, "SNDCTL_DSP_GETOPTR failed\n");
-            return 0;
-        }
-
-        if (abinfo.bytes > bufsize) {
-            trace_oss_invalid_available_size(abinfo.bytes, bufsize);
-            abinfo.bytes =3D bufsize;
-        }
-
-        if (abinfo.bytes < 0) {
-            trace_oss_invalid_available_size(abinfo.bytes, bufsize);
-            return 0;
-        }
-
-        decr =3D MIN (abinfo.bytes >> hw->info.shift, live);
-        if (!decr) {
-            return 0;
-        }
-    }
-
-    decr =3D audio_pcm_hw_clip_out (hw, oss->pcm_buf, decr, oss->pending=
);
-    oss->pending +=3D decr;
-    oss_write_pending (oss);
-
-    return decr;
+    return pos;
 }
=20
 static void oss_fini_out (HWVoiceOut *hw)
@@ -473,18 +458,13 @@ static void oss_fini_out (HWVoiceOut *hw)
     ldebug ("oss_fini\n");
     oss_anal_close (&oss->fd);
=20
-    if (oss->pcm_buf) {
-        if (oss->mmapped) {
-            err =3D munmap (oss->pcm_buf, hw->samples << hw->info.shift)=
;
-            if (err) {
-                oss_logerr(errno, "Failed to unmap buffer %p, size %zu\n=
",
-                           oss->pcm_buf, hw->samples << hw->info.shift);
-            }
+    if (oss->mmapped && hw->buf_emul) {
+        err =3D munmap(hw->buf_emul, hw->size_emul);
+        if (err) {
+            oss_logerr(errno, "Failed to unmap buffer %p, size %zu\n",
+                       hw->buf_emul, hw->size_emul);
         }
-        else {
-            g_free (oss->pcm_buf);
-        }
-        oss->pcm_buf =3D NULL;
+        hw->buf_emul =3D NULL;
     }
 }
=20
@@ -535,19 +515,20 @@ static int oss_init_out(HWVoiceOut *hw, struct auds=
ettings *as,
=20
     oss->mmapped =3D 0;
     if (oopts->has_try_mmap && oopts->try_mmap) {
-        oss->pcm_buf =3D mmap (
+        hw->size_emul =3D hw->samples << hw->info.shift;
+        hw->buf_emul =3D mmap(
             NULL,
-            hw->samples << hw->info.shift,
+            hw->size_emul,
             PROT_READ | PROT_WRITE,
             MAP_SHARED,
             fd,
             0
             );
-        if (oss->pcm_buf =3D=3D MAP_FAILED) {
+        if (hw->buf_emul =3D=3D MAP_FAILED) {
             oss_logerr(errno, "Failed to map %zu bytes of DAC\n",
-                       hw->samples << hw->info.shift);
-        }
-        else {
+                       hw->size_emul);
+            hw->buf_emul =3D NULL;
+        } else {
             int err;
             int trig =3D 0;
             if (ioctl (fd, SNDCTL_DSP_SETTRIGGER, &trig) < 0) {
@@ -567,30 +548,16 @@ static int oss_init_out(HWVoiceOut *hw, struct auds=
ettings *as,
             }
=20
             if (!oss->mmapped) {
-                err =3D munmap (oss->pcm_buf, hw->samples << hw->info.sh=
ift);
+                err =3D munmap(hw->buf_emul, hw->size_emul);
                 if (err) {
                     oss_logerr(errno, "Failed to unmap buffer %p size %z=
u\n",
-                               oss->pcm_buf, hw->samples << hw->info.shi=
ft);
+                               hw->buf_emul, hw->size_emul);
                 }
+                hw->buf_emul =3D NULL;
             }
         }
     }
=20
-    if (!oss->mmapped) {
-        oss->pcm_buf =3D audio_calloc(__func__,
-                                    hw->samples,
-                                    1 << hw->info.shift);
-        if (!oss->pcm_buf) {
-            dolog (
-                "Could not allocate DAC buffer (%zu samples, each %d byt=
es)\n",
-                hw->samples,
-                1 << hw->info.shift
-                );
-            oss_anal_close (&fd);
-            return -1;
-        }
-    }
-
     oss->fd =3D fd;
     oss->dev =3D dev;
     return 0;
@@ -618,7 +585,7 @@ static int oss_ctl_out (HWVoiceOut *hw, int cmd, ...)
                 return 0;
             }
=20
-            audio_pcm_info_clear_buf (&hw->info, oss->pcm_buf, hw->sampl=
es);
+            audio_pcm_info_clear_buf(&hw->info, hw->buf_emul, hw->sample=
s);
             trig =3D PCM_ENABLE_OUTPUT;
             if (ioctl (oss->fd, SNDCTL_DSP_SETTRIGGER, &trig) < 0) {
                 oss_logerr (
@@ -692,13 +659,6 @@ static int oss_init_in(HWVoiceIn *hw, struct audsett=
ings *as, void *drv_opaque)
     }
=20
     hw->samples =3D (obt.nfrags * obt.fragsize) >> hw->info.shift;
-    oss->pcm_buf =3D audio_calloc(__func__, hw->samples, 1 << hw->info.s=
hift);
-    if (!oss->pcm_buf) {
-        dolog("Could not allocate ADC buffer (%zu samples, each %d bytes=
)\n",
-              hw->samples, 1 << hw->info.shift);
-        oss_anal_close (&fd);
-        return -1;
-    }
=20
     oss->fd =3D fd;
     oss->dev =3D dev;
@@ -710,78 +670,36 @@ static void oss_fini_in (HWVoiceIn *hw)
     OSSVoiceIn *oss =3D (OSSVoiceIn *) hw;
=20
     oss_anal_close (&oss->fd);
-
-    g_free(oss->pcm_buf);
-    oss->pcm_buf =3D NULL;
 }
=20
-static size_t oss_run_in(HWVoiceIn *hw)
+static size_t oss_read(HWVoiceIn *hw, void *buf, size_t len)
 {
     OSSVoiceIn *oss =3D (OSSVoiceIn *) hw;
-    int hwshift =3D hw->info.shift;
-    int i;
-    size_t live =3D audio_pcm_hw_get_live_in (hw);
-    size_t dead =3D hw->samples - live;
-    size_t read_samples =3D 0;
-    struct {
-        size_t add;
-        size_t len;
-    } bufs[2] =3D {
-        { .add =3D hw->wpos, .len =3D 0 },
-        { .add =3D 0,        .len =3D 0 }
-    };
+    size_t pos =3D 0;
=20
-    if (!dead) {
-        return 0;
-    }
-
-    if (hw->wpos + dead > hw->samples) {
-        bufs[0].len =3D (hw->samples - hw->wpos) << hwshift;
-        bufs[1].len =3D (dead - (hw->samples - hw->wpos)) << hwshift;
-    }
-    else {
-        bufs[0].len =3D dead << hwshift;
-    }
-
-    for (i =3D 0; i < 2; ++i) {
+    while (len) {
         ssize_t nread;
=20
-        if (bufs[i].len) {
-            void *p =3D advance (oss->pcm_buf, bufs[i].add << hwshift);
-            nread =3D read (oss->fd, p, bufs[i].len);
+        void *dst =3D advance(buf, pos);
+        nread =3D read(oss->fd, dst, len);
=20
-            if (nread > 0) {
-                if (nread & hw->info.align) {
-                    dolog("warning: Misaligned read %zd (requested %zu),=
 "
-                          "alignment %d\n", nread, bufs[i].add << hwshif=
t,
-                          hw->info.align + 1);
-                }
-                read_samples +=3D nread >> hwshift;
-                hw->conv (hw->conv_buf + bufs[i].add, p, nread >> hwshif=
t);
-            }
-
-            if (bufs[i].len - nread) {
-                if (nread =3D=3D -1) {
-                    switch (errno) {
-                    case EINTR:
-                    case EAGAIN:
-                        break;
-                    default:
-                        oss_logerr(
-                            errno,
-                            "Failed to read %zu bytes of audio (to %p)\n=
",
-                            bufs[i].len, p
-                            );
-                        break;
-                    }
-                }
+        if (nread =3D=3D -1) {
+            switch (errno) {
+            case EINTR:
+            case EAGAIN:
+                break;
+            default:
+                oss_logerr(errno, "Failed to read %zu bytes of audio (to=
 %p)\n",
+                           len, dst);
                 break;
             }
         }
+
+        pos +=3D nread;
+        len -=3D nread;
     }
=20
-    hw->wpos =3D (hw->wpos + read_samples) % hw->samples;
-    return read_samples;
+    return pos;
 }
=20
 static int oss_ctl_in (HWVoiceIn *hw, int cmd, ...)
@@ -845,12 +763,14 @@ static void oss_audio_fini (void *opaque)
 static struct audio_pcm_ops oss_pcm_ops =3D {
     .init_out =3D oss_init_out,
     .fini_out =3D oss_fini_out,
-    .run_out  =3D oss_run_out,
+    .write    =3D oss_write,
+    .get_buffer_out =3D oss_get_buffer_out,
+    .put_buffer_out =3D oss_put_buffer_out,
     .ctl_out  =3D oss_ctl_out,
=20
     .init_in  =3D oss_init_in,
     .fini_in  =3D oss_fini_in,
-    .run_in   =3D oss_run_in,
+    .read     =3D oss_read,
     .ctl_in   =3D oss_ctl_in
 };
=20
--=20
2.18.1


