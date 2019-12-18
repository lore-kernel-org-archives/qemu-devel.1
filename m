Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447C5C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:30:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F771206D8
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6fdaq1Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F771206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihf1q-0004PB-L0
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 14:30:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihexi-0008IQ-7c
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:26:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihexf-00044U-S3
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:26:21 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40347
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihexe-0003yK-Kg
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:26:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576697172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vYieTMV2GGryjAYltk1B6hSeskuepnCEd/upKBPg6sc=;
 b=M6fdaq1Yt4oPBsyMg23IXo+khTps7qQ4oAiOYM7Jdk3A8HUd74Bdk2qMjW3oCyyHMyeUIC
 o6hGUi3YanVcgqP6rWNsMaNwjWh1cQx/xHmwDlki4FN5OpSwV+cWMNXVv8pulelNWpxQeB
 Npcv9svB4bLl2xw7SfZ1UyODNFM+2y8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-GKU3JQVBO16wNXnwHLjn3A-1; Wed, 18 Dec 2019 14:26:11 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3E60801E6C;
 Wed, 18 Dec 2019 19:26:09 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-116-235.ams2.redhat.com [10.36.116.235])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 002A260C84;
 Wed, 18 Dec 2019 19:26:06 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 5/6] hw/net/imx_fec: Remove unuseful FALLTHROUGH
 comments
Date: Wed, 18 Dec 2019 20:25:25 +0100
Message-Id: <20191218192526.13845-6-philmd@redhat.com>
In-Reply-To: <20191218192526.13845-1-philmd@redhat.com>
References: <20191218192526.13845-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: GKU3JQVBO16wNXnwHLjn3A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't need to explicit these obvious switch fall through
comments. Stay consistent with the rest of the codebase.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Cc: Peter Chubb <peter.chubb@nicta.com.au>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: qemu-arm@nongnu.org
---
 hw/net/imx_fec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index c01ce4f078..5a83678f64 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -901,8 +901,8 @@ static void imx_eth_write(void *opaque, hwaddr offset, =
uint64_t value,
             s->regs[index] =3D 0;
         }
         break;
-    case ENET_TDAR1:    /* FALLTHROUGH */
-    case ENET_TDAR2:    /* FALLTHROUGH */
+    case ENET_TDAR1:
+    case ENET_TDAR2:
         if (unlikely(single_tx_ring)) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "[%s]%s: trying to access TDAR2 or TDAR1\n",
--=20
2.21.0


