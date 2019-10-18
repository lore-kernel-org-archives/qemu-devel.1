Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82B1CA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B078921D80
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B078921D80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLMvJ-00088r-EZ
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 03:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iLMtW-0006FA-3E
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:41:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iLMtV-00072v-2M
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:41:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56964)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iLMtT-00071T-76
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:41:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E8F7E3001FEB;
 Fri, 18 Oct 2019 07:41:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com
 [10.36.116.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CED275D9D5;
 Fri, 18 Oct 2019 07:41:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 28A3C9D31; Fri, 18 Oct 2019 09:41:44 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/13] audio: paaudio: ability to specify stream name
Date: Fri, 18 Oct 2019 09:41:34 +0200
Message-Id: <20191018074144.24071-4-kraxel@redhat.com>
In-Reply-To: <20191018074144.24071-1-kraxel@redhat.com>
References: <20191018074144.24071-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 18 Oct 2019 07:41:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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

This can be used to identify stream in tools like pavucontrol when one
creates multiple -audiodevs or runs multiple qemu instances.

Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
Acked-by: Markus Armbruster <armbru@redhat.com>
Message-id: 2d6e337c474ac84172d0809e6959c26b21d48120.1568157545.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/paaudio.c | 4 ++--
 qapi/audio.json | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index 3e6580a5ee50..2cba492d8265 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -339,7 +339,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audset=
tings *as,
=20
     pa->stream =3D qpa_simple_new (
         c,
-        g->dev->id,
+        ppdo->has_stream_name ? ppdo->stream_name : g->dev->id,
         PA_STREAM_PLAYBACK,
         ppdo->has_name ? ppdo->name : NULL,
         &ss,
@@ -388,7 +388,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsetti=
ngs *as, void *drv_opaque)
=20
     pa->stream =3D qpa_simple_new (
         c,
-        g->dev->id,
+        ppdo->has_stream_name ? ppdo->stream_name : g->dev->id,
         PA_STREAM_RECORD,
         ppdo->has_name ? ppdo->name : NULL,
         &ss,
diff --git a/qapi/audio.json b/qapi/audio.json
index 9fefdf5186dd..e45218f081f2 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -206,6 +206,11 @@
 #
 # @name: name of the sink/source to use
 #
+# @stream-name: name of the PulseAudio stream created by qemu.  Can be
+#               used to identify the stream in PulseAudio when you
+#               create multiple PulseAudio devices or run multiple qemu
+#               instances (default: audiodev's id, since 4.2)
+#
 # @latency: latency you want PulseAudio to achieve in microseconds
 #           (default 15000)
 #
@@ -215,6 +220,7 @@
   'base': 'AudiodevPerDirectionOptions',
   'data': {
     '*name': 'str',
+    '*stream-name': 'str',
     '*latency': 'uint32' } }
=20
 ##
--=20
2.18.1


