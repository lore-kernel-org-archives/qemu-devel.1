Return-Path: <SRS0=55mG=TM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415D0C04A6B
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 18:14:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 000992133D
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 18:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 000992133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45922 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPszi-0005lh-0X
	for qemu-devel@archiver.kernel.org; Sun, 12 May 2019 14:14:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hPsyo-0005Oe-FG
	for qemu-devel@nongnu.org; Sun, 12 May 2019 14:13:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hPsym-0008BO-JV
	for qemu-devel@nongnu.org; Sun, 12 May 2019 14:13:46 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hPsyk-0007dd-7Z
	for qemu-devel@nongnu.org; Sun, 12 May 2019 14:13:43 -0400
Received: by mail-qt1-f194.google.com with SMTP id m32so9271219qtf.0
	for <qemu-devel@nongnu.org>; Sun, 12 May 2019 11:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=8s0dL0/30XJbv7CGE/CS5WQrRXAGOGz8PlUeZ+qI+48=;
	b=PzNH/OicyLnCldGp7ECIYOjAC1Gih9W89vlGDN9R0ozvf5lTGqJ9AYCYmPZyffcR7T
	03f/Zldd7eEdBQon68Rl9sdGfHl4uFWbTTHCVDw3rOEg7w9ZorjS3qdXUSXoditjgiU2
	D1uGdn9YHWlC0GuznrshNZvRDijVyX3H8I6b2gTru5YSFM20W5JSOKGQjl4grMVp14Bo
	Hl745gOvQir1b00A6hrsajg3Qv/mwcvIqadC8XWa7VsFrDonhOfyonl3nqsFtfBNXE5I
	e+nwT/WPjj9j5fuzPkwdC9J4QaLhA0Ere2Tyy+DvoXhgD8uooV/UCjJ0/hjgwMGDoaBR
	6hxQ==
X-Gm-Message-State: APjAAAUFZ+6d4hfhhAuorXv43TdLitMLRqhy9CcerZ4lkISFApt9VcdC
	W1NK43FlYi1p3FXKqpd3LNgGvg==
X-Google-Smtp-Source: APXvYqz18ZnU+tKkJnY/XPWRqOlUKsYR7KcpX8/OJDOzT2WMxg4BtYxWdotVZ1mPEAc3L8Q78FUEzQ==
X-Received: by 2002:a0c:932f:: with SMTP id d44mr11904899qvd.187.1557684812942;
	Sun, 12 May 2019 11:13:32 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	s28sm1808947qtc.81.2019.05.12.11.13.31
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Sun, 12 May 2019 11:13:31 -0700 (PDT)
Date: Sun, 12 May 2019 14:13:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190512141309-mutt-send-email-mst@kernel.org>
References: <20190424041959.4087-1-david@gibson.dropbear.id.au>
	<20190424041959.4087-4-david@gibson.dropbear.id.au>
	<0890a0ab-e176-5549-1ec9-98c00a9c8026@ozlabs.ru>
	<20190507044837.GC7073@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507044837.GC7073@umbus.fritz.box>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.194
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 3/3] pcie: Simplify
 pci_adjust_config_limit()
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org,
	Greg Kurz <groug@kaod.org>, Alex Williamson <alex.williamson@redhat.com>,
	qemu-ppc@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 07, 2019 at 02:48:38PM +1000, David Gibson wrote:
> On Fri, Apr 26, 2019 at 04:40:17PM +1000, Alexey Kardashevskiy wrote:
> > 
> > 
> > On 24/04/2019 14:19, David Gibson wrote:
> > > Since c2077e2c "pci: Adjust PCI config limit based on bus topology",
> > > pci_adjust_config_limit() has been used in the config space read and write
> > > paths to only permit access to extended config space on buses which permit
> > > it.  Specifically it prevents access on devices below a vanilla-PCI bus via
> > > some combination of bridges, even if both the host bridge and the device
> > > itself are PCI-E.
> > > 
> > > It accomplishes this with a somewhat complex call up the chain of bridges
> > > to see if any of them prohibit extended config space access.  This is
> > > overly complex, since we can always know if the bus will support such
> > > access at the point it is constructed.
> > > 
> > > This patch simplifies the test by using a flag in the PCIBus instance
> > > indicating whether extended configuration space is accessible.  It is
> > > false for vanilla PCI buses.  For PCI-E buses, it is true for root
> > > buses and equal to the parent bus's's capability otherwise.
> > > 
> > > For the special case of sPAPR's paravirtualized PCI root bus, which
> > > acts mostly like vanilla PCI, but does allow extended config space
> > > access, we override the default value of the flag from the host bridge
> > > code.
> > > 
> > > This should cause no behavioural change.
> > > 
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>cd
> > > ---
> > >  hw/pci/pci.c             | 41 ++++++++++++++++++++++------------------
> > >  hw/pci/pci_host.c        | 13 +++----------
> > >  hw/ppc/spapr_pci.c       | 34 ++++++++++-----------------------
> > >  include/hw/pci/pci.h     |  1 -
> > >  include/hw/pci/pci_bus.h |  9 ++++++++-
> > >  5 files changed, 44 insertions(+), 54 deletions(-)
> > > 
> > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > index ea5941fb22..59ee034331 100644
> > > --- a/hw/pci/pci.c
> > > +++ b/hw/pci/pci.c
> > > @@ -120,6 +120,27 @@ static void pci_bus_realize(BusState *qbus, Error **errp)
> > >      vmstate_register(NULL, -1, &vmstate_pcibus, bus);
> > >  }
> > >  
> > > +static void pcie_bus_realize(BusState *qbus, Error **errp)
> > > +{
> > > +    PCIBus *bus = PCI_BUS(qbus);
> > > +
> > > +    pci_bus_realize(qbus, errp);
> > > +
> > > +    /*
> > > +     * A PCI-E bus can support extended config space if it's the root
> > > +     * bus, or if the bus/bridge above it does as well
> > > +     */
> > > +    if (pci_bus_is_root(bus)) {
> > > +        bus->flags |= PCI_BUS_EXTENDED_CONFIG_SPACE;
> > > +    } else {
> > > +        PCIBus *parent_bus = pci_get_bus(bus->parent_dev);
> > 
> > 
> > g_assert(bus->parent_dev) ?
> > 
> > Slightly confusingly bus->parent_dev is not the same as bus->qbus.parent
> > and can be NULL, I'd even look into ditching parent_dev and using
> > bus->qbus.parent instead (if possible).
> 
> Oh boy, the can of worms I reached into following up that simple
> comment.  Yes, they're subtly different, and yes it's confusing.  In
> practice parent_dev is NULL when on a root bus, that's not a PXB bus,
> and otherwise equal to qbus.parent.
> 
> After a *lot* of thinking about this, I think parent_dev is actually
> correct here - we're explicitly looking at the parent as a P2P bridge,
> not anything else.
> 
> But, I'll try to do some later cleanups making the parent_dev /
> qbus.parent confusion a bit better.
> > > +static inline bool pci_bus_allows_extended_config_space(PCIBus *bus)
> > > +{
> > > +    return !!(bus->flags & PCI_BUS_EXTENDED_CONFIG_SPACE);
> > > +}
> > > +
> > > +
> > 
> > An extra empty line.
> > 
> > Anyway, these are minor comments, so
> > 
> > Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > 
> > 
> > 
> > 
> > >  #endif /* QEMU_PCI_BUS_H */
> > > 
> > 

Pls address comments and repost ok?

> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson



