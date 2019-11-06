Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF9DC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 08:28:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DD872178F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 08:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YXU4DMj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD872178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSGgR-0003QB-1u
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 03:28:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iSGdy-0001op-8m
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:26:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iSGdu-0007kU-Ll
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:26:20 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33523
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iSGdt-0007hJ-6R
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:26:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573028775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4NGlYDEMqwNmSmxG8/CKN6VZ1rCxY9lp6aRSrD53fbE=;
 b=YXU4DMj16zJK3Otibis47ERCPWK2uGHp9RA+3EGNg32nOqqs3kC6khCQqx9o/m66+Z7hyn
 kPIVafSqkIh0LiLSMLpefelFygUxGd29YB5gB4f1JcJdY6La3cuxzvAmbFRM6HpaW55Y1/
 rF+YSV0bRE9VE32RWrCQVhzYfTrF42I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-f1S6S0CIPHujnTgEmX2LCA-1; Wed, 06 Nov 2019 03:26:14 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DE04477
 for <qemu-devel@nongnu.org>; Wed,  6 Nov 2019 08:26:13 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-69.ams2.redhat.com
 [10.36.116.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D5AD75C298;
 Wed,  6 Nov 2019 08:26:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DF4109D23; Wed,  6 Nov 2019 09:26:04 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/1] audio: add -audiodev pa,in|out.latency= to documentation
Date: Wed,  6 Nov 2019 09:26:04 +0100
Message-Id: <20191106082604.9548-2-kraxel@redhat.com>
In-Reply-To: <20191106082604.9548-1-kraxel@redhat.com>
References: <20191106082604.9548-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: f1S6S0CIPHujnTgEmX2LCA-1
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

The "latency" parameter wasn't covered by the documentation.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20191004125641.24383-1-stefanha@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 qemu-options.hx | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 1fc2470e2fd4..ee4a099e252f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -471,6 +471,7 @@ DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
     "-audiodev pa,id=3Did[,prop[=3Dvalue][,...]]\n"
     "                server=3D PulseAudio server address\n"
     "                in|out.name=3D source/sink device name\n"
+    "                in|out.latency=3D desired latency in microseconds\n"
 #endif
 #ifdef CONFIG_AUDIO_SDL
     "-audiodev sdl,id=3Did[,prop[=3Dvalue][,...]]\n"
@@ -645,6 +646,10 @@ Sets the PulseAudio @var{server} to connect to.
 @item in|out.name=3D@var{sink}
 Use the specified source/sink for recording/playback.
=20
+@item in|out.latency=3D@var{usecs}
+Desired latency in microseconds.  The PulseAudio server will try to honor =
this
+value but actual latencies may be lower or higher.
+
 @end table
=20
 @item -audiodev sdl,id=3D@var{id}[,@var{prop}[=3D@var{value}][,...]]
--=20
2.18.1


