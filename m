Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51A8C47095
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7527E20781
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="Uqv1W8rO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7527E20781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPMCx-0003rm-L5
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 04:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1kPLtQ-0007mh-Bn
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:30:48 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:45000)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1kPLtO-0008OR-HF
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:30:47 -0400
Received: by mail-lf1-x142.google.com with SMTP id 197so9782089lfo.11
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 01:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=g4iKcUIM7terCeaBS6RyMfNNspV94WN2EocDcg/2Bmc=;
 b=Uqv1W8rOOgib8k1lKmbcnlSPHFjGYGiB9RREtMWoQsyMR67kdTHtOKoh4mVMb+s9V+
 Aq9OEuF4t542M97qtZVlZbSNUDAchmI2bbpKZZd2/C+PLZBxZtLnet9JNk5NKpH8b4QF
 cvMKkLmgOPBK6tE3h9J9/rvEAIc7JXX+iTCCtJ0oTICVtc+FapEYoYFQi7Ar63TXXnyF
 kyEjfoD/WOFl0UjoK5q7IJ/sVtVqaQ+tYsUqUavwU78u0/Oafhhk22ANWEDTHIzZzUle
 IBx41pO/CA4IdNHIIAYgsPZTME2Q7ERdP4lmSqFUN7MoX27GxN5tSucy2cz7F3V3aptM
 8Mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=g4iKcUIM7terCeaBS6RyMfNNspV94WN2EocDcg/2Bmc=;
 b=LAhpTK4kS4EQ4V4+UxdTFURk3R2dqbh3wQ4imcYrAmaQovnLnBSd3botYfwLR9PII+
 xh1aLrFKV6VYrErANK5UBdt9sLpEzk97+qAZXNyXxr4BZn6xiT3jBaxjhTtTnJ5jpVaA
 taanJ50PvOl3Y9HUhuFIkEahiXXlxzHqrK+F/8y1l+ZkHnjxD0xLR9Iyh4vrXemfyboq
 A1NO2sTYixa9hns0sH5R4XxAIbszzb9P8b11/FjxZutVjpV6GP7cep3XyJh5Erb9vMfJ
 7nnqwbTzIaJNK+sUQldnT9zz+YjoRyq1HqpjirSUVnOoi/Y5NaPdk76cOeq8nmso0eCB
 yf0A==
X-Gm-Message-State: AOAM532NLBrql96vUlqn+xNwXfxmRBm5SJRIzvCToStVNYVZo9kEa19r
 mQkQJYycEFyvdXsUp6tti/jl1TJ3OItqYg==
X-Google-Smtp-Source: ABdhPJweNAp0ScT9tqvjvYn2w7PPuheO7TZBQ/01XMB3WLP00CrPw8BPA4z3Uo78SDaDK652kmCFQA==
X-Received: by 2002:a19:64b:: with SMTP id 72mr3255950lfg.47.1601886640158;
 Mon, 05 Oct 2020 01:30:40 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id o27sm2585693lfb.306.2020.10.05.01.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 01:30:39 -0700 (PDT)
From: andrew@daynix.com
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] hw/virtio-pci: AER capability
Date: Mon,  5 Oct 2020 12:01:38 +0300
Message-Id: <20201005090140.90461-1-andrew@daynix.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::142;
 envelope-from=andrew@daynix.com; helo=mail-lf1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew Melnychenko <andrew@daynix.com>

Now, AER capability for virtio-pci is disabled by default.
AER capability is only for PCI with PCIe interface on PCIe bus.
During migration - device "realize" should initialize AER
if requested by device properties.

Andrew (2):
  hw/virtio-pci Added counter for pcie capabilities offsets.
  hw/virtio-pci Added AER capability.

 hw/virtio/virtio-pci.c | 20 +++++++++++++++++++-
 hw/virtio/virtio-pci.h |  4 ++++
 2 files changed, 23 insertions(+), 1 deletion(-)

-- 
2.28.0


