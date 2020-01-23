Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B552C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:59:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67F122071E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z9GZvQXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F122071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufpI-00008a-49
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:59:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iuct5-0007fJ-0r
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iuct2-0006qi-Sg
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:10 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21369
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iuct2-0006qI-QJ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E2MlMz4cN9CaACYckxJtaBM6X0v8cyJc+aK+uqDTqvw=;
 b=Z9GZvQXALPYVeyywn1t7epdA9xEXChs8zyKTbbZTP3W/l9lN81cKicAriR9Zbsd0JNxlBW
 CTG+YxS5aeVqyq1XtC7EG15E4Lg7rz8DjSP9BlA1ohsCCvzJc8OBafoi2nbgsTiWXMQ5bX
 /xGaOp4C3Via+l6GEP8jxulSxoNJYJc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-EVTXLLaOPCq7nCvxtYs2Ag-1; Thu, 23 Jan 2020 08:51:07 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 119528017CC
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:51:05 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E29085780;
 Thu, 23 Jan 2020 13:51:03 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/59] audio/audio: Add missing fall through comment
Date: Thu, 23 Jan 2020 14:49:56 +0100
Message-Id: <1579787449-27599-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: EVTXLLaOPCq7nCvxtYs2Ag-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

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
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Message-Id: <20191218192526.13845-2-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/audio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/audio/audio.c b/audio/audio.c
index abea027..f63f397 100644
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
1.8.3.1



