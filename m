Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7E6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 15:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B6D20728
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 15:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HdyJytwu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B6D20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZc4s-0005pE-Jw
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 11:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jZc3k-0004AV-1J
 for qemu-devel@nongnu.org; Fri, 15 May 2020 11:15:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56587
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jZc3i-0005za-FP
 for qemu-devel@nongnu.org; Fri, 15 May 2020 11:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589555733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6pddmoRnqZoHNeMB0r0PyY5bEn79vipDG8JOISd/tkc=;
 b=HdyJytwuilSXYazWi6lzCdMm3YMh+5MFfWDcs4HZCXKhUVRkxHomos7WBUsDZRIU3TDa6z
 JCZ27lrSgskjzbgyprSAepmaOCYQJr1r5q3mwpb0tE1d3tuFzs52VHXof/WkyPxFlVwOBo
 YeXYQrwsT/4BXCBlOvKXKpWMqLUqcuc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-sD3zGBhyOdOS50vKX5ha2Q-1; Fri, 15 May 2020 11:15:31 -0400
X-MC-Unique: sD3zGBhyOdOS50vKX5ha2Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBEF68735C8;
 Fri, 15 May 2020 15:15:30 +0000 (UTC)
Received: from localhost (ovpn-112-229.ams2.redhat.com [10.36.112.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 420E06E9E5;
 Fri, 15 May 2020 15:15:30 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-s390x@nongnu.org
Subject: [PATCH v2 3/3] docs/s390x: document vfio-ccw
Date: Fri, 15 May 2020 17:15:18 +0200
Message-Id: <20200515151518.83950-4-cohuck@redhat.com>
In-Reply-To: <20200515151518.83950-1-cohuck@redhat.com>
References: <20200515151518.83950-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a basic example for passing a dasd via vfio-ccw.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 docs/system/s390x/vfio-ccw.rst | 72 ++++++++++++++++++++++++++++++++++
 docs/system/target-s390x.rst   |  1 +
 2 files changed, 73 insertions(+)
 create mode 100644 docs/system/s390x/vfio-ccw.rst

diff --git a/docs/system/s390x/vfio-ccw.rst b/docs/system/s390x/vfio-ccw.rst
new file mode 100644
index 000000000000..4cfd22c3b789
--- /dev/null
+++ b/docs/system/s390x/vfio-ccw.rst
@@ -0,0 +1,72 @@
+Subchannel passthrough via vfio-ccw
+===================================
+
+vfio-ccw (based upon the mediated vfio device infrastructure) allows to
+make certain I/O subchannels and their devices available to a guest. The
+host will not interact with those subchannels/devices any more.
+
+Note that while vfio-ccw should work with most non-QDIO devices, only ECKD
+DASDs have really been tested.
+
+Example configuration
+---------------------
+
+Step 1: configure the host device
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Note: it is recommended to use the ``mdevctl`` tool for this step.
+
+To define the same device as configured below to be started
+automatically, use
+
+::
+
+   [root@host ~]# driverctl -b css set-override 0.0.0313 vfio_ccw
+   [root@host ~]# mdevctl define -u 7e270a25-e163-4922-af60-757fc8ed48c6\
+                  -p 0.0.0313 -t vfio-ccw_io -a
+
+If this is not possible or wanted, follow the manual procedure below.
+
+* Locate the subchannel for the device (in this example, ``0.0.2b09``)::
+
+    [root@host ~]# lscss | grep 0.0.2b09 | awk '{print $2}'
+    0.0.0313
+
+* Unbind the subchannel (in this example, ``0.0.0313``) from the standard
+  I/O subchannel driver and bind it to the vfio-ccw driver::
+
+    [root@host ~]# echo 0.0.0313 > /sys/bus/css/devices/0.0.0313/driver/unbind
+    [root@host ~]# echo 0.0.0313 > /sys/bus/css/drivers/vfio_ccw/bind
+
+* Create the mediated device (identified by a uuid)::
+
+    [root@host ~]# uuidgen
+    7e270a25-e163-4922-af60-757fc8ed48c6
+    [root@host ~]# echo "7e270a25-e163-4922-af60-757fc8ed48c6" > \
+    /sys/bus/css/devices/0.0.0313/mdev_supported_types/vfio_ccw-io/create
+
+Step 2: configure QEMU
+~~~~~~~~~~~~~~~~~~~~~~
+
+* Reference the created mediated device and (optionally) pick a device id to
+  be presented in the guest (here, ``fe.0.1234``, which will end up visible
+  in the guest as ``0.0.1234``::
+
+    -device vfio-ccw,devno=fe.0.1234,sysfsdev=\
+    /sys/bus/mdev/devices/7e270a25-e163-4922-af60-757fc8ed48c6
+
+* Start the guest. The device (here, ``0.0.1234``) should now be usable::
+
+    [root@guest ~]# lscss -d 0.0.1234
+    Device   Subchan.  DevType CU Type Use  PIM PAM POM  CHPIDs           
+    ----------------------------------------------------------------------
+    0.0.1234 0.0.0007  3390/0e 3990/e9      f0  f0  ff   1a2a3a0a 00000000
+    [root@guest ~]# chccwdev -e 0.0.1234
+    Setting device 0.0.1234 online
+    Done
+    [root@guest ~]# dmesg -t
+    (...)
+    dasd-eckd 0.0.1234: A channel path to the device has become operational
+    dasd-eckd 0.0.1234: New DASD 3390/0E (CU 3990/01) with 10017 cylinders, 15 heads, 224 sectors
+    dasd-eckd 0.0.1234: DASD with 4 KB/block, 7212240 KB total size, 48 KB/track, compatible disk layout
+    dasda:VOL1/  0X2B09: dasda1
diff --git a/docs/system/target-s390x.rst b/docs/system/target-s390x.rst
index 2592a05303ef..644e404ef9fd 100644
--- a/docs/system/target-s390x.rst
+++ b/docs/system/target-s390x.rst
@@ -25,6 +25,7 @@ or vfio-ap is also available.
    s390x/vfio-ap
    s390x/css
    s390x/3270
+   s390x/vfio-ccw
 
 Architectural features
 ======================
-- 
2.25.4


