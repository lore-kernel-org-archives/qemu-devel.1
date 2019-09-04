Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B450CC3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 12:07:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B23A2339E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 12:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B23A2339E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5U4O-0002zu-KI
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 08:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1i5TyS-0006Aa-RW
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 08:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1i5TyQ-0002Qd-Cs
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 08:01:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39166)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1i5TyP-00026a-W0
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 08:01:18 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0C56689ACA
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 12:00:50 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id b143so22790885qkg.9
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 05:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=QbH+SiWofwKrzqAIlJFnrSFE2cKXcuOyn4vUrnhdR9Q=;
 b=awcYgFDXK4bIJZv5l14ukzZNJaIoh2LoedRwyYUTq+h1UQy1DnAAgEoJyL/3A/vNbT
 ZTJyoI8OBur08+OblhKphk4HzcdrQQW9UIF655w8cEgeFSTfQEqqx8sqb0NWZtRPBTIK
 3/em1Y9JwxH0NF9E+OLmgNp+YhL4F/3JP8ksjcskrlaWZuitN7HoDQAY90p2o0qKoREt
 F4tM9YQef4bypjKlBwPpIiNgLgWCv1wO1vKJvJM98VlioRwmqpqCiIo9lMFl0JoSwHii
 +h8QWJz6DmZpotGH1GBcmSsqmRnETfyayKIrEZYotvSm9dGz9awsb3KpkqerU7QzHM/H
 N2+w==
X-Gm-Message-State: APjAAAUVIQhUQyW/HrdWoc5KmFNM0G6/LTGOoH/LtbOhZnl+v/vcRFak
 tYL7UP8QcUkaFBPNwBG1BTjoChDbB86wfXz6/SFTmZcfFtq1+tmULZn7n0qzp6Bcmg+7WOmHm4J
 YqXPlXoas48TN4UM=
X-Received: by 2002:a37:714:: with SMTP id 20mr38787129qkh.32.1567598448825;
 Wed, 04 Sep 2019 05:00:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwX7MmTAs/H8oRGs8k/mncUrfgCnHW5MsT8/2cZPfBW/62fEKduUpzz4FOG44BcK73T5cPpDQ==
X-Received: by 2002:a37:714:: with SMTP id 20mr38787114qkh.32.1567598448667;
 Wed, 04 Sep 2019 05:00:48 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id q5sm8970766qte.38.2019.09.04.05.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 05:00:47 -0700 (PDT)
Date: Wed, 4 Sep 2019 08:00:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190904120026.3220-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/6] virtio,vhost: fixes, features, cleanups.
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

The following changes since commit 379d83f2c92879f4418aa9c57fd1fcbc3c82d384:

  Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-aug-29-2019' into staging (2019-09-04 10:16:00 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to eeb39263aa9b05b4ac3f8d8e957958071834a7b6:

  libvhost-user: introduce and use vu_has_protocol_feature() (2019-09-04 07:53:12 -0400)

----------------------------------------------------------------
virtio,vhost: fixes, features, cleanups.

FLR support.
Misc fixes, cleanups.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Johannes Berg (2):
      libvhost-user: fix SLAVE_SEND_FD handling
      libvhost-user: introduce and use vu_has_protocol_feature()

Julia Suvorova (1):
      virtio-pci: Add Function Level Reset support

Laurent Vivier (2):
      rng-builtin: add an RNG backend that uses qemu_guest_getrandom()
      virtio-rng: change default backend to rng-builtin

Markus Armbruster (1):
      virtio-rng: Keep the default backend out of VirtIORNGConf

 hw/virtio/virtio-pci.h                |  4 ++
 include/hw/virtio/virtio-rng.h        |  2 -
 include/sysemu/rng.h                  |  2 +
 backends/rng-builtin.c                | 77 +++++++++++++++++++++++++++++++++++
 contrib/libvhost-user/libvhost-user.c | 19 +++++----
 hw/core/machine.c                     |  4 +-
 hw/virtio/virtio-pci.c                | 10 +++++
 hw/virtio/virtio-rng.c                | 19 ++++-----
 backends/Makefile.objs                |  2 +-
 qemu-options.hx                       |  7 ++++
 10 files changed, 122 insertions(+), 24 deletions(-)
 create mode 100644 backends/rng-builtin.c


