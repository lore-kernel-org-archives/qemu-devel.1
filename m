Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7461AC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 22:57:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AE2C21479
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 22:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE2C21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43174 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSrDO-0001Zt-B5
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 18:57:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrCY-0001EC-KE
	for qemu-devel@nongnu.org; Mon, 20 May 2019 18:56:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrCX-0000NC-II
	for qemu-devel@nongnu.org; Mon, 20 May 2019 18:56:14 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hSrCX-0000DG-99
	for qemu-devel@nongnu.org; Mon, 20 May 2019 18:56:13 -0400
Received: by mail-qt1-f195.google.com with SMTP id k24so18331204qtq.7
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 15:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=GkKH3srfLOfkbuG17YwZEDhkPkMS2JTDDH9PJ0Iz6m4=;
	b=SmwwBPV+wK+PmtUIN1sHT1M8aDuMN3V8u27oZEpaglr5inPz4BlhKlvaYaCH4gj7/K
	FjmeM+f+TqwWx2UQ79qX4xfxW28MUu5j9xte0t1XyET+OP7BXisPioUcvOydAceiE/zU
	9h3efOFu/on+quWOJto9xPxTbno94bSGSoe6id25U1zHV5ebfpF3jk+HuzJo+4HNfB6w
	iIGEFtoIVQJnxMX06epq14b6vLd35d4+2+q/UqM5Esj+HkX2uMLCXWcNCZqJYmMzpQ1q
	JAJurUEMX8G6sJwrMHnMyDx+07xC+ne3ikhyRTmNOZADpB4RwWA/yMLuez6HjZn3VlYs
	Fsqw==
X-Gm-Message-State: APjAAAVUowcQKquMzSAhLbkFF/gET5twIujQfP2WnDDOuWvk5DQXVdqn
	rQ3wVPCD8mwDwB/2yMTUa3uIeg==
X-Google-Smtp-Source: APXvYqzImDcExicufQSE5cF7XOSzbPwxt/0OzZmvDGTicCZkQYv/ZkQs7ACUmcS/r0pideFZ6IxrWw==
X-Received: by 2002:ac8:3598:: with SMTP id k24mr64667758qtb.46.1558392956921; 
	Mon, 20 May 2019 15:55:56 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	x3sm10466098qtk.75.2019.05.20.15.55.54
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 20 May 2019 15:55:55 -0700 (PDT)
Date: Mon, 20 May 2019 18:55:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190520185508-mutt-send-email-mst@kernel.org>
References: <20190520005957.6953-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520005957.6953-1-richardw.yang@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.195
Subject: Re: [Qemu-devel] [PATCH v5 0/6] Extract build_mcfg
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, thuth@redhat.com,
	qemu-devel@nongnu.org, shannon.zhaosl@gmail.com,
	qemu-arm@nongnu.org, imammedo@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 20, 2019 at 08:59:51AM +0800, Wei Yang wrote:
> This patch set tries to generalize MCFG table build process. And it is
> based on one un-merged patch from Igor, which is included in this serials.
> 
> v4->v5:
>     * ACPI_PCI depends on both ACPI and PCI
>     * rebase on latest master, adjust arm Kconfig
>     * miss the reserved[8] of MCFG, add it back
>     * make sure bios-tables-test all OK

So I am merging 1-4 now - they are unchanged from previous iterations.
You just need to repost 5-6.

> v3->v4:
>     * adjust comment to give more information about MCFG table
> 
> v2->v3:
>     * Includes the un-merged patch from Igor
>     * use build_append_foo() API to construct MCFG
> 
> Igor Mammedov (1):
>   q35: acpi: do not create dummy MCFG table
> 
> Wei Yang (5):
>   hw/arm/virt-acpi-build: remove unnecessary variable mcfg_start
>   i386, acpi: remove mcfg_ prefix in AcpiMcfgInfo members
>   hw/arm/virt-acpi-build: pass AcpiMcfgInfo to build_mcfg()
>   hw/acpi: Consolidate build_mcfg to pci.c
>   acpi: pci: use build_append_foo() API to construct MCFG
> 
>  default-configs/i386-softmmu.mak |  1 +
>  hw/acpi/Kconfig                  |  4 +++
>  hw/acpi/Makefile.objs            |  1 +
>  hw/acpi/pci.c                    | 57 ++++++++++++++++++++++++++++++++
>  hw/arm/Kconfig                   |  1 +
>  hw/arm/virt-acpi-build.c         | 31 +++++------------
>  hw/i386/acpi-build.c             | 44 ++++--------------------
>  include/hw/acpi/acpi-defs.h      | 18 ----------
>  include/hw/acpi/pci.h            | 34 +++++++++++++++++++
>  9 files changed, 113 insertions(+), 78 deletions(-)
>  create mode 100644 hw/acpi/pci.c
>  create mode 100644 include/hw/acpi/pci.h
> 
> -- 
> 2.19.1

