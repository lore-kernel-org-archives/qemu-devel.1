Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3229C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:39:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73BED20721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqHL/L/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73BED20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyb0e-0005lv-L3
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 07:39:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iyazh-0004Aa-D0
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:38:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iyazf-0005ss-CZ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:38:24 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36931
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iyazf-0005sO-3v
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580733502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oH65uqXcaiNOfOxPQVnbm5s5rgUPvhzNSRSIeIA6sRo=;
 b=LqHL/L/v/rJcQw7WM195TWwpVtMH5DZiZonH/vTv+2qxZNMxaPRP5eaVlVhy1tCi4jUsHu
 zfN3fhhtbqXgnLvBgD5vl4ClVOBuoGwIGVyXb0KTRU+/GQJM20eFOOPWkbp0fCUyzKVxRd
 sy4qGcVXnjMBtJhcj6oI4OwDtkTWxGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-a3TeloO7N-GA1lGfVTAIcA-1; Mon, 03 Feb 2020 07:38:18 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69C77800D41;
 Mon,  3 Feb 2020 12:38:16 +0000 (UTC)
Received: from thuth.com (ovpn-116-129.ams2.redhat.com [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C284196B1;
 Mon,  3 Feb 2020 12:38:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/13] qtests, kconfig and misc patches
Date: Mon,  3 Feb 2020 13:37:58 +0100
Message-Id: <20200203123811.8651-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: a3TeloO7N-GA1lGfVTAIcA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Hi Peter,

the following changes since commit 28db64fce555a03b4ca256d5b6f4290abdfbd9e8=
:

  Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request'=
 into staging (2020-01-31 17:37:00 +0000)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2020-02-03

for you to fetch changes up to 585c138628bbf22ea8e740b2f4f1a3ed0274ebe8:

  trivial: Remove xenfb_enabled from sysemu.h (2020-02-03 10:33:57 +0100)

----------------------------------------------------------------
* Current qtests queue
* Some Kconfig updates
* Some trivial clean-ups here and there
----------------------------------------------------------------

Dr. David Alan Gilbert (1):
      tests/vhost-user-bridge: Fix build

Heyi Guo (1):
      tests/qtest: update comments about bios-tables-test-allowed-diff.h

Miroslav Rezanina (1):
      test-logging: Fix -Werror=3Dmaybe-uninitialized warning

Pan Nengyuan (1):
      boot-order-test: fix memleaks in boot-order-test

Philippe Mathieu-Daud=C3=A9 (1):
      hw/hppa/Kconfig: LASI chipset requires PARALLEL port

Thomas Huth (8):
      docs/devel: Fix qtest paths and info about check-block in testing.rst
      tests/Makefile: Fix inclusion of the qos dependency files
      gitlab-ci: Refresh the list of iotests
      hw/bt: Remove empty Kconfig file
      hw/input: Do not enable CONFIG_PCKBD by default
      hw/*/Makefile.objs: Move many .o files to common-objs
      include/sysemu/sysemu.h: Remove usused variable no_quit
      trivial: Remove xenfb_enabled from sysemu.h

 .gitlab-ci.yml                 | 12 ++++++------
 docs/devel/testing.rst         | 23 ++++++++++++-----------
 hw/adc/Makefile.objs           |  2 +-
 hw/block/Makefile.objs         |  2 +-
 hw/bt/Kconfig                  |  0
 hw/char/Makefile.objs          | 16 ++++++++--------
 hw/core/Makefile.objs          |  2 +-
 hw/display/Makefile.objs       |  2 +-
 hw/dma/Makefile.objs           |  6 +++---
 hw/gpio/Makefile.objs          | 10 +++++-----
 hw/hppa/Kconfig                |  1 +
 hw/i2c/Makefile.objs           |  4 ++--
 hw/i2c/ppc4xx_i2c.c            |  1 -
 hw/input/Kconfig               |  1 -
 hw/input/Makefile.objs         |  8 ++++----
 hw/isa/Kconfig                 |  1 +
 hw/net/Makefile.objs           |  6 +++---
 hw/nvram/Makefile.objs         |  2 +-
 hw/pcmcia/Makefile.objs        |  2 +-
 hw/sd/Makefile.objs            | 10 +++++-----
 hw/ssi/Makefile.objs           |  4 ++--
 hw/usb/Makefile.objs           |  4 ++--
 hw/xenpv/xen_machine_pv.c      |  2 +-
 include/sysemu/sysemu.h        |  2 --
 tests/Makefile.include         |  3 ++-
 tests/qtest/Makefile.include   |  1 -
 tests/qtest/bios-tables-test.c | 10 +++++-----
 tests/qtest/boot-order-test.c  |  6 +++---
 tests/qtest/libqos/fw_cfg.h    |  2 ++
 tests/test-logging.c           |  6 +++---
 30 files changed, 76 insertions(+), 75 deletions(-)
 delete mode 100644 hw/bt/Kconfig


