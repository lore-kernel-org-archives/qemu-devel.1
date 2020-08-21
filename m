Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28933C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:34:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBE5F20724
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FcVI/YAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE5F20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k99zc-0005UO-4c
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 12:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1k99vz-0007u9-3w
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:30:31 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:33843)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1k99vv-0006nm-K8
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:30:30 -0400
Received: by mail-ej1-x643.google.com with SMTP id o23so3030129ejr.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 09:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cfGEtVcjgxqVubuTMIgt6HrOoNGCRwyjjLNrvoUWZIE=;
 b=FcVI/YAV+PBNs/h35+luBqIu5MBgP4JC3OJUnM+kHCHF8ZyBBS5CkJCszjSsrW53QR
 YY3GkGj2Lf01ntsQIcD/7onmQKw9EeGyAjZX4BjlVFjH7m44yVGxOyu0OYcdsrCop0Wv
 1Z16aIRw/4al5FceE09chtSY4OibYq+/HOsq0oZuuIn2gW6w+CAcIUs+jbGb2731gsyS
 DtcrE4QQmJ8v00DC7ktgUZHN4ORb1qjBh+GRrAVFhusNI1ZZfQBiDfNI+OLxxLu7dex4
 SP5gdCu7ykqhNMW2y9C/uShqtv48zYfuvxd20DThCDj2EJKLHtdceZtLiLUpPoVkgi9n
 uHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cfGEtVcjgxqVubuTMIgt6HrOoNGCRwyjjLNrvoUWZIE=;
 b=V1d6EOLKxsGU3fYrsEfOf3rca15dB0auuYZwoZcbF43yZqDziy3tbxri8+CsYUgHxP
 Qc2qONwpyc1yyN1kqOn2TPj/PyyXuXiJjbQYsvjtLZrtNCdWOQqy9FiXp//eoR5NS2Cv
 ISWM4ukqmS6JFJJPQuXSfhCTCHl6V3mP0odpyY/l0LqDPds1pDKGiKWnyGqo52nNPxxt
 LTAk21Pe6/fhFxAINK4NP/gAkWiym8Ll6e9o/ulHigGdZpHdt+qnER98kGER5Gsh1Wb/
 XubsnMRWRAhStjeTOYpPpSZiffIU2SB5SEnnynxXalQUN8fL1TLJhzFONvm42NuOvIYl
 9miw==
X-Gm-Message-State: AOAM53242XsuR8tTmNhY3arFv4nsFQCxehhHztPUtJEEt7a5rzEGF7pi
 BBp2JoZgrxQbXxHZKNkx5WJ7Jw==
X-Google-Smtp-Source: ABdhPJz6ycDFGslYAKVe3XafSFgwZH19GNj3LKMVVzVuLVIv+62GHiDvGCjt/XSNwnDm4w8RB8P1cg==
X-Received: by 2002:a17:906:9989:: with SMTP id
 af9mr3498328ejc.385.1598027425104; 
 Fri, 21 Aug 2020 09:30:25 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id dk28sm1398030edb.90.2020.08.21.09.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 09:30:24 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/5] linux headers: Import virtio-iommu header from Linux
Date: Fri, 21 Aug 2020 18:28:36 +0200
Message-Id: <20200821162839.3182051-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821162839.3182051-1-jean-philippe@linaro.org>
References: <20200821162839.3182051-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=jean-philippe@linaro.org; helo=mail-ej1-x643.google.com
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, mst@redhat.com,
 eric.auger@redhat.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Import virtio-iommu topology definitions from Linux. These changes
haven't been upstreamed yet.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/standard-headers/linux/virtio_iommu.h | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/include/standard-headers/linux/virtio_iommu.h b/include/standard-headers/linux/virtio_iommu.h
index b9443b83a13..ee158c37c36 100644
--- a/include/standard-headers/linux/virtio_iommu.h
+++ b/include/standard-headers/linux/virtio_iommu.h
@@ -16,6 +16,7 @@
 #define VIRTIO_IOMMU_F_BYPASS			3
 #define VIRTIO_IOMMU_F_PROBE			4
 #define VIRTIO_IOMMU_F_MMIO			5
+#define VIRTIO_IOMMU_F_TOPOLOGY			6
 
 struct virtio_iommu_range_64 {
 	uint64_t					start;
@@ -27,6 +28,17 @@ struct virtio_iommu_range_32 {
 	uint32_t					end;
 };
 
+struct virtio_iommu_topo_config {
+	/* Number of topology description structures */
+	uint16_t					count;
+	/*
+	 * Offset to the first topology description structure
+	 * (virtio_iommu_topo_*) from the start of the virtio_iommu config
+	 * space. Aligned on 8 bytes.
+	 */
+	uint16_t					offset;
+};
+
 struct virtio_iommu_config {
 	/* Supported page sizes */
 	uint64_t					page_size_mask;
@@ -36,6 +48,38 @@ struct virtio_iommu_config {
 	struct virtio_iommu_range_32		domain_range;
 	/* Probe buffer size */
 	uint32_t					probe_size;
+	struct virtio_iommu_topo_config		topo_config;
+};
+
+#define VIRTIO_IOMMU_TOPO_PCI_RANGE		0x1
+#define VIRTIO_IOMMU_TOPO_MMIO			0x2
+
+struct virtio_iommu_topo_pci_range {
+	/* VIRTIO_IOMMU_TOPO_PCI_RANGE */
+	uint8_t					type;
+	uint8_t					reserved;
+	/* Length of this structure */
+	uint16_t					length;
+	/* First endpoint ID in the range */
+	uint32_t					endpoint_start;
+	/* PCI domain number */
+	uint16_t					segment;
+	/* PCI Bus:Device.Function range */
+	uint16_t					bdf_start;
+	uint16_t					bdf_end;
+	uint16_t					padding;
+};
+
+struct virtio_iommu_topo_mmio {
+	/* VIRTIO_IOMMU_TOPO_MMIO */
+	uint8_t					type;
+	uint8_t					reserved;
+	/* Length of this structure */
+	uint16_t					length;
+	/* Endpoint ID */
+	uint32_t					endpoint;
+	/* Address of the first MMIO region */
+	uint64_t					address;
 };
 
 /* Request types */
-- 
2.28.0


