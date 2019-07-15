Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB06CC76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 17:48:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4596205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 17:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4596205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn55k-0004IN-Ej
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 13:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50449)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hn55Y-0003if-P5
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 13:48:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hn55X-0006nM-Jj
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 13:48:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58574)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hn55X-0006lu-DS; Mon, 15 Jul 2019 13:48:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 522D7308A958;
 Mon, 15 Jul 2019 17:48:34 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EEE05C224;
 Mon, 15 Jul 2019 17:48:20 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>
Date: Mon, 15 Jul 2019 19:48:07 +0200
Message-Id: <20190715174817.18981-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Mon, 15 Jul 2019 17:48:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH-for-4.1 v2 0/9] tests/docker: Debian & MXE fixes
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
 Laszlo Ersek <lersek@redhat.com>, Helge Deller <deller@gmx.de>,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Few more patches to be able to MXE-build the NSIS installers.

The Fedora kludge is not meant for merge, but might be useful to
test this series.

Based-on: 20190712111849.9006-1-alex.bennee@linaro.org
https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg03014.html

Philippe Mathieu-Daud=C3=A9 (9):
  tests/docker: Kludge to build the Fedora image
  tests/docker: Install Sphinx in the Debian images
  tests/docker: Install the NSIS tools in the MinGW capable images
  tests/docker: Set the correct cross-PKG_CONFIG_PATH in the MXE images
  tests/docker: Install texinfo in the Fedora image
  buildsys: The NSIS Windows build requires the documentation installed
  buildsys: The NSIS Windows build requires qemu-nsis.bmp installed
  tests/docker: Let the test-mingw test generate a NSIS installer
  NSIS: Add missing firmware blobs

 Makefile                                           | 3 ++-
 qemu.nsi                                           | 3 +++
 tests/docker/dockerfiles/debian-win32-cross.docker | 6 ++++++
 tests/docker/dockerfiles/debian-win64-cross.docker | 6 ++++++
 tests/docker/dockerfiles/debian10.docker           | 1 +
 tests/docker/dockerfiles/debian9.docker            | 1 +
 tests/docker/dockerfiles/fedora.docker             | 5 ++++-
 tests/docker/test-mingw                            | 1 +
 8 files changed, 24 insertions(+), 2 deletions(-)

--=20
2.20.1


