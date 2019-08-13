Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4938DC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 11:19:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18BE720679
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 11:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18BE720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxUpj-0002fh-52
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 07:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41643)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hxUoq-00018Z-7T
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:18:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hxUoo-00051g-DC
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:18:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53080)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hxUom-00050e-Nc
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:18:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B52EE3C93A;
 Tue, 13 Aug 2019 11:18:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com
 [10.36.116.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 043907A228;
 Tue, 13 Aug 2019 11:18:10 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 40C459D12; Tue, 13 Aug 2019 13:18:09 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 13 Aug 2019 13:17:57 +0200
Message-Id: <20190813111809.3141-4-kraxel@redhat.com>
In-Reply-To: <20190813111809.3141-1-kraxel@redhat.com>
References: <20190813111809.3141-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 13 Aug 2019 11:18:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 03/15] audio: add audiodev property to vnc and
 wav_capture
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Kővágó@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Walle <michael@walle.cc>, Gerd Hoffmann <kraxel@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, =?UTF-8?q?Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>

Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-id: ff28a2d4a61be1e7150556342a5fb83aa818c439.1564925486.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc.h        |  2 ++
 monitor/misc.c  | 22 +++++++++++-----------
 ui/vnc.c        | 15 ++++++++++++++-
 hmp-commands.hx | 11 ++++++-----
 qemu-options.hx |  6 ++++++
 5 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/ui/vnc.h b/ui/vnc.h
index 2f84db314216..6f54653455b4 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -183,6 +183,8 @@ struct VncDisplay
 #ifdef CONFIG_VNC_SASL
     VncDisplaySASL sasl;
 #endif
+
+    AudioState *audio_state;
 };
=20
 typedef struct VncTight {
diff --git a/monitor/misc.c b/monitor/misc.c
index e393333a0e13..bdf857555fe9 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -1142,21 +1142,21 @@ static void hmp_stopcapture(Monitor *mon, const Q=
Dict *qdict)
 static void hmp_wavcapture(Monitor *mon, const QDict *qdict)
 {
     const char *path =3D qdict_get_str(qdict, "path");
-    int has_freq =3D qdict_haskey(qdict, "freq");
-    int freq =3D qdict_get_try_int(qdict, "freq", -1);
-    int has_bits =3D qdict_haskey(qdict, "bits");
-    int bits =3D qdict_get_try_int(qdict, "bits", -1);
-    int has_channels =3D qdict_haskey(qdict, "nchannels");
-    int nchannels =3D qdict_get_try_int(qdict, "nchannels", -1);
+    int freq =3D qdict_get_try_int(qdict, "freq", 44100);
+    int bits =3D qdict_get_try_int(qdict, "bits", 16);
+    int nchannels =3D qdict_get_try_int(qdict, "nchannels", 2);
+    const char *audiodev =3D qdict_get_str(qdict, "audiodev");
     CaptureState *s;
+    AudioState *as =3D audio_state_by_name(audiodev);
+
+    if (!as) {
+        monitor_printf(mon, "Audiodev '%s' not found\n", audiodev);
+        return;
+    }
=20
     s =3D g_malloc0 (sizeof (*s));
=20
-    freq =3D has_freq ? freq : 44100;
-    bits =3D has_bits ? bits : 16;
-    nchannels =3D has_channels ? nchannels : 2;
-
-    if (wav_start_capture(NULL, s, path, freq, bits, nchannels)) {
+    if (wav_start_capture(as, s, path, freq, bits, nchannels)) {
         monitor_printf(mon, "Failed to add wave capture\n");
         g_free (s);
         return;
diff --git a/ui/vnc.c b/ui/vnc.c
index 140f364ddacf..24f9be5b5d7e 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1222,7 +1222,7 @@ static void audio_add(VncState *vs)
     ops.destroy =3D audio_capture_destroy;
     ops.capture =3D audio_capture;
=20
-    vs->audio_cap =3D AUD_add_capture(NULL, &vs->as, &ops, vs);
+    vs->audio_cap =3D AUD_add_capture(vs->vd->audio_state, &vs->as, &ops=
, vs);
     if (!vs->audio_cap) {
         error_report("Failed to add audio capture");
     }
@@ -3369,6 +3369,9 @@ static QemuOptsList qemu_vnc_opts =3D {
         },{
             .name =3D "non-adaptive",
             .type =3D QEMU_OPT_BOOL,
+        },{
+            .name =3D "audiodev",
+            .type =3D QEMU_OPT_STRING,
         },
         { /* end of list */ }
     },
@@ -3806,6 +3809,7 @@ void vnc_display_open(const char *id, Error **errp)
     const char *saslauthz;
     int lock_key_sync =3D 1;
     int key_delay_ms;
+    const char *audiodev;
=20
     if (!vd) {
         error_setg(errp, "VNC display not active");
@@ -3991,6 +3995,15 @@ void vnc_display_open(const char *id, Error **errp=
)
     }
     vd->ledstate =3D 0;
=20
+    audiodev =3D qemu_opt_get(opts, "audiodev");
+    if (audiodev) {
+        vd->audio_state =3D audio_state_by_name(audiodev);
+        if (!vd->audio_state) {
+            error_setg(errp, "Audiodev '%s' not found", audiodev);
+            goto fail;
+        }
+    }
+
     device_id =3D qemu_opt_get(opts, "display");
     if (device_id) {
         int head =3D qemu_opt_get_number(opts, "head", 0);
diff --git a/hmp-commands.hx b/hmp-commands.hx
index bfa5681dd257..cfcc044ce4bf 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -819,16 +819,17 @@ ETEXI
=20
     {
         .name       =3D "wavcapture",
-        .args_type  =3D "path:F,freq:i?,bits:i?,nchannels:i?",
-        .params     =3D "path [frequency [bits [channels]]]",
+        .args_type  =3D "path:F,audiodev:s,freq:i?,bits:i?,nchannels:i?"=
,
+        .params     =3D "path audiodev [frequency [bits [channels]]]",
         .help       =3D "capture audio to a wave file (default frequency=
=3D44100 bits=3D16 channels=3D2)",
         .cmd        =3D hmp_wavcapture,
     },
 STEXI
-@item wavcapture @var{filename} [@var{frequency} [@var{bits} [@var{chann=
els}]]]
+@item wavcapture @var{filename} @var{audiodev} [@var{frequency} [@var{bi=
ts} [@var{channels}]]]
 @findex wavcapture
-Capture audio into @var{filename}. Using sample rate @var{frequency}
-bits per sample @var{bits} and number of channels @var{channels}.
+Capture audio into @var{filename} from @var{audiodev}, using sample rate
+@var{frequency} bits per sample @var{bits} and number of channels
+@var{channels}.
=20
 Defaults:
 @itemize @minus
diff --git a/qemu-options.hx b/qemu-options.hx
index 9621e934c0bf..a308e5f5aa5c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1978,6 +1978,12 @@ can help the device and guest to keep up and not l=
ose events in case
 events are arriving in bulk.  Possible causes for the latter are flaky
 network connections, or scripts for automated testing.
=20
+@item audiodev=3D@var{audiodev}
+
+Use the specified @var{audiodev} when the VNC client requests audio
+transmission. When not using an -audiodev argument, this option must
+be omitted, otherwise is must be present and specify a valid audiodev.
+
 @end table
 ETEXI
=20
--=20
2.18.1


