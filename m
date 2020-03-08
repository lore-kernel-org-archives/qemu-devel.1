Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D737C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 13:32:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5851D20866
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 13:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUApD4CI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5851D20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAw2d-0005FI-Dy
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 09:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jAw1T-0004VC-Cr
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 09:31:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jAw1S-0006UX-F2
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 09:31:15 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60930
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jAw1S-0006Td-BG
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 09:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583674273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vLZxKFDyLln3P4X3bsWsttBd23vjmMTd1x8ewmo+Gnw=;
 b=KUApD4CIJTl8E2rFgCoMqVUMp2ksb+XyA4gfAWmq4e7b8KYfx9HiQ8r4ziNcjOWyvP/sZ8
 R9ulyeUwpDmgKa2kqOPEI3Lb0+DOH1/FcDMmjsx6p16bBwOIKzVfHw/P2p9WD2qhtmfnf2
 NQg+JnHR+USAQT7IAL/MFcAht8YyCm0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-_vmLJipRPlW_FabryD69LQ-1; Sun, 08 Mar 2020 09:31:12 -0400
X-MC-Unique: _vmLJipRPlW_FabryD69LQ-1
Received: by mail-qt1-f199.google.com with SMTP id g6so4963770qtp.20
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2020 06:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:content-transfer-encoding;
 bh=AtEWYTk93jKyFJQygsziPn2jAXaRiVDTLinDw9eD9FM=;
 b=eXAJrymCnKhs1Tf/TQLmuy+nQVjYMi+NKcbcJcghGWrF7I6ZB+NtEcGtvJuxKDCDCT
 VfTNtwwoEivxKXxyOEiGMc89O1UJbOeQQiNfM6lKGhQaxJJtiO+6+vIexRcNuskzPH5U
 HojfrXr0qNPnWgswwiMIirsX2TBA4ax4JJXeaxA177W3ZOop7s3Msjs11WXY1NfNzMOp
 ZM1bw0YI76Jybv1GH/+2k08iJRfuLH7gbeejQ/7dpqwgqbxVtu6WCd7wDaJ5/uWKmVUk
 BzK8uT3YjMs/dgShea55uA7Qd72+1lMiXH8Y1GnoXrLaN/tSallDQvPYp5fgu5QXLw+k
 /PGQ==
X-Gm-Message-State: ANhLgQ1EZ++6U3H8LtencuPFREQy347tLjpd1BhRT8IUFkQUhpZyjYuN
 VogVtGqe8Lze/QFGLvIjLTXh4z2QeODy7bVo3lXbWJmSuw3USVWaoWAX+xrseoFklHyTtx7AnET
 ucHw7323PMvS9BkQ=
X-Received: by 2002:a05:620a:1241:: with SMTP id
 a1mr10892730qkl.61.1583674271251; 
 Sun, 08 Mar 2020 06:31:11 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsHAQRKSgT7Bd9WeNZrdUE2/qmhm9iuZK9JbJSjEKKvKiMWzzumcpnyO9KfqAJPTGyDl4wIXg==
X-Received: by 2002:a05:620a:1241:: with SMTP id
 a1mr10892704qkl.61.1583674270970; 
 Sun, 08 Mar 2020 06:31:10 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id p77sm18401689qke.18.2020.03.08.06.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2020 06:31:10 -0700 (PDT)
Date: Sun, 8 Mar 2020 09:31:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] virtio, pci, pc: fixes, cleanups, features
Message-ID: <20200308133054.1563705-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

The following changes since commit 67f17e23baca5dd545fe98b01169cc351a70fe35=
:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into stagi=
ng (2020-03-06 17:15:36 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to a6f65f4fc217713ee2c78b99baae1cc31c761778:

  hw/i386/intel_iommu: Simplify vtd_find_as_from_bus_num() logic (2020-03-0=
8 09:27:09 -0400)

----------------------------------------------------------------
virtio, pci, pc: fixes, cleanups, features

Bugfixes, cleanups all over the place.
Ability to disable hotplug for pci express ports.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Jason Wang (1):
      vhost: correctly turn on VIRTIO_F_IOMMU_PLATFORM

Julia Suvorova (1):
      pcie_root_port: Add hotplug disabling option

Nick Erdmann (1):
      vhost-vsock: fix error message output

Philippe Mathieu-Daud=C3=A9 (1):
      hw/i386/intel_iommu: Simplify vtd_find_as_from_bus_num() logic

 include/hw/pci/pcie.h              |  2 +-
 include/hw/pci/pcie_port.h         |  3 +++
 hw/i386/intel_iommu.c              | 34 ++++++++++++++++++----------------
 hw/pci-bridge/pcie_root_port.c     |  2 +-
 hw/pci-bridge/xio3130_downstream.c |  2 +-
 hw/pci/pcie.c                      | 11 +++++++----
 hw/pci/pcie_port.c                 |  1 +
 hw/virtio/vhost-vsock.c            |  2 +-
 hw/virtio/vhost.c                  | 12 +++++++++++-
 9 files changed, 44 insertions(+), 25 deletions(-)


