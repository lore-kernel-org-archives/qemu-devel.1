Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD2CC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:45:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2120D22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2120D22D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0MFf-0000eW-Cp
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 04:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i0MBF-0003kJ-V5
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i0MBF-00053a-0A
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:41:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59844)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1i0MBE-00053B-Qg
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:41:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1F56EC0021D3;
 Wed, 21 Aug 2019 08:41:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-60.ams2.redhat.com
 [10.36.116.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A3072E0C9;
 Wed, 21 Aug 2019 08:41:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6D7E016E36; Wed, 21 Aug 2019 10:41:13 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 10:40:59 +0200
Message-Id: <20190821084113.1840-2-kraxel@redhat.com>
In-Reply-To: <20190821084113.1840-1-kraxel@redhat.com>
References: <20190821084113.1840-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Wed, 21 Aug 2019 08:41:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 01/15] audio: Add missing fall through comments
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Michael Walle <michael@walle.cc>, Gerd Hoffmann <kraxel@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Weil <sw@weilnetz.de>

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20190718193441.12490-1-sw@weilnetz.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/audio/audio.c b/audio/audio.c
index c8b88d892d20..a76787b3e872 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -306,6 +306,7 @@ void audio_pcm_init_info (struct audio_pcm_info *info=
, struct audsettings *as)
=20
     case AUDIO_FORMAT_S16:
         sign =3D 1;
+        /* fall through */
     case AUDIO_FORMAT_U16:
         bits =3D 16;
         shift =3D 1;
@@ -313,6 +314,7 @@ void audio_pcm_init_info (struct audio_pcm_info *info=
, struct audsettings *as)
=20
     case AUDIO_FORMAT_S32:
         sign =3D 1;
+        /* fall through */
     case AUDIO_FORMAT_U32:
         bits =3D 32;
         shift =3D 2;
--=20
2.18.1


