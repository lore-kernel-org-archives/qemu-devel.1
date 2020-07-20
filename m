Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6429C433FC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:14:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 916482080D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="FixqSNwT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916482080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxRsZ-0007cr-RK
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 05:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jxRs0-00077R-LC; Mon, 20 Jul 2020 05:14:00 -0400
Received: from charlie.dont.surf ([128.199.63.193]:46634)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jxRrw-0000Uq-Ea; Mon, 20 Jul 2020 05:14:00 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 877D4BF5BE;
 Mon, 20 Jul 2020 09:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1595236432;
 bh=C9EYpa9zTMRY693LTDqVMbcxhcj1z7NXefHr4v4O1eQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FixqSNwTNb0/hVbnRtkRLpA8paN4UegiRP+HjpmG44vmiXceennacuAxwImjIMqE/
 w6meGQaUY6hnFNnsGKPNHFt+xTj9luZsZp04MvcaXrkTBtGSQpy3/8OzhVYbRrAICD
 Zsyk3hcicz4pYskVKg6p5AXEbodkaoOrJMVpB/q4zMYKJW5CwHk0lfOKSHHMKUITZF
 jbIVJ8CCQPPOfw3YQw7iyixU/oEqMtYiRgDrGvWOXutsy5HX0TmQoAtpiAFZDRogK7
 Bbd6nPJDL8m+JBqpEafKjNhZ98Syn/5HYLq/PPkmQ6VWnDfVw0Bfp7l7pugCl7Vv76
 X//lDUFyhd+Qg==
Date: Mon, 20 Jul 2020 11:13:48 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: Re: [PATCH v3 00/18] hw/block/nvme: bump to v1.3
Message-ID: <20200720091348.GA278838@apples.localdomain>
References: <20200706061303.246057-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200706061303.246057-1-its@irrelevant.dk>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 05:13:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul  6 08:12, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> This adds mandatory features of NVM Express v1.3 to the emulated NVMe
> device.
> 
> 
> v3:
>   * hw/block/nvme: additional tracing
>     - Reverse logic in nvme_cid(). (Philippe)
>     - Move nvme_cid() and nvme_sqid() to source file. (Philippe)
>   * hw/block/nvme: fix missing endian conversion
>     - Move this patch to very early in the series and fix the bug properly as
>       suggested by Philippe. Then let the change trickle down through
>       the series. (Philippe)
>   * hw/block/nvme: add remaining mandatory controller parameters
>     - Move the nvme_feature_{support,default} arrays to the source file.
>       (Philippe)
>     - Add a NVME_FID_MAX constant. (Philippe)
>   * hw/block/nvme: support the get/set features select and save fields
>     - Move the nvme_feature_cap array to the source file. (Philippe)
>   * hw/block/nvme: reject invalid nsid values in active namespace id list
>     - Rework the condition and add a comment and reference to the spec.
>       (Philippe)
>   * hw/block/nvme: provide the mandatory subnqn field
>     - Change to use strpadcpy(). (Philippe)
> 
>   Had to clear some R-b's due to functional changes.
> 
>   Missing review: 2, 3, 7, 12, 16, 17
> 
> 
> v2:
>   * hw/block/nvme: bump spec data structures to v1.3
>     - Shorten some constants. (Dmitry)
>   * hw/block/nvme: add temperature threshold feature
>     - Remove unused temp_thresh member. (Dmitry)
>   * hw/block/nvme: add support for the get log page command
>     - Change the temperature field in the NvmeSmartLog struct to be an
>       uint16_t and handle wierd alignment by adding QEMU_PACKED to the
>       struct. (Dmitry)
>   * hw/block/nvme: add remaining mandatory controller parameters
>     - Fix spelling. (Dmitry)
>   * hw/block/nvme: support the get/set features select and save fields
>     - Fix bad logic causing temperature thresholds to always report
>       defaults. (Dmitry)
>   * hw/block/nvme: reject invalid nsid values in active namespace id list
>     - Added patch; reject the 0xfffffffe and 0xffffffff nsid values.
> 
> 
> $ git-backport-diff -u for-master/bump-to-v1.3-v2 -r upstream/master... -S
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream patch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively
> 
> 001/18:[----] [--] 'hw/block/nvme: bump spec data structures to v1.3'
> 002/18:[0008] [FC] 'hw/block/nvme: fix missing endian conversion'
> 003/18:[0028] [FC] 'hw/block/nvme: additional tracing'
> 004/18:[----] [--] 'hw/block/nvme: add support for the abort command'
> 005/18:[0004] [FC] 'hw/block/nvme: add temperature threshold feature'
> 006/18:[----] [--] 'hw/block/nvme: mark fw slot 1 as read-only'
> 007/18:[----] [--] 'hw/block/nvme: add support for the get log page command'
> 008/18:[0002] [FC] 'hw/block/nvme: add support for the asynchronous event request command'
> 009/18:[----] [--] 'hw/block/nvme: move NvmeFeatureVal into hw/block/nvme.h'
> 010/18:[----] [--] 'hw/block/nvme: flush write cache when disabled'
> 011/18:[0044] [FC] 'hw/block/nvme: add remaining mandatory controller parameters'
> 012/18:[0024] [FC] 'hw/block/nvme: support the get/set features select and save fields'
> 013/18:[----] [--] 'hw/block/nvme: make sure ncqr and nsqr is valid'
> 014/18:[----] [--] 'hw/block/nvme: support identify namespace descriptor list'
> 015/18:[0008] [FC] 'hw/block/nvme: reject invalid nsid values in active namespace id list'
> 016/18:[----] [--] 'hw/block/nvme: enforce valid queue creation sequence'
> 017/18:[0006] [FC] 'hw/block/nvme: provide the mandatory subnqn field'
> 018/18:[----] [--] 'hw/block/nvme: bump supported version to v1.3'
> 
> 
> Klaus Jensen (18):
>   hw/block/nvme: bump spec data structures to v1.3
>   hw/block/nvme: fix missing endian conversion
>   hw/block/nvme: additional tracing
>   hw/block/nvme: add support for the abort command
>   hw/block/nvme: add temperature threshold feature
>   hw/block/nvme: mark fw slot 1 as read-only
>   hw/block/nvme: add support for the get log page command
>   hw/block/nvme: add support for the asynchronous event request command
>   hw/block/nvme: move NvmeFeatureVal into hw/block/nvme.h
>   hw/block/nvme: flush write cache when disabled
>   hw/block/nvme: add remaining mandatory controller parameters
>   hw/block/nvme: support the get/set features select and save fields
>   hw/block/nvme: make sure ncqr and nsqr is valid
>   hw/block/nvme: support identify namespace descriptor list
>   hw/block/nvme: reject invalid nsid values in active namespace id list
>   hw/block/nvme: enforce valid queue creation sequence
>   hw/block/nvme: provide the mandatory subnqn field
>   hw/block/nvme: bump supported version to v1.3
> 
>  block/nvme.c          |  18 +-
>  hw/block/nvme.c       | 676 ++++++++++++++++++++++++++++++++++++++++--
>  hw/block/nvme.h       |  22 +-
>  hw/block/trace-events |  27 +-
>  include/block/nvme.h  | 225 +++++++++++---
>  5 files changed, 892 insertions(+), 76 deletions(-)
> 
> -- 
> 2.27.0
> 
> 

Thanks for the reviews everyone, applied to nvme-next.


Klaus

