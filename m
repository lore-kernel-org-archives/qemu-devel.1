Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CDCC48BD7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 07:25:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2A162085A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 07:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A162085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57114 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hffpn-0005gw-3A
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 03:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35539)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hffoo-0004o5-Ul
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 03:24:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hffon-0006p7-A0
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 03:24:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49560)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hffok-0006ll-JG; Tue, 25 Jun 2019 03:24:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8FA7E81F35;
 Tue, 25 Jun 2019 07:24:37 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-23.ams2.redhat.com
 [10.36.117.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BE9D600C7;
 Tue, 25 Jun 2019 07:24:32 +0000 (UTC)
Date: Tue, 25 Jun 2019 09:24:30 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Message-ID: <20190625072430.GA5187@localhost.localdomain>
References: <20190617081205.GA26990@apples.localdomain>
 <c754211f-b41d-4b69-585b-b287fb776d81@redhat.com>
 <20190624080154.GA4263@apples.localdomain>
 <20190624101828.GC12855@linux.fritz.box>
 <3571317f-84c2-8649-ba63-0e6508679b05@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3571317f-84c2-8649-ba63-0e6508679b05@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 25 Jun 2019 07:24:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [RFC] nvme: how to support multiple
 namespaces
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
Cc: Keith Busch <keith.busch@intel.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 24.06.2019 um 22:46 hat Laszlo Ersek geschrieben:
> On 06/24/19 12:18, Kevin Wolf wrote:
> > Am 24.06.2019 um 10:01 hat Klaus Birkelund geschrieben:
> >> On Thu, Jun 20, 2019 at 05:37:24PM +0200, Laszlo Ersek wrote:
> >>> On 06/17/19 10:12, Klaus Birkelund wrote:
> >>>> Hi all,
> >>>>
> >>>> I'm thinking about how to support multiple namespaces in the NVMe
> >>>> device. My first idea was to add a "namespaces" property array to the
> >>>> device that references blockdevs, but as Laszlo writes below, this might
> >>>> not be the best idea. It also makes it troublesome to add per-namespace
> >>>> parameters (which is something I will be required to do for other
> >>>> reasons). Some of you might remember my first attempt at this that
> >>>> included adding a new block driver (derived from raw) that could be
> >>>> given certain parameters that would then be stored in the image. But I
> >>>> understand that this is a no-go, and I can see why.
> >>>>
> >>>> I guess the optimal way would be such that the parameters was something
> >>>> like:
> >>>>
> >>>>    -blockdev raw,node-name=blk_ns1,file.driver=file,file.filename=blk_ns1.img
> >>>>    -blockdev raw,node-name=blk_ns2,file.driver=file,file.filename=blk_ns2.img
> >>>>    -device nvme-ns,drive=blk_ns1,ns-specific-options (nsfeat,mc,dlfeat)...
> >>>>    -device nvme-ns,drive=blk_ns2,...
> >>>>    -device nvme,...
> >>>>
> >>>> My question is how to state the parent/child relationship between the
> >>>> nvme and nvme-ns devices. I've been looking at how ide and virtio does
> >>>> this, and maybe a "bus" is the right way to go?
> >>>
> >>> I've added Markus to the address list, because of this question. No
> >>> other (new) comments from me on the thread starter at this time, just
> >>> keeping the full context.
> >>>
> >>
> >> Hi all,
> >>
> >> I've succesfully implemented this by introducing a new 'nvme-ns' device
> >> model. The nvme device creates a bus named from the device id ('id'
> >> parameter) and the nvme-ns devices are then registered on this.
> >>
> >> This results in an nvme device being creates like this (two namespaces
> >> example):
> >>
> >>   -drive file=nvme0n1.img,if=none,id=disk1
> >>   -drive file=nvme0n2.img,if=none,id=disk2
> >>   -device nvme,serial=deadbeef,id=nvme0
> >>   -device nvme-ns,drive=disk1,bus=nvme0,nsid=1
> >>   -device nvme-ns,drive=disk2,bus=nvme0,nsid=2
> >>
> >> How does that look as a way forward?
> > 
> > This looks very similar to what other devices do (one bus controller
> > that has multiple devices on its but), so I like it.
> 
> +1
> 
> Also, I believe it's more modern nowadays to express the same example
> with "blockdev" syntax, rather than "drive". (Not that I could suggest
> the exact spelling for that :)) I don't expect the modern syntax to
> behave differently, I just guess it's better to stick with the new in
> examples / commit messages etc.

As this example uses only raw files, it's actually pretty simple:

-blockdev driver=file,filename=nvme0n1.img,node-name=disk1
-blockdev driver=file,filename=nvme0n2.img,node-name=disk2

The -device options stay the same, their drive=... value just refers to
the node-name now. (-drive IDs and node-names have a shared namespace,
so this is unambiguous.)

For the sake of completeness, if nvme0n1.img were actually a qcow2
image, you would add a second -blockdev for the format layer:

-blockdev driver=file,filename=nvme0n1.img,node-name=disk1-file
-blockdev driver=qcow2,file=disk1-file,node-name=disk1

Kevin

