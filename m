Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAE9C7618F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 22:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA4D721849
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 22:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4D721849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=weilnetz.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoEV6-00081b-QT
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 18:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42541)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefan@weilnetz.de>) id 1hoEUu-0007dW-4l
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 18:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefan@weilnetz.de>) id 1hoEUo-0003bT-L1
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 18:03:32 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:35702
 helo=v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefan@weilnetz.de>)
 id 1hoEUo-0003Zh-F9; Thu, 18 Jul 2019 18:03:26 -0400
Received: from localhost (localhost [127.0.0.1])
 by v2201612906741603.powersrv.de (Postfix) with ESMTP id 1E489DB8797;
 Thu, 18 Jul 2019 21:34:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at v2201612906741603.powersrv.de
Received: from v2201612906741603.powersrv.de ([127.0.0.1])
 by localhost (v2201612906741603.powersrv.de [127.0.0.1]) (amavisd-new,
 port 10024)
 with ESMTP id pWmEUmwMM1fd; Thu, 18 Jul 2019 21:34:52 +0200 (CEST)
Received: from qemu.weilnetz.de (qemu.weilnetz.de [188.68.58.204])
 by v2201612906741603.powersrv.de (Postfix) with ESMTP id 5A917DB8783;
 Thu, 18 Jul 2019 21:34:52 +0200 (CEST)
Received: by qemu.weilnetz.de (Postfix, from userid 1000)
 id E972B460018; Thu, 18 Jul 2019 21:34:51 +0200 (CEST)
From: Stefan Weil <sw@weilnetz.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 18 Jul 2019 21:34:41 +0200
Message-Id: <20190718193441.12490-1-sw@weilnetz.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 37.120.169.71
Subject: [Qemu-devel] [PATCH] audio: Add missing fall through comments
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
Cc: qemu-trivial@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---
 audio/audio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/audio/audio.c b/audio/audio.c
index 5fd9a58a80..a7a13e900a 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -304,6 +304,7 @@ void audio_pcm_init_info (struct audio_pcm_info *info=
, struct audsettings *as)
=20
     case AUDIO_FORMAT_S16:
         sign =3D 1;
+        /* fall through */
     case AUDIO_FORMAT_U16:
         bits =3D 16;
         shift =3D 1;
@@ -311,6 +312,7 @@ void audio_pcm_init_info (struct audio_pcm_info *info=
, struct audsettings *as)
=20
     case AUDIO_FORMAT_S32:
         sign =3D 1;
+        /* fall through */
     case AUDIO_FORMAT_U32:
         bits =3D 32;
         shift =3D 2;
--=20
2.20.1


