Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EBBC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:27:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0BF4206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGGn/XXZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0BF4206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihezC-0001Og-F6
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 14:27:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihexP-0007wZ-1j
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:26:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihexN-0003Gw-HG
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:26:02 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36041
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihexN-0003E3-Cx
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:26:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576697160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EBUSnrX9Xj4Cd46mcJUhEO/KAuVtcVoqZZfjQwOzsSI=;
 b=eGGn/XXZuJ7SNNRzUKr19GeY7UuelKYRIML088ReGjS8X36W0D18cntLx3dVXvjj4IymKY
 JKViGDsBfzc5rixkmtJrqW/ufv9NP9D1raYxnW5x6Jl+RJhtSEqF0MFle2qlqc/5p210lt
 lZUPWOLp9KmXm0o7BfUV4vPbcSIi0N8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-fccG64bLMmC8M51TdRLDmQ-1; Wed, 18 Dec 2019 14:25:59 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 368F812BA80;
 Wed, 18 Dec 2019 19:25:58 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-116-235.ams2.redhat.com [10.36.116.235])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 10B4F60C81;
 Wed, 18 Dec 2019 19:25:55 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/6] hw/display/tcx: Add missing fall through comments
Date: Wed, 18 Dec 2019 20:25:22 +0100
Message-Id: <20191218192526.13845-3-philmd@redhat.com>
In-Reply-To: <20191218192526.13845-1-philmd@redhat.com>
References: <20191218192526.13845-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: fccG64bLMmC8M51TdRLDmQ-1
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Olivier Danet <odanet@caramail.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When building with GCC9 using CFLAG -Wimplicit-fallthrough=3D2 we get:

  hw/display/tcx.c: In function =E2=80=98tcx_dac_writel=E2=80=99:
  hw/display/tcx.c:453:26: error: this statement may fall through [-Werror=
=3Dimplicit-fallthrough=3D]
    453 |             s->dac_index =3D (s->dac_index + 1) & 0xff; /* Index =
autoincrement */
        |             ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
  hw/display/tcx.c:454:9: note: here
    454 |         default:
        |         ^~~~~~~
  hw/display/tcx.c: In function =E2=80=98tcx_dac_readl=E2=80=99:
  hw/display/tcx.c:412:22: error: this statement may fall through [-Werror=
=3Dimplicit-fallthrough=3D]
    412 |         s->dac_index =3D (s->dac_index + 1) & 0xff; /* Index auto=
increment */
        |         ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
  hw/display/tcx.c:413:5: note: here
    413 |     default:
        |     ^~~~~~~
  cc1: all warnings being treated as errors

Give a hint to GCC by adding the missing fall through comments.

Fixes: 55d7bfe22
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: Reword the description (Aleksandar)

Cc: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Cc: Olivier Danet <odanet@caramail.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/display/tcx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 14e829d3fa..abbeb30284 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -410,6 +410,7 @@ static uint64_t tcx_dac_readl(void *opaque, hwaddr addr=
,
     case 2:
         val =3D s->b[s->dac_index] << 24;
         s->dac_index =3D (s->dac_index + 1) & 0xff; /* Index autoincrement=
 */
+        /* fall through */
     default:
         s->dac_state =3D 0;
         break;
@@ -451,6 +452,7 @@ static void tcx_dac_writel(void *opaque, hwaddr addr, u=
int64_t val,
             s->b[index] =3D val >> 24;
             update_palette_entries(s, index, index + 1);
             s->dac_index =3D (s->dac_index + 1) & 0xff; /* Index autoincre=
ment */
+            /* fall through */
         default:
             s->dac_state =3D 0;
             break;
--=20
2.21.0


