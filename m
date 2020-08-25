Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06603C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 22:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E087F2075E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 22:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vdcfXxU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E087F2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAhQs-0006ef-3u
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 18:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>) id 1kAhQN-0006E8-6y
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 18:28:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38512)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>) id 1kAhQL-00049O-8L
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 18:28:14 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [129.253.182.57])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 10E2C2075E;
 Tue, 25 Aug 2020 22:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598394491;
 bh=11PlzHXEG75kRjlL+PHq1+tOM7Ods96wocSFW6weJR0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vdcfXxU335vq/e61b8S7vpT2VePmm/++6SJV9iTtb5ZwVOc4MDXJIMsgUHQ3qHrau
 0NV8aDfyPg5CqKLwxsMW63KJXffKI7gaLyDx3gUT3ibOTYnVhb1VfpDAMQHh/M4UMv
 Muome3iKcVq+EjSoe9oqI+b+BQovMHGQrhsmH81s=
Date: Wed, 26 Aug 2020 07:28:04 +0900
From: Keith Busch <kbusch@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL] nvme updates
Message-ID: <20200825222804.GB20971@redsun51.ssa.fujisawa.hgst.com>
References: <20200819192240.GA25305@dhcp-10-100-145-180.wdl.wdc.com>
 <CAFEAcA8-VgEDTZ7+T9ZgB2LR9KWRrejBtZN=iwy2GGPcuFuz2Q@mail.gmail.com>
 <20200825201242.GA20971@redsun51.ssa.fujisawa.hgst.com>
 <CAFEAcA-SD1WMODNzZpJkq_39bk72Gf+XFhCKWEDjTb0Lvdfe9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-SD1WMODNzZpJkq_39bk72Gf+XFhCKWEDjTb0Lvdfe9g@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 18:28:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -80
X-Spam_score: -8.1
X-Spam_bar: --------
X-Spam_report: (-8.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
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
 QEMU Developers <qemu-devel@nongnu.org>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 25, 2020 at 10:43:23PM +0100, Peter Maydell wrote:
> On Tue, 25 Aug 2020 at 21:12, Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Sun, Aug 23, 2020 at 02:56:12PM +0100, Peter Maydell wrote:
> > > Hi; it looks like this isn't a gpg-signed tag?
> > >
> > > error: remotes/nvme/nvme-next: cannot verify a non-tag object of type commit.
> >
> > Oops, sorry I forgot about that part of the procedure here. The repo should
> > have a signed tag now:
> 
> Thanks; the gpg key setup looks ok.
> 
> I notice that all the commits in the repo have Klaus's signed-off-by.
> Usually the expectation is that the person who sends the pull req
> is the one who's curated the tree and added their signed-off-by,
> but are you doing a jointly-administered tree here ?

Right, Klaus is the primary committer for our joint repository, and I
added his info to the MAINTAINERS file in the first commit of this pull.
Since he's not currently listed upstream, I thought it made sense to
make the introduction here. We'll coordinate pull requests as you've
described going forward.
 
> The build has a format string issue that shows up on OSX, Windows,
> and 32-bit builds:

Sorry about that, we'll fix it up ASAP.

> In file included from ../../hw/block/trace.h:1:0,
>                  from ../../hw/block/fdc.c:48:
> ./trace/trace-hw_block.h: In function '_nocheck__trace_pci_nvme_err_mdts':
> ./trace/trace-hw_block.h:2162:18: error: format '%llu' expects
> argument of type 'long long unsigned int', but argument 6 has type
> 'size_t {aka unsigned int}' [-Werror=format=]
>          qemu_log("%d@%zu.%06zu:pci_nvme_err_mdts " "cid %"PRIu16" len
> %"PRIu64"" "\n",
>                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> thanks
> -- PMM

