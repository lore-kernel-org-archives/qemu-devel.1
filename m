Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B6AC43331
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 00:47:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43F7E208C3
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 00:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fnarfbargle.com header.i=@fnarfbargle.com header.b="j9BoGElX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F7E208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fnarfbargle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Osp-0000Fu-4p
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 20:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lists2009@fnarfbargle.com>) id 1i6OrO-0007oO-Oz
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 20:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lists2009@fnarfbargle.com>) id 1i6OrN-0000bO-Ck
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 20:45:50 -0400
Received: from ns3.fnarfbargle.com ([103.4.19.87]:40302)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lists2009@fnarfbargle.com>)
 id 1i6OrM-0000XU-Ld; Fri, 06 Sep 2019 20:45:49 -0400
Received: from [10.8.0.1] (helo=srv.home ident=heh23595)
 by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.84_2) (envelope-from <lists2009@fnarfbargle.com>)
 id 1i6Ope-0005MU-CO; Sat, 07 Sep 2019 08:44:02 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=fnarfbargle.com; s=mail; 
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject;
 bh=s+V/sDK4sohm+58JlidQM/U+KvK/a3EfWVG8Z2VaSKQ=; 
 b=j9BoGElXjdN4vCxarj/6Kjqbj0oxht+PUXGA/jFK8fEdMbJQjeyoU/e3uE3YW3tNDI+DpRsIB6SnsEzKzREw11Yx0gB+1vVv4sQII6fxhhHWwffswvrXyUZaDiTVucS+J/df9ik05F4uyYcEVN//Ji75AD/kwFVy0t/GGPCYR7I=;
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <ed421291-7178-d7bc-5ed3-9863d28ceba9@fnarfbargle.com>
 <dd33a398-3c1f-0c92-2318-00ad144e1e5d@fnarfbargle.com>
 <b1782119-abbc-9678-8217-ef576dbf8c93@fnarfbargle.com>
 <20190906190351.GB20068@work-vm>
From: Brad Campbell <lists2009@fnarfbargle.com>
Message-ID: <a9799b8b-a294-59e3-f329-060b19cdcf0e@fnarfbargle.com>
Date: Sat, 7 Sep 2019 08:44:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906190351.GB20068@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 103.4.19.87
Subject: Re: [Qemu-devel] Cross-posted : Odd QXL/KVM performance issue with
 a Windows 7 Guest
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
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-discuss@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 7/9/19 03:03, Dr. David Alan Gilbert wrote:
> * Brad Campbell (lists2009@fnarfbargle.com) wrote:
>> On 2/9/19 6:23 pm, Brad Campbell wrote:
>>
>>> Here is the holdup :
>>>
>>> 11725@1567416625.003504:qxl_ring_command_check 0 native
>>> 11725@1567416625.102653:qxl_io_write 0 native addr=0 (QXL_IO_NOTIFY_CMD)
>>> val=0 size=1 async=0
>>>
>>> ~100ms delay prior to each logged QXL_IO_NOTIFY_CMD on the AMD box which
>>> explains the performance difference. Now I just need to figure out if
>>> that lies in the guest, the guest QXL driver, QEMU or SPICE and why it
>>> exhibits on the AMD box and not the i7.
>>>
>>> To get to this point, I recompiled the kernel on the i7 box with both
>>> AMD and Intel KVM modules. Once that was running I cloned the drive and
>>> put it in the AMD box, so the OS, software stack and all dependencies
>>> are identical.
>> Reacp :
>>
>> I have a machine with a Windows 7 VM which is running on an i7-3770. This
>> works perfectly.
>>
>> Clone the disk and put it in a new(ish) AMD Ryzen 1500x machine and the
>> display output using qxl/spice is now limited to ~5-7fps.
>>
>> I originally cloned the entire machine to keep the software versions
>> identical.
>>
>> To simplify debugging and reproduction I'm now using :
>> - An identical SPICE version to that on the i7.
>> - A fresh 64 bit Windows 7 VM.
>> - The D2D benchmark from Crystalmark 2004R7.
>>
>> The machine is booted with :
>>
>> qemu -enable-kvm \
>>   -m 8192\
>>   -rtc base=localtime\
>>   -vga qxl\
>>   -device qxl\
>>   -global qxl-vga.guestdebug=3\
>>   -global qxl-vga.cmdlog=1\
>>   -global qxl-vga.vram_size=65536\
>>   -global qxl.vram_size=65536\
>>   -global qxl-vga.ram_size=65536\
>>   -global qxl.ram_size=65536\
>>   -net nic,model=virtio\
>>   -net tap,ifname=tap0,script=/etc/qemu-ifup,vhost=on\
>>   -usbdevice tablet\
>>   -spice port=5930,disable-ticketing\
>>   -device virtio-serial\
>>   -chardev spicevmc,id=vdagent,name=vdagent\
>>   -device virtserialport,chardev=vdagent,name=com.redhat.spice.0\
>>   -smp 3,maxcpus=3,cores=3,threads=1,sockets=1\
>>   -cpu qemu64,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time \
> -cpu qemu64 is almost always a bad idea;  does -cpu host help ?
>
> Dave


No. I was using -cpu host. I changed it to qemu64 for testing so I could add & remove -enable-kvm for testing without the machine changing drivers about.

Regards,

Brad

-- 
An expert is a person who has found out by his own painful
experience all the mistakes that one can make in a very
narrow field. - Niels Bohr


