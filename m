Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8AEC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:26:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB7CE208C7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gogk0mfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7CE208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDkZh-000061-Ub
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 04:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kDkXE-0003Bh-Cf
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:23:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31010
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kDkXC-0008T8-H1
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599121433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6R9Jg7opXvR8jDkvvA6MGBCHBDiXgUX75X5k3fE0S+k=;
 b=gogk0mfB9sqpcWw1ik1Ixr1VrOYf2mUjXHoqSh6rUDfpsjErT2k21V621kJIv5TpEjN3Ti
 llABqvxHCzBUVSLVEjngo2wDMasvKid+FcBrBj4hlJ4K1HNausrJx15K2RB1ooowLVKs/6
 TKZQ1MezTed/TwPd7TYY91fkSzHQrMM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-ARE-wZPsN12U4Io6YID6kg-1; Thu, 03 Sep 2020 04:23:51 -0400
X-MC-Unique: ARE-wZPsN12U4Io6YID6kg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03A2C107B768;
 Thu,  3 Sep 2020 08:23:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DCB5419C59;
 Thu,  3 Sep 2020 08:23:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CD67910C778B; Thu,  3 Sep 2020 10:23:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 8/8] docs/qdev-device-use: Don't suggest -drive and -net can do
 USB
Date: Thu,  3 Sep 2020 10:23:44 +0200
Message-Id: <20200903082344.1877175-9-armbru@redhat.com>
In-Reply-To: <20200903082344.1877175-1-armbru@redhat.com>
References: <20200903082344.1877175-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:28:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 480324ec8d "docs/qdev-device-use: Clean up the sentences
related to -usbdevice" deleted the information on syntax that no
longer works.  Unfortunately, the resulting text suggests you can
configure USB block devices with -drive, and USB network devices with
-net, which is misleading.

Instead of rephrasing the now misleading text, I'm putting the
information back, and just make clear it's about old versions of QEMU.

Cc: Thomas Huth <thuth@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200806081147.3123652-4-armbru@redhat.com>
---
 docs/qdev-device-use.txt | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/docs/qdev-device-use.txt b/docs/qdev-device-use.txt
index 9889521e3c..245cdf29c7 100644
--- a/docs/qdev-device-use.txt
+++ b/docs/qdev-device-use.txt
@@ -125,7 +125,14 @@ The -device argument differs in detail for each type of drive:
 
 * if=pflash, if=mtd, if=sd, if=xen are not yet available with -device
 
-For USB storage devices, you can use something like:
+For USB devices, the old way was actually different:
+
+    -usbdevice disk:format=FMT:FILENAME
+
+"Was" because "disk:" is gone since v2.12.0.
+
+The old way provided much less control than -drive's OPTS...  The new
+way fixes that:
 
     -device usb-storage,drive=DRIVE-ID,removable=RMB
 
@@ -178,6 +185,9 @@ The appropriate DEVNAME depends on the machine type.  For type "pc":
 
   -device usb-braille,chardev=braille -chardev braille,id=braille
 
+* -usbdevice serial::chardev is gone since v2.12.0.  It became
+  -device usb-serial,chardev=dev.
+
 LEGACY-CHARDEV translates to -chardev HOST-OPTS... as follows:
 
 * null becomes -chardev null
@@ -231,6 +241,12 @@ The old way to define the guest part looks like this:
 
     -net nic,netdev=NET-ID,macaddr=MACADDR,model=MODEL,name=ID,addr=STR,vectors=V
 
+Except for USB it looked like this:
+
+    -usbdevice net:netdev=NET-ID,macaddr=MACADDR,name=ID
+
+"Looked" because "net:" is gone since v2.12.0.
+
 The new way is -device:
 
     -device DEVNAME,netdev=NET-ID,mac=MACADDR,DEV-OPTS...
@@ -328,6 +344,13 @@ The new way is -device DEVNAME,DEV-OPTS...  Details depend on DRIVER:
 * u2f             -device u2f-{emulated,passthru}
 * braille         See "Character Devices"
 
+Until v2.12.0, we additionally had
+
+* host:...        See "Host Device Assignment"
+* disk:...        See "Block Devices"
+* serial:...      See "Character Devices"
+* net:...         See "Network Devices"
+
 === Watchdog Devices ===
 
 Host and guest part of watchdog devices have always been separate.
@@ -343,7 +366,14 @@ and host USB devices.  PCI devices can only be assigned with -device:
 
     -device vfio-pci,host=ADDR,id=ID
 
-To assign a host USB device use:
+The old way to assign a USB host device
+
+    -usbdevice host:auto:BUS.ADDR:VID:PRID
+
+was removed in v2.12.0.  Any of BUS, ADDR, VID, PRID could be the
+wildcard *.
+
+The new way is
 
     -device usb-host,hostbus=BUS,hostaddr=ADDR,vendorid=VID,productid=PRID
 
-- 
2.26.2


