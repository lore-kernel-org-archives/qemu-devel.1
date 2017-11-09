Received: from eggs.gnu.org ([2001:4830:134:3::10]:45538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCdCS-0001Zl-3d
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 22:08:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCdCR-0004zd-3I
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 22:08:16 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1510181732.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <63b860be-0bbd-78b7-d722-81d1c94da5f4@amsat.org>
Date: Thu, 9 Nov 2017 00:08:06 -0300
MIME-Version: 1.0
In-Reply-To: <cover.1510181732.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 00/45] Remove some of the fprintf(stderr, "*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, armbru@redhat.com, QEMU Trivial <qemu-trivial@nongnu.org>

Hi Alistair,

On 11/08/2017 07:56 PM, Alistair Francis wrote:
> Continue on improving QEMUs logging/error messages by removing more
> fprintf()'s.
> 
> Unfortunatley my Coccinelle skills aren't that great so it's all done in
> some nasty regex and a little bit of manual work.
> 
> V4:
>  - Reorder patch 3 (the audio func patch)
>  - Add all tags
>  - Small fixes
> V3:
>  - Rebase
>  - All sorts of style fixes
>  - Remove "qemu: " prefixes from print messages
> V2:
>  - Fix build issues
>  - Drop block patches
>  - Split the hw patches into subdirectories
>  - Remove AUDIO_FUNC macro as well
>  - Add some __FUNCTION__ rename fixes in a seperate patch
>  - Create a qemu_log() conversion patch for target/
> 
> Alistair Francis (45):
>   audio: Replace AUDIO_FUNC with __func__
>   Replace all occurances of __FUNCTION__ with __func__
>   Fixes after renaming __FUNCTION__ to __func__
>   tests: Replace fprintf(stderr, "*\n" with error_report()
>   hw/arm: Replace fprintf(stderr, "*\n" with error_report()
>   hw/block: Replace fprintf(stderr, "*\n" with error_report()
>   hw/bt: Replace fprintf(stderr, "*\n" with error_report()
>   hw/char: Replace fprintf(stderr, "*\n" with error_report()
>   hw/core: Replace fprintf(stderr, "*\n" with error_report()
>   hw/cris: Replace fprintf(stderr, "*\n" with error_report()
>   hw/display: Replace fprintf(stderr, "*\n" with error_report()
>   hw/dma: Replace fprintf(stderr, "*\n" with error_report()
>   hw/gpio: Replace fprintf(stderr, "*\n" with error_report()
>   hw/i2c: Replace fprintf(stderr, "*\n" with error_report()
>   hw/i386: Replace fprintf(stderr, "*\n" with error_report()
>   hw/ide: Replace fprintf(stderr, "*\n" with error_report()
>   hw/input: Replace fprintf(stderr, "*\n" with error_report()
>   hw/intc: Replace fprintf(stderr, "*\n" with error_report()
>   hw/ipmi: Replace fprintf(stderr, "*\n" with error_report()
>   hw/isa: Replace fprintf(stderr, "*\n" with error_report()
>   hw/lm32: Replace fprintf(stderr, "*\n" with error_report()
>   hw/microblaze: Replace fprintf(stderr, "*\n" with error_report()
>   hw/mips: Replace fprintf(stderr, "*\n" with error_report()
>   hw/misc: Replace fprintf(stderr, "*\n" with error_report()
>   hw/moxie: Replace fprintf(stderr, "*\n" with error_report()
>   hw/net: Replace fprintf(stderr, "*\n" with error_report()
>   hw/nios2: Replace fprintf(stderr, "*\n" with error_report()
>   hw/nvram: Replace fprintf(stderr, "*\n" with error_report()
>   hw/openrisc: Replace fprintf(stderr, "*\n" with error_report()
>   hw/pci*: Replace fprintf(stderr, "*\n" with error_report()
>   hw/ppc: Replace fprintf(stderr, "*\n" with error_report()
>   hw/s390x: Replace fprintf(stderr, "*\n" with error_report()
>   hw/scsi: Replace fprintf(stderr, "*\n" with error_report()
>   hw/sd: Replace fprintf(stderr, "*\n" with error_report()
>   hw/sh4: Replace fprintf(stderr, "*\n" with error_report()
>   hw/sparc*: Replace fprintf(stderr, "*\n" with error_report()
>   hw/ssi: Replace fprintf(stderr, "*\n" with error_report()
>   hw/timer: Replace fprintf(stderr, "*\n" with error_report()
>   hw/usb: Replace fprintf(stderr, "*\n" with error_report()
>   hw/watchdog: Replace fprintf(stderr, "*\n" with error_report()
>   hw/xen*: Replace fprintf(stderr, "*\n" with error_report()
>   util: Replace fprintf(stderr, "*\n" with error_report()
>   ui: Replace fprintf(stderr, "*\n" with error_report()
>   tcg: Replace fprintf(stderr, "*\n" with error_report()
>   target: Use qemu_log() instead of fprintf(stderr, ...)

You should split this series :)
- all the reviewed patches Cc'ing qemu-trivial@,
- respin the rest, it will be much less scary.

Regards,

Phil.
