Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5786C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:52:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F17420838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TyGogTwW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F17420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izyQv-0005L4-Lw
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 02:52:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1izyL1-0005Vo-KO
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1izyKz-0003Du-Cf
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:06 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58793
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1izyKz-0003C4-8i
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581061564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wllwx88jrI6wT6IXdepHFAII/++Fy/E/2IWHLG7h/2I=;
 b=TyGogTwW1FPK3oCfXZTVp6mbzskJ/Ppwfekqggr46dByxQx3OJULBcng+Zahq1EmVMwN1q
 mp3zi3mYttmvQGwUOrZZeCEGBmH/OrPEpUt7w/T1pIWHw48gA+janagGGd6ymT7jy7YW6W
 UyEgp/YqsVCz1nqW/1MnJyJF3p4ePd8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-ZipSl2pANPekrzZdVs__bg-1; Fri, 07 Feb 2020 02:46:02 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70E7C800D5C;
 Fri,  7 Feb 2020 07:46:01 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com
 [10.36.116.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9FDF6790CF;
 Fri,  7 Feb 2020 07:45:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id F3EC631E89; Fri,  7 Feb 2020 08:45:57 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/12] paaudio: remove unused variables
Date: Fri,  7 Feb 2020 08:45:49 +0100
Message-Id: <20200207074557.26073-5-kraxel@redhat.com>
In-Reply-To: <20200207074557.26073-1-kraxel@redhat.com>
References: <20200207074557.26073-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: ZipSl2pANPekrzZdVs__bg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Volker R=C3=BCmelin <vr_qemu@t-online.de>

The unused variables were last used before commit 49ddd7e122
"paaudio: port to the new audio backend api".

Fixes: 49ddd7e122
Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
Message-Id: <20200123074943.6699-3-vr_qemu@t-online.de>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/paaudio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index dbfe48c03a1d..8f37c6185161 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -32,7 +32,6 @@ typedef struct {
     HWVoiceOut hw;
     pa_stream *stream;
     paaudio *g;
-    size_t samples;
 } PAVoiceOut;
=20
 typedef struct {
@@ -41,7 +40,6 @@ typedef struct {
     const void *read_data;
     size_t read_length;
     paaudio *g;
-    size_t samples;
 } PAVoiceIn;
=20
 static void qpa_conn_fini(PAConnection *c);
@@ -488,7 +486,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsetti=
ngs *as,
     }
=20
     audio_pcm_init_info (&hw->info, &obt_as);
-    hw->samples =3D pa->samples =3D audio_buffer_samples(
+    hw->samples =3D audio_buffer_samples(
         qapi_AudiodevPaPerDirectionOptions_base(ppdo),
         &obt_as, ppdo->buffer_length);
=20
@@ -536,7 +534,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsetting=
s *as, void *drv_opaque)
     }
=20
     audio_pcm_init_info (&hw->info, &obt_as);
-    hw->samples =3D pa->samples =3D audio_buffer_samples(
+    hw->samples =3D audio_buffer_samples(
         qapi_AudiodevPaPerDirectionOptions_base(ppdo),
         &obt_as, ppdo->buffer_length);
=20
--=20
2.18.1


