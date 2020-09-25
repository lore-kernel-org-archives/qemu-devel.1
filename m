Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2039DC4346E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 01:26:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC51920809
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 01:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvRw3Crj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC51920809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLcUt-0001wA-RW
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 21:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kLcTA-00089U-Pu; Thu, 24 Sep 2020 21:24:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43660)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kLcT7-0006Wk-CV; Thu, 24 Sep 2020 21:24:16 -0400
Received: from C02WT3WMHTD6 (rap-us.hgst.com [199.255.44.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5C291207C4;
 Fri, 25 Sep 2020 01:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600997050;
 bh=hYYEsTgmRC+XlDKmrT2udxPtV7eFEYI2buiygho9Lqo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OvRw3CrjJIxa0acdikirDjTwU34EeScYhVF9xrs/FW0Ex7SK/GFDbbxhFtwB++bIR
 hKDJfUkUNaw5rOlZlV2nf/vzym/6r45tnlECq4harpAZ3DVYy/cfpgXdlTa9o67OGO
 OHWHWw1utJfC0wk6rR8bXecuQKf8GCn517N3VHHs=
Date: Thu, 24 Sep 2020 19:24:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH 00/16] hw/block/nvme: zoned namespace command set
Message-ID: <20200925012407.GA5897@C02WT3WMHTD6>
References: <20200924204516.1881843-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924204516.1881843-1-its@irrelevant.dk>
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 21:24:10
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -82
X-Spam_score: -8.3
X-Spam_bar: --------
X-Spam_report: (-8.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 24, 2020 at 10:45:00PM +0200, Klaus Jensen wrote:
> Finally, I wrote this. I am *NOT* saying that this somehow makes it
> better, but as a maintainer, is a big deal to me since both series are
> arguably a lot of code to maintain and support (both series are about
> the same size). But - I am not the only maintainer, so if Keith (now
> suddenly placed in the grim role as some sort of arbiter) signs off on
> Dmitry's series, then so be it, I will rest my case.

I think it's neat there's enough interest in ZNS that we have multiple
solutions to consider.

I'm still catching up from virtual conferencing, but I should be able to have a
look over the weekend. I know everyone's put a lot of work into the development
of this capability, so maybe there's something to be taken from both? Not sure
yet if that's feasible, but I'll have a better idea on that later.

