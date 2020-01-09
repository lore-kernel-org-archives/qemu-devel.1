Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B6DC282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 18:21:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 146C5206ED
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 18:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 146C5206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kamp.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipcQg-0006hj-6m
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 13:21:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pl@kamp.de>) id 1ipcPl-0006AO-0W
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 13:20:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pl@kamp.de>) id 1ipcPj-0007f0-77
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 13:20:12 -0500
Received: from kerio.kamp.de ([195.62.97.192]:42085)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pl@kamp.de>) id 1ipcPi-0007BE-VB
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 13:20:11 -0500
X-Footer: a2FtcC5kZQ==
Received: from [172.21.12.60] ([172.21.12.60]) (authenticated user pl@kamp.de)
 by kerio.kamp.de with ESMTPSA
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
 Thu, 9 Jan 2020 19:19:57 +0100
Subject: Re: qemu-4.0.1: vhost_region_add_section:Section rounded to 0 prior
 to previous a0000
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <985fea06-ede6-dcb7-8829-a48a9416bc09@kamp.de>
 <20200108150458.GC3184@work-vm>
From: Peter Lieven <pl@kamp.de>
Message-ID: <ca222a5f-1ec6-477c-ed83-6ef52ea9e97f@kamp.de>
Date: Thu, 9 Jan 2020 19:19:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108150458.GC3184@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 195.62.97.192
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 08.01.20 um 16:04 schrieb Dr. David Alan Gilbert:
> * Peter Lieven (pl@kamp.de) wrote:
>> Hi,
>>
>>
>> I have a Qemu 4.0.1 machine with vhost-net network adapter, thats polluting the log with the above message.
>>
>> Is this something known? Googling revealed the following patch in Nemu (with seems to be a Qemu fork from Intel):
>>
>> https://github.com/intel/nemu/commit/03940ded7f5370ce7492c619dccced114ef7f56e
>>
>>
>> The network stopped functioning. After a live-migration the vServer is reachable again.
>>
>>
>> Any ideas?
> What guest are you running and what does your qemu commandline look
> like?


Its running debian9. We have hundreds of other VMs with identical setup. Do not know why this one makes trouble.

Here is the cmdline:


/usr/bin/qemu-4.0.0  -enable-kvm  -M pc-i440fx-2.9  -nodefaults -netdev type=tap,id=guest0,script=no,downscript=no,ifname=tap0,vhost=on,vnet_hdr=on -device virtio-net-pci,netdev=guest0,mac=52:54:00:80:07:bc -iscsi 
initiator-name=iqn.2005-03.org.virtual-core:0025b51f006c,timeout=30 -object rng-random,filename=/dev/urandom,id=rng0 -device virtio-rng-pci,rng=rng0,max-bytes=65536,period=1000  -drive 
format=raw,discard=on,detect-zeroes=off,file=XXX,if=none,cache=writeback,aio=native,id=disk0 -device virtio-scsi-pci  -device scsi-hd,drive=disk0  -serial null  -parallel null  -m 1024,slots=16,maxmem=393216M  -smp 
1,sockets=64,cores=1,threads=1,maxcpus=64  -monitor tcp:0:4001,server,nowait,nodelay -vnc :1 -qmp tcp:0:3001,server,nowait,nodelay  -name 'debian9'  -drive index=2,media=cdrom,if=ide,aio=native,readonly=on  -boot order=c,menu=off  -k de  -pidfile 
/var/run/qemu/vm-5182.pid -mem-path /hugepages  -mem-prealloc  -cpu Westmere,+pcid,enforce -rtc base=utc -usb -device usb-tablet -no-hpet -vga vmware -chardev socket,host=127.0.0.1,port=2001,id=qga0,server,nowait,nodelay -device virtio-serial -device 
virtserialport,chardev=qga0,name=org.qemu.guest_agent.0


Thanks,

Peter



