Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AF0C3F68F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 17:36:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F367C206D8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 17:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xz7V6hYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F367C206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihGlt-0003jY-JH
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 12:36:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihGkT-0001oH-31
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:35:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihGkR-00009j-W6
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:35:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50902
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihGkR-000092-Sg
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:35:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576604103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JerXtiZg/NdV0y3V9bJw7XC5WMrWi8gnxmPCM/s6nsY=;
 b=Xz7V6hYQAKWAaICBYEXW/vJfU4bVXDjtJ9PCOmi7rB3ypcXNDd1U80vcFZFI4Zz2dnKAP0
 ILftMqHCsFYlV0EsE6v/HzUnGNRhDm96m14eTCNH/UDNC9Ybqp51tBDxq9tMNFfYNKfFmF
 7Z42KuzqPxIGIuT3sIaX9ONC/8P2vqE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-uWLPNUfoMs6bVftKDHCoMw-1; Tue, 17 Dec 2019 12:35:00 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9DAA18C35C0;
 Tue, 17 Dec 2019 17:34:58 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-147.brq.redhat.com [10.40.205.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7616D19C4F;
 Tue, 17 Dec 2019 17:34:53 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/6] hw/net/imx_fec: Rewrite fall through comments
Date: Tue, 17 Dec 2019 18:34:22 +0100
Message-Id: <20191217173425.5082-4-philmd@redhat.com>
In-Reply-To: <20191217173425.5082-1-philmd@redhat.com>
References: <20191217173425.5082-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: uWLPNUfoMs6bVftKDHCoMw-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

GCC9 is confused by this comment when building with CFLAG
-Wimplicit-fallthrough=3D2:

  hw/net/imx_fec.c: In function =E2=80=98imx_eth_write=E2=80=99:
  hw/net/imx_fec.c:906:12: error: this statement may fall through [-Werror=
=3Dimplicit-fallthrough=3D]
    906 |         if (unlikely(single_tx_ring)) {
        |            ^
  hw/net/imx_fec.c:912:5: note: here
    912 |     case ENET_TDAR:     /* FALLTHROUGH */
        |     ^~~~
  cc1: all warnings being treated as errors

Rewrite the comments in the correct place,  using 'fall through'
which is recognized by GCC and static analyzers.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Cc: Peter Chubb <peter.chubb@nicta.com.au>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: qemu-arm@nongnu.org
---
 hw/net/imx_fec.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index bd99236864..30cc07753d 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -901,15 +901,17 @@ static void imx_eth_write(void *opaque, hwaddr offset=
, uint64_t value,
             s->regs[index] =3D 0;
         }
         break;
-    case ENET_TDAR1:    /* FALLTHROUGH */
-    case ENET_TDAR2:    /* FALLTHROUGH */
+        /* fall through */
+    case ENET_TDAR1:
+    case ENET_TDAR2:
         if (unlikely(single_tx_ring)) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "[%s]%s: trying to access TDAR2 or TDAR1\n",
                           TYPE_IMX_FEC, __func__);
             return;
         }
-    case ENET_TDAR:     /* FALLTHROUGH */
+        /* fall through */
+    case ENET_TDAR:
         if (s->regs[ENET_ECR] & ENET_ECR_ETHEREN) {
             s->regs[index] =3D ENET_TDAR_TDAR;
             imx_eth_do_tx(s, index);
--=20
2.21.0


