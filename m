Received: from eggs.gnu.org ([209.51.188.92]:59334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pintu.ping@gmail.com>) id 1h3M1C-0003oQ-In
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pintu.ping@gmail.com>) id 1h3M1B-00064p-PC
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:35:06 -0400
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36]:39205)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pintu.ping@gmail.com>)
	id 1h3M1B-00063O-Dt
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:35:05 -0400
Received: by mail-vs1-xe36.google.com with SMTP id w14so2823968vso.6
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 07:35:05 -0700 (PDT)
MIME-Version: 1.0
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Mon, 11 Mar 2019 20:04:53 +0530
Message-ID: <CAOuPNLgobR4ejPs_ZUuXpRwkURH0sfb1LD27TKhGg=wrwhUvZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] ssh session with qemu-arm using busybox
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: open list <linux-kernel@vger.kernel.org>, kernelnewbies@kernelnewbies.org, linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, qemu-devel@nongnu.org, =?UTF-8?B?7KCE7KeE7JiB?= <jy0.jeon@gmail.com>

Hi,

I have a qemu-arm setup with busybox which I normally use to test my
kernel changes.
I use this command to boot it:

QEMU-ARM$
qemu-system-arm -M vexpress-a9 -m 1024M -kernel
../KERNEL/linux/arch/arm/boot/zImage -dtb
../KERNEL/linux/arch/arm/boot/dts/vexpress-v2p-ca9.dtb -initrd
rootfs.img.gz -append "console=ttyAMA0 root=/dev/ram rdinit=/sbin/init
ip=dhcp" -nographic -smp 4

This includes, my own custom kernel and rootfs build.
For rootfs I use busybox and create cpio image and use it as initrd.

But, every time, if I have to copy some files inside qemu, I need to
create create roofs image.
This is painful.

So, now I am exploring how to transfer files from my ubuntu pc to
qemu-session using "ssh".
I know this is possible, but I am still not successful, and bit lazy
to explore these.

I am sure, many of you people would have explored already "how to use
ssh over qemu" and found a easy method.
So, if anybody have easy setup please share with me.

I could see that after adding "ip=dhcp" I get the eth0 interface like this:
/ # ifconfig
eth0      Link encap:Ethernet  HWaddr 52:54:00:12:34:56
          inet addr:10.0.2.15  Bcast:10.0.2.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:2 errors:0 dropped:0 overruns:0 frame:0
          TX packets:2 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:1180 (1.1 KiB)  TX bytes:1180 (1.1 KiB)
          Interrupt:22

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

But I could not ping it from ubuntu PC.


Regards,
Pintu
