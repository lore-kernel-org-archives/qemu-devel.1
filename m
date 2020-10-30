Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6482C4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17AAC206E5
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hIDI38dc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17AAC206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYYoH-0006iY-OV
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 14:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kYYmf-00055E-HP
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:05:53 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39886)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kYYmZ-0004om-W0
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:05:51 -0400
Received: by mail-wr1-x442.google.com with SMTP id y12so7439789wrp.6
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 11:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ogWY79DGBphZ5cSLWp+iarT8DOVPwPU4DycZP1s48eM=;
 b=hIDI38dchaM7mwa6axoQPbJKDp9g5SlsXm3WUx3q0ejkGkv5+NDSfhr9t8gGZWkiCh
 vA6L/NECH3bGi5Sh2HoBDckZ08jeFcXbiS/kyQZgU4YOgOcA6F70vULt16TVT9dSwLbd
 6X585Sc7C/mjp4Cn1NjZF07xP7SE15M/ON527gWTtAJ8rJx4YJR4/m5SD/Bces3yZwz0
 qAlNtIT3g0E8ugZQNp4XZtG7I7T5Kn5+cFv+TZBkP48k66l2vpuTOiPjAlWG7m4NvrAe
 iw8kWy/shmR/0yuv1t6nr0rDew3jDpSxl07pvfne1sczVIAinMhdlfsgdFRvTkHjswPk
 s2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ogWY79DGBphZ5cSLWp+iarT8DOVPwPU4DycZP1s48eM=;
 b=Oymogdy2Bvz6RVmwcIFLvnVUf9SawGM/2Tk2Na14dpIv0t6fpAZBRwHt805cs6+bfy
 inrVrkwAvDVZJMhsURtBs9q0b8UpNxo4vQ7XlOSNWoYdxrEMY95M0aUISzr26YEPOiHT
 FUy33wEdmO/FcqM8+nudogchMK8DYmHxvS+MB5UZSCr5z0tBg0q0I6f3hJOv9OuZUBEk
 YMD8VP35SG383UiVnoJMbLmaB7SgwKJpF15MVszbF3WuVHp7xZopaks7WwUVOGxIdwa7
 5l8P++Mo351gHIVPljHxYe77eqjaLS1w+u0hdH4IbHSQPN4ox7dkfHcTVXzpvQ4lHMZe
 babA==
X-Gm-Message-State: AOAM5303kA98ELAK5JoyEr7JPibtT9p0eGBI4GEMhupKe73WPronWpLm
 gHwEFuTHtb3Za0fXkRgEC0ME8Q==
X-Google-Smtp-Source: ABdhPJzpYSnuWLVORF6kIqZC3wVYhBKzRrEYGYvaFs2y8heoy9AXPozN0zkxlxzTaASMFLeDYJJNYA==
X-Received: by 2002:a5d:54d0:: with SMTP id x16mr4612623wrv.75.1604081146325; 
 Fri, 30 Oct 2020 11:05:46 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id u3sm10044438wro.33.2020.10.30.11.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 11:05:45 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: eric.auger@redhat.com,
	alex.williamson@redhat.com
Subject: [PATCH v11 00/10] virtio-iommu: VFIO integration
Date: Fri, 30 Oct 2020 19:05:00 +0100
Message-Id: <20201030180510.747225-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x442.google.com
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
Since [v10] I addressed the review comments, and changed the logic of
patch 9 for setting the page mask, as discussed. Please see individual
changelogs for details.

[v10] https://lore.kernel.org/qemu-devel/20201008171558.410886-1-jean-philippe@linaro.org/

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

 include/exec/memory.h    |  38 ++++++++
 hw/vfio/common.c         |  19 ++++
 hw/virtio/virtio-iommu.c | 205 ++++++++++++++++++++++++++++++++++++++-
 softmmu/memory.c         |  13 +++
 hw/virtio/trace-events   |   6 ++
 5 files changed, 279 insertions(+), 2 deletions(-)

-- 
2.29.1


