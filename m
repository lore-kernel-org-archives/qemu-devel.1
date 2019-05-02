Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4D7C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:55:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4FE42085A
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4FE42085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46916 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM6Z7-0002cJ-5S
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 03:55:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hM6GS-0002FA-A8
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:36:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hM6GO-00016W-UT
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:36:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hM6GN-0000mF-64
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:36:15 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1F0812D800;
	Thu,  2 May 2019 07:35:52 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-45.ams2.redhat.com
	[10.36.116.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B01221001DEF;
	Thu,  2 May 2019 07:35:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 91AEE17535; Thu,  2 May 2019 09:35:43 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 09:35:39 +0200
Message-Id: <20190502073543.4391-4-kraxel@redhat.com>
In-Reply-To: <20190502073543.4391-1-kraxel@redhat.com>
References: <20190502073543.4391-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Thu, 02 May 2019 07:35:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 3/7] usb-mtp: change default to success for
 usb_mtp_update_object
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
Cc: Bandan Das <bsd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502073539.S-8GytBTgWSMk41Z0Xq4YDAV6JAJxAkGG4IbaOyA1pA@z>

From: Bandan Das <bsd@redhat.com>

Commit c5ead51f90cf (usb-mtp: return incomplete transfer on a lstat
failure) checks if lstat succeeded when updating attributes of a
file. However, it also changed behavior to return an error by
default. This is incorrect because for smaller file sizes, Qemu
will attempt to write the file in one go and there won't be
an object for it.

Fixes: c5ead51f90cf
Signed-off-by: Bandan Das <bsd@redhat.com>
Message-id: jpgwojv9pwv.fsf@linux.bootlegged.copy
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-mtp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 963449ec7de8..d90b336d53f4 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1587,7 +1587,7 @@ done:
 
 static int usb_mtp_update_object(MTPObject *parent, char *name)
 {
-    int ret = -1;
+    int ret = 0;
 
     MTPObject *o =
         usb_mtp_object_lookup_name(parent, name, strlen(name));
-- 
2.18.1


