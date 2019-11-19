Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2367CC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0E792068F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ov4UoCe7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E792068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX739-0000xj-GO
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 12:12:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iX6zV-0005Pr-NP
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:08:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iX6zT-0004Fa-Nb
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:08:36 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40234
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iX6zQ-0004DL-RE
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:08:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574183312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=D/EdQ7m9Ml0kThkiyNOqvSzD8lEE+OryYE8c//DizhQ=;
 b=Ov4UoCe7TeJCWaW8YCMt+Cx1w0u309PGlVGL9xjxyJBtJAXIJYTjISPL76I1f/3GcvKbPS
 1AaCi3nz//NE2DhmGWos3x2w/8kR29joybhZ7teynhhOvK+2qXUzMtDmbNGDDRD1Jfghrj
 0Isws8CMf21YaXq1QR6+7UHNb5BjA7k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-RA6nIR4GMEWCvpNpeNzb1A-1; Tue, 19 Nov 2019 12:08:29 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4C27801FA1;
 Tue, 19 Nov 2019 17:08:27 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E8D45E254;
 Tue, 19 Nov 2019 17:08:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/6] Enable Travis builds on arm64, ppc64le and s390x
Date: Tue, 19 Nov 2019 18:08:15 +0100
Message-Id: <20191119170822.45649-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: RA6nIR4GMEWCvpNpeNzb1A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Travis recently added build hosts for arm64, ppc64le and s390x, so
this is a welcome addition to our Travis testing matrix.

Unfortunately, the builds are running in quite restricted LXD containers
there, for example it is not possible to create huge files there (even
if they are just sparse), and certain system calls are blocked. So we
have to change some tests first to stop them failing in such environments.

I also included Alex' patch for dropping some targets from the
MAIN_SOFTMMU_TARGETS config variable, since at least on arm64, the
build process seems to be rather slow and sometimes hits the 50 minutes
timeout otherwise.

For the curious, here's a test run (non-x86 at the end of the page):

 https://travis-ci.com/huth/qemu/jobs/258095792

 Thomas


Alex Benn=C3=A9e (1):
  travis.yml: drop 32 bit systems from MAIN_SOFTMMU_TARGETS

Thomas Huth (5):
  iotests: Skip test 060 if it is not possible to create large files
  iotests: Skip test 079 if it is not possible to create large files
  tests/hd-geo-test: Skip test when images can not be created
  tests/test-util-filemonitor: Skip test on non-x86 Travis containers
  travis.yml: Enable builds on arm64, ppc64le and s390x

 .travis.yml                   | 85 ++++++++++++++++++++++++++++++++++-
 tests/hd-geo-test.c           | 12 ++++-
 tests/qemu-iotests/060        |  6 +++
 tests/qemu-iotests/079        |  6 +++
 tests/test-util-filemonitor.c | 11 +++++
 5 files changed, 118 insertions(+), 2 deletions(-)

--=20
2.23.0


