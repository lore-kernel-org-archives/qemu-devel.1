Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6D9C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 10:55:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 536022133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 10:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 536022133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFFoB-000794-UD
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 06:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iFFkI-0003X5-HY
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 06:51:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iFFkG-0007M6-N5
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 06:51:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31164)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iFFkG-0007Gr-FR
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 06:51:04 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 214CD81F25;
 Tue,  1 Oct 2019 10:51:02 +0000 (UTC)
Received: from thuth.com (ovpn-116-70.ams2.redhat.com [10.36.116.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3FBB146;
 Tue,  1 Oct 2019 10:51:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/5] qtest and misc patches
Date: Tue,  1 Oct 2019 12:50:52 +0200
Message-Id: <20191001105057.3949-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 01 Oct 2019 10:51:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Hi Peter!

The following changes since commit 95e9d74fe4281f7ad79a5a7511400541729aa4=
4a:

  Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-20190930' =
into staging (2019-09-30 14:21:56 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2019-10-01

for you to fetch changes up to 3d5e90a50bd4ffa199166e01a365f5c5995534ae:

  Disallow colons in the parameter of "-accel" (2019-10-01 11:54:17 +0200=
)

----------------------------------------------------------------
- Fix and re-enable the usb-hcd-ehci-test
- Silence a Coverity warning in hw/m68k/next-cube.c
- Fix crash that can occur when using bad binaries with "-kernel"
- Disallow colons in the "-accel" parameter
----------------------------------------------------------------

Marc-Andr=C3=A9 Lureau (2):
      tests: fix usb-hcd-ehci-test compilation
      tests: fix echi/ehci typo

Thomas Huth (3):
      hw/m68k/next-cube: Avoid static RTC variables and introduce control=
 register
      hw/core/loader: Fix possible crash in rom_copy()
      Disallow colons in the parameter of "-accel"

 hw/core/loader.c          |  2 +-
 hw/m68k/next-cube.c       | 73 ++++++++++++++++++++++++++---------------=
------
 tests/Makefile.include    |  4 +--
 tests/cdrom-test.c        |  2 +-
 tests/usb-hcd-ehci-test.c |  4 +--
 vl.c                      |  5 ++++
 6 files changed, 50 insertions(+), 40 deletions(-)

