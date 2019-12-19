Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB61C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 20:05:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C4D12467B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 20:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4D12467B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii22m-0000TF-8J
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 15:05:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vr_qemu@t-online.de>) id 1ii223-0008OP-01
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 15:04:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vr_qemu@t-online.de>) id 1ii221-0001oN-Qx
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 15:04:22 -0500
Received: from mailout11.t-online.de ([194.25.134.85]:52208)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vr_qemu@t-online.de>) id 1ii221-0001fn-Gz
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 15:04:21 -0500
Received: from fwd02.aul.t-online.de (fwd02.aul.t-online.de [172.20.26.148])
 by mailout11.t-online.de (Postfix) with SMTP id 03819422183B;
 Thu, 19 Dec 2019 21:04:20 +0100 (CET)
Received: from [192.168.211.200]
 (SUGkSqZ1whffNCN1h7XYDfYU8mnY17v7cTj4PoJWrz18QKJbU7CyNfJkRWir9jzgAn@[46.86.55.2])
 by fwd02.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1ii21x-2Fkh4S0; Thu, 19 Dec 2019 21:04:17 +0100
Subject: [PATCH 2/5] hda-codec: fix recording rate control
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
References: <fe427705-ef37-d48e-526c-7dc8025425b6@t-online.de>
Message-ID: <08ea1c13-aa53-31f4-4495-ff4e455ae3ad@t-online.de>
Date: Thu, 19 Dec 2019 21:04:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <fe427705-ef37-d48e-526c-7dc8025425b6@t-online.de>
Content-Type: multipart/alternative;
 boundary="------------96E699F27F3941B227FB4792"
Content-Language: de-DE
X-ID: SUGkSqZ1whffNCN1h7XYDfYU8mnY17v7cTj4PoJWrz18QKJbU7CyNfJkRWir9jzgAn
X-TOI-MSGID: e54a930e-1124-4056-8d16-d18c99b7771d
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 194.25.134.85
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

This is a multi-part message in MIME format.
--------------96E699F27F3941B227FB4792
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Apply previous commit to hda_audio_input_cb for the same
reasons.

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
---
 hw/audio/hda-codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 768ba31e79..e711a99a41 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -265,8 +265,6 @@ static void hda_audio_input_cb(void *opaque, int avai=
l)
=20
     int64_t to_transfer =3D MIN(B_SIZE - (wpos - rpos), avail);
=20
-    hda_timer_sync_adjust(st, -((wpos - rpos) + to_transfer - (B_SIZE >>=
 1)));
-
     while (to_transfer) {
         uint32_t start =3D (uint32_t) (wpos & B_MASK);
         uint32_t chunk =3D (uint32_t) MIN(B_SIZE - start, to_transfer);
@@ -278,6 +276,8 @@ static void hda_audio_input_cb(void *opaque, int avai=
l)
             break;
         }
     }
+
+    hda_timer_sync_adjust(st, -((wpos - rpos) - (B_SIZE >> 1)));
 }
=20
 static void hda_audio_output_timer(void *opaque)
--=20
2.16.4


--------------96E699F27F3941B227FB4792
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <pre>Apply previous commit to hda_audio_input_cb for the same
reasons.

Signed-off-by: Volker R=C3=BCmelin <a class=3D"moz-txt-link-rfc2396E" hre=
f=3D"mailto:vr_qemu@t-online.de">&lt;vr_qemu@t-online.de&gt;</a>
---
 hw/audio/hda-codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 768ba31e79..e711a99a41 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -265,8 +265,6 @@ static void hda_audio_input_cb(void *opaque, int avai=
l)
=20
     int64_t to_transfer =3D MIN(B_SIZE - (wpos - rpos), avail);
=20
-    hda_timer_sync_adjust(st, -((wpos - rpos) + to_transfer - (B_SIZE &g=
t;&gt; 1)));
-
     while (to_transfer) {
         uint32_t start =3D (uint32_t) (wpos &amp; B_MASK);
         uint32_t chunk =3D (uint32_t) MIN(B_SIZE - start, to_transfer);
@@ -278,6 +276,8 @@ static void hda_audio_input_cb(void *opaque, int avai=
l)
             break;
         }
     }
+
+    hda_timer_sync_adjust(st, -((wpos - rpos) - (B_SIZE &gt;&gt; 1)));
 }
=20
 static void hda_audio_output_timer(void *opaque)
--=20
2.16.4

</pre>
  </body>
</html>

--------------96E699F27F3941B227FB4792--

