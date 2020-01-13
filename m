Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD98EC33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 19:02:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 869A9214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 19:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtbTMiUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869A9214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir4zK-0008CS-J4
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 14:02:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jandryuk@gmail.com>) id 1ir4yQ-0007ii-Nd
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 14:02:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jandryuk@gmail.com>) id 1ir4yO-0006EG-MY
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 14:02:02 -0500
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:36941)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jandryuk@gmail.com>) id 1ir4yO-0006Cn-Be
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 14:02:00 -0500
Received: by mail-lf1-x143.google.com with SMTP id b15so7707953lfc.4
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 11:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6++MrcCBmrVxPhrUnlMDVibQ7hwF8CWrqhrWWkblI9c=;
 b=PtbTMiUE/Fav3osb1BGGCxgiEaPqd+zywdMwCgiSxqo71To3O5mk5v7GxoX9rX1oC5
 WXZWZEzZlyLcFGRc56JK4rW0B8UVYdQ9abAo0fujgxU/mcyVcLKd0jBn2gtld/GZPhux
 4gyes/P2dP61dwC9rYleMWjYy6FiSur7hhGxdui6MnvK1ZQFquDql3gRqYJHrjezBgwH
 pifXBwVev/1ni/cQxQqVJJ9niir23KV9PBGUybkmpDZyejaM5N6uif+71aI8JAyRAKM6
 w57AFBTTiQDkt8qraUHykQnXxpCEnFD4WtVXVHILn3JbSkAPTK/btCqiv9p1VlPSyiKw
 Rz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6++MrcCBmrVxPhrUnlMDVibQ7hwF8CWrqhrWWkblI9c=;
 b=SnEwc1wh5gKiMHjVSLiN0OByu+Y7DZuR2WuObS4346VQHlJi3ehy4WRRln7u0i3ADq
 5DwZBd7Uw5ZPdLPeF+W5CqEb2rP26B4Z2hRAorqPRiqv1SP1hIW1izLCL247WfwiT24Q
 TBQtM1klVDCTozXrQ3uICjPoU4XHOEIIEiLd8OSMK6yc/H99nAyVPCTtDMwVSdmZosKs
 16+2yhHIwR6VdLDZ2AdAQYInaDORfUHISYaNuzkMhsNOjn0pGM+3/trsoA2MwCuTu8D8
 0kNU8G7sV4GvW3+NWstoAg82dd3fcCttN7+FSzEvsSQkR+8OXdbI8M5yc2V63fS6YSH7
 pbvg==
X-Gm-Message-State: APjAAAUcX+tpXavkgQEsTcu9HfxlIYmo7uGz/gTCz0AH5J9EoH3oCbeq
 +UhlKQkGqva0xR/Go0jbExDk5jztTX/Y0sGhR6M=
X-Google-Smtp-Source: APXvYqw+g2vrAm9cX7AKpyLZVnr+yOD4d87+gCmZ7HeFY1maN99qm3O85Pz18oxwtUipoT6e0XyY2nr9OF39AJqVUGo=
X-Received: by 2002:ac2:4add:: with SMTP id m29mr10353482lfp.190.1578942118569; 
 Mon, 13 Jan 2020 11:01:58 -0800 (PST)
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
In-Reply-To: <CAKf6xptP_b-+FuscjsTK9G7pMeVS8drvA_t+xb5bdF2zxxmWfA@mail.gmail.com>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Mon, 13 Jan 2020 14:01:47 -0500
Message-ID: <CAKf6xpscx9Yukphv7mfK2BPM8HoGW0ddt9zbOZxpV+9LzWxz4g@mail.gmail.com>
Subject: Re: [Xen-devel] [PATCH 6/6] xen-pt: Round pci regions sizes to
 XEN_PAGE_SIZE
To: =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
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
 Simon Gaiser <simon@invisiblethingslab.com>,
 Paul Durrant <Paul.Durrant@citrix.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 22, 2019 at 3:43 PM Jason Andryuk <jandryuk@gmail.com> wrote:
>
> On Thu, Mar 21, 2019 at 11:09 PM Roger Pau Monn=C3=A9 <roger.pau@citrix.c=
om> wrote:
> >
> > On Wed, Mar 20, 2019 at 01:28:47PM -0400, Jason Andryuk wrote:
> > > On Fri, Mar 15, 2019 at 12:28 PM Andrew Cooper
> > > <andrew.cooper3@citrix.com> wrote:
> > > >
> > > > On 15/03/2019 09:17, Paul Durrant wrote:
> > > > >> -----Original Message-----
> > > > >> From: Jason Andryuk [mailto:jandryuk@gmail.com]
> > > > >> Sent: 14 March 2019 18:16
> > > > >> To: Paul Durrant <Paul.Durrant@citrix.com>
> > > > >> Cc: qemu-devel@nongnu.org; xen-devel@lists.xenproject.org; marma=
rek@invisiblethingslab.com; Simon
> > > > >> Gaiser <simon@invisiblethingslab.com>; Stefano Stabellini <sstab=
ellini@kernel.org>; Anthony Perard
> > > > >> <anthony.perard@citrix.com>
> > > > >> Subject: Re: [PATCH 6/6] xen-pt: Round pci regions sizes to XEN_=
PAGE_SIZE
> > > > >>
> > > > >> On Wed, Mar 13, 2019 at 11:09 AM Paul Durrant <Paul.Durrant@citr=
ix.com> wrote:
> > > > >>>> -----Original Message-----
> > > > >>>> From: Jason Andryuk [mailto:jandryuk@gmail.com]
> > > > >>>> Sent: 11 March 2019 18:02
> > > > >>>> To: qemu-devel@nongnu.org
> > > > >>>> Cc: xen-devel@lists.xenproject.org; marmarek@invisiblethingsla=
b.com; Simon Gaiser
> > > > >>>> <simon@invisiblethingslab.com>; Jason Andryuk <jandryuk@gmail.=
com>; Stefano Stabellini
> > > > >>>> <sstabellini@kernel.org>; Anthony Perard <anthony.perard@citri=
x.com>; Paul Durrant
> > > > >>>> <Paul.Durrant@citrix.com>
> > > > >>>> Subject: [PATCH 6/6] xen-pt: Round pci regions sizes to XEN_PA=
GE_SIZE
> > > > >>>>
> > > > >>>> From: Simon Gaiser <simon@invisiblethingslab.com>
> > > > >>>>
> > > > >>>> If a pci memory region has a size < XEN_PAGE_SIZE it can get l=
ocated at
> > > > >>>> an address which is not page aligned.
> > > > >>> IIRC the PCI spec says that the minimum memory region size shou=
ld be at least 4k. Should we even be
> > > > >> tolerating BARs smaller than that?
> > > > >>>   Paul
> > > > >>>
> > > > >> Hi, Paul.
> > > > >>
> > > > >> Simon found this, so it affects a real device.  Simon, do you re=
call
> > > > >> which device was affected?
> > > > >>
> > > > >> I think BARs only need to be power-of-two size and aligned, and =
4k is
> > > > >> not a minimum.  16bytes may be a minimum, but I don't know what =
the
> > > > >> spec says.
> > > > >>
> > > > >> On an Ivy Bridge system, here are some of the devices with BARs =
smaller than 4K:
> > > > >> 00:16.0 Communication controller: Intel Corporation 7 Series/C21=
0
> > > > >> Series Chipset Family MEI Controller #1 (rev 04)
> > > > >>    Memory at d0735000 (64-bit, non-prefetchable) [disabled] [siz=
e=3D16]
> > > > >> 00:1d.0 USB controller: Intel Corporation 7 Series/C210 Series C=
hipset
> > > > >> Family USB Enhanced Host Controller #1 (rev 04) (prog-if 20 [EHC=
I])
> > > > >>    Memory at d0739000 (32-bit, non-prefetchable) [disabled] [siz=
e=3D1K]
> > > > >> 00:1f.3 SMBus: Intel Corporation 7 Series/C210 Series Chipset Fa=
mily
> > > > >> SMBus Controller (rev 04)
> > > > >>    Memory at d0734000 (64-bit, non-prefetchable) [disabled] [siz=
e=3D256]
> > > > >> 02:00.0 System peripheral: JMicron Technology Corp. SD/MMC Host
> > > > >> Controller (rev 30)
> > > > >>    Memory at d0503000 (32-bit, non-prefetchable) [disabled] [siz=
e=3D256]
> > > > >>
> > > > >> These examples are all 4K aligned, so this is not an issue on th=
is machine.
> > > > >>
> > > > >> Reviewing the code, I'm now wondering if the following in
> > > > >> hw/xen/xen_pt.c:xen_pt_region_update is wrong:        rc =3D
> > > > >> xc_domain_memory_mapping(xen_xc, xen_domid,
> > > > >>                                      XEN_PFN(guest_addr + XC_PAG=
E_SIZE - 1),
> > > > >>                                      XEN_PFN(machine_addr + XC_P=
AGE_SIZE - 1),
> > > > >>                                      XEN_PFN(size + XC_PAGE_SIZE=
 - 1),
> > > > >>                                      op);
> > > > >>
> > > > >> If a bar of size 0x100 is at 0xd0500800, then the machine_addr p=
assed
> > > > >> in would be 0xd0501000 which is past the actual location.  Shoul=
d the
> > > > >> call arguments just be XEN_PFN(guest_addr) & XEN_PFN(machine_add=
r)?
> > > > >>
> > > > >> BARs smaller than a page would also be a problem if BARs for dif=
ferent
> > > > >> devices shared the same page.
> > > > > Exactly. We cannot pass them through with any degree of safety (n=
ot that passthrough of an arbitrary device is a particularly safe thing to =
do anyway). The xen-pt code would instead need to trap those BARs and perfo=
rm the accesses to the real BAR itself. Ultimately though I think we should=
 be retiring the xen-pt code in favour of a standalone emulator.
> > > >
> > > > It doesn't matter if the BAR is smaller than 4k, if there are holes=
 next
> > > > to it.
> > > >
> > > > Do we know what the case is in practice for these USB controllers?
> > > >
> > > > If the worst comes to the worst, we can re-enumerate the PCI bus to
> > > > ensure that all bars smaller than 4k still have 4k alignment betwee=
n
> > > > them.  That way we can safely pass them through even when they are =
smaller.
> > >
> > > Andrew, thanks for checking the spec on the minimum BAR size.
> > >
> > > Dropping the Round PCI region patch from QMEU, the guest HVM will hav=
e:
> > >
> > > 00:06.0 SD Host controller: Ricoh Co Ltd PCIe SDXC/MMC Host Controlle=
r (rev 07)
> > >     Memory at f2028800 (32-bit, non-prefetchable) [size=3D256]
> > > 00:07.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host
> > > Controller (rev 04) (prog-if 30 [XHCI])
> > >     Memory at f2024000 (64-bit, non-prefetchable) [size=3D8K]
> > > 00:08.0 USB controller: Intel Corporation 6 Series/C200 Series Chipse=
t
> > > Family USB Enhanced Host Controller #2 (rev 05) (prog-if 20 [EHCI])
> > >     Memory at f2028000 (32-bit, non-prefetchable) [size=3D1K]
> > > 00:09.0 USB controller: Intel Corporation 6 Series/C200 Series Chipse=
t
> > > Family USB Enhanced Host Controller #1 (rev 05) (prog-if 20 [EHCI])
> > >     Memory at f2028400 (32-bit, non-prefetchable) [size=3D1K]
> > >
> > > 00:09.0, 00:08.0 & 00:06.0 all share the same page.  Only 00:08.0 is
> > > working.  With some added debugging output, you'll see that the same
> > > page* is used for three of the BARs.
> > >
> > > [00:06.0] mapping guest_addr 0xf2028800 gfn 0xf2028 to maddr
> > > 0xe1a30000 mfn 0xe1a30
> > > [00:07.0] mapping guest_addr 0xf2024000 gfn 0xf2024 to maddr
> > > 0xe0800000 mfn 0xe0800
> > > [00:09.0] mapping guest_addr 0xf2028400 gfn 0xf2028 to maddr
> > > 0xe1900000 mfn 0xe1900
> > > [00:08.0] mapping guest_addr 0xf2028000 gfn 0xf2028 to maddr
> > > 0xe1a2f000 mfn 0xe1a2f
> >
> > The patch below should prevent hvmloader from placing multiple BARs on
> > the same page, could you give it a try?
> >
> > Note that this is not going to prevent the guest from moving those
> > BARs around and place them in the same page, thus breaking the initial
> > placement done by hvmloader.
> >
> > Thanks, Roger.
>
> Hi, Roger.
>
> I've minimally tested this.  Yes, this patch seems to place small BARs
> into separate pages.  The linux stubdom and QEMU then use the spacing
> as provided by hvmloader.

Roger,

Would you mind submitting this patch to Xen?

Thanks,
Jason

>
>
> > ---8<---
> > diff --git a/tools/firmware/hvmloader/pci.c b/tools/firmware/hvmloader/=
pci.c
> > index 0b708bf578..c433b34cd6 100644
> > --- a/tools/firmware/hvmloader/pci.c
> > +++ b/tools/firmware/hvmloader/pci.c
> > @@ -489,6 +489,10 @@ void pci_setup(void)
> >
> >          resource->base =3D base;
> >
> > +        if ( (bar_data & PCI_BASE_ADDRESS_SPACE) =3D=3D
> > +             PCI_BASE_ADDRESS_SPACE_MEMORY )
> > +            resource->base =3D ROUNDUP(resource->base, PAGE_SIZE);
> > +
> >          pci_writel(devfn, bar_reg, bar_data);
> >          if (using_64bar)
> >              pci_writel(devfn, bar_reg + 4, bar_data_upper);
> > diff --git a/tools/firmware/hvmloader/util.h b/tools/firmware/hvmloader=
/util.h
> > index 7bca6418d2..b5554b5844 100644
> > --- a/tools/firmware/hvmloader/util.h
> > +++ b/tools/firmware/hvmloader/util.h
> > @@ -51,6 +51,8 @@ void __bug(char *file, int line) __attribute__((noret=
urn));
> >  #define MB(mb) (mb##ULL << 20)
> >  #define GB(gb) (gb##ULL << 30)
> >
> > +#define ROUNDUP(x, a) (((x) + (a) - 1) & ~((a) - 1))
> > +
> >  static inline int test_bit(unsigned int b, const void *p)
> >  {
> >      return !!(((const uint8_t *)p)[b>>3] & (1u<<(b&7)));
> >

