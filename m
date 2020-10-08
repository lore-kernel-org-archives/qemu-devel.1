Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51966C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:18:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 888ED204EF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rGgAm5Cg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888ED204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQZYT-00066g-9I
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 13:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kQZX9-0004gr-Tl
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:16:51 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54803)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kQZX8-0006dq-6B
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:16:51 -0400
Received: by mail-wm1-x344.google.com with SMTP id p15so7235793wmi.4
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 10:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ov7qk3cmZdLbo6B66/DwhAswXTq22jpqn9muQ2KRmCk=;
 b=rGgAm5CgewJ/FebnO1UC9WYSW59EBcIlT9RQwqTDQC4HNmDvsfCYelk5KAByfudpwB
 AqupzZsfoDq6LImGktLi4S98IIB2abYJimbwZ4pqkkSYh7n5EYuf9X8g0G0QZOc6A4Ye
 hGvefPQz2WXfkzUTV2nhNEFiozMicEG32mfzsrjxu+jHXy95DpFzhUxR/Jw4RIAI7eFK
 LqoFumb8lnqYclVjnAMoIAl+1x+1jblcE2aFvilqx49lZYWsjAKHg5LgQaN18yd8VFNA
 GfjUpjSjOBWFnN0jpliEbP1QcvjpcSUUH9UZB6S2eCqae3NM0nx7d8eDfhlh3ev/4rLo
 Vj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ov7qk3cmZdLbo6B66/DwhAswXTq22jpqn9muQ2KRmCk=;
 b=gBPoHCdpEG/1zHIESBpLZpzHxikbG+CpyiyhWVPUCFCXdPWgCTs6+MDPVaGsmLKL4N
 OVMx5fPHGiijL9zi6C0HinmlA6mRoDeO6vO2af6yBhXMXuDSLxXCI/UBdC9/ifPIwA+Z
 kKady6kZSHCTu7qZK1Z7xerHfo1QygN1buajWMlv6ynEDmAbtJ3BTBotfzwvUgS87i2h
 H03K8uJdYIv8nlokm65OcafH1zfTGD9VqP4Iv320VwLd2yi6lkM9DCitndTnbFOi0en2
 rHo9Kx+lT+LNtfjObJ6Oov7ZG6QP7SIe6VPD6INkjcrNWfwdwJ1lnBz0lQxtnpufGTqN
 hA8g==
X-Gm-Message-State: AOAM530qLyf8/WScJlB0olXtZ1VLmDK4Cxc6OWAsre7rngx6NfMyyery
 5pgKA7qt5BFDure9RWHXNL+8kA==
X-Google-Smtp-Source: ABdhPJwo1OSthaM/mayhzFOlyEtsd02UvzE2zv9lhAv7fLPOhwdGotkzFjgLCMzSKOilPgv41K9RMw==
X-Received: by 2002:a1c:f20f:: with SMTP id s15mr10003451wmc.69.1602177408236; 
 Thu, 08 Oct 2020 10:16:48 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id x1sm719413wrl.41.2020.10.08.10.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 10:16:47 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: eric.auger@redhat.com,
	alex.williamson@redhat.com
Subject: [PATCH v10 00/10] virtio-iommu: VFIO integration
Date: Thu,  8 Oct 2020 19:15:48 +0200
Message-Id: <20201008171558.410886-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, mst@redhat.com,
 qemu-devel@nongnu.org, peterx@redhat.com, pbonzini@redhat.com,
 bbhushan2@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series adds support for VFIO endpoints to virtio-iommu.

Versions 1 to 9 were posted by Bharat Bhushan, but I am taking over for
now since he doesn't have much time to spend on it. Thanks again Bharat
for the work!

Two major changes since [v9]:

* Don't use per-endoint page_size_mask properties. Instead keep a global
  page size for the virtio-iommu device, updated when adding a VFIO
  endpoint. Reject hotplug if the page size is incompatible.

* Try to make the MAP/UNMAP paths more efficient, by keeping track of
  memory region within the endpoint structure.

More testing would be appreciated, since I can only test using a software
model as host at the moment. But it does seem to hold well with PCIe
hotplug/unplug, and pass-through to guest userspace, which are no mean
feat.

Note that one page size combination is not supported: host 64kB guest
4kB cannot work, because the host IOMMU driver will automatically pick
64kB pages which prevents mapping at a smaller granule. Supporting this
case would require introducing a page size negotiation mechanism from
the guest all the way to the host IOMMU driver. Possible, but not
planned at the moment.

[v9] https://lore.kernel.org/qemu-devel/20200323084617.1782-1-bbhushan2@marvell.com/

Bharat Bhushan (7):
  virtio-iommu: Add memory notifiers for map/unmap
  virtio-iommu: Call memory notifiers in attach/detach
  virtio-iommu: Add replay() memory region callback
  virtio-iommu: Add notify_flag_changed() memory region callback
  memory: Add interface to set iommu page size mask
  vfio: Set IOMMU page size as per host supported page size
  virtio-iommu: Set supported page size mask

Jean-Philippe Brucker (3):
  virtio-iommu: Fix virtio_iommu_mr()
  virtio-iommu: Store memory region in endpoint struct
  vfio: Don't issue full 2^64 unmap

 include/exec/memory.h    |  26 +++++
 hw/vfio/common.c         |  19 ++++
 hw/virtio/virtio-iommu.c | 204 ++++++++++++++++++++++++++++++++++++++-
 softmmu/memory.c         |  13 +++
 hw/virtio/trace-events   |   5 +
 5 files changed, 265 insertions(+), 2 deletions(-)

-- 
2.28.0


