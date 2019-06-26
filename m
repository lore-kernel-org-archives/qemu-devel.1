Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE27C4646B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 04:47:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4039A2080C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 04:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4039A2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfzqd-0007xN-W6
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 00:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53886)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hfzpu-0007SF-8x
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 00:47:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hfzps-0008AB-V7
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 00:47:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42732)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hfzpl-00083b-WD; Wed, 26 Jun 2019 00:47:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A44243086201;
 Wed, 26 Jun 2019 04:46:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-169.ams2.redhat.com
 [10.36.117.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 46D4D608BA;
 Wed, 26 Jun 2019 04:46:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BAD5411386A0; Wed, 26 Jun 2019 06:46:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
References: <20190617081205.GA26990@apples.localdomain>
 <c754211f-b41d-4b69-585b-b287fb776d81@redhat.com>
 <20190624080154.GA4263@apples.localdomain>
 <20190624101828.GC12855@linux.fritz.box>
 <3571317f-84c2-8649-ba63-0e6508679b05@redhat.com>
 <87wohajjq6.fsf@dusky.pond.sub.org>
 <20190625164726.GB21148@apples.localdomain>
Date: Wed, 26 Jun 2019 06:46:46 +0200
In-Reply-To: <20190625164726.GB21148@apples.localdomain> (Klaus Birkelund's
 message of "Tue, 25 Jun 2019 18:47:26 +0200")
Message-ID: <87o92lkl6x.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Wed, 26 Jun 2019 04:46:59 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: QOM maintainers in case I'm talking nonsense about QOM.

Klaus Birkelund <klaus@birkelund.eu> writes:

> On Tue, Jun 25, 2019 at 07:51:29AM +0200, Markus Armbruster wrote:
>> Laszlo Ersek <lersek@redhat.com> writes:
>> 
>> > On 06/24/19 12:18, Kevin Wolf wrote:
>> >> Am 24.06.2019 um 10:01 hat Klaus Birkelund geschrieben:
>> >>> On Thu, Jun 20, 2019 at 05:37:24PM +0200, Laszlo Ersek wrote:
>> >>>> On 06/17/19 10:12, Klaus Birkelund wrote:
>> >>>>> Hi all,
>> >>>>>
>> >>>>> I'm thinking about how to support multiple namespaces in the NVMe
>> >>>>> device. My first idea was to add a "namespaces" property array to the
>> >>>>> device that references blockdevs, but as Laszlo writes below, this might
>> >>>>> not be the best idea. It also makes it troublesome to add per-namespace
>> >>>>> parameters (which is something I will be required to do for other
>> >>>>> reasons). Some of you might remember my first attempt at this that
>> >>>>> included adding a new block driver (derived from raw) that could be
>> >>>>> given certain parameters that would then be stored in the image. But I
>> >>>>> understand that this is a no-go, and I can see why.
>> >>>>>
>> >>>>> I guess the optimal way would be such that the parameters was something
>> >>>>> like:
>> >>>>>
>> >>>>>    -blockdev raw,node-name=blk_ns1,file.driver=file,file.filename=blk_ns1.img
>> >>>>>    -blockdev raw,node-name=blk_ns2,file.driver=file,file.filename=blk_ns2.img
>> >>>>>    -device nvme-ns,drive=blk_ns1,ns-specific-options (nsfeat,mc,dlfeat)...
>> >>>>>    -device nvme-ns,drive=blk_ns2,...
>> >>>>>    -device nvme,...
>> >>>>>
>> >>>>> My question is how to state the parent/child relationship between the
>> >>>>> nvme and nvme-ns devices. I've been looking at how ide and virtio does
>> >>>>> this, and maybe a "bus" is the right way to go?
>> >>>>
>> >>>> I've added Markus to the address list, because of this question. No
>> >>>> other (new) comments from me on the thread starter at this time, just
>> >>>> keeping the full context.
>> >>>>
>> >>>
>> >>> Hi all,
>> >>>
>> >>> I've succesfully implemented this by introducing a new 'nvme-ns' device
>> >>> model. The nvme device creates a bus named from the device id ('id'
>> >>> parameter) and the nvme-ns devices are then registered on this.
>> >>>
>> >>> This results in an nvme device being creates like this (two namespaces
>> >>> example):
>> >>>
>> >>>   -drive file=nvme0n1.img,if=none,id=disk1
>> >>>   -drive file=nvme0n2.img,if=none,id=disk2
>> >>>   -device nvme,serial=deadbeef,id=nvme0
>> >>>   -device nvme-ns,drive=disk1,bus=nvme0,nsid=1
>> >>>   -device nvme-ns,drive=disk2,bus=nvme0,nsid=2
>> >>>
>> >>> How does that look as a way forward?
>> >> 
>> >> This looks very similar to what other devices do (one bus controller
>> >> that has multiple devices on its but), so I like it.
>> 
>> Devices can be wired together without a bus intermediary.  You
>> definitely want a bus when the physical connection you model has one.
>> If not, a bus may be useful anyway, say because it provides a convenient
>> way to encapsulate the connection model, or to support -device bus=...
>> 
>  
> I'm not sure how to wire it together without the bus abstraction? So
> I'll stick with the bus for now. It *is* extremely convenient!

As far as I can tell offhand, a common use of bus-less connections
between devices is wiring together composite devices.  Example:

    static void designware_pcie_host_init(Object *obj)
    {
        DesignwarePCIEHost *s = DESIGNWARE_PCIE_HOST(obj);
        DesignwarePCIERoot *root = &s->root;

        object_initialize_child(obj, "root",  root, sizeof(*root),
                                TYPE_DESIGNWARE_PCIE_ROOT, &error_abort, NULL);
        qdev_prop_set_int32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
        qdev_prop_set_bit(DEVICE(root), "multifunction", false);
    }

This creates a TYPE_DESIGNWARE_PCIE_ROOT device "within" the
TYPE_DESIGNWARE_PCIE_HOST device.

Bus-less connections between separate devices (i.e. neither device is a
part of the other) are also possible.  But I'm failing at grep right
now.  Here's an example for connecting a device to a machine:

    static void mch_realize(PCIDevice *d, Error **errp)
    {
        int i;
        MCHPCIState *mch = MCH_PCI_DEVICE(d);

        [...]
        object_property_add_const_link(qdev_get_machine(), "smram",
                                       OBJECT(&mch->smram), &error_abort);
        [...]
    }

Paolo, can you provide guidance on when to use a bus, and when not to?

