Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B967C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 13:25:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 662DF20772
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 13:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJICn5PJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662DF20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJGtB-00051D-FD
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 09:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jJGq6-0000DI-7L
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jJGq4-0005en-II
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:21:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39841
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jJGq4-0005eC-Ed
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585660915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LFcA+Na0wO9Ia4W+pPHQiZMfXmxEQRyTDwSkU5ySfY8=;
 b=IJICn5PJXbyZPuqpjuAuQBpEFEeWIoMf4J376BokMTew+4vZFL3xp8x/hKi/SqwYmIIj06
 lzOQ7QtarGyGnCb9R6fjvy/sPFic8xmBMek2gu0Gsm9npTnZwzxbIvrBOTJxHKMk94To6y
 2dGom7QU/wjxxm+36RxssvYx1I0oJTQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-0EZ4k7XMMj-Dc1elBcS-3g-1; Tue, 31 Mar 2020 09:21:51 -0400
X-MC-Unique: 0EZ4k7XMMj-Dc1elBcS-3g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60E04801FA1;
 Tue, 31 Mar 2020 13:21:50 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-118.pek2.redhat.com
 [10.72.12.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 017A21036D00;
 Tue, 31 Mar 2020 13:21:48 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL V2 00/14] Net patches
Date: Tue, 31 Mar 2020 21:21:25 +0800
Message-Id: <1585660899-11228-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 2a95551e8b1456aa53ce54fac573df18809340a6=
:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20200330' into st=
aging (2020-03-31 11:20:21 +0100)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 1153cf9f5b67fad41ca6f8571e9a26e2c7c70759:

  qtest: add tulip test case (2020-03-31 21:14:35 +0800)

----------------------------------------------------------------

Changes from V1:

- fix the compiling error
- include qtest for tulip OOB

----------------------------------------------------------------
Andrew Melnychenko (1):
      Fixed integer overflow in e1000e

Li Qiang (1):
      qtest: add tulip test case

Peter Maydell (2):
      hw/net/i82596.c: Avoid reading off end of buffer in i82596_receive()
      hw/net/allwinner-sun8i-emac.c: Fix REG_ADDR_HIGH/LOW reads

Philippe Mathieu-Daud=C3=A9 (7):
      hw/net/i82596: Correct command bitmask (CID 1419392)
      hw/net/e1000e_core: Let e1000e_can_receive() return a boolean
      hw/net/smc91c111: Let smc91c111_can_receive() return a boolean
      hw/net/rtl8139: Simplify if/else statement
      hw/net/rtl8139: Update coding style to make checkpatch.pl happy
      hw/net: Make NetCanReceive() return a boolean
      hw/net/can: Make CanBusClientInfo::can_receive() return a boolean

Prasad J Pandit (1):
      net: tulip: check frame size and r/w data length

Zhang Chen (2):
      net/colo-compare.c: Expose "compare_timeout" to users
      net/colo-compare.c: Expose "expired_scan_cycle" to users

 hw/net/allwinner-sun8i-emac.c | 14 +++----
 hw/net/allwinner_emac.c       |  2 +-
 hw/net/cadence_gem.c          |  8 ++--
 hw/net/can/can_sja1000.c      |  8 ++--
 hw/net/can/can_sja1000.h      |  2 +-
 hw/net/dp8393x.c              |  8 ++--
 hw/net/e1000.c                |  2 +-
 hw/net/e1000e.c               |  4 +-
 hw/net/e1000e_core.c          |  2 +-
 hw/net/e1000e_core.h          |  2 +-
 hw/net/ftgmac100.c            |  6 +--
 hw/net/i82596.c               | 66 ++++++++++++++++++++----------
 hw/net/i82596.h               |  2 +-
 hw/net/imx_fec.c              |  2 +-
 hw/net/opencores_eth.c        |  5 +--
 hw/net/rtl8139.c              | 22 +++++-----
 hw/net/smc91c111.c            | 10 ++---
 hw/net/spapr_llan.c           |  4 +-
 hw/net/sungem.c               |  6 +--
 hw/net/sunhme.c               |  4 +-
 hw/net/tulip.c                | 36 ++++++++++++----
 hw/net/virtio-net.c           | 10 ++---
 hw/net/xilinx_ethlite.c       |  2 +-
 include/net/can_emu.h         |  2 +-
 include/net/net.h             |  2 +-
 net/can/can_socketcan.c       |  4 +-
 net/colo-compare.c            | 95 +++++++++++++++++++++++++++++++++++++++=
+---
 net/filter-buffer.c           |  2 +-
 net/hub.c                     |  6 +--
 qemu-options.hx               | 10 +++--
 tests/qtest/Makefile.include  |  1 +
 tests/qtest/tulip-test.c      | 91 +++++++++++++++++++++++++++++++++++++++=
++
 32 files changed, 328 insertions(+), 112 deletions(-)
 create mode 100644 tests/qtest/tulip-test.c


