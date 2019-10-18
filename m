Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5822ACA9EA3
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:51:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32DB2222CB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32DB2222CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLN37-0000Gz-OY
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 03:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iLMtX-0006Gz-U9
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:41:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iLMtV-00073D-4V
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:41:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51368)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iLMtT-00071X-7c
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:41:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 15562C05AA65;
 Fri, 18 Oct 2019 07:41:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com
 [10.36.116.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D80065D9DC;
 Fri, 18 Oct 2019 07:41:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3295D9D34; Fri, 18 Oct 2019 09:41:44 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/13] audio: add mixing-engine option (documentation)
Date: Fri, 18 Oct 2019 09:41:35 +0200
Message-Id: <20191018074144.24071-5-kraxel@redhat.com>
In-Reply-To: <20191018074144.24071-1-kraxel@redhat.com>
References: <20191018074144.24071-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 18 Oct 2019 07:41:50 +0000 (UTC)
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

This will allow us to disable mixeng when we use a decent backend.

Disabling mixeng have a few advantages:
* we no longer convert the audio output from one format to another, when
  the underlying audio system would just convert it to a third format.
  We no longer convert, only the underlying system, when needed.
* the underlying system probably has better resampling and sample format
  converting methods anyway...
* we may support formats that the mixeng currently does not support (S24
  or float samples, more than two channels)
* when using an audio server (like pulseaudio) different sound card
  outputs will show up as separate streams, even if we use only one
  backend

Disadvantages:
* audio capturing no longer works (wavcapture, and vnc audio extension)
* some backends only support a single playback stream or very picky
  about the audio format.  In this case we can't disable mixeng.

Originally thw two main use cases of the disabled option was: using
unsupported audio formats (5.1 and 7.1 audio) and having different
pulseaudio streams per audio frontend.  Since we can have multiple
-audiodevs, the latter is not that important, so currently you only need
this option if you want to use 5.1 or 7.1 audio (implemented in a later
patch), otherwise it's probably better to stick to the old and tried
mixeng, since it's less picky about the backends.

The ideal solution would be to port as much as possible to gstreamer,
but this is currently out of scope:
https://wiki.qemu.org/Internships/ProjectIdeas/AudioGStreamer

Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
Message-id: 5765186a7aadd51a72bc7d3e804307f0ee8a34ce.1570996490.git.DirtY=
.iCE.hu@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 qapi/audio.json |  6 ++++++
 qemu-options.hx | 15 +++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/qapi/audio.json b/qapi/audio.json
index e45218f081f2..83312b23391e 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -11,6 +11,11 @@
 # General audio backend options that are used for both playback and
 # recording.
 #
+# @mixing-engine: use QEMU's mixing engine to mix all streams inside QEM=
U and
+#                 convert audio formats when not supported by the backen=
d. When
+#                 set to off, fixed-settings must be also off (default o=
n,
+#                 since 4.2)
+#
 # @fixed-settings: use fixed settings for host input/output. When off,
 #                  frequency, channels and format must not be
 #                  specified (default true)
@@ -31,6 +36,7 @@
 ##
 { 'struct': 'AudiodevPerDirectionOptions',
   'data': {
+    '*mixing-engine':  'bool',
     '*fixed-settings': 'bool',
     '*frequency':      'uint32',
     '*channels':       'uint32',
diff --git a/qemu-options.hx b/qemu-options.hx
index 793d70ff9388..996b6fba7461 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -433,6 +433,7 @@ DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
     "                specifies the audio backend to use\n"
     "                id=3D identifier of the backend\n"
     "                timer-period=3D timer period in microseconds\n"
+    "                in|out.mixing-engine=3D use mixing engine to mix st=
reams inside QEMU\n"
     "                in|out.fixed-settings=3D use fixed settings for hos=
t audio\n"
     "                in|out.frequency=3D frequency to use with fixed set=
tings\n"
     "                in|out.channels=3D number of channels to use with f=
ixed settings\n"
@@ -493,6 +494,10 @@ output's property with @code{out.@var{prop}}. For ex=
ample:
 -audiodev alsa,id=3Dexample,out.channels=3D1 # leaves in.channels unspec=
ified
 @end example
=20
+NOTE: parameter validation is known to be incomplete, in many cases
+specifying an invalid option causes QEMU to print an error message and
+continue emulation without sound.
+
 Valid global options are:
=20
 @table @option
@@ -503,6 +508,16 @@ Identifies the audio backend.
 Sets the timer @var{period} used by the audio subsystem in microseconds.
 Default is 10000 (10 ms).
=20
+@item in|out.mixing-engine=3Don|off
+Use QEMU's mixing engine to mix all streams inside QEMU and convert
+audio formats when not supported by the backend.  When off,
+@var{fixed-settings} must be off too.  Note that disabling this option
+means that the selected backend must support multiple streams and the
+audio formats used by the virtual cards, otherwise you'll get no sound.
+It's not recommended to disable this option unless you want to use 5.1
+or 7.1 audio, as mixing engine only supports mono and stereo audio.
+Default is on.
+
 @item in|out.fixed-settings=3Don|off
 Use fixed settings for host audio.  When off, it will change based on
 how the guest opens the sound card.  In this case you must not specify
--=20
2.18.1


