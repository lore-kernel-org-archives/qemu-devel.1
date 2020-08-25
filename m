Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6142C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 20:13:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7800F2075F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 20:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5sUGAv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7800F2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAfJy-0001SZ-N7
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 16:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>) id 1kAfJM-00011I-GP
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 16:12:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36022)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>) id 1kAfJK-0004V9-Ol
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 16:12:52 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [129.253.182.57])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 951DA20738;
 Tue, 25 Aug 2020 20:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598386368;
 bh=nC54vfxMgN4S1vCM/o+DtvkyJpgPoRNtf9GGtwyhZ9A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=o5sUGAv2BbSNBJByAOFchXh7o0u3FaEwro8Y1PbYh3DsEOtIK0Uxz2mGICJlbooRU
 w3RCE1bH+vLVFhJa45XP6N/XT9rGPJO6CgezgrQEctYpiYa1wwil8Tktimn8oBVdy4
 iYT0IyO076w1KYYgbzLPT2gwoVLSxTroeTHg+6h0=
Date: Wed, 26 Aug 2020 05:12:42 +0900
From: Keith Busch <kbusch@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL] nvme updates
Message-ID: <20200825201242.GA20971@redsun51.ssa.fujisawa.hgst.com>
References: <20200819192240.GA25305@dhcp-10-100-145-180.wdl.wdc.com>
 <CAFEAcA8-VgEDTZ7+T9ZgB2LR9KWRrejBtZN=iwy2GGPcuFuz2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8-VgEDTZ7+T9ZgB2LR9KWRrejBtZN=iwy2GGPcuFuz2Q@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 16:12:48
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

On Sun, Aug 23, 2020 at 02:56:12PM +0100, Peter Maydell wrote:
> On Wed, 19 Aug 2020 at 20:23, Keith Busch <kbusch@kernel.org> wrote:
> >
> > We're trying our first nvme pull request from a dedicated development
> > tree containing various fixes, cleanups, spec compliance, and welcoming
> > Klaus Jensen to maintaining the emulated nvme device development.
> >
> > The following changes since commit d0ed6a69d399ae193959225cdeaa9382746c91cc:
> >
> >   Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://git.infradead.org/qemu-nvme.git nvme-next
> 
> Hi; it looks like this isn't a gpg-signed tag?
> 
> error: remotes/nvme/nvme-next: cannot verify a non-tag object of type commit.

Oops, sorry I forgot about that part of the procedure here. The repo should
have a signed tag now:

The following changes since commit d0ed6a69d399ae193959225cdeaa9382746c91cc:

  Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)

are available in the Git repository at:

  git://git.infradead.org/qemu-nvme.git tags/for-upstream

for you to fetch changes up to 9257c77e4f0feaefb76f02fff3dc8d60b420ea4d:

  hw/block/nvme: remove explicit qsg/iov parameters (2020-08-17 08:40:54 +0200)

