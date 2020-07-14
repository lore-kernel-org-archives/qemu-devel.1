Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1479C433E8
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 00:45:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ED3521835
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 00:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Qml3mxo+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED3521835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv94e-0002MS-Ms
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 20:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=457b4eeb6=alistair.francis@wdc.com>)
 id 1jv91m-0005nk-R4
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 20:42:35 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:30777)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=457b4eeb6=alistair.francis@wdc.com>)
 id 1jv91j-0008Oh-ST
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 20:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594687352; x=1626223352;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xcHlkEUB8K3W8z+63v2B/EdOVM81fq1DzUz4AiTWNF0=;
 b=Qml3mxo+hJ7OZrMMhSG7GUEMgqLwsvSpZvyhf9WC/jCpN9LH/146Pkkc
 lgL5iR+2k5uWQqMzrVLgwVdZzFTOXAEkwScSV5fsupjQGUZXnrBmxbUXM
 ALHfv+/v3SnYV8FlsfALlW4olf3pL9OYG38Def+l3qt43bDmnI7ls0OlH
 UcfKq0lrVTaUWWpcIYrZOg+Lzt1GL3TPIhnqGZ3nTBC2IQJMxDjRg6ORO
 lMSdJjuh02dJdGmQrY9LzsxosyW/PeiqO7uDSMkjjGJhKpmfTv/6x2B2h
 lj4peQPGj01N0APEZMnIxoyesW/Acohj+/FrJqy/rGKOzqfQ78hDktj1g w==;
IronPort-SDR: rd2390R43e6xH3UuVK3h79UJrp9HPMdAokYr5u26a0t0cvmglrBPv72caT3lPA7LMkDibWDTDY
 5slmv0/dfVC3c4qMCl4gD5ydociC3yxVNWvQnFIyWYrHFpA/wHtaRH0JeA1kHKF4W3LZD3au14
 Y/nzd/scED2UGSHS+uyo+RL9qBe0lWOC2zFgupNj9kRnSXziLtOV6/dEM+xLcWXVY5z/JV/OFR
 zFz/yWcmEE3t3Y/kfuyw61jSyqfxJtSmKiydFRgUZ6uj1CWW7gklKVG/TSbOH7auS2UX19EKfS
 YmI=
X-IronPort-AV: E=Sophos;i="5.75,349,1589212800"; d="scan'208";a="142511917"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2020 08:42:28 +0800
IronPort-SDR: SDCxjQLbb7y50eO3M7HMkH2QfWyWNxLKK2llL5jNThMimd6T5eOgpkydqqU/PbKrHAHF+FamjX
 HxZ/mMoHlCyj4wooJoSeqGL+OzhvjrbiM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2020 17:30:56 -0700
IronPort-SDR: gPeYaMEnwY2bt33LpY9f2WfaAt9f46Uole8pRi1W2jfjcelVc9ZaBYhsexPDd3cgkooQCQlrCx
 /xH8p9MSM5Fg==
WDCIronportException: Internal
Received: from usa002626.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.178])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Jul 2020 17:42:28 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/15] MAINTAINERS: Add an entry for OpenSBI firmware
Date: Mon, 13 Jul 2020 17:32:40 -0700
Message-Id: <20200714003254.4044149-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714003254.4044149-1-alistair.francis@wdc.com>
References: <20200714003254.4044149-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=457b4eeb6=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 20:42:28
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bmeng.cn@gmail.com>

List me as the maintainer for OpenSBI firmware related files.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <1593177220-28143-1-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe8139f367..80fa8837e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2681,6 +2681,13 @@ F: hw/i386/intel_iommu.c
 F: hw/i386/intel_iommu_internal.h
 F: include/hw/i386/intel_iommu.h
 
+OpenSBI Firmware
+M: Bin Meng <bmeng.cn@gmail.com>
+S: Supported
+F: pc-bios/opensbi-*
+F: .gitlab-ci.d/opensbi.yml
+F: .gitlab-ci.d/opensbi/
+
 Usermode Emulation
 ------------------
 Overall usermode emulation
-- 
2.27.0


