Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22403C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAAD220661
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WOEPQ4da"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAAD220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVy6Y-0000Sb-38
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jVxy1-0004KV-RV
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:50:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23928
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jVxy0-0002tK-SI
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588686636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0BHKYf+uyjsemkjgPewlgPN6fBK+tXCMv6UZn0yd3kI=;
 b=WOEPQ4daDktG5820eMWrbEq5qHfbzJ1Xn1jOaHnfYjopwT4eikpO5rZdqjoEf+rjGYUEuL
 7245oOMBkeQw4DzPQT7UDgcEcBOV6Ljw9YRKM/2MYTBFrAKuHDmxXP67Q4P2EDynPc2NUR
 yHMtSkyLl3dKQcTsabcG3+P4jx9Pf5M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-KdZYq_xSNmG4FbsEkBNpDQ-1; Tue, 05 May 2020 09:50:34 -0400
X-MC-Unique: KdZYq_xSNmG4FbsEkBNpDQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF6578014C0;
 Tue,  5 May 2020 13:50:33 +0000 (UTC)
Received: from localhost (ovpn-112-219.ams2.redhat.com [10.36.112.219])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 64B335C1D3;
 Tue,  5 May 2020 13:50:33 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-s390x@nongnu.org
Subject: [PATCH 2/3] docs/s390x: document 3270
Date: Tue,  5 May 2020 15:50:24 +0200
Message-Id: <20200505135025.14614-3-cohuck@redhat.com>
In-Reply-To: <20200505135025.14614-1-cohuck@redhat.com>
References: <20200505135025.14614-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:19
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
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add some basic info how to use 3270 devices.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 docs/system/s390x/3270.rst   | 32 ++++++++++++++++++++++++++++++++
 docs/system/target-s390x.rst |  1 +
 2 files changed, 33 insertions(+)
 create mode 100644 docs/system/s390x/3270.rst

diff --git a/docs/system/s390x/3270.rst b/docs/system/s390x/3270.rst
new file mode 100644
index 000000000000..e367a457e001
--- /dev/null
+++ b/docs/system/s390x/3270.rst
@@ -0,0 +1,32 @@
+3270 devices
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+With the aid of the ``x3270`` emulator, QEMU provides limited support
+for making a single 3270 device available to a guest. Note that this
+supports basic features only.
+
+To provide a 3270 device to a guest, create a ``x-3270device`` linked to
+a ``tn3270`` chardev. The guest will see a 3270 channel device. In order
+to actually be able to use it, attach the ``x3270`` emulator to the charde=
v.
+
+Example configuration
+---------------------
+
+* Add a ``tn3270`` chardev and a ``x-3270device`` to the QEMU command line=
::
+
+    -chardev socket,id=3Dchar_0,host=3D0.0.0.0,port=3D23,nowait,server,tn3=
270
+    -device x-terminal3270,chardev=3Dchar_0,devno=3Dfe.0.000a,id=3Dtermina=
l_0
+
+* Start the guest. In the guest, use ``chccwdev -e 0.0.000a`` to enable
+  the device.
+
+* On the host, start the ``x3270`` emulator::
+
+    x3270 <host>:23
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
=20
 Architectural features
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--=20
2.21.3


