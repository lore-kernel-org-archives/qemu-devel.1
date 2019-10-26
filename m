Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C657FCA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 19:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90A6E206DD
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 19:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H61C+5B+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A6E206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iORw7-00031K-F9
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 15:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iORu9-0000Fr-JW
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:39:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iORu6-00006e-R7
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:39:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26391
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iORu6-00006U-Ks
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572118754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7zBJcQYcm4R1xBnCaPtvBJ9RdLY5gddiv+Gw4vdQZY0=;
 b=H61C+5B+wypM5RMcKAbHgaHJclMQV3NbRUytXhVHnPID2mKItIvimLsXXPHw0rLtfhCZjd
 Irl7bEfGZR/G4Zjxl0oH5D8b3OfwaaZgG/b8yHzX2K2xxyuVsN2IqjWTImHxkoxBTG3/Cr
 XORTmGqkkYAtv5cd2L9tuXXc6HB89qI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-LJiQRB4JN8a0aHiYU9lcmA-1; Sat, 26 Oct 2019 15:39:10 -0400
Received: by mail-qk1-f200.google.com with SMTP id d127so6067583qkc.1
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 12:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:content-transfer-encoding;
 bh=Zg+rkMHpASJm9gv0NQkdpGR05/GpW54dzxRERmCiBeE=;
 b=dXVqodKuFhS+LDEZ4IiaEMFmjvzaowJ+K4adBQQ7IGnJ5gTsX/ydG5jEASbb1RADkB
 Cl8qPxNhg2VrxUTYEayeAO8ubk2/CoEt+wVyPI/RqRMTn25WgvJ/eVLILuTumg0AsNSF
 VLrFN2K2mHgBHAi14YXwW1mFT0W6KUtVD4NCn0VJmsYEtPAj2TuYGv2FlIyzvr9WUeC7
 Z//nVNtnMSx0pbNMgdXbCIee21Gc3DP4Xoi/LGY12/j/JDmTCAKQt7WCK20kOXRHtCFw
 6T0h5m7n41f6h7ASBPNHpTNJGaqbRR3SiXmEvQJJ+nrmfzkWbZCJtyXdvxtv2KgCBuHw
 kr/g==
X-Gm-Message-State: APjAAAV2M1UQEdaaOCyDGiuOJZq+yrf+vS5yQ+WXCeYTHTSElXOLyVOA
 IkTX727q0i59vwgq3tpfzxLPNsEp/fM53ChuDZHIoehp7bJiD2cbOKEsKR05COu9N5d5EPZUnUA
 pFChpOUzA0x+Ez5k=
X-Received: by 2002:ac8:38a9:: with SMTP id f38mr10000283qtc.108.1572118749952; 
 Sat, 26 Oct 2019 12:39:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxsNVZWLLFrS0F20sQBgZZWyERCAL6+sqBMstiGAwP9HofHup1ExNto5QFPR4/9A209BeI5XA==
X-Received: by 2002:ac8:38a9:: with SMTP id f38mr10000262qtc.108.1572118749625; 
 Sat, 26 Oct 2019 12:39:09 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 b185sm4017995qkg.45.2019.10.26.12.39.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2019 12:39:08 -0700 (PDT)
Date: Sat, 26 Oct 2019 15:39:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/25] virtio: features, tests
Message-ID: <20191026193824.11926-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-MC-Unique: LJiQRB4JN8a0aHiYU9lcmA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

The following changes since commit 58560ad254fbda71d4daa6622d71683190070ee2=
:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.2-20191024' =
into staging (2019-10-24 16:22:58 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 909c548c539b4136e3abf2377980dad6274c4c2e:

  virtio: drop unused virtio_device_stop_ioeventfd() function (2019-10-25 0=
7:46:22 -0400)

----------------------------------------------------------------
virtio: features, tests

libqos update with support for virtio 1.
Packed ring support for virtio.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Eugenio P=C3=A9rez (2):
      virtio: Free blk virqueues at unrealize()
      virtio: Free rnd virqueue at unrealize()

Jason Wang (4):
      virtio: basic packed virtqueue support
      virtio: event suppression support for packed ring
      vhost_net: enable packed ring support
      virtio: add property to enable packed virtqueue

Stefan Hajnoczi (17):
      tests/virtio-blk-test: read config space after feature negotiation
      libqos: read QVIRTIO_MMIO_VERSION register
      libqos: extend feature bits to 64-bit
      virtio-scsi-test: add missing feature negotiation
      tests/virtio-blk-test: set up virtqueue after feature negotiation
      libqos: add missing virtio-9p feature negotiation
      libqos: enforce Device Initialization order
      libqos: implement VIRTIO 1.0 FEATURES_OK step
      libqos: access VIRTIO 1.0 vring in little-endian
      libqos: add iteration support to qpci_find_capability()
      libqos: pass full QVirtQueue to set_queue_address()
      libqos: add MSI-X callbacks to QVirtioPCIDevice
      libqos: expose common virtqueue setup/cleanup functions
      libqos: make the virtio-pci BAR index configurable
      libqos: extract Legacy virtio-pci.c code
      libqos: add VIRTIO PCI 1.0 support
      virtio: drop unused virtio_device_stop_ioeventfd() function

Wei Xu (2):
      virtio: basic structure for packed ring
      virtio: device/driver area size calculation refactor for split ring

 include/hw/virtio/virtio.h       |   15 +-
 tests/libqos/pci.h               |    2 +-
 tests/libqos/virtio-mmio.h       |    1 +
 tests/libqos/virtio-pci-modern.h |   17 +
 tests/libqos/virtio-pci.h        |   34 +-
 tests/libqos/virtio.h            |   19 +-
 hw/block/virtio-blk.c            |    7 +-
 hw/char/virtio-serial-bus.c      |    2 +-
 hw/net/vhost_net.c               |    2 +
 hw/scsi/virtio-scsi.c            |    3 +-
 hw/virtio/virtio-rng.c           |    1 +
 hw/virtio/virtio.c               | 1074 ++++++++++++++++++++++++++++++++++=
----
 tests/libqos/pci.c               |   30 +-
 tests/libqos/virtio-9p.c         |    6 +
 tests/libqos/virtio-mmio.c       |   38 +-
 tests/libqos/virtio-net.c        |    6 +-
 tests/libqos/virtio-pci-modern.c |  443 ++++++++++++++++
 tests/libqos/virtio-pci.c        |  105 ++--
 tests/libqos/virtio.c            |  160 ++++--
 tests/virtio-blk-test.c          |   66 ++-
 tests/virtio-scsi-test.c         |    8 +
 tests/Makefile.include           |    1 +
 22 files changed, 1803 insertions(+), 237 deletions(-)
 create mode 100644 tests/libqos/virtio-pci-modern.h
 create mode 100644 tests/libqos/virtio-pci-modern.c


