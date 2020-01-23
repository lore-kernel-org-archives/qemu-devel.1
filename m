Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383BFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:00:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03E7420704
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L37Dd17O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E7420704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iueuJ-0006Jo-Eg
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:00:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iuctz-0000jV-K8
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iucty-0000lq-HL
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57282
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iucty-0000lb-EV
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uGtirKO2x8LatZcTwxQVCWV+j2GJli1ju0HnJOC/W14=;
 b=L37Dd17OvLRIDEZaaS0QnKdc37UFyza3kpiLEadxuqtCTdNLQvVEoNqSxlqEroGXgPFOJb
 hLtPBYTOsPq6iwa6J3pRO32Pg5q9p/rBx9XGBiZ9J35TTaBDikfjGUCzmUI08g5OT/KatL
 uWC0TYTuGVSZFyzk9BIQmkFS4m15XHo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-aVF6WOm5PWGCm-LPmUCWiQ-1; Thu, 23 Jan 2020 08:52:02 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6541101FE4B
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:52:01 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D352684DBD;
 Thu, 23 Jan 2020 13:52:00 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 32/59] qdev: remove duplicated qdev_property_add_static() doc
Date: Thu, 23 Jan 2020 14:50:22 +0100
Message-Id: <1579787449-27599-33-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: aVF6WOm5PWGCm-LPmUCWiQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The function is already documented in the header.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200110153039.1379601-3-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/qdev.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 58e87d3..b47dc07 100644
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
1.8.3.1



