Received: from eggs.gnu.org ([2001:4830:134:3::10]:33869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jack.wang.usish@gmail.com>) id 1d0pSN-0002mo-Gc
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 09:15:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jack.wang.usish@gmail.com>) id 1d0pSJ-0002m8-FG
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 09:15:39 -0400
Received: from mail-qk0-x22a.google.com ([2607:f8b0:400d:c09::22a]:34354)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jack.wang.usish@gmail.com>)
	id 1d0pSJ-0002lm-8q
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 09:15:35 -0400
Received: by mail-qk0-x22a.google.com with SMTP id p68so19353693qke.1
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 06:15:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170419120850.12262.4252.malone@soybean.canonical.com>
References: <20151206150708.14182.82430.malonedeb@wampee.canonical.com>
	<20170419120850.12262.4252.malone@soybean.canonical.com>
From: Jack Wang <jack.wang.usish@gmail.com>
Date: Wed, 19 Apr 2017 15:15:34 +0200
Message-ID: <CA+res+QMEc4qxpFt0FEX5rrLa7MP2cXEBZfVH++KTofRnEMDMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Bug 1523246] Re: Virtio-blk does not support TRIM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1523246 <1523246@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org

Latest effort was one month ago:

https://patchwork.kernel.org/patch/9645537/

2017-04-19 14:08 GMT+02:00 Mike Mol <mikemol@gmail.com>:
> discard support for virtio-blk is on the QEMU TODO list:
>
> http://wiki.qemu-project.org/ToDo/Block#virtio-
> blk_discard_support_.5BPeter_Lieven.5D
>
> --
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1523246
>
> Title:
>   Virtio-blk does not support TRIM
>
> Status in QEMU:
>   Confirmed
>
> Bug description:
>   When model=virtio is used, TRIM is not supported.
>
>   # mount -o discard /dev/vda4 /mnt
>   # mount | tail -1
>   /dev/vda4 on /mnt type fuseblk (rw,nosuid,nodev,relatime,user_id=0,group_id=0,allow_other,blksize=4096)
>   # fstrim /mnt/
>   fstrim: /mnt/: the discard operation is not supported
>
>   Booting without model=virtio allows using TRIM (in Windows as well).
>
>   Full QEMU line:
>
>   qemu-system-x86_64 -enable-kvm -cpu host -bios
>   /usr/share/ovmf/ovmf_x64.bin -smp 2 -m 7G -vga qxl -usbdevice tablet
>   -net nic,model=virtio -net user -drive discard=unmap,detect-
>   zeroes=unmap,cache=none,file=vms/win10.hd.img.vmdk,format=vmdk,if=virtio
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1523246/+subscriptions
>
