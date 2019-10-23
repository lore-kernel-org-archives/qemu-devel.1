Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505DBCA9EBB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 20:26:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27E0C2064A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 20:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E0C2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNNCi-0001nL-6I
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 16:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1iNMn6-00063y-Oh
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 15:59:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1iNMn4-0006q3-Kq
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 15:59:32 -0400
Received: from charlie.dont.surf ([128.199.63.193]:44904)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>) id 1iNMn4-0006pu-Et
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 15:59:30 -0400
Received: from apples.localdomain (ip-5-186-123-87.cgn.fibianet.dk
 [5.186.123.87])
 by charlie.dont.surf (Postfix) with ESMTPSA id AF20CBF44C;
 Wed, 23 Oct 2019 19:59:28 +0000 (UTC)
Date: Wed, 23 Oct 2019 21:59:27 +0200
From: Klaus Birkelund <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/1] pci: pass along the return value of dma_memory_rw
Message-ID: <20191023195927.GB466001@apples.localdomain>
References: <20191011070141.188713-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011070141.188713-1-its@irrelevant.dk>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 128.199.63.193
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 11, 2019 at 09:01:40AM +0200, Klaus Jensen wrote:
> Hi,
> 
> While working on fixing the emulated nvme device to pass more tests in
> the blktests suite, I discovered that the pci_dma_rw function ignores
> the return value of dma_memory_rw.
> 
> The nvme device needs to handle DMA errors gracefully in order to pass
> the block/011 test ("disable PCI device while doing I/O") in the
> blktests suite. This is only possible if the device knows if the DMA
> transfer was successful or not.
> 
> I can't see what the reason for ignoring the return value would be. But
> if there is a good reason, please enlighten me :)
> 
> 
> Klaus Jensen (1):
>   pci: pass along the return value of dma_memory_rw
> 
>  include/hw/pci/pci.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> -- 
> 2.23.0
> 

Gentle ping.

https://patchwork.kernel.org/patch/11184911/

