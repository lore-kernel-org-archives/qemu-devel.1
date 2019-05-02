Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A156C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 16:15:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFF172089E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 16:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF172089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54001 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMEMS-0005HG-3h
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 12:15:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMEKr-00046l-U3
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMEKr-0002In-0T
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:13:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hMEKq-0002I6-RH
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:13:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1E9F37EBC1;
	Thu,  2 May 2019 16:13:24 +0000 (UTC)
Received: from thuth.com (ovpn-116-131.ams2.redhat.com [10.36.116.131])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DBB5B17D58;
	Thu,  2 May 2019 16:13:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Thu,  2 May 2019 18:13:02 +0200
Message-Id: <20190502161310.15624-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Thu, 02 May 2019 16:13:24 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/8] qtest and misc patches
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Otubo <otubo@redhat.com>, Helge Deller <deller@gmx.de>,
	Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502161302.0ZgSl9gg-aOXfqhDbvR5VxRt_LXYCLjhBoj9h0_T2Og@z>

 Hi Peter,

the following changes since commit 8482ff2eb3bb95020eb2f370a9b3ea26511e41=
df:

  Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request'=
 into staging (2019-05-02 12:04:51 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2019-05-02

for you to fetch changes up to aff39be0ed9753c9c323f64a14f5533dd5c43525:

  hw/pci-host: Use object_initialize_child for correct reference counting=
 (2019-05-02 16:56:33 +0200)

----------------------------------------------------------------
- Move qtest accel code to accel/qtest.c, get rid of AccelClass->availabl=
e
- Test TCG interpreter in gitlab-ci
- Small improvements to the configure script
- Use object_initialize_child in hw/pci-host
----------------------------------------------------------------

Eduardo Habkost (3):
      qtest: Move accel code to accel/qtest.c
      qtest: Don't compile qtest accel on non-POSIX systems
      accel: Remove unused AccelClass::available field

Helge Deller (1):
      configure: Relax check for libseccomp

Thomas Huth (4):
      gitlab-ci.yml: Test the TCG interpreter in a CI pipeline
      configure: Add -Wno-typedef-redefinition to CFLAGS (for Clang)
      configure: Remove old *-config-devices.mak.d files when running con=
figure
      hw/pci-host: Use object_initialize_child for correct reference coun=
ting

 .gitlab-ci.yml            | 15 +++++++++++++
 MAINTAINERS               |  1 +
 accel/Makefile.objs       |  1 +
 accel/accel.c             |  5 -----
 accel/qtest.c             | 54 +++++++++++++++++++++++++++++++++++++++++=
++++++
 configure                 | 33 +++++++----------------------
 hw/pci-host/designware.c  |  4 ++--
 hw/pci-host/gpex.c        |  5 +++--
 hw/pci-host/q35.c         |  4 ++--
 hw/pci-host/xilinx-pcie.c |  4 ++--
 include/sysemu/accel.h    |  1 -
 include/sysemu/qtest.h    |  9 --------
 qtest.c                   | 34 -----------------------------
 13 files changed, 88 insertions(+), 82 deletions(-)
 create mode 100644 accel/qtest.c


