Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4ACC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 11:26:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B54620795
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 11:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="CMufNrVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B54620795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPOdL-0001yk-0l
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 07:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1kPOc6-00010n-7z
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 07:25:06 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:33851)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1kPOc4-0005kQ-5q
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 07:25:05 -0400
Received: by mail-lf1-x143.google.com with SMTP id u8so10402054lff.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 04:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VwG+XNrhoeeF5cRnLMedD+7G946kK8EA6TQLCd3Qk68=;
 b=CMufNrVjvjJMA1o2UzuKlnx5qJsFXv1rtGVVTL/q48uxOYima/h46z11in6KFQnJKh
 4+VpzGcgCL3xKlhQLXApXUyr3sg6/991eGWsFs+a2IrcX5ESDhrJf/BMOLQStz/OSRY3
 U60VQLSDbaUp4urikgmEG+FBqX3KbMSl087EIeWSLctNkXGTmR9w/2iK3Gc4QJfZiDjQ
 Pb+auz353iBnaFep32Hqd2nLxju1egYnL+UBDO3Cv3wXfSqtmkG1gaQsxV8qIhAzRPoW
 r7tHWrTYh2Mkq4BuXFd/1Rp8qFctCgUvI5f8w1zTnbQqcwQ/TR8N6wLUTGktBlEj6kju
 bEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VwG+XNrhoeeF5cRnLMedD+7G946kK8EA6TQLCd3Qk68=;
 b=k72LEr4ccexyVL1hT9uC/WZ7jFesc4vOxmZdh8CP87Wn3GQUw/EyKpITXxA5onY9Em
 ReHiXqtmUl481x+aZfnlQpgyFbnYQdU1aI/Vs1cF0aQWOP8y6JDtT8P96yPiDsnHc7sk
 D7Kkta+e7DJD3baPlJsC7XDf7NDsEfg6BJ5Wez8vIYqQh1b23paOIOrXx325DYRWxdHk
 PD0ITG7xuKiqTIxn0WWUdB2Y3oCdDcxXQd353GjLYG2XRxrRx8Nr1cg3HPhrXLMmDYgi
 Owgpf4hVN/Qus93KrKUPxizVuRqQtQePJMnPrIbAWL6Hn4NhuSbamgS0aUMfH1UU5aEt
 2xEA==
X-Gm-Message-State: AOAM533HjfizAq9pIQgt0ePPkoEKRfubjIvE9igzrEgUQhEWWh9a3Y1X
 /GTaDv6vxLkxoVQClKI1l1DF9wY5tFQ0MQ==
X-Google-Smtp-Source: ABdhPJzxeM9exvRuWkdfD3r5lbIcq5KW//gsF8ktavjFPHjvfN4B8Th0TQHP4qOd/kPwkicxMctWog==
X-Received: by 2002:a19:c1d7:: with SMTP id r206mr3138014lff.87.1601897101721; 
 Mon, 05 Oct 2020 04:25:01 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id f10sm1546514ljn.87.2020.10.05.04.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 04:25:00 -0700 (PDT)
From: andrew@daynix.com
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] hw/virtio-pci: AER capability
Date: Mon,  5 Oct 2020 14:55:59 +0300
Message-Id: <20201005115601.103791-1-andrew@daynix.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::143;
 envelope-from=andrew@daynix.com; helo=mail-lf1-x143.google.com
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
Also fixed commit message and added proper link to bugzilla.

Andrew (2):
  hw/virtio-pci Added counter for pcie capabilities offsets.
  hw/virtio-pci Added AER capability.

 hw/virtio/virtio-pci.c | 20 +++++++++++++++++++-
 hw/virtio/virtio-pci.h |  4 ++++
 2 files changed, 23 insertions(+), 1 deletion(-)

-- 
2.28.0


