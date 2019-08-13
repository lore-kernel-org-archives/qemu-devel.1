Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9D2C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 11:21:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF05B20651
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 11:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF05B20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxUsA-0000qx-7O
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 07:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41747)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hxUoz-0001Db-Vk
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:18:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hxUoy-00059V-LC
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:18:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35288)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hxUoy-000578-Cl
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:18:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CA4B92F366F;
 Tue, 13 Aug 2019 11:18:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com
 [10.36.116.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 873618E780;
 Tue, 13 Aug 2019 11:18:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6ECE09D21; Tue, 13 Aug 2019 13:18:09 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 13 Aug 2019 13:18:00 +0200
Message-Id: <20190813111809.3141-7-kraxel@redhat.com>
In-Reply-To: <20190813111809.3141-1-kraxel@redhat.com>
References: <20190813111809.3141-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 13 Aug 2019 11:18:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 06/15] audio: audiodev= parameters no longer
 optional when -audiodev present
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

This means you should probably stop using -soundhw (as it doesn't allow
you to specify any options) and add the device manually with -device.
The exception is pcspk, it's currently not possible to manually add it.
To use it with audiodev, use something like this:

    -audiodev id=3Dfoo,... -global isa-pcspk.audiodev=3Dfoo -soundhw pcsp=
k

Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
Message-id: faa22ae99df3a4de8c83effe90ed986460df7b34.1564925486.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 4baa37caac93..d1319581949d 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -101,6 +101,8 @@ const struct mixeng_volume nominal_volume =3D {
 #endif
 };
=20
+static bool legacy_config =3D true;
+
 #ifdef AUDIO_IS_FLAWLESS_AND_NO_CHECKS_ARE_REQURIED
 #error No its not
 #else
@@ -1392,7 +1394,7 @@ static AudiodevListEntry *audiodev_find(
  * if dev =3D=3D NULL =3D> legacy implicit initialization, return the al=
ready created
  *   state or create a new one
  */
-static AudioState *audio_init(Audiodev *dev)
+static AudioState *audio_init(Audiodev *dev, const char *name)
 {
     static bool atexit_registered;
     size_t i;
@@ -1406,12 +1408,13 @@ static AudioState *audio_init(Audiodev *dev)
=20
     if (dev) {
         /* -audiodev option */
+        legacy_config =3D false;
         drvname =3D AudiodevDriver_str(dev->driver);
     } else if (!QTAILQ_EMPTY(&audio_states)) {
-        /*
-         * todo: check for -audiodev once we have normal audiodev select=
ion
-         * support
-         */
+        if (!legacy_config) {
+            dolog("You must specify an audiodev=3D for the device %s\n",=
 name);
+            exit(1);
+        }
         return QTAILQ_FIRST(&audio_states);
     } else {
         /* legacy implicit initialization */
@@ -1518,7 +1521,7 @@ void audio_free_audiodev_list(AudiodevListHead *hea=
d)
 void AUD_register_card (const char *name, QEMUSoundCard *card)
 {
     if (!card->state) {
-        card->state =3D audio_init(NULL);
+        card->state =3D audio_init(NULL, name);
     }
=20
     card->name =3D g_strdup (name);
@@ -1544,8 +1547,11 @@ CaptureVoiceOut *AUD_add_capture(
     struct capture_callback *cb;
=20
     if (!s) {
-        /* todo: remove when we have normal audiodev selection support *=
/
-        s =3D audio_init(NULL);
+        if (!legacy_config) {
+            dolog("You must specify audiodev when trying to capture\n");
+            return NULL;
+        }
+        s =3D audio_init(NULL, NULL);
     }
=20
     if (audio_validate_settings (as)) {
@@ -1776,7 +1782,7 @@ void audio_init_audiodevs(void)
     AudiodevListEntry *e;
=20
     QSIMPLEQ_FOREACH(e, &audiodevs, next) {
-        audio_init(e->dev);
+        audio_init(e->dev, NULL);
     }
 }
=20
--=20
2.18.1


