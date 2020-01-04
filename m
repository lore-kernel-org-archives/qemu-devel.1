Return-Path: <SRS0=YGca=2Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1F1C32767
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2020 09:13:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E377B215A4
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2020 09:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E377B215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1infVM-0004lq-2y
	for qemu-devel@archiver.kernel.org; Sat, 04 Jan 2020 04:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <volker.ruemelin@t-online.de>) id 1infT1-0001dx-2R
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 04:11:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <volker.ruemelin@t-online.de>) id 1infSz-0006eg-V6
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 04:11:31 -0500
Received: from mailout06.t-online.de ([194.25.134.19]:33414)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <volker.ruemelin@t-online.de>)
 id 1infSz-0006XP-OV
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 04:11:29 -0500
Received: from fwd16.aul.t-online.de (fwd16.aul.t-online.de [172.20.26.243])
 by mailout06.t-online.de (Postfix) with SMTP id B3A4E41657D5;
 Sat,  4 Jan 2020 10:11:27 +0100 (CET)
Received: from linpower.localnet
 (GQTK2EZXrhlnmiexBFeuF+mabf9XMAlavyrrRvkacjs49ed+hGEgecOY+zv+ghbZgF@[46.86.52.107])
 by fwd16.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1infSx-1UhxJI0; Sat, 4 Jan 2020 10:11:27 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 22F0F20278F; Sat,  4 Jan 2020 10:11:22 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 3/5] paaudio: drop recording stream in qpa_fini_in
Date: Sat,  4 Jan 2020 10:11:20 +0100
Message-Id: <20200104091122.13971-3-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <07d61da6-51fb-8599-ea27-dae828fbdb3c@t-online.de>
References: <07d61da6-51fb-8599-ea27-dae828fbdb3c@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-ID: GQTK2EZXrhlnmiexBFeuF+mabf9XMAlavyrrRvkacjs49ed+hGEgecOY+zv+ghbZgF
X-TOI-MSGID: 7468035e-a24f-4e18-8a4b-0f3a9eb2e8aa
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 194.25.134.19
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
Cc: QEMU <qemu-devel@nongnu.org>,
 =?UTF-8?q?Zolt=C3=A1n=20K=C5=91v=C3=A1g=C3=B3?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Every call to pa_stream_peek which returns a data length > 0
should have a corresponding pa_stream_drop. A call to qpa_read
does not necessarily call pa_stream_drop immediately after a
call to pa_stream_peek. Test in qpa_fini_in if a last
pa_stream_drop is needed.

This prevents following messages in the libvirt log file after
a recording stream gets closed and a new one opened.

pulseaudio: pa_stream_drop failed
pulseaudio: Reason: Bad state
pulseaudio: pa_stream_drop failed
pulseaudio: Reason: Bad state

To reproduce start qemu with
-audiodev pa,id=3Daudio0,in.mixing-engine=3Doff
and in the guest start and stop Audacity several times.

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
---
 audio/paaudio.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index 55a91f8980..7db1dc15f0 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -536,7 +536,6 @@ static void qpa_simple_disconnect(PAConnection *c, pa=
_stream *stream)
 {
     int err;
=20
-    pa_threaded_mainloop_lock(c->mainloop);
     /*
      * wait until actually connects. workaround pa bug #247
      * https://gitlab.freedesktop.org/pulseaudio/pulseaudio/issues/247
@@ -550,7 +549,6 @@ static void qpa_simple_disconnect(PAConnection *c, pa=
_stream *stream)
         dolog("Failed to disconnect! err=3D%d\n", err);
     }
     pa_stream_unref(stream);
-    pa_threaded_mainloop_unlock(c->mainloop);
 }
=20
 static void qpa_fini_out (HWVoiceOut *hw)
@@ -558,8 +556,12 @@ static void qpa_fini_out (HWVoiceOut *hw)
     PAVoiceOut *pa =3D (PAVoiceOut *) hw;
=20
     if (pa->stream) {
-        qpa_simple_disconnect(pa->g->conn, pa->stream);
+        PAConnection *c =3D pa->g->conn;
+
+        pa_threaded_mainloop_lock(c->mainloop);
+        qpa_simple_disconnect(c, pa->stream);
         pa->stream =3D NULL;
+        pa_threaded_mainloop_unlock(c->mainloop);
     }
 }
=20
@@ -568,8 +570,20 @@ static void qpa_fini_in (HWVoiceIn *hw)
     PAVoiceIn *pa =3D (PAVoiceIn *) hw;
=20
     if (pa->stream) {
-        qpa_simple_disconnect(pa->g->conn, pa->stream);
+        PAConnection *c =3D pa->g->conn;
+
+        pa_threaded_mainloop_lock(c->mainloop);
+        if (pa->read_length) {
+            int r =3D pa_stream_drop(pa->stream);
+            if (r) {
+                qpa_logerr(pa_context_errno(c->context),
+                           "pa_stream_drop failed\n");
+            }
+            pa->read_length =3D 0;
+        }
+        qpa_simple_disconnect(c, pa->stream);
         pa->stream =3D NULL;
+        pa_threaded_mainloop_unlock(c->mainloop);
     }
 }
=20
--=20
2.16.4


