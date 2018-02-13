Received: from eggs.gnu.org ([2001:4830:134:3::10]:56428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ciro.santilli@gmail.com>) id 1elYu4-00083e-Cf
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 06:37:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ciro.santilli@gmail.com>) id 1elYu3-00076U-5b
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 06:37:40 -0500
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:46494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ciro.santilli@gmail.com>)
	id 1elYu2-000769-VT
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 06:37:39 -0500
Received: by mail-io0-x241.google.com with SMTP id k80so9546708ioe.13
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 03:37:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <002d01d3a4b8$b73a37e0$25aea7a0$@ru>
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
From: Ciro Santilli <ciro.santilli@gmail.com>
Date: Tue, 13 Feb 2018 11:37:17 +0000
Message-ID: <CAFXrp_dVnWzpDb0p8nGC4eGZ_mWh-pXgozZ7Q0kewRdJE5hM2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: Peter Maydell <peter.maydell@linaro.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, war2jordan@live.com, Igor R <boost.lists@gmail.com>, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aleksandr Bezzubikov <zuban32s@gmail.com>, maria.klimushenkova@ispras.ru, Gerd Hoffmann <kraxel@redhat.com>, Thomas Dullien <thomas.dullien@googlemail.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Tue, Feb 13, 2018 at 10:52 AM, Pavel Dovgalyuk <dovgaluk@ispras.ru>
wrote:

> > From: Peter Maydell [mailto:peter.maydell@linaro.org]
> > On 13 February 2018 at 10:26, Pavel Dovgalyuk <dovgaluk@ispras.ru>
> wrote:
> > > Then I added SCSI adapter with the option =E2=80=93device lsi,id=3Dsc=
si0 and QEMU
> > > failed with the following error:
> > >
> > > qemu: fatal: IO on conditional branch instruction
> >
> > > Seems, that your kernel is incomatible with QEMU, which ARM emulation
> is not
> > > good enough.
>

Just to clarify, this is my working ARM command that works without record /
replay:

./buildroot/output.arm~/host/usr/bin/qemu-system-arm -m 128M -monitor
telnet::45454,server,nowait -netdev user,hostfwd=3Dtcp::45455-:45455,id=3Dn=
et0
-smp 1  -M versatilepb -append 'root=3D/dev/sda nokaslr norandmaps
printk.devkmsg=3Don printk.time=3Dy' -device rtl8139,netdev=3Dnet0 -drive
file=3D./buildroot/output.arm~/images/rootfs.ext2,if=3Dscsi,format=3Draw -d=
tb
./buildroot/output.arm~/images/versatile-pb.dtb -kernel
./buildroot/output.arm~/images/zImage -serial stdio

I then tried to modify it for record / replay to use similar options to the
x86 version. The only non-trivial change was what to use for the drive. So
I tried to replace them with:

-drive file=3D./buildroot/output.arm~/images/rootfs.ext2,if=3Dscsi,id=3Dimg=
-direct,format=3Draw
\
-drive driver=3Dblkreplay,if=3Dnone,image=3Dimg-direct,id=3Dimg-blkreplay \
-device scsi-hd,drive=3Dimg-blkreplay \

and some other variations, but this is just guesswork and likely to be
wrong, since I don't understand those options very well.

I don't need to use SCSI if that is not supported, I'd be happy with any
record / replay QEMU command that works with the image I uploaded on the
.zip.


> >
> > It seems fairly unlikely to me that the Linux driver for this
> > SCSI adaptor is using weirdo self-modifying code of the kind
> > that would trip up that cpu_abort(). I would suggest a bit
> > more investigation into what's actually happening...
>
> It happens for any SCSI adapter (i.e., for every system able to run).
> And the log is not very big. Therefore the problem is in early boot code.
>
> Pavel Dovgalyuk
>
>
