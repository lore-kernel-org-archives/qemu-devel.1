Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D29CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:12:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55E6D20738
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F00FZg94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E6D20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzBc-0006Ez-Jt
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1juzAZ-0004bf-Dy
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:10:59 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51606
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1juzAW-0006ZB-PX
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594649455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=YYKkuxz1L82bepkVHwfJi/gR2rbiaG98J1TwbK5Ss2M=;
 b=F00FZg94YHu5iFWIz1CZhHVvDj1/WFTqdyuekl/vA7X9nyE+qrAWdj0xyHNeKaJ4bGnU45
 b2WT1d2vhwz1ZlmBeITXM1JkLU2pg+BZc/gxVbtbOFIIiOX29x77roaYNvnWnKvOF8iTiJ
 hZWdleQspRNVUhGEURMeJv+aiLtVrbw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-oMK5yRvbNiyxKB_8fC-E9A-1; Mon, 13 Jul 2020 10:10:54 -0400
X-MC-Unique: oMK5yRvbNiyxKB_8fC-E9A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 301E81085
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 14:10:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-89.ams2.redhat.com
 [10.36.115.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 058802B6DD;
 Mon, 13 Jul 2020 14:10:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2917F3F119; Mon, 13 Jul 2020 16:10:49 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/4] docs/qdev-device-use: Clean up the sentences related to
 -usbdevice
Date: Mon, 13 Jul 2020 16:10:47 +0200
Message-Id: <20200713141049.2241-3-kraxel@redhat.com>
In-Reply-To: <20200713141049.2241-1-kraxel@redhat.com>
References: <20200713141049.2241-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Most of the -usbdevice paramaters have been removed already. Update
the doc accordingly.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-id: 20200710065520.24784-1-thuth@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 docs/qdev-device-use.txt | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/docs/qdev-device-use.txt b/docs/qdev-device-use.txt
index 4bbbcf561f2f..f8d0d2fe297a 100644
--- a/docs/qdev-device-use.txt
+++ b/docs/qdev-device-use.txt
@@ -125,12 +125,7 @@ The -device argument differs in detail for each type of drive:
 
 * if=pflash, if=mtd, if=sd, if=xen are not yet available with -device
 
-For USB devices, the old way is actually different:
-
-    -usbdevice disk:format=FMT:FILENAME
-
-Provides much less control than -drive's OPTS...  The new way fixes
-that:
+For USB storage devices, you can use something like:
 
     -device usb-storage,drive=DRIVE-ID,removable=RMB
 
@@ -177,8 +172,6 @@ The appropriate DEVNAME depends on the machine type.  For type "pc":
 
   This lets you control I/O ports and IRQs.
 
-* -usbdevice serial::chardev becomes -device usb-serial,chardev=dev.
-
 * -usbdevice braille doesn't support LEGACY-CHARDEV syntax.  It always
   uses "braille".  With -device, this useful default is gone, so you
   have to use something like
@@ -238,10 +231,6 @@ The old way to define the guest part looks like this:
 
     -net nic,netdev=NET-ID,macaddr=MACADDR,model=MODEL,name=ID,addr=STR,vectors=V
 
-Except for USB it looks like this:
-
-    -usbdevice net:netdev=NET-ID,macaddr=MACADDR,name=ID
-
 The new way is -device:
 
     -device DEVNAME,netdev=NET-ID,mac=MACADDR,DEV-OPTS...
@@ -336,12 +325,7 @@ The new way is -device DEVNAME,DEV-OPTS...  Details depend on DRIVER:
 * mouse           -device usb-mouse
 * tablet          -device usb-tablet
 * wacom-tablet    -device usb-wacom-tablet
-* host:...        See "Host Device Assignment"
-* disk:...        See "Block Devices"
-* serial:...      See "Character Devices"
 * braille         See "Character Devices"
-* net:...         See "Network Devices"
-* bt:...          not yet available with -device
 
 === Watchdog Devices ===
 
@@ -358,17 +342,11 @@ and host USB devices.  PCI devices can only be assigned with -device:
 
     -device vfio-pci,host=ADDR,id=ID
 
-The old way to assign a host USB device is
-
-    -usbdevice host:auto:BUS.ADDR:VID:PRID
-
-where any of BUS, ADDR, VID, PRID can be the wildcard *.
-
-The new way is
+To assign a host USB device use:
 
     -device usb-host,hostbus=BUS,hostaddr=ADDR,vendorid=VID,productid=PRID
 
-Omitted options match anything, just like the old way's wildcard.
+Omitted options match anything.
 
 === Default Devices ===
 
-- 
2.18.4


