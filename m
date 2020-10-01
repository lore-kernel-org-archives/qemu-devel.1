Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8973BC47423
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:06:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECCAA206B6
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGF9PM98"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECCAA206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2yW-0000pj-0F
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 14:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kO2Ps-0002g7-RB; Thu, 01 Oct 2020 13:30:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38920)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kO2Pp-0004z6-De; Thu, 01 Oct 2020 13:30:52 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0C8872085B;
 Thu,  1 Oct 2020 17:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601573445;
 bh=M0nVfKA4hHFwDxCFHpx3AXw35cp8CwCQhDbIV5gAD/4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tGF9PM98gOS3xckwGsAC+pL3jhCLU1ClWt9vFChCJtEl+ikUPBkqEkRPTNdJ1XHWX
 MhMIMODBONxGj1tD7Z5Y+W7ciCOWbAW0yFQDCxUix4t3KnGT70ODhfIppFHsr7zLYv
 SWa5X++xskA2TcgOiSxa8k2XPOZJzdnH3K76MA08=
Date: Thu, 1 Oct 2020 10:30:43 -0700
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH 3/9] hw/block/nvme: support per-namespace smart log
Message-ID: <20201001173043.GA564827@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200930220414.562527-1-kbusch@kernel.org>
 <20200930220414.562527-4-kbusch@kernel.org>
 <20201001041057.GC681387@apples.localdomain>
 <20201001152055.GA3343@C02WT3WMHTD6>
 <20201001171837.GA792691@apples.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001171837.GA792691@apples.localdomain>
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

On Thu, Oct 01, 2020 at 07:18:37PM +0200, Klaus Jensen wrote:
> OK, so I agree that it makes sense for it to be supported on a per
> namespace basis, but I think the spec is just keeping the door open for
> future namespace specific stuff in the log page - currently there is
> none.
> 
> Figure 94 (the actual SMART log page) says that the Data Units
> Read/Written are controller wide, so there really is no namespace
> specific information. Maybe this could be in the context of shared
> namespaces? How would a controller know how much data has been
> read/written from it without asking the other controllers? What if a
> controller is detached from the namespace - you'd lose those numbers.

That text is wrong. There is no "controller" scope to the smart log.
Figure 191 says the smart scope is to the subsystem or the namespace. It
doesn't matter which controller performed an IO to a particular
namespace; the log needs to report the same information regardless of
which controller you query. How that is coordinated within the subsystem
is a detail not defined by spec.

Not that that particular detail matters here, as we don't support
multi-controller subsystems (yet!). But the smart log text has missed an
update to reflect this, so it looks like trivial ECN material to me.

