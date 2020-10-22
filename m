Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F15C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 00:56:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E552237B
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 00:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTuIPghJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E552237B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVOuB-0001mT-GT
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 20:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kVOsw-0001BS-C7; Wed, 21 Oct 2020 20:55:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55988)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kVOsu-0001Pu-5M; Wed, 21 Oct 2020 20:55:17 -0400
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C72DC223BF;
 Thu, 22 Oct 2020 00:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603328112;
 bh=2aTgrS69UdITPw362V+vA0dwNlb8wCzQ+cJnJLP5W+s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JTuIPghJYGf0OmJlkfcVj3Gadf+jIf4umGRnz1/tF2yXGWOYTrjm4+/g7fouZfb7M
 Tp7/HnuPUhnPMrF6O5QOl/QwKl6dJKnq2Wyfv4oA5ZaDYVV0zi8hyIR8HRGPasZyGR
 1WXSjakJrGdHe731ELKLi0MHfbgz/7R1sVb1M5uw=
Date: Wed, 21 Oct 2020 17:55:09 -0700
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v3 1/2] hw/block/nvme: add dulbe support
Message-ID: <20201022005509.GA1663557@dhcp-10-100-145-180.wdc.com>
References: <20201021221736.100779-1-its@irrelevant.dk>
 <20201021221736.100779-2-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021221736.100779-2-its@irrelevant.dk>
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 20:55:12
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 22, 2020 at 12:17:35AM +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Add support for reporting the Deallocated or Unwritten Logical Block
> Error (DULBE).
> 
> Rely on the block status flags reported by the block layer and consider
> any block with the BDRV_BLOCK_ZERO flag to be deallocated.
> 
> Multiple factors affect when a Write Zeroes command result in
> deallocation of blocks.
> 
>   * the underlying file system block size
>   * the blockdev format
>   * the 'discard' and 'logical_block_size' parameters
> 
>      format | discard | wz (512b)  wz (4kb)  wz (64kb)
>     ---------------------------------------------------
>       qcow2    ignore   n          n         y
>       qcow2    unmap    n          n         y
>       raw      ignore   n          y         y
>       raw      unmap    n          y         y
> 
> So, this works best with an image in raw format and 4kb LBAs, since
> holes can then be punched on a per-block basis (this assumes a file
> system with a 4kb block size, YMMV). A qcow2 image, uses a cluster size
> of 64kb by default and blocks will only be marked deallocated if a full
> cluster is zeroed or discarded. However, this *is* consistent with the
> spec since Write Zeroes "should" deallocate the block if the Deallocate
> attribute is set and "may" deallocate if the Deallocate attribute is not
> set. Thus, we always try to deallocate (the BDRV_REQ_MAY_UNMAP flag is
> always set).

This looks fine. The constraints sound reasonable to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

