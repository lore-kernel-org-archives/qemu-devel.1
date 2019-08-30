Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A838CC3A5A3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 04:54:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71C9F2186A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 04:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C9F2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Yvo-0004N9-Ir
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 00:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43055)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jing2.liu@linux.intel.com>) id 1i3Yuq-0003yR-AF
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 00:53:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jing2.liu@linux.intel.com>) id 1i3Yuo-0003EH-PY
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 00:53:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:54557)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jing2.liu@linux.intel.com>)
 id 1i3Yuo-00038f-FZ
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 00:53:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Aug 2019 21:53:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,445,1559545200"; d="scan'208";a="381890493"
Received: from liujing-mobl.ccr.corp.intel.com (HELO [10.238.128.246])
 ([10.238.128.246])
 by fmsmga006.fm.intel.com with ESMTP; 29 Aug 2019 21:53:30 -0700
To: Sergio Lopez <slp@redhat.com>
References: <20190702121106.28374-1-slp@redhat.com>
 <879c7f68-95a3-3bf6-cba8-d3465770d399@linux.intel.com>
 <87lfvc3rgj.fsf@redhat.com>
From: Jing Liu <jing2.liu@linux.intel.com>
Message-ID: <18777980-a2ca-fe27-419b-6e2bd213dd17@linux.intel.com>
Date: Fri, 30 Aug 2019 12:53:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87lfvc3rgj.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Introduce the microvm machine type
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
Cc: ehabkost@redhat.com, maran.wilson@oracle.com, mst@redhat.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, pbonzini@redhat.com,
 sgarzare@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sergio,

On 8/29/2019 11:46 PM, Sergio Lopez wrote:
> 
> Jing Liu <jing2.liu@linux.intel.com> writes:
> 
>> Hi Sergio,
>>
>> The idea is interesting and I tried to launch a guest by your
>> guide but seems failed to me. I tried both legacy and normal modes,
>> but the vncviewer connected and told me that:
>> The vm has no graphic display device.
>> All the screen in vnc is just black.
> 
> The microvm machine type doesn't support any graphics device, so you
> need to rely on the serial console.
Got it.

> 
>> kernel config:
>> CONFIG_KVM_MMIO=y
>> CONFIG_VIRTIO_MMIO=y
>>
>> I don't know if any specified kernel version/patch/config
>> is needed or anything I missed.
>> Could you kindly give some tips?
> 
> I'm testing it with upstream vanilla Linux. In addition to MMIO, you
> need to add support for PVH (the next version of this patchset, v4, will
> support booting from FW, so it'll be possible to use non-PVH ELF kernels
> and bzImages too).
> 
> I've just uploaded a working kernel config here:
> 
> https://gist.github.com/slp/1060ba3aaf708584572ad4109f28c8f9
> 
Thanks very much and this config is helpful to me.

> As for the QEMU command line, something like this should do the trick:
> 
> ./x86_64-softmmu/qemu-system-x86_64 -smp 1 -m 1g -enable-kvm -M microvm,legacy -kernel vmlinux -append "earlyprintk=ttyS0 console=ttyS0 reboot=k panic=1" -nodefaults -no-user-config -nographic -serial stdio
> 
> If this works, you can move to non-legacy mode with a virtio-console:
> 
> ./x86_64-softmmu/qemu-system-x86_64 -smp 1 -m 1g -enable-kvm -M microvm -kernel vmlinux -append "console=hvc0 reboot=k panic=1" -nodefaults -no-user-config -nographic -serial pty -chardev stdio,id=virtiocon0,server -device virtio-serial-device -device virtconsole,chardev=virtiocon0
> 
I tried the above two ways and it works now. Thanks!

> If is still working, you can try adding some devices too:
> 
> ./x86_64-softmmu/qemu-system-x86_64 -smp 1 -m 1g -enable-kvm -M microvm -kernel vmlinux -append "console=hvc0 reboot=k panic=1 root=/dev/vda" -nodefaults -no-user-config -nographic -serial pty -chardev stdio,id=virtiocon0,server -device virtio-serial-device -device virtconsole,chardev=virtiocon0 -netdev user,id=testnet -device virtio-net-device,netdev=testnet -drive id=test,file=alpine-rootfs-x86_64.raw,format=raw,if=none -device virtio-blk-device,drive=test
> 
But I'm wondering why the image I used can not be found.
root=/dev/vda3 and the same image worked well on normal qemu/guest-
config bootup, but didn't work here. The details are,

-append "console=hvc0 reboot=k panic=1 root=/dev/vda3 rw rootfstype=ext4" \

[    0.022784] Key type encrypted registered
[    0.022988] VFS: Cannot open root device "vda3" or 
unknown-block(254,3): error -6
[    0.023041] Please append a correct "root=" boot option; here are the 
available partitions:
[    0.023089] fe00         8946688 vda
[    0.023090]  driver: virtio_blk
[    0.023143] Kernel panic - not syncing: VFS: Unable to mount root fs 
on unknown-block(254,3)
[    0.023201] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.3.0-rc3 #23


BTW, root=/dev/vda is also tried and didn't work. The dmesg is a little 
different:

[    0.028050] Key type encrypted registered
[    0.028484] List of all partitions:
[    0.028529] fe00         8946688 vda
[    0.028529]  driver: virtio_blk
[    0.028615] No filesystem could mount root, tried:
[    0.028616]  ext4
[    0.028670]
[    0.028712] Kernel panic - not syncing: VFS: Unable to mount root fs 
on unknown-block(254,0)

I tried another ext4 img but still doesn't work.
Is there any limitation of blk image? Could I copy your image for simple
test?

Thanks in advance,
Jing

> Sergio.
> 
>> Thanks very much.
>> Jing
>>
>>
>>
>>> A QEMU instance with the microvm machine type can be invoked this way:
>>>
>>>    - Normal mode:
>>>
>>> qemu-system-x86_64 -M microvm -m 512m -smp 2 \
>>>    -kernel vmlinux -append "console=hvc0 root=/dev/vda" \
>>>    -nodefaults -no-user-config \
>>>    -chardev pty,id=virtiocon0,server \
>>>    -device virtio-serial-device \
>>>    -device virtconsole,chardev=virtiocon0 \
>>>    -drive id=test,file=test.img,format=raw,if=none \
>>>    -device virtio-blk-device,drive=test \
>>>    -netdev tap,id=tap0,script=no,downscript=no \
>>>    -device virtio-net-device,netdev=tap0
>>>
>>>    - Legacy mode:
>>>
>>> qemu-system-x86_64 -M microvm,legacy -m 512m -smp 2 \
>>>    -kernel vmlinux -append "console=ttyS0 root=/dev/vda" \
>>>    -nodefaults -no-user-config \
>>>    -drive id=test,file=test.img,format=raw,if=none \
>>>    -device virtio-blk-device,drive=test \
>>>    -netdev tap,id=tap0,script=no,downscript=no \
>>>    -device virtio-net-device,netdev=tap0 \
>>>    -serial stdio
>>>
> 

