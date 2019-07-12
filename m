Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E099CC742B0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 09:20:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B964421670
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 09:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B964421670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlrj8-0006BF-7M
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 05:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41150)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hlriw-0005en-FZ
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 05:20:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hlriv-0005G6-Cq
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 05:20:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37586)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hlrit-0005CW-1W; Fri, 12 Jul 2019 05:20:11 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 84CC185543;
 Fri, 12 Jul 2019 09:20:09 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E7CC19C58;
 Fri, 12 Jul 2019 09:20:07 +0000 (UTC)
Date: Fri, 12 Jul 2019 11:20:06 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190712092006.GA4514@dhcp-200-226.str.redhat.com>
References: <20190704124342.7753-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704124342.7753-1-mlevitsk@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 12 Jul 2019 09:20:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 0/1] Don't obey the kernel block device
 max transfer len / max segments for raw block devices
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
Cc: Fam Zheng <fam@euphon.net>, John Ferlan <jferlan@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 04.07.2019 um 14:43 hat Maxim Levitsky geschrieben:
> Linux block devices, even in O_DIRECT mode don't have any user visible
> limit on transfer size / number of segments, which underlying kernel block device can have.
> The kernel block layer takes care of enforcing these limits by splitting the bios.
> 
> By limiting the transfer sizes, we force qemu to do the splitting itself which
> introduces various overheads.
> It is especially visible in nbd server, where the low max transfer size of the
> underlying device forces us to advertise this over NBD, thus increasing the
> traffic overhead in case of image conversion which benefits from large blocks.
> 
> More information can be found here:
> https://bugzilla.redhat.com/show_bug.cgi?id=1647104
> 
> Tested this with qemu-img convert over nbd and natively and to my surprise,
> even native IO performance improved a bit.

Thanks, applied to the block branch.

Kevin

