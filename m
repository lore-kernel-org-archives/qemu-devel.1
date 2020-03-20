Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3D8C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 11:59:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8C4120732
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 11:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="EekNPaM0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C4120732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFGIn-0000hs-VJ
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 07:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jFGHp-0007h0-J9
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jFGHo-0000El-HC
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:58:01 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:44655)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jFGHo-0000DD-34
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:58:00 -0400
Received: by mail-wr1-x42d.google.com with SMTP id o12so6548652wrh.11
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 04:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=nDVUfE5qp5/dOvSz6UOOSa8GHDGJmO0y7HWrNxsmL/E=;
 b=EekNPaM0uDdUVsxqz7CxycxGrqLYQXN9DG3OVoCfy1/voMW7Z1E2eFywav05enHw+G
 5ZBWSGtQlH8A+rhU067hL6GlcO3M+YP6cpvrSgqG4DaL/2pz/y04l2SsyEPnn+8jf9Rs
 C7ncBMIA/fZphBpGk72QyOfVk4dOx1lFOyO3bpilL3gtxwnwFv+kbrdPcdCNs5AA0ljA
 8npSrkGlQWLmECJFu5fNh0AQHo3S13ipkyUAubj8hrXjq08V5lv3iLX2sHxInt0D1cEj
 gHVxogZBJMf1zQxB7vjgKzgfKSizjYuS0DdEftriWnBodNb1+R8u3yugTWzp8fVInAUU
 fKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=nDVUfE5qp5/dOvSz6UOOSa8GHDGJmO0y7HWrNxsmL/E=;
 b=pEBqT3ARsynwkbOUFeN3wH9+RCJo6d57WLx4f0rX8H2lqD7Z3gdirFj+l7GCe0z5MU
 R3MiJfi/xuQpHUJ1STs5pe6nB8jWsXa31QGp/psyelo9EsaTF5fYE1K5HNLGy4TefitY
 qfNnqXfbK7UdU0mg/vCbn61lc/I8g6i2IDwthmic6Jh/lBbSgqpwkSlzwYElnYAkUtvO
 X3fpM1QJEQ5BKdZWF/BSQJdazYvFsO81sKnTrD0QUpkfXCE55kDS93DCQ6RUCf49bkB+
 zs+aNSIMAv07C32LGti93JpbNwvUv2LF9T6b5a5ldrjulcU+35SP9w4xpBr9VAT8hicI
 CKLw==
X-Gm-Message-State: ANhLgQ3tEOFgPb45/L4jeGlx6l9HZr/3Ka8TWd2MHk11wpl9cXimDu2i
 adj8Q0L6SeUO39ry2uFUR1B+r0u6PlJtbw==
X-Google-Smtp-Source: ADFU+vuWXrHBFgZXu6OJVWGxCTo/6ARb7eC6PxiT5M5jE9ltcB4m3N9c6nM1fY9Nx2Ve4LEarFDbIw==
X-Received: by 2002:a5d:5545:: with SMTP id g5mr10325535wrw.290.1584705478558; 
 Fri, 20 Mar 2020 04:57:58 -0700 (PDT)
Received: from f2.redhat.com (bzq-79-179-79-224.red.bezeqint.net.
 [79.179.79.224])
 by smtp.gmail.com with ESMTPSA id c18sm6637645wrx.5.2020.03.20.04.57.56
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 20 Mar 2020 04:57:57 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 quintela@redhat.com, dgilbert@redhat.com
Subject: [PATCH v6 0/7] reference implementation of RSS and hash report
Date: Fri, 20 Mar 2020 13:57:44 +0200
Message-Id: <20200320115751.19446-1-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Cc: yan@daynix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Support for VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT
features in QEMU for reference purpose.
Implements Toeplitz hash calculation for incoming
packets according to configuration provided by driver.
Uses calculated hash for decision on receive virtqueue
and/or reports the hash in the virtio header

Changes from v5:
RSS migration state moved to subsection and migrated
only if enabled (patch 7)
Updated sign off (patch 6)

Yuri Benditovich (7):
  virtio-net: introduce RSS and hash report features
  virtio-net: implement RSS configuration command
  virtio-net: implement RX RSS processing
  tap: allow extended virtio header with hash info
  virtio-net: reference implementation of hash report
  vmstate.h: provide VMSTATE_VARRAY_UINT16_ALLOC macro
  virtio-net: add migration support for RSS and hash report

 hw/net/trace-events            |   3 +
 hw/net/virtio-net.c            | 448 +++++++++++++++++++++++++++++++--
 include/hw/virtio/virtio-net.h |  16 ++
 include/migration/vmstate.h    |  10 +
 net/tap.c                      |  11 +-
 5 files changed, 460 insertions(+), 28 deletions(-)

-- 
2.17.1


