Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BB3C18E7D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 09:25:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 832B82075B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 09:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 832B82075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39100 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTNV4-0001Pw-Py
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 05:25:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hTNTY-0000Yq-BV
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:23:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hTNTX-00016o-Gb
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:23:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hTNTX-00015g-Ar
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:23:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 704B386673
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 09:23:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EAEE8282D8;
	Wed, 22 May 2019 09:23:51 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 12029A200; Wed, 22 May 2019 11:23:51 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 11:23:47 +0200
Message-Id: <20190522092351.17920-2-kraxel@redhat.com>
In-Reply-To: <20190522092351.17920-1-kraxel@redhat.com>
References: <20190522092351.17920-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Wed, 22 May 2019 09:23:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/5] usb-hub: tweak feature names
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add dashes, so they don't look like two separate things when printed.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-hub.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index 7e9339b8a83d..9b04b6a6ec2d 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -287,11 +287,11 @@ static const char *feature_name(int feature)
         [PORT_POWER]         = "power",
         [PORT_LOWSPEED]      = "lowspeed",
         [PORT_HIGHSPEED]     = "highspeed",
-        [PORT_C_CONNECTION]  = "change connection",
-        [PORT_C_ENABLE]      = "change enable",
-        [PORT_C_SUSPEND]     = "change suspend",
-        [PORT_C_OVERCURRENT] = "change overcurrent",
-        [PORT_C_RESET]       = "change reset",
+        [PORT_C_CONNECTION]  = "change-connection",
+        [PORT_C_ENABLE]      = "change-enable",
+        [PORT_C_SUSPEND]     = "change-suspend",
+        [PORT_C_OVERCURRENT] = "change-overcurrent",
+        [PORT_C_RESET]       = "change-reset",
         [PORT_TEST]          = "test",
         [PORT_INDICATOR]     = "indicator",
     };
-- 
2.18.1


