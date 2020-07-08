Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C003C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:04:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 421AF206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZKVTT/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 421AF206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtDUY-00064E-FL
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 13:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1jtDTt-0005OA-9T; Wed, 08 Jul 2020 13:03:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:54700)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1jtDTr-0002RI-Nk; Wed, 08 Jul 2020 13:03:36 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A0295206F6;
 Wed,  8 Jul 2020 17:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594227813;
 bh=qT0Fgh78zjvkP+NMKJGCy2cy29885pz+LcvIogHAdMs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kZKVTT/Gd0KStOhSUIlrjM4XmYbpqDHajeZozeYI0duBbXbDb6yqhVmkRqYrO7poH
 nDfnw4OtLomenOQa+h2C5iD7gmeeZ7AXb6AY6CcC9MQkfPIl2Qi1p8mhjatfn7xS+F
 R7U651qQx1lUp7XpKzuJjhZG5r6rJlJyXze9Y8Rs=
Date: Wed, 8 Jul 2020 10:03:30 -0700
From: Keith Busch <kbusch@kernel.org>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: update nvme entry
Message-ID: <20200708170330.GA2288218@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200706194342.1996219-1-kbusch@kernel.org>
 <20200707152613.GD7002@linux.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707152613.GD7002@linux.fritz.box>
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 13:03:33
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -80
X-Spam_score: -8.1
X-Spam_bar: --------
X-Spam_report: (-8.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
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
Cc: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 07, 2020 at 05:26:13PM +0200, Kevin Wolf wrote:
> Am 06.07.2020 um 21:43 hat Keith Busch geschrieben:
> > The nvme emulated device development pace has increased recently.  Klaus
> > has offered to co-maintain, and since we have many new contributions
> > coming through, we're adding a repository to accumulate and test new
> > features.
> > 
> > Cc: Klaus Jensen <its@irrelevant.dk>
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> 
> I assume that you'll merge this as the first thing through your new
> tree, so instead of applying, I'll just add:

Thanks, I've started the new branch with this as the first commit. We'll
wait at least a few more days to see if we've agreement on new patches
before sending our pull request.

