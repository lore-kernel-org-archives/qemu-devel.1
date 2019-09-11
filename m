Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19FEC49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:26:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A742D2084D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A742D2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i84WD-0005wN-6N
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 11:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i845B-0007Xb-P9
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:58:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i845A-0002ti-OF
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:58:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48190)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i845A-0002sl-J2
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:58:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 783A285360;
 Wed, 11 Sep 2019 14:58:54 +0000 (UTC)
Received: from localhost (ovpn-116-185.ams2.redhat.com [10.36.116.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E3436608C2;
 Wed, 11 Sep 2019 14:58:53 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 11 Sep 2019 16:58:18 +0200
Message-Id: <20190911145818.18962-3-stefanha@redhat.com>
In-Reply-To: <20190911145818.18962-1-stefanha@redhat.com>
References: <20190911145818.18962-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Wed, 11 Sep 2019 14:58:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/2] audio: add -audiodev pa,
 in|out.latency= to documentation
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Zolt=C3=A1n=20K=C5=91v=C3=A1g=C3=B3?= <DirtY.iCE.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The "latency" parameter wasn't covered by the documentation.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
How is this parameter related to buffer-length?
---
 qemu-options.hx | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index a4f9f74f52..82154cecf8 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -470,6 +470,7 @@ DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
     "-audiodev pa,id=3Did[,prop[=3Dvalue][,...]]\n"
     "                server=3D PulseAudio server address\n"
     "                in|out.name=3D source/sink device name\n"
+    "                in|out.latency=3D desired latency in microseconds\n=
"
 #endif
 #ifdef CONFIG_AUDIO_SDL
     "-audiodev sdl,id=3Did[,prop[=3Dvalue][,...]]\n"
@@ -630,6 +631,9 @@ Sets the PulseAudio @var{server} to connect to.
 @item in|out.name=3D@var{sink}
 Use the specified source/sink for recording/playback.
=20
+@item in|out.latency=3D@var{usecs}
+Desired latency in microseconds.
+
 @end table
=20
 @item -audiodev sdl,id=3D@var{id}[,@var{prop}[=3D@var{value}][,...]]
--=20
2.21.0


