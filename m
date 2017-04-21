Received: from eggs.gnu.org ([2001:4830:134:3::10]:44799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d1a95-0001sb-11
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 11:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d1a91-00018Y-RY
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 11:06:51 -0400
Received: from chuckie.co.uk ([82.165.15.123]:51790
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1d1a91-00018T-KQ
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 11:06:47 -0400
References: <AA896828-A1B7-4060-9537-F738C1E2012C@gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <e538350e-e710-ea4d-ba69-8bc54c5af6a2@ilande.co.uk>
Date: Fri, 21 Apr 2017 16:06:16 +0100
MIME-Version: 1.0
In-Reply-To: <AA896828-A1B7-4060-9537-F738C1E2012C@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Help needed: Sparc 64, kernel panic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Siavash Katebzadeh <mr.katebzadeh@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 21/04/17 15:56, Siavash Katebzadeh wrote:

> My command line is:
> 
> ./qemu-system-sparc64 \
> -L pc-bios -m 720 \
> -kernel ${KERNEL_PATH}/${KERNEL} \
> -initrd ${KERNEL_PATH}/${INITRD} \
> -drive file=${QCOW2_PATH}/${QCOW2},if=virtio,index=0 \
> -rtc base='2006-06-17T16:01:21',clock=vm \
> -net none -append 'modprobe.blacklist=pata_cmd64x root=/dev/vda1' \
> -d in_asm -D ./out_file_timing \
> -nographic
> 
> And here is my environment:
> 
> Guest OS: Debian-7.8.0
> Guest Kernel: 3.2.0-4-sparc64 (Virtio modules are added manually)
> Host OS: Ubuntu 14.04
> CPU: Intel(R) Xeon(R) CPU E5-2650 0 @ 2.00GHz
> 
> This error happens when I’m using qemu-2.8.0-rc0 or later.

Please make sure that you CC the qemu-devel list, particularly as I
won't be around for several days. There have been several fixes in 2.9
that could be related to this - do you still see the same issue with the
latest 2.9 release?


ATB,

Mark.
