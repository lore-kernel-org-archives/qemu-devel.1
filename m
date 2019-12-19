Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98E9C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 16:18:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 959892146E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 16:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ps6hOm2H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 959892146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihyV1-0004rM-QT
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 11:18:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kbusch@kernel.org>) id 1ihyTS-0003bf-LK
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:16:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kbusch@kernel.org>) id 1ihyTP-0006Xm-0o
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:16:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34138)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kbusch@kernel.org>)
 id 1ihyTL-0006Rb-2x; Thu, 19 Dec 2019 11:16:19 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9AD6D2146E;
 Thu, 19 Dec 2019 16:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576772176;
 bh=PvBMk40AVcsxpbmsnTaXSTM4abX/LuAy5ZAECYOZVi4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ps6hOm2H+5sMTJolXBUnW/MkEZIIYBuOQg2uMwgf5wJDoa4jV07+I4bQzcktCy3A1
 4AB/xagV+63poSKgoBCa443ROKpVYRBf72bmeexMOULTJP56X+VYMvfJr2Lcn3k9ip
 Xj0jQAYgZGhb2IHHwaYXLpmR2LGPWRmcmtIdDfZU=
Date: Fri, 20 Dec 2019 01:16:09 +0900
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v4 22/24] nvme: bump controller pci device id
Message-ID: <20191219161609.GA24055@redsun51.ssa.fujisawa.hgst.com>
References: <20191219130921.309264-1-k.jensen@samsung.com>
 <CGME20191219130949eucas1p172304dc579f8bda43a8febd234064799@eucas1p1.samsung.com>
 <20191219130921.309264-23-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219130921.309264-23-k.jensen@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 198.145.29.99
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 19, 2019 at 02:09:19PM +0100, Klaus Jensen wrote:
> @@ -2480,7 +2480,7 @@ static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev)
>      pci_conf[PCI_INTERRUPT_PIN] = 1;
>      pci_config_set_prog_interface(pci_conf, 0x2);
>      pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_INTEL);
> -    pci_config_set_device_id(pci_conf, 0x5845);
> +    pci_config_set_device_id(pci_conf, 0x5846);
>      pci_config_set_class(pci_conf, PCI_CLASS_STORAGE_EXPRESS);
>      pcie_endpoint_cap_init(pci_dev, 0x80);

We can't just pick a number here, these are supposed to be assigned by the
vendor. A day will come when I will be in trouble for using the existing
identifier: I found out to late it was supposed to be for internal use
only as it was never officially reserved, so lets not make the same
mistake for some future device.

