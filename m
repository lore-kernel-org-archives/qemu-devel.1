Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49862C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 07:10:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 164DF20735
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 07:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164DF20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY2Zz-0003Ld-3a
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 03:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jY2ZM-0002UB-51; Mon, 11 May 2020 03:09:44 -0400
Received: from charlie.dont.surf ([128.199.63.193]:38478)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jY2ZK-0000Ij-I4; Mon, 11 May 2020 03:09:43 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 0BE6CBF5B8;
 Mon, 11 May 2020 07:09:40 +0000 (UTC)
Date: Mon, 11 May 2020 09:09:36 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v5 00/18] nvme: refactoring and cleanups
Message-ID: <20200511070936.fxarxicz7zrj6mop@apples.localdomain>
References: <20200505054840.186586-1-its@irrelevant.dk>
 <20200511062513.3axdfcmr4izulv5x@apples.localdomain>
 <095f3c9b-5b32-7a88-03e9-ca993ca3f3c9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <095f3c9b-5b32-7a88-03e9-ca993ca3f3c9@redhat.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 02:25:18
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 11 09:00, Philippe Mathieu-Daudé wrote:
> Hi Klaus,
> 
> On 5/11/20 8:25 AM, Klaus Jensen wrote:
> > On May  5 07:48, Klaus Jensen wrote:
> > > From: Klaus Jensen <k.jensen@samsung.com>
> > > 
> > > Changes since v5
> > > ~~~~~~~~~~~~~~~~
> > > No functional changes, just updated Reviewed-by tags. Also, I screwed up
> > > the CC list when sending v4.
> > > 
> > > Philippe and Keith, please add a Reviewed-by to
> > > 
> > >    * "nvme: factor out pmr setup" and
> > >    * "do cmb/pmr init as part of pci init"
> > > 
> > > since the first one was added and the second one was changed in v4 when
> > > rebasing on Kevins block-next tree which had the PMR work that was not
> > > in master at the time.
> > > 
> > > With those in place, it should be ready for Kevin to merge.
> > > 
> > Gentle ping on this.
> > 
> > Also, please see the two patches in "[PATCH 0/2] hw/block/nvme: fixes
> > for interrupt behavior". I think they should go in preparation to this
> > series.
> 
> I was going to ping Kevin last week, but then read your comment on pach #7
> "nvme: add max_ioqpairs device parameter", so I interpreted you would
> respin.
> Now it is clearer, applying in the following order you don't need to respin,
> right?
> 
> - [PATCH 0/2] hw/block/nvme: fixes for interrupt behavior"
> - [PATCH v5 00/18] nvme: refactoring and cleanups
> 

Ugh. "[PATCH v5 00/18] nvme: refactoring and cleanups" doesn't apply
completely cleanly.

"[PATCH 0/2] hw/block/nvme: fixes for interrupt behavior" was intented
to go into master because it fixes a bug, that is why I split them up.

But looks like it is better to just roll it into this series. I'll
respin a v6 with the two interrupt fixes.

