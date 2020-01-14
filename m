Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB429C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:05:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 731162467A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="iWC0Zr0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 731162467A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irJ57-00064k-HQ
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 05:05:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <roger.pau@citrix.com>) id 1irJ41-00052p-7P
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:04:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <roger.pau@citrix.com>) id 1irJ3y-0000GI-9P
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:04:45 -0500
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:40059)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <roger.pau@citrix.com>)
 id 1irJ3x-0000Ev-NJ
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:04:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1578996282;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=qxx3rA9hhMlVPBelH0+xqpyRUHbQaUMIaiHea6JarYk=;
 b=iWC0Zr0AjiMPxvLbTlKu81lrdaUhHwsK5e5GDjkPlarW/iGCMGsUFc6s
 rUx1f8ftYrwgmHiFjkrIZg8KkKcoN51BEpSLT8/lyG9ZuYmdWl4JQcCga
 kuoE7tUcBLUdBDKLncmDJXAdxwMi0Z2bGCQKUxbH7SjzwGLQf0MOPYuTl s=;
Authentication-Results: esa3.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=roger.pau@citrix.com;
 spf=Pass smtp.mailfrom=roger.pau@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
 receiver=esa3.hc3370-68.iphmx.com;
 envelope-from="roger.pau@citrix.com";
 x-sender="roger.pau@citrix.com"; x-conformance=sidf_compatible
Received-SPF: Pass (esa3.hc3370-68.iphmx.com: domain of
 roger.pau@citrix.com designates 162.221.158.21 as permitted
 sender) identity=mailfrom; client-ip=162.221.158.21;
 receiver=esa3.hc3370-68.iphmx.com;
 envelope-from="roger.pau@citrix.com";
 x-sender="roger.pau@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
 ip4:168.245.78.127 ~all"
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
 envelope-from="roger.pau@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: sghE+WHFnhZzApVd7UGFx09uGuh5xokj5Vfu6eoVGE96Nb/Tme3ifWwBRgpOHjJ8Oi3gnppU+z
 XBFOnJHDebAboMUOjp8mRhDLgQngNbUNLx9KTjU5vqZeNXe3ayp49yYNAif7QTSRIKwDsIdada
 xDa0Bc+6xbEVs5lfsI4ee3+K0tfqe+Oh0hIq6Vg9udrdNoIk6DeIFBlA1mEOz2s0aCcX1KCJ3+
 DiH1N+88oUD2sT4jNfinb/1ELpzaTGTD4HWlz/s9HMY9kWNP93IxLzyuA5vngncRmuYlZ0802g
 dw8=
X-SBRS: 2.7
X-MesageID: 10874124
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,432,1571716800"; d="scan'208";a="10874124"
Date: Tue, 14 Jan 2020 11:04:06 +0100
From: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To: Jason Andryuk <jandryuk@gmail.com>
Subject: Re: [Xen-devel] [PATCH 6/6] xen-pt: Round pci regions sizes to
 XEN_PAGE_SIZE
Message-ID: <20200114100406.GF11756@Air-de-Roger>
References: <20190311180216.18811-1-jandryuk@gmail.com>
 <20190311180216.18811-7-jandryuk@gmail.com>
 <ee0da83d3f054e72ae450437c8834d04@AMSPEX02CL02.citrite.net>
 <CAKf6xpujVs3RPJcb+2vqPZFcYwhdDcjbt=S_+awjPuPFpFHsPw@mail.gmail.com>
 <57dc1083d20a469785f05a2e5250a820@AMSPEX02CL02.citrite.net>
 <cd5f1ecc-576f-b7d0-3090-4f3e4faf6148@citrix.com>
 <CAKf6xpt4XYXn2xHJoVY_ibcaHSw-ED10V7ZGNKuDdkiJ93RS0A@mail.gmail.com>
 <20190322030936.fkiajz5ifgaejkd4@MacBook-Air-de-Roger.local>
 <CAKf6xptP_b-+FuscjsTK9G7pMeVS8drvA_t+xb5bdF2zxxmWfA@mail.gmail.com>
 <CAKf6xpscx9Yukphv7mfK2BPM8HoGW0ddt9zbOZxpV+9LzWxz4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKf6xpscx9Yukphv7mfK2BPM8HoGW0ddt9zbOZxpV+9LzWxz4g@mail.gmail.com>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL01.citrite.net (10.69.22.125)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.145.155
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 "marmarek@invisiblethingslab.com" <marmarek@invisiblethingslab.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Simon Gaiser <simon@invisiblethingslab.com>, Paul
 Durrant <Paul.Durrant@citrix.com>, Anthony Perard <anthony.perard@citrix.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 13, 2020 at 02:01:47PM -0500, Jason Andryuk wrote:
> On Fri, Mar 22, 2019 at 3:43 PM Jason Andryuk <jandryuk@gmail.com> wrote:
> >
> > On Thu, Mar 21, 2019 at 11:09 PM Roger Pau Monné <roger.pau@citrix.com> wrote:
> > >
> > > On Wed, Mar 20, 2019 at 01:28:47PM -0400, Jason Andryuk wrote:
> > > > On Fri, Mar 15, 2019 at 12:28 PM Andrew Cooper
> > > > <andrew.cooper3@citrix.com> wrote:
> > > > >
> > > > > On 15/03/2019 09:17, Paul Durrant wrote:
> > > > > >> -----Original Message-----
> > > > > >> From: Jason Andryuk [mailto:jandryuk@gmail.com]
> > > > > >> Sent: 14 March 2019 18:16
> > > > > >> To: Paul Durrant <Paul.Durrant@citrix.com>
> > > > > >> Cc: qemu-devel@nongnu.org; xen-devel@lists.xenproject.org; marmarek@invisiblethingslab.com; Simon
> > > > > >> Gaiser <simon@invisiblethingslab.com>; Stefano Stabellini <sstabellini@kernel.org>; Anthony Perard
> > > > > >> <anthony.perard@citrix.com>
> > > > > >> Subject: Re: [PATCH 6/6] xen-pt: Round pci regions sizes to XEN_PAGE_SIZE
> > > > > >>
> > > > > >> On Wed, Mar 13, 2019 at 11:09 AM Paul Durrant <Paul.Durrant@citrix.com> wrote:
> > > > > >>>> -----Original Message-----
> > > > > >>>> From: Jason Andryuk [mailto:jandryuk@gmail.com]
> > > > > >>>> Sent: 11 March 2019 18:02
> > > > > >>>> To: qemu-devel@nongnu.org
> > > > > >>>> Cc: xen-devel@lists.xenproject.org; marmarek@invisiblethingslab.com; Simon Gaiser
> > > > > >>>> <simon@invisiblethingslab.com>; Jason Andryuk <jandryuk@gmail.com>; Stefano Stabellini
> > > > > >>>> <sstabellini@kernel.org>; Anthony Perard <anthony.perard@citrix.com>; Paul Durrant
> > > > > >>>> <Paul.Durrant@citrix.com>
> > > > > >>>> Subject: [PATCH 6/6] xen-pt: Round pci regions sizes to XEN_PAGE_SIZE
> > > > > >>>>
> > > > > >>>> From: Simon Gaiser <simon@invisiblethingslab.com>
> > > > > >>>>
> > > > > >>>> If a pci memory region has a size < XEN_PAGE_SIZE it can get located at
> > > > > >>>> an address which is not page aligned.
> > > > > >>> IIRC the PCI spec says that the minimum memory region size should be at least 4k. Should we even be
> > > > > >> tolerating BARs smaller than that?
> > > > > >>>   Paul
> > > > > >>>
> > > > > >> Hi, Paul.
> > > > > >>
> > > > > >> Simon found this, so it affects a real device.  Simon, do you recall
> > > > > >> which device was affected?
> > > > > >>
> > > > > >> I think BARs only need to be power-of-two size and aligned, and 4k is
> > > > > >> not a minimum.  16bytes may be a minimum, but I don't know what the
> > > > > >> spec says.
> > > > > >>
> > > > > >> On an Ivy Bridge system, here are some of the devices with BARs smaller than 4K:
> > > > > >> 00:16.0 Communication controller: Intel Corporation 7 Series/C210
> > > > > >> Series Chipset Family MEI Controller #1 (rev 04)
> > > > > >>    Memory at d0735000 (64-bit, non-prefetchable) [disabled] [size=16]
> > > > > >> 00:1d.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset
> > > > > >> Family USB Enhanced Host Controller #1 (rev 04) (prog-if 20 [EHCI])
> > > > > >>    Memory at d0739000 (32-bit, non-prefetchable) [disabled] [size=1K]
> > > > > >> 00:1f.3 SMBus: Intel Corporation 7 Series/C210 Series Chipset Family
> > > > > >> SMBus Controller (rev 04)
> > > > > >>    Memory at d0734000 (64-bit, non-prefetchable) [disabled] [size=256]
> > > > > >> 02:00.0 System peripheral: JMicron Technology Corp. SD/MMC Host
> > > > > >> Controller (rev 30)
> > > > > >>    Memory at d0503000 (32-bit, non-prefetchable) [disabled] [size=256]
> > > > > >>
> > > > > >> These examples are all 4K aligned, so this is not an issue on this machine.
> > > > > >>
> > > > > >> Reviewing the code, I'm now wondering if the following in
> > > > > >> hw/xen/xen_pt.c:xen_pt_region_update is wrong:        rc =
> > > > > >> xc_domain_memory_mapping(xen_xc, xen_domid,
> > > > > >>                                      XEN_PFN(guest_addr + XC_PAGE_SIZE - 1),
> > > > > >>                                      XEN_PFN(machine_addr + XC_PAGE_SIZE - 1),
> > > > > >>                                      XEN_PFN(size + XC_PAGE_SIZE - 1),
> > > > > >>                                      op);
> > > > > >>
> > > > > >> If a bar of size 0x100 is at 0xd0500800, then the machine_addr passed
> > > > > >> in would be 0xd0501000 which is past the actual location.  Should the
> > > > > >> call arguments just be XEN_PFN(guest_addr) & XEN_PFN(machine_addr)?
> > > > > >>
> > > > > >> BARs smaller than a page would also be a problem if BARs for different
> > > > > >> devices shared the same page.
> > > > > > Exactly. We cannot pass them through with any degree of safety (not that passthrough of an arbitrary device is a particularly safe thing to do anyway). The xen-pt code would instead need to trap those BARs and perform the accesses to the real BAR itself. Ultimately though I think we should be retiring the xen-pt code in favour of a standalone emulator.
> > > > >
> > > > > It doesn't matter if the BAR is smaller than 4k, if there are holes next
> > > > > to it.
> > > > >
> > > > > Do we know what the case is in practice for these USB controllers?
> > > > >
> > > > > If the worst comes to the worst, we can re-enumerate the PCI bus to
> > > > > ensure that all bars smaller than 4k still have 4k alignment between
> > > > > them.  That way we can safely pass them through even when they are smaller.
> > > >
> > > > Andrew, thanks for checking the spec on the minimum BAR size.
> > > >
> > > > Dropping the Round PCI region patch from QMEU, the guest HVM will have:
> > > >
> > > > 00:06.0 SD Host controller: Ricoh Co Ltd PCIe SDXC/MMC Host Controller (rev 07)
> > > >     Memory at f2028800 (32-bit, non-prefetchable) [size=256]
> > > > 00:07.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host
> > > > Controller (rev 04) (prog-if 30 [XHCI])
> > > >     Memory at f2024000 (64-bit, non-prefetchable) [size=8K]
> > > > 00:08.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset
> > > > Family USB Enhanced Host Controller #2 (rev 05) (prog-if 20 [EHCI])
> > > >     Memory at f2028000 (32-bit, non-prefetchable) [size=1K]
> > > > 00:09.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset
> > > > Family USB Enhanced Host Controller #1 (rev 05) (prog-if 20 [EHCI])
> > > >     Memory at f2028400 (32-bit, non-prefetchable) [size=1K]
> > > >
> > > > 00:09.0, 00:08.0 & 00:06.0 all share the same page.  Only 00:08.0 is
> > > > working.  With some added debugging output, you'll see that the same
> > > > page* is used for three of the BARs.
> > > >
> > > > [00:06.0] mapping guest_addr 0xf2028800 gfn 0xf2028 to maddr
> > > > 0xe1a30000 mfn 0xe1a30
> > > > [00:07.0] mapping guest_addr 0xf2024000 gfn 0xf2024 to maddr
> > > > 0xe0800000 mfn 0xe0800
> > > > [00:09.0] mapping guest_addr 0xf2028400 gfn 0xf2028 to maddr
> > > > 0xe1900000 mfn 0xe1900
> > > > [00:08.0] mapping guest_addr 0xf2028000 gfn 0xf2028 to maddr
> > > > 0xe1a2f000 mfn 0xe1a2f
> > >
> > > The patch below should prevent hvmloader from placing multiple BARs on
> > > the same page, could you give it a try?
> > >
> > > Note that this is not going to prevent the guest from moving those
> > > BARs around and place them in the same page, thus breaking the initial
> > > placement done by hvmloader.
> > >
> > > Thanks, Roger.
> >
> > Hi, Roger.
> >
> > I've minimally tested this.  Yes, this patch seems to place small BARs
> > into separate pages.  The linux stubdom and QEMU then use the spacing
> > as provided by hvmloader.
> 
> Roger,
> 
> Would you mind submitting this patch to Xen?

Hm, I'm half minded regarding this patch. It feels more like a bandaid
than a proper solution. Mapping BARs not multiple of page-sizes is
dangerous because AFAIK there's no entity that asserts there isn't any
other BAR from a different device on the same page, and hence you
might end up mapping some MMIO region from another device
inadvertently.

Anyway, I can formally submit the patch since it's no worse than
what's currently done, but I would clearly state this is not safe in
it's current state.

Thanks, Roger.

