Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F11FC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 20:17:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27F63217F9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 20:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F63217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birkelund.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58958 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTBCX-000326-9H
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 16:17:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <klaus@birkelund.eu>) id 1hTB9l-0001ET-R1
	for qemu-devel@nongnu.org; Tue, 21 May 2019 16:14:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <klaus@birkelund.eu>) id 1hTB9j-0000Hg-Us
	for qemu-devel@nongnu.org; Tue, 21 May 2019 16:14:41 -0400
Received: from charlie.dont.surf ([128.199.63.193]:53418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <klaus@birkelund.eu>)
	id 1hTB9e-0008Rk-C8; Tue, 21 May 2019 16:14:35 -0400
Received: from apples.localdomain (ip-5-186-120-196.cgn.fibianet.dk
	[5.186.120.196])
	by charlie.dont.surf (Postfix) with ESMTPSA id A1CB2BF513;
	Tue, 21 May 2019 20:14:30 +0000 (UTC)
Date: Tue, 21 May 2019 22:14:26 +0200
From: Klaus Birkelund <klaus@birkelund.eu>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190521201424.GA28415@apples.localdomain>
Mail-Followup-To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
	Keith Busch <keith.busch@intel.com>, Max Reitz <mreitz@redhat.com>,
	qemu-devel@nongnu.org, armbru@redhat.com
References: <20190517084234.26923-1-klaus@birkelund.eu>
	<20190520130124.GE5699@localhost.localdomain>
	<20190520193445.GA22742@apples.localdomain>
	<20190521080115.GA4971@linux.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521080115.GA4971@linux.fritz.box>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 128.199.63.193
Subject: Re: [Qemu-devel] [PATCH 0/8] nvme: v1.3, sgls,
 metadata and new 'ocssd' device
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Keith Busch <keith.busch@intel.com>, armbru@redhat.com,
	qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 21, 2019 at 10:01:15AM +0200, Kevin Wolf wrote:
> Am 20.05.2019 um 21:34 hat Klaus Birkelund geschrieben:
> > On Mon, May 20, 2019 at 03:01:24PM +0200, Kevin Wolf wrote:
> > > Am 17.05.2019 um 10:42 hat Klaus Birkelund Jensen geschrieben:
> > > > Hi,
> > > > 
> > > > This series of patches contains a number of refactorings to the emulated
> > > > nvme device, adds additional features, such as support for metadata and
> > > > scatter gather lists, and bumps the supported NVMe version to 1.3.
> > > > Lastly, it contains a new 'ocssd' device.
> > > > 
> > > > The motivation for the first seven patches is to set everything up for
> > > > the final patch that adds a new 'ocssd' device and associated block
> > > > driver that implements the OpenChannel 2.0 specification[1]. Many of us
> > > > in the OpenChannel comunity have used a qemu fork[2] for emulation of
> > > > OpenChannel devices. The fork is itself based on Keith's qemu-nvme
> > > > tree[3] and we recently merged mainline qemu into it, but the result is
> > > > still a "hybrid" nvme device that supports both conventional nvme and
> > > > the OCSSD 2.0 spec through a 'dialect' mechanism. Merging instead of
> > > > rebasing also created a pretty messy commit history and my efforts to
> > > > try and rebase our work onto mainline was getting hairy to say the
> > > > least. And I was never really happy with the dialect approach anyway.
> > > > 
> > > > I have instead prepared this series of fresh patches that incrementally
> > > > adds additional features to the nvme device to bring it into shape for
> > > > finally introducing a new (and separate) 'ocssd' device that emulates an
> > > > OpenChannel 2.0 device by reusing core functionality from the nvme
> > > > device. Providing a separate ocssd device ensures that no ocssd specific
> > > > stuff creeps into the nvme device.
> > > > 
> > > > The ocssd device is backed by a new 'ocssd' block driver that holds
> > > > internal meta data and keeps state permanent across power cycles. In the
> > > > future I think we could use the same approach for the nvme device to
> > > > keep internal metadata such as utilization and deallocated blocks.
> > > 
> > > A backend driver that is specific for a guest device model (i.e. the
> > > device model requires this driver, and the backend is useless without
> > > the device) sounds like a very questionable design.
> > > 
> > > Metadata like OcssdFormatHeader that is considered part of the image
> > > data, which means that the _actual_ image content without metadata isn't
> > > directly accessible any more feels like a bad idea, too. Simple things
> > > like what a resize operation means (change only the actual disk size as
> > > usual, or is the new size disk + metadata?) become confusing. Attaching
> > > an image to a different device becomes impossible.
> > > 
> > > The block format driver doesn't seem to actually add much functionality
> > > to a specially crafted raw image: It provides a convenient way to create
> > > such special images and it dumps some values in 'qemu-img info', but the
> > > actual interpretation of the data is left to the device model.
> > > 
> > > Looking at the options it does provide, my impression is that these
> > > should really be qdev properties, and the place to store them
> > > persistently is something like the libvirt XML. The device doesn't
> > > change any of the values, so there is nothing that QEMU actually needs
> > > to store. What you invented is a one-off way to pass a config file to a
> > > device, but only for one specific device type.
> > > 
> > > I think this needs to use a much more standard approach to be mergable.
> > > 
> > > Markus (CCed) as the maintainer for the configuration mechanisms may
> > > have an opinion on this, too.
> > > 
> > > > For now, the nvme device does not support the Deallocated and
> > > > Unwritten Logical Block Error (DULBE) feature or the Data Set
> > > > Management command as this would require such support.
> > > 
> > > Doesn't bdrv_co_block_status() provide all the information you need for
> > > that?
> > 
> > Is it wrong for a device to store such "internal" metadata on the image?
> > Before implementing the ocssd block driver, the device just used a raw
> > image that it initialized with internal metadata and would error out if
> > the size of the raw image was too small to accomodate the chosen
> > geometry. Is that an acceptable way forward?
> 
> No, I think if you read from the image normally, it should produce
> whatever the guest sees. So I can take the same image and attach it to
> IDE, virtio-blk or ocssd without modifying the image file.
> 

Hmm, I am not sure how that should work for an OpenChannel device due to
the difference in adressing. An LBA that is valid on an OpenChannel
device may not be valid on a regular NVMe device and vice versa.

The physical layout of the NAND is exposed to the host (ehm, guest in
this case...) in such a way that there is no linear address space. The
address space is hierarchical such that an OCSSD LBA encodes group,
parallel unit, chunk and sector into a 64 bit value. The spec has an
example. Consider this physical geometry:

  * 16 groups:                           4 bits required
  * 4 PUs within each group:             2 bits required
  * 1004 chunks within each PU:         10 bits required
  * 4096 logical blocks within a chunk: 12 bits required

In other words, there are 263192576 (16 * 4 * 1004 * 4096) logical
blocks available. In a linear world, we'd have an LBA range of
0-263192575, but with the hierarchical adressing, the 64 bits are used
like this:

  * Bits 11-0  specify a logical block within a chunk
  * Bits 21-12 specify a chunk within a PU
  * Bits 23-22 specify a PU within a group
  * Bits 27-24 specify a group
  * Bits 63-28 are unused

So, the last logical block in the last chunk on the last pu in the last
group has LBA:

  (0b1111 << 24) | (0b11 << 22) | (0b1111101011 << 12) | 0b111111111111
  [    group   ] | [   punit  ] | [      chunk       ] | [   sector   ]

which has the value 268353535 != 263192575. Bottomline: the addresses of
data change depending on whether we are working with an nvme or an ocssd
device.

I assume you mean that if an ide device reads all sectors on the image
starting from 0, it should give the same result as if we did it when
connected to the ocssd device. Even if we assume that I do not write any
additional internal metadata to the image such that sector 0 on the
image is LBA 0, then this is still not possible because the address
space when used with the ocssd device has "holes". All the addresses
describing the non-existing chunks with chunk number 1004-1023 has an
address in the address space, but there is conceptually no NAND backing
it, so when we try to write it we get a write fault. On the other hand,
when we read it, we read predefined data (say, zeroes).

So, say we just include these "holes" by making the disk larger (i.e.
more LBAs). This does not affect the ocssd device because it wont allow
writes to these fillers and when reading them we just read the data that
they are initialized with. We are then able to read the same raw data
from the image when connected to an nvme device. But this would also
mean that the nvme device could write these "filler" LBAs that are
invalid under the geometry that the ocssd device knows about. So it only
works one-way. My v2 actually works like that, e.g. truncating the image
file to the size of the address space.

> If we want to store such data in the image file (I'm not convinced of
> this idea yet, but maybe that's because I don't know the use case),
> adding an block layer API for storing metadata and extending qcow2 to
> support that would be a cleaner design. Or if you don't mind having a
> second file, you could have a qdev option for the device to pass a
> separate config file.
> 

Yes - it would be awesome if we could just hide the internal metadata by
having raw/qcow2 support and a block api. We could also just move the
internal metadata to an additional file, but we would still be left with
the issue on linear vs hierarchical adressing that I described above.
Maybe the conclusion here is to recognize that an ocssd device is not a
block device? It just looks like it in most circumstances.

> Anyway, if I understand correctly, this is a convenience function. So
> I'd suggest to split this off, so we can move forward with the actual
> device (assuming it gets sufficient review) while discussing the
> configuration mechanisms.
> 

I really don't think the block driver is a good idea anymore - it does
spooky stuff, so I have a v2 ready that no longer contains it. Instead,
the image is initialized on the basis of ocssd device parameters. It
still holds a bunch of internal metadata, which I think is justifiable.
As explained above, we can't make the image work on other devices
anyway.

> I'm also sure that others such as Markus can provide valuable input, so
> let's try to keep the discussion on the list. (Is this intentionally
> off-list? If not, feel free to add the list again in your reply.)
> 

Adding in the list again. I was unsure how much back and forth
discussion goes to the list vs off-list, but I'll keep it on-list.

