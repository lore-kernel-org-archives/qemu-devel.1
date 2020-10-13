Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68929C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 17:49:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFE7225381
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 17:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0MIPntTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE7225381
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSOQZ-0001Uh-NF
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 13:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kSOPa-0000x1-TG; Tue, 13 Oct 2020 13:48:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59142)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kSOPY-0004Vz-Ry; Tue, 13 Oct 2020 13:48:34 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9012B2537C;
 Tue, 13 Oct 2020 17:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602611309;
 bh=WT6cXp50w5XmLCcyf3h9gqNsXSNCCrTDL7BZB9qNcIc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=0MIPntTJsoygjtisK54nct2VmUvR25OmnAiVMC+AzRqLOX9rVE2aMcO6YTs039uTs
 ymvFvlSL9wVDNR7z3ZUIZzQJAwgm7n7X/EkoyQKka0XRJujHPT9pPsAiTu54MsZXGO
 /i517GSMVZyhpD+FO5HogMoWcz/09lRWakeOtIiw=
Date: Tue, 13 Oct 2020 10:48:26 -0700
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH 0/9] nvme qemu cleanups and fixes
Message-ID: <20201013174826.GA1049145@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200930220414.562527-1-kbusch@kernel.org>
 <20201013090401.GC168093@apples.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013090401.GC168093@apples.localdomain>
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 13:48:29
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

On Tue, Oct 13, 2020 at 11:04:01AM +0200, Klaus Jensen wrote:
> On Sep 30 15:04, Keith Busch wrote:
> > After going through the zns enabling, I notice the controller enabling
> > is not correct. Then I just continued maked more stuff. The series, I
> > think, contains some of the less controversial patches from the two
> > conflicting zns series, preceeded by some cleanups and fixes from me.
> > 
> > If this is all fine, I took the liberty of porting the zns enabling to
> > it and made a public branch for consideration here:
> > 
> >  http://git.infradead.org/qemu-nvme.git/shortlog/refs/heads/kb-zns 
> > 
> > Dmitry Fomichev (1):
> >   hw/block/nvme: report actual LBA data shift in LBAF
> > 
> > Keith Busch (5):
> >   hw/block/nvme: remove pointless rw indirection
> >   hw/block/nvme: fix log page offset check
> >   hw/block/nvme: support per-namespace smart log
> >   hw/block/nvme: validate command set selected
> >   hw/block/nvme: support for admin-only command set
> > 
> > Klaus Jensen (3):
> >   hw/block/nvme: reject io commands if only admin command set selected
> >   hw/block/nvme: add nsid to get/setfeat trace events
> >   hw/block/nvme: add trace event for requests with non-zero status code
> > 
> >  hw/block/nvme-ns.c    |   5 ++
> >  hw/block/nvme.c       | 194 ++++++++++++++++++++----------------------
> >  hw/block/trace-events |   6 +-
> >  include/block/nvme.h  |  11 +++
> >  4 files changed, 114 insertions(+), 102 deletions(-)
> > 
> > -- 
> > 2.24.1
> > 
> > 
> 
> These fixes all look good to me apart from the odd fixes that has been
> mentioned in the reviews. Since soft freeze is only two weeks away (Oct
> 27th), it would be nice to get this staged on nvme-next so we can get a
> pull sent off to Peter.

I've fixed up the comments mentioned and added the received reviews.
Since it was pretty trivial fixups and passes my basic santify tests, I
went ahead and pushed to nvme-next.

