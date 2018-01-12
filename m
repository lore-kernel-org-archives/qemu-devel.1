Received: from eggs.gnu.org ([2001:4830:134:3::10]:56993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZz9X-00019D-Vw
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:13:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZz9U-000329-PD
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:13:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eZz9U-00031V-JN
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:13:44 -0500
Date: Fri, 12 Jan 2018 14:13:35 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180112131335.cea7zr4f4lu43z2s@sirius.home.kraxel.org>
References: <20180111132724.13744-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180111132724.13744-1-linzhecheng@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v3] vga: check the validation of memory
 addr when draw text
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>
Cc: ppandit@redhat.com, qemu-devel@nongnu.org, fabrice@bellard.org, wangxinxin.wang@huawei.com, arei.gonglei@huawei.com

On Thu, Jan 11, 2018 at 09:27:24PM +0800, linzhecheng wrote:
> Start a vm with qemu-kvm -enable-kvm -vnc :66 -smp 1 -m 1024 -hda
> redhat_5.11.qcow2  -device pcnet -vga cirrus,
> then use VNC client to connect to VM, and excute the code below in guest
> OS will lead to qemu crash:
> 
> int main()
>  {
>     iopl(3);
>     srand(time(NULL));
>     int a,b;
>     while(1){
> 	a = rand()%0x100;
> 	b = 0x3c0 + (rand()%0x20);
>         outb(a,b);
>     }
>     return 0;
> }
> 
> The above code is writing the registers of VGA randomly.
> We can write VGA CRT controller registers index 0x0C or 0x0D
> (which is the start address register) to modify the
> the display memory address of the upper left pixel
> or character of the screen. The address may be out of the
> range of vga ram. So we should check the validation of memory address
> when reading or writing it to avoid segfault.

Patch queued up.

thanks,
  Gerd
