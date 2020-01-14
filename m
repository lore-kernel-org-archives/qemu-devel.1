Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E16AC33CB2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 18:06:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E9E2465A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 18:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="CReMT7Gh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E9E2465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irQa2-0004Em-3p
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 13:06:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49474)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <roger.pau@citrix.com>) id 1irQZL-0003hF-VG
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 13:05:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <roger.pau@citrix.com>) id 1irQZH-0008Dt-OL
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 13:05:35 -0500
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:62274)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <roger.pau@citrix.com>)
 id 1irQZH-0008DL-El
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 13:05:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1579025131;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=crf+I3wnXQ44AOltWJZ4HXcnTWZ7HnfpUxIZ9muk0MY=;
 b=CReMT7Gh6EdV5cdxtpvgDd9J1A4B7J6OPlkeeoHmAO44TsHN/aMtEusG
 PuRAbD90g2ooJqKn54tPoY6LRJEtSz5IbDP0mVvhtC1BemsjciRG91Bc5
 IqBIUqLmJbz0zc6N8hHJTzvaDjXGf3YXE7S2wb7JBbuWBw3adWOTIu1pu k=;
Authentication-Results: esa6.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=roger.pau@citrix.com;
 spf=Pass smtp.mailfrom=roger.pau@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
 receiver=esa6.hc3370-68.iphmx.com;
 envelope-from="roger.pau@citrix.com";
 x-sender="roger.pau@citrix.com"; x-conformance=sidf_compatible
Received-SPF: Pass (esa6.hc3370-68.iphmx.com: domain of
 roger.pau@citrix.com designates 162.221.158.21 as permitted
 sender) identity=mailfrom; client-ip=162.221.158.21;
 receiver=esa6.hc3370-68.iphmx.com;
 envelope-from="roger.pau@citrix.com";
 x-sender="roger.pau@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
 ip4:168.245.78.127 ~all"
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
 envelope-from="roger.pau@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: Sc3x1A6ID8s2CRScL6qhKxLOGme1y5VckC7IpP3FcCYuozqQgeLOBq5bi3GutB0/k9Jr+AM8RA
 mU85K38Cx6AHDCJrfOyNYaekmecteLwAasW/qnzbYI/JTz2nNowJ6DBTcM3GD857w6wHs7ItyB
 UpKil7h9e9V7Kl+DmQssouvx0GpMt/q8h+KeuP4d8vT+ZuAkYgXyennTr7jzIyA4+16qzA7idK
 QPlUNfnA23yAJeN611WaAszBuoKJT930wcyrXNLTy/rbPg6a/kmtIQk/ubIJMsfod6yRFdfh/4
 HZM=
X-SBRS: 2.7
X-MesageID: 11335295
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.70,319,1574139600"; d="scan'208";a="11335295"
Date: Tue, 14 Jan 2020 19:04:57 +0100
From: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To: Jason Andryuk <jandryuk@gmail.com>
Subject: Re: [Xen-devel] [PATCH 6/6] xen-pt: Round pci regions sizes to
 XEN_PAGE_SIZE
Message-ID: <20200114180457.GG11756@Air-de-Roger>
References: <ee0da83d3f054e72ae450437c8834d04@AMSPEX02CL02.citrite.net>
 <CAKf6xpujVs3RPJcb+2vqPZFcYwhdDcjbt=S_+awjPuPFpFHsPw@mail.gmail.com>
 <57dc1083d20a469785f05a2e5250a820@AMSPEX02CL02.citrite.net>
 <cd5f1ecc-576f-b7d0-3090-4f3e4faf6148@citrix.com>
 <CAKf6xpt4XYXn2xHJoVY_ibcaHSw-ED10V7ZGNKuDdkiJ93RS0A@mail.gmail.com>
 <20190322030936.fkiajz5ifgaejkd4@MacBook-Air-de-Roger.local>
 <CAKf6xptP_b-+FuscjsTK9G7pMeVS8drvA_t+xb5bdF2zxxmWfA@mail.gmail.com>
 <CAKf6xpscx9Yukphv7mfK2BPM8HoGW0ddt9zbOZxpV+9LzWxz4g@mail.gmail.com>
 <20200114100406.GF11756@Air-de-Roger>
 <CAKf6xpuDo=FGTOJ9ipmk7nY+qs+pKBWESqY0ah6B1vS3kZsT=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKf6xpuDo=FGTOJ9ipmk7nY+qs+pKBWESqY0ah6B1vS3kZsT=A@mail.gmail.com>
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL01.citrite.net (10.69.22.125)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.155.175
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

On Tue, Jan 14, 2020 at 09:41:46AM -0500, Jason Andryuk wrote:
> On Tue, Jan 14, 2020 at 5:04 AM Roger Pau Monné <roger.pau@citrix.com> wrote:
> >
> > On Mon, Jan 13, 2020 at 02:01:47PM -0500, Jason Andryuk wrote:
> > > On Fri, Mar 22, 2019 at 3:43 PM Jason Andryuk <jandryuk@gmail.com> wrote:
> > > >
> > > > On Thu, Mar 21, 2019 at 11:09 PM Roger Pau Monné <roger.pau@citrix.com> wrote:
> > > > >
> > > > > The patch below should prevent hvmloader from placing multiple BARs on
> > > > > the same page, could you give it a try?
> > > > >
> > > > > Note that this is not going to prevent the guest from moving those
> > > > > BARs around and place them in the same page, thus breaking the initial
> > > > > placement done by hvmloader.
> > > > >
> > > > > Thanks, Roger.
> > > >
> > > > Hi, Roger.
> > > >
> > > > I've minimally tested this.  Yes, this patch seems to place small BARs
> > > > into separate pages.  The linux stubdom and QEMU then use the spacing
> > > > as provided by hvmloader.
> > >
> > > Roger,
> > >
> > > Would you mind submitting this patch to Xen?
> >
> > Hm, I'm half minded regarding this patch. It feels more like a bandaid
> > than a proper solution. Mapping BARs not multiple of page-sizes is
> > dangerous because AFAIK there's no entity that asserts there isn't any
> > other BAR from a different device on the same page, and hence you
> > might end up mapping some MMIO region from another device
> > inadvertently.
> 
> We have the guest, linux stubdom with qemu, & dom0. Are you concerned
> that all of them need a minimum of page alignment?

No, not really. The hardware domain (dom0 in normal deployments)
should be the one that makes sure there are no BARs sharing physical
pages.

> Linux PCI subsytem has an option resource_alignment that can be
> applied to either a single device or all devices.  Booting with
> pci=resource_aligment=4096 will align each device to a page.  Do you
> think pciback should force resource_alignment=4096 for dom0?

Ideally Xen should keep track of the BARs position and size and refuse
to passthrough devices that have BARs sharing a page with other
devices BARs.

> Are
> there other MMIO ranges to be concerned about adjacent to BARs?

IIRC you can have two BARs of different devices in the same 4K page,
BARs are only aligned to it's size, so BARs smaller than 4K are not
required to be page aligned.

> On my one test machine with a BAR smaller than 4096, the firmware
> already sets an alignment of 4096.  Linux dom0 seems to keep the
> firmware BAR alignment by default.

The PCI spec recommend BARs to be sized to a multiple of a page size, but
sadly that's not a mandatory requirement.

Will submit the patch now, thanks for the ping, I completely forgot
about this TBH.

Roger.

