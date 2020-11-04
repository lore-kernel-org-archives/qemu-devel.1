Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BC6C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 13:20:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1DDB20759
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 13:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKMO5CKZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DDB20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaIic-0003HU-Rn
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 08:20:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kaIhV-0002f4-9O
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 08:19:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45463)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kaIhT-0008Om-MN
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 08:19:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604495982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ieLv9dmyy/G0gAglfvR+qfF/TYPq2slV5F03Ohc5eSA=;
 b=YKMO5CKZLBPmKGniK7bVfW1cFZ+210B6DMhZoziblT98CAge6dNBBH4FprchwEKNp5sIsf
 mB1xNY+EvnOKZ15MaI1/N+ni4qZmE96FuVFKP2cH0xV8bj4qrZgDtnN9/BAWGqxiHhHLgI
 Hvk1ed1cruZa0F3am4oU8GL/Erucrh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-kJz7wKTBNM-AOc-HabexPw-1; Wed, 04 Nov 2020 08:19:41 -0500
X-MC-Unique: kJz7wKTBNM-AOc-HabexPw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB5C11084D8A;
 Wed,  4 Nov 2020 13:19:39 +0000 (UTC)
Received: from fedora.redhat.com (ovpn-115-26.ams2.redhat.com [10.36.115.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4EC8D2C31E;
 Wed,  4 Nov 2020 13:19:38 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] docker: remove libblockdev-mpath-devel package
Date: Wed,  4 Nov 2020 13:19:24 +0000
Message-Id: <20201104131924.593522-4-berrange@redhat.com>
In-Reply-To: <20201104131924.593522-1-berrange@redhat.com>
References: <20201104131924.593522-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This package was added in

  commit 8ea5962f286272ac2533892c07f9b7e2a77d8819
  Author: Philippe Mathieu-Daudé <philmd@redhat.com>
  Date:   Sat May 4 07:54:40 2019 +0200

    tests/docker: Test more components on the Fedora default image

but this is never used by QEMU. The multipath support in QEMU
requires the device-mapper-multipath-devel package instead, which
is already present.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/coverity-scan/coverity-scan.docker | 1 -
 tests/docker/dockerfiles/fedora.docker     | 1 -
 2 files changed, 2 deletions(-)

diff --git a/scripts/coverity-scan/coverity-scan.docker b/scripts/coverity-scan/coverity-scan.docker
index e49c5e8332..b2521e159f 100644
--- a/scripts/coverity-scan/coverity-scan.docker
+++ b/scripts/coverity-scan/coverity-scan.docker
@@ -40,7 +40,6 @@ ENV PACKAGES \
     libaio-devel \
     libasan \
     libattr-devel \
-    libblockdev-mpath-devel \
     libcap-devel \
     libcap-ng-devel \
     libcurl-devel \
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 0f5c76067b..9474b94060 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -25,7 +25,6 @@ ENV PACKAGES \
     libaio-devel \
     libasan \
     libattr-devel \
-    libblockdev-mpath-devel \
     libcap-ng-devel \
     libcacard-devel \
     libcurl-devel \
-- 
2.28.0


