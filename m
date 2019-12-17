Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490D1C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 17:38:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4ADE206D8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 17:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZcC1NSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4ADE206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihGnq-0007Lx-Dz
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 12:38:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihGkM-0001ba-U0
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:34:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihGkL-0008JF-S7
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:34:58 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30818
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihGkL-0008IM-P6
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576604097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=024EQHq67Rd7USQOwAS6CFKa3pM0k1rzZuTHwHmHWb8=;
 b=KZcC1NSSloQAUp0xqaZjKc3mcVbWo6GgMpvUpFI73pPyjSEodvPA7prU5Lcpqod02Lyxwm
 pF2mMUejYkpWU/k8rg/MlhSp5TBnafpq77Ko1gk+10EFbKn8sNJdEA8pitibUG4Xp2sfNg
 geq8Vp+L95KPL0AWMebKBkDWG2ZUQ2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-Q2qQ9ZUJNjKv8sUJ0YPWfA-1; Tue, 17 Dec 2019 12:34:54 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB0F18024E9;
 Tue, 17 Dec 2019 17:34:52 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-147.brq.redhat.com [10.40.205.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 00CC719C4F;
 Tue, 17 Dec 2019 17:34:49 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/6] hw/display/tcx: Add missing fall through comments
Date: Tue, 17 Dec 2019 18:34:21 +0100
Message-Id: <20191217173425.5082-3-philmd@redhat.com>
In-Reply-To: <20191217173425.5082-1-philmd@redhat.com>
References: <20191217173425.5082-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Q2qQ9ZUJNjKv8sUJ0YPWfA-1
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
Cc: qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Olivier Danet <odanet@caramail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

GCC9 is confused by this comment when building with
CFLAG -Wimplicit-fallthrough=3D2:

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

Add the missing fall through comments.

Fixes: 55d7bfe22
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
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


