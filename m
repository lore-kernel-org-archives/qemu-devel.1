Received: from eggs.gnu.org ([2001:4830:134:3::10]:40040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnRhQ-0006VF-RA
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnRhL-0003Gi-Sm
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:48:08 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35891)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnRhL-0003GV-NJ
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:48:03 -0400
Received: by mail-qk0-x241.google.com with SMTP id l65so15103qkc.3
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 08:48:03 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170831122925.GJ17315@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <12741481-4c23-5a17-3784-ffce326dabc8@amsat.org>
Date: Thu, 31 Aug 2017 12:47:59 -0300
MIME-Version: 1.0
In-Reply-To: <20170831122925.GJ17315@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] RFC: changing ROM bundling in tar dists for
 releases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

On 08/31/2017 09:29 AM, Daniel P. Berrange wrote:
[...]> There are the following options I see
> 
>    1. Keep existing dist, and add a new minimal one
> 
>         qemu-X.Y.Z.tar.bz2 - qemu source + bundled ROMS + libs
>         qemu-minimal-X.Y.Z.tar.bz2 - qemu source only
> 
>       Least impact for current non-distro users, distros just switch.
> 
>    2. Change existing dist, and add a new one with everything
> 
>         qemu-X.Y.Z.tar.bz2 - qemu source only
>         qemu-full-X.Y.Z.tar.bz2 - qemu source + bundled ROMS + libs
> 
>       Non-distro users need to download a different dist from what they
>       have known previously, but otherwise unchanged build process.
> 
>    3. Change existing dist, and add a new one with bundled bits
> 
>         qemu-X.Y.Z.tar.bz2 - qemu source only
>         qemu-addons-X.Y.Z.tar.bz2 - bundled ROMS + libs
> 
>       Non-distro users need to manually download & install an
>       extra piece compared to now.

Debian style:

linux-kbuild-4.9 - Kbuild infrastructure for Linux 4.9
linux-kbuild-4.12 - Kbuild infrastructure for Linux 4.12
linux-source - Linux kernel source (meta-package)
linux-source-4.12 - Linux kernel source for version 4.12 with Debian patches
firmware-linux - Binary firmware for various drivers in the Linux kernel 
(meta-package)
firmware-linux-nonfree - Binary firmware for various drivers in the 
Linux kernel (meta-package)
firmware-misc-nonfree - Binary firmware for various drivers in the Linux 
kernel
firmware-zd1211 - binary firmware for the zd1211rw wireless driver
firmware-bnx2 - Binary firmware for Broadcom NetXtremeII
...
qemu-efi - UEFI firmware for 64-bit ARM virtual machines
grub-firmware-qemu - GRUB firmware image for QEMU
ipxe-qemu - PXE boot firmware - ROM images for qemu
ovmf - UEFI firmware for 64-bit x86 virtual machines
vgabios - VGA BIOS software for the Bochs and Qemu emulated VGA card
seabios - Legacy BIOS implementation
sgabios - bios option rom to provide legacy serial console for x86

$ apt-cache show qemu-system-x86
Package: qemu-system-x86
Provides: qemu-system-i386, qemu-system-x86-64
Suggests: samba, vde2, qemu-block-extra, kmod, sgabios, ovmf

$ apt-cache show qemu-system-arm
Recommends: qemu-utils, ipxe-qemu, qemu-efi

This seems to me the cleaner one, the distrib choose to provide 
dependencies in the package description, a package to build, and keep 
exclusive licenses in different packages.

> 
>    4. Change existing dist, never distribute bundled ROMs + libs at all
> 
>         qemu-X.Y.Z.tar.bz2 - qemu source only
> 
>       Only here for completeness, not a serious suggestion

Linux style :)

> 
>    5. Change nothing
> 
>       Continue ignoring the problem I aim to solve.
> 
> 
> My patch did option 2, but I really open to any of 1/2/3 without a
> strong preference, as long as we can get some agreement on one. I
> guess option 1 might be easiest to get agreement on given its minimal
> impact.

It would be easier to have people building from sources to answer but 
they usually don't read this list, you might want to ask on qemu-stable.

Regards,

Phil.
