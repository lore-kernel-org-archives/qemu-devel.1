Received: from eggs.gnu.org ([2001:4830:134:3::10]:47016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1e1aBQ-00010a-Et
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:41:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1e1aBM-0008SB-I7
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:41:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1e1aBM-0008Rj-Bf
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:41:28 -0400
References: <CAFq1WaKFes0czd9bKSWA0jbBWGiBk-vu+Owra6u-JGGjADui5g@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <9138d85e-26c5-71f5-54c0-44da066169c3@redhat.com>
Date: Mon, 9 Oct 2017 11:41:25 -0400
MIME-Version: 1.0
In-Reply-To: <CAFq1WaKFes0czd9bKSWA0jbBWGiBk-vu+Owra6u-JGGjADui5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Using qemu command not able launch VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Koushik Dutta <koushikcseist@gmail.com>, qemu-devel@nongnu.org



On 10/07/2017 03:53 AM, Koushik Dutta wrote:
> Hi All (qemu members),
> 
> I installed qemu utility in my host machine. I want to start Virtual
> machine using qemu command.
> 
> My host machine: Intel-X86
> Script for launching VM :
> 
> T=/home/koushik/vpp/cloud_ubuntu_img
>     sudo qemu-system-i386  -enable-kvm -m 1024 -smp
> sockets=1,cpus=4,cores=2 -cpu host \
>     -vga none -nographic \
>     -kernel $T/vmlinuz-4.4.0-96-generic --append "console=ttyAMA0
> root=/dev/vda rw"  \
>     -drive file=$T/custom32.img,if=virtio,aio=threads \
>     -chardev socket,id=char1,path=/tmp/sock1.sock \
>     -netdev type=vhost-user,id=mynet1,chardev=char1,vhostforce\
>     -device virtio-net-pci,mac=00:00:00:00:00:01,netdev=mynet1 \
>     -object
> memory-backend-file,id=mem,size=1024M,mem-path=/dev/hugepages,share=on \
>     -numa node,memdev=mem -mem-prealloc \
>     #-debugcon file:debug.log -global isa-debugcon.iobase=0x402
> 
> 
> Bug:  Invalid netdev type
> 
> Please let me know where i did wrong.
> Please help me.
> Thanks to all in advance.
> 
> 
> Thanks & Regards,
> Koushik
> 

type isn't a named parameter, it's positional.

-netdev vhost-user,foo=bar

Please take a look at the output from -help. look for "vhost-user."

--js
