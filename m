Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5683C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 07:13:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0EF4206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 07:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0EF4206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwhXp-0006ad-00
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 02:13:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vr_qemu@t-online.de>) id 1iwhXA-00068R-T6
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 02:13:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vr_qemu@t-online.de>) id 1iwhX9-0006FY-Oy
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 02:13:08 -0500
Received: from mailout08.t-online.de ([194.25.134.20]:48280)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vr_qemu@t-online.de>) id 1iwhX9-0006EZ-GA
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 02:13:07 -0500
Received: from fwd02.aul.t-online.de (fwd02.aul.t-online.de [172.20.26.148])
 by mailout08.t-online.de (Postfix) with SMTP id DF0CB41EA55A;
 Wed, 29 Jan 2020 08:13:04 +0100 (CET)
Received: from [192.168.211.200]
 (GWsm-QZHrhsf+hH2lX0hYgwLRVqhtUJUMUmiXmSWDkIbHofBJ5xAe4NloGVK8P+gko@[93.236.147.123])
 by fwd02.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1iwhX6-2NJXSS0; Wed, 29 Jan 2020 08:13:04 +0100
Subject: [RFC] coreaudio: fix coreaudio_test.diff
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
To: Howard Spoelstra <hsp.cat7@gmail.com>
References: <43D423C6-78D4-4DCE-B97C-0658D3D2E3BD@gmail.com>
 <4021690b-2380-3925-209e-d4cc66928773@gmail.com>
 <5314e860-dffe-3bc0-209f-bd2b937cd0c6@t-online.de>
 <CABLmASGcUVyASudNizcgPshEqahwYt-4m9Z1DXEhVe2vdko9cQ@mail.gmail.com>
 <54f5ddf3-5ea9-bd6d-8c71-edf4db527463@t-online.de>
Message-ID: <f03b7ae9-344c-5a7f-414c-6250a9c5ec2f@t-online.de>
Date: Wed, 29 Jan 2020 08:13:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <54f5ddf3-5ea9-bd6d-8c71-edf4db527463@t-online.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-ID: GWsm-QZHrhsf+hH2lX0hYgwLRVqhtUJUMUmiXmSWDkIbHofBJ5xAe4NloGVK8P+gko
X-TOI-MSGID: 7b99df4c-656d-4aca-8b4f-7d04cbee8c79
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 194.25.134.20
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
Cc: Programmingkid <programmingkidx@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an untested patch that tries to fix the problems in the
patch found at
https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg02142.html.=20

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
---
 audio/audio_template.h | 16 ++++++++--------
 audio/coreaudio.c      |  5 +++++
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/audio/audio_template.h b/audio/audio_template.h
index a7b46b8363..e6724c5d68 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -153,13 +153,6 @@ static int glue (audio_pcm_sw_init_, TYPE) (
     sw->ratio =3D ((int64_t) sw->info.freq << 32) / sw->hw->info.freq;
 #endif
=20
-#ifdef FLOAT_MIXENG
-#ifdef DAC
-    sw->conv =3D mixeng_conv_float;
-#else
-    sw->clip =3D mixeng_clip_float;
-#endif
-#else
 #ifdef DAC
     sw->conv =3D mixeng_conv
 #else
@@ -169,7 +162,6 @@ static int glue (audio_pcm_sw_init_, TYPE) (
         [sw->info.sign]
         [sw->info.swap_endianness]
         [audio_bits_to_index (sw->info.bits)];
-#endif
=20
     sw->name =3D g_strdup (name);
     err =3D glue (audio_pcm_sw_alloc_resources_, TYPE) (sw);
@@ -284,6 +276,13 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioSt=
ate *s,
         goto err1;
     }
=20
+#ifdef FLOAT_MIXENG
+#ifdef DAC
+    hw->clip =3D mixeng_clip_float;
+#else
+    hw->conv =3D mixeng_conv_float;
+#endif
+#else
 #ifdef DAC
     hw->clip =3D mixeng_clip
 #else
@@ -293,6 +292,7 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioSta=
te *s,
         [hw->info.sign]
         [hw->info.swap_endianness]
         [audio_bits_to_index (hw->info.bits)];
+#endif
=20
     glue(audio_pcm_hw_alloc_resources_, TYPE)(hw);
=20
diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index 4e7e509ad0..ff0d23fd7d 100644
--- a/audio/coreaudio.c
+++ b/audio/coreaudio.c
@@ -482,6 +482,7 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct =
audsettings *as,
     Audiodev *dev =3D drv_opaque;
     AudiodevCoreaudioPerDirectionOptions *cpdo =3D dev->u.coreaudio.out;
     int frames;
+    struct audsettings fake_as;
=20
     /* create mutex */
     err =3D pthread_mutex_init(&core->mutex, NULL);
@@ -490,6 +491,10 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct=
 audsettings *as,
         return -1;
     }
=20
+    memcpy(&fake_as, as, sizeof(struct audsettings));
+    as =3D &fake_as;
+    /* size of float is 32bits */
+    as->fmt =3D AUDIO_FORMAT_S32;
     audio_pcm_init_info (&hw->info, as);
=20
     status =3D coreaudio_get_voice(&core->outputDeviceID);
--=20
2.16.4


