Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0269C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 22:07:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A8F20777
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 22:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hlfhq04k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A8F20777
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFPnu-0006lx-Ky
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 18:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=34142b0fd=alistair.francis@wdc.com>)
 id 1jFPn6-0005uF-6M
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 18:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=34142b0fd=alistair.francis@wdc.com>)
 id 1jFPn5-0005BT-42
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 18:06:55 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:56412)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=34142b0fd=alistair.francis@wdc.com>)
 id 1jFPn4-0005AG-DO
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 18:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1584742032; x=1616278032;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=IgWu9gLXS+DFBGNoiP5gMmYWqWGHVZzfRuriMrh3ZgQ=;
 b=hlfhq04ker2MmRQMqoTVrEXuavqm6HNe2DbgKRggnodw6rDbcfQguIMO
 gRwNkmMa6Z41B+spNOsr7fyeuknnaZIcZxjM2g5ti+Gawmg0ahCHp/sbN
 k90yBILJFwkZiysXwRUTKNE13JGPeUOO8H9IrhLicn//hhpemv+r1Sn2E
 x+/ApMb+534uyoVzOiT7MhCKZHyEeJuC6M0EEaRL0mFoDtNQsnMOllmLu
 4i0jJBfivKwerK9ShfAQPgo/Ipcc1chCXRffdLth/Fp+HNHx40UejmwsA
 c8Xs3bW1wITH0qrdsaSK2mDOx9aRukb0cWfFbXD9t4ae+UkKVQBqs6e+u A==;
IronPort-SDR: DVa6KECKrBFad7LlvAkbJ//3LITSnkQI41TQPN60oH+NpEYZpMkwLElSi/Xd6Q56202KhLgKl4
 r+8zUhQMGfTTdZFwwXCBbxM/TNPhFtXEj23nTvNDprquhuHHekZcmelchVaS4iE3VxXkiIpG7C
 J3IiElQZKxNRgI/oOPb5GdQmDb/9igOCqiG9o04WNruM6fxxJIcubOsCn95uxyAiXC3yPFk9zt
 MN3/fud7WBAaorrRiPvAvD81HNdHzUiC2ueKLNZZLAUTxdU9imju0iBT6737m47yutfZvat/WC
 pxo=
X-IronPort-AV: E=Sophos;i="5.72,286,1580745600"; d="scan'208";a="235266276"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2020 06:07:05 +0800
IronPort-SDR: LAtwAl2NrVLOQdWbIvPTXOl+oF7T0nWhbaZiWJGz1gUfaw9oBfwRt3W3h7fRgAks8qXfDZGT8g
 FLTW/zUCgosM8VvfSodSZUZQ7fpyBsOAJfHPD84327bpbM2wflaS4jHfi+p270wanqfExylXrI
 XZI9qerT9WXEMTUdkfvzbqdAtaZ11bcnOqQ98bqlziAkTO+PO+6Ahv7PIfEXSZ/ftO1relk2ep
 YTeHS040jx+UNU0eI2qYJ3ww7u8DUFVJSBAUwzJ5m1i1UtxUYHOc0YADY0SKIBWv2zHvO6uPW0
 gy6zIzFn188jgzL54iWNuuzG
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2020 14:58:12 -0700
IronPort-SDR: 8hjBZ1Xa/Jlap/lmwV93vsOGarmD7xohHY95P7vK77IyVULNFNoF/Pc5v+pGlA5PX5/fQHzbpM
 QuCClJ6ilRmHchQrTiPfSMRhHGm3Mqsx0EGqCVWG7lyt3wtOjVthNJhWDwkRmcm9IgLZkqWWln
 eAs1SXTdAlpbGgpg6pbLfcDz5RivIDVHrlRWrZs32lq2veVBRrKu++vcHQ+YWxNVEP495Q+zOn
 bpbqJ2ElRBo/QDGnMd9cciViwYD+fQw3a3VKtOgsnsQHFJj91P+WaPYFPhNt7FrLF84V4A6o/e
 mtQ=
WDCIronportException: Internal
Received: from 2kbcp12.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.54.155])
 by uls-op-cesaip01.wdc.com with ESMTP; 20 Mar 2020 15:06:50 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] DTC queue for 5.0
Date: Fri, 20 Mar 2020 14:59:15 -0700
Message-Id: <20200320215916.3054194-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.143.124
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
Cc: peter.maydell@linaro.org, Alistair Francis <alistair.francis@wdc.com>,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 3d0ac346032a1fa9afafcaedc979a99f670e077e:

  Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-request' into staging (2020-03-20 13:54:23 +0000)

are available in the Git repository at:

  git@github.com:alistair23/qemu.git tags/pull-dtc-next-20200320-1

for you to fetch changes up to 9f252c7c88eacbf21dadcfe117b0d08f2e88ceeb:

  device_tree: Add info message when dumping dtb to file (2020-03-20 14:55:44 -0700)

----------------------------------------------------------------
DTC patches for 5.0

----------------------------------------------------------------
Leonardo Bras (1):
      device_tree: Add info message when dumping dtb to file

 device_tree.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

