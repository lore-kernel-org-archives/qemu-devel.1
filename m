Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FA4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:51:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A0D1207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fE7lr9N7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A0D1207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw5EM-0003IV-KK
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 10:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jw5Dg-0002Yo-4L
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:50:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54888
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jw5Dd-0001Ct-D1
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594911040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dWGy+JtpcVStBAd18eZ6y8u7s7U2HGRfmg2OA6tfv78=;
 b=fE7lr9N7sXY+LrW++gPSLUpy2iiWjJDYXGYSadXbnWJ4WGA7HkI3lBt+CgzgfCW8xGabEV
 JjUooY3tsYb2NJPROHXJx7fDfwIpi9go45OKhLy+gKPqbBuqlhh6RvSEPGQ5X8grSnA7z1
 exsyULUwo6g6P5sIfKTTMX7xcZ95ik4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-lpKFeW-qNbu9FNYSG606eA-1; Thu, 16 Jul 2020 10:50:36 -0400
X-MC-Unique: lpKFeW-qNbu9FNYSG606eA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEE6D100960F;
 Thu, 16 Jul 2020 14:50:35 +0000 (UTC)
Received: from localhost (ovpn-113-57.ams2.redhat.com [10.36.113.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 81FF610013D0;
 Thu, 16 Jul 2020 14:50:35 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-s390x@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] docs/s390x: fix vfio-ccw type
Date: Thu, 16 Jul 2020 16:50:31 +0200
Message-Id: <20200716145031.771476-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:25:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix the type name in the mdevctl example.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---

I always seem to get this one wrong, and mdevctl does not complain until
it wants to start the device...

---
 docs/system/s390x/vfio-ccw.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/s390x/vfio-ccw.rst b/docs/system/s390x/vfio-ccw.rst
index 8f65442c0f56..41e0bad5b489 100644
--- a/docs/system/s390x/vfio-ccw.rst
+++ b/docs/system/s390x/vfio-ccw.rst
@@ -29,7 +29,7 @@ automatically, use
 
    [root@host ~]# driverctl -b css set-override 0.0.0313 vfio_ccw
    [root@host ~]# mdevctl define -u 7e270a25-e163-4922-af60-757fc8ed48c6 \
-                  -p 0.0.0313 -t vfio-ccw_io -a
+                  -p 0.0.0313 -t vfio_ccw-io -a
 
 If using ``mdevctl`` is not possible or wanted, follow the manual procedure
 below.
-- 
2.25.4


