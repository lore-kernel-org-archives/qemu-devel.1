Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA5AC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:26:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9615320717
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBerPnif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9615320717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihUfO-0001jC-9C
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 03:26:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ihUWU-0005zK-Tq
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ihUWS-0002U9-GA
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37113
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ihUWR-0002Rz-FF
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576657050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YQyo31yOIMAWoY5gSODjk4z41BQXDWiKUVDzu9supbM=;
 b=EBerPnifyd5tYcOT5OJJROeLFiJUcUZ6+cTHx53naVHT/Zqo4Ik8+ToEaH3t9cUmu75mjm
 nEPHV4OAIBnffcnFno8MW40IixksUzWFPS+68szRmAnl5qpHZg4RJ4sOpGpFCI9z9k4bwB
 j9DSaykACR+FDAuctZhUAQvRqP8dQa0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-3RxOyB4SMm2PLFYIyvViug-1; Wed, 18 Dec 2019 03:17:29 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57A431854334;
 Wed, 18 Dec 2019 08:17:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2434A68882;
 Wed, 18 Dec 2019 08:17:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C72A3113642D; Wed, 18 Dec 2019 09:17:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 29/35] hw/sd: drop extra whitespace in
 sdhci_sysbus_realize() header
Date: Wed, 18 Dec 2019 09:17:15 +0100
Message-Id: <20191218081721.23520-30-armbru@redhat.com>
In-Reply-To: <20191218081721.23520-1-armbru@redhat.com>
References: <20191218081721.23520-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 3RxOyB4SMm2PLFYIyvViug-1
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20191205174635.18758-16-vsementsov@virtuozzo.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/sd/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 88404d0e9d..18c0c052ce 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1459,7 +1459,7 @@ static void sdhci_sysbus_finalize(Object *obj)
     sdhci_uninitfn(s);
 }
=20
-static void sdhci_sysbus_realize(DeviceState *dev, Error ** errp)
+static void sdhci_sysbus_realize(DeviceState *dev, Error **errp)
 {
     SDHCIState *s =3D SYSBUS_SDHCI(dev);
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
--=20
2.21.0


