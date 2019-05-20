Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3894C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 13:11:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A57ED20815
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 13:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57ED20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35532 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSi4F-0002gT-Sf
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 09:11:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hShvA-0005Fc-Bn
	for qemu-devel@nongnu.org; Mon, 20 May 2019 09:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hShv5-0004eK-8q
	for qemu-devel@nongnu.org; Mon, 20 May 2019 09:01:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hShuy-0004aU-MA; Mon, 20 May 2019 09:01:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E1FF4308220B;
	Mon, 20 May 2019 13:01:27 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-208.ams2.redhat.com
	[10.36.117.208])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 739415D6A6;
	Mon, 20 May 2019 13:01:26 +0000 (UTC)
Date: Mon, 20 May 2019 15:01:24 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Klaus Birkelund Jensen <klaus@birkelund.eu>
Message-ID: <20190520130124.GE5699@localhost.localdomain>
References: <20190517084234.26923-1-klaus@birkelund.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517084234.26923-1-klaus@birkelund.eu>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Mon, 20 May 2019 13:01:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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

Am 17.05.2019 um 10:42 hat Klaus Birkelund Jensen geschrieben:
> Hi,
> 
> This series of patches contains a number of refactorings to the emulated
> nvme device, adds additional features, such as support for metadata and
> scatter gather lists, and bumps the supported NVMe version to 1.3.
> Lastly, it contains a new 'ocssd' device.
> 
> The motivation for the first seven patches is to set everything up for
> the final patch that adds a new 'ocssd' device and associated block
> driver that implements the OpenChannel 2.0 specification[1]. Many of us
> in the OpenChannel comunity have used a qemu fork[2] for emulation of
> OpenChannel devices. The fork is itself based on Keith's qemu-nvme
> tree[3] and we recently merged mainline qemu into it, but the result is
> still a "hybrid" nvme device that supports both conventional nvme and
> the OCSSD 2.0 spec through a 'dialect' mechanism. Merging instead of
> rebasing also created a pretty messy commit history and my efforts to
> try and rebase our work onto mainline was getting hairy to say the
> least. And I was never really happy with the dialect approach anyway.
> 
> I have instead prepared this series of fresh patches that incrementally
> adds additional features to the nvme device to bring it into shape for
> finally introducing a new (and separate) 'ocssd' device that emulates an
> OpenChannel 2.0 device by reusing core functionality from the nvme
> device. Providing a separate ocssd device ensures that no ocssd specific
> stuff creeps into the nvme device.
> 
> The ocssd device is backed by a new 'ocssd' block driver that holds
> internal meta data and keeps state permanent across power cycles. In the
> future I think we could use the same approach for the nvme device to
> keep internal metadata such as utilization and deallocated blocks.

A backend driver that is specific for a guest device model (i.e. the
device model requires this driver, and the backend is useless without
the device) sounds like a very questionable design.

Metadata like OcssdFormatHeader that is considered part of the image
data, which means that the _actual_ image content without metadata isn't
directly accessible any more feels like a bad idea, too. Simple things
like what a resize operation means (change only the actual disk size as
usual, or is the new size disk + metadata?) become confusing. Attaching
an image to a different device becomes impossible.

The block format driver doesn't seem to actually add much functionality
to a specially crafted raw image: It provides a convenient way to create
such special images and it dumps some values in 'qemu-img info', but the
actual interpretation of the data is left to the device model.

Looking at the options it does provide, my impression is that these
should really be qdev properties, and the place to store them
persistently is something like the libvirt XML. The device doesn't
change any of the values, so there is nothing that QEMU actually needs
to store. What you invented is a one-off way to pass a config file to a
device, but only for one specific device type.

I think this needs to use a much more standard approach to be mergable.

Markus (CCed) as the maintainer for the configuration mechanisms may
have an opinion on this, too.

> For now, the nvme device does not support the Deallocated and
> Unwritten Logical Block Error (DULBE) feature or the Data Set
> Management command as this would require such support.

Doesn't bdrv_co_block_status() provide all the information you need for
that?

Kevin

