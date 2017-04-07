Received: from eggs.gnu.org ([2001:4830:134:3::10]:60956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cwZZZ-0007Mv-CN
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 15:29:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cwZZY-0000PA-Ad
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 15:29:29 -0400
In-Reply-To: <AM5P194MB01294EAC74E1825F9210E04CC80C0@AM5P194MB0129.EURP194.PROD.OUTLOOK.COM>
References: <20170407060752.31313-1-nikunj@linux.vnet.ibm.com>
	<AM5P194MB01294EAC74E1825F9210E04CC80C0@AM5P194MB0129.EURP194.PROD.OUTLOOK.COM>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2883915A-A579-4BC2-9FBE-5D885B88AF22@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Fri, 7 Apr 2017 15:29:18 -0400
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 0/3] Enable MTTCG on PPC64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: luigi burdo <intermediadc@hotmail.com>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>, "rth@twiddle.net" <rth@twiddle.net>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "bharata@linux.vnet.ibm.com" <bharata@linux.vnet.ibm.com>


On Apr 7, 2017, at 1:49 PM, luigi burdo wrote:

> Tested on PowerMac G5 Quad  and 380% of system load and working on
> Fedora 25 PPC64 host and Ubuntu Mate 17.04 guest  (patched the 2.9  
> rc3)
>
> The machine configuration was this
>
> sudo ./qemu-system-ppc64 -cpu POWER8 -vga none -machine  
> pseries-2.5,usb=off -m 2G  -smp 4,cores=4,threads=1 -accel  
> tcg,thread=multi  -kerne vmlinuz    -append root=/dev/sda   -device  
> ich9-ahci,id=ahci   -device ide-drive,drive=disk0 -drive file=/dev/ 
> sda4,if=none,id=disk0   -net nic,model=pcnet -net user -soundhw  
> hda  -display sdl -vga virtio
>
> vga virtio working too
> here a shot
> https://scontent-mxp1-1.xx.fbcdn.net/v/ 
> t1.0-9/17796379_10208795258860396_7825547329794577576_n.jpg? 
> oh=526d6ddeb67c817053582d5b9ee56c71&oe=594D7BDF
>
> Thanks
> Luigi

Do you have any timings? Did the guest run faster?
