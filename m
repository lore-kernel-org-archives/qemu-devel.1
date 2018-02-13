Received: from eggs.gnu.org ([2001:4830:134:3::10]:57466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1elXLt-0006HN-5l
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 04:58:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1elXLo-0007H3-Kd
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 04:58:17 -0500
Received: from mail.ispras.ru ([83.149.199.45]:54320)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1elXLo-0007E2-3O
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 04:58:12 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180207120353.5389.54531.stgit@pasha-VirtualBox>
	<CAFXrp_fenK2mzLSOUUcWLTR1r4_jUEN07QDqfkRDpTFEo4oHpQ@mail.gmail.com>
	<002401d3a010$8d551280$a7ff3780$@ru>
	<CAFXrp_c09S6e9EnT7LOYox2YMiOXN_suFo30wfqcmzwRB8zx2A@mail.gmail.com>
	<CAFXrp_dUAZDYLUTqY0nxbGg7w4TEqD2+rNRPT+47a0B8N1Y6Aw@mail.gmail.com>
	<001b01d3a3c5$032e09f0$098a1dd0$@ru>
	<CAFXrp_dNj+BSYo+0rpv5d4PxdjJ1RL_cROaDWRvjQTLziFtO_Q@mail.gmail.com>
	<000c01d3a496$fd2bc470$f7834d50$@ru>
	<CAFXrp_cEsHH_6VQevxsrj8GTchraGKEJ_t0xhSbfajcBu-mmzg@mail.gmail.com>
In-Reply-To: <CAFXrp_cEsHH_6VQevxsrj8GTchraGKEJ_t0xhSbfajcBu-mmzg@mail.gmail.com>
Date: Tue, 13 Feb 2018 12:58:08 +0300
Message-ID: <001a01d3a4b1$273f1a90$75bd4fb0$@ru>
MIME-Version: 1.0
Content-Language: ru
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v6 00/20] replay additions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Ciro Santilli' <ciro.santilli@gmail.com>
Cc: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, kwolf@redhat.com, 'Peter Maydell' <peter.maydell@linaro.org>, war2jordan@live.com, 'Igor R' <boost.lists@gmail.com>, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, 'Aleksandr Bezzubikov' <zuban32s@gmail.com>, maria.klimushenkova@ispras.ru, kraxel@redhat.com, 'Thomas Dullien' <thomas.dullien@googlemail.com>, pbonzini@redhat.com, =?utf-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>

There is the same file I downloaded this morning.=20

Now I re-checked everything and it prints the following error: =
qemu-system-arm: -device scsi-hd,drive=3Dimg-blkreplay: No 'SCSI' bus =
found for device 'scsi-hd'

=20

Pavel Dovgalyuk

=20

From: Ciro Santilli [mailto:ciro.santilli@gmail.com]=20
Sent: Tuesday, February 13, 2018 12:07 PM
To: Pavel Dovgalyuk
Cc: Pavel Dovgalyuk; qemu-devel@nongnu.org; kwolf@redhat.com; Peter =
Maydell; war2jordan@live.com; Igor R; quintela@redhat.com; =
jasowang@redhat.com; mst@redhat.com; Aleksandr Bezzubikov; =
maria.klimushenkova@ispras.ru; kraxel@redhat.com; Thomas Dullien; =
pbonzini@redhat.com; Alex Benn=C3=A9e
Subject: Re: [RFC PATCH v6 00/20] replay additions

=20

=20

=20

On Tue, Feb 13, 2018 at 6:50 AM, Pavel Dovgalyuk <dovgaluk@ispras.ru> =
wrote:

Your command line looks wrong, because you forgot =E2=80=93icount, but =
specified other replay options

=20

Sorry about that, my full command is exactly the previous but with =
-icount 'shift=3D7,rr=3Drecord,rrfile=3Dreplay.bin' added to the end.

=20

.

I tried recording and replaying with your command line and the execution =
hangs at some moment of replay.

The problem may be hidden in =E2=80=93dtb option, because it may add the =
devices without configuring replay for them.

Can you specify the whole hardware configuration in the command line?

=20

Ah, now that you mentioned this, I had a modification on the DTB which =
needed to be reverted. I have re-uploaded it to the same address: =
https://github.com/cirosantilli/linux-kernel-module-cheat/releases/downlo=
ad/test-replay-arm/images.zip please use the new one instead.

=20

Now it should be just the vanilla Linux kernel versatilepb one.

=20

How to specify the --dtb configuration explicitly on the command line? I =
have also included the dts on the zip if that helps.

=20

=20

Pavel Dovgalyuk

=20

From: Ciro Santilli [mailto:ciro.santilli@gmail.com]=20
Sent: Tuesday, February 13, 2018 8:58 AM
To: Pavel Dovgalyuk
Cc: Pavel Dovgalyuk; qemu-devel@nongnu.org; kwolf@redhat.com; Peter =
Maydell; war2jordan@live.com; Igor R; quintela@redhat.com; =
jasowang@redhat.com; mst@redhat.com; Aleksandr Bezzubikov; =
maria.klimushenkova@ispras.ru; kraxel@redhat.com; Thomas Dullien; =
pbonzini@redhat.com; Alex Benn=C3=A9e
Subject: Re: [RFC PATCH v6 00/20] replay additions

=20

=20

=20

On Mon, Feb 12, 2018 at 5:47 AM, Pavel Dovgalyuk <dovgaluk@ispras.ru> =
wrote:

I tested ARM only with =E2=80=93kernel and =E2=80=93initrd.

Can you provide the full command line and the disk image?

=20

=20

The command I tried was:

=20

time ./buildroot/output.arm~/host/usr/bin/qemu-system-arm -M versatilepb =
-append 'root=3D/dev/sda nokaslr norandmaps printk.devkmsg=3Don =
printk.time=3Dy - lkmc_eval=3D"/rand_check.out;wget -S =
google.com;/poweroff.out;"' -kernel =
./buildroot/output.arm~/images/zImage -dtb =
./buildroot/output.arm~/images/versatile-pb.dtb -nographic -drive =
file=3D./buildroot/output.arm~/images/rootfs.ext2,if=3Dscsi,id=3Dimg-dire=
ct,format=3Draw -drive =
driver=3Dblkreplay,if=3Dnone,image=3Dimg-direct,id=3Dimg-blkreplay =
-device scsi-hd,drive=3Dimg-blkreplay -netdev user,id=3Dnet1 -device =
rtl8139,netdev=3Dnet1 -object filter-replay,id=3Dreplay,netdev=3Dnet1=20

=20

and the required files can be downloaded from:

=20

https://github.com/cirosantilli/linux-kernel-module-cheat/releases/downlo=
ad/test-replay-arm/images.zip

=20

They were generated with:

=20

./build -a arm

=20

on that repo.

=20

=20

Pavel Dovgalyuk

=20

From: Ciro Santilli [mailto:ciro.santilli@gmail.com]=20
Sent: Saturday, February 10, 2018 3:09 AM
To: Pavel Dovgalyuk
Cc: Pavel Dovgalyuk; qemu-devel@nongnu.org; kwolf@redhat.com; Peter =
Maydell; war2jordan@live.com; Igor R; quintela@redhat.com; =
jasowang@redhat.com; mst@redhat.com; Aleksandr Bezzubikov; =
maria.klimushenkova@ispras.ru; kraxel@redhat.com; Thomas Dullien; =
pbonzini@redhat.com; Alex Benn=C3=A9e
Subject: Re: [RFC PATCH v6 00/20] replay additions

=20

Also, what command do you use to test on ARM? I'm a bit stuck to get the =
drive part right, e.g.:

=20

-drive =
file=3D./buildroot/output.arm~/images/rootfs.ext2,if=3Dscsi,id=3Dimg-dire=
ct,format=3Draw \

-drive =
driver=3Dblkreplay,if=3Dnone,image=3Dimg-direct,id=3Dimg-blkreplay \

-device scsi-hd,drive=3Dimg-blkreplay \

=20

fails with: qemu-system-arm: -device scsi-hd,drive=3Dimg-blkreplay: =
Conflicts with use by img-direct as 'root', which does not allow 'write' =
on #block968

=20

=20

=20
