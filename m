Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C69AC433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:16:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7CC2207BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7CC2207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqfPK-00055x-2h
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 12:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqfKH-0005uv-Cq; Wed, 01 Jul 2020 12:11:09 -0400
Received: from charlie.dont.surf ([128.199.63.193]:49998)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqfKE-00067D-Vn; Wed, 01 Jul 2020 12:11:08 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 1DF93BF64B;
 Wed,  1 Jul 2020 16:11:04 +0000 (UTC)
Date: Wed, 1 Jul 2020 18:11:01 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: Cover "block/nvme.h" file
Message-ID: <20200701161101.pv7e7ivy37snagvs@apples.localdomain>
References: <20200701140634.25994-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200701140634.25994-1-philmd@redhat.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 12:11:05
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul  1 16:06, Philippe Mathieu-Daudé wrote:
> The "block/nvme.h" header is shared by both the NVMe block
> driver and the NVMe emulated device. Add the 'F:' entry on
> both sections, so all maintainers/reviewers are notified
> when it is changed.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

> ---
> Cc: Fam Zheng <fam@euphon.net>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Niklas Cassel <Niklas.Cassel@wdc.com>
> Cc: Klaus Jensen <its@irrelevant.dk>
> Cc: Klaus Jensen <k.jensen@samsung.com>
> Cc: Maxim Levitsky <mlevitsk@redhat.com>
> Cc: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
> Cc: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dec252f38b..9995cdc805 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1795,6 +1795,7 @@ M: Keith Busch <kbusch@kernel.org>
>  L: qemu-block@nongnu.org
>  S: Supported
>  F: hw/block/nvme*
> +F: include/block/nvme.h
>  F: tests/qtest/nvme-test.c
>  
>  megasas
> @@ -2804,6 +2805,7 @@ M: Fam Zheng <fam@euphon.net>
>  L: qemu-block@nongnu.org
>  S: Supported
>  F: block/nvme*
> +F: include/block/nvme.h
>  
>  Bootdevice
>  M: Gonglei <arei.gonglei@huawei.com>
> -- 
> 2.21.3
> 
> 

