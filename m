Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B6FC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 06:58:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1C37233A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 06:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C37233A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0h3I-0004Z8-Ib
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 02:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i0gxr-0007LP-87
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 02:52:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i0gxn-0004jl-N3
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 02:52:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52412)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1i0gxn-0004fq-Cf
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 02:52:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 90D6D106BB25
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 06:52:48 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-60.ams2.redhat.com
 [10.36.116.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C3D3600CD;
 Thu, 22 Aug 2019 06:52:43 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8FDD2934B; Thu, 22 Aug 2019 08:52:42 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 08:52:41 +0200
Message-Id: <20190822065242.12496-5-kraxel@redhat.com>
In-Reply-To: <20190822065242.12496-1-kraxel@redhat.com>
References: <20190822065242.12496-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Thu, 22 Aug 2019 06:52:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 4/5] usb: reword -usb command-line option and
 mention xHCI
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

The -usb section of the man page is not very clear on what exactly -usb
does and fails to mention xHCI as a modern alternative (-device
nec-usb-xhci).

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20190815141428.29080-1-stefanha@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 qemu-options.hx | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 9621e934c0bf..1fb362f06faa 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1436,12 +1436,15 @@ STEXI
 ETEXI
 
 DEF("usb", 0, QEMU_OPTION_usb,
-    "-usb            enable the USB driver (if it is not used by default yet)\n",
+    "-usb            enable on-board USB host controller (if not enabled by default)\n",
     QEMU_ARCH_ALL)
 STEXI
 @item -usb
 @findex -usb
-Enable the USB driver (if it is not used by default yet).
+Enable USB emulation on machine types with an on-board USB host controller (if
+not enabled by default).  Note that on-board USB host controllers may not
+support USB 3.0.  In this case @option{-device qemu-xhci} can be used instead
+on machines with PCI.
 ETEXI
 
 DEF("usbdevice", HAS_ARG, QEMU_OPTION_usbdevice,
-- 
2.18.1


