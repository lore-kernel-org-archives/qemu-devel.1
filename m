Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00002C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 13:22:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8FB821721
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 13:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8FB821721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54268 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVyX0-0000a0-2y
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 09:22:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hVyVZ-0008Cf-Ih
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:20:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hVyVY-0007OC-JD
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:20:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hVyVW-0007K8-IE
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:20:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 750C681E19;
	Wed, 29 May 2019 13:20:35 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-131.ams2.redhat.com
	[10.36.117.131])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 282DC1001E80;
	Wed, 29 May 2019 13:20:34 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 6611116E08; Wed, 29 May 2019 15:20:33 +0200 (CEST)
Date: Wed, 29 May 2019 15:20:33 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190529132033.cdjuguiwn2tg22lp@sirius.home.kraxel.org>
References: <20190528204331.5280-1-kraxel@redhat.com>
	<20190529131652.7ae89190@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529131652.7ae89190@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Wed, 29 May 2019 13:20:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] q35: fix mmconfig and PCI0._CRS
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?utf-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 29, 2019 at 01:16:52PM +0200, Igor Mammedov wrote:
> On Tue, 28 May 2019 22:43:31 +0200
> Gerd Hoffmann <kraxel@redhat.com> wrote:
> 
> > This patch changes the handling of the mmconfig area.  Thanks to the
> > pci(e) expander devices we already have the logic to exclude address
> > ranges from PCI0._CRS.  We can simply add the mmconfig address range
> > to the list get it excluded as well.
> > 
> > With that in place we can go with a fixed pci hole which covers the
> > whole area from the end of (low) ram to the ioapic.
> > 
> > This will make the whole logic alot less fragile.  No matter where the
> > firmware places the mmconfig xbar, things should work correctly.  The
> > guest also gets a bit more PCI address space (seabios boot):
> > 
> >     # cat /proc/iomem
> >     [ ... ]
> >     7ffdd000-7fffffff : reserved
> >     80000000-afffffff : PCI Bus 0000:00            <<-- this is new
> >     b0000000-bfffffff : PCI MMCONFIG 0000 [bus 00-ff]
> >       b0000000-bfffffff : reserved
> >     c0000000-febfffff : PCI Bus 0000:00
> >       f8000000-fbffffff : 0000:00:01.0
> >     [ ... ]
> > 
> > So this is a guest visible change.
> 
> My impression was that QEMU would/should add into CRS whatever bars
> firmware programmed (and it looks like QEMU doesn't do it right).

Well, that works reasonable well.  It looks at all pci bars.  The ones
which do not belong to PCI0 are added to their pci(e) expander.  All
remaining address space of the pci hole is added to PCI0.  At times
things look a bit odd as all unused ranges go to PCI0 even in cases like
this one:

[ ... ]
84a00000-85203fff : PCI Bus 0000:40
  84a00000-84bfffff : PCI Bus 0000:44
  84c00000-84dfffff : PCI Bus 0000:43
  84e00000-84ffffff : PCI Bus 0000:42
  85000000-851fffff : PCI Bus 0000:41
  85200000-85200fff : 0000:40:02.3
  85201000-85201fff : 0000:40:02.2
  85202000-85202fff : 0000:40:02.1
  85203000-85203fff : 0000:40:02.0
85204000-853fffff : PCI Bus 0000:00   <<-- this could be given to PCI Bus 0000:40
85400000-85c03fff : PCI Bus 0000:80
  85400000-855fffff : PCI Bus 0000:84
[ ... ]

but that is more or less cosmetical.

> So I'm not really fond of adding bigger hole just to paper over
> existing bug (still might be the way to go). Let me ponder a bit
> on it and look into what's isn't working on QEMU side properly.

Basically qemu assumes the (32bit) pci hole starts above the mmconfig
bar.  The pci hole should start above low memory though, like it does
on 'pc'.  And the mmconfig bar should be excluded.

cheers,
  Gerd


