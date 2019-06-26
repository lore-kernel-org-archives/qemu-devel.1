Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AA2C48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 17:00:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61EB620665
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 17:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61EB620665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birkelund.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgBHJ-0001ED-GL
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 13:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39907)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <klaus@birkelund.eu>) id 1hgBFL-0007wI-9k
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 12:58:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <klaus@birkelund.eu>) id 1hgBFJ-0005l5-8o
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 12:58:11 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48174)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <klaus@birkelund.eu>)
 id 1hgBFB-0005Y1-Bd; Wed, 26 Jun 2019 12:58:01 -0400
Received: from apples.localdomain (ip-5-186-120-196.cgn.fibianet.dk
 [5.186.120.196])
 by charlie.dont.surf (Postfix) with ESMTPSA id 529A4BFD2C;
 Wed, 26 Jun 2019 16:57:57 +0000 (UTC)
Date: Wed, 26 Jun 2019 18:57:54 +0200
From: Klaus Birkelund <klaus@birkelund.eu>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190626165754.GA22827@apples.localdomain>
Mail-Followup-To: Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>,
 Laszlo Ersek <lersek@redhat.com>
References: <20190617081205.GA26990@apples.localdomain>
 <c754211f-b41d-4b69-585b-b287fb776d81@redhat.com>
 <20190624080154.GA4263@apples.localdomain>
 <20190624101828.GC12855@linux.fritz.box>
 <3571317f-84c2-8649-ba63-0e6508679b05@redhat.com>
 <87wohajjq6.fsf@dusky.pond.sub.org>
 <20190625164726.GB21148@apples.localdomain>
 <87o92lkl6x.fsf@dusky.pond.sub.org>
 <3d94d5af-002a-d079-4e23-8a8b06c11152@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d94d5af-002a-d079-4e23-8a8b06c11152@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 128.199.63.193
Subject: Re: [Qemu-devel] [Qemu-block] [RFC] nvme: how to support multiple
 namespaces
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Keith Busch <keith.busch@intel.com>, Max Reitz <mreitz@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 26, 2019 at 12:14:15PM +0200, Paolo Bonzini wrote:
> On 26/06/19 06:46, Markus Armbruster wrote:
> >> I'm not sure how to wire it together without the bus abstraction? So
> >> I'll stick with the bus for now. It *is* extremely convenient!
> > 
> > As far as I can tell offhand, a common use of bus-less connections
> > between devices is wiring together composite devices.  Example:
> > 
> >     static void designware_pcie_host_init(Object *obj)
> >     {
> >         DesignwarePCIEHost *s = DESIGNWARE_PCIE_HOST(obj);
> >         DesignwarePCIERoot *root = &s->root;
> > 
> >         object_initialize_child(obj, "root",  root, sizeof(*root),
> >                                 TYPE_DESIGNWARE_PCIE_ROOT, &error_abort, NULL);
> >         qdev_prop_set_int32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
> >         qdev_prop_set_bit(DEVICE(root), "multifunction", false);
> >     }
> > 
> > This creates a TYPE_DESIGNWARE_PCIE_ROOT device "within" the
> > TYPE_DESIGNWARE_PCIE_HOST device.
> > 
> > Bus-less connections between separate devices (i.e. neither device is a
> > part of the other) are also possible.  But I'm failing at grep right
> > now.  Here's an example for connecting a device to a machine:
> > 
> >     static void mch_realize(PCIDevice *d, Error **errp)
> >     {
> >         int i;
> >         MCHPCIState *mch = MCH_PCI_DEVICE(d);
> > 
> >         [...]
> >         object_property_add_const_link(qdev_get_machine(), "smram",
> >                                        OBJECT(&mch->smram), &error_abort);
> >         [...]
> >     }
> 
> This is a link to a memory region.  A connection to a separate device
> can be found in hw/dma/xilinx_axidma.c and hw/net/xilinx_axienet.c,
> where you have
> 
>          data stream <------------> data stream
>        /                                        \
>    dma                                            enet
>        \                                        /
>          control stream <------> control stream
> 
> where the horizontal links in the middle are set up by board code, while
> the diagonal lines on the side are set up by device code.
> 
> > Paolo, can you provide guidance on when to use a bus, and when not to?
> 
> I would definitely use a bus if 1) it is common for the user (and not
> for machine code) to set up the connection 2) the relationship is
> parent-child.  Link properties are basically unused on the command line,
> and it only makes sense to make something different if the connection is
> some kind of graph so bus-child does not cut it.
> 

Definitely looks like the bus is the way to go. The controller/namespace
relationship is strictly parent-child.

Thanks both of you for the advice!


Klaus

