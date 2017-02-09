Received: from eggs.gnu.org ([2001:4830:134:3::10]:33678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1cboLm-0008Qz-V0
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:01:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1cboLj-000204-Sy
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:01:27 -0500
Received: from outprodmail02.cc.columbia.edu ([128.59.72.51]:32955)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jl4312@columbia.edu>) id 1cboLj-0001zB-NN
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:01:23 -0500
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by outprodmail02.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	v19CxiRB011954
	for <qemu-devel@nongnu.org>; Thu, 9 Feb 2017 08:01:17 -0500
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id 514296D
	for <qemu-devel@nongnu.org>; Thu,  9 Feb 2017 08:01:17 -0500 (EST)
Received: from sendprodmail02.cc.columbia.edu (sendprodmail02.cc.columbia.edu
	[128.59.72.14]) by hazelnut (Postfix) with ESMTP id 3C0966D
	for <qemu-devel@nongnu.org>; Thu,  9 Feb 2017 08:01:17 -0500 (EST)
Received: from mail-ua0-f200.google.com (mail-ua0-f200.google.com
	[209.85.217.200])
	by sendprodmail02.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	v19D1Hqo063541
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 9 Feb 2017 08:01:17 -0500
Received: by mail-ua0-f200.google.com with SMTP id d5so1494413uag.5
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 05:01:17 -0800 (PST)
Received: from mail-ua0-f174.google.com (mail-ua0-f174.google.com.
	[209.85.217.174])
	by smtp.gmail.com with ESMTPSA id 17sm3929295uah.2.2017.02.09.05.01.14
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 Feb 2017 05:01:14 -0800 (PST)
Received: by mail-ua0-f174.google.com with SMTP id y9so2194569uae.2
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 05:01:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170209035250.GB22153@pxdev.xzpeter.org>
References: <CAHyh4xiVKjd+D=qaizUZ02O8xLYhpoVKOqC9cR0ZWWyLq9HtbQ@mail.gmail.com>
	<20170208031216.GA5151@pxdev.xzpeter.org>
	<CAHyh4xg7NVPjXu3c+xGWNzQqwLgFqFJTPo4SgN-X+FNuHjGihQ@mail.gmail.com>
	<CAHyh4xhOPmfLoU_fvtbBF1Wqbzji9q6rp_bRN38qfnwvhQq+9A@mail.gmail.com>
	<20170209035250.GB22153@pxdev.xzpeter.org>
From: Jintack Lim <jintack@cs.columbia.edu>
Date: Thu, 9 Feb 2017 08:01:14 -0500
Message-ID: <CAHyh4xi9KZm13mJnE3-EyYkkyN4YDKKwbeJ68AumCBM7kgr+MQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] iommu emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: mst@redhat.com, Alex Williamson <alex.williamson@redhat.com>, QEMU Devel Mailing List <qemu-devel@nongnu.org>

On Wed, Feb 8, 2017 at 10:52 PM, Peter Xu <peterx@redhat.com> wrote:
> (cc qemu-devel and Alex)
>
> On Wed, Feb 08, 2017 at 09:14:03PM -0500, Jintack Lim wrote:
>> On Wed, Feb 8, 2017 at 10:49 AM, Jintack Lim <jintack@cs.columbia.edu> wrote:
>> > Hi Peter,
>> >
>> > On Tue, Feb 7, 2017 at 10:12 PM, Peter Xu <peterx@redhat.com> wrote:
>> >> On Tue, Feb 07, 2017 at 02:16:29PM -0500, Jintack Lim wrote:
>> >>> Hi Peter and Michael,
>> >>
>> >> Hi, Jintack,
>> >>
>> >>>
>> >>> I would like to get some help to run a VM with the emulated iommu. I
>> >>> have tried for a few days to make it work, but I couldn't.
>> >>>
>> >>> What I want to do eventually is to assign a network device to the
>> >>> nested VM so that I can measure the performance of applications
>> >>> running in the nested VM.
>> >>
>> >> Good to know that you are going to use [4] to do something useful. :-)
>> >>
>> >> However, could I ask why you want to measure the performance of
>> >> application inside nested VM rather than host? That's something I am
>> >> just curious about, considering that virtualization stack will
>> >> definitely introduce overhead along the way, and I don't know whether
>> >> that'll affect your measurement to the application.
>> >
>> > I have added nested virtualization support to KVM/ARM, which is under
>> > review now. I found that application performance running inside the
>> > nested VM is really bad both on ARM and x86, and I'm trying to figure
>> > out what's the real overhead. I think one way to figure that out is to
>> > see if the direct device assignment to L2 helps to reduce the overhead
>> > or not.
>
> I see. IIUC you are trying to use an assigned device to replace your
> old emulated device in L2 guest to see whether performance will drop
> as well, right? Then at least I can know that you won't need a nested
> VT-d here (so we should not need a vIOMMU in L2 guest).

That's right.

>
> In that case, I think we can give it a shot, considering that L1 guest
> will use vfio-pci for that assigned device as well, and when L2 guest
> QEMU uses this assigned device, it'll use a static mapping (just to
> map the whole GPA for L2 guest) there, so even if you are using a
> kernel driver in L2 guest with your to-be-tested application, we
> should still be having a static mapping in vIOMMU in L1 guest, which
> is IMHO fine from performance POV.
>
> I cced Alex in case I missed anything here.
>
>> >
>> >>
>> >> Another thing to mention is that (in case you don't know that), device
>> >> assignment with VT-d protection would be even slower than generic VMs
>> >> (without Intel IOMMU protection) if you are using generic kernel
>> >> drivers in the guest, since we may need real-time DMA translation on
>> >> data path.
>> >>
>> >
>> > So, this is the comparison between using virtio and using the device
>> > assignment for L1? I have tested application performance running
>> > inside L1 with and without iommu, and I found that the performance is
>> > better with iommu. I thought whether the device is assigned to L1 or
>> > L2, the DMA translation is done by iommu, which is pretty fast? Maybe
>> > I misunderstood what you said?
>
> I failed to understand why an vIOMMU could help boost performance. :(
> Could you provide your command line here so that I can try to
> reproduce?

Sure. This is the command line to launch L1 VM

qemu-system-x86_64 -M q35,accel=kvm,kernel-irqchip=split \
-m 12G -device intel-iommu,intremap=on,eim=off,caching-mode=on \
-drive file=/mydata/guest0.img,format=raw --nographic -cpu host \
-smp 4,sockets=4,cores=1,threads=1 \
-device vfio-pci,host=08:00.0,id=net0

And this is for L2 VM.

./qemu-system-x86_64 -M q35,accel=kvm \
-m 8G \
-drive file=/vm/l2guest.img,format=raw --nographic -cpu host \
-device vfio-pci,host=00:03.0,id=net0

>
> Besides, what I mentioned above is just in case you don't know that
> vIOMMU will drag down the performance in most cases.
>
> I think here to be more explicit, the overhead of vIOMMU is different
> for assigned devices and emulated ones.
>
>   (1) For emulated devices, the overhead is when we do the
>       translation, or say when we do the DMA operation. We need
>       real-time translation which should drag down the performance.
>
>   (2) For assigned devices (our case), the overhead is when we setup
>       the pages (since we are trapping the setup procedures via CM
>       bit). However, after it's setup, we should have no much
>       performance drag when we really do the data transfer (during
>       DMA) since that'll all be done in the hardware IOMMU (no matter
>       whether the device is assigned to L1/L2 guest).
>
> Now, after I know your use case now (use vIOMMU in L1 guest, don't use
> vIOMMU in L2 guest, only use assigned devices), I suspect we would
> have no big problem according to (2).
>
>> >
>> >>>
>> >>> First, I am having trouble to boot a VM with the emulated iommu. I
>> >>> have posted my problem to the qemu user mailing list[1],
>> >>
>> >> Here I would suggest that you cc qemu-devel as well next time:
>> >>
>> >>   qemu-devel@nongnu.org
>> >>
>> >> Since I guess not all people are registered to qemu-discuss, at least
>> >> I am not in that loop. Imho cc qemu-devel could let the question
>> >> spread to more people, and it'll get a higher chance to be answered.
>> >
>> > Thanks. I'll cc qemu-devel next time.
>> >
>> >>
>> >>> but to put it
>> >>> in a nutshell, I'd like to know the setting I can reuse to boot a VM
>> >>> with the emulated iommu. (e.g. how to create a VM with q35 chipset
>> >>> and/or libvirt xml if you use virsh).
>> >>
>> >> IIUC you are looking for device assignment for the nested VM case. So,
>> >> firstly, you may need my tree to run this (see below). Then, maybe you
>> >> can try to boot a L1 guest with assigned device (under VT-d
>> >> protection), with command:
>> >>
>> >> $qemu -M q35,accel=kvm,kernel-irqchip=split -m 1G \
>> >>       -device intel-iommu,intremap=on,eim=off,caching-mode=on \
>> >>       -device vfio-pci,host=$HOST_PCI_ADDR \
>> >>       $YOUR_IMAGE_PATH
>> >>
>> >
>> > Thanks! I'll try this right away.
>> >
>> >> Here $HOST_PCI_ADDR should be something like 05:00.0, which is the
>> >> host PCI address of the device to be assigned to guest.
>> >>
>> >> (If you go over the cover letter in [4], you'll see similar command
>> >>  line there, though with some more devices assigned, and with traces)
>> >>
>> >> If you are playing with nested VM, you'll also need a L2 guest, which
>> >> will be run inside the L1 guest. It'll require similar command line,
>> >> but I would suggest you first try a L2 guest without intel-iommu
>> >> device. Frankly speaking I haven't played with that yet, so just let
>> >> me know if you got any problem, which is possible. :-)
>> >>
>>
>> I was able to boot L2 guest without assigning a network device
>> successfully. (host iommu was on, L1 iommu was on, and the network
>> device was assigned to L1)
>>
>> Then, I unbound the network device in L1 and bound it to vfio-pci.
>> When I try to run L2 with the following command, I got an assertion.
>>
>> # ./qemu-system-x86_64 -M q35,accel=kvm \
>> -m 8G \
>> -drive file=/vm/l2guest.img,format=raw --nographic -cpu host \
>> -device vfio-pci,host=00:03.0,id=net0
>>
>> qemu-system-x86_64: hw/pci/pcie.c:686: pcie_add_capability: Assertion
>> `prev >= 0x100' failed.
>> Aborted (core dumped)
>>
>> Thoughts?
>
> I don't know whether it'll has anything to do with how vfio-pci works,
> anyway I cced Alex and the list in case there is quick answer.
>
> I'll reproduce this nested case and update when I got anything.

Thanks!

>
> Thanks!
>
>>
>> >
>> > Ok. I'll let you know!
>> >
>> >>>
>> >>> I'm using QEMU 2.8.0, kernel 4.6.0-rc5, libvirt 3.0.0, and this is my
>> >>> libvirt xml [2], which gives me DMAR error during the VM boot[3].
>> >>>
>> >>> I also wonder if the VM can successfully assign a device (i.e. network
>> >>> device in my case) to the nested VM if I use this patch series from
>> >>> you. [4]
>> >>
>> >> Yes, for your nested device assignment requirement you may need to use
>> >> the tree posted in [4], rather than any other qemu versions. [4] is
>> >> still during review (which Alex should have mentioned in the other
>> >> thread), so you may need to build it on your own to get
>> >> qemu-system-x86_64 binary, which is located at:
>> >>
>> >>   https://github.com/xzpeter/qemu/tree/vtd-vfio-enablement-v7
>> >>
>> >> (this link is in [4] as well)
>> >>
>> >
>> > Thanks a lot.
>> >
>> >>>
>> >>> I mostly work on ARM architecture, especially nested virtualization on
>> >>> ARM, and I'm trying to become accustomed to x86 environment :)
>> >>
>> >> Hope you'll quickly get used to it. :-)
>> >>
>> >> Regards,
>> >>
>> >> -- peterx
>> >>
>>
>
> -- peterx
>
