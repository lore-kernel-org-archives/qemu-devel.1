Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90ADFC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 22:35:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59D0E20733
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 22:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KYalicSp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D0E20733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVkBl-0005WT-6Q
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 17:35:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1iVk9a-0003hA-OO
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 17:33:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1iVk9Y-0000gX-AY
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 17:33:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29494
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1iVk9Y-0000fM-70
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 17:33:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573857199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=64WVrzDZ62NONk0zWq6JXWWrJ/svFtlrpVXVGoXMmbI=;
 b=KYalicSpMP0XS3Yyx0uO2VvtyQwiQ1kgdbpMteEzlGfk75zBxFP2jvdJO9eULF5wznTf3o
 IDxLiZotDeS+y9bnb+3MNHL6FZft0QDZVDf6vFSmjBOTa8YkSF5vENOfXn/I72L5UaGfbN
 3MYHkZ5kM4LakiW24kssuu5GbmK+Sx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-vGrkxYYcOKavcavckoJw7A-1; Fri, 15 Nov 2019 17:33:16 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32AFD477;
 Fri, 15 Nov 2019 22:33:15 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-116-194.ams2.redhat.com
 [10.36.116.194])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A4D766835;
 Fri, 15 Nov 2019 22:33:12 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] ppc-for-4.2 queue 2019-11-15
Date: Fri, 15 Nov 2019 23:33:06 +0100
Message-Id: <20191115223312.204979-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: vGrkxYYcOKavcavckoJw7A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 36609b4fa36f0ac934874371874416f7533a5408=
:

  Merge remote-tracking branch 'remotes/palmer/tags/palmer-for-master-4.2-s=
f1' into staging (2019-11-02 17:59:03 +0000)

are available in the Git repository at:

  https://github.com/vivier/qemu.git tags/ppc-for-4.2-pull-request

for you to fetch changes up to 140fce75367a2bd8ef50681896a15f34952d9b85:

  mos6522: fix T1 and T2 timers (2019-11-03 20:09:59 +0100)

----------------------------------------------------------------
ppc patch queue 2019-11-15

Several fixes for 4.2.0-rc2:

fix mos6522 performance issue,
xive/xics issues,
fix /chosen device-tree on reset
and KVM default cpu-model for all machine classes

----------------------------------------------------------------

Alexey Kardashevskiy (1):
  spapr: Add /chosen to FDT only at reset time to preserve kernel and
    initramdisk

David Gibson (1):
  spapr/kvm: Set default cpu model for all machine classes

Greg Kurz (3):
  ppc: Add intc_destroy() handlers to SpaprInterruptController/PnvChip
  xive, xics: Fix reference counting on CPU objects
  ppc: Skip partially initialized vCPUs in 'info pic'

Laurent Vivier (1):
  mos6522: fix T1 and T2 timers

 hw/intc/spapr_xive.c       | 10 ++++++
 hw/intc/xics.c             | 22 ++++++++++++-
 hw/intc/xics_spapr.c       | 10 ++++++
 hw/intc/xive.c             | 20 +++++++++++-
 hw/misc/mos6522.c          | 67 +++++++++++++++++++++++++++++---------
 hw/ppc/pnv.c               | 21 ++++++++++++
 hw/ppc/pnv_core.c          |  7 ++--
 hw/ppc/spapr.c             | 25 ++++++++------
 hw/ppc/spapr_cpu_core.c    |  7 +---
 hw/ppc/spapr_irq.c         | 14 ++++++++
 include/hw/ppc/pnv.h       |  1 +
 include/hw/ppc/spapr_irq.h |  2 ++
 include/hw/ppc/xics.h      |  1 +
 include/hw/ppc/xive.h      |  1 +
 target/ppc/kvm.c           | 21 +++++++-----
 15 files changed, 185 insertions(+), 44 deletions(-)

--=20
2.23.0


