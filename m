Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71E0C2D0BF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:27:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7248F206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dg9Afcwe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7248F206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihezD-0001UW-Bi
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 14:27:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihexO-0007wY-3t
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:26:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihexN-0003Fj-36
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:26:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31033
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihexM-0003Db-T4
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:26:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576697160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uuh8UofcW0PixAC6FAxpsmAjIHeSqODHyjZhHex+ypc=;
 b=dg9AfcweEftUvIlaG/1sR+S6OM90O4+WwlkKqHNvrkx9y6BweJPTAJISf7eVs83Qi02amz
 bjAsspwDzWFZnMcQ9gaNgiaSXDBeNthTmwkih0PfbCDL1p01tr96lBo/Py7/bBhZmj6oQo
 cAogl8umN3pRtTzQsjC9IsC1gzRjSfQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-WjxdumrSNdSzzWtem2prnw-1; Wed, 18 Dec 2019 14:25:56 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2B51107ACC5;
 Wed, 18 Dec 2019 19:25:55 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-116-235.ams2.redhat.com [10.36.116.235])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1556060CD1;
 Wed, 18 Dec 2019 19:25:52 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/6] audio/audio: Add missing fall through comment
Date: Wed, 18 Dec 2019 20:25:21 +0100
Message-Id: <20191218192526.13845-2-philmd@redhat.com>
In-Reply-To: <20191218192526.13845-1-philmd@redhat.com>
References: <20191218192526.13845-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: WjxdumrSNdSzzWtem2prnw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When building with GCC9 using CFLAG -Wimplicit-fallthrough=3D2 we get:

  audio/audio.c: In function =E2=80=98audio_pcm_init_info=E2=80=99:
  audio/audio.c:306:14: error: this statement may fall through [-Werror=3Di=
mplicit-fallthrough=3D]
    306 |         sign =3D 1;
        |         ~~~~~^~~
  audio/audio.c:307:5: note: here
    307 |     case AUDIO_FORMAT_U8:
        |     ^~~~
  cc1: all warnings being treated as errors

Similarly to e46349414, add the missing fall through comment to
hint GCC.

Fixes: 2b9cce8c8c
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: Reword the description (Aleksandar)

Cc: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
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


