Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EFBC48BD6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 16:51:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB0F6205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 16:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0F6205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birkelund.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34046 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfofi-00010V-O9
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 12:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51835)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <klaus@birkelund.eu>) id 1hfobp-0007Pn-2z
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 12:47:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <klaus@birkelund.eu>) id 1hfobn-0002SF-Tn
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 12:47:53 -0400
Received: from charlie.dont.surf ([128.199.63.193]:44880)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <klaus@birkelund.eu>)
 id 1hfobl-00027J-2s; Tue, 25 Jun 2019 12:47:49 -0400
Received: from apples.localdomain (ip-5-186-120-196.cgn.fibianet.dk
 [5.186.120.196])
 by charlie.dont.surf (Postfix) with ESMTPSA id 5C83ABF988;
 Tue, 25 Jun 2019 16:47:27 +0000 (UTC)
Date: Tue, 25 Jun 2019 18:47:26 +0200
From: Klaus Birkelund <klaus@birkelund.eu>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190625164726.GB21148@apples.localdomain>
Mail-Followup-To: Markus Armbruster <armbru@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Keith Busch <keith.busch@intel.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
References: <20190617081205.GA26990@apples.localdomain>
 <c754211f-b41d-4b69-585b-b287fb776d81@redhat.com>
 <20190624080154.GA4263@apples.localdomain>
 <20190624101828.GC12855@linux.fritz.box>
 <3571317f-84c2-8649-ba63-0e6508679b05@redhat.com>
 <87wohajjq6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wohajjq6.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 128.199.63.193
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 25, 2019 at 07:51:29AM +0200, Markus Armbruster wrote:
> Laszlo Ersek <lersek@redhat.com> writes:
> 
> > On 06/24/19 12:18, Kevin Wolf wrote:
> >> Am 24.06.2019 um 10:01 hat Klaus Birkelund geschrieben:
> >>> On Thu, Jun 20, 2019 at 05:37:24PM +0200, Laszlo Ersek wrote:
> >>>> On 06/17/19 10:12, Klaus Birkelund wrote:
> >>>>> Hi all,
> >>>>>
> >>>>> I'm thinking about how to support multiple namespaces in the NVMe
> >>>>> device. My first idea was to add a "namespaces" property array to the
> >>>>> device that references blockdevs, but as Laszlo writes below, this might
> >>>>> not be the best idea. It also makes it troublesome to add per-namespace
> >>>>> parameters (which is something I will be required to do for other
> >>>>> reasons). Some of you might remember my first attempt at this that
> >>>>> included adding a new block driver (derived from raw) that could be
> >>>>> given certain parameters that would then be stored in the image. But I
> >>>>> understand that this is a no-go, and I can see why.
> >>>>>
> >>>>> I guess the optimal way would be such that the parameters was something
> >>>>> like:
> >>>>>
> >>>>>    -blockdev raw,node-name=blk_ns1,file.driver=file,file.filename=blk_ns1.img
> >>>>>    -blockdev raw,node-name=blk_ns2,file.driver=file,file.filename=blk_ns2.img
> >>>>>    -device nvme-ns,drive=blk_ns1,ns-specific-options (nsfeat,mc,dlfeat)...
> >>>>>    -device nvme-ns,drive=blk_ns2,...
> >>>>>    -device nvme,...
> >>>>>
> >>>>> My question is how to state the parent/child relationship between the
> >>>>> nvme and nvme-ns devices. I've been looking at how ide and virtio does
> >>>>> this, and maybe a "bus" is the right way to go?
> >>>>
> >>>> I've added Markus to the address list, because of this question. No
> >>>> other (new) comments from me on the thread starter at this time, just
> >>>> keeping the full context.
> >>>>
> >>>
> >>> Hi all,
> >>>
> >>> I've succesfully implemented this by introducing a new 'nvme-ns' device
> >>> model. The nvme device creates a bus named from the device id ('id'
> >>> parameter) and the nvme-ns devices are then registered on this.
> >>>
> >>> This results in an nvme device being creates like this (two namespaces
> >>> example):
> >>>
> >>>   -drive file=nvme0n1.img,if=none,id=disk1
> >>>   -drive file=nvme0n2.img,if=none,id=disk2
> >>>   -device nvme,serial=deadbeef,id=nvme0
> >>>   -device nvme-ns,drive=disk1,bus=nvme0,nsid=1
> >>>   -device nvme-ns,drive=disk2,bus=nvme0,nsid=2
> >>>
> >>> How does that look as a way forward?
> >> 
> >> This looks very similar to what other devices do (one bus controller
> >> that has multiple devices on its but), so I like it.
> 
> Devices can be wired together without a bus intermediary.  You
> definitely want a bus when the physical connection you model has one.
> If not, a bus may be useful anyway, say because it provides a convenient
> way to encapsulate the connection model, or to support -device bus=...
> 
 
I'm not sure how to wire it together without the bus abstraction? So
I'll stick with the bus for now. It *is* extremely convenient!

Cheers,
Klaus

