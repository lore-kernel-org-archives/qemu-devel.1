Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE258C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:10:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22BB5239D2
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qt5mtKwC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22BB5239D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX54h-0002cB-LH
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 12:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kX4yE-00042r-79; Mon, 26 Oct 2020 12:03:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:60778)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kX4yB-0005wn-Gz; Mon, 26 Oct 2020 12:03:41 -0400
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E88BD22409;
 Mon, 26 Oct 2020 16:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603728216;
 bh=BKnBFFMi1F3OcmRVjJGk2Hco0RFEVTeV52UgmJCm19Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Qt5mtKwCNj9dETWvBFfkNZuAR94UQljNz7wUJNQW5OUweQlUniXcrDYYdlnFXIyW2
 Agf5/z9Ay8aLYMBMWuSfpnyVt+1y/M6PytBevM9E4N3BcX29dh+/0uAfC1TJBISZqz
 3ZyQ9g5QsL6ABwTGSwtplbuXdQzr91DcN+VYPCPU=
Date: Mon, 26 Oct 2020 09:03:34 -0700
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v6 3/3] hw/block/nvme: add the dataset management command
Message-ID: <20201026160334.GA1940105@dhcp-10-100-145-180.wdc.com>
References: <20201026060101.371900-1-its@irrelevant.dk>
 <20201026060101.371900-4-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026060101.371900-4-its@irrelevant.dk>
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 12:03:36
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

On Mon, Oct 26, 2020 at 07:01:01AM +0100, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Add support for the Dataset Management command and the Deallocate
> attribute. Deallocation results in discards being sent to the underlying
> block device. Whether of not the blocks are actually deallocated is
> affected by the same factors as Write Zeroes (see previous commit).
> 
>      format | discard | dsm (512B)  dsm (4KiB)  dsm (64KiB)
>     --------------------------------------------------------
>       qcow2    ignore   n           n           n
>       qcow2    unmap    n           n           y
>       raw      ignore   n           n           n
>       raw      unmap    n           y           y
> 
> Again, a raw format and 4KiB LBAs are preferable.
> 
> In order to set the Namespace Preferred Deallocate Granularity and
> Alignment fields (NPDG and NPDA), choose a sane minimum discard
> granularity of 4KiB. If we are using a passthru device supporting
> discard at a 512B granularity, user should set the discard_granularity
> property explicitly. NPDG and NPDA will also account for the
> cluster_size of the block driver if required (i.e. for QCOW2).
> 
> See NVM Express 1.3d, Section 6.7 ("Dataset Management command").
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>

Looks fine

Reviewed-by: Keith Busch <kbusch@kernel.org>

