Received: from eggs.gnu.org ([2001:4830:134:3::10]:51788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cVwPb-0007Id-UB
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 03:25:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cVwPY-0001a2-PM
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 03:25:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cVwPY-0001Zr-JQ
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 03:25:04 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1485206573-32452-1-git-send-email-atar4qemu@gmail.com>
Date: Tue, 24 Jan 2017 09:25:01 +0100
In-Reply-To: <1485206573-32452-1-git-send-email-atar4qemu@gmail.com> (Artyom
	Tarasenko's message of "Mon, 23 Jan 2017 22:22:53 +0100")
Message-ID: <87k29kx3tu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] niagara: check if a serial port is
 available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk

Your series lacks threading: the patches don't carry In-Reply-To and
References headers.  The easiest way to fix that is sending them with
git-send-email --thread.  You should be able to omit --thread; it's the
default unless configured otherwise.

Artyom Tarasenko <atar4qemu@gmail.com> writes:

> Reported-by:Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
> ---
>  hw/sparc64/niagara.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
> index e945b5a..a14724f 100644
> --- a/hw/sparc64/niagara.c
> +++ b/hw/sparc64/niagara.c
> @@ -154,9 +154,10 @@ static void niagara_init(MachineState *machine)
>              exit(1);
>          }
>      }
> -    serial_mm_init(sysmem, NIAGARA_UART_BASE, 0, NULL, 115200,
> -                   serial_hds[0], DEVICE_BIG_ENDIAN);
> -
> +    if (serial_hds[0]) {
> +        serial_mm_init(sysmem, NIAGARA_UART_BASE, 0, NULL, 115200,
> +                       serial_hds[0], DEVICE_BIG_ENDIAN);
> +    }
>      empty_slot_init(NIAGARA_IOBBASE, NIAGARA_IOBSIZE);
>      sun4v_rtc_init(NIAGARA_RTC_BASE);
>  }

Reviewed-by: Markus Armbruster <armbru@redhat.com>
