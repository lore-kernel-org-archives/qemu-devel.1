Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09233C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:22:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBD5D22CBB
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ej+NG7fX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD5D22CBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBGur-0006G5-WD
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 08:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kBGu2-00055f-Gy
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:21:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30343)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kBGtx-0003Ya-8H
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598530867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DDTULzELLcU5lTKvin3OhpsI+JtzWux6k8dG0iN71Uw=;
 b=ej+NG7fXqWlnnluvq3pqoJ0G6avkjh2HIOTeQ/FLH5tdIHZY4cwh2Q0ME0DTmSbgapTuZn
 +6LYghGcy7RRGk/8T9Y5/1RFztWFnjJxuYQpI/bk9HiFqp16OG/QTgeHyFA0vbSrNvHIu2
 bip48JTA3C6o9AJAcBMNkS6zPOcdbBY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-6wokyHOBPJe2ALT8nMa2Rg-1; Thu, 27 Aug 2020 08:21:05 -0400
X-MC-Unique: 6wokyHOBPJe2ALT8nMa2Rg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 377B0F6C01;
 Thu, 27 Aug 2020 12:21:04 +0000 (UTC)
Received: from localhost (ovpn-113-237.ams2.redhat.com [10.36.113.237])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D299178370;
 Thu, 27 Aug 2020 12:21:03 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/3] virtio-ccw-input: fix description
Date: Thu, 27 Aug 2020 14:20:55 +0200
Message-Id: <20200827122057.232662-2-cohuck@redhat.com>
In-Reply-To: <20200827122057.232662-1-cohuck@redhat.com>
References: <20200827122057.232662-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:54:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix a copy/paste error.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200728102820.273598-1-cohuck@redhat.com>
---
 hw/s390x/virtio-ccw-input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/virtio-ccw-input.c b/hw/s390x/virtio-ccw-input.c
index 5601e25deed8..83136fbba15c 100644
--- a/hw/s390x/virtio-ccw-input.c
+++ b/hw/s390x/virtio-ccw-input.c
@@ -1,5 +1,5 @@
 /*
- * virtio ccw scsi implementation
+ * virtio ccw input implementation
  *
  * Copyright 2012, 2015 IBM Corp.
  *
-- 
2.25.4


