Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0854AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:43:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBA5E2074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHT3mYCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA5E2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhEVd-0005FP-1v
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 11:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jhEQJ-0004t9-AM
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:38:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48580
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jhEQI-00023R-Lc
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591371502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D8qi9ytLXYXL9phEhAXY7r2w/wEkZABvMwRhIgTiOho=;
 b=LHT3mYCDqWY+ccIFt9XLU4mLfkPlilmLOcOuYjPFyxWOWI3Fn+bjpxUajnSGrflF38a9ml
 6BqpNIUizRVPc0kiGIb+WYgs4I2AC9/lGj/B1QwUEPylRYyQWTfntZNsRteXTfScznXswc
 chrY0p6KySpwDcDUb8glqru4f5NzaxM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-ijFIKAEDMZO6hlYNA2q6iA-1; Fri, 05 Jun 2020 11:38:14 -0400
X-MC-Unique: ijFIKAEDMZO6hlYNA2q6iA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5091619200CA;
 Fri,  5 Jun 2020 15:38:13 +0000 (UTC)
Received: from localhost (ovpn-113-2.ams2.redhat.com [10.36.113.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EBAB15C583;
 Fri,  5 Jun 2020 15:38:12 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 04/10] docs/s390x: document 3270
Date: Fri,  5 Jun 2020 17:37:50 +0200
Message-Id: <20200605153756.392825-5-cohuck@redhat.com>
In-Reply-To: <20200605153756.392825-1-cohuck@redhat.com>
References: <20200605153756.392825-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add some basic info how to use 3270 devices.

Message-Id: <20200515151518.83950-3-cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 docs/system/s390x/3270.rst   | 32 ++++++++++++++++++++++++++++++++
 docs/system/target-s390x.rst |  1 +
 2 files changed, 33 insertions(+)
 create mode 100644 docs/system/s390x/3270.rst

diff --git a/docs/system/s390x/3270.rst b/docs/system/s390x/3270.rst
new file mode 100644
index 000000000000..1774cdcadf01
--- /dev/null
+++ b/docs/system/s390x/3270.rst
@@ -0,0 +1,32 @@
+3270 devices
+============
+
+QEMU supports connecting an external 3270 terminal emulator (such as
+``x3270``) to make a single 3270 device available to a guest. Note that this
+supports basic features only.
+
+To provide a 3270 device to a guest, create a ``x-terminal3270`` linked to
+a ``tn3270`` chardev. The guest will see a 3270 channel device. In order
+to actually be able to use it, attach the ``x3270`` emulator to the chardev.
+
+Example configuration
+---------------------
+
+* Add a ``tn3270`` chardev and a ``x-terminal3270`` to the QEMU command line::
+
+    -chardev socket,id=char_0,host=0.0.0.0,port=2300,nowait,server,tn3270
+    -device x-terminal3270,chardev=char_0,devno=fe.0.000a,id=terminal_0
+
+* Start the guest. In the guest, use ``chccwdev -e 0.0.000a`` to enable
+  the device.
+
+* On the host, start the ``x3270`` emulator::
+
+    x3270 <host>:2300
+
+* In the guest, locate the 3270 device node under ``/dev/3270/`` (say,
+  ``tty1``) and start a getty on it::
+
+    systemctl start serial-getty@3270-tty1.service
+
+This should get you an addtional tty for logging into the guest.
diff --git a/docs/system/target-s390x.rst b/docs/system/target-s390x.rst
index 37ca032d98ef..2592a05303ef 100644
--- a/docs/system/target-s390x.rst
+++ b/docs/system/target-s390x.rst
@@ -24,6 +24,7 @@ or vfio-ap is also available.
 .. toctree::
    s390x/vfio-ap
    s390x/css
+   s390x/3270
 
 Architectural features
 ======================
-- 
2.25.4


