Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC2BC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 11:35:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0719A207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 11:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0719A207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBHCM-0006mA-Nk
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 07:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBHAU-0004iX-BI
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 07:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBHAS-00016K-GR
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 07:33:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36176)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iBHAS-00014H-Bs
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 07:33:40 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 10F903082124;
 Fri, 20 Sep 2019 11:33:38 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.206.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A4DE010027AA;
 Fri, 20 Sep 2019 11:33:31 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Justin Terry <juterry@microsoft.com>
Subject: [PATCH v2 0/3] testing: Build WHPX enabled binaries
Date: Fri, 20 Sep 2019 13:33:26 +0200
Message-Id: <20190920113329.16787-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 20 Sep 2019 11:33:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a job to cross-build QEMU with WHPX enabled.

Since the WHPX is currently broken, include the patch required to have
successful Shippable build.

I previously included the WHPX headers shared by the Android project,
and Daniel asked me to check the EULA. While trying to manually
install the Windows SDK, I noticed the installer fetches archives
directly, kindly asking where they are stored via the /fwlink API.
Do the same, fetch the required archives and extract them. No need
to accept EULA...

Docker build the image first, then build QEMU in a instance of this
image. The image is internal to Shippable, the instances are not
reachable and are thrown once the build is finished. What we collect
from Shippable is the console output of QEMU build process, and if
the build process succeed or failed. So far we do not redistribute
the image or built binaries.

Philippe Mathieu-Daud=C3=A9 (3):
  target/i386: Fix broken build with WHPX enabled
  tests/docker: Add fedora-win10sdk-cross image
  .shippable.yml: Build WHPX enabled binaries

 .shippable.yml                                |  2 ++
 target/i386/whpx-all.c                        |  1 +
 tests/docker/Makefile.include                 |  2 ++
 .../dockerfiles/fedora-win10sdk-cross.docker  | 23 ++++++++++++++++
 tests/docker/dockerfiles/win10sdk-dl.sh       | 27 +++++++++++++++++++
 5 files changed, 55 insertions(+)
 create mode 100644 tests/docker/dockerfiles/fedora-win10sdk-cross.docker
 create mode 100755 tests/docker/dockerfiles/win10sdk-dl.sh

--=20
2.20.1


