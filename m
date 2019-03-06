Received: from eggs.gnu.org ([209.51.188.92]:50864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1h1QC7-00059Y-PU
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 01:38:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1h1QC1-0003qw-Vh
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 01:38:22 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42039)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1h1QBy-0003qP-10
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 01:38:14 -0500
Received: by mail-oi1-x244.google.com with SMTP id s16so8954974oih.9
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 22:38:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20190305162829.20079-1-philmd@redhat.com>
References: <20190305162829.20079-1-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 6 Mar 2019 07:38:12 +0100
Message-ID: <CAL1e-=gTsjAt1O63xuDwm7NfV6nKt3gMHk46Yjfg_PKp0a1m+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/5] mips_malta: Clean up definition of
 flash memory size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

On Tuesday, March 5, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =
wrote:

> Hi Markus,
>
> this is a rework of your 'mips_malta: Clean up definition of flash memory
> size somewhat' patch:
> https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg07177.html
>
> Regards,
>
> Phil.


Philippe,

Could you summarize end-user-visible changes resulting from this series?

Aleksandar


> Based-on: <20190226193408.23862-9-armbru@redhat.com>
>
> Markus Armbruster (1):
>   mips_malta: Clean up definition of flash memory size somewhat
>
> Philippe Mathieu-Daud=C3=A9 (4):
>   hw/mips/malta: Fix the DEBUG_BOARD_INIT code
>   hw/mips/malta: Remove fl_sectors variable (used one single time)
>   hw/mips/malta: Restrict 'bios_size' variable scope
>   hw/mips/malta: Only accept 'monitor' pflash of 4MiB
>
>  hw/mips/mips_malta.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
>
> --
> 2.20.1
>
>
>
