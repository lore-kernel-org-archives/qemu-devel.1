Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D86C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 11:15:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 935DA20675
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 11:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bXyJCfCl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 935DA20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHmxR-0002Eb-Ny
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 07:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jHmwP-0000dO-Sm
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:14:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jHmwO-0001Qe-J2
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:14:21 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:48592)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jHmwO-0001Nq-Eh
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585307659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qu+omo93Xn9dxDL4iLUokienPqqiFjRyYQlMOgtQxIA=;
 b=bXyJCfClbS8KT0uczuLEmTmIWbnZZD2GxGEVhWxqj+Y5uKCkz3UxURLT8XdoBlKtwdxIIK
 akLfxA0E/V5csSydI2HVH6vp/37YdIRuk4TJo4R/DK5mx2IqOj/ik/IyrwXZul1sNNbPQb
 wv1nd0Krl2Mnjat/8B0zV9Z0TJ2D+fQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-G6UUGJbhN5KDxpOGYz06Kw-1; Fri, 27 Mar 2020 07:14:12 -0400
X-MC-Unique: G6UUGJbhN5KDxpOGYz06Kw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62BC41005512;
 Fri, 27 Mar 2020 11:14:11 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-77.pek2.redhat.com
 [10.72.12.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF9C45E01F;
 Fri, 27 Mar 2020 11:14:09 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 00/13] Net patches
Date: Fri, 27 Mar 2020 19:13:54 +0800
Message-Id: <1585307647-24456-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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

The following changes since commit cfe68ae025f704f336d7dd3d1903ce37b445831d=
:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.0-pul=
l-request' into staging (2020-03-26 20:55:54 +0000)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to f3b364f4f77fcb24cec468f518bf5e093dc27cb7:

  hw/net/allwinner-sun8i-emac.c: Fix REG_ADDR_HIGH/LOW reads (2020-03-27 18=
:59:47 +0800)

----------------------------------------------------------------

----------------------------------------------------------------
Andrew Melnychenko (1):
      Fixed integer overflow in e1000e

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

 hw/net/allwinner-sun8i-emac.c | 12 ++----
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
 30 files changed, 235 insertions(+), 111 deletions(-)



