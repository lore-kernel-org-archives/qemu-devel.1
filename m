Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29696C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:48:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E64420B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zzoi4wrd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E64420B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI8Vf-0002PW-FI
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 06:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8Tw-0000Dp-LV
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:46:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47810
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8Tu-0004W6-RC
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600166797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VJ3fvYcZfAhMpKefh6bvQo2IkLj6yxPmWEKt+9Z9uQU=;
 b=Zzoi4wrd26Mh6yLPg1tGMI4V1RSPAHaX52TF5llieX1R/zepYorpZxDhW4HAQJJyZbSn5Q
 VT8/gzbqTJClF5uUtjG7jNMYIA2nx9tu9mKDTcjkPgf02AnB/4+ZbJZvtyy5SwI1zhzHFp
 D2sV3KXA2euhdgzgy2vKFZ9HouJg/Wo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-thpCz1B4PxiwOLhpk9lUUg-1; Tue, 15 Sep 2020 06:46:35 -0400
X-MC-Unique: thpCz1B4PxiwOLhpk9lUUg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4014A1084D62;
 Tue, 15 Sep 2020 10:46:34 +0000 (UTC)
Received: from localhost (ovpn-113-7.ams2.redhat.com [10.36.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D9D5C5FC2A;
 Tue, 15 Sep 2020 10:46:33 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 02/22] qemu-iotests: Fix FilePaths docstring
Date: Tue, 15 Sep 2020 12:46:07 +0200
Message-Id: <20200915104627.699552-3-mreitz@redhat.com>
In-Reply-To: <20200915104627.699552-1-mreitz@redhat.com>
References: <20200915104627.699552-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:11:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nir Soffer <nirsof@gmail.com>

When this class was extracted from FilePath, the docstring was not
updated for generating multiple files, and the example usage was
referencing unrelated file.

While fixing the docstring, add example for creating sockets, which
should use iotests.sock_dir instead of the default base_dir.

Fixes: de263986b5dc
Signed-off-by: Nir Soffer <nsoffer@redhat.com>
Message-Id: <20200828232152.205833-3-nsoffer@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 36814daf84..bbe63a6da0 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -450,14 +450,21 @@ def file_pattern(name):
 
 class FilePaths:
     """
-    FilePaths is an auto-generated filename that cleans itself up.
+    Context manager generating multiple file names. The generated files are
+    removed when exiting the context.
 
-    Use this context manager to generate filenames and ensure that the file
-    gets deleted::
+    Example usage:
+
+        with FilePaths(['a.img', 'b.img']) as (img_a, img_b):
+            # Use img_a and img_b here...
+
+        # a.img and b.img are automatically removed here.
+
+    By default images are created in iotests.test_dir. To create sockets use
+    iotests.sock_dir:
+
+       with FilePaths(['a.sock'], base_dir=iotests.sock_dir) as (sock,):
 
-        with FilePaths(['test.img']) as img_path:
-            qemu_img('create', img_path, '1G')
-        # migration_sock_path is automatically deleted
     """
     def __init__(self, names, base_dir=test_dir):
         self.paths = []
-- 
2.26.2


