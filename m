Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CBCC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 08:43:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 826EF207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 08:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUmIAHG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826EF207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih8Rm-0002vZ-LS
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 03:43:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ih8RB-0002U8-QD
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 03:42:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ih8R8-0007oJ-8M
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 03:42:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50447
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ih8R8-0007mv-3W
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 03:42:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576572153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Dm9HhKVzTOuAXnV6JPJx2A8N3dmAelMfkSAoeZikMCY=;
 b=ZUmIAHG+nqHCK2D51vFlrb+ckfrgvK07WzPFDtghGr7OW0RdHDI3f/j5YLlw3qAQkrYGAN
 tzwIWzkUoAGH7O57v+s1TQH/Ra7zqTsjK9iExRcrtnQGiBqptnDl2oO35OPZ62bg8uTNul
 tJi/mY18UaTnPPW1GS+sn1cSUvxhbZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-xMPm4jebO46R3Fx9Kd7xhw-1; Tue, 17 Dec 2019 03:42:31 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B329E800D41;
 Tue, 17 Dec 2019 08:42:30 +0000 (UTC)
Received: from thuth.com (ovpn-116-149.ams2.redhat.com [10.36.116.149])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1589560BE2;
 Tue, 17 Dec 2019 08:42:26 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v2 00/10] Bluetooth removal, and qtest & misc patches
Date: Tue, 17 Dec 2019 09:42:22 +0100
Message-Id: <20191217084223.10231-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: xMPm4jebO46R3Fx9Kd7xhw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Hi!

The following changes since commit cb88904a54903ef6ba21a68a61d9cd51e2166304=
:

  Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-dec-16-20=
19' into staging (2019-12-16 14:07:56 +0000)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2019-12-17

for you to fetch changes up to 0f555602c7430ae55b5a4bacf39ce9e483e11193:

  tests: use g_test_rand_int (2019-12-17 09:05:23 +0100)

----------------------------------------------------------------
* Removal of the deprecated bluetooth code
* Some qtest and misc patches
----------------------------------------------------------------

v2: Unfortunately, I was not able to reproduce the build problem that
    Peter reported for the v1 pull request. So I'm trying to work-around
    the issue now by leaving an empty hw/bt/Kconfig file around this time.
    I'll remove it by another patch later in a couple of weeks instead.

Cole Robinson (1):
      tests: fix modules-test 'duplicate test case' error

Laurent Vivier (1):
      pseries: disable migration-test if /dev/kvm cannot be used

Marc-Andr=C3=A9 Lureau (1):
      glib: use portable g_setenv()

Markus Armbruster (1):
      hw/misc/ivshmem: Bury dead legacy INTx code

Paolo Bonzini (1):
      tests: use g_test_rand_int

Thomas Huth (4):
      hw/arm/nseries: Replace the bluetooth chardev with a "null" chardev
      hw/usb: Remove the USB bluetooth dongle device
      Remove the core bluetooth code
      Remove libbluetooth / bluez from the CI tests

Wainer dos Santos Moschetta (1):
      tests/Makefile: Fix check-report.* targets shown in check-help

 .gitlab-ci.yml                             |    2 +-
 Makefile.objs                              |    2 -
 bt-host.c                                  |  198 ---
 bt-vhci.c                                  |  167 --
 configure                                  |   31 -
 hw/Kconfig                                 |    1 -
 hw/Makefile.objs                           |    1 -
 hw/arm/nseries.c                           |   16 +-
 hw/bt/Kconfig                              |    2 -
 hw/bt/Makefile.objs                        |    3 -
 hw/bt/core.c                               |  143 --
 hw/bt/hci-csr.c                            |  512 -------
 hw/bt/hci.c                                | 2263 ------------------------=
----
 hw/bt/hid.c                                |  553 -------
 hw/bt/l2cap.c                              | 1367 -----------------
 hw/bt/sdp.c                                |  989 ------------
 hw/misc/ivshmem.c                          |   35 -
 hw/usb/Kconfig                             |    5 -
 hw/usb/Makefile.objs                       |    1 -
 hw/usb/dev-bluetooth.c                     |  581 -------
 include/hw/bt.h                            | 2177 ------------------------=
--
 include/sysemu/bt.h                        |   20 -
 include/sysemu/os-win32.h                  |    2 -
 os-win32.c                                 |   22 -
 qemu-deprecated.texi                       |    7 -
 qemu-doc.texi                              |   17 -
 qemu-options.hx                            |   79 -
 tests/Makefile.include                     |    4 +-
 tests/docker/dockerfiles/fedora.docker     |    1 -
 tests/docker/dockerfiles/ubuntu.docker     |    1 -
 tests/docker/dockerfiles/ubuntu1804.docker |    1 -
 tests/ivshmem-test.c                       |    2 +-
 tests/libqtest.c                           |    2 +-
 tests/migration-test.c                     |    3 +-
 tests/modules-test.c                       |    3 +-
 tests/test-bitmap.c                        |    8 +-
 tests/test-crypto-tlscredsx509.c           |    2 +-
 tests/test-crypto-tlssession.c             |    2 +-
 tests/test-io-channel-tls.c                |    2 +-
 tests/test-qga.c                           |    4 +-
 tests/test-vmstate.c                       |    2 +-
 ui/sdl2.c                                  |    2 +-
 vl.c                                       |  136 --
 43 files changed, 26 insertions(+), 9345 deletions(-)
 delete mode 100644 bt-host.c
 delete mode 100644 bt-vhci.c
 delete mode 100644 hw/bt/Makefile.objs
 delete mode 100644 hw/bt/core.c
 delete mode 100644 hw/bt/hci-csr.c
 delete mode 100644 hw/bt/hci.c
 delete mode 100644 hw/bt/hid.c
 delete mode 100644 hw/bt/l2cap.c
 delete mode 100644 hw/bt/sdp.c
 delete mode 100644 hw/usb/dev-bluetooth.c
 delete mode 100644 include/hw/bt.h
 delete mode 100644 include/sysemu/bt.h


