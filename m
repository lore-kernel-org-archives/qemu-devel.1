Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82662C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:36:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A967208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="e1E8nYJN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A967208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC0bI-0005wn-Dc
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 08:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jC0aC-0004St-1Q
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:35:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jC0aA-0002l4-Fe
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:35:31 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:37226)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jC0aA-0002gh-3Z
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:35:30 -0400
Received: by mail-wm1-x32c.google.com with SMTP id a141so1934788wme.2
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 05:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=isDQvsAYmN6wVJF+nRBGYGE2YR+59MqTx0YxR793qE4=;
 b=e1E8nYJNaYdBdyQ7dYWFDPuDtdzErF2793T8pD00tYT/8PYixzMC9r1XgVOUUHq+o/
 S/vZJ3dKRMk/0jmFmbDPL1kLOrCZIqsg3oCNZMwXXc3ucaohMLltKY6puSgH7xFCqzoL
 r3R4cKn/eo8L019MaWhP/eWcbpq5kAmYbSJFsAqzLri7d3q+q2AKPnOPugoDBZYOcOL8
 TyRo5kBFywM1u9o8IVKX4yq6OXL3o3jW67e6kCwN9RiMCXhEkyCeJM4ERW2kHMyfyYUN
 MCVEAnMDUcpxQcGor+blN9Vlg50KODb0KLQn1EWek1+Z+fcb9MgW3X3yeVxF8RZyAnfr
 zVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=isDQvsAYmN6wVJF+nRBGYGE2YR+59MqTx0YxR793qE4=;
 b=XxJrhgGvXPvC6YdwvZh2QIhkJT1o9O71Yo8NQvtREcMElsfTBwRv4Me8/lR9sYi41x
 kM+Z1xH+WzoReeq5mMAZDajfLmmmLpShdpYXtZNr6gTlJz5wl6Rv91+OwHB//CGlU1LW
 XuxsHNfh0/9Eo5vRKs3tJ9ggyNVo3+4jyoD6uhHhrYGv9Wc4YqjW3nXL8L5FdfY1Qig5
 IBKazUUCY7NcqYwfSzk2i5Y86ZciqVcroeAcnvIP7kwnKNMMbtGMVqJnBujPEmDGMsS4
 AjlfkmUWnYGybG7mP3tZpY4JZc+t3oxVccrkv3gFQ2Oc3UvNeAgCqL5D9oM5ClZYV+YL
 5L1Q==
X-Gm-Message-State: ANhLgQ1+T93S5op6czhhrklMkPdp2HYZ5oymiDvkB+toQjy8QbneYBUp
 WvsimX3DoA2LSZLIMEfBEXQE4K+SVaLnuQ==
X-Google-Smtp-Source: ADFU+vtn41RjOCMGHgeZ+4szgCWXz7nc0VF7YspUsrWgepsv+c9Fxkw9BVXl0iBdbfK/PXfw9REv8g==
X-Received: by 2002:a1c:4e03:: with SMTP id g3mr3584431wmh.22.1583930128170;
 Wed, 11 Mar 2020 05:35:28 -0700 (PDT)
Received: from f2.redhat.com (bzq-79-183-43-120.red.bezeqint.net.
 [79.183.43.120])
 by smtp.gmail.com with ESMTPSA id o11sm61480696wrn.6.2020.03.11.05.35.25
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 11 Mar 2020 05:35:26 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v3 0/6]  reference implementation of RSS and hash report
Date: Wed, 11 Mar 2020 14:35:12 +0200
Message-Id: <20200311123518.4025-1-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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

Changes from v2:
Implemented migration support
Added implementation of hash report
Changed reporting of error during processing of command
(per review of v2)
Cosmetic changes per v2 review

Yuri Benditovich (6):
  virtio-net: introduce RSS and hash report features
  virtio-net: implement RSS configuration command
  virtio-net: implement RX RSS processing
  virtio-net: reference implementation of hash report
  virtio-net: add migration support for RSS and hast report
  tap: allow extended virtio header with hash info

 hw/net/trace-events            |   3 +
 hw/net/virtio-net.c            | 424 +++++++++++++++++++++++++++++++--
 include/hw/virtio/virtio-net.h |  19 ++
 net/tap.c                      |  11 +-
 4 files changed, 440 insertions(+), 17 deletions(-)

-- 
2.17.1


