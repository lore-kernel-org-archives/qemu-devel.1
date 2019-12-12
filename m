Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E3EC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:57:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3BAF2073B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K2MmqQ88"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3BAF2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifTe1-000437-6n
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:57:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ifTbk-0002J0-H3
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:54:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ifTbg-00087k-Ee
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:54:37 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51077
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ifTbg-00084y-6b
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:54:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576176874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ywhF0mDJPToGztXR81jzoR/v7+5m/XLXDLdXmTzQTHY=;
 b=K2MmqQ88dfQrOcM2Z7caeojbjAUCZBXgqnfyqtSWTD5xseDAEQiSg2Vp/s3zaF7OtKZVzV
 /NrYy2x6Lr3jnT2IELEwT1U+QxwDyI2ZV317wdNnMQsOAv4Uj54dr67rgBG9fKUcfV6CX8
 BUN7n7kg2guApMgUBDYiRkfStk9sdIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-cuQHZp6QMMmA8cvByg_r8A-1; Thu, 12 Dec 2019 13:54:32 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58C68800D4C;
 Thu, 12 Dec 2019 18:54:31 +0000 (UTC)
Received: from thuth.com (ovpn-116-168.ams2.redhat.com [10.36.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B8E4C19C4F;
 Thu, 12 Dec 2019 18:54:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/10] Bluetooth removal, and qtest & misc patches
Date: Thu, 12 Dec 2019 19:54:14 +0100
Message-Id: <20191212185424.4675-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: cuQHZp6QMMmA8cvByg_r8A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

 Hi,

the following changes since commit 52901abf94477b400cf88c1f70bb305e690ba2de=
:

  Update version for v4.2.0-rc5 release (2019-12-10 17:15:21 +0000)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2019-12-12

for you to fetch changes up to e38f04c4db40a9219cc0c516a6c68b9ca0a783d0:

  tests: use g_test_rand_int (2019-12-12 08:16:24 +0100)

----------------------------------------------------------------
- Removal of the deprecated bluetooth code
- Some qtest and misc patches
----------------------------------------------------------------

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
 delete mode 100644 hw/bt/Kconfig
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


