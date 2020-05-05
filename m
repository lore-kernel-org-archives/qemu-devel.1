Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EF0C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 20:53:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CF51206B8
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 20:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF51206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW4Zd-00068k-CM
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 16:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jW4Yk-0005bS-Va; Tue, 05 May 2020 16:52:59 -0400
Received: from charlie.dont.surf ([128.199.63.193]:57608)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jW4Yi-0007G9-O6; Tue, 05 May 2020 16:52:58 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id BBE52BF627;
 Tue,  5 May 2020 20:52:53 +0000 (UTC)
Date: Tue, 5 May 2020 22:52:50 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: Re: [PATCH v5 07/18] nvme: add max_ioqpairs device parameter
Message-ID: <20200505205250.fvd5ox3dpd3i35b4@apples.localdomain>
References: <20200505054840.186586-1-its@irrelevant.dk>
 <20200505054840.186586-8-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200505054840.186586-8-its@irrelevant.dk>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 16:36:30
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May  5 07:48, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> The num_queues device paramater has a slightly confusing meaning because
> it accounts for the admin queue pair which is not really optional.
> Secondly, it is really a maximum value of queues allowed.
> 
> Add a new max_ioqpairs parameter that only accounts for I/O queue pairs,
> but keep num_queues for compatibility.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> ---
>  hw/block/nvme.c | 51 ++++++++++++++++++++++++++++++-------------------
>  hw/block/nvme.h |  3 ++-
>  2 files changed, 33 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 623a88be93dc..3875a5f3dcbf 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1571,7 +1581,8 @@ static Property nvme_props[] = {
>                       HostMemoryBackend *),
>      DEFINE_PROP_STRING("serial", NvmeCtrl, params.serial),
>      DEFINE_PROP_UINT32("cmb_size_mb", NvmeCtrl, params.cmb_size_mb, 0),
> -    DEFINE_PROP_UINT32("num_queues", NvmeCtrl, params.num_queues, 64),
> +    DEFINE_PROP_UINT32("num_queues", NvmeCtrl, params.num_queues, 0),
> +    DEFINE_PROP_UINT32("max_ioqpairs", NvmeCtrl, params.max_ioqpairs, 64),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  

I noticed that this default of 64 makes the default configuration
unsafe by allowing the cq->cqid < 64 assert in nvme_irq_{,de}assert() to
trigger if the pin-based interrupt logic is used (under SPDK for
instance). The assert protects against undefined behavior caused by
shifting by more than 63 into the 64 bit irq_status variable.

As far as I can tell, the assert, the shift and the size of the
irq_status variable is bogus, so I posted a patch for this in
"hw/block/nvme: fixes for interrupt behavior". Preferably that should go
in before this series.

