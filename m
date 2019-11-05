Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA793CA9ED3
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 02:41:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83D0021882
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 02:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fnarfbargle.com header.i=@fnarfbargle.com header.b="wDVzBrji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D0021882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fnarfbargle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRomD-00061R-LN
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 21:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lists2009@fnarfbargle.com>) id 1iRokw-00050k-J4
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 21:39:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lists2009@fnarfbargle.com>) id 1iRokv-0000VT-54
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 21:39:42 -0500
Received: from ns3.fnarfbargle.com ([103.4.19.87]:58398)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lists2009@fnarfbargle.com>)
 id 1iRoku-0000Bx-Hv; Mon, 04 Nov 2019 21:39:41 -0500
Received: from [10.8.0.1] (helo=srv.home ident=heh30858)
 by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.84_2) (envelope-from <lists2009@fnarfbargle.com>)
 id 1iRoja-0005P0-KY; Tue, 05 Nov 2019 10:38:18 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=fnarfbargle.com; s=mail; 
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:To:Subject:From;
 bh=LN06c4LQfBV3TkpgzpR/SsY1fEUCkQJoyr9kgAD1mSQ=; 
 b=wDVzBrjirBYMpiu6GKziDlsFZwnxhDVxeyFacOoRukOQYSz502n0Qf8+Sl/v+9lULE76l2lDDT5hQRKviMw9mRNMN57qr0RlThBEOLhG9APK4ZOC8OM4CeOWtPpm2KXvd6rn2k6vkwJtXrfKQOEZn/GmfIhKg9ODcYs8DrhgKzw=;
From: Brad Campbell <lists2009@fnarfbargle.com>
Subject: Re: [Qemu-discuss] Cross-posted : Odd QXL/KVM performance issue with
 a Windows 7 Guest
To: qemu-discuss@nongnu.org, qemu-devel <qemu-devel@nongnu.org>
References: <ed421291-7178-d7bc-5ed3-9863d28ceba9@fnarfbargle.com>
 <dd33a398-3c1f-0c92-2318-00ad144e1e5d@fnarfbargle.com>
 <b1782119-abbc-9678-8217-ef576dbf8c93@fnarfbargle.com>
Message-ID: <6186a915-7796-e91e-7bc0-48d5a5586596@fnarfbargle.com>
Date: Tue, 5 Nov 2019 10:38:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b1782119-abbc-9678-8217-ef576dbf8c93@fnarfbargle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 103.4.19.87
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/9/19 4:49 pm, Brad Campbell wrote:
> On 2/9/19 6:23 pm, Brad Campbell wrote:
> 
>>
>> Here is the holdup :
>>
>> 11725@1567416625.003504:qxl_ring_command_check 0 native
>> 11725@1567416625.102653:qxl_io_write 0 native addr=0 
>> (QXL_IO_NOTIFY_CMD) val=0 size=1 async=0
>>
>> ~100ms delay prior to each logged QXL_IO_NOTIFY_CMD on the AMD box 
>> which explains the performance difference. Now I just need to figure 
>> out if that lies in the guest, the guest QXL driver, QEMU or SPICE and 
>> why it exhibits on the AMD box and not the i7.
>>
>> To get to this point, I recompiled the kernel on the i7 box with both 
>> AMD and Intel KVM modules. Once that was running I cloned the drive 
>> and put it in the AMD box, so the OS, software stack and all 
>> dependencies are identical.
> 
> Reacp :
> 
> I have a machine with a Windows 7 VM which is running on an i7-3770. 
> This works perfectly.
> 
> Clone the disk and put it in a new(ish) AMD Ryzen 1500x machine and the 
> display output using qxl/spice is now limited to ~5-7fps.
> 
> I originally cloned the entire machine to keep the software versions 
> identical.
> 
> To simplify debugging and reproduction I'm now using :
> - An identical SPICE version to that on the i7.
> - A fresh 64 bit Windows 7 VM.
> - The D2D benchmark from Crystalmark 2004R7.
> 
> The machine is booted with :
> 
> qemu -enable-kvm \
>   -m 8192\
>   -rtc base=localtime\
>   -vga qxl\
>   -device qxl\
>   -global qxl-vga.guestdebug=3\
>   -global qxl-vga.cmdlog=1\
>   -global qxl-vga.vram_size=65536\
>   -global qxl.vram_size=65536\
>   -global qxl-vga.ram_size=65536\
>   -global qxl.ram_size=65536\
>   -net nic,model=virtio\
>   -net tap,ifname=tap0,script=/etc/qemu-ifup,vhost=on\
>   -usbdevice tablet\
>   -spice port=5930,disable-ticketing\
>   -device virtio-serial\
>   -chardev spicevmc,id=vdagent,name=vdagent\
>   -device virtserialport,chardev=vdagent,name=com.redhat.spice.0\
>   -smp 3,maxcpus=3,cores=3,threads=1,sockets=1\
>   -cpu qemu64,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time \
>   -drive 
> file=/server/VM/Cadbox.raw,if=virtio,aio=threads,format=raw,cache=unsafe 
> -boot c \
>   -drive 
> file=/server/VM/Cadbox_swap.raw,if=virtio,aio=threads,format=raw,cache=unsafe 
> \
> 
> 
> The D2D benchmark runs through a series of Sprites (stars) and it just 
> shuffles them around the screen.
> 
> With KVM enabled I get :
> 
> Sprite    10 - 8.66fps
> Sprite   100 - 8.47fps
> Sprite   500 - 8.45fps
> Sprite  1000 - 8.18fps
> Sprite  5000 - 7.64fps
> Sprite 10000 - 7.26fps
> 
> With the identical system, with KVM disabled I get :
> 
> Sprite    10 - 28.97fps
> Sprite   100 - 27.24fps
> Sprite   500 - 23.85fps
> Sprite  1000 - 22.00fps
> Sprite  5000 - 11.11fps
> Sprite 10000 -  4.50fps
> 
> On the i7 with the same software version and kvm enabled  :
> 
> Sprite    10 - 88.58fps
> Sprite   100 - 88.35fps
> Sprite   500 - 85.64fps
> Sprite  1000 - 83.33fps
> Sprite  5000 - 58.08fps
> Sprite 10000 - 45.29fps
> 

Just to round this out, I spent quite a bit of time trying to profile 
the guest and qxl driver, and then gave up.

I tried installing Windows 8.1 and the new WDDM driver and it didn't 
exhibit the fault, so I resigned myself to rebuild all the guests.

Regards,
Brad
-- 
An expert is a person who has found out by his own painful
experience all the mistakes that one can make in a very
narrow field. - Niels Bohr

