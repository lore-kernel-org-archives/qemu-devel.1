Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52C2C33CA2
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 16:07:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B987120661
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 16:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B987120661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipaLT-0002QB-Rs
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 11:07:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ipaKg-0001h8-4q
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 11:06:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ipaKe-0007Qj-5i
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 11:06:49 -0500
Received: from 6.mo177.mail-out.ovh.net ([46.105.51.249]:32775)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ipaKd-0007ET-TL
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 11:06:48 -0500
Received: from player787.ha.ovh.net (unknown [10.108.54.13])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 5D4B911DC10
 for <qemu-devel@nongnu.org>; Thu,  9 Jan 2020 17:06:45 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player787.ha.ovh.net (Postfix) with ESMTPSA id 551B7E392BDD;
 Thu,  9 Jan 2020 16:06:42 +0000 (UTC)
Date: Thu, 9 Jan 2020 17:06:40 +0100
From: Greg Kurz <groug@kaod.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: Prevent double swap due to target pre 1.0 VirtIO
Message-ID: <20200109170640.4c3fa148@bahia.lan>
In-Reply-To: <20200109073529-mutt-send-email-mst@kernel.org>
References: <20200108161618.221116-1-afscoelho@gmail.com>
 <20200109054233-mutt-send-email-mst@kernel.org>
 <CAGTcC7yLjP5h4oWfgvrOYobChW-cw-oL5EBmMCH45O41+yuvyA@mail.gmail.com>
 <20200109073529-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 5734208229011986905
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiuddghedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuffhomhgrihhnpehqvghmuhdrohhrghenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.51.249
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
Cc: =?UTF-8?B?QW5kcsOp?= Silva <afscoelho@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 Jan 2020 07:39:17 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Jan 09, 2020 at 09:25:42AM -0300, Andr=C3=A9 Silva wrote:
> > Hi Michael!
> > Thanks for reviewing the patch!
> >=20
> > > we always get LE values from memory subsystem,
> > > not target endian values:
> >=20
> > I see. So do you think the patch is correct in eliminating the extra
> > swap (as virtio_config_readw for example already makes a swap)?
> >=20
> > Thanks,
> > andr=C3=A9
>=20
> I don't think it is, I think we do need an extra swap
> in some cases. It's possible that some cross-endian
> setups are broken now, if so pls include testing
> result not just theoretical analysis.
>=20

I confirm that we must keep the extra swap otherwise
read/write in cross-endian setups will have wrong
endian. Please read this commit for a more detailed
explanation:

commit 82afa58641b0e67abbaf4da6c325ebd7c2513262
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Tue Jan 10 01:35:11 2012 +0000

    virtio-pci: Fix endianness of virtio config

https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D82afa58641b0e67abbaf4=
da6c325ebd7c2513262

This is especially critical on ppc64 since _all_ hosts are now LE
but the first piece of code in the guest that is likely to drive
the device is the SLOF firmware which is BE.

This is what we get with this patch when trying to run a pseries guest on a
ppc64le host:

Trying to load:  from: /pci@800000020000000/scsi@0 ... virtioblk_transfer: =
Access beyond end of device!

Cheers,

--
Greg

> > On Thu, Jan 9, 2020 at 7:50 AM Michael S. Tsirkin <mst@redhat.com> wrot=
e:
> > >
> > > On Wed, Jan 08, 2020 at 01:16:18PM -0300, Andre Silva wrote:
> > > > Remove the bswap function calls after reading and before writing
> > > > memory bytes in virtio_pci_config_read and virtio_pci_config_write
> > > > because they are reverting back an already swapped bytes.
> > > >
> > > > Consider the table below in the context of virtio_pci_config_read
> > > > function.
> > > >
> > > > Host   Target  virtio-config-read[wl]
> > > >                swap?                   virtio-is-big-endian?   extr=
a bswap?   Should be   Final result   Final result ok?
> > > > ----- ------- ------------------------ ----------------------- ----=
---------- ----------- -------------- ------------------
> > > > LE     BE      s(x)                    true                    s(s(=
x))        s(x)        x              No
> > > > LE     LE      x                       false                   -   =
           x           x              Yes
> > > > BE     LE      s(x)                    false                   -   =
           s(x)        s(x)           Yes
> > > > BE     BE      x                       true                    s(x)=
           x           s(x)           No
> > >
> > > we always get LE values from memory subsystem,
> > > not target endian values:
> > >
> > > static const MemoryRegionOps virtio_pci_config_ops =3D {
> > >     .read =3D virtio_pci_config_read,
> > >     .write =3D virtio_pci_config_write,
> > >     .impl =3D {
> > >         .min_access_size =3D 1,
> > >         .max_access_size =3D 4,
> > >     },
> > >     .endianness =3D DEVICE_LITTLE_ENDIAN,
> > > };
> > >
> > >
> > > This triggers another swap in address_space_ldl_internal
> > > (memory_ldst.inc.c).
> > >
> > >
> > > > In table above, when target is big endian and VirtIO is pre 1.0,
> > > > function virtio_is_big_endian would return true and the extra
> > > > swap would be executed, reverting the previous swap made by
> > > > virtio_config_read[wl].
> > > >
> > > > The 's(x)' means that a swap function was applied at
> > > > address x. 'LE' is little endian and 'BE' is big endian. The
> > > > 'Final result' column is the returned value from
> > > > virtio_pci_config_read, considering a target Virtio pre 1.0.
> > > > 'x' means that target's value was not swapped in Qemu, 's(x)' means
> > > > that Qemu will use a swapped value.
> > > >
> > > > If we remove the extra swap made in virtio_pci_config_read we will
> > > > have the correct result in any host/target combination, both for
> > > > VirtIO pre 1.0 or later versions.
> > > >
> > > > The same reasoning applies to virtio_pci_config_write.
> > > >
> > > > Signed-off-by: Andre Silva <afscoelho@gmail.com>
> > > > ---
> > > >  hw/virtio/virtio-pci.c | 12 ------------
> > > >  1 file changed, 12 deletions(-)
> > > >
> > > > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > > > index c6b47a9c73..4ba9e847f3 100644
> > > > --- a/hw/virtio/virtio-pci.c
> > > > +++ b/hw/virtio/virtio-pci.c
> > > > @@ -431,15 +431,9 @@ static uint64_t virtio_pci_config_read(void *o=
paque, hwaddr addr,
> > > >          break;
> > > >      case 2:
> > > >          val =3D virtio_config_readw(vdev, addr);
> > > > -        if (virtio_is_big_endian(vdev)) {
> > > > -            val =3D bswap16(val);
> > > > -        }
> > > >          break;
> > > >      case 4:
> > > >          val =3D virtio_config_readl(vdev, addr);
> > > > -        if (virtio_is_big_endian(vdev)) {
> > > > -            val =3D bswap32(val);
> > > > -        }
> > > >          break;
> > > >      }
> > > >      return val;
> > > > @@ -465,15 +459,9 @@ static void virtio_pci_config_write(void *opaq=
ue, hwaddr addr,
> > > >          virtio_config_writeb(vdev, addr, val);
> > > >          break;
> > > >      case 2:
> > > > -        if (virtio_is_big_endian(vdev)) {
> > > > -            val =3D bswap16(val);
> > > > -        }
> > > >          virtio_config_writew(vdev, addr, val);
> > > >          break;
> > > >      case 4:
> > > > -        if (virtio_is_big_endian(vdev)) {
> > > > -            val =3D bswap32(val);
> > > > -        }
> > > >          virtio_config_writel(vdev, addr, val);
> > > >          break;
> > > >      }
> > > > --
> > > > 2.24.1
> > >
>=20
>=20


