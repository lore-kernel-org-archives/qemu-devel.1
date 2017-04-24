Received: from eggs.gnu.org ([2001:4830:134:3::10]:39907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d2kEq-0008Nw-IU
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 16:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d2kEl-00065p-IB
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 16:05:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d2kEl-00065T-C6
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 16:05:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 49D6AC05975A
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 20:05:30 +0000 (UTC)
Date: Mon, 24 Apr 2017 17:05:26 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170424200526.GH3482@thinpad.lan.raisama.net>
References: <20170424185817.41002-1-imammedo@redhat.com>
	<20170424191317.GA3482@thinpad.lan.raisama.net>
	<20170424213233.2d19bdab@Igors-MacBook-Pro.local>
	<20170424193731.GE3482@thinpad.lan.raisama.net>
	<20170424215604.65daf761@Igors-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170424215604.65daf761@Igors-MacBook-Pro.local>
Subject: Re: [Qemu-devel] [PATCH] pc/fwcfg: unbreak migration from qemu-2.5
 and qemu-2.6 during firmware boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com, dgilbert@redhat.com, lersek@redhat.com

On Mon, Apr 24, 2017 at 09:56:04PM +0200, Igor Mammedov wrote:
> On Mon, 24 Apr 2017 16:37:31 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Mon, Apr 24, 2017 at 09:32:33PM +0200, Igor Mammedov wrote:
> > > On Mon, 24 Apr 2017 16:13:17 -0300
> > > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > > 
> > > > On Mon, Apr 24, 2017 at 08:58:17PM +0200, Igor Mammedov wrote:
> > > > [...]
> > > > > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > > > > index f3b372a18f..3f2d96da64 100644
> > > > > --- a/hw/i386/pc.c
> > > > > +++ b/hw/i386/pc.c
> > > > > @@ -1047,7 +1047,7 @@ static void load_linux(PCMachineState *pcms,
> > > > >      fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_SIZE, setup_size);
> > > > >      fw_cfg_add_bytes(fw_cfg, FW_CFG_SETUP_DATA, setup, setup_size);
> > > > >  
> > > > > -    if (fw_cfg_dma_enabled(fw_cfg)) {
> > > > > +    if (!pcmc->linuxboot_dma_disabled && fw_cfg_dma_enabled(fw_cfg)) {
> > > > 
> > > > Why not name the flag just "linuxboot_dma", set it to true by
> > > > default at pc_machine_class_init(), and avoid the double
> > > > negative?
> > > to avoid setting it to true somewhere else, so less thing could go wrong
> > > but is you prefer *_enable variant I can switch to it.
> > 
> > I would prefer to. We already have other compat flags initialized
> > inside pc_machine_class_init(), so this would fit nicely there.
> how about 'use_linuxboot_mmio' instead, it will remove negation
> and let me not to touch pc_machine_class_init()?

Sounds good to me.

-- 
Eduardo
