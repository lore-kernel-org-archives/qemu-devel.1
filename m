Received: from eggs.gnu.org ([2001:4830:134:3::10]:45557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <constantin.petra@gmail.com>) id 1d0j3k-0003Yg-MC
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 02:25:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <constantin.petra@gmail.com>) id 1d0j3i-0003ge-WA
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 02:25:48 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:35270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <constantin.petra@gmail.com>)
	id 1d0j3i-0003fm-M8
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 02:25:46 -0400
Received: by mail-wr0-x22f.google.com with SMTP id o21so8242775wrb.2
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 23:25:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <363c3493-f7f4-25de-d679-3726651706c1@web.de>
References: <1856afd9-6c92-4309-8e92-8da478864752@googlegroups.com>
	<2ab0912c-9581-7656-5a21-d7a261e62a90@siemens.com>
	<CAOT14F66-BXb4KvgvSuebFLoPL=kZPoqAZ5dqhx+ftn7886m4A@mail.gmail.com>
	<b5af41e1-d6cf-48ae-b758-a957bdb60391@googlegroups.com>
	<cf570bb4-7b1b-9788-7e89-faff52ad4502@siemens.com>
	<498d9e2d-e025-4aa1-9a47-76a9c94d8a5f@googlegroups.com>
	<5acf6dd8-4ec5-0c57-9645-3615beb755af@siemens.com>
	<CAOT14F6f2rHB4Adqo1p-VDgn4dMPUbyuRo8XPa9s7Yin_xK8rQ@mail.gmail.com>
	<29858b5d-edb6-bc5e-73df-84e8adfd2a61@web.de>
	<7d43790d-b6ac-c997-69c3-8d0249c7b7be@web.de>
	<4126cc24-3237-49fd-b28a-7d5583e1b2d4@googlegroups.com>
	<1d51b078-d8e4-bea2-064b-2d7a8e41e9eb@web.de>
	<CAOT14F6XqnYaKmNry-SN3uXzmm0Sv8RUM48074=t2d2Qmi+bkA@mail.gmail.com>
	<CAOT14F77f3tdWDHMyVj1itUiyRPwp2GYgJwKuHF+WM1a-grbjQ@mail.gmail.com>
	<363c3493-f7f4-25de-d679-3726651706c1@web.de>
From: Constantin Petra <constantin.petra@gmail.com>
Date: Wed, 19 Apr 2017 09:25:44 +0300
Message-ID: <CAOT14F69gS9Ss5ewkjdhk6qSHC3cr7qOHXVRg6Gn=qKJ1Q6Wkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Jailhouse on Ultrascale+ (ZCU102)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jailhouse <jailhouse-dev@googlegroups.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, qemu-devel <qemu-devel@nongnu.org>

Yes, I am using the QEMU version included by Xilinx in PetaLinux 2016.4.

On Wed, Apr 19, 2017 at 7:37 AM, Jan Kiszka <jan.kiszka@web.de> wrote:

> On 2017-04-19 05:48, Constantin Petra wrote:
> > Hello,
> >
> > I have tried the same binaries on a ZCU102 board and it seems to work.
> > Cannot be sure though, the board is remote and I don't have access to
> > the secondary UART as I understand it would be required for the
> uart-demo.
>
> You can always reconfigure this to the primary one. We share it in other
> setups as well.
>
> > So from some reason, under QEMU something is not in place, but what can
> > that be? It would be convenient from our perspective, if it would work...
>
> I fully agree, and I'm waiting for official EL2 support in QEMU in order
> to introduce a virtual target for ARM[64], just like we have on x86
> already.
>
> I suppose you are using Xilinx' version of QEMU, not upstream, correct?
> I didn't track recently what the state of upstream is. Just checking the
> list again, seeing some interesting patches from early this year...
> Peter, can you comment on what is still missing? I'm reading that you
> successfully booted KVM inside QEMU. Seems like we are pretty close now
> and it could make sense to debug the remaining issues.
>
> Jan
>
> >
> > root@plnx_aarch64:~# jailhouse/usr/local/sbin/jailhouse cell list
> > ID      Name                    State           Assigned CPUs
> > Failed CPUs
> > 0       ZynqMP-ZCU102           running         0-2
> > 1       gic-demo                running         3
> >
> >
> > Best Regards,
> > Constantin
> >
> > On Tue, Apr 18, 2017 at 1:32 PM, Constantin Petra
> > <constantin.petra@gmail.com <mailto:constantin.petra@gmail.com>> wrote:
> >
> >     Hi,
> >
> >     Yes, that's correct, I'm trying to run the whole stack in QEMU, not
> >     hardware.
> >
> >     Best Regards,
> >     Constantin
> >
> >     On Tue, Apr 18, 2017 at 12:52 PM, Jan Kiszka <jan.kiszka@web.de
> >     <mailto:jan.kiszka@web.de>> wrote:
> >
> >         On 2017-04-18 10:22, constantin.petra@gmail.com
> >         <mailto:constantin.petra@gmail.com> wrote:
> >         > Hi,
> >         >
> >         > I have made the changes to pci.c, but QEMU seems to freeze
> after enabling Jailhouse after the "opening" message is displayed (I have
> previously started a SSH connection which also freezes - to make sure the
> Serial port is not somehow hijacked by hypervisor as described in the
> documentaiton). I cannot start GDB using petalinux tools due to a Python
> 2.6 dependency (the system has Python 2.7) so I don't really know what
> happens. Any ideas? (Attached also a log file with the boot messages; tried
> relying on configured dtb and here also tried memmap for the reserved
> memory, with the same result).
> >         >
> >
> >         Oh, now I get it: You are running the whole stack emulated in
> >         QEMU, not
> >         on real hardware, right? Maybe there is a subtle difference in
> >         the QEMU
> >         system configuration compared to the board, or Jailhouse is
> >         stressing
> >         some aspect of virtualization that the QEMU model does not yet
> >         handle
> >         correctly or at all.
> >
> >         Adding Edgar, maybe he can comment on the state of hypervisor
> >         execution
> >         in the Xilinx QEMU version. He will probably need some details
> >         about the
> >         setup (versions, configuration etc.).
> >
> >         Jan
> >
> >         > root@plnx_aarch64:~# jailhouse/usr/local/sbin/jailhouse enable
> >         /home/root/jailhouse/configs/zynqmp-zcu102.cell
> >         >
> >         > Initializing Jailhouse hypervisor v0.6 (47-ge02403c-dirty) on
> >         CPU 0
> >         > Code location: 0x0000ffffc0200040
> >         > Page pool usage after early setup: mem 33/996, remap 64/131072
> >         > Initializing processors:
> >         >  CPU 0... OK
> >         >  CPU 1... OK
> >         >  CPU 2... OK
> >         >  CPU 3... OK
> >         > Adding virtual PCI device 00:00.0 to cell "ZynqMP-ZCU102"
> >         > Adding virtual PCI device 00:01.0 to cell "ZynqMP-ZCU102"
> >         > Page pool usage after late setup: mem 44/996, remap 69/131072
> >         > Activating hypervisor
> >         > [   71.547900] OF: PCI: host bridge //vpci@0 ranges:
> >         > [   71.549101] OF: PCI:   MEM 0xfc100000..0xfc103fff ->
> 0xfc100000
> >         > [   71.552493] pci-host-generic fc000000.vpci: ECAM at [mem
> >         0xfc000000-0xfc0fffff] for [bus 00]
> >         > [   71.555644] pci-host-generic fc000000.vpci: PCI host bridge
> >         to bus 0001:00
> >         > [   71.556337] pci_bus 0001:00: root bus resource [bus 00]
> >         > [   71.556698] pci_bus 0001:00: root bus resource [mem
> >         0xfc100000-0xfc103fff]
> >         > [   71.569008] pci 0001:00:00.0: BAR 0: assigned [mem
> >         0xfc100000-0xfc1000ff 64bit]
> >         > [   71.570284] pci 0001:00:01.0: BAR 0: assigned [mem
> >         0xfc100100-0xfc1001ff 64bit]
> >         > [   71.576654] The Jailhouse is opening.
> >         > root@plnx_aarch64:~#
> >         >
> >         > Best Regards,
> >         > Constantin
> >         >
> >
> >
> >
>
>
