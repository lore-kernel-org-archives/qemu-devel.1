Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A06C04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 03:25:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496A720657
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 03:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496A720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46355 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVpDc-0006Kk-Im
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 23:25:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hVpCQ-0005ZA-33
	for qemu-devel@nongnu.org; Tue, 28 May 2019 23:24:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hVpCO-0004UP-NZ
	for qemu-devel@nongnu.org; Tue, 28 May 2019 23:24:22 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hVpCO-0004Sr-Iu
	for qemu-devel@nongnu.org; Tue, 28 May 2019 23:24:20 -0400
Received: by mail-qt1-f196.google.com with SMTP id 14so904722qtf.0
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 20:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=vHtHXlb2UxU1f5Qt+FyLuYxrO8fV3Dn+f67W9eBDx4s=;
	b=kQ1Jjn3xCQxzrrT5TxfXb9Cq0pCTgAfj/dbm4f0GLnu4vuC9GuXhTLh9P58ra1MRfy
	kGaDuXMui5ld5CHqRglsTCOD9FLlweI8mVlWDRkZqnIsVt+EZIE/oufk99AqpkLTwY9c
	L/JReYIz0WVoD48HACoWF5J04hzo7V/ffGaFtuY2V4pvW1k6XCacRSkwM5P96E4/Q9kl
	Z6kPWvzl7QYsp5x1V07hOwH/Ahcr9P9dU8FZCSIYmXDrGTlISMnYk24fwEcAxI/c5Ieb
	dxky7q8DaJLE7m6HuWE7QmtlIxPP6wCyJ6q2B6W2QIuxY0R7HRZY0NFHagaCcs2q02wi
	+pqA==
X-Gm-Message-State: APjAAAVCFlCjoFCT7Iw+IAiy5jG9PTJS88Oo22C4EALJLo8B55GczFWQ
	B+jwFnC0E4TlEA0e29AqN8iRWg==
X-Google-Smtp-Source: APXvYqyWGIsPMBvTT4N76v5lzOsyEfB3ZGcwOTE9zFDBPtSEGfcKvdtR+n6dy5XsLqX8tbcBh2sfkw==
X-Received: by 2002:aed:3bd7:: with SMTP id s23mr17778362qte.139.1559100259928;
	Tue, 28 May 2019 20:24:19 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	z18sm2174466qtf.28.2019.05.28.20.24.18
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 28 May 2019 20:24:19 -0700 (PDT)
Date: Tue, 28 May 2019 23:24:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190528232406-mutt-send-email-mst@kernel.org>
References: <20190523052918.1129-1-david@gibson.dropbear.id.au>
	<20190528232250-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528232250-mutt-send-email-mst@kernel.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.196
Subject: Re: [Qemu-devel] [PATCH 1/8] spapr: Clean up device node name
 generation for PCI devices
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
Cc: qemu-devel@nongnu.org, mdroth@linux.ibm.com, qemu-ppc@nongnu.org,
	groug@kaod.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 28, 2019 at 11:23:54PM -0400, Michael S. Tsirkin wrote:
> On Thu, May 23, 2019 at 03:29:11PM +1000, David Gibson wrote:
> > spapr_populate_pci_child_dt() adds a 'name' property to the device tree
> > node for PCI devices.  This is never necessary for a flattened device tree,
> > it is implicit in the name added when the node is constructed.  In fact
> > anything we do add to a 'name' property will be overwritten with something
> > derived from the structural name in the guest firmware (but in fact it is
> > exactly the same bytes).
> > 
> > So, remove that.  In addition, pci_get_node_name() is very simple, so fold
> > it into its (also simple) sole caller spapr_create_pci_child_dt().
> > 
> > While we're there rename pci_find_device_name() to the shorter and more
> > accurate dt_name_from_class().
> > 
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> 
> The threading is broken here btw.
> 
> I was CC'd but it's mostly PPC stuff.
> I like how pci_XX functions that are not in pci.c are
> going away :)
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

and that's for the whole patchset.

> 
> > ---
> >  hw/ppc/spapr_pci.c | 43 +++++++++++++++++--------------------------
> >  1 file changed, 17 insertions(+), 26 deletions(-)
> > 
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index 97961b0128..b2db46ef1d 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -1173,8 +1173,8 @@ static const PCIClass pci_classes[] = {
> >      { "data-processing-controller", spc_subclass },
> >  };
> >  
> > -static const char *pci_find_device_name(uint8_t class, uint8_t subclass,
> > -                                        uint8_t iface)
> > +static const char *dt_name_from_class(uint8_t class, uint8_t subclass,
> > +                                      uint8_t iface)
> >  {
> >      const PCIClass *pclass;
> >      const PCISubClass *psubclass;
> > @@ -1216,23 +1216,6 @@ static const char *pci_find_device_name(uint8_t class, uint8_t subclass,
> >      return name;
> >  }
> >  
> > -static gchar *pci_get_node_name(PCIDevice *dev)
> > -{
> > -    int slot = PCI_SLOT(dev->devfn);
> > -    int func = PCI_FUNC(dev->devfn);
> > -    uint32_t ccode = pci_default_read_config(dev, PCI_CLASS_PROG, 3);
> > -    const char *name;
> > -
> > -    name = pci_find_device_name((ccode >> 16) & 0xff, (ccode >> 8) & 0xff,
> > -                                ccode & 0xff);
> > -
> > -    if (func != 0) {
> > -        return g_strdup_printf("%s@%x,%x", name, slot, func);
> > -    } else {
> > -        return g_strdup_printf("%s@%x", name, slot);
> > -    }
> > -}
> > -
> >  static uint32_t spapr_phb_get_pci_drc_index(SpaprPhbState *phb,
> >                                              PCIDevice *pdev);
> >  
> > @@ -1300,11 +1283,6 @@ static void spapr_populate_pci_child_dt(PCIDevice *dev, void *fdt, int offset,
> >          _FDT(fdt_setprop(fdt, offset, "udf-supported", NULL, 0));
> >      }
> >  
> > -    _FDT(fdt_setprop_string(fdt, offset, "name",
> > -                            pci_find_device_name((ccode >> 16) & 0xff,
> > -                                                 (ccode >> 8) & 0xff,
> > -                                                 ccode & 0xff)));
> > -
> >      buf = spapr_phb_get_loc_code(sphb, dev);
> >      _FDT(fdt_setprop_string(fdt, offset, "ibm,loc-code", buf));
> >      g_free(buf);
> > @@ -1348,10 +1326,23 @@ static int spapr_create_pci_child_dt(SpaprPhbState *phb, PCIDevice *dev,
> >                                       void *fdt, int node_offset)
> >  {
> >      int offset;
> > -    gchar *nodename;
> > +    const gchar *basename;
> > +    char *nodename;
> > +    int slot = PCI_SLOT(dev->devfn);
> > +    int func = PCI_FUNC(dev->devfn);
> > +    uint32_t ccode = pci_default_read_config(dev, PCI_CLASS_PROG, 3);
> > +
> > +    basename = dt_name_from_class((ccode >> 16) & 0xff, (ccode >> 8) & 0xff,
> > +                                  ccode & 0xff);
> > +
> > +    if (func != 0) {
> > +        nodename = g_strdup_printf("%s@%x,%x", basename, slot, func);
> > +    } else {
> > +        nodename = g_strdup_printf("%s@%x", basename, slot);
> > +    }
> >  
> > -    nodename = pci_get_node_name(dev);
> >      _FDT(offset = fdt_add_subnode(fdt, node_offset, nodename));
> > +
> >      g_free(nodename);
> >  
> >      spapr_populate_pci_child_dt(dev, fdt, offset, phb);
> > -- 
> > 2.21.0

