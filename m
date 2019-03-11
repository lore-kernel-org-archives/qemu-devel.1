Received: from eggs.gnu.org ([209.51.188.92]:55556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mick@ics.forth.gr>) id 1h3Pxu-0001Ko-Ca
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:48:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mick@ics.forth.gr>) id 1h3PgA-0004JB-4k
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:29:39 -0400
Received: from mailgate-2.ics.forth.gr ([139.91.1.5]:46482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mick@ics.forth.gr>) id 1h3Pg9-0004Cj-DB
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:29:38 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Mon, 11 Mar 2019 20:28:37 +0200
From: Nick Kossifidis <mick@ics.forth.gr>
In-Reply-To: <CAOuPNLgobR4ejPs_ZUuXpRwkURH0sfb1LD27TKhGg=wrwhUvZg@mail.gmail.com>
References: <CAOuPNLgobR4ejPs_ZUuXpRwkURH0sfb1LD27TKhGg=wrwhUvZg@mail.gmail.com>
Message-ID: <2c5d240eabdb56913f4abcc9aacf2b6b@mailhost.ics.forth.gr>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] ssh session with qemu-arm using busybox
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pintu Agarwal <pintu.ping@gmail.com>
Cc: open list <linux-kernel@vger.kernel.org>, kernelnewbies@kernelnewbies.org, linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, qemu-devel@nongnu.org, =?UTF-8?Q?=EC=A0=84=EC=A7=84=EC=98=81?= <jy0.jeon@gmail.com>

=CE=A3=CF=84=CE=B9=CF=82 2019-03-11 16:34, Pintu Agarwal =CE=AD=CE=B3=CF=81=
=CE=B1=CF=88=CE=B5:
> Hi,
>=20
> I have a qemu-arm setup with busybox which I normally use to test my
> kernel changes.
> I use this command to boot it:
>=20
> QEMU-ARM$
> qemu-system-arm -M vexpress-a9 -m 1024M -kernel
> ../KERNEL/linux/arch/arm/boot/zImage -dtb
> ../KERNEL/linux/arch/arm/boot/dts/vexpress-v2p-ca9.dtb -initrd
> rootfs.img.gz -append "console=3DttyAMA0 root=3D/dev/ram rdinit=3D/sbin=
/init
> ip=3Ddhcp" -nographic -smp 4
>=20
> This includes, my own custom kernel and rootfs build.
> For rootfs I use busybox and create cpio image and use it as initrd.
>=20
> But, every time, if I have to copy some files inside qemu, I need to
> create create roofs image.
> This is painful.
>=20
> So, now I am exploring how to transfer files from my ubuntu pc to
> qemu-session using "ssh".
> I know this is possible, but I am still not successful, and bit lazy
> to explore these.
>=20
> I am sure, many of you people would have explored already "how to use
> ssh over qemu" and found a easy method.
> So, if anybody have easy setup please share with me.
>=20
> I could see that after adding "ip=3Ddhcp" I get the eth0 interface like=
=20
> this:
> / # ifconfig
> eth0      Link encap:Ethernet  HWaddr 52:54:00:12:34:56
>           inet addr:10.0.2.15  Bcast:10.0.2.255  Mask:255.255.255.0
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:2 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:2 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000
>           RX bytes:1180 (1.1 KiB)  TX bytes:1180 (1.1 KiB)
>           Interrupt:22
>=20
> lo        Link encap:Local Loopback
>           inet addr:127.0.0.1  Mask:255.0.0.0
>           UP LOOPBACK RUNNING  MTU:65536  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000
>           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
>=20
> But I could not ping it from ubuntu PC.
>=20
>=20
> Regards,
> Pintu
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

You may use the hostfw argument on qemu, e.g...

-netdev user,id=3Dunet,hostfwd=3Dtcp::2222-:22 \
-net user \

and you 'll get guest's port 22 to be forwarded to hosts port 2222, so=20
you can do

ssh root@localhost:2222

from the host.

Regards,
Nick
