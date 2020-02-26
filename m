Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB579C4BA1E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:49:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 986E020801
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="hhzCJWQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986E020801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j70oG-0005VX-Nr
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 12:49:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1j70nE-0004E4-54
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:48:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1j70nD-0003Tp-3g
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:48:20 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46432)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1j70nC-0003R9-I9
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:48:19 -0500
Received: by mail-wr1-x442.google.com with SMTP id j7so4138279wrp.13
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 09:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=DJryyKGum4fJqTbc9fFHhmRlMqpAyGeGJAAAPzeTxPk=;
 b=hhzCJWQ063KeUmxxFIZ7eJpBGDedUdX72khtLn3b+uHS9rdWp3PYSdxjS/AIE8y6hH
 lS/5PwPr7lvZ9IluEZfskbYTjc2xJFNpbVOcUB6RgQleVgHZUwsRTFn6INwJE9AKv/aO
 v4pfxjjUYp8NGVZJsinYyrIqIyu/qaOXlyxXzFW+WX4NHnZNPmKFcpgYccMYb8CNV1zZ
 VB6mqdtLpAMaPjCkLAmy1UjSnnhClHAj1ROkfLycozWIL5NWZ8rXWDvFA/SJ80H066uP
 K58XcKBgOt/qeaUn3SObcQTG91yswnKaKeyeEAW4LiZEl57sQQ+34L4HNEu2btZ5cDGE
 H4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=DJryyKGum4fJqTbc9fFHhmRlMqpAyGeGJAAAPzeTxPk=;
 b=ThOMOTO/scTROrmD0n6MYNciFYQYodsHR4/sqfzUddYvojurzWnakd2wTFxHL7tpos
 uVhJbjj2Gm1vyBN2Dfkgjil27apam59pI51SeBEonSE2IlzChQUdhQVG9JSpI6BfQuai
 aiUVxKywcUCcIBF/Sg+BzHziIM+W0nbmeOiWD+9nDbsqIl7l0L3faqe9dMRIq99/Ig4W
 ieZ1qJ2BbY3lGqR5dSiK0JVaAee+ZdjhJYBk2yPLKCI1RX2rscC7ceObKq/njwELoK9U
 PL549Vh7oYIeuMltHdYZ1ztgyFNbA7MTGxOoCzLIJ7hqQFR8Cg3O/ZO7x6I/r9R/ve1H
 vHPg==
X-Gm-Message-State: APjAAAVZhDFBHlyNnhI5C3AOkrj/k8zeFm0h5XMbwC7ssSDBcOBvgNPg
 oni4iXqEL7OLnEED8LQehc7AELZTWFc=
X-Google-Smtp-Source: APXvYqwP9F2AuFYCqwoD9/upj7bGSE+PBBsTthdzdEftHZYZi8mXJczSJpGYaY0AczIAId1MdWYwKA==
X-Received: by 2002:a5d:55c1:: with SMTP id i1mr7186831wrw.347.1582739296333; 
 Wed, 26 Feb 2020 09:48:16 -0800 (PST)
Received: from f2.redhat.com (bzq-79-177-42-131.red.bezeqint.net.
 [79.177.42.131])
 by smtp.gmail.com with ESMTPSA id b21sm3930520wmd.37.2020.02.26.09.48.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 26 Feb 2020 09:48:15 -0800 (PST)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 0/3] reference implementation of RSS
Date: Wed, 26 Feb 2020 19:48:06 +0200
Message-Id: <20200226174809.9675-1-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

Support for VIRTIO_NET_F_RSS feature in QEMU for reference
purpose. Implements Toeplitz hash calculation for incoming
packets according to configuration provided by driver.

This series requires previously submitted and accepted
patch to be applied:
https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg06448.html

Yuri Benditovich (3):
  virtio-net: introduce RSS RX steering feature
  virtio-net: implement RSS configuration command
  virtio-net: implement RX RSS processing

 hw/net/trace-events                         |   3 +
 hw/net/virtio-net.c                         | 234 +++++++++++++++++++-VIRTIO_NET_F_RSS
 include/hw/virtio/virtio-net.h              |  12 +
 include/standard-headers/linux/virtio_net.h |  37 +++-
 4 files changed, 273 insertions(+), 13 deletions(-)

-- 
2.17.1


