Received: from eggs.gnu.org ([2001:4830:134:3::10]:52066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eorug-0003NJ-L6
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:31:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eorua-0007V1-Jj
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:31:58 -0500
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:41389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eorua-0007Uc-CT
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:31:52 -0500
Received: by mail-oi0-x236.google.com with SMTP id e10so3815592oiy.8
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 06:31:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180215221325.7611-1-f4bug@amsat.org>
References: <20180215221325.7611-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 14:31:31 +0000
Message-ID: <CAFEAcA_3z8nxiD4xQnFcn3=bUMjLpQUoH8jZQmQkkycC2vWq1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 00/20] SDCard: bugfixes,
 support UHS-I (part 5)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Andrzej Zaborowski <balrogg@gmail.com>

On 15 February 2018 at 22:13, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> Some refactors, few bugfixes, better SD/SPI support.
>
> With this series apply, machines can use SD cards in UHS-I mode.
> (mostly imported from Alistair Francis work)
>
> MMC mode split out for another series,
> so UHS enabled MMC cards are still not usable:
>
>   kernel: mmc0: SDHCI controller on PCI [0000:00:05.0] using ADMA
>   kernel: sd 0:0:0:0: Attached scsi generic sg0 type 0
>   kernel: mmc0: Skipping voltage switch
>   [mmc kthread looping]
>
> Since v3:
> - simpler SPI handling, improved descriptions (Alistair review)
> - inverted patches 16/17 order
>
> Since v2:
> - split again in 2... other part is cleanup/tracing
>
> Since v1:
> - rewrote mostly all patches to keep it simpler.
>
> $ git backport-diff
> 001/20:[----] [-C] 'sdcard: Don't always set the high capacity bit'
> 002/20:[----] [-C] 'sdcard: update the CSD CRC register regardless the CS=
D structure version'
> 003/20:[----] [-C] 'sdcard: fix the 'maximum data transfer rate' to 25MHz=
'
> 004/20:[----] [-C] 'sdcard: clean the SCR register and add few comments'
> 005/20:[----] [--] 'sdcard: remove commands from unsupported old MMC spec=
ification'
> 006/20:[----] [--] 'sdcard: simplify using the ldst API'
> 007/20:[0008] [FC] 'sdcard: use the correct masked OCR in the R3 reply'
> 008/20:[----] [-C] 'sdcard: use the registerfields API for the CARD_STATU=
S register masks'
> 009/20:[----] [--] 'sdcard: handle CMD54 (SDIO)'
> 010/20:[down] 'sdcard: handle the Security Specification commands'
> 011/20:[down] 'sdcard: use a more descriptive label 'unimplemented_spi_cm=
d''
> 012/20:[0034] [FC] 'sdcard: handles more commands in SPI mode'
> 013/20:[----] [--] 'sdcard: check the card is in correct state for APP CM=
D (CMD55)'
> 014/20:[----] [--] 'sdcard: warn if host uses an incorrect address for AP=
P CMD (CMD55)'
> 015/20:[----] [--] 'sdcard: simplify SEND_IF_COND (CMD8)'
> 016/20:[----] [--] 'sdcard: simplify SD_SEND_OP_COND (ACMD41)'
> 017/20:[----] [--] 'sdcard: add SD SEND_TUNING_BLOCK (CMD19)'
> 018/20:[----] [--] 'sdcard: implement the UHS-I SWITCH_FUNCTION entries (=
Spec v3)'
> 019/20:[----] [-C] 'sdcard: add a 'uhs' property, update the OCR register=
 ACCEPT_SWITCH_1V8 bit'
> 020/20:[----] [--] 'sdcard: add an enum for the SD PHY Spec version'

I've applied patches 1 to 16 to target-arm.next.

Removing the CMD11 support worries me a bit -- presumably it was put there
because some guest actually uses it -- but my test images seem to
still boot OK...

thanks
-- PMM
