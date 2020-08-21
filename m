Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7B1C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:31:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C860207DE
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XFdOZ22V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C860207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k99xK-0001Co-7k
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 12:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1k99vv-0007tO-W2
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:30:28 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:34487)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1k99vt-0006mP-1N
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:30:27 -0400
Received: by mail-ed1-x543.google.com with SMTP id bs17so1953255edb.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 09:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HWqwkfbMIQKiQpdnbw24fCwXZALtGYStinOFhF15nP8=;
 b=XFdOZ22VxsBhg14LK341LWAWJFSzlpQ8+eIX3hdz5+t+Ex3H4pdMkor7u673g960dr
 KSx1BzhsRhapEEpxR8qcRbfKQUbCt6eg+Gzp2hZjxwTnj6aJklYtS5KTYHItVuA0dqO9
 PnqsAdQ5twwiv9UhpwsajdcDLCYXpyYtr5juPaoxjbVblEOGxgk2qqKDZ/fd6yhqBQGy
 fo15iBSD+627jp3oMTXvESGkIv2pR7pQUmQwqUR7paJpOLLe6TAHvbkPNY0Qu3ucfPzh
 HIgXmHP8V76g2GIJjQrTXwBucXGPUeL7E5wKDp/ptZwJFdopuqU0QWfDQ+qE0npTZ54c
 rb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HWqwkfbMIQKiQpdnbw24fCwXZALtGYStinOFhF15nP8=;
 b=oPxFMwbr4FM+KVM00uGF6uYTi1SqL2VF5Nb9BUvIL3+SxEU1DNLA8thJIaKvJqjYq1
 TeDr0ZTVwQaZ8eTklIRQ2Pluoos3q0J2XXVbL0AZdPPNP2KEtUsnVDPKvDRlRUEn6qvw
 DxN/VnboUPIfK9D0U3wXW1zcdgQ/TYzY+/ikGRSxF3XoMNZmKNloMog+6RU/d3Q9DFN8
 c11iax1bQo5A6tcY3u+3YS5+cemyf9lIis/y7Cs5+PMc17ETwOO0NcPwFLfrGsLhPHum
 /LZzUxPV/LM0aMtvujesZaIH9Mioa7o2LItqg8czHHjWiBT7cZ9j/5zmdT4OKfuqUstZ
 BSmQ==
X-Gm-Message-State: AOAM530nOsnvxA59Yjq0Vn5DiqTdP06xtDIGcl/GNzcmAfLHUkeA9MaC
 rI5x1U0ftCFmtfLqejXSLybiIw==
X-Google-Smtp-Source: ABdhPJwRyysxsoHWnPq3r1zlBzseM8FUAYYFzGNwBGeKdtq+S49DhbzCKftJe7i8zGHvW+3Q2bUK/Q==
X-Received: by 2002:aa7:c70b:: with SMTP id i11mr3566222edq.272.1598027422929; 
 Fri, 21 Aug 2020 09:30:22 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id dk28sm1398030edb.90.2020.08.21.09.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 09:30:22 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/5] virtio-iommu: Built-in topology and x86 support
Date: Fri, 21 Aug 2020 18:28:34 +0200
Message-Id: <20200821162839.3182051-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=jean-philippe@linaro.org; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, mst@redhat.com,
 eric.auger@redhat.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a topology description to the virtio-iommu config space, allowing to
create a virtio-iommu device on platforms without device-tree. Our
long-term plan is to add an ACPI table that describes this topology, but
it will take a while to ratify. This built-in topology is needed anyway
for platforms that don't use either DT or ACPI (e.g. microvm) and can be
used as a temporary boot method for ACPI platforms as well.

Patch 1 looks unrelated, but is required to boot with a firmware on x86.
As previously discussed on this list:
https://lore.kernel.org/qemu-devel/aa5fa9e6-6efd-e1a3-96c6-d02ba8eab4c8@redhat.com/

This work depends on the proposed spec change for virtio-iommu (v2):
https://lists.oasis-open.org/archives/virtio-dev/202008/msg00067.html

And the Linux implementation (v3):
https://lore.kernel.org/linux-iommu/20200821131540.2801801-1-jean-philippe@linaro.org/

Eric Auger (1):
  hw/i386/pc: Add support for virtio-iommu-pci

Jean-Philippe Brucker (4):
  virtio-iommu: Default to bypass during boot
  linux headers: Import virtio-iommu header from Linux
  virtio-iommu: Declare topology in config space
  hw/arm/virt: Remove device-tree restriction on virtio-iommu

 include/hw/virtio/virtio-iommu.h              |  4 ++
 include/standard-headers/linux/virtio_iommu.h | 44 +++++++++++++
 hw/arm/virt.c                                 | 10 +--
 hw/i386/pc.c                                  |  9 ++-
 hw/virtio/virtio-iommu-pci.c                  |  2 -
 hw/virtio/virtio-iommu.c                      | 62 ++++++++++++++++---
 hw/virtio/trace-events                        |  4 +-
 7 files changed, 115 insertions(+), 20 deletions(-)

-- 
2.28.0


