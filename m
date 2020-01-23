Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A26C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:56:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CA9F2071E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dVa+nPPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CA9F2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufmg-0005Py-QO
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:56:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iuct5-0007g0-9r
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iuct3-0006qz-3d
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35320
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iuct3-0006qm-1F
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4lOpQAex6+ed7KVCCMGrJwZB+MBzXKa8ZFG++CEMgy0=;
 b=dVa+nPPteywISCVHHNjlNm9sd1sfHbiaS9pEhPpakTZZlsAGLhrtXjKeFxifAwTu0FNK4C
 bKBpX1dAa7uGsKI/uK4QGIkX98kKES6ROqNyLXCycfp+A86KCYLCBdp8evVNjX44iaAxJA
 SahCEM+/795bQNmrwB3IU7MENzhjPGc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-Zr24jV69O3WX4hGRw8HDGg-1; Thu, 23 Jan 2020 08:51:07 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 878AF100551A
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:51:06 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 83DBA84DBD;
 Thu, 23 Jan 2020 13:51:05 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/59] hw/display/tcx: Add missing fall through comments
Date: Thu, 23 Jan 2020 14:49:57 +0100
Message-Id: <1579787449-27599-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Zr24jV69O3WX4hGRw8HDGg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

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
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20191218192526.13845-3-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/tcx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 14e829d..abbeb30 100644
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
1.8.3.1



