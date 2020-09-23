Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33410C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:19:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9968621BE5
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NOw95NVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9968621BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL8Qm-0006YD-LH
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 13:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kL8PS-0005WI-Jr
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 13:18:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35228)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kL8PQ-00006s-Oa
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 13:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600881504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=mWojMheGZWSRnSgRE3G04AKltkt7yfbGQSkQ/gHEfVE=;
 b=NOw95NVD/CYCgQq5Zu6e1xyquliEzZgzKJMLeHrWikuKwpruthyeT+vJa1BGp2NWtXLGKD
 PK81/aOYBhqdJ1OFyHU0DuyP7Yd5iClIfLlnsU7Rj6fe44PUxkuOhmCnjywY2JAyWwm3Xs
 i3fwse+yq9njwFgLwL35IVUl51G7AEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-OfTdVhUuNHWWoBbIjyC_ZQ-1; Wed, 23 Sep 2020 13:18:20 -0400
X-MC-Unique: OfTdVhUuNHWWoBbIjyC_ZQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D5FD801FD4;
 Wed, 23 Sep 2020 17:18:19 +0000 (UTC)
Received: from thuth.com (ovpn-112-49.ams2.redhat.com [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 474E219728;
 Wed, 23 Sep 2020 17:18:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] docs/system/deprecated: Mark the 'moxie' CPU as deprecated
Date: Wed, 23 Sep 2020 19:18:15 +0200
Message-Id: <20200923171815.97801-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Anthony Green <green@moxielogic.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is currently unclear whether anybody is still using the 'moxie' CPU,
and there are no images for testing available this CPU, so the code has
likely bit-rotten in the course of time. When I asked the maintainer
for information, I did not get a reply within four weeks yet (see
https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg07201.html).
The last Signed-off-by line from Anthony in our repo is from 2013,
so it seems like this code is rather unmaintained. Time to put it onto
the deprecation list to see whether somebody is still interested in this
code or whether we could remove it in a couple of releases.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/system/deprecated.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index e3dcf1f149..ac92a7afcf 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -322,6 +322,14 @@ for VNC should be performed using the pluggable QAuthZ objects.
 System emulator CPUS
 --------------------
 
+``moxie`` CPU (since 5.2.0)
+'''''''''''''''''''''''''''
+
+The ``moxie`` guest CPU support is deprecated and will be removed in
+a future version of QEMU. It's unclear whether anybody is still using
+CPU emulation in QEMU, and there are no test images available to make
+sure that the code is still working.
+
 ``compat`` property of server class POWER CPUs (since 5.0)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
-- 
2.18.2


