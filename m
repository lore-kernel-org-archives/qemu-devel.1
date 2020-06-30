Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD62C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:49:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E0B0206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E0B0206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqBxR-0007Yi-O4
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 04:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqBuo-0004kI-I6; Tue, 30 Jun 2020 04:46:54 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47438)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqBul-0008Vw-Eg; Tue, 30 Jun 2020 04:46:54 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id D79B5BF676;
 Tue, 30 Jun 2020 08:46:48 +0000 (UTC)
Date: Tue, 30 Jun 2020 10:46:45 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] hw/block/nvme: Align I/O BAR to 4 KiB
Message-ID: <20200630084645.f53iwkmpbewnhilk@apples.localdomain>
References: <20200625154834.367-1-philmd@redhat.com>
 <20200625182326.ookc3e6rpbcypuj3@apples.localdomain>
 <a186c461-7af3-371a-f82f-7dc3ced0ea84@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a186c461-7af3-371a-f82f-7dc3ced0ea84@redhat.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 04:46:49
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 30 10:35, Philippe Mathieu-Daudé wrote:
> Hi Klaus,
> 
> On 6/25/20 8:23 PM, Klaus Jensen wrote:
> > On Jun 25 17:48, Philippe Mathieu-Daudé wrote:
> >> Simplify the NVMe emulated device by aligning the I/O BAR to 4 KiB.
> >>
> >> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> >> ---
> >>  include/block/nvme.h | 3 +++
> >>  hw/block/nvme.c      | 5 ++---
> >>  2 files changed, 5 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/block/nvme.h b/include/block/nvme.h
> >> index 1720ee1d51..6d87c9c146 100644
> >> --- a/include/block/nvme.h
> >> +++ b/include/block/nvme.h
> >> @@ -22,6 +22,8 @@ typedef struct NvmeBar {
> >>      uint32_t    pmrebs;
> >>      uint32_t    pmrswtp;
> >>      uint32_t    pmrmsc;
> >> +    uint32_t    reserved[58];
> >> +    uint8_t     cmd_set_specfic[0x100];
> >>  } NvmeBar;
> > 
> > This ends up as a freak mix of v1.3 and v1.4 specs. Since we already
> > have the PMR stuff in there, I think it makes more sense to align with
> > v1.4 and remove the reserved bytes.
> 
> I'm sorry but I don't understand what you'd prefer, removing the
> cmd_set_specfic[] for v1.3 and instead use this?
> 
>       uint32_t    pmrmsc;
>  +    uint32_t    reserved[122];
>   } NvmeBar;
> 
> Or this?
> 
>       uint32_t    pmrmsc;
>  +    uint8_t     reserved[488];
>   } NvmeBar;
> 

Yes, the second one.

But it should be 484 bytes reserved and the bug is in the pmrmsc field
that should be uint64_t. Can you fix that as well?  :)

