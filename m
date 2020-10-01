Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565A2C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:29:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4D3520872
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsJOfMDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D3520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO0WQ-0006Q6-W2
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kO0Rr-0002ia-SZ; Thu, 01 Oct 2020 11:24:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52158)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kO0Ro-00014B-Ru; Thu, 01 Oct 2020 11:24:47 -0400
Received: from C02WT3WMHTD6 (rap-us.hgst.com [199.255.44.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B209620672;
 Thu,  1 Oct 2020 15:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601565882;
 bh=BzgdtIJASNmF7F2/xPKdF6MTvbrfvc6BUt8uujR44XQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nsJOfMDfV3Sj4YrrWD2XQr4AVRKbD1Ux2FhZnncyWlIGyN3AZSsMS96xrwypGztjP
 50K2GSG1Ii15mKh2H6GK0FajBkefLk9zrpr4lmOkgmofX6N+ImpsanpyyaN2cq3BQv
 CJ1GXuBMjTHLoxJ2MCjGLRW1HfcU7FSCJDAIHhrk=
Date: Thu, 1 Oct 2020 09:24:39 -0600
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH 1/9] hw/block/nvme: remove pointless rw indirection
Message-ID: <20201001152439.GB3343@C02WT3WMHTD6>
References: <20200930220414.562527-1-kbusch@kernel.org>
 <20200930220414.562527-2-kbusch@kernel.org>
 <20201001040508.GA681387@apples.localdomain>
 <20201001084803.GA688151@apples.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001084803.GA688151@apples.localdomain>
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 11:20:58
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
Cc: Kevin Wolf <kwolf@redhat.com>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 01, 2020 at 10:48:03AM +0200, Klaus Jensen wrote:
> On Oct  1 06:05, Klaus Jensen wrote:
> > On Sep 30 15:04, Keith Busch wrote:
> > > The code switches on the opcode to invoke a function specific to that
> > > opcode. There's no point in consolidating back to a common function that
> > > just switches on that same opcode without any actual common code.
> > > Restore the opcode specific behavior without going back through another
> > > level of switches.
> > > 
> > > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > 
> > Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
> > 
> > Point taken. I could've sweared I had a better reason for this.
> > 
> 
> Can you also remove the nvme_do_aio trace event?

Ah, thanks for pointing that out. I'll fix up the trace.

I think you may have a case where this might make sense still in the making? If
so we can reevaluate when it's ready.

