Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB94C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:12:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 416A72133D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416A72133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35875 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTnWS-0001N7-Es
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:12:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTnH5-0003rP-U7
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:56:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTn4R-0000sd-Ms
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:43:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hTn4Q-0000rC-Hf; Thu, 23 May 2019 08:43:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C60A2307EA98;
	Thu, 23 May 2019 12:43:35 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CEF45D9C3;
	Thu, 23 May 2019 12:43:22 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 14:43:05 +0200
Message-Id: <20190523124320.28726-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Thu, 23 May 2019 12:43:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/15] Fw cfg 20190523 patches
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit c4600d5d417ea13e0f1cc047b227a2b5b0e694=
f5:

  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-=
request' into staging (2019-05-23 12:00:37 +0100)

are available in the Git repository at:

  https://gitlab.com/philmd/qemu.git tags/fw_cfg-20190523-pull-request

for you to fetch changes up to 3ae9dd1a304248e1f6ca631cdd43eb44a3e9e7b4:

  tests: fw_cfg: add 'splash-time' test case (2019-05-23 14:10:31 +0200)

----------------------------------------------------------------

fw_cfg patches for 2019-05-23

- Add trace events
- Get rid of globals in fw_cfg-test
- Explicit 'reboot-timeout' is little endian
- Add tests for 'reboot-timeout' and 'splash-time'

----------------------------------------------------------------

Li Qiang (5):
  tests: refactor fw_cfg_test
  tests: fw_cfg: add a function to get the fw_cfg file
  hw/nvram/fw_cfg: Store 'reboot-timeout' as little endian
  tests: fw_cfg: add 'reboot-timeout' test case
  tests: fw_cfg: add 'splash-time' test case

Philippe Mathieu-Daud=C3=A9 (10):
  hw/nvram/fw_cfg: Add trace events
  hw/nvram/fw_cfg: Add fw_cfg_arch_key_name()
  hw/i386: Extract fw_cfg definitions to local "fw_cfg.h"
  hw/i386: Implement fw_cfg_arch_key_name()
  hw/ppc: Implement fw_cfg_arch_key_name()
  hw/sparc: Implement fw_cfg_arch_key_name()
  hw/sparc64: Implement fw_cfg_arch_key_name()
  tests/libqos: Add io_fw_cfg_uninit() and mm_fw_cfg_uninit()
  tests/libqos: Add pc_fw_cfg_uninit() and use it
  tests/fw_cfg: Free QFWCFG object after qtest has run

 MAINTAINERS               |   1 +
 hw/i386/Makefile.objs     |   2 +-
 hw/i386/fw_cfg.c          |  38 ++++++++++++
 hw/i386/fw_cfg.h          |  20 ++++++
 hw/i386/pc.c              |   7 +--
 hw/nvram/fw_cfg.c         |  67 +++++++++++++++++++-
 hw/nvram/trace-events     |   7 ++-
 hw/ppc/Makefile.objs      |   2 +-
 hw/ppc/fw_cfg.c           |  45 ++++++++++++++
 hw/sparc/sun4m.c          |  19 ++++++
 hw/sparc64/sun4u.c        |  19 ++++++
 include/hw/nvram/fw_cfg.h |  14 +++++
 stubs/Makefile.objs       |   1 +
 stubs/fw_cfg.c            |  21 +++++++
 tests/fw_cfg-test.c       | 127 ++++++++++++++++++++++++++++++++++----
 tests/libqos/fw_cfg.c     |  55 +++++++++++++++++
 tests/libqos/fw_cfg.h     |   9 +++
 tests/libqos/malloc-pc.c  |   2 +-
 18 files changed, 433 insertions(+), 23 deletions(-)
 create mode 100644 hw/i386/fw_cfg.c
 create mode 100644 hw/i386/fw_cfg.h
 create mode 100644 hw/ppc/fw_cfg.c
 create mode 100644 stubs/fw_cfg.c

--=20
2.20.1


