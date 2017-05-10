Received: from eggs.gnu.org ([2001:4830:134:3::10]:59890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <constantin.petra@gmail.com>) id 1d8PXl-0002QT-4i
	for qemu-devel@nongnu.org; Wed, 10 May 2017 07:12:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <constantin.petra@gmail.com>) id 1d8PXj-0004VL-NS
	for qemu-devel@nongnu.org; Wed, 10 May 2017 07:12:33 -0400
Received: from mail-pg0-x238.google.com ([2607:f8b0:400e:c05::238]:34432)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <constantin.petra@gmail.com>)
	id 1d8PXj-0004VD-F8
	for qemu-devel@nongnu.org; Wed, 10 May 2017 07:12:31 -0400
Received: by mail-pg0-x238.google.com with SMTP id h64so2487252pge.1
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 04:12:31 -0700 (PDT)
Date: Wed, 10 May 2017 04:12:29 -0700 (PDT)
From: Constantin Petra <constantin.petra@gmail.com>
Message-Id: <5170722c-f118-4bf8-ac64-380032854ced@googlegroups.com>
In-Reply-To: <20170421192258.GA18999@toto>
References: <4126cc24-3237-49fd-b28a-7d5583e1b2d4@googlegroups.com>
	<1d51b078-d8e4-bea2-064b-2d7a8e41e9eb@web.de>
	<CAOT14F6XqnYaKmNry-SN3uXzmm0Sv8RUM48074=t2d2Qmi+bkA@mail.gmail.com>
	<CAOT14F77f3tdWDHMyVj1itUiyRPwp2GYgJwKuHF+WM1a-grbjQ@mail.gmail.com>
	<363c3493-f7f4-25de-d679-3726651706c1@web.de>
	<CAFEAcA9p0OuKt9yKsmB9qDnqR-EuVR8qzS9oENAW=MGkVE4CcA@mail.gmail.com>
	<4c587382-b690-5011-6571-9361c30b2384@web.de>
	<20170419203005.GG19639@toto>
	<CAOT14F776jM5frvEazwmtwUXKWDednp+CT9DRP2NbKOGZ2H1_A@mail.gmail.com>
	<CAOT14F7Bj5+s5EyceAUchNofLXY34ZwvfaosdUQt+NcSpip1PA@mail.gmail.com>
	<20170421192258.GA18999@toto>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Jailhouse on Ultrascale+ (ZCU102)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jailhouse <jailhouse-dev@googlegroups.com>
Cc: constantin.petra@gmail.com, qemu-devel@nongnu.org, peter.maydell@linaro.org, jan.kiszka@web.de, edgar.iglesias@xilinx.com

Hi,

Any findings on this case? Is there any chance PetaLinux 2017.1 addressed this issue?

Thank you,
Constantin


On Friday, April 21, 2017 at 10:23:07 PM UTC+3, Edgar E. Iglesias wrote:
> On Fri, Apr 21, 2017 at 10:04:56AM +0300, Constantin Petra wrote:
> > OK,
> > 
> > Changed configs for inmate to UART0, and the messages appeared on the
> > console (on the ZCU102 board, not QEMU), so it is indeed functional.
> > root@plnx_aarch64:~# jailhouse/usr/local/sbin/jailhouse cell start
> > ZynqMP-linux-demo
> > Started cell "ZynqMP-linux-demo"
> > Hello 1 from cell!
> > Hello 2 from cell!
> > Hello 3 from cell!
> > ---
> > etc
> > 
> > Edgar, are the images I have sent of any help?
> 
> Thanks Constantin, yes, I can reproduce a lockup.
> This is what I see:
> root@plnx_aarch64:~# jailhouse/usr/local/sbin/jailhouse enable /home/root/jailhouse/configs/zynqmp-zcu102.cell
> 
> Initializing Jailhouse hypervisor v0.6 (47-ge02403c-dirty) on CPU 2
> Code location: 0x0000ffffc0200040
> Page pool usage after early setup: mem 33/996, remap 64/131072
> Initializing processors:
>  CPU 2... OK
>  CPU 3... OK
>  CPU 0... OK
>  CPU 1... OK
> Adding virtual PCI device 00:00.0 to cell "ZynqMP-ZCU102"
> Adding virtual PCI device 00:01.0 to cell "ZynqMP-ZCU102"
> Page pool usage after late setup: mem 44/996, remap 69/131072
> Activating hypervisor
> [   73.743265] OF: PCI: host bridge //vpci@0 ranges:
> [   73.744161] OF: PCI:   MEM 0xfc100000..0xfc103fff -> 0xfc100000
> [   73.747033] pci-host-generic fc000000.vpci: ECAM at [mem 0xfc000000-0xfc0fffff] for [bus 00]
> [   73.748659] pci-host-generic fc000000.vpci: PCI host bridge to bus 0001:00
> [   73.748972] pci_bus 0001:00: root bus resource [bus 00]
> [   73.749644] pci_bus 0001:00: root bus resource [mem 0xfc100000-0xfc103fff]
> [   73.758116] pci 0001:00:00.0: BAR 0: assigned [mem 0xfc100000-0xfc1000ff 64bit]
> [   73.758928] pci 0001:00:01.0: BAR 0: assigned [mem 0xfc100100-0xfc1001ff 64bit]
> [   73.761465] The Jailhouse is opening.
> root@plnx_aarch64:~# [   74.710264] ivshmem-net 0001:00:00.0: enabling device (0000 -> 0002)
> [   74.713514] ivshmem-net: probe of 0001:00:00.0 failed with error -16
> [   74.714971] ivshmem-net 0001:00:01.0: enabling device (0000 -> 0002)
> [   74.715904] ivshmem-net: probe of 0001:00:01.0 failed with error -16
> 
> 
> After that, it all deadlocks.
> I'll see what I can find.
> 
> Cheers,
> Edgar
> 
> > Let me know if you need any other information about the setup.
> > 
> > Best Regards,
> > Constantin
> > P.S. Sent the above previously by chance only to Edgar, reposted again for
> > the larger audience :)
> > 
> > On Thu, Apr 20, 2017 at 11:19 AM, Constantin Petra <
> > constantin.petra@gmail.com> wrote:
> > 
> > > Hi,
> > >
> > > Sure, I have added the archive containing the image files and jailhouse
> > > build here (the archive contains the /tftpboot folder directly)
> > > https://drive.google.com/file/d/0B2bhbcx8eg-caTBNdnZ4cWhJcWc/view?usp=
> > > sharing
> > >
> > > I use the following sequence to start qemu / kernel / jailhouse, provided
> > > the /tftpboot folder has the structure in the previously archive and, of
> > > course, there is tftp access to the host)
> > > petalinux-boot --qemu --uboot --qemu-args "-redir tcp:10022:10.0.2.15:22"
> > >
> > > In QEMU:
> > > setenv bootargs 'console=ttyPS0,115200'; tftpboot 0x10000000  image.ub;
> > > bootm
> > >
> > > tftp -g 10.0.2.2 jailhouse.tar.gz -r jailhouse.tar.gz
> > >
> > > tar zvxf jailhouse.tar.gz
> > >
> > > mv tftpboot/jailhouse jailhouse
> > >
> > > mkdir -p  /lib/firmware
> > >
> > > cp ./jailhouse/lib/firmware/jailhouse.bin /lib/firmware
> > >
> > > insmod ./jailhouse/lib/modules/4.11.0-rc4/extra/driver/jailhouse.ko
> > >
> > > sleep 2
> > >
> > > jailhouse/usr/local/sbin/jailhouse enable /home/root/jailhouse/configs/
> > > zynqmp-zcu102.cell
> > >
> > >
> > > Thank you,
> > >
> > > Constantin
> > >
> > >
> > > On Apr 19, 2017 23:30, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> > > wrote:
> > >
> > >> On Wed, Apr 19, 2017 at 11:02:21AM +0200, Jan Kiszka wrote:
> > >> > On 2017-04-19 10:45, Peter Maydell wrote:
> > >> > > On 19 April 2017 at 05:37, Jan Kiszka <jan.kiszka@web.de> wrote:
> > >> > >> On 2017-04-19 05:48, Constantin Petra wrote:
> > >> > >>> So from some reason, under QEMU something is not in place, but what
> > >> can
> > >> > >>> that be? It would be convenient from our perspective, if it would
> > >> work...
> > >> > >>
> > >> > >> I fully agree, and I'm waiting for official EL2 support in QEMU in
> > >> order
> > >> > >> to introduce a virtual target for ARM[64], just like we have on x86
> > >> already.
> > >> > >
> > >> > > This has been in upstream QEMU for a little while now,
> > >> > > and will be in the upcoming 2.9 release. (Applies only for
> > >> > > AArch64 hosts using GICv3, needs some board support changes
> > >> > > which have currently only been done for 'virt'.)
> > >> >
> > >> > Ah, v3 - oversaw this "minor" detail. Too bad that there is still no
> > >> > GICv3 silicon in our hands that we could test against (do you know some
> > >> > recommendable board?). I'm pretty sure Jailhouse's GICv3 support is
> > >> > broken by now (due to lacking tests), plus it is not yet enabled for our
> > >> > ARM64 port. But I'm a bit reluctant to enable this only over QEMU...
> > >>
> > >> Hi,
> > >>
> > >> Xilinx QEMU has support for the virtualization extensions in the GICv2 but
> > >> we're seeing issues with running hypervisors in multi-core setups.
> > >> It seems like guest migration between cores is causing trouble but we
> > >> haven't pinpointed the exact cause.
> > >>
> > >> I'd be interested in debugging the problem seen with Jailhouse.
> > >> Can the images and instructions on howto run be shared with me?
> > >>
> > >> Thanks,
> > >> Edgar
> > >>
> > >
