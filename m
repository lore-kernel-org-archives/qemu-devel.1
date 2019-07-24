Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47CDC76191
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 19:43:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA292229F4
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 19:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA292229F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqNAM-0000AV-Sk
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 15:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35699)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.williamson@redhat.com>) id 1hqNAB-0008Db-3R
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 15:43:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1hqNA9-0000uo-NF
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 15:42:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40192)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1hqNA9-0000ts-ES
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 15:42:57 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B58C83082128;
 Wed, 24 Jul 2019 19:42:55 +0000 (UTC)
Received: from x1.home (ovpn-116-99.phx2.redhat.com [10.3.116.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B1E519C70;
 Wed, 24 Jul 2019 19:42:47 +0000 (UTC)
Date: Wed, 24 Jul 2019 13:42:47 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Peter Xu <zhexu@redhat.com>
Message-ID: <20190724134247.61c2104a@x1.home>
In-Reply-To: <20190724084355.627d44cf@x1.home>
References: <155364082689.15803.7062874513041742278.stgit@gimli.home>
 <20190329104904.450fefef@x1.home>
 <dbe614f5-47c8-b05d-dd73-2fbcd1579ae3@amd.com>
 <20190723112618.0efafa8d@x1.home> <20190724071439.GB18771@xz-x1>
 <20190724040837-mutt-send-email-mst@kernel.org>
 <20190724100331.GA14454@xz-x1> <20190724084355.627d44cf@x1.home>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Wed, 24 Jul 2019 19:42:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH] pci: Use PCI aliases when determining
 device IOMMU address space
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
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "Suthikulpanit,
 Suravee" <Suravee.Suthikulpanit@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 24 Jul 2019 08:43:55 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Wed, 24 Jul 2019 18:03:31 +0800
> Peter Xu <zhexu@redhat.com> wrote:
> 
> > On Wed, Jul 24, 2019 at 05:39:22AM -0400, Michael S. Tsirkin wrote:  
> > > On Wed, Jul 24, 2019 at 03:14:39PM +0800, Peter Xu wrote:    
> > > > On Tue, Jul 23, 2019 at 11:26:18AM -0600, Alex Williamson wrote:    
> > > > > > On 3/29/19 11:49 AM, Alex Williamson wrote:    
> > > > > > > [Cc +Brijesh]
> > > > > > > 
> > > > > > > Hi Brijesh, will the change below require the IVRS to be updated to
> > > > > > > include aliases for all BDF ranges behind a conventional bridge?  I
> > > > > > > think the Linux code handles this regardless of the firmware provided
> > > > > > > aliases, but is it required per spec for the ACPI tables to include
> > > > > > > bridge aliases?  Thanks,
[snip]

For a data point, I fired up an old 990FX system which includes a
PCIe-to-PCI bridge and I added a plugin PCIe-to-PCI bridge just to keep
things interesting... guess how many alias ranges are in the IVRS...
Yep, just the one built into the motherboard:

AMD-Vi: Using IVHD type 0x10
AMD-Vi: device: 00:00.2 cap: 0040 seg: 0 flags: 3e info 1300
AMD-Vi:        mmio-addr: 00000000fec30000
AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 00:00.0 flags: 00
AMD-Vi:   DEV_RANGE_END		 devid: 00:00.2
AMD-Vi:   DEV_SELECT			 devid: 00:09.0 flags: 00
AMD-Vi:   DEV_SELECT			 devid: 01:00.0 flags: 00
AMD-Vi:   DEV_SELECT			 devid: 00:0a.0 flags: 00
AMD-Vi:   DEV_SELECT			 devid: 02:00.0 flags: 00
AMD-Vi:   DEV_SELECT			 devid: 00:11.0 flags: 00
AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 00:12.0 flags: 00
AMD-Vi:   DEV_RANGE_END		 devid: 00:12.2
AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 00:13.0 flags: 00
AMD-Vi:   DEV_RANGE_END		 devid: 00:13.2
AMD-Vi:   DEV_SELECT			 devid: 00:14.0 flags: d7
AMD-Vi:   DEV_SELECT			 devid: 00:14.2 flags: 00
AMD-Vi:   DEV_SELECT			 devid: 00:14.3 flags: 00
AMD-Vi:   DEV_SELECT			 devid: 00:14.4 flags: 00
AMD-Vi:   DEV_ALIAS_RANGE		 devid: 03:00.0 flags: 00 devid_to: 00:14.4
AMD-Vi:   DEV_RANGE_END		 devid: 03:1f.7

[Everything on bus 03:xx.x is aliased to device 00:14.4, the builtin PCIe-to-PCI bridge]

AMD-Vi:   DEV_SELECT			 devid: 00:14.5 flags: 00
AMD-Vi:   DEV_SELECT			 devid: 00:15.0 flags: 00
AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 04:00.0 flags: 00
AMD-Vi:   DEV_RANGE_END		 devid: 04:1f.7
AMD-Vi:   DEV_SELECT			 devid: 00:15.1 flags: 00
AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 05:00.0 flags: 00
AMD-Vi:   DEV_RANGE_END		 devid: 05:1f.7
AMD-Vi:   DEV_SELECT			 devid: 00:15.2 flags: 00
AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 06:00.0 flags: 00
AMD-Vi:   DEV_RANGE_END		 devid: 06:1f.7
AMD-Vi:   DEV_SELECT			 devid: 00:15.3 flags: 00
AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 08:00.0 flags: 00
AMD-Vi:   DEV_RANGE_END		 devid: 08:1f.7
AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 00:16.0 flags: 00
AMD-Vi:   DEV_RANGE_END		 devid: 00:16.2
AMD-Vi:   DEV_SPECIAL(IOAPIC[8])		devid: 00:14.0
AMD-Vi:   DEV_SPECIAL(HPET[0])		devid: 00:14.0
AMD-Vi:   DEV_SPECIAL(IOAPIC[8])		devid: 00:00.1

-[0000:00]-+-00.0  Advanced Micro Devices, Inc. [AMD/ATI] RD9x0/RX980 Host Bridge
           +-00.2  Advanced Micro Devices, Inc. [AMD/ATI] RD890S/RD990 I/O Memory Management Unit (IOMMU)
           +-09.0-[01]----00.0  Etron Technology, Inc. EJ168 USB 3.0 Host Controller
           +-0a.0-[02]----00.0  Marvell Technology Group Ltd. 88SE9172 SATA 6Gb/s Controller
           +-11.0  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode]
           +-12.0  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
           +-12.2  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller
           +-13.0  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
           +-13.2  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller
           +-14.0  Advanced Micro Devices, Inc. [AMD/ATI] SBx00 SMBus Controller
           +-14.2  Advanced Micro Devices, Inc. [AMD/ATI] SBx00 Azalia (Intel HDA)
           +-14.3  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 LPC host controller
           +-14.4-[03]--+-06.0  NVidia / SGS Thomson (Joint Venture) Riva128
           |            \-0e.0  VIA Technologies, Inc. VT6306/7/8 [Fire II(M)] IEEE 1394 OHCI Controller
           +-14.5  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI2 Controller
           +-15.0-[04]----00.0  Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
           +-15.1-[05]----00.0  Etron Technology, Inc. EJ168 USB 3.0 Host Controller
           +-15.2-[06-07]----00.0-[07]----00.0  Realtek Semiconductor Co., Ltd. Device 8149
           +-15.3-[08]--
           +-16.0  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
           +-16.2  Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller
           +-18.0  Advanced Micro Devices, Inc. [AMD] Family 10h Processor HyperTransport Configuration
           +-18.1  Advanced Micro Devices, Inc. [AMD] Family 10h Processor Address Map
           +-18.2  Advanced Micro Devices, Inc. [AMD] Family 10h Processor DRAM Controller
           +-18.3  Advanced Micro Devices, Inc. [AMD] Family 10h Processor Miscellaneous Control
           \-18.4  Advanced Micro Devices, Inc. [AMD] Family 10h Processor Link Control

00:14.4 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 PCI to PCI Bridge (rev 40) (prog-if 01 [Subtractive decode])
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=64

06:00.0 PCI bridge: ASMedia Technology Inc. ASM1083/1085 PCIe to PCI Bridge (rev 03) (prog-if 00 [Normal decode])
	Bus: primary=06, secondary=07, subordinate=07, sec-latency=32
	Capabilities: [80] Express (v1) PCI-Express to PCI/PCI-X Bridge, MSI 00

I realized as I was writing, that the alias caused by 06:00.0 would be
devfn 00.0 on the secondary bus 07, ie. 07:00.0 would alias to
07:00.0, so technically there's really not an alias for this small
case.  So I replaced the NIC with this:

           +-15.2-[06-07]----00.0-[07]--+-00.0  NEC Corporation OHCI USB Controller
                                        +-00.1  NEC Corporation OHCI USB Controller
                                        \-00.2  NEC Corporation uPD72010x USB 2.0 Controller

Now functions 07:00.[12] also alias to 07:00.0.  The IVRS table is
unaffected.

I'm tempted to say that QEMU would be no worse than bare metal if we
simply ignore IVHD device alias entries.  I know that Linux will figure
out the aliasing regardless of the IVRS.  Will Windows guests?  I'd
love to hear from Bijesh or Suravee regarding the behavior above versus
what AMD expects from system vendors.  Thanks,

Alex

