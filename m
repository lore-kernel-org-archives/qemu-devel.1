Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46142C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 11:55:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18BAE2173E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 11:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18BAE2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2wXw-0004s8-R6
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 07:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i2wWI-0003bG-50
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 07:53:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i2wWD-0005z2-3e
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 07:53:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33130)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1i2wWC-0005yl-Se
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 07:53:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4033118C8919;
 Wed, 28 Aug 2019 11:53:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-95.ams2.redhat.com
 [10.36.116.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 527D310016EB;
 Wed, 28 Aug 2019 11:53:33 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8FD2731E86; Wed, 28 Aug 2019 13:53:32 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 13:53:32 +0200
Message-Id: <20190828115332.28760-3-kraxel@redhat.com>
In-Reply-To: <20190828115332.28760-1-kraxel@redhat.com>
References: <20190828115332.28760-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Wed, 28 Aug 2019 11:53:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/2] audio: omitting audiodev= parameter is only
 deprecated
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
Cc: libvir-list@redhat.com, Kővágó@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>

Unfortunately, changes introduced in af2041ed2d "audio: audiodev=3D
parameters no longer optional when -audiodev present" breaks backward
compatibility.  This patch changes the error into a deprecation warning.

Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
Message-id: 02d4328c33455742d01e0b62395013e95293c3ba.1566847960.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio.c        | 8 ++++----
 qemu-deprecated.texi | 7 +++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index ae335dbebb1e..e99fcd0694e9 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1412,8 +1412,9 @@ static AudioState *audio_init(Audiodev *dev, const =
char *name)
         drvname =3D AudiodevDriver_str(dev->driver);
     } else if (!QTAILQ_EMPTY(&audio_states)) {
         if (!legacy_config) {
-            dolog("You must specify an audiodev=3D for the device %s\n",=
 name);
-            exit(1);
+            dolog("Device %s: audiodev default parameter is deprecated, =
please "
+                  "specify audiodev=3D%s\n", name,
+                  QTAILQ_FIRST(&audio_states)->dev->id);
         }
         return QTAILQ_FIRST(&audio_states);
     } else {
@@ -1548,8 +1549,7 @@ CaptureVoiceOut *AUD_add_capture(
=20
     if (!s) {
         if (!legacy_config) {
-            dolog("You must specify audiodev when trying to capture\n");
-            return NULL;
+            dolog("Capturing without setting an audiodev is deprecated\n=
");
         }
         s =3D audio_init(NULL, NULL);
     }
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 00a4b6f35042..9d74a1cfc017 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -72,6 +72,13 @@ backend settings instead of environment variables.  To=
 ease migration to
 the new format, the ``-audiodev-help'' option can be used to convert
 the current values of the environment variables to ``-audiodev'' options=
.
=20
+@subsection Creating sound card devices and vnc without audiodev=3D prop=
erty (since 4.2)
+
+When not using the deprecated legacy audio config, each sound card
+should specify an @code{audiodev=3D} property.  Additionally, when using
+vnc, you should specify an @code{audiodev=3D} propery if you plan to
+transmit audio through the VNC protocol.
+
 @subsection -mon ...,control=3Dreadline,pretty=3Don|off (since 4.1)
=20
 The @code{pretty=3Don|off} switch has no effect for HMP monitors, but is
--=20
2.18.1


