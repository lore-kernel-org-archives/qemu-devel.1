Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F573C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 02:10:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 374BB206E6
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 02:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374BB206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIjsq-0005dD-Al
	for qemu-devel@archiver.kernel.org; Sun, 29 Mar 2020 22:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1jIjs9-00058M-9V
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 22:09:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1jIjs7-0004LZ-Ac
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 22:09:52 -0400
Received: from [192.146.154.243] (port=21189 helo=mcp01.nutanix.com)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1jIjs7-0004L1-5p
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 22:09:51 -0400
Received: from localhost.localdomain (unknown [10.40.36.165])
 by mcp01.nutanix.com (Postfix) with ESMTP id 00904100AD9D;
 Mon, 30 Mar 2020 02:09:48 +0000 (UTC)
Date: Wed, 25 Mar 2020 18:30:08 -0400
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] fix vhost_user_blk_watch crash
Message-ID: <20200325222930.GA14456@localhost.localdomain>
References: <20200323052924.29286-1-fengli@smartx.com>
 <20200329084911-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200329084911-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 192.146.154.243
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 29, 2020 at 09:30:24AM -0400, Michael S. Tsirkin wrote:
> 
> On Mon, Mar 23, 2020 at 01:29:24PM +0800, Li Feng wrote:
> > the G_IO_HUP is watched in tcp_chr_connect, and the callback
> > vhost_user_blk_watch is not needed, because tcp_chr_hup is registered as
> > callback. And it will close the tcp link.
> > 
> > Signed-off-by: Li Feng <fengli@smartx.com>
> 
> Raphael would you like to review this?

Sure - I'll review it now.

> Also, I think at this point
> nutanix is the biggest contributor to vhost user blk.
> So if you want to be added to MAINTAINERS on this
> one so people Cc you on patcches, that'd be great.
> 

Yes, please add me to MAINTAINERS.

 

