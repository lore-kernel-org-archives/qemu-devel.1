Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A24C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 10:01:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A916214D8
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 10:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A916214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42957 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVCS6-0008AW-Vu
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 06:01:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVCPu-0006Yi-Ks
	for qemu-devel@nongnu.org; Mon, 27 May 2019 05:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVCPt-0001rD-2L
	for qemu-devel@nongnu.org; Mon, 27 May 2019 05:59:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hVCPs-0001op-TD
	for qemu-devel@nongnu.org; Mon, 27 May 2019 05:59:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id m3so16318933wrv.2
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 02:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=MKxa0yQTYJysbK9ki2dSmjnrKgMTjPmx7C3sPSScBQ0=;
	b=Pf0T0CMkEP0FJojqaLrKW/j5hmXJQOuDcyI7/6axBT95Fl1Ez+CNe4J3H111KjwN4T
	oF6Td6uKTjk8TkIShy7fcS8nUKj/07DAQxevNpLfK+HPmJpWWuiMXbwcFgs5LUCwoSuq
	Zygsr6Mm4AB9i8Qi7rfpLGMHzBhXvCX09V4bcq9YZKofx3FlPTSXdzXmka945HhE/w4d
	61mWAEeDIsssA3FEOVOyEIzmMV0LoWdILNrcNNyGUN6BUJf4zdkUM08X6KaP7tLU3Dj7
	Fq1NuaZzm3ijpn5mv4v7pw7m+Yw0eENvzJmLz6Z9NNVSPpMI6MHXu0faHDkBEc81p6uU
	srgA==
X-Gm-Message-State: APjAAAWJ0Vf16d23O25VK/dShGSGZANtu0ACtP3wtP8uoOcyqAl/b+cH
	i3PwLNFQnWlwFVtRtctWFi0F3w==
X-Google-Smtp-Source: APXvYqxiXtq4bdSLnyzXT/1gE9F59AZzdwKfIc88QXtGHsRcQXR/uHFNBpYovK8xOoEBMWjILuNFtw==
X-Received: by 2002:a5d:55ce:: with SMTP id i14mr9999202wrw.352.1558951179286; 
	Mon, 27 May 2019 02:59:39 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228])
	by smtp.gmail.com with ESMTPSA id 22sm8799146wmg.44.2019.05.27.02.59.37
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 27 May 2019 02:59:38 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>
References: <51df31ee-54a1-d7be-bef4-71ae003b8811@redhat.com>
	<3fab9e76-53ad-2de7-45df-eb69c8604709@redhat.com>
	<016edc53-278e-cc58-0061-d2c5de80afd2@de.ibm.com>
	<1ddf0d83-ce0c-f1c9-065d-ff88ddb9293b@redhat.com>
	<60d1bf3d-659c-d199-6592-d3659702d754@redhat.com>
	<d38b05af-effc-97a1-0b4a-a0d44a13f769@de.ibm.com>
	<CAFEAcA9K+d+LM5SfDrX0Ljwq8zWQdmJAM4R4cdHhF+tM1F13LQ@mail.gmail.com>
	<87v9xw1gi4.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <75e26ba3-be23-8a46-f3d1-a11c6f9a241a@redhat.com>
Date: Mon, 27 May 2019 11:59:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87v9xw1gi4.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] hw/s390x/ipl: Dubious use of qdev_reset_all_fn
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
	Edgar Iglesias <edgar.iglesias@xilinx.com>, Thomas Huth <thuth@redhat.com>,
	David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x <qemu-s390x@nongnu.org>, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Damien who is working on "multi-phase reset mechanism".

On 5/27/19 9:52 AM, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> On Fri, 24 May 2019 at 20:47, Christian Borntraeger
>> <borntraeger@de.ibm.com> wrote:
>>> While this patch is certainly ok, I find it disturbing that qdev devices are being resetted,
>>> but qom devices not.
>>
>> It's not a qdev-vs-QOM thing. Anything which is a DeviceState
>> has a reset method, but only devices which are somewhere
>> rooted in the bus-tree that starts with the "main system
>> bus" (aka sysbus) get reset by the vl.c-registered "reset
>> everything on the system bus". Devices which are SysBusDevice
>> get auto-parented onto the sysbus, and so get reset. Devices
>> like PCI devices or SCSI devices get put onto the PCI
>> bus or the SCSI bus, and those buses are in turn children
>> of some host-controller device which is on the sysbus, so
>> they all get reset. The things that don't get reset are
>> "orphan" devices which are neither (a) of a type that gets
>> automatically parented onto a bus like SysBusDevice nor
>> (b) put specifically onto some other bus.
>>
>> CPU objects are the other common thing that doesn't get
>> reset 'automatically'.
>>
>> Suggestions for how to restructure reset so this doesn't
>> happen are welcome... "reset follows the bus hierarchy"
>> works well in some places but is a bit weird in others
>> (for SoC containers and the like "follow the QOM
>> hierarchy" would make more sense, but I have no idea
>> how to usefully transition to a model where you could
>> say "for these devices, follow QOM tree for reset" or
>> what an API for that would look like).
> 
> Here's a QOM composition tree for the ARM virt machine (-nodefaults
> -device e1000) as visible in qom-fuse under /machine, with irq and
> qemu:memory-region ommitted for brevity:
> 
>     machine  virt-4.1-machine
>       +-- fw_cfg  fw_cfg_mem
>       +-- peripheral  container
>       +-- peripheral-anon  container
>       |     +-- device[0]  e1000
>       +-- unattached  container
>       |     +-- device[0]  cortex-a15-arm-cpu
>       |     +-- device[1]  arm_gic
>       |     +-- device[2]  arm-gicv2m
>       |     +-- device[3]  pl011
>       |     +-- device[4]  pl031
>       |     +-- device[5]  gpex-pcihost
>       |     |     +-- pcie.0  PCIE
>       |     |     +-- gpex_root  gpex-root
>       |     +-- device[6]  pl061
>       |     +-- device[7]  gpio-key
>       |     +-- device[8]  virtio-mmio
>       |     |     +-- virtio-mmio-bus.0  virtio-mmio-bus
>       |     .
>       |     .  more virtio-mmio
>       |     .
>       |     +-- device[39]  virtio-mmio
>       |     |     +-- virtio-mmio-bus.31  virtio-mmio-bus
>       |     +-- device[40]  platform-bus-device
>       |     +-- sysbus  System
>       +-- virt.flash0  cfi.pflash01
>       +-- virt.flash1  cfi.pflash01
> 
> Observations:
> 
> * Some components of the machine are direct children of machine: fw_cfg,
>   virt.flash0, virt.flash1
> 
> * machine additionally has a few containers: peripheral,
>   peripheral-anon, unattached.
> 
> * machine/peripheral and machine/peripheral-anon contain the -device
>   with and without ID, respectively.
> 
> * machine/unattached contains everything else created by code without an
>   explicit parent device.  Some (all?) of them should perhaps be direct
>   children of machine instead.
> 
> Compare to the qdev tree shown by info qtree:
> 
>     bus: main-system-bus
>       type System
>       dev: platform-bus-device, id "platform-bus-device"
>       dev: fw_cfg_mem, id ""
>       dev: virtio-mmio, id ""
>         bus: virtio-mmio-bus.31
>           type virtio-mmio-bus
>       ... more virtio-mmio
>       dev: virtio-mmio, id ""
>         bus: virtio-mmio-bus.0
>           type virtio-mmio-bus
>       dev: gpio-key, id ""
>       dev: pl061, id ""
>       dev: gpex-pcihost, id ""
>         bus: pcie.0
>           type PCIE
>           dev: e1000, id ""
>           dev: gpex-root, id ""
>       dev: pl031, id ""
>       dev: pl011, id ""
>       dev: arm-gicv2m, id ""
>       dev: arm_gic, id ""
>       dev: cfi.pflash01, id ""
>       dev: cfi.pflash01, id ""
> 
> Observations:
> 
> * Composition tree root machine's containers are not in the qtree.
> 
> * Composition tree node cortex-a15-arm-cpu is not in the qtree.  That's
>   because it's not a qdev (in QOM parlance: not a TYPE_DEVICE).
> 
> * In the qtree, every other inner node is a qbus.  These are *leaves* in
>   the composition tree.  The qtree's vertex from qbus to qdev is a
>   *link* in the composition tree.
> 
>   Example: main-system-bus -> pl011 is
>       machine/unattached/sysbus/child[4] ->
>       ../../../machine/unattached/device[3].
> 
>   Example: main-system-bus/gpex-pcihost/pcie.0 -> e1000 is
>       machine/unattached/device[5]/pcie.0//child[1] ->
>       ../../../../machine/peripheral-anon/device[0].
> 
> Now let me ramble a bit on reset.
> 
> We could model the reset wiring explicitly: every QOM object that wants
> to participate in reset has a reset input pin.  We represent the wiring
> as links.  The reset links form a reset tree.
> 
> Example: object virt-4.1-machine at machine gets a link reset[4]
>     pointing to its child object cfi.pflash01 at machine/virt.flash0.
> 
> Example: object PCIE at machine/unattached/device[5]/pcie.0 gets a link
>     reset[1] pointing to object e1000 at
>     machine/peripheral-anon/device[0].
> 
>     Note that reset[1] points to the same object as child[1].
> 
> Adding all these links in code would be tiresome.  Enter defaults.
> 
> If an object doesn't get its reset input connected, and
> 
> * the parent is machine/peripheral or machine/peripheral-anon, default
>   to the object that links to it in the composition tree.  Error when
>   there's more than one.
> 
>   Example: object e1000 at machine/peripheral-anon/device[0] defaults to
>   machine/unattached/device[5]/pcie.0.
> 
> * the parent is machine/unattached, default to machine.
> 
>   Example: object gpex-pcihost at machine/unattached/device[5] defaults
>   to machine.
> 
> * the parent is not one of these containers, default to its parent in
>   the composition tree.
> 
>   Example: object cfi.pflash01 at machine/virt.flash0 defaults to
>   machine.
> 
> This leaves the order in which an object asserts its reset wires
> unspecified.  In physical hardware, these guys get asserted
> simultaneously, and the various pieces of silicon at the other ends
> reset in parallel.  In software, we serialize.
> 
> We could pick some order by numbering the reset links, say reset[0],
> reset[1], ...
> 
> Reset could then work by walking the reset tree, running device model
> callbacks before and after walking the children.
> 
> Cases may well exist where reset is more complicated than that.  Perhaps
> an object resets its children in the reset tree at different times
> during its own reset.  Such cases need to modelled in device model code.
> That's another callback.
> 
> This is quite possibly too naive to be practical.  Hey, you asked :)

Thanks a lot for this extensive analysis :) I guess you indirectly
answered to some of the issues Peter pointed in
https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg03667.html

Markus, if your bandwidth allows it, you might want to have a look at it :)

