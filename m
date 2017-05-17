Received: from eggs.gnu.org ([2001:4830:134:3::10]:50812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dAu2r-0000U5-N0
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:10:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dAu2m-0002fW-GY
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:10:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dAu2m-0002fI-2E
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:10:52 -0400
References: <149500755798.25192.15465936284699398425.malonedeb@gac.canonical.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f3f455ae-756d-ae8a-c551-09fb6c095116@redhat.com>
Date: Wed, 17 May 2017 10:10:48 +0200
MIME-Version: 1.0
In-Reply-To: <149500755798.25192.15465936284699398425.malonedeb@gac.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1691379] [NEW] NetBSD evbmips64el port
 installation doesn't work with qemu-system-mips64el.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1691379 <1691379@bugs.launchpad.net>, qemu-devel@nongnu.org
Cc: Kamil Rytarowski <kamil@netbsd.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>

On 17.05.2017 09:52, Utkarsh Anand wrote:
> Public bug reported:
> 
> I successfully installed the NetBSD evbmips64el port on gxemul but was
> unable to install it on qemu. Trying to boot it on qemu takes me to the
> 'db>' prompt. Here's the output and backtrace:
> 
> panic: pcib_isa_intr_string: bogus isa irq 0x0
> kernel: breakpoint trap
> Stopped in pid 0.1 (system) at  netbsd:cpu_Debugger+0x4:        jr      ra
>                 bdslot: nop
> db> bt
> 0xffffffff805977f0: cpu_Debugger+4 (63061,90000000180003f8,6,ffffffff804c2290) ra ffffffff8030acd0 sz 0
> 0xffffffff805977f0: vpanic+158 (63061,90000000180003f8,6,ffffffff804c2290) ra ffffffff8030ad7c sz 64
> 0xffffffff80597830: panic+34 (63061,ffffffff803d65b0,0,40) ra ffffffff80109784 sz 96
> 0xffffffff80597890: pcib_isa_intr_string+6c (63061,ffffffff803d65b0,0,40) ra ffffffff80149bfc sz 16
> 0xffffffff805978a0: uhci_pci_attach+16c (63061,ffffffff803d65b0,0,40) ra ffffffff802f0400 sz 176
> 0xffffffff80597950: config_attach_loc+1c8 (63061,ffffffff803d65b0,0,40) ra ffffffff802f053c sz 64
> 0xffffffff80597990: config_found_sm_loc+5c (63061,ffffffff803d65b0,0,40) ra ffffffff80121354 sz 64
> 0xffffffff805979d0: pci_probe_device+524 (63061,ffffffff803d65b0,0,0) ra ffffffff80121548 sz 288
> 0xffffffff80597af0: pci_enumerate_bus+1d0 (63061,ffffffff803d65b0,0,0) ra ffffffff8012167c sz 160
> 0xffffffff80597b90: pcirescan+5c (63061,ffffffff803d65b0,0,0) ra ffffffff801218c4 sz 32
> 0xffffffff80597bb0: pciattach+19c (63061,ffffffff803d65b0,0,0) ra ffffffff802f0400 sz 80
> 0xffffffff80597c00: config_attach_loc+1c8 (63061,ffffffff803d65b0,0,0) ra ffffffff802f053c sz 64
> 0xffffffff80597c40: config_found_sm_loc+5c (63061,ffffffff803d65b0,0,0) ra ffffffff80108934 sz 64
> 0xffffffff80597c80: gt_attach+7c (63061,ffffffff803d65b0,0,0) ra ffffffff802f0400 sz 112   
> 0xffffffff80597cf0: config_attach_loc+1c8 (63061,ffffffff803d65b0,0,0) ra ffffffff802f053c sz 64
> 0xffffffff80597d30: config_found_sm_loc+5c (63061,ffffffff803d65b0,0,0) ra ffffffff801086ac sz 64
> 0xffffffff80597d70: mainbus_attach+dc (63061,ffffffff803d65b0,0,0) ra ffffffff802f0400 sz 96
> 0xffffffff80597dd0: config_attach_loc+1c8 (63061,ffffffff803d65b0,0,0) ra ffffffff80104bf8 sz 64
> 0xffffffff80597e10: cpu_configure+28 (63061,ffffffff803d65b0,0,0) ra ffffffff803d5f30 sz 16
> 0xffffffff80597e20: main+3a0 (63061,ffffffff803d65b0,0,0) ra ffffffff801000dc sz 128       
> 0xffffffff80597ea0: kernel_text+dc (63061,ffffffff803d65b0,0,0) ra 0 sz 0
> User-level: pid 0.1
> 
> Here's the command that I used:
> 
> Build evbmips64el from source and then launch it from qemu (replace the
> paths relative to your system):
> 
> qemu-system-mips64el -cdrom
> /extra/evbmips64/distrib/evbmips/cdroms/installcd/NetBSD-7.99.71
> -evbmips-mips64el.iso -hda /extra/evbmips64.img -kernel
> /extra/evbmips64/releasedir/evbmips/installation/netbsd-INSTALL_MALTA64
> -nographic -M malta
> 
> (I've decompressed the kernel)
> 
> Here's the output for qemu-system-mips64el --version :
> 
> QEMU emulator version 2.7.1(qemu-2.7.1-6.fc25), Copyright (c) 2003-2016
> Fabrice Bellard and the QEMU Project developers
> 
> This doesn't look like a NetBSD bug. I've attached a screenshot of the
> working installation using gxemul in the attachments.

When reporting such issues, please always use the latest release of QEMU
first, so could you please try again with the latest upstream release of
QEMU (currently v2.9.0)? Thanks!

 Thomas
