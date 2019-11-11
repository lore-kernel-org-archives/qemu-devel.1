Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F93C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 10:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC837214DB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 10:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC837214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU71Z-0007Zl-Uz
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 05:34:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1iU70f-00073i-1b
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:33:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1iU70d-0006Ng-ON
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:33:24 -0500
Received: from charlie.dont.surf ([128.199.63.193]:51944)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1iU70d-0006Ie-AF; Mon, 11 Nov 2019 05:33:23 -0500
Received: from apples.localdomain (unknown [194.62.217.57])
 by charlie.dont.surf (Postfix) with ESMTPSA id A8CDABF600;
 Mon, 11 Nov 2019 10:33:20 +0000 (UTC)
Date: Mon, 11 Nov 2019 11:33:17 +0100
From: Klaus Birkelund <its@irrelevant.dk>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/1] pci: pass along the return value of dma_memory_rw
Message-ID: <20191111103317.GA238995@apples.localdomain>
References: <20191011070141.188713-1-its@irrelevant.dk>
 <20191011070141.188713-2-its@irrelevant.dk>
 <455e6dee-8dd8-fae7-5a2f-e175b9d1cb8d@redhat.com>
 <20191111093007.GA109346@apples.localdomain>
 <20191111051055-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20191111051055-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 128.199.63.193
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 11, 2019 at 05:16:41AM -0500, Michael S. Tsirkin wrote:
> On Mon, Nov 11, 2019 at 10:30:07AM +0100, Klaus Birkelund wrote:
> > On Thu, Oct 24, 2019 at 01:13:36AM +0200, Philippe Mathieu-Daud=E9 wr=
ote:
> > > On 10/11/19 9:01 AM, Klaus Jensen wrote:
> > > > Some might actually care about the return value of dma_memory_rw.=
 So
> > > > let us pass it along instead of ignoring it.
> > > >=20
> > > > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > > > ---
> > > >   include/hw/pci/pci.h | 3 +--
> > > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > > > index f3f0ffd5fb78..4e95bb847857 100644
> > > > --- a/include/hw/pci/pci.h
> > > > +++ b/include/hw/pci/pci.h
> > > > @@ -779,8 +779,7 @@ static inline AddressSpace *pci_get_address_s=
pace(PCIDevice *dev)
> > > >   static inline int pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
> > > >                                void *buf, dma_addr_t len, DMADire=
ction dir)
> > > >   {
> > > > -    dma_memory_rw(pci_get_address_space(dev), addr, buf, len, di=
r);
> > > > -    return 0;
> > > > +    return dma_memory_rw(pci_get_address_space(dev), addr, buf, =
len, dir);
> > > >   }
> > > >   static inline int pci_dma_read(PCIDevice *dev, dma_addr_t addr,
> > > >=20
> > >=20
> > > Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> >=20
> > Gentle ping on this.
> >=20
> > This fix is required for the nvme device to start passing some of the
> > nasty tests from blktests that flips bus mastering while doing I/O.
> >=20
> >=20
> > Cheers,
> > Klaus
>=20
> So I looked and it does not seem like anyone at all checks the
> return value. While this makes the patch safe, how come it
> helps anyone at all?

I have a series[1] under review for the nvme device (I should have
mentioned that). There is a certain test (block/011) from blktests[2],
that disables the PCI device while doing I/O by flipping the bus master
register. QEMU correctly understands this which causes the dma_memory_rw
calls to fail while the device is not a bus master. For the NVMe device
to pass that test, it needs to know that it could not do the DMA,
otherwise it will just think that a completion queue entry was
successfully posted or data was correctly read.

> Maybe this is just infrastructure to allow checks in the
> future, in this case do we need this for the freeze?
> Or can it wait until after the release?
>=20

The series I'm mentioning won't be going into the release, so yeah - it
can surely wait. I was just pinging to make sure someone would pick it
up at some point :)
=20
    [1]: https://patchwork.kernel.org/cover/11190045/
    [2]: https://github.com/osandov/blktests

