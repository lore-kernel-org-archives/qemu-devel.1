Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCE9C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 09:22:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99BB82082F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 09:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="igTXx5/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99BB82082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWzin-0006Gw-MF
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 04:22:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iWzi3-0005pv-S4
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 04:22:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iWzi0-0008U7-77
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 04:22:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20301
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iWzhx-0008QH-Ev
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 04:22:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574155319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Rq0C8YjHA+S/tSICJOwI9sHyh6UoHo3kISx0tvyTtZw=;
 b=igTXx5/c7qea2gBfyUNAFMCG9O4m19IP/Ww4E8au2ZWbtUekntNXy83HTXDZ4WDgrZeXLe
 TUh6ZuSa2h4zQqg5/0XnTrzeYQ3Wr2XiZ3stMpbuURU3Vrqy1QLozCWtpjfeRGeRfC7y8P
 ogy4qwTzvdGdgUU0blQNRmjUOp5pYzA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-3dRlCE7ZPOyd--3vmgACiA-1; Tue, 19 Nov 2019 04:21:57 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FDE9107ACC4;
 Tue, 19 Nov 2019 09:21:55 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 93B7875E41;
 Tue, 19 Nov 2019 09:21:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] travis.yml: Remove the redundant
 clang-with-MAIN_SOFTMMU_TARGETS entry
Date: Tue, 19 Nov 2019 10:21:47 +0100
Message-Id: <20191119092147.4260-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 3dRlCE7ZPOyd--3vmgACiA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We test clang with the MAIN_SOFTMMU_TARGETS twice, once without
sanitizers and once with sanitizers enabled. That's somewhat redundant
since if compilation and tests succeeded with sanitizers enabled, it
should also work fine without sanitizers. Thus remove the clang entry
without sanitizers to speed up the CI testing a little bit.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .travis.yml | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index b9a026c8ee..47875bdafe 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -181,12 +181,6 @@ matrix:
       compiler: clang
=20
=20
-    - env:
-        - CONFIG=3D"--disable-user --target-list=3D${MAIN_SOFTMMU_TARGETS}=
"
-        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-clang-default"
-      compiler: clang
-
-
     - env:
         - CONFIG=3D"--target-list=3D${MAIN_SOFTMMU_TARGETS} "
         - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-clang-sanitize"
--=20
2.23.0


