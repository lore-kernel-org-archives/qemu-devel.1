Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25496C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 08:54:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA2B2087E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 08:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9hgs8mM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA2B2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iytz0-00006O-2T
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 03:54:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36516)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iytyD-0007go-Dj
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:54:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iytyA-0002bI-Uf
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:54:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34777
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iytyA-0002Xv-QO
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:54:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580806445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zQfFSKDnE+LvHtNaJYgi2LsApFLvlO1t8oG342ajtr0=;
 b=S9hgs8mMSJEig/AkAgKdX7/m7PAVbDUXdeOI1eN9JyZdiHwPDNt6iz6exCfSTTBfwxmHWk
 4H1aewHM/QSmwkyZDnQ9D/H7wdUFIATJue1BKYQJU/kQ1DamS7kTSC07J6u/z6O/SQ2kGw
 XG80m0b9dizSaAyRdD7O8iaCIOf9tbc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-YMkD1u1gN7ycQes_qwW8Xg-1; Tue, 04 Feb 2020 03:54:04 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1653800D55;
 Tue,  4 Feb 2020 08:54:02 +0000 (UTC)
Received: from thuth.com (ovpn-116-39.ams2.redhat.com [10.36.116.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D1A8887B1C;
 Tue,  4 Feb 2020 08:54:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 00/14] qtests, kconfig and misc patches
Date: Tue,  4 Feb 2020 09:53:56 +0100
Message-Id: <20200204085358.17191-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: YMkD1u1gN7ycQes_qwW8Xg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Hi Peter,

the following changes since commit f31160c7d1b89cfb4dd4001a23575b42141cb0ec=
:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-docs-20200203' i=
nto staging (2020-02-03 11:14:24 +0000)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2020-02-04

for you to fetch changes up to 4f67366e3bbe6040998be038156486eed264ea58:

  configure: Fix typo of the have_afalg variable (2020-02-04 09:01:31 +0100=
)

----------------------------------------------------------------
* Current qtests queue
* Some Kconfig updates
* Some trivial clean-ups here and there
----------------------------------------------------------------

v2: Replaced the hw/bt/Kconfig removal patch with the fix for the
    minikconf inputs and a patch that touches "configure" to make
    sure that all builders regenerate their dependencies afterwards.

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

Thomas Huth (9):
      docs/devel: Fix qtest paths and info about check-block in testing.rst
      tests/Makefile: Fix inclusion of the qos dependency files
      gitlab-ci: Refresh the list of iotests
      include/sysemu/sysemu.h: Remove usused variable no_quit
      trivial: Remove xenfb_enabled from sysemu.h
      hw/*/Makefile.objs: Move many .o files to common-objs
      Makefile: Do not use wildcard hw/*/Kconfig as input for minikconf
      hw/input: Do not enable CONFIG_PCKBD by default
      configure: Fix typo of the have_afalg variable

 .gitlab-ci.yml                 | 12 ++++++------
 Makefile                       |  6 +++---
 configure                      |  2 +-
 docs/devel/testing.rst         | 23 ++++++++++++-----------
 hw/adc/Makefile.objs           |  2 +-
 hw/block/Makefile.objs         |  2 +-
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
 31 files changed, 80 insertions(+), 79 deletions(-)


