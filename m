Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAB4CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:07:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD7AA20862
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1SXTxE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7AA20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPaZw-0005Wl-G2
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 19:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42710)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iPaTF-0007vN-Kt
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:00:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iPaTA-00030O-9j
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:00:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21903
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iPaT7-0002uM-MY
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572390003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gY9I1epMo4kk1tMj2jDo4Mey/k+u1Lfe2h++HKnqCzI=;
 b=d1SXTxE3CX/eqWzs/xJfNCINPnzqDsUW8BgS3mYVfKuArF1KxU1oiA1nuSIoO9J2NG9GTT
 zRc55zQBeWAYZ7huG17IZtyQ5zLJSmvQm2A36JLYA18FyLjnLNULICCywIvSdN8dGYS0TD
 MyOhU/W6fhN/Zd4p27Ms8WqrA/ve/OU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-6Hx4YrDnMXGTD7lJdk9Tmg-1; Tue, 29 Oct 2019 19:00:01 -0400
Received: by mail-qt1-f198.google.com with SMTP id l5so519339qtj.8
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 16:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=sF4aBi2azp2aQT4mPLlMSrWH9hotqWxhTMSDn1DPy9M=;
 b=XQNsXeAL1nnvhIHteR1ZtdZtCtCPwLwtCZTB43m5SaxplXnQECEFIvftOxOxWpUrW7
 +/JmnNMMgK4lJOwF/hKzl2HCns+ebtFr5EfLeK2mhUKlcAbea8J+etgAxVFqxeTOPD7Z
 GMuwrqr6T4sepu7xVDMGzphnhgAb2KdMLT4r6rjoAMIpw1+cbJH7stc3BeipQ4wRhaBO
 jacJjQCIA2mv5djlEBSb5nK6wN5UuoMr3BJY+nQR7I5ykmN1VMaOBI8uqInRMetbEhUO
 wV8G2T50pjiYGwFQ8sxTTXGJAeLo9sVfK+I1JboNnBuPQdwqgiTCb1WP/10Jzw4fZOIq
 rYXw==
X-Gm-Message-State: APjAAAW9rsaBOpzAcPs+Ic+Vx+ygg0SZd7RsoJP42Xh2UpYnZo6h+9xw
 ZBmFAzbXmzYJ5rY/QqSxtQr4P+aAkZPVTyShE9tNqc8tqwNK5xziBXev61eMGyEtgmTQa1vAv+N
 rdu5WQjAYa6V1ssk=
X-Received: by 2002:a0c:fde8:: with SMTP id m8mr26375821qvu.4.1572390000743;
 Tue, 29 Oct 2019 16:00:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwR1FmT02cV64HHUWjjU7wm2kQ1nHotFXfW5Vz/nlP9QpFRRzJLuDV4yJEcTLfzrR5nh7GmAg==
X-Received: by 2002:a0c:fde8:: with SMTP id m8mr26375796qvu.4.1572390000313;
 Tue, 29 Oct 2019 16:00:00 -0700 (PDT)
Received: from redhat.com (94.222.26.109.rev.sfr.net. [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id u7sm251332qkm.127.2019.10.29.15.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2019 15:59:59 -0700 (PDT)
Date: Tue, 29 Oct 2019 18:59:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/14] virtio: features, cleanups
Message-ID: <20191029225932.14585-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-MC-Unique: 6Hx4YrDnMXGTD7lJdk9Tmg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 16884391c750d0c5e863f55ad7aaaa146fc5181e=
:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2019-10-29' i=
nto staging (2019-10-29 20:06:08 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to b5f53d04a5a567ac70d33ec95628d35583eba600:

  virtio: Use auto rcu_read macros (2019-10-29 18:56:45 -0400)

----------------------------------------------------------------
virtio: features, cleanups

virtio net failover
rcu cleanup

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Dr. David Alan Gilbert (3):
      virtio/vhost: Use auto_rcu_read macros
      virtio_net: use RCU_READ_LOCK_GUARD
      virtio: Use auto rcu_read macros

Jens Freimann (11):
      qdev/qbus: add hidden device support
      pci: add option for net failover
      pci: mark devices partially unplugged
      pci: mark device having guest unplug request pending
      qapi: add unplug primary event
      qapi: add failover negotiated event
      migration: allow unplug during migration for failover devices
      migration: add new migration state wait-unplug
      libqos: tolerate wait-unplug migration state
      net/virtio: add failover support
      vfio: unplug failover primary device before migration

 qapi/migration.json            |  24 +++-
 qapi/net.json                  |  19 +++
 hw/vfio/pci.h                  |   1 +
 include/hw/pci/pci.h           |   4 +
 include/hw/qdev-core.h         |  30 ++++
 include/hw/virtio/virtio-net.h |  12 ++
 include/hw/virtio/virtio.h     |   1 +
 include/migration/vmstate.h    |   2 +
 migration/migration.h          |   3 +
 migration/savevm.h             |   2 +
 hw/core/qdev.c                 |  25 ++++
 hw/net/virtio-net.c            | 309 +++++++++++++++++++++++++++++++++++++=
+++-
 hw/pci/pci.c                   |  32 +++++
 hw/pci/pcie.c                  |   6 +
 hw/vfio/pci.c                  |  26 +++-
 hw/virtio/vhost.c              |   4 +-
 hw/virtio/virtio.c             |  65 +++------
 migration/migration.c          |  21 +++
 migration/savevm.c             |  31 +++++
 qdev-monitor.c                 |  43 +++++-
 tests/libqos/libqos.c          |   3 +-
 vl.c                           |   6 +-
 MAINTAINERS                    |   1 +
 docs/virtio-net-failover.rst   |  68 +++++++++
 24 files changed, 673 insertions(+), 65 deletions(-)
 create mode 100644 docs/virtio-net-failover.rst


