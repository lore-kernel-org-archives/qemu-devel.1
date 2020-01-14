Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64136C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DB142467D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlKgBPWb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB142467D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irNOy-0001UR-9Y
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 09:42:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jandryuk@gmail.com>) id 1irNOL-00010h-Cq
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:42:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jandryuk@gmail.com>) id 1irNOJ-00034K-HT
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:42:01 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:41845)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jandryuk@gmail.com>) id 1irNOJ-00034C-7G
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:41:59 -0500
Received: by mail-lj1-x242.google.com with SMTP id h23so14627645ljc.8
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 06:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KScogeDftmvqWYIkPyyiPLur8lC1L/rXWGn83bgxhNc=;
 b=SlKgBPWbPrrlTrsa5/1lSY7DUL3Lbqw9Zen97OZDuZeXiF7rZMySocuw++DXkmt7U7
 fpFxhOiRO06nYoNIQ5GfpmcspAVOyDeYinNPKYj8e957EaCl2frLbUjWGNqGYMPVZZfN
 WuHcga+2V9h0TYWINSPOCdF7eWntQeoN4KwRj02eo+N06j5E0oMxMiUZoBbjA67NiEL5
 M/tjE09cl7mTThw5NLVVlvUheebRvR1Dm2kkWb3tYgdaq2w2/gqDU0FZ0TLDQCPDU5Mk
 1/9OcpHVytpW1qEHxnSs+o4Ww6sTdJTVi4jcbsNttCMv2dJxzZihLZLF3qxnzGiz7oCW
 vfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KScogeDftmvqWYIkPyyiPLur8lC1L/rXWGn83bgxhNc=;
 b=PQhWu5+0zcpaFDW0XkmDtu9jAAtu0czhWk3jhnFRAJxSoOx3NE5N+TUNRtmrDqG5YT
 idyoYwDpsv7INiBGsfe4gTm4buqqDGjIlKg+Sza3bWiyeHx5twU2do7kRoHPx+6+EHZd
 6rvt3ShrtVf+VEz0Z+B0jrAEwerEPQM6qXi7PcJ/6B2NblyIcDJ2/JXZP3f7w+uApSd/
 u1NEr3DtdYSGjHx6/PclJcuXOXSRfBNGBD8v1XPb+SX4p2H9PkvBXmtLyc+0+Y/FtWiA
 ggt1d9O762nTRNxoEZzojsV/KOy9bH4ZEmdlgSdSBJcQG63lW00hGbIb5fwo/PktF50Y
 jUYw==
X-Gm-Message-State: APjAAAUI7JDkBniiEYzVLOVD7kx6rWZa3tdk5duFGop5++N801WeUkrh
 v3Iz9rubRtJG1aVKqnUJTx++JhCKIiGbqPyj0B8=
X-Google-Smtp-Source: APXvYqxUbN2OiIBkXqdcyM7277FQJ8KxNOBpAR3aYwqLyXQI3z3Sz6j68OqJwSxfcqAWVfqsAEzZLjO4nTpc6Qezwso=
X-Received: by 2002:a2e:6f19:: with SMTP id k25mr14504839ljc.84.1579012917620; 
 Tue, 14 Jan 2020 06:41:57 -0800 (PST)
MIME-Version: 1.0
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
 <20200114100406.GF11756@Air-de-Roger>
In-Reply-To: <20200114100406.GF11756@Air-de-Roger>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Tue, 14 Jan 2020 09:41:46 -0500
Message-ID: <CAKf6xpuDo=FGTOJ9ipmk7nY+qs+pKBWESqY0ah6B1vS3kZsT=A@mail.gmail.com>
Subject: Re: [Xen-devel] [PATCH 6/6] xen-pt: Round pci regions sizes to
 XEN_PAGE_SIZE
To: =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
 Andrew Cooper <andrew.cooper3@citrix.com>, Paul Durrant <pdurrant@amazon.com>,
 "marmarek@invisiblethingslab.com" <marmarek@invisiblethingslab.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Simon Gaiser <simon@invisiblethingslab.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 14, 2020 at 5:04 AM Roger Pau Monn=C3=A9 <roger.pau@citrix.com>=
 wrote:
>
> On Mon, Jan 13, 2020 at 02:01:47PM -0500, Jason Andryuk wrote:
> > On Fri, Mar 22, 2019 at 3:43 PM Jason Andryuk <jandryuk@gmail.com> wrot=
e:
> > >
> > > On Thu, Mar 21, 2019 at 11:09 PM Roger Pau Monn=C3=A9 <roger.pau@citr=
ix.com> wrote:
> > > >
> > > > On Wed, Mar 20, 2019 at 01:28:47PM -0400, Jason Andryuk wrote:
> > > > > On Fri, Mar 15, 2019 at 12:28 PM Andrew Cooper
> > > > > <andrew.cooper3@citrix.com> wrote:
> > > > > >
> > > > > > On 15/03/2019 09:17, Paul Durrant wrote:
> > > > > > >> -----Original Message-----
> > > > > > >> From: Jason Andryuk [mailto:jandryuk@gmail.com]
> > > > > > >> Sent: 14 March 2019 18:16
> > > > > > >> To: Paul Durrant <Paul.Durrant@citrix.com>
> > > > > > >> Cc: qemu-devel@nongnu.org; xen-devel@lists.xenproject.org; m=
armarek@invisiblethingslab.com; Simon
> > > > > > >> Gaiser <simon@invisiblethingslab.com>; Stefano Stabellini <s=
stabellini@kernel.org>; Anthony Perard
> > > > > > >> <anthony.perard@citrix.com>
> > > > > > >> Subject: Re: [PATCH 6/6] xen-pt: Round pci regions sizes to =
XEN_PAGE_SIZE
> > > > > > >>
> > > > > > >> On Wed, Mar 13, 2019 at 11:09 AM Paul Durrant <Paul.Durrant@=
citrix.com> wrote:
> > > > > > >>>> -----Original Message-----
> > > > > > >>>> From: Jason Andryuk [mailto:jandryuk@gmail.com]
> > > > > > >>>> Sent: 11 March 2019 18:02
> > > > > > >>>> To: qemu-devel@nongnu.org
> > > > > > >>>> Cc: xen-devel@lists.xenproject.org; marmarek@invisiblethin=
gslab.com; Simon Gaiser
> > > > > > >>>> <simon@invisiblethingslab.com>; Jason Andryuk <jandryuk@gm=
ail.com>; Stefano Stabellini
> > > > > > >>>> <sstabellini@kernel.org>; Anthony Perard <anthony.perard@c=
itrix.com>; Paul Durrant
> > > > > > >>>> <Paul.Durrant@citrix.com>
> > > > > > >>>> Subject: [PATCH 6/6] xen-pt: Round pci regions sizes to XE=
N_PAGE_SIZE
> > > > > > >>>>
> > > > > > >>>> From: Simon Gaiser <simon@invisiblethingslab.com>
> > > > > > >>>>
> > > > > > >>>> If a pci memory region has a size < XEN_PAGE_SIZE it can g=
et located at
> > > > > > >>>> an address which is not page aligned.
> > > > > > >>> IIRC the PCI spec says that the minimum memory region size =
should be at least 4k. Should we even be
> > > > > > >> tolerating BARs smaller than that?
> > > > > > >>>   Paul
> > > > > > >>>
> > > > > > >> Hi, Paul.
> > > > > > >>
> > > > > > >> Simon found this, so it affects a real device.  Simon, do yo=
u recall
> > > > > > >> which device was affected?
> > > > > > >>
> > > > > > >> I think BARs only need to be power-of-two size and aligned, =
and 4k is
> > > > > > >> not a minimum.  16bytes may be a minimum, but I don't know w=
hat the
> > > > > > >> spec says.
> > > > > > >>
> > > > > > >> On an Ivy Bridge system, here are some of the devices with B=
ARs smaller than 4K:
> > > > > > >> 00:16.0 Communication controller: Intel Corporation 7 Series=
/C210
> > > > > > >> Series Chipset Family MEI Controller #1 (rev 04)
> > > > > > >>    Memory at d0735000 (64-bit, non-prefetchable) [disabled] =
[size=3D16]
> > > > > > >> 00:1d.0 USB controller: Intel Corporation 7 Series/C210 Seri=
es Chipset
> > > > > > >> Family USB Enhanced Host Controller #1 (rev 04) (prog-if 20 =
[EHCI])
> > > > > > >>    Memory at d0739000 (32-bit, non-prefetchable) [disabled] =
[size=3D1K]
> > > > > > >> 00:1f.3 SMBus: Intel Corporation 7 Series/C210 Series Chipse=
t Family
> > > > > > >> SMBus Controller (rev 04)
> > > > > > >>    Memory at d0734000 (64-bit, non-prefetchable) [disabled] =
[size=3D256]
> > > > > > >> 02:00.0 System peripheral: JMicron Technology Corp. SD/MMC H=
ost
> > > > > > >> Controller (rev 30)
> > > > > > >>    Memory at d0503000 (32-bit, non-prefetchable) [disabled] =
[size=3D256]
> > > > > > >>
> > > > > > >> These examples are all 4K aligned, so this is not an issue o=
n this machine.
> > > > > > >>
> > > > > > >> Reviewing the code, I'm now wondering if the following in
> > > > > > >> hw/xen/xen_pt.c:xen_pt_region_update is wrong:        rc =3D
> > > > > > >> xc_domain_memory_mapping(xen_xc, xen_domid,
> > > > > > >>                                      XEN_PFN(guest_addr + XC=
_PAGE_SIZE - 1),
> > > > > > >>                                      XEN_PFN(machine_addr + =
XC_PAGE_SIZE - 1),
> > > > > > >>                                      XEN_PFN(size + XC_PAGE_=
SIZE - 1),
> > > > > > >>                                      op);
> > > > > > >>
> > > > > > >> If a bar of size 0x100 is at 0xd0500800, then the machine_ad=
dr passed
> > > > > > >> in would be 0xd0501000 which is past the actual location.  S=
hould the
> > > > > > >> call arguments just be XEN_PFN(guest_addr) & XEN_PFN(machine=
_addr)?
> > > > > > >>
> > > > > > >> BARs smaller than a page would also be a problem if BARs for=
 different
> > > > > > >> devices shared the same page.
> > > > > > > Exactly. We cannot pass them through with any degree of safet=
y (not that passthrough of an arbitrary device is a particularly safe thing=
 to do anyway). The xen-pt code would instead need to trap those BARs and p=
erform the accesses to the real BAR itself. Ultimately though I think we sh=
ould be retiring the xen-pt code in favour of a standalone emulator.
> > > > > >
> > > > > > It doesn't matter if the BAR is smaller than 4k, if there are h=
oles next
> > > > > > to it.
> > > > > >
> > > > > > Do we know what the case is in practice for these USB controlle=
rs?
> > > > > >
> > > > > > If the worst comes to the worst, we can re-enumerate the PCI bu=
s to
> > > > > > ensure that all bars smaller than 4k still have 4k alignment be=
tween
> > > > > > them.  That way we can safely pass them through even when they =
are smaller.
> > > > >
> > > > > Andrew, thanks for checking the spec on the minimum BAR size.
> > > > >
> > > > > Dropping the Round PCI region patch from QMEU, the guest HVM will=
 have:
> > > > >
> > > > > 00:06.0 SD Host controller: Ricoh Co Ltd PCIe SDXC/MMC Host Contr=
oller (rev 07)
> > > > >     Memory at f2028800 (32-bit, non-prefetchable) [size=3D256]
> > > > > 00:07.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host
> > > > > Controller (rev 04) (prog-if 30 [XHCI])
> > > > >     Memory at f2024000 (64-bit, non-prefetchable) [size=3D8K]
> > > > > 00:08.0 USB controller: Intel Corporation 6 Series/C200 Series Ch=
ipset
> > > > > Family USB Enhanced Host Controller #2 (rev 05) (prog-if 20 [EHCI=
])
> > > > >     Memory at f2028000 (32-bit, non-prefetchable) [size=3D1K]
> > > > > 00:09.0 USB controller: Intel Corporation 6 Series/C200 Series Ch=
ipset
> > > > > Family USB Enhanced Host Controller #1 (rev 05) (prog-if 20 [EHCI=
])
> > > > >     Memory at f2028400 (32-bit, non-prefetchable) [size=3D1K]
> > > > >
> > > > > 00:09.0, 00:08.0 & 00:06.0 all share the same page.  Only 00:08.0=
 is
> > > > > working.  With some added debugging output, you'll see that the s=
ame
> > > > > page* is used for three of the BARs.
> > > > >
> > > > > [00:06.0] mapping guest_addr 0xf2028800 gfn 0xf2028 to maddr
> > > > > 0xe1a30000 mfn 0xe1a30
> > > > > [00:07.0] mapping guest_addr 0xf2024000 gfn 0xf2024 to maddr
> > > > > 0xe0800000 mfn 0xe0800
> > > > > [00:09.0] mapping guest_addr 0xf2028400 gfn 0xf2028 to maddr
> > > > > 0xe1900000 mfn 0xe1900
> > > > > [00:08.0] mapping guest_addr 0xf2028000 gfn 0xf2028 to maddr
> > > > > 0xe1a2f000 mfn 0xe1a2f
> > > >
> > > > The patch below should prevent hvmloader from placing multiple BARs=
 on
> > > > the same page, could you give it a try?
> > > >
> > > > Note that this is not going to prevent the guest from moving those
> > > > BARs around and place them in the same page, thus breaking the init=
ial
> > > > placement done by hvmloader.
> > > >
> > > > Thanks, Roger.
> > >
> > > Hi, Roger.
> > >
> > > I've minimally tested this.  Yes, this patch seems to place small BAR=
s
> > > into separate pages.  The linux stubdom and QEMU then use the spacing
> > > as provided by hvmloader.
> >
> > Roger,
> >
> > Would you mind submitting this patch to Xen?
>
> Hm, I'm half minded regarding this patch. It feels more like a bandaid
> than a proper solution. Mapping BARs not multiple of page-sizes is
> dangerous because AFAIK there's no entity that asserts there isn't any
> other BAR from a different device on the same page, and hence you
> might end up mapping some MMIO region from another device
> inadvertently.

We have the guest, linux stubdom with qemu, & dom0. Are you concerned
that all of them need a minimum of page alignment?

Linux PCI subsytem has an option resource_alignment that can be
applied to either a single device or all devices.  Booting with
pci=3Dresource_aligment=3D4096 will align each device to a page.  Do you
think pciback should force resource_alignment=3D4096 for dom0?  Are
there other MMIO ranges to be concerned about adjacent to BARs?

On my one test machine with a BAR smaller than 4096, the firmware
already sets an alignment of 4096.  Linux dom0 seems to keep the
firmware BAR alignment by default.

> Anyway, I can formally submit the patch since it's no worse than
> what's currently done, but I would clearly state this is not safe in
> it's current state.

Regards,
Jason

