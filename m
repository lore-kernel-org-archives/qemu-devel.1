Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF3AC4646B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 06:50:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 644212089E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 06:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 644212089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55094 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heDNc-0001oU-JF
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 02:50:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56628)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1heDKf-00087T-98
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 02:47:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1heDJw-0005SY-Tn
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 02:46:49 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46007)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1heDJw-0005Rm-QE
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 02:46:48 -0400
Received: by mail-qt1-f195.google.com with SMTP id j19so5835966qtr.12
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 23:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fs4Y07E+1GAKPQC2EK12ZPOAC9gn6lG/ttRIZSdSg+s=;
 b=HyPfICshR9MxLRMu9TjjAabytHF+1hm7iImJLKc+vbegRbHDVniwtWFyKPgFHzz6WC
 xZbqqvaMD+aVsuKfJUTGdrM1YRJ/2GopH3ZunL/XO569kmAtkYsKWjXIezVANVzu5cFT
 6JyloZ4BQIkL/9MsDyQ8svEkzaUra1+VWh9ZCgtoNRZQgp2if5atRRGmz1loqOXjmGIF
 /iSDDnF8sDmvKHN32lwnvZsOFqC3ornPyEcmaKHQUzbFcHebWQAp505kLZnFgFItCpry
 mFTCStfrzzs/ibJlbm7OpUBibOGWm/nSRhrTSUSZ4c/GnNO3Q9TveSatexPQC+PI2j+5
 Ix3A==
X-Gm-Message-State: APjAAAW3qapj848Kgngi2yqxlK/u9dQMlS1m2DMVdR4WMmJ1l4BmJ/Se
 UiNYoN84oEW6YoN3rWjaYcNurrB3c88=
X-Google-Smtp-Source: APXvYqydSjGQQjtuUiePWzzI2qsKqxLudFKBIbQ07Tt7MkkJ2SVbRuEqDiPUEzYkvR8+re5zPyB8Sw==
X-Received: by 2002:ac8:2b14:: with SMTP id 20mr23638136qtu.295.1561099608038; 
 Thu, 20 Jun 2019 23:46:48 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
 [100.0.197.103])
 by smtp.gmail.com with ESMTPSA id z1sm908155qke.122.2019.06.20.23.46.47
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 20 Jun 2019 23:46:47 -0700 (PDT)
Date: Fri, 21 Jun 2019 02:46:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190621064615.20099-2-mst@redhat.com>
References: <20190621064615.20099-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621064615.20099-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.195
Subject: [Qemu-devel] [PATCH 1/3] pcie: don't skip multi-mask events
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we are trying to set multiple bits at once, testing that just one of
them is already set gives a false positive. As a result we won't
interrupt guest if e.g. presence detection change and attention button
press are both set. This happens with multi-function device removal.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 88c30ff74c..b22527000d 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -383,7 +383,7 @@ static void pcie_cap_slot_event(PCIDevice *dev, PCIExpressHotPlugEvent event)
 {
     /* Minor optimization: if nothing changed - no event is needed. */
     if (pci_word_test_and_set_mask(dev->config + dev->exp.exp_cap +
-                                   PCI_EXP_SLTSTA, event)) {
+                                   PCI_EXP_SLTSTA, event) == event) {
         return;
     }
     hotplug_event_notify(dev);
-- 
MST


