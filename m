Received: from eggs.gnu.org ([2001:4830:134:3::10]:32825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fJb9T-0002io-BD
	for qemu-devel@nongnu.org; Fri, 18 May 2018 04:54:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fJb9O-0005My-Fv
	for qemu-devel@nongnu.org; Fri, 18 May 2018 04:54:15 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1fJb9O-0005Mj-9z
	for qemu-devel@nongnu.org; Fri, 18 May 2018 04:54:10 -0400
Received: by mail-wm0-f67.google.com with SMTP id a137-v6so2614925wme.1
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 01:54:09 -0700 (PDT)
References: <4521b265-855f-7f06-ffff-3fa394380922@xenosoft.de>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <b3243bab-58b6-0b43-67b5-94a2f90d9199@tuxfamily.org>
Date: Fri, 18 May 2018 10:54:06 +0200
MIME-Version: 1.0
In-Reply-To: <4521b265-855f-7f06-ffff-3fa394380922@xenosoft.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PPC64] P5020DS: Booting from img possible
 (-drive)?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Zigotzky <chzigotzky@xenosoft.de>, "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>

On 18.05.2018 08:01, Christian Zigotzky wrote:
> |Hello,
> 
> I was able to boot a Linux kernel (uImage) with an initrd in a virtual
> P5020DS PPC64 machine with an e5500 core (QEMU 2.12.0) with the
> following command.
> 
> qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048 -initrd
> /home/christian/Downloads/slitaz25.gz -nographic -kernel
> /home/christian/Downloads/vmlinux-4.17-rc5-AmigaOne_X1000_X5000/X5000/uImage-4.17
> -net nic,vlan=0,model=e1000 -net user,vlan=0 -machine
> dt_compatible=fsl,,P5020DS -append "root=/dev/ramdisk"
> 
> It also works with the machine 'MPC8544DS':
> 
> qemu-system-ppc64 -M mpc8544ds -cpu e5500 -m 2048 -initrd
> /home/christian/Downloads/slitaz25.gz -nographic -kernel
> /home/christian/Downloads/vmlinux-4.17-rc5-AmigaOne_X1000_X5000/X5000/uImage-4.17
> -net nic,vlan=0,model=e1000 -net user,vlan=0 -machine
> dt_compatible=fsl,,P5020DS -append "root=/dev/ramdisk"

These two machines ppce500 and mpc8544ds are "embedded" PowerPC machines...

> I tried to boot ubuntu MATE 16.04 LTS PowerPC from an img with the
> option '-drive' but without any success. Is it possible to boot from a
> hard disk img with a virtual P5020DS PPC64 machine? Can I use a virtual
> graphics card with this machine?

... but according to http://cdimage.ubuntu.com/releases/16.04/release/
Ubuntu 16.04 is for Apple and IBM machines only, so I don't think that
you'll be able to run this on an embedded PPC machine?

 Thomas
