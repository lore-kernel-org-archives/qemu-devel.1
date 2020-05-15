Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15453C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE122074D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="01BzQG+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE122074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZZZz-0007Sz-Uy
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 08:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1jZZZ8-0006wN-Rn
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:35:50 -0400
Received: from forwardcorp1o.mail.yandex.net ([2a02:6b8:0:1a2d::193]:35324)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1jZZZ5-0006Xl-A4
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:35:49 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 00EBD2E15EC;
 Fri, 15 May 2020 15:35:40 +0300 (MSK)
Received: from iva4-7c3d9abce76c.qloud-c.yandex.net
 (iva4-7c3d9abce76c.qloud-c.yandex.net [2a02:6b8:c0c:4e8e:0:640:7c3d:9abc])
 by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 OGWjJb71yy-ZcrmLdE5; Fri, 15 May 2020 15:35:39 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1589546139; bh=Q9jFzaev3lq9TkuTq/i00/QKNOl8R0xszKIuZTqHRt0=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=01BzQG+UDh+pe/m/sdrYkm75Y0a4eE65VJo/GmFtiOhkCu26aEHN+0BSsTrJBcqCd
 nZQMYJmwzMwvbmdb7RVcylP/fsnoLjjMtWtlfplOHnRatfsFVBz/2gUTmwUXEnqJGS
 E96We3l3irKZ9RK49ONiq6MzEgre7c4rKYho66eo=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:220::1:7])
 by iva4-7c3d9abce76c.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 mADdXfnKz8-ZbWSseSF; Fri, 15 May 2020 15:35:37 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
Date: Fri, 15 May 2020 15:35:35 +0300
From: Roman Kagan <rvkagan@yandex-team.ru>
To: Jon Doron <arilou@gmail.com>
Subject: Re: [PATCH v4 5/6] i386: Hyper-V VMBus ACPI DSDT entry
Message-ID: <20200515123535.GF85336@rvkaganb.lan>
Mail-Followup-To: Roman Kagan <rvkagan@yandex-team.ru>,
 Jon Doron <arilou@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 eyakovlev@virtuozzo.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 liran.alon@oracle.com, Roman Kagan <rkagan@virtuozzo.com>,
 pbonzini@redhat.com, vkuznets@redhat.com
References: <20200424123444.3481728-1-arilou@gmail.com>
 <20200424123444.3481728-6-arilou@gmail.com>
 <20200505150637.7131e79b@redhat.com>
 <20200505153838.GC2862@jondnuc>
 <30fea22b-ef36-04d9-17ef-d13e3f93a3c5@maciej.szmigiero.name>
 <20200507031425.GG2862@jondnuc>
 <20200511201106.GB1307176@rvkaganb.lan>
 <20200513173725.277b0e16@redhat.com>
 <20200515085636.GN2862@jondnuc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200515085636.GN2862@jondnuc>
Received-SPF: pass client-ip=2a02:6b8:0:1a2d::193;
 envelope-from=rvkagan@yandex-team.ru; helo=forwardcorp1o.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, eyakovlev@virtuozzo.com,
 ehabkost@redhat.com, qemu-devel@nongnu.org, liran.alon@oracle.com,
 Roman Kagan <rkagan@virtuozzo.com>, pbonzini@redhat.com,
 Igor Mammedov <imammedo@redhat.com>, vkuznets@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 15, 2020 at 11:56:36AM +0300, Jon Doron wrote:
> On 13/05/2020, Igor Mammedov wrote:
> 
> Do you guys know perhaps which module is reading the ACPI configuration for
> VMBus? vmbus.sys / vmbkmcl.sys / winhv.sys? is it the kernel or HAL?

No idea...

> I dont have any real HyperV Windows to play with...
> 
> Roman, do you remember when is this information being used? Do we need a
> full emulation setup (aka your hv-scsi / hv-net) patches in order to see
> Windows working this ACPI entry?

I think the series you've posted should be enough to see VMBus in the
DeviceManager.  hv-scsi and hv-net should not further depend on ACPI.
hv-pci does: it (at least in its Linux driver implementation) wants the
VMBus entry or any of its ancestors to define range(s) where mmio
windows can be placed.  This may be worth considering when deciding
where to stick the VMBus entry to.

Thanks,
Roman.

> Thanks,
> -- Jon.
> 
> > On Mon, 11 May 2020 23:11:23 +0300
> > Roman Kagan <rvkagan@yandex-team.ru> wrote:
> > 
> > > On Thu, May 07, 2020 at 06:14:25AM +0300, Jon Doron wrote:
> > > > Igor it seems like the IRQ being used is 5 and not 7 & 13 like in the
> > > > current patch.
> > > 
> > > HyperV using irq 5 doesn't mean QEMU has to too.  Especially so as no
> > > guest was noticed to use the irqs in ACPI.  I'd rather try and test if
> > > the guest requires any those at all.
> > > 
> > > > Seems like it needs to reside in the _CRS like you said.
> > > 
> > > They already are there.
> > > 
> > > > Seems like it has all those _STA/_DIS/_PS0 just like the way it's currently
> > > > in the patch (unless I'm missing something).
> > > 
> > > Right, but, as you can see, they are pretty dumb, so the question is
> > > whether they are necessary or the guests can do without (Linux
> > > apparently can).
> > 
> > Agreed with all of above,
> > Instead of blind copying dubious AML, we should try to figure out what's
> > really necessary of it and throw away the rest.
> > 
> > > 
> > > Thanks,
> > > Roman.
> > > 
> > > > Notice _PS3 is not a Method.
> > > >
> > > > So just to summarize the changes i need to do:
> > > > 1. Change from 2 IRQs to single one (and use 5 as the default)
> > > > 2. IRQs needs to be under _CRS.
> > > > 3. You mentioned you want under a different location than the ISA bug where
> > > > would you want it to be?
> > > >
> > > > Please let me know if there is anything else.
> > > >
> > > > Thanks,
> > > > -- Jon.
> > > >
> > > > On 06/05/2020, Maciej S. Szmigiero wrote:
> > > > > On 05.05.2020 17:38, Jon Doron wrote:
> > > > > > On 05/05/2020, Igor Mammedov wrote:
> > > > > >
> > > > > > I dont know what were the original intentions of the original patch authors (at this point I simply rebased it, and to be honest I did not need this patch to get where I was going to, but it was part of the original patchset).
> > > > > >
> > > > > > But I'm willing to do any changes so we can keep going forward with this.
> > > > > >
> > > > > > > On Fri, 24 Apr 2020 15:34:43 +0300
> > > > > > > Jon Doron <arilou@gmail.com> wrote:
> > > > > > >
> > > > > > > > Guest OS uses ACPI to discover VMBus presence.  Add a corresponding
> > > > > > > > entry to DSDT in case VMBus has been enabled.
> > > > > > > >
> > > > > > > > Experimentally Windows guests were found to require this entry to
> > > > > > > > include two IRQ resources. They seem to never be used but they still
> > > > > > > > have to be there.
> > > > > > > >
> > > > > > > > Make IRQ numbers user-configurable via corresponding properties; use 7
> > > > > > > > and 13 by default.
> > > > > > > well, it seems that at least linux guest driver uses one IRQ,
> > > > > > > abeit not from ACPI descriptior
> > > > > > >
> > > > > > > perhaps it's what hyperv host puts into _CRS.
> > > > > > > Could you dump ACPI tables and check how hyperv describes vmbus in acpi?
> > > > > > >
> > > > > > >
> > > > > >
> > > > > > I can no longer get to the HyperV computer I had (in the office so hopefully if someone else has access to HyperV machine and willing to reply here with the dumped ACPI tables that would be great).
> > > > > >
> > > > >
> > > > > Here is a VMBus ACPI device description from Hyper-V in Windows Server 2019:
> > > > >
> > > > > Device (\_SB.VMOD.VMBS)
> > > > > {
> > > > >    Name (STA, 0x0F)
> > > > >    Name (_ADR, Zero)  // _ADR: Address
> > > > >    Name (_DDN, "VMBUS")  // _DDN: DOS Device Name
> > > > >    Name (_HID, "VMBus")  // _HID: Hardware ID
> > > > >    Name (_UID, Zero)  // _UID: Unique ID
> > > > >    Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
> > > > >    {
> > > > > 	STA &= 0x0D
> > > > >    }
> > > > >
> > > > >    Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
> > > > >    {
> > > > > 	STA |= 0x0F
> > > > >    }
> > > > >
> > > > >    Method (_STA, 0, NotSerialized)  // _STA: Status
> > > > >    {
> > > > > 	Return (STA) /* \_SB_.VMOD.VMBS.STA_ */
> > > > >    }
> > > > >
> > > > >    Name (_PS3, Zero)  // _PS3: Power State 3
> > > > >    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
> > > > >    {
> > > > > 	IRQ (Edge, ActiveHigh, Exclusive, )
> > > > > 	    {5}
> > > > >    })
> > > > > }
> > > > >
> > > > > It seems to use just IRQ 5.
> > > > >
> > > > > Maciej
> > > >
> > > 
> > 

