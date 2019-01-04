Received: from eggs.gnu.org ([208.118.235.92]:48586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <t.glaser@tarent.de>) id 1gfK5r-0001pB-SJ
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 02:40:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <t.glaser@tarent.de>) id 1gfK5q-0004cy-OI
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 02:40:35 -0500
Received: from herc.mirbsd.org ([2001:470:1f15:10c:202:b3ff:feb7:54e8]:48716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <t.glaser@tarent.de>) id 1gfK5q-0004XZ-Bn
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 02:40:34 -0500
Date: Fri, 4 Jan 2019 07:30:42 +0000 (UTC)
From: Thorsten Glaser <t.glaser@tarent.de>
In-Reply-To: <20190104053013.GA6519@lorien.valinor.li>
Message-ID: <Pine.BSM.4.64L.1901040722540.14540@herc.mirbsd.org>
References: <154644530361.2390.18185252504260044930.reportbug@ci-busyapps.lan.tarent.de>
	<154644530361.2390.18185252504260044930.reportbug@ci-busyapps.lan.tarent.de>
	<20190102163939.GB13145@eldamar.local>
	<154644530361.2390.18185252504260044930.reportbug@ci-busyapps.lan.tarent.de>
	<20190104053013.GA6519@lorien.valinor.li>
	<CA+CK2bC70pnL0Wimb0xt99J4nNfi8W3zuUHgAk-jsPuOP9jpHA@mail.gmail.com>
Content-Language: de-DE-1901, en-GB
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Subject: Re: [Qemu-devel] [PATCH v15 23/26] sched: early boot clock (was Re:
 Bug#918036: linux: uptime after reboot wrong (kvm-clock related?))
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Salvatore Bonaccorso <carnil@debian.org>, 918036@bugs.debian.org, Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, Dominique Martinet <asmadeus@codewreck.org>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com, douly.fnst@cn.fujitsu.com, Peter Zijlstra <peterz@infradead.org>, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, qemu-devel@nongnu.org

Hi Salvatore,

>p.s.: my earlier reply to you seem to have been rejected and never
>      reached you, hope this one does now.

if you sent from Googlemail, it may reach me in the next weeks or
never *shrug* they don=E2=80=99t play nice with greylisting. The -submitter
or @d.o works, though. I=E2=80=99m following up from my $dayjob address as
the issue occurred there (which is also Googlemail, unfortunately).

>There was now a followup on this, and if you can I think it's best if
>you can followup there.
>
>https://lore.kernel.org/lkml/CA+CK2bC70pnL0Wimb0xt99J4nNfi8W3zuUHgAk-jsPuO=
P9jpHA@mail.gmail.com/

OK, doing now:


Pavel Tatashin wrote:

>Could you please send the config file and qemu arguments that were
>used to reproduce this problem.

This is from a libvirt-managed system. The arguments as shown by
=E2=80=9Cps axwww=E2=80=9D are:

qemu-system-x86_64 -enable-kvm -name ci-busyapps -S -machine pc-1.1,accel=
=3Dkvm,usb=3Doff -m 8192 -realtime mlock=3Doff -smp 2,sockets=3D2,cores=3D1=
,threads=3D1 -uuid 09536d92-dd73-8993-78fb-e0c885acf763 -no-user-config -no=
defaults -chardev socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/ci-b=
usyapps.monitor,server,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=
=3Dcontrol -rtc base=3Dutc -no-shutdown -boot strict=3Don -device piix3-usb=
-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -drive file=3D/dev/vms/ci-busyapp=
s,format=3Draw,if=3Dnone,id=3Ddrive-virtio-disk0,cache=3Dnone,aio=3Dnative =
-device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x4,drive=3Ddrive-virt=
io-disk0,id=3Dvirtio-disk0,bootindex=3D1 -netdev tap,fd=3D24,id=3Dhostnet0,=
vhost=3Don,vhostfd=3D25 -device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,=
mac=3D52:54:00:05:6e:fd,bus=3Dpci.0,addr=3D0x3 -chardev pty,id=3Dcharserial=
0 -device isa-serial,chardev=3Dcharserial0,id=3Dserial0 -device usb-tablet,=
id=3Dinput0 -vnc 127.0.0.1:0 -device cirrus-vga,id=3Dvideo0,bus=3Dpci.0,add=
r=3D0x2 -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x5 -ms=
g timestamp=3Don

I=E2=80=99ve attached the kernel configuration; this is a stock Debian
unstable/amd64 system, just upgraded. After upgrading the guest,
I merely issued a =E2=80=9Creboot=E2=80=9D in the guest and did not stop/st=
art
qemu.

The host is Debian jessie/amd64 (Linux 3.16.0-7-amd64 / 3.16.59-1)
in case that matters.

Thanks,
//mirabilos
--=20
tarent solutions GmbH
Rochusstra=C3=9Fe 2-4, D-53123 Bonn =E2=80=A2 http://www.tarent.de/
Tel: +49 228 54881-393 =E2=80=A2 Fax: +49 228 54881-235
HRB 5168 (AG Bonn) =E2=80=A2 USt-ID (VAT): DE122264941
Gesch=C3=A4ftsf=C3=BChrer: Dr. Stefan Barth, Kai Ebenrett, Boris Esser, Ale=
xander Steeg
