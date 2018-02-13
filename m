Received: from eggs.gnu.org ([2001:4830:134:3::10]:45533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1elZSP-0005BH-CE
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:13:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1elZSL-00064t-Ux
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:13:09 -0500
Received: from mail.ispras.ru ([83.149.199.45]:41274)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1elZSL-000643-Gz
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:13:05 -0500
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
	<001a01d3a4b1$273f1a90$75bd4fb0$@ru>
	<002201d3a4b5$2a642b80$7f2c8280$@ru>
	<CAFEAcA9yO_4FX0J6hsdAmV7TwZd5kp9J-B2EPwm_KZxDO25bGQ@mail.gmail.com>
	<002d01d3a4b8$b73a37e0$25aea7a0$@ru>
	<CAFXrp_dVnWzpDb0p8nGC4eGZ_mWh-pXgozZ7Q0kewRdJE5hM2Q@mail.gmail.com>
In-Reply-To: <CAFXrp_dVnWzpDb0p8nGC4eGZ_mWh-pXgozZ7Q0kewRdJE5hM2Q@mail.gmail.com>
Date: Tue, 13 Feb 2018 15:13:03 +0300
Message-ID: <003701d3a4c3$ffff3650$fffda2f0$@ru>
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
Cc: 'Peter Maydell' <peter.maydell@linaro.org>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, 'QEMU Developers' <qemu-devel@nongnu.org>, 'Kevin Wolf' <kwolf@redhat.com>, war2jordan@live.com, 'Igor R' <boost.lists@gmail.com>, 'Juan Quintela' <quintela@redhat.com>, 'Jason Wang' <jasowang@redhat.com>, "'Michael S. Tsirkin'" <mst@redhat.com>, 'Aleksandr Bezzubikov' <zuban32s@gmail.com>, maria.klimushenkova@ispras.ru, 'Gerd Hoffmann' <kraxel@redhat.com>, 'Thomas Dullien' <thomas.dullien@googlemail.com>, 'Paolo Bonzini' <pbonzini@redhat.com>, =?utf-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>

I=E2=80=99ve tried starting QEMU with your files without SCSI at all.

The problem is with implementation of icount in ARM.

The following command line fails with the same error:=20

=20

./bin/qemu-system-arm -icount 7 -M versatilepb -nographic -dtb =
./images/arm/versatile-pb.dtb -kernel ./images/arm/zImage -net none

=20

And it does not fail when I remove icount.

=20

Pavel Dovgalyuk

=20

From: Ciro Santilli [mailto:ciro.santilli@gmail.com]=20
Sent: Tuesday, February 13, 2018 2:37 PM
To: Pavel Dovgalyuk
Cc: Peter Maydell; Pavel Dovgalyuk; QEMU Developers; Kevin Wolf; =
war2jordan@live.com; Igor R; Juan Quintela; Jason Wang; Michael S. =
Tsirkin; Aleksandr Bezzubikov; maria.klimushenkova@ispras.ru; Gerd =
Hoffmann; Thomas Dullien; Paolo Bonzini; Alex Benn=C3=A9e
Subject: Re: [RFC PATCH v6 00/20] replay additions

=20

=20

=20

On Tue, Feb 13, 2018 at 10:52 AM, Pavel Dovgalyuk <dovgaluk@ispras.ru> =
wrote:

> From: Peter Maydell [mailto:peter.maydell@linaro.org]
> On 13 February 2018 at 10:26, Pavel Dovgalyuk <dovgaluk@ispras.ru> =
wrote:
> > Then I added SCSI adapter with the option =E2=80=93device =
lsi,id=3Dscsi0 and QEMU
> > failed with the following error:
> >
> > qemu: fatal: IO on conditional branch instruction
>
> > Seems, that your kernel is incomatible with QEMU, which ARM =
emulation is not
> > good enough.

=20

Just to clarify, this is my working ARM command that works without =
record / replay:

=20

./buildroot/output.arm~/host/usr/bin/qemu-system-arm -m 128M -monitor =
telnet::45454,server,nowait -netdev =
user,hostfwd=3Dtcp::45455-:45455,id=3Dnet0 -smp 1  -M versatilepb =
-append 'root=3D/dev/sda nokaslr norandmaps printk.devkmsg=3Don =
printk.time=3Dy' -device rtl8139,netdev=3Dnet0 -drive =
file=3D./buildroot/output.arm~/images/rootfs.ext2,if=3Dscsi,format=3Draw =
-dtb ./buildroot/output.arm~/images/versatile-pb.dtb -kernel =
./buildroot/output.arm~/images/zImage -serial stdio

=20

I then tried to modify it for record / replay to use similar options to =
the x86 version. The only non-trivial change was what to use for the =
drive. So I tried to replace them with:

=20

-drive =
file=3D./buildroot/output.arm~/images/rootfs.ext2,if=3Dscsi,id=3Dimg-dire=
ct,format=3Draw \

-drive =
driver=3Dblkreplay,if=3Dnone,image=3Dimg-direct,id=3Dimg-blkreplay \

-device scsi-hd,drive=3Dimg-blkreplay \

=20

and some other variations, but this is just guesswork and likely to be =
wrong, since I don't understand those options very well.

=20

I don't need to use SCSI if that is not supported, I'd be happy with any =
record / replay QEMU command that works with the image I uploaded on the =
.zip.

=20

>
> It seems fairly unlikely to me that the Linux driver for this
> SCSI adaptor is using weirdo self-modifying code of the kind
> that would trip up that cpu_abort(). I would suggest a bit
> more investigation into what's actually happening...

It happens for any SCSI adapter (i.e., for every system able to run).
And the log is not very big. Therefore the problem is in early boot =
code.

Pavel Dovgalyuk

=20
