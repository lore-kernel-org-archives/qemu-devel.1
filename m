Received: from eggs.gnu.org ([2001:4830:134:3::10]:42262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ciro.santilli@gmail.com>) id 1eoHpM-0006kS-9Y
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 19:00:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ciro.santilli@gmail.com>) id 1eoHpL-0001nt-5I
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 19:00:04 -0500
Received: from mail-it0-x22a.google.com ([2607:f8b0:4001:c0b::22a]:39320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ciro.santilli@gmail.com>)
	id 1eoHpK-0001mn-Vm
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 19:00:03 -0500
Received: by mail-it0-x22a.google.com with SMTP id l187so232636ith.4
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 16:00:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <001801d3aa2f$ac7b4160$0571c420$@ru>
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
	<000d01d3a590$caa17950$5fe46bf0$@ru>
	<001201d3a957$f85ed610$e91c8230$@ru>
	<CAFXrp_cR16EOwZp-FauZuZcwuWwB53gxSO57ggy5qud-vyzimA@mail.gmail.com>
	<001801d3aa2f$ac7b4160$0571c420$@ru>
From: Ciro Santilli <ciro.santilli@gmail.com>
Date: Tue, 20 Feb 2018 23:59:39 +0000
Message-ID: <CAFXrp_d7WDGcZ99pnfpxggYgqzHJDLRxnjNcGH1SLgbyq2Y7yQ@mail.gmail.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, richard.henderson@linaro.org, "Emilio G. Cota" <cota@braap.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, war2jordan@live.com, Igor R <boost.lists@gmail.com>, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aleksandr Bezzubikov <zuban32s@gmail.com>, maria.klimushenkova@ispras.ru, Gerd Hoffmann <kraxel@redhat.com>, Thomas Dullien <thomas.dullien@googlemail.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Tue, Feb 20, 2018 at 9:46 AM, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote=
:
>> From: Ciro Santilli [mailto:ciro.santilli@gmail.com]
>> On Mon, Feb 19, 2018 at 8:02 AM, Pavel Dovgalyuk <dovgaluk@ispras.ru> wr=
ote:
>> >> From: Pavel Dovgalyuk [mailto:dovgaluk@ispras.ru]
>> >> > From: Peter Maydell [mailto:peter.maydell@linaro.org]
>> >> > On 13 February 2018 at 10:26, Pavel Dovgalyuk <dovgaluk@ispras.ru> =
wrote:
>> >> > > Then I added SCSI adapter with the option =E2=80=93device lsi,id=
=3Dscsi0 and QEMU
>> >> > > failed with the following error:
>> >> > >
>> >> > > qemu: fatal: IO on conditional branch instruction
>> >> >
>> >> > > Seems, that your kernel is incomatible with QEMU, which ARM emula=
tion is not
>> >> > > good enough.
>> >> >
>> >> > It seems fairly unlikely to me that the Linux driver for this
>> >> > SCSI adaptor is using weirdo self-modifying code of the kind
>> >> > that would trip up that cpu_abort(). I would suggest a bit
>> >> > more investigation into what's actually happening...
>> >>
>> >> Peter, I bisected this bug and figured out the following.
>> >>
>> >> icount in ARM was broken by the following commit: 9b990ee5a3cc6aa38f8=
1266fb0c6ef37a36c45b9
>> >> tcg: Add CPUState cflags_next_tb
>> >> This commit breaks execution of Ciro's kernel with enabled icount.
>> >> I haven't yet figured out why this happens.
>> >
>> > The problem is in the following code.
>> > As far, as I can understand, original version recompiles the TB and
>> > continues the execution as it goes.
>> >
>> > But the modified version sets cflags for the next compilation.
>> > And these are the flags for the old TB which should replace the origin=
al one.
>> > TCG tries to use cflags for the new TB (which starts after the interru=
pted one)
>> > and fails, because these flags are inappropriate.
>> > That is why icount execution fails.
>> >
>> > New version also does not include recompilation of the old block, whic=
h is wrong too.
>> >
>>
>> Awesome! Can you push it to a branch, and give the full qemu command
>> line so I can test it?
>
> Updated the branch on github.
> You may try it.
>

Thanks,

At 8a482834780a131e7747c1c3c1931379ed0beedc ARM initrd record runs,
but replay is getting stuck at:

[   12.120424] scsi host0: sym-2.2.3

Neighboring lines on record:

[   11.346357] sym53c8xx 0000:00:0c.0: enabling device (0100 -> 0103)
[   11.536683] sym0: <895a> rev 0x0 at pci 0000:00:0c.0 irq 66
[   11.731679] sym0: No NVRAM, ID 7, Fast-40, LVD, parity checking
[   11.930599] sym0: SCSI BUS has been reset.
[   12.120424] scsi host0: sym-2.2.3
[   15.451809] scsi 0:0:2:0: CD-ROM            QEMU     QEMU CD-ROM
  2.5+ PQ: 0 ANSI: 5
[   15.847227] scsi target0:0:2: tagged command queuing enabled,
command queue depth 16.
[   16.256585] scsi target0:0:2: Beginning Domain Validation
[   16.482189] scsi target0:0:2: Domain Validation skipping write tests
[   16.699445] scsi target0:0:2: Ending Domain Validation

My QEMU command:

time ./buildroot/output.arm~/host/usr/bin/qemu-system-arm -M
versatilepb -append 'root=3D/dev/sda nokaslr norandmaps
printk.devkmsg=3Don printk.time=3Dy - lkmc_eval=3D"/rand_check.out;wget -S
google.com;/poweroff.out;"'
 -kernel ./buildroot/output.arm~/images/zImage -dtb
./buildroot/output.arm~/images/versatile-pb.dtb -nographic -initrd
./buildroot/output.arm~/images/rootfs.cpio -netdev user,id=3Dnet1
-device rtl8139,netdev=3Dnet1
-object filter-replay,id=3Dreplay,netdev=3Dnet1

What is your full QEMU command?

Also I think the patch to fix qmeu-img was not included in the branch.

> Pavel Dovgalyuk
>
