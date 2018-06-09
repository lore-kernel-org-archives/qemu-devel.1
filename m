Received: from eggs.gnu.org ([2001:4830:134:3::10]:39264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRUWh-0005y7-SO
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 23:26:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRUWg-000687-To
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 23:26:51 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180608200558.386-1-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c7bcc8cd-458f-6501-df30-a9ea0a0299bb@amsat.org>
Date: Sat, 9 Jun 2018 00:26:39 -0300
MIME-Version: 1.0
In-Reply-To: <20180608200558.386-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 00/13] hw/m68k: add Apple Machintosh Quadra
 800 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, "open list:Block layer core" <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

On 06/08/2018 05:05 PM, Laurent Vivier wrote:
> I'm rebasing some of these patches for seven years now,
> too many years...
> 
> It's an RFC because things have changed in QEMU in seven years,
> for instance the VIA has a new implementation (mos6522) introduced
> by Mark Cave-Ayland and I didn't rework my implementation to
> fit into this new one (any volunteers?), display has some glitches,
> ADB devices are not identified correctly.
> 
> if you want to test the machine, I'm sorry, it doesn't boot
> a MacROM, but you can boot a linux kernel from the command line.
> 
> You can install your own disk using debian-installer, with:
> 
>     ...
>     -M q800 \
>     -serial none -serial mon:stdio \
>     -m 1000M -drive file=m68k.qcow2,format=qcow2 \
>     -net nic,model=dp83932,addr=09:00:07:12:34:57 \
>     -append "console=ttyS0 vga=off" \
>     -kernel vmlinux-4.15.0-2-m68k \
>     -initrd initrd.gz \
>     -drive file=debian-9.0-m68k-NETINST-1.iso \
>     -drive file=m68k.qcow2,format=qcow2 \
>     -nographic

qemu-system-m68k: -drive file=m68k.qcow2,format=qcow2: Failed to get
"write" lock
Is another process using the image?

(two times same file provided in cmdline arguments)

@block-team I found it funny because this is the very same process which
already locked. The error message is enough as it imo.
