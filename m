Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09961C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 20:06:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E36E2465E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 20:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E36E2465E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii24D-0002GJ-ND
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 15:06:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55967)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vr_qemu@t-online.de>) id 1ii23F-0001Gy-R6
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 15:05:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vr_qemu@t-online.de>) id 1ii23C-0007Gf-VY
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 15:05:37 -0500
Received: from mailout04.t-online.de ([194.25.134.18]:42982)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vr_qemu@t-online.de>) id 1ii23C-00079g-OF
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 15:05:34 -0500
Received: from fwd16.aul.t-online.de (fwd16.aul.t-online.de [172.20.26.243])
 by mailout04.t-online.de (Postfix) with SMTP id 6597341F5AE1;
 Thu, 19 Dec 2019 21:05:33 +0100 (CET)
Received: from [192.168.211.200]
 (VOcBouZTrhWZkVw5BBLrch8uvHDMJpk4IXsLeO4yYELVMU6ZX3FOqxUuaHfHCXmgsW@[46.86.55.2])
 by fwd16.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1ii239-3OJfBg0; Thu, 19 Dec 2019 21:05:31 +0100
Subject: [PATCH 3/5] paaudio: drop recording stream in qpa_fini_in
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
References: <fe427705-ef37-d48e-526c-7dc8025425b6@t-online.de>
Message-ID: <6f2e756e-f498-4dea-03f8-089010624b64@t-online.de>
Date: Thu, 19 Dec 2019 21:05:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <fe427705-ef37-d48e-526c-7dc8025425b6@t-online.de>
Content-Type: text/plain; charset=UTF-8
Content-Language: de-DE
X-ID: VOcBouZTrhWZkVw5BBLrch8uvHDMJpk4IXsLeO4yYELVMU6ZX3FOqxUuaHfHCXmgsW
X-TOI-MSGID: c18584e3-5378-41ab-923e-aea545c5c500
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 194.25.134.18
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
 =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
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
index 55a91f8980..b831e0d6e9 100644
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
+                           "pa_stream_peek failed\n");
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


