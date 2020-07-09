Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577E5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 16:07:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 269B120767
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 16:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GV6HelsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269B120767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtZ5W-0002pi-Dr
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 12:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtZ2m-0007T8-Ti
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 12:05:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46022
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtZ2j-0000zv-Ug
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 12:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594310700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=1uP0rRX5sys7IyYf81527/O/Op13w4EXz/SwyxzIwdA=;
 b=GV6HelsQoLwk++MxE0UjeMvWtL4p0wc8lcaOTCt5B/igP1eACHs3I9XXbt2Hd0aTFgYEJY
 NzFnQ0hxjc3zkTvVzJ+LRGsPvunxpluhdnmWZgNG50hR5y0ZuaItq4aVZf2TJK7Ti2Rvfv
 b3AVWnKF9TjG5l2gTX/1JkcUrPJmeFo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-D1ihEJy-OiylAYsqzMmpqQ-1; Thu, 09 Jul 2020 12:04:43 -0400
X-MC-Unique: D1ihEJy-OiylAYsqzMmpqQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D3D8186A8DE;
 Thu,  9 Jul 2020 16:04:42 +0000 (UTC)
Received: from thuth.com (ovpn-112-106.ams2.redhat.com [10.36.112.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3098B60BE2;
 Thu,  9 Jul 2020 16:04:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH] docs/system/s390x: Improve the 3270 documentation
Date: Thu,  9 Jul 2020 18:04:39 +0200
Message-Id: <20200709160439.15088-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 10:34:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is some additional information about the 3270 support in our
Wiki at https://wiki.qemu.org/Features/3270 - so let's include this
information into the main documentation now to have one single
source of information (the Wiki page could later be removed).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/system/s390x/3270.rst | 43 ++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/docs/system/s390x/3270.rst b/docs/system/s390x/3270.rst
index 1774cdcadf..80350264d7 100644
--- a/docs/system/s390x/3270.rst
+++ b/docs/system/s390x/3270.rst
@@ -1,9 +1,15 @@
 3270 devices
 ============
 
-QEMU supports connecting an external 3270 terminal emulator (such as
-``x3270``) to make a single 3270 device available to a guest. Note that this
-supports basic features only.
+The 3270 is the classic 'green-screen' console of the mainframes (see the
+`IBM 3270 Wikipedia article <https://en.wikipedia.org/wiki/IBM_3270>`__).
+
+The 3270 data stream is not implemented within QEMU; the device only provides
+TN3270 (a telnet extension; see `RFC 854 <https://tools.ietf.org/html/rfc854>`__
+and `RFC 1576 <https://tools.ietf.org/html/rfc1576>`__) and leaves the heavy
+lifting to an external 3270 terminal emulator (such as ``x3270``) to make a
+single 3270 device available to a guest. Note that this supports basic
+features only.
 
 To provide a 3270 device to a guest, create a ``x-terminal3270`` linked to
 a ``tn3270`` chardev. The guest will see a 3270 channel device. In order
@@ -12,10 +18,14 @@ to actually be able to use it, attach the ``x3270`` emulator to the chardev.
 Example configuration
 ---------------------
 
+* Make sure that 3270 support is enabled in the guest's kernel. You need
+  ``CONFIG_TN3270`` and at least one of ``CONFIG_TN3270_TTY`` (for additional
+  ttys) or ``CONFIG_TN3270_CONSOLE`` (for a 3270 console).
+
 * Add a ``tn3270`` chardev and a ``x-terminal3270`` to the QEMU command line::
 
-    -chardev socket,id=char_0,host=0.0.0.0,port=2300,nowait,server,tn3270
-    -device x-terminal3270,chardev=char_0,devno=fe.0.000a,id=terminal_0
+   -chardev socket,id=ch0,host=0.0.0.0,port=2300,nowait,server,tn3270
+   -device x-terminal3270,chardev=ch0,devno=fe.0.000a,id=terminal0
 
 * Start the guest. In the guest, use ``chccwdev -e 0.0.000a`` to enable
   the device.
@@ -29,4 +39,25 @@ Example configuration
 
     systemctl start serial-getty@3270-tty1.service
 
-This should get you an addtional tty for logging into the guest.
+  This should get you an addtional tty for logging into the guest.
+
+* If you want to use the 3270 device as the kernel console instead of an
+  additional tty, you can also append ``conmode=3270 condev=000a`` to the
+  guest's kernel command line. The kernel then should use the 3270 as
+  console after the next boot.
+
+Restrictions
+------------
+
+3270 support is still experimental. In particular:
+
+* Only one 3270 device is supported.
+
+* It has only been tested with Linux guests and the x3270 emulator.
+
+* TLS/SSL is not yet supported.
+
+* Resizing on reattach is not yet supported.
+
+* Multiple commands in one inbound buffer (for example, when the reset key
+  is pressed while the network is slow) are not yet supported.
-- 
2.18.1


