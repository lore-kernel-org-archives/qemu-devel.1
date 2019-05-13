Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E93CC04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 13:17:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2465621473
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 13:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2465621473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57214 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQApn-0007xi-AD
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 09:17:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hQAnn-0006Ns-Nx
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hQAnl-0005WJ-B4
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:15:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hQAng-0005N3-NB; Mon, 13 May 2019 09:15:28 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D82153086213;
	Mon, 13 May 2019 13:15:27 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-130.ams2.redhat.com [10.36.117.130])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B62319C70;
	Mon, 13 May 2019 13:15:22 +0000 (UTC)
Date: Mon, 13 May 2019 15:15:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190513131521.GD19114@linux.fritz.box>
References: <20190505070059.4664-1-zhengxiang9@huawei.com>
	<87a7fyb0v7.fsf@dusky.pond.sub.org>
	<72adbed8-f650-42df-98d5-e98154baec08@redhat.com>
	<87h8a513sl.fsf@dusky.pond.sub.org>
	<fb04cdb2-910d-58be-fb21-db7050cdc669@huawei.com>
	<87ef574z4e.fsf@dusky.pond.sub.org>
	<ac4ac85f-67ae-a526-9172-fef190fdc23a@huawei.com>
	<87ef56mjbi.fsf@dusky.pond.sub.org>
	<bfa0d642-e425-f90c-f776-9e7e25e66c25@huawei.com>
	<87bm06a7k3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bm06a7k3.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Mon, 13 May 2019 13:15:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] pflash: Only read non-zero parts of
 backend image
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
Cc: peter.maydell@linaro.org, qemu-block@nongnu.org, ard.biesheuvel@linaro.org,
	qemu-devel@nongnu.org, mreitz@redhat.com,
	Xiang Zheng <zhengxiang9@huawei.com>, stefanha@redhat.com,
	guoheyi@huawei.com, wanghaibin.wang@huawei.com,
	Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 13.05.2019 um 13:59 hat Markus Armbruster geschrieben:
> Xiang Zheng <zhengxiang9@huawei.com> writes:
> 
> > On 2019/5/10 23:16, Markus Armbruster wrote:
> >> Xiang Zheng <zhengxiang9@huawei.com> writes:
> >> 
> >>> On 2019/5/9 19:59, Markus Armbruster wrote:
> >>>> Xiang Zheng <zhengxiang9@huawei.com> writes:
> >>>>
> >>>>> On 2019/5/8 21:20, Markus Armbruster wrote:
> >>>>>> Laszlo Ersek <lersek@redhat.com> writes:
> >>>>>>
> >>>>>>> Hi Markus,
> >>>>>>>
> >>>>>>> On 05/07/19 20:01, Markus Armbruster wrote:
> >>>>>>>> The subject is slightly misleading.  Holes read as zero.  So do
> >>>>>>>> non-holes full of zeroes.  The patch avoids reading the former, but
> >>>>>>>> still reads the latter.
> >>>>>>>>
> >>>>>>>> Xiang Zheng <zhengxiang9@huawei.com> writes:
> >>>>>>>>
> >>>>>>>>> Currently we fill the memory space with two 64MB NOR images when
> >>>>>>>>> using persistent UEFI variables on virt board. Actually we only use
> >>>>>>>>> a very small(non-zero) part of the memory while the rest significant
> >>>>>>>>> large(zero) part of memory is wasted.
> >>>>>>>>
> >>>>>>>> Neglects to mention that the "virt board" is ARM.
> >>>>>>>>
> >>>>>>>>> So this patch checks the block status and only writes the non-zero part
> >>>>>>>>> into memory. This requires pflash devices to use sparse files for
> >>>>>>>>> backends.
> >>>>>>>>
> >>>>>>>> I started to draft an improved commit message, but then I realized this
> >>>>>>>> patch can't work.
> >>>>>>>>
> >>>>>>>> The pflash_cfi01 device allocates its device memory like this:
> >>>>>>>>
> >>>>>>>>     memory_region_init_rom_device(
> >>>>>>>>         &pfl->mem, OBJECT(dev),
> >>>>>>>>         &pflash_cfi01_ops,
> >>>>>>>>         pfl,
> >>>>>>>>         pfl->name, total_len, &local_err);
> >>>>>>>>
> >>>>>>>> pflash_cfi02 is similar.
> >>>>>>>>
> >>>>>>>> memory_region_init_rom_device() calls
> >>>>>>>> memory_region_init_rom_device_nomigrate() calls qemu_ram_alloc() calls
> >>>>>>>> qemu_ram_alloc_internal() calls g_malloc0().  Thus, all the device
> >>>>>>>> memory gets written to even with this patch.
> >>>>>>>
> >>>>>>> As far as I can see, qemu_ram_alloc_internal() calls g_malloc0() only to
> >>>>>>> allocate the the new RAMBlock object called "new_block". The actual
> >>>>>>> guest RAM allocation occurs inside ram_block_add(), which is also called
> >>>>>>> by qemu_ram_alloc_internal().
> >>>>>>
> >>>>>> You're right.  I should've read more attentively.
> >>>>>>
> >>>>>>> One frame outwards the stack, qemu_ram_alloc() passes NULL to
> >>>>>>> qemu_ram_alloc_internal(), for the 4th ("host") parameter. Therefore, in
> >>>>>>> qemu_ram_alloc_internal(), we set "new_block->host" to NULL as well.
> >>>>>>>
> >>>>>>> Then in ram_block_add(), we take the (!new_block->host) branch, and call
> >>>>>>> phys_mem_alloc().
> >>>>>>>
> >>>>>>> Unfortunately, "phys_mem_alloc" is a function pointer, set with
> >>>>>>> phys_mem_set_alloc(). The phys_mem_set_alloc() function is called from
> >>>>>>> "target/s390x/kvm.c" (setting the function pointer to
> >>>>>>> legacy_s390_alloc()), so it doesn't apply in this case. Therefore we end
> >>>>>>> up calling the default qemu_anon_ram_alloc() function, through the
> >>>>>>> funcptr. (I think anyway.)
> >>>>>>>
> >>>>>>> And qemu_anon_ram_alloc() boils down to mmap() + MAP_ANONYMOUS, in
> >>>>>>> qemu_ram_mmap(). (Even on PPC64 hosts, because qemu_anon_ram_alloc()
> >>>>>>> passes (-1) for "fd".)
> >>>>>>>
> >>>>>>> I may have missed something, of course -- I obviously didn't test it,
> >>>>>>> just speculated from the source.
> >>>>>>
> >>>>>> Thanks for your sleuthing!
> >>>>>>
> >>>>>>>> I'm afraid you neglected to test.
> >>>>>>
> >>>>>> Accusation actually unsupported.  I apologize, and replace it by a
> >>>>>> question: have you observed the improvement you're trying to achieve,
> >>>>>> and if yes, how?
> >>>>>>
> >>>>>
> >>>>> Yes, we need to create sparse files as the backing images for pflash device.
> >>>>> To create sparse files like:
> >>>>>
> >>>>>    dd of="QEMU_EFI-pflash.raw" if="/dev/zero" bs=1M seek=64 count=0
> >>>>>    dd of="QEMU_EFI-pflash.raw" if="QEMU_EFI.fd" conv=notrunc
> >>>>
> >>>> This creates a copy of firmware binary QEMU_EFI.fd padded with a hole to
> >>>> 64MiB.
> >>>>
> >>>>>    dd of="empty_VARS.fd" if="/dev/zero" bs=1M seek=64 count=0
> >>>>
> >>>> This creates the varstore as a 64MiB hole.  As far as I know (very
> >>>> little), you should use the varstore template that comes with the
> >>>> firmware binary.
> >>>>
> >>>> I use
> >>>>
> >>>>     cp --sparse=always bld/pc-bios/edk2-arm-vars.fd .
> >>>>     cp --sparse=always bld/pc-bios/edk2-aarch64-code.fd .
> >>>>
> >>>> These guys are already zero-padded, and I use cp to sparsify.
> >>>>
> >>>>> Start a VM with below commandline:
> >>>>>
> >>>>>     -drive file=/usr/share/edk2/aarch64/QEMU_EFI-pflash.raw,if=pflash,format=raw,unit=0,readonly=on\
> >>>>>     -drive file=/usr/share/edk2/aarch64/empty_VARS.fd,if=pflash,format=raw,unit=1 \
> >>>>>
> >>>>> Then observe the memory usage of the qemu process (THP is on).
> >>>>>
> >>>>> 1) Without this patch:
> >>>>> # cat /proc/`pidof qemu-system-aarch64`/smaps | grep AnonHugePages: | grep -v ' 0 kB'
> >>>>> AnonHugePages:    706560 kB
> >>>>> AnonHugePages:      2048 kB
> >>>>> AnonHugePages:     65536 kB    // pflash memory device
> >>>>> AnonHugePages:     65536 kB    // pflash memory device
> >>>>> AnonHugePages:      2048 kB
> >>>>>
> >>>>> # ps aux | grep qemu-system-aarch64
> >>>>> RSS: 879684
> >>>>>
> >>>>> 2) After applying this patch:
> >>>>> # cat /proc/`pidof qemu-system-aarch64`/smaps | grep AnonHugePages: | grep -v ' 0 kB'
> >>>>> AnonHugePages:    700416 kB
> >>>>> AnonHugePages:      2048 kB
> >>>>> AnonHugePages:      2048 kB    // pflash memory device
> >>>>> AnonHugePages:      2048 kB    // pflash memory device
> >>>>> AnonHugePages:      2048 kB
> >>>>>
> >>>>> # ps aux | grep qemu-system-aarch64
> >>>>> RSS: 744380
> >>>>
> >>>> Okay, this demonstrates the patch succeeds at mapping parts of the
> >>>> pflash memory as holes.
> >>>>
> >>>> Do the guests in these QEMU processes run?
> >>>
> >>> Yes.
> >> 
> >> Good to know, thanks.
> >> 
> >>>>> Obviously, there are at least 100MiB memory saved for each guest.
> >>>>
> >>>> For a definition of "memory".
> >>>>
> >>>> Next question: what impact on system performance do you observe?
> >>>>
> >>>> Let me explain.
> >>>>
> >>>> Virtual memory holes get filled in by demand paging on access.  In other
> >>>> words, they remain holes only as long as nothing accesses the memory.
> >>>>
> >>>> Without your patch, we allocate pages at image read time and fill them
> >>>> with zeroes. If we don't access them again, the kernel will eventually
> >>>> page them out (assuming you're running with swap).  So the steady state
> >>>> is "we waste some swap space", not "we waste some physical RAM".
> >>>>
> >>>
> >>> Not everybody wants to run with swap because it may cause low performance.
> >> 
> >> Someone running without swap because he heard someone say someone said
> >> swap may be slow is probably throwing away performance.
> >> 
> >> But I assume you mean people running without swap because they measured
> >> their workload and found it more performant without swap.  Legitimate.
> >
> > Yes, and I had ever suffered from the high IO waits with swap.:)
> >
> >> 
> >>>> Your patch lets us map pflash memory pages containing only zeros as
> >>>> holes.
> >>>>
> >>>> For pages that never get accessed, your patch avoids page allocation,
> >>>> filling with zeroes, writing to swap (all one-time costs), and saves
> >>>> some swap space (not commonly an issue).
> >>>>
> >>>> For pflash memory that gets accessed, your patch merely delays page
> >>>> allocation from image read time to first access.
> >>>>
> >>>> I wonder how these savings and delays affect actual system performance.
> >>>> Without an observable change in system performance, all we'd accomplish
> >>>> is changing a bunch of numers in /proc/$pid/.
> >>>>
> >>>> What improvement(s) can you observe?
> >>>
> >>> We only use pflash device for UEFI, and we hardly care about the performance.
> >>> I think the bottleneck of the performance is the MMIO emulation, even this
> >>> patch would delay page allocation at the first access.
> >> 
> >> I wasn't inquiring about the performance of the pflash device.  I was
> >> inquiring about *system* performance.  But let me rephrase my question.
> >> 
> >> Doing work to save resources is only worthwhile if something valuable
> >> gets better in a measurable way.  I'm asking you
> >> 
> >> (1) to explain what exactly you value, and 
> >> 
> >> (2) to provide measurements that show improvement.
> >> 
> >
> > What we exactly value is the cost of memory resources and it is the only
> > thing that this patch aims to resolve.
> 
> Then measure this cost!
> 
> > I am confused that why you think it will impact the system performance? Did I
> > neglect something?
> 
> If the patch does not impact how the system as a whole performs, then
> it's useless.
> 
> Since you find it useful, it must have some valuable[*] observable
> effect for you.  Tell us about it!
> 
> I keep asking not to torment you, but to guide you towards building a
> compelling justification for your patch.  However, I can only show you
> the path; the walking you'll have to do yourself.

Is this discussion really a good use of our time?

The patch is simple, and a few obvious improvements it brings were
mentioned (even by yourself), such as avoiding OOM without swap; and
with swap enabled, saving swap space for more useful content and
saving unnecessary I/O related to accessing swap needlessly.

You may consider these improvements neglegible, but even small
improvments can add up. If you really want to measure them, it should be
clear how to do it. I don't see value in actually setting up such
environments just to get some numbers that show what we already know.

So, what's the downside of the patch? The worst case is, the memory
usage numbers only look better, but most people don't have a use case
where the improvement matters. There might be some maintenance cost
associated with the code, but it's small and I suspect this discussion
has already cost us more time than maintaining the code will ever cost
us.

So why not just take it?

Kevin

