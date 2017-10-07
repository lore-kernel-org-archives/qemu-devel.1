Received: from eggs.gnu.org ([2001:4830:134:3::10]:36453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <koushikcseist@gmail.com>) id 1e0jvM-00036Y-DT
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 03:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <koushikcseist@gmail.com>) id 1e0jvL-0005tL-EB
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 03:53:28 -0400
Received: from mail-it0-x22e.google.com ([2607:f8b0:4001:c0b::22e]:55244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <koushikcseist@gmail.com>)
	id 1e0jvL-0005t3-9N
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 03:53:27 -0400
Received: by mail-it0-x22e.google.com with SMTP id 72so7286635itk.3
	for <qemu-devel@nongnu.org>; Sat, 07 Oct 2017 00:53:26 -0700 (PDT)
MIME-Version: 1.0
From: Koushik Dutta <koushikcseist@gmail.com>
Date: Sat, 7 Oct 2017 13:23:25 +0530
Message-ID: <CAFq1WaKFes0czd9bKSWA0jbBWGiBk-vu+Owra6u-JGGjADui5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Using qemu command not able launch VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi All (qemu members),

I installed qemu utility in my host machine. I want to start Virtual
machine using qemu command.

My host machine: Intel-X86
Script for launching VM :

T=/home/koushik/vpp/cloud_ubuntu_img
    sudo qemu-system-i386  -enable-kvm -m 1024 -smp
sockets=1,cpus=4,cores=2 -cpu host \
    -vga none -nographic \
    -kernel $T/vmlinuz-4.4.0-96-generic --append "console=ttyAMA0
root=/dev/vda rw"  \
    -drive file=$T/custom32.img,if=virtio,aio=threads \
    -chardev socket,id=char1,path=/tmp/sock1.sock \
    -netdev type=vhost-user,id=mynet1,chardev=char1,vhostforce\
    -device virtio-net-pci,mac=00:00:00:00:00:01,netdev=mynet1 \
    -object
memory-backend-file,id=mem,size=1024M,mem-path=/dev/hugepages,share=on \
    -numa node,memdev=mem -mem-prealloc \
    #-debugcon file:debug.log -global isa-debugcon.iobase=0x402


Bug:  Invalid netdev type

Please let me know where i did wrong.
Please help me.
Thanks to all in advance.


Thanks & Regards,
Koushik
