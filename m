Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1146FC4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:28:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 875E520719
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d92ybKuE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 875E520719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO0Uz-0005Am-Ka
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kO0OJ-0005a6-Kr; Thu, 01 Oct 2020 11:21:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48950)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kO0OG-0000Y7-0B; Thu, 01 Oct 2020 11:21:07 -0400
Received: from C02WT3WMHTD6 (rap-us.hgst.com [199.255.44.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 10A2120719;
 Thu,  1 Oct 2020 15:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601565658;
 bh=3OsuHrfbiVTzoXfB6OAlPuJ13vF8R2so8Qz/EgjMbMc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d92ybKuEYPFEKEhTxj69fNoEBHm2ZMHHY0C3u2rYZLuz+JT2LLEsmp/mUzWhS/NQi
 dROQtCbVOXgKCkdXgIIw3Olw9pY3p9VHUdpCuEafOMeC14gnxHz8o0U2WBzZLnxZm6
 fLmlzwq9V0IQoeVezUKAo/S+Wu2GmjIdbafBnt7g=
Date: Thu, 1 Oct 2020 09:20:55 -0600
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH 3/9] hw/block/nvme: support per-namespace smart log
Message-ID: <20201001152055.GA3343@C02WT3WMHTD6>
References: <20200930220414.562527-1-kbusch@kernel.org>
 <20200930220414.562527-4-kbusch@kernel.org>
 <20201001041057.GC681387@apples.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001041057.GC681387@apples.localdomain>
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

On Thu, Oct 01, 2020 at 06:10:57AM +0200, Klaus Jensen wrote:
> On Sep 30 15:04, Keith Busch wrote:
> > Let the user specify a specific namespace if they want to get access
> > stats for a specific namespace.
> > 
> 
> I don't think this makes sense for v1.3+.
> 
> NVM Express v1.3d, Section 5.14.1.2: "There is no namespace specific
> information defined in the SMART / Health log page in this revision of
> the specification.  therefore the controller log page and namespace
> specific log page contain identical information".
> 
> I have no idea why the TWG decided this, but that's the way it is ;)

I don't think they did that. The behavior you're referring to is specific to
controllers that operate a particular way: "If the log page is not supported on
a per namespace basis ...". They were trying to provide a spec compliant way
for controllers to return a success status if you supplied a valid NSID when
the controller doesn't support per-namespace smart data..

The previous paragraph is more clear on this: "The controller may also support
requesting the log page on a per namespace basis, as indicated by bit 0 of the
LPA field in the Identify Controller data structure".

