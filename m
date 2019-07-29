Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC712C76186
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 21:16:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 819842073F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 21:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819842073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsD0q-0006Jt-Qr
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 17:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56673)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hsD01-0005ZG-2u
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 17:16:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hsD00-0003T3-1n
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 17:16:05 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35836)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hsCzz-0003RA-TU
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 17:16:03 -0400
Received: by mail-qt1-f193.google.com with SMTP id d23so60974337qto.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 14:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=56Kq6/bdO7dXYH2sn1ZzlSC7sP2/lMfBCKvfK33VPho=;
 b=A5ri3Mz8Jj2NwbVcF+X7bnHSMB1oREGdzA1MnpZJrVD+2CqOkANinw+vNTzn84dZ0o
 3q16BuOFnHnTe99anmIPQqJFRXaYzxy1/Fp2X+7PksZNG6oNORPVAjUnVnhJ+0wvS4Lh
 2ht+ow38u8X450h6c5xtAhXzgEAz3sUz5LR+ufGbekmLlL5o2Krs28xPl4dUMAyxbF3x
 X2uRq3OAONKXZG3kjhPLAHLRaXWIXfhYiTRoejDPuDB+0GpEESdQx6XOPhX8MylidCsm
 7lQLedbs8C97NQKbUZ48hbODEVvZW2tyrn9F7d1yOm9J1U8DajiQYQfUVnloha6SxZ32
 arnQ==
X-Gm-Message-State: APjAAAVbuHvSmJ82Pgmwhmnbj3JYzuKKB+IwnGN96PRJs314V6wnOUnM
 CqQ8jkwxninzGESUPAQGPVvQ66p2qTQidg==
X-Google-Smtp-Source: APXvYqwJuRU5+9o59y/WtlhdhNuNoUSW1YLO9pgPf9saSYeFJ2CR9OfhGVK+Vf7Us3kCitjFr8wN0Q==
X-Received: by 2002:a0c:e588:: with SMTP id t8mr80511092qvm.179.1564434962910; 
 Mon, 29 Jul 2019 14:16:02 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 j8sm27068122qki.85.2019.07.29.14.16.00
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 29 Jul 2019 14:16:02 -0700 (PDT)
Date: Mon, 29 Jul 2019 17:15:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190729211404.1533-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.193
Subject: [Qemu-devel] [PULL 0/3] virtio, pc: fixes
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm sending this out now as these patches are ready,
but it seems likely we'll need another patch for pci,
and as it deals with migration compat it might be a blocker.
Will know more tomorrow :(


The following changes since commit fff3159900d2b95613a9cb75fc3703e67a674729:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190726' into staging (2019-07-26 16:23:07 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 22235bb609c18547cf6b215bad1f9d2ec56ad371:

  pc-dimm: fix crash when invalid slot number is used (2019-07-29 16:57:27 -0400)

----------------------------------------------------------------
virtio, pc: fixes

A couple of last minute bugfixes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Dr. David Alan Gilbert (2):
      Revert "Revert "globals: Allow global properties to be optional""
      Revert "hw: report invalid disable-legacy|modern usage for virtio-1-only devs"

Igor Mammedov (1):
      pc-dimm: fix crash when invalid slot number is used

 hw/virtio/virtio-pci.h        | 31 ++++++-------------------------
 include/hw/qdev-core.h        |  3 +++
 hw/core/machine.c             | 23 +++--------------------
 hw/display/virtio-gpu-pci.c   |  4 +---
 hw/display/virtio-vga.c       |  4 +---
 hw/mem/pc-dimm.c              |  7 +++++++
 hw/virtio/virtio-crypto-pci.c |  4 +---
 hw/virtio/virtio-input-pci.c  |  4 +---
 hw/virtio/virtio-pci.c        | 26 ++++++++++----------------
 qom/object.c                  |  3 +++
 10 files changed, 36 insertions(+), 73 deletions(-)


