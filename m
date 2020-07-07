Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5387C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 06:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E1E7206F6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 06:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1E7206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jshS8-0003du-RB
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 02:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jshQj-00027j-TH; Tue, 07 Jul 2020 02:50:15 -0400
Received: from charlie.dont.surf ([128.199.63.193]:59916)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jshQc-00014Z-4T; Tue, 07 Jul 2020 02:50:12 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 0E55FBF5EE;
 Tue,  7 Jul 2020 06:50:03 +0000 (UTC)
Date: Tue, 7 Jul 2020 08:49:59 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: update nvme entry
Message-ID: <20200707064959.GA470656@apples.localdomain>
References: <20200706194342.1996219-1-kbusch@kernel.org>
 <105bd6d0-a67b-e8d2-5a13-27e0f5c81472@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <105bd6d0-a67b-e8d2-5a13-27e0f5c81472@redhat.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 02:16:09
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Keith Busch <kbusch@kernel.org>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul  7 08:30, Philippe Mathieu-Daudé wrote:
> On 7/6/20 9:43 PM, Keith Busch wrote:
> > The nvme emulated device development pace has increased recently.  Klaus
> > has offered to co-maintain, and since we have many new contributions
> > coming through, we're adding a repository to accumulate and test new
> > features.
> 
> Thanks Klaus for helping!
> 
> > 
> > Cc: Klaus Jensen <its@irrelevant.dk>
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > ---
> >  MAINTAINERS | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c31c878c63..fbeba04dc5 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1793,10 +1793,12 @@ F: include/hw/virtio/virtio-crypto.h
> >  
> >  nvme
> >  M: Keith Busch <kbusch@kernel.org>
> > +M: Klaus Jensen <its@irrelevant.dk>
> 
> Is that the correct email you want to use?
> 

Yes that is correct. I prefer getting CC'ed on that address, but yes, I
sign off with and use my @samsung.com address for commits.

> Regardless:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> >  L: qemu-block@nongnu.org
> >  S: Supported
> >  F: hw/block/nvme*
> >  F: tests/qtest/nvme-test.c
> > +T: git git://git.infradead.org/qemu-nvme.git nvme-next
> >  
> >  megasas
> >  M: Hannes Reinecke <hare@suse.com>
> > 
> 
> 

