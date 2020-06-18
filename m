Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE116C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:45:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2B99206FA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QH/I+vKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B99206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlwj5-0001Sm-0n
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 11:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jlwdO-0001Cb-Gz
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:39:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22481
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jlwdM-0008TX-2J
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592494759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TWpT4jkGl2N9gsyZimcFt+Ki1BcBHkTNI7OIlqD8oho=;
 b=QH/I+vKYre1PFohEhi8LE6NqUmTzjMMJzo3VQXVV4sNEKPUwwY+5yRCuuW36WGl56Im39c
 SFawpbKuTw8SS9R9XotPcmSqAWDXXtNYhEOy1AT3qcKmNT99YOHTtM21JvDcRk+Yj4+ZUw
 yIX1rX76cuqEolcQWsG+GPE4x1xpoPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-yVsl1nGINrGFzQkuSVhjPg-1; Thu, 18 Jun 2020 11:39:15 -0400
X-MC-Unique: yVsl1nGINrGFzQkuSVhjPg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 112361800D4A;
 Thu, 18 Jun 2020 15:39:14 +0000 (UTC)
Received: from localhost (ovpn-113-9.ams2.redhat.com [10.36.113.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA6AB60CD0;
 Thu, 18 Jun 2020 15:39:13 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 7/7] docs/s390x: fix vfio-ap device_del description
Date: Thu, 18 Jun 2020 17:38:54 +0200
Message-Id: <20200618153854.271723-8-cohuck@redhat.com>
In-Reply-To: <20200618153854.271723-1-cohuck@redhat.com>
References: <20200618153854.271723-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:47:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

device_del requires an id and not a sysfsfile.

Fixes: bac03ec72f1b ("s390x/vfio-ap: document hot plug/unplug of vfio-ap device")
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200617160604.5593-1-borntraeger@de.ibm.com>
[CH: add missing '$']
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 docs/system/s390x/vfio-ap.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/system/s390x/vfio-ap.rst b/docs/system/s390x/vfio-ap.rst
index 3cd84179a2df..084ba9c4e3b0 100644
--- a/docs/system/s390x/vfio-ap.rst
+++ b/docs/system/s390x/vfio-ap.rst
@@ -606,10 +606,11 @@ action.
 
 To hot plug a vfio-ap device, use the QEMU ``device_add`` command::
 
-    (qemu) device_add vfio-ap,sysfsdev="$path-to-mdev"
+    (qemu) device_add vfio-ap,sysfsdev="$path-to-mdev",id="$id"
 
 Where the ``$path-to-mdev`` value specifies the absolute path to a mediated
 device to which AP resources to be used by the guest have been assigned.
+``$id`` is the name value for the optional id parameter.
 
 Note that on Linux guests, the AP devices will be created in the
 ``/sys/bus/ap/devices`` directory when the AP bus subsequently performs its periodic
@@ -632,10 +633,9 @@ or a prior hot plug action.
 
 To hot unplug a vfio-ap device, use the QEMU ``device_del`` command::
 
-    (qemu) device_del vfio-ap,sysfsdev="$path-to-mdev"
+    (qemu) device_del "$id"
 
-Where ``$path-to-mdev`` is the same as the path specified when the vfio-ap
-device was attached to the virtual machine's ap-bus.
+Where ``$id`` is the same id that was specified at device creation.
 
 On a Linux guest, the AP devices will be removed from the ``/sys/bus/ap/devices``
 directory on the guest when the AP bus subsequently performs its periodic scan,
-- 
2.25.4


