Received: from eggs.gnu.org ([2001:4830:134:3::10]:56190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1f86dj-0000OS-RR
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:06:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1f86df-0002Zf-53
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:05:59 -0400
References: <20180415203106.24333-1-f4bug@amsat.org>
From: "mar.krzeminski" <mar.krzeminski@gmail.com>
Message-ID: <5b3b6d5a-865c-0d41-368b-33fc7ec35baf@gmail.com>
Date: Mon, 16 Apr 2018 18:05:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180415203106.24333-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: pl
Subject: Re: [Qemu-devel] [PATCH for-2.12?] m25p80: Correct the
 at25128a/at25256a eeproms size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

W dniu 15.04.2018 o 22:31, Philippe Mathieu-Daudé pisze:
> >From the datasheet (3368J–SEEPR) description:
>      The AT25128A/256A provides 131,072/262,144 bits of serial
>      electrically-erasable programmable read only memory (EEPROM)
>      organized as 16,384/32,768 words of 8 bits each.
>
> However QEMU models the flash size in bytes.
> Correct the at25128a/at25256a entries to reflect the datasheet size.
>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Marcin Krzeminski <mar.krzeminski@gmail.com>
> ---
> This is not a regression, so can now wait for 2.13.
>
>   hw/block/m25p80.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index b49c8e9caa..d0b9fbfc50 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -196,8 +196,8 @@ static const FlashPartInfo known_devices[] = {
>       /* Atmel EEPROMS - it is assumed, that don't care bit in command
>        * is set to 0. Block protection is not supported.
>        */
> -    { INFO("at25128a-nonjedec", 0x0,     0,         1, 131072, EEPROM) },
> -    { INFO("at25256a-nonjedec", 0x0,     0,         1, 262144, EEPROM) },
> +    { INFO("at25128a-nonjedec", 0x0,     0,         1, 16384, EEPROM) },
> +    { INFO("at25256a-nonjedec", 0x0,     0,         1, 32768, EEPROM) },
Thanks!
Marcin
>   
>       /* EON -- en25xxx */
>       { INFO("en25f32",     0x1c3116,      0,  64 << 10,  64, ER_4K) },
