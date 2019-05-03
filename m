Received: from eggs.gnu.org ([209.51.188.92]:53426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hMTPV-0004kS-6A
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:19:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hMTPT-0003Do-VD
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:19:12 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:34602
	helo=mail.default.ilande.uk0.bigv.io)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hMTPT-0003C3-P3
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:19:11 -0400
References: <1556194715-24427-1-git-send-email-frederic.konrad@adacore.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <5eb69d4e-1d3c-805f-fc79-fce42febf959@ilande.co.uk>
Date: Fri, 3 May 2019 09:19:07 +0100
MIME-Version: 1.0
In-Reply-To: <1556194715-24427-1-git-send-email-frederic.konrad@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Leon3 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, chouteau@adacore.com, philmd@redhat.com, atar4qemu@gmail.com

On 25/04/2019 13:18, KONRAD Frederic wrote:

> Hi all,
> 
> Those are some little fixes for the leon3 machine:
>   * The first part initializes the uart and the timer when no bios are
>     provided.
>   * The second part adds AHB and APB plug and play devices to allow to boot
>     linux.
>   * The third part adds myself to the MAINTAINERS for this board.
> 
> The test images are available here: https://www.gaisler.com/anonftp/linux/lin
> ux-2.6/images/leon-linux-4.9/leon-linux-4.9-1.0/up/
> 
> Tested with:
>   qemu-system-sparc -M leon3_generic --nographic --kernel image.ram
> 
> V1 -> V2:
>   * minor fixes in the first patch suggested by Philippe.
> 
> Regards,
> Fred
> 
> KONRAD Frederic (3):
>   leon3: add a little bootloader
>   leon3: introduce the plug and play mecanism
>   MAINTAINERS: add myself for leon3
> 
>  MAINTAINERS                         |   1 +
>  hw/misc/Makefile.objs               |   2 +
>  hw/misc/grlib_ahb_apb_pnp.c         | 269 ++++++++++++++++++++++++++++++++++++
>  hw/sparc/leon3.c                    | 114 +++++++++++++--
>  include/hw/misc/grlib_ahb_apb_pnp.h |  60 ++++++++
>  include/hw/sparc/grlib.h            |  35 +++--
>  6 files changed, 455 insertions(+), 26 deletions(-)
>  create mode 100644 hw/misc/grlib_ahb_apb_pnp.c
>  create mode 100644 include/hw/misc/grlib_ahb_apb_pnp.h

Hi Frederic,

I've now had a chance to review this - I think it basically looks good, it just needs
a few minor tweaks. I can also confirm that using the test images at the URL above, I
can boot to a userspace shell.

I'm happy to take this through my qemu-sparc branch once everything is ready to go.


ATB,

Mark.
