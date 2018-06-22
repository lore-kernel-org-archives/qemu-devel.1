Received: from eggs.gnu.org ([2001:4830:134:3::10]:42142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWAvt-00029a-UA
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 21:32:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWAvq-000684-Qd
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 21:32:13 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:32791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWAvq-00067T-MN
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 21:32:10 -0400
Received: by mail-qt0-x244.google.com with SMTP id l10-v6so4707938qtj.0
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 18:32:10 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1529568501.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3cbe516a-9c99-273a-49aa-2961a315aff8@amsat.org>
Date: Thu, 21 Jun 2018 22:32:05 -0300
MIME-Version: 1.0
In-Reply-To: <cover.1529568501.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/5] Misc sm501 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Sebastian Bauer <mail@sebastianbauer.info>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, David Gibson <david@gibson.dropbear.id.au>

Hi Zoltan,

On 06/21/2018 05:08 AM, BALATON Zoltan wrote:
> These are fixes to sm501 emulation that were found while testing with
> AmigaOS 4.1FE (AmigaOS 4 is known to work on real hardware but we have
> no way to verify it against hardware). While this is mainly to improve

Is it possible to fetch/use this image? (and add integration tests)

> sam460ex emulation this is now a separate series with the sm501
> specific patches because that's also used on SH emulation. I hope
> someone can review and merge this.
> 
> BALATON Zoltan (3):
>   sm501: Implement i2c part for reading monitor EDID
>   sm501: Set updated region dirty after 2D operation
>   sm501: Fix support for non-zero frame buffer start address
> 
> Sebastian Bauer (2):
>   sm501: Perform a full update after palette change
>   sm501: Use values from the pitch register for 2d operations.
> 
>  default-configs/ppc-softmmu.mak    |   1 +
>  default-configs/ppcemb-softmmu.mak |   1 +
>  default-configs/sh4-softmmu.mak    |   2 +
>  default-configs/sh4eb-softmmu.mak  |   2 +
>  hw/display/sm501.c                 | 166 +++++++++++++++++++++++++++++++++++--
>  5 files changed, 163 insertions(+), 9 deletions(-)
> 
