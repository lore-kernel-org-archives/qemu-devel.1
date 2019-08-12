Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCA3C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 15:49:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C69D20679
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 15:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C69D20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxCZj-00031T-PP
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 11:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47849)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.williamson@redhat.com>) id 1hxCYh-0002A7-4N
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:48:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1hxCYg-0003nJ-3O
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:48:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4267)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1hxCYf-0003mX-UL
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:48:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ECBF9309DF03;
 Mon, 12 Aug 2019 15:48:28 +0000 (UTC)
Received: from x1.home (ovpn-116-99.phx2.redhat.com [10.3.116.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F33A802EC;
 Mon, 12 Aug 2019 15:48:15 +0000 (UTC)
Date: Mon, 12 Aug 2019 09:48:14 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190812094814.24ad5c80@x1.home>
In-Reply-To: <CAFEAcA-PxgCZzMJu8favVEP3x+DX3208TfChsu17fYCkibGg2w@mail.gmail.com>
References: <20190812065221.20907-1-kraxel@redhat.com>
 <aec51679-b766-5773-86cb-9ebd06a8cb49@redhat.com>
 <c4b30dfe-83d7-f1e0-d868-82791d56d6b6@redhat.com>
 <CAFEAcA-3bFuy2DDG8=-_Y3JO4HWpCW80EcsGWWN8toxiMpafBA@mail.gmail.com>
 <20190812093510.1b85cac8@x1.home>
 <CAFEAcA-PxgCZzMJu8favVEP3x+DX3208TfChsu17fYCkibGg2w@mail.gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 12 Aug 2019 15:48:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/1] display/bochs: fix pcie support (qemu
 security issue)
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Prasad J Pandit <ppandit@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 12 Aug 2019 16:38:05 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Mon, 12 Aug 2019 at 16:35, Alex Williamson
> <alex.williamson@redhat.com> wrote:
> > Quoting new commit log:
> >
> >         This makes sure the pci config space allocation is big enough,
> >         so accessing the PCIe extended config space doesn't overflow
> >         the pci config space buffer.
> >
> >         PCI(e) config space is guest writable.  Writes are limited
> >         bywrite mask (which probably is also filled with random stuff),
> >         so the guest can only flip enabled bits.  But I suspect it
> >         still might be exploitable, so rather serious because it might
> >         be a host escape for the guest.  On the other hand the device
> >         is probably not yet in widespread use.
> >
> >         Mitigation: use "-device bochs-display" as conventional pci
> >         device only.
> >
> > Is it clear to others that this mitigation remark seems to be
> > referencing an alternative configuration constraint to avoid the issue
> > rather than what's actually implemented in this patch?  IOW, if we
> > never place the bochs-display device into a PCIe hierarchy, then
> > extended config space is never accessible to the guest anyway, and
> > there is no issue.  I think this was meant to be an alternative to the
> > patch but the enforcement of that would happen above QEMU, probably why
> > it was mentioned in the cover letter rather than the original commit
> > log.  Thanks,  
> 
> Yeah, that's unclear in retrospect. How about:
> 
> # (For a QEMU version without this commit, a mitigation for the
> # bug is available: use "-device bochs-display" as a conventional pci
> # device only.)

Yes, better.  Thanks,

Alex

