Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC6EC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:35:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FC2C227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H36HjDYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC2C227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihzhg-00005D-U3
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 12:35:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihzXm-00067j-C5
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:24:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihzXl-0005l9-98
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:24:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59578
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihzXk-0005hf-VF
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:24:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576776296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3eY7agRu1Bt1uazChG+gikshqr3IfI6j+Fl6tLEcA3Y=;
 b=H36HjDYk5K2Tdfq/YeWyDHT+giROQPmhURy5yD7XHf+nAhANShFT1cVOAgjyzwhVNe/eFv
 EZxGbIDGADWnCgrOoBHToojKlo899Wmz47/hpWLFc4X3bMFR/Dde8lag8TxA/25Okkpcks
 /HJE0fQ0Go4MrJe/TCost7u7FbPSNCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-KALX4k9CMPqgG4tdcjjroQ-1; Thu, 19 Dec 2019 12:24:54 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB76C1005502;
 Thu, 19 Dec 2019 17:24:53 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF98963B8A;
 Thu, 19 Dec 2019 17:24:51 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 04/30] qapi: better document NVMe blockdev @device parameter
Date: Thu, 19 Dec 2019 18:24:15 +0100
Message-Id: <20191219172441.7289-5-kwolf@redhat.com>
In-Reply-To: <20191219172441.7289-1-kwolf@redhat.com>
References: <20191219172441.7289-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: KALX4k9CMPqgG4tdcjjroQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Mention that this is a PCI device address & give the format it is
expected in. Also mention that it must be first unbound from any
host kernel driver.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0cf68fea14..fcb52ec24f 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2963,9 +2963,13 @@
 #
 # Driver specific block device options for the NVMe backend.
 #
-# @device:    controller address of the NVMe device.
+# @device:    PCI controller address of the NVMe device in
+#             format hhhh:bb:ss.f (host:bus:slot.function)
 # @namespace: namespace number of the device, starting from 1.
 #
+# Note that the PCI @device must have been unbound from any host
+# kernel driver before instructing QEMU to add the blockdev.
+#
 # Since: 2.12
 ##
 { 'struct': 'BlockdevOptionsNVMe',
--=20
2.20.1


