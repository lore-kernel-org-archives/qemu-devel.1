Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D651C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 05:42:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 338F12067D
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 05:42:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 338F12067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hshNK-0003Ds-F6
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 01:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57156)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dovgaluk@ispras.ru>) id 1hshMu-0002ny-Dv
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 01:41:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1hshMt-0003nv-Du
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 01:41:44 -0400
Received: from mail.ispras.ru ([83.149.199.45]:39762)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1hshMr-0003kE-FA
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 01:41:43 -0400
Received: from PASHAISP (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id E5C4554006A;
 Wed, 31 Jul 2019 08:41:35 +0300 (MSK)
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
To: "'Kevin Wolf'" <kwolf@redhat.com>, "'Paolo Bonzini'" <pbonzini@redhat.com>
References: <156395778867.510.17588721322993616668.stgit@pasha-Precision-3630-Tower>
 <83f7a43a-3039-0ac2-e7c7-5e802811d431@redhat.com>
 <20190725084453.GA8294@linux.fritz.box>
In-Reply-To: <20190725084453.GA8294@linux.fritz.box>
Date: Wed, 31 Jul 2019 08:41:37 +0300
Message-ID: <000001d54762$9f61ede0$de25c9a0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdVCxUAtlqanUL3pQAaL+B91K4mnygEnSShw
Content-Language: ru
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: Re: [Qemu-devel] [PATCH for-4.2 00/14] Some record/replay fixes
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
Cc: peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru,
 crosthwaite.peter@gmail.com, ciro.santilli@gmail.com, jasowang@redhat.com,
 quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 alex.bennee@linaro.org, 'Pavel Dovgalyuk' <pavel.dovgaluk@gmail.com>,
 maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com,
 boost.lists@gmail.com, thomas.dullien@googlemail.com, mreitz@redhat.com,
 artem.k.pisarenko@gmail.com, dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Kevin Wolf [mailto:kwolf@redhat.com]
> Am 24.07.2019 um 16:35 hat Paolo Bonzini geschrieben:
> > On 24/07/19 10:43, Pavel Dovgalyuk wrote:
> > > The set of patches include the latest fixes for record/replay icount function:
> > >  - fix for icount for the case when translation blocks are chained
> > >  - block operation fixes for rr mode
> > >  - development documentation update
> > >  - some refactoring
> > >
> > > These patches make record/replay functional on the latest 4.2 QEMU core.
> >
> > Please separate patches 1 and 9-14, I can merge those.
> 
> The block related parts have my Acked-by and the rest looks a bit like
> no man's land, so I think you could just take the whole series.

Paolo, I've sent the rest of the patches as a separate series.
But they are rebased upon the first series.
Since Kevin agreed to merge them, can you put them in your queue?

Pavel Dovgalyuk


