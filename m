Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B269C432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:19:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAAB42082E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 11:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hqLE/2/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAAB42082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibNGe-00037s-JF
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 06:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNCv-00011P-LL
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:16:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ibNCt-00089f-FD
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:16:05 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49590
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ibNCr-00089A-HP
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 06:16:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575198961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TxxHG81s/qqK+7fdmD/biYU+2IZTgwEf9+RxbaMycOE=;
 b=hqLE/2/U+H22OHLstOxd3b8n5AEedI96rP2X2t2CxrcP2JxmjhScoKVXfuS4+Ms0+c3O3w
 Drcl2aKO5YSESDo5+eJ7I2pxek2YAqFYtVKG6C7lPATSQJC4AJ7Lh0DHPDyTpNOUdYaPpa
 +N59qD61uwTh8ELYygY0T4+1Nm6Yp+A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-vbJVBW6hPkyR1AQQcBxsgA-1; Sun, 01 Dec 2019 06:15:59 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1202184CABB
 for <qemu-devel@nongnu.org>; Sun,  1 Dec 2019 11:15:58 +0000 (UTC)
Received: from localhost (unknown [10.36.112.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 55B2E5C3FA;
 Sun,  1 Dec 2019 11:15:56 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/26] qdev: remove duplicated qdev_property_add_static() doc
Date: Sun,  1 Dec 2019 15:15:07 +0400
Message-Id: <20191201111531.1136947-3-marcandre.lureau@redhat.com>
In-Reply-To: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
References: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: vbJVBW6hPkyR1AQQcBxsgA-1
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The function is already documented in the header.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/core/qdev.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index c7b3f0dec5..8b93b85727 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -717,16 +717,6 @@ static void qdev_property_add_legacy(DeviceState *dev,=
 Property *prop,
     g_free(name);
 }
=20
-/**
- * qdev_property_add_static:
- * @dev: Device to add the property to.
- * @prop: The qdev property definition.
- * @errp: location to store error information.
- *
- * Add a static QOM property to @dev for qdev property @prop.
- * On error, store error in @errp.  Static properties access data in a str=
uct.
- * The type of the QOM property is derived from prop->info.
- */
 void qdev_property_add_static(DeviceState *dev, Property *prop,
                               Error **errp)
 {
--=20
2.24.0


