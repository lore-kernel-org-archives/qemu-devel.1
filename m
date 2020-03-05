Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8D9C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:58:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BACE52072D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AlX+yJ5w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BACE52072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9ulF-0000Us-JL
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 12:58:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9uk0-00075j-9D
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:57:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9ujy-0002dV-Np
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:56:59 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32744
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9ujy-0002cw-Ko
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:56:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583431017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LVNdqsgidxTOl/zf7lJCTVEB/6AAxpggw+CjoQVwh+A=;
 b=AlX+yJ5wJPi4rQ62i1w9mSCgz/0F6Lt3P5tM+aA9iRmLty7Luagt9BY02tMwTZEgqQJB95
 HVFvEEsLgYz04iDneoF4qggc8ufXofNlXKuVYQOrCMCSP1xWJAAp+Vw03JZbTFhb4wXwwe
 6wVxAlp/5HHgWCeGVROhHARf/gVOkJ8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-AnrEFfCxPFyMpqaqBC6rxA-1; Thu, 05 Mar 2020 12:56:54 -0500
X-MC-Unique: AnrEFfCxPFyMpqaqBC6rxA-1
Received: by mail-wm1-f70.google.com with SMTP id c5so2373161wmd.8
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 09:56:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rXrFsYCbNITMAKKDyeFnLcrzD4LbTWQbaw3IfuF40i0=;
 b=JRGFpYjEPzOGYc8Uw4Tw38FWMk4vXL27fwMATEYhLc7mtYFQPip3YQpfAW/whPo2/q
 GMOpTdW+PYJJ1/Z4v5ngmBPD0h+GPtLGbf5nNRzl6h6Tsv6y5/JRgGnEg7n8vPuEbFQw
 z5pWCaPM3WfhO1qbWcAe9UwvR+SU4utNH0BVb67vOe1rPRru68noNi7ymtB7HW3kBDHK
 OVNpcT+VoDOj28coh6wVppCGySnFmQlkaUSZyY4tOki3J3Ov9kAGzNv5OzKo72LRwegs
 Mszqa62pr4It5mjBPquymMiFTzQ8Ckb7JuqfMiKyvdNO1kc/JFw/3huMm78pu9Af2StO
 SwEg==
X-Gm-Message-State: ANhLgQ2JyR5Zx4rN3kaK8ZLDpXBOUZLfkuBGRA5Zqr9SG/L+wCyJ5+VQ
 YpyO0RG7qcoZgZs8u4Y9tflEMqRsJmE+CVpcqXGnYXLTx7aFquBBafQtcQXVy0AonqI+yibVmbR
 fC47R1XHiyM5MulA=
X-Received: by 2002:a5d:4389:: with SMTP id i9mr144697wrq.90.1583431013360;
 Thu, 05 Mar 2020 09:56:53 -0800 (PST)
X-Google-Smtp-Source: ADFU+vt06duxsLwo2jqPu8jYkYTApkgH0gZ9gFiO4tBdqbt55DylznDtVWxEPf5n5A0t+srolVEC0A==
X-Received: by 2002:a5d:4389:: with SMTP id i9mr144664wrq.90.1583431013103;
 Thu, 05 Mar 2020 09:56:53 -0800 (PST)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id q1sm3608381wrx.19.2020.03.05.09.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 09:56:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/6] hw/net: Make Net/CanBus can_receive() handlers return a
 boolean
Date: Thu,  5 Mar 2020 18:56:44 +0100
Message-Id: <20200305175651.4563-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
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
Cc: qemu-ppc@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Joel Stanley <joel@jms.id.au>, Beniamino Galvani <b.galvani@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Net/CanBus can_receive() handlers return whether
the network device can or can not receive new data.
Make it obvious by returning a boolean type

Philippe Mathieu-Daud=C3=A9 (6):
  hw/net/e1000e_core: Let e1000e_can_receive() return a boolean
  hw/net/smc91c111: Let smc91c111_can_receive() return a boolean
  hw/net/rtl8139: Simplify if/else statement
  hw/net/rtl8139: Update coding style to make checkpatch.pl happy
  hw/net: Make NetCanReceive() return a boolean
  hw/net/can: Make CanBusClientInfo::can_receive() return a boolean

 hw/net/can/can_sja1000.h |  2 +-
 hw/net/e1000e_core.h     |  2 +-
 hw/net/i82596.h          |  2 +-
 include/net/can_emu.h    |  2 +-
 include/net/net.h        |  2 +-
 hw/net/allwinner_emac.c  |  2 +-
 hw/net/cadence_gem.c     |  8 ++++----
 hw/net/can/can_sja1000.c |  8 ++++----
 hw/net/dp8393x.c         |  8 +++-----
 hw/net/e1000.c           |  2 +-
 hw/net/e1000e.c          |  2 +-
 hw/net/e1000e_core.c     |  2 +-
 hw/net/ftgmac100.c       |  6 +++---
 hw/net/i82596.c          | 10 +++++-----
 hw/net/imx_fec.c         |  2 +-
 hw/net/opencores_eth.c   |  5 ++---
 hw/net/rtl8139.c         | 22 ++++++++++++----------
 hw/net/smc91c111.c       | 10 +++++-----
 hw/net/spapr_llan.c      |  4 ++--
 hw/net/sungem.c          |  6 +++---
 hw/net/sunhme.c          |  4 ++--
 hw/net/virtio-net.c      | 10 +++++-----
 hw/net/xilinx_ethlite.c  |  2 +-
 net/can/can_socketcan.c  |  4 ++--
 net/filter-buffer.c      |  2 +-
 net/hub.c                |  6 +++---
 26 files changed, 67 insertions(+), 68 deletions(-)

--=20
2.21.1


