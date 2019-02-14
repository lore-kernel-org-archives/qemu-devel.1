Received: from eggs.gnu.org ([209.51.188.92]:48862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1guETa-00081r-NZ
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:42:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1guETW-0007EW-HC
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:42:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1guETV-0007AF-Ui
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:42:38 -0500
Date: Thu, 14 Feb 2019 10:42:26 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190214104225.GB2617@work-vm>
References: <RO1P152MB1483190501127990FEBFCE9A97940@RO1P152MB1483.LAMP152.PROD.OUTLOOK.COM>
	<20190128121331.GB2939@work-vm>
	<RO1P152MB1483C38DCFD740BD8982F39597960@RO1P152MB1483.LAMP152.PROD.OUTLOOK.COM>
	<20190128173536.GE2585@work-vm>
	<RO1P152MB14834BE5D9747719CD493C5297960@RO1P152MB1483.LAMP152.PROD.OUTLOOK.COM>
	<20190201133639.GE3150@work-vm>
	<RO1P152MB148380E67D93DAB6C8093EFE97920@RO1P152MB1483.LAMP152.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <RO1P152MB148380E67D93DAB6C8093EFE97920@RO1P152MB1483.LAMP152.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Crash when booting KDE Neon using qxl-vga
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonardo Soares =?iso-8859-1?Q?M=FCller?= <leozinho29_eu@hotmail.com>
Cc: "kraxel@redhat.com" <kraxel@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

* Leonardo Soares M=FCller (leozinho29_eu@hotmail.com) wrote:
> I can confirm this, KDE Neon using the command line similar to yours
> crashes QEMU to me too. I will test with Mageia 7 later to see if it
> behaves differently.
>=20
> But this is a completely different crash. This crash is happening
> earlier, what I reported first is a crash when the login screen should
> load, this is happening earlier on boot.
>=20
> The command line I used this time:
>=20
> qemu-system-x86_64 -M pc,accel=3Dkvm -smp 3 -m 4G -drive
> if=3Dvirtio,file=3Dneonbroken.qcow2 -vga qxl -bios /usr/share/ovmf/OVMF=
.fd

Yes, this was: https://bugs.launchpad.net/qemu/+bug/1813940

Dave

> The backtrace:
>=20
> (gdb) bt
> #0  0x00007ffff0371e97 in __GI_raise (sig=3Dsig@entry=3D6) at
> ../sysdeps/unix/sysv/linux/raise.c:51
> #1  0x00007ffff0373801 in __GI_abort () at abort.c:79
> #2  0x000055555589eac9 in kvm_mem_ioeventfd_add
> (listener=3D0x555556a1fdc8, section=3D0x7fffc7ffba90, match_data=3Dfals=
e,
> data=3D0, e=3D0x5555578c7fc8) at
> /home/usuario/Documentos/qemu/accel/kvm/kvm-all.c:866
> #3  0x000055555588300a in address_space_add_del_ioeventfds
> (as=3D0x5555567e5a00 <address_space_memory>, fds_new=3D0x7fffbc000d30,
> fds_new_nb=3D1, fds_old=3D0x0, fds_old_nb=3D0) at
> /home/usuario/Documentos/qemu/memory.c:793
> #4  0x00005555558832f4 in address_space_update_ioeventfds
> (as=3D0x5555567e5a00 <address_space_memory>) at
> /home/usuario/Documentos/qemu/memory.c:843
> #5  0x000055555588415b in memory_region_transaction_commit () at
> /home/usuario/Documentos/qemu/memory.c:1094
> #6  0x00005555558871c8 in memory_region_add_eventfd (mr=3D0x5555578b642=
0,
> addr=3D0, size=3D0, match_data=3Dfalse, data=3D0, e=3D0x5555578c7fc8) a=
t
> /home/usuario/Documentos/qemu/memory.c:2303
> #7  0x0000555555c26cd0 in virtio_pci_ioeventfd_assign (d=3D0x5555578b57=
50,
> notifier=3D0x5555578c7fc8, n=3D0, assign=3Dtrue) at hw/virtio/virtio-pc=
i.c:243
> #8  0x0000555555c24dd5 in virtio_bus_set_host_notifier
> (bus=3D0x5555578bd848, n=3D0, assign=3Dtrue) at hw/virtio/virtio-bus.c:=
283
> #9  0x00005555558ce648 in virtio_blk_data_plane_start
> (vdev=3D0x5555578bd8c0) at
> /home/usuario/Documentos/qemu/hw/block/dataplane/virtio-blk.c:200
> #10 0x0000555555c24af2 in virtio_bus_start_ioeventfd
> (bus=3D0x5555578bd848) at hw/virtio/virtio-bus.c:223
> #11 0x0000555555c26e57 in virtio_pci_start_ioeventfd
> (proxy=3D0x5555578b5750) at hw/virtio/virtio-pci.c:282
> #12 0x0000555555c29285 in virtio_pci_common_write
> (opaque=3D0x5555578b5750, addr=3D20, val=3D15, size=3D1) at
> hw/virtio/virtio-pci.c:1233
> #13 0x0000555555881ebd in memory_region_write_accessor
> (mr=3D0x5555578b6120, addr=3D20, value=3D0x7fffc7ffbf38, size=3D1, shif=
t=3D0,
> mask=3D255, attrs=3D...) at /home/usuario/Documentos/qemu/memory.c:502
> #14 0x00005555558820cd in access_with_adjusted_size (addr=3D20,
> value=3D0x7fffc7ffbf38, size=3D1, access_size_min=3D1, access_size_max=3D=
4,
> access_fn=3D0x555555881dd4 <memory_region_write_accessor>,
> mr=3D0x5555578b6120, attrs=3D...) at /home/usuario/Documentos/qemu/memo=
ry.c:568
> #15 0x0000555555885100 in memory_region_dispatch_write
> (mr=3D0x5555578b6120, addr=3D20, data=3D15, size=3D1, attrs=3D...) at
> /home/usuario/Documentos/qemu/memory.c:1499
> #16 0x000055555581bca9 in flatview_write_continue (fv=3D0x7fffcc50f4f0,
> addr=3D34359738388, attrs=3D..., buf=3D0x7ffff7fee028 "\017", len=3D1, =
addr1=3D20,
> l=3D1, mr=3D0x5555578b6120) at /home/usuario/Documentos/qemu/exec.c:323=
4
> #17 0x000055555581bdf3 in flatview_write (fv=3D0x7fffcc50f4f0,
> addr=3D34359738388, attrs=3D..., buf=3D0x7ffff7fee028 "\017", len=3D1) =
at
> /home/usuario/Documentos/qemu/exec.c:3273
> #18 0x000055555581c0f9 in address_space_write (as=3D0x5555567e5a00
> <address_space_memory>, addr=3D34359738388, attrs=3D..., buf=3D0x7ffff7=
fee028
> "\017", len=3D1) at /home/usuario/Documentos/qemu/exec.c:3363
> #19 0x000055555581c14a in address_space_rw (as=3D0x5555567e5a00
> <address_space_memory>, addr=3D34359738388, attrs=3D..., buf=3D0x7ffff7=
fee028
> "\017", len=3D1, is_write=3Dtrue) at /home/usuario/Documentos/qemu/exec=
.c:3374
> #20 0x00005555558a146f in kvm_cpu_exec (cpu=3D0x555556afe140) at
> /home/usuario/Documentos/qemu/accel/kvm/kvm-all.c:2031
> #21 0x0000555555865a3e in qemu_kvm_cpu_thread_fn (arg=3D0x555556afe140)=
 at
> /home/usuario/Documentos/qemu/cpus.c:1281
> #22 0x0000555555e1ba02 in qemu_thread_start (args=3D0x555556b20440) at
> util/qemu-thread-posix.c:502
> #23 0x00007ffff072b6db in start_thread (arg=3D0x7fffc7fff700) at
> pthread_create.c:463
> #24 0x00007ffff045488f in clone () at
> ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
>=20
>=20
> =C0s 11:36 de 01/02/2019, Dr. David Alan Gilbert escreveu:
> >=20
> > Hmm, I'm also getting a crash, but I think it's very different from
> > yours:
> >=20
> > ./x86_64-softmmu/qemu-system-x86_64 -M pc,accel=3Dkvm -smp 3 -m 8G -c=
drom /home/vmimages/neon-useredition-current.iso -drive if=3Dvirtio,file=3D=
/home/vmimages/kde-neon.qcow2 -vga qxl
> >=20
> > kvm_mem_ioeventfd_add: error adding ioeventfd: No space left on devic=
e
> > Aborted (core dumped)
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
