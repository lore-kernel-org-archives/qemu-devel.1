Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12261C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 17:36:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D16EE24655
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 17:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OreWebw9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D16EE24655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihGlm-0003XK-B4
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 12:36:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46076)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihGkK-0001WZ-4y
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:34:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihGkI-0008Ak-7c
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:34:56 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44920
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihGkI-0008A4-3q
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:34:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576604093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i/ycAlXiPXADaLAOWo3IoxfdaOKQ4Pec1+OI0orkZ5c=;
 b=OreWebw9FkyVlzJmb01uipl/8WCSkZ6mmGvWsLzxBl5g4oJL22btiH/vMY30ER06MnGujs
 ZPs5KJXWgsnMgSy0B9aSxipSB4VUkjd1VsJjo8omXmdHF520vOn7kx3PPhHij/ZQpYTxmH
 wzQj2JsDRmK1QT8M/z0xswNliJiniYo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-Fz3Ue5MAMvqsmOjIRlB__g-1; Tue, 17 Dec 2019 12:34:50 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6373C8024E6;
 Tue, 17 Dec 2019 17:34:49 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-147.brq.redhat.com [10.40.205.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB5EA19C4F;
 Tue, 17 Dec 2019 17:34:46 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/6] audio/audio: Add missing fall through comment
Date: Tue, 17 Dec 2019 18:34:20 +0100
Message-Id: <20191217173425.5082-2-philmd@redhat.com>
In-Reply-To: <20191217173425.5082-1-philmd@redhat.com>
References: <20191217173425.5082-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Fz3Ue5MAMvqsmOjIRlB__g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

GCC9 is confused by this comment when building with
CFLAG -Wimplicit-fallthrough=3D2:

  audio/audio.c: In function =E2=80=98audio_pcm_init_info=E2=80=99:
  audio/audio.c:306:14: error: this statement may fall through [-Werror=3Di=
mplicit-fallthrough=3D]
    306 |         sign =3D 1;
        |         ~~~~~^~~
  audio/audio.c:307:5: note: here
    307 |     case AUDIO_FORMAT_U8:
        |     ^~~~
  cc1: all warnings being treated as errors

Add the missing fall through comment, similarly to e46349414.

Fixes: 2b9cce8c8c
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: "K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n" <dirty.ice.hu@gmail.com>
---
 audio/audio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/audio/audio.c b/audio/audio.c
index 56fae55047..57daf3f620 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -304,6 +304,7 @@ void audio_pcm_init_info (struct audio_pcm_info *info, =
struct audsettings *as)
     switch (as->fmt) {
     case AUDIO_FORMAT_S8:
         sign =3D 1;
+        /* fall through */
     case AUDIO_FORMAT_U8:
         mul =3D 1;
         break;
--=20
2.21.0


